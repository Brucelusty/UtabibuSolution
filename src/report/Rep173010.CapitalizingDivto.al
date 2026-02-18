report 173015 CapitalizingDiv
{
    ApplicationArea = All;
    Caption = 'Capitalize Dividends / Interest on Deposits';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";

            trigger OnPreDataItem()
            begin
                // ===== VALIDATIONS =====
                if PostingDate = 0D then
                    Error('Posting Date must be specified.');

                if RecoverDiv and RecoverFromIOD then
                    Error('Select either Recover Dividend OR Recover Interest on Deposits.');

                if (not RecoverDiv) and (not RecoverFromIOD) then
                    Error('Select either Recover Dividend OR Recover Interest on Deposits.');

                MinCapitalizeAmount := 100;

                // ===== CLEAR JOURNAL =====
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.FindFirst() then
                    GenJournalLine.DeleteAll();

                LineNo := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                // ================= INTEREST ON DEPOSITS =================
                if RecoverFromIOD then begin
                    CalcFields("Interest On Deposits");

                    RunBal := RoundDownAmount("Interest On Deposits");

                    if RunBal >= MinCapitalizeAmount then begin
                        RunBal :=
                            FnRecoverLoanArrears(
                                "No.",
                                RunBal,
                                GenJournalLine."Transaction Type"::"Interest on Deposits"
                            );

                        RunBal := RoundDownAmount(RunBal);

                        if RunBal >= MinCapitalizeAmount then
                            FnPostRemainingToDeposit(
                                "No.",
                                RunBal,
                                GenJournalLine."Transaction Type"::"Interest on Deposits"
                            );
                    end;
                end;

                // ================= DIVIDEND =================
                if RecoverDiv then begin
                    CalcFields("Dividend Amount");

                    RunBal := RoundDownAmount("Dividend Amount");

                    if RunBal >= MinCapitalizeAmount then begin
                        RunBal :=
                            FnRecoverLoanArrears(
                                "No.",
                                RunBal,
                                GenJournalLine."Transaction Type"::Dividend
                            );

                        RunBal := RoundDownAmount(RunBal);

                        if RunBal >= MinCapitalizeAmount then
                            FnPostRemainingToDeposit(
                                "No.",
                                RunBal,
                                GenJournalLine."Transaction Type"::Dividend
                            );
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = Basic;
                    }
                    field(RecoverFromIOD; RecoverFromIOD)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Recover From Interest On Deposits';
                    }
                    field(RecoverDiv; RecoverDiv)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Recover From Dividend';
                    }
                }
            }
        }
    }

    var
        RecoverDiv: Boolean;
        RecoverFromIOD: Boolean;
        PostingDate: Date;
        RunBal: Decimal;
        LineNo: Integer;
        MinCapitalizeAmount: Decimal;

        GenJournalLine: Record "Gen. Journal Line";
        SFactory: Codeunit "Au Factory";

        BATCH_TEMPLATE: Label 'GENERAL';
        BATCH_NAME: Label 'DIV';
        DOCUMENT_NO: Label 'CAPITALIZE';

        AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";

    // =========================================================
    // ROUND DOWN helper
    // =========================================================
    local procedure RoundDownAmount(Amount: Decimal): Decimal
    begin
        exit(Round(Amount, 1, '<'));
    end;

    // =========================================================
    // Recover loan arrears ONLY
    // =========================================================
    local procedure FnRecoverLoanArrears(
        MemberNo: Code[30];
        RunningBal: Decimal;
        SourceTransType: Option
    ): Decimal
    var
        Loans: Record "Loans Register";
        ArrearsAmt: Decimal;
        RecoverAmt: Decimal;
    begin
        if RunningBal <= 0 then
            exit(0);

        Loans.Reset();
        Loans.SetRange("Client Code", MemberNo);
        Loans.SetFilter("Outstanding Balance", '>%1', 0);

        if Loans.FindSet() then
            repeat
                Loans.CalcFields("Outstanding Balance");


                if ArrearsAmt <= 0 then
                    ArrearsAmt := Loans."Amount in Arrears";
                RecoverAmt := ArrearsAmt;
                if RecoverAmt > RunningBal then
                    RecoverAmt := RunningBal;

                // ===== DEBIT SOURCE =====
                LineNo += 10000;
                SFactory.FnCreateGnlJournalLine(
                    BATCH_TEMPLATE,
                    BATCH_NAME,
                    DOCUMENT_NO,
                    LineNo,
                    SourceTransType,
                    GenJournalLine."Account Type"::Customer,
                    MemberNo,
                    PostingDate,
                    RecoverAmt,
                    'BOSA',
                    Loans."Loan  No.",
                    '2024 Dividends transfer to deposits.Loan Arrears Recovery',
                    Loans."Loan  No.",
                    AppSource::" "
                );

                // ===== CREDIT LOAN REPAYMENT =====
                LineNo += 10000;
                SFactory.FnCreateGnlJournalLine(
                    BATCH_TEMPLATE,
                    BATCH_NAME,
                    DOCUMENT_NO,
                    LineNo,
                    GenJournalLine."Transaction Type"::Repayment,
                    GenJournalLine."Account Type"::Customer,
                    MemberNo,
                    PostingDate,
                    -RecoverAmt,
                    'BOSA',
                    Loans."Loan  No.",
                    '2024 Dividends transfer to deposits.Loan Arrears Cleared',
                    Loans."Loan  No.",
                    AppSource::" "
                );

                RunningBal -= RecoverAmt;
            until (Loans.Next() = 0) or (RunningBal <= 0);

        exit(RunningBal);
    end;

    // =========================================================
    // Capitalize remaining balance to deposits
    // =========================================================
    local procedure FnPostRemainingToDeposit(
        MemberNo: Code[30];
        Amount: Decimal;
        SourceTransType: Option
    )
    var
        RoundedAmount: Decimal;
    begin
        RoundedAmount := RoundDownAmount(Amount);

        if RoundedAmount < MinCapitalizeAmount then
            exit;

        // ===== DEBIT SOURCE =====
        LineNo += 10000;
        SFactory.FnCreateGnlJournalLine(
            BATCH_TEMPLATE,
            BATCH_NAME,
            DOCUMENT_NO,
            LineNo,
            SourceTransType,
            GenJournalLine."Account Type"::Customer,
            MemberNo,
            PostingDate,
            RoundedAmount,
            'BOSA',
            '',
            '2024 Dividends transfer to deposits.Capitalized Balance',
            '',
            AppSource::" "
        );

        // ===== CREDIT DEPOSIT =====
        LineNo += 10000;
        SFactory.FnCreateGnlJournalLine(
            BATCH_TEMPLATE,
            BATCH_NAME,
            DOCUMENT_NO,
            LineNo,
            GenJournalLine."Transaction Type"::"Deposit Contribution",
            GenJournalLine."Account Type"::Customer,
            MemberNo,
            PostingDate,
            -RoundedAmount,
            'BOSA',
            '',
            '2024 Dividends transfer to deposits.Capitalized to Deposits',
            '',
            AppSource::" "
        );
    end;
}
