report 50047 "Share Capital Capitalization"
{
    Caption = 'Share Capital Capitalization';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/ShareCapitalRecovery4.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(Name; Name)
            {
            }
            column(No; "No.")
            {
            }
            column(SharesRetained; "Shares Retained")
            {
            }
            column(CurrentShares; "Current Shares")
            {
            }

            trigger OnAfterGetRecord()
            begin
                // Initialize variables
                shareRecovered := 0;

                // Check for outstanding UTAPESA loans
                LoanApp.Reset();
                LoanApp.SetRange("Client Code", Customer."No.");
                LoanApp.SetRange("Loan Product Type", 'UTAPESA');
                LoanApp.SetFilter("Outstanding Balance", '>0');
                LoanApp.SetFilter("Date Filter", '..%1', RunDate);


                if LoanApp.FindFirst() then
                    exit;


                Customer2.Reset();
                Customer2.SetRange("No.", Customer."No.");
                Customer2.SetAutoCalcFields("Current Shares", "Shares Retained");
                Customer2.SetFilter("Date Filter", '..%1', RunDate);

                if Customer2.FindFirst() then begin
                    SaccoSetup.Get();
                    shareRecovered := SaccoSetup."Retained Shares" - Customer2."Shares Retained";

                    // 🔹 Deduct registration fee gradually if boolean is true
                    if Customer2." Deduct Registration Fee" then
                        TryDeductRegistrationFee(Customer2."No.", RunDate);

                    // Deduct shares if member is below minimum share capital
                    if shareRecovered > 0 then begin
                        CapitalizeShares(Customer2."No.", Customer2."Current Shares", RunDate);
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                // Post journal lines if any exist
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.FindSet() then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(RunDate; RunDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        // Set default RunDate to today if not specified
        if RunDate = 0D then
            RunDate := Today;
    end;

    var
        Customer2: Record Customer;
        SaccoSetup: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        LoanApp: Record "Loans Register";
        Aufactory: Codeunit "Au Factory";
        RunDate: Date;
        shareRecovered: Decimal;
        LineNo: Integer;
        BATCH_TEMPLATE: Label 'GENERAL';
        BATCH_NAME: Label 'DEFAULT';
        DOCUMENT_NO: Label 'SharesRecovered';
        CustLedger: Record "Detailed Cust. Ledg. Entry";
    // 🔹 Deduct registration fee if not already paid
    procedure TryDeductRegistrationFee(MemberNo: Code[20]; PostingDate: Date)
    var
        TotalPaid: Decimal;
        RemainingFee: Decimal;
        RegistrationFeeAmount: Decimal;
    begin
        RegistrationFeeAmount := 1000;
        TotalPaid := GetTotalRegistrationFeePaid(MemberNo);
        RemainingFee := RegistrationFeeAmount - TotalPaid;

        if RemainingFee <= 0 then
            exit; // Already fully paid

        // 🔸 Deduct only the remaining amount (not exceeding 1000 total)
        CreateJournalLine(MemberNo, PostingDate, -RemainingFee,
            'Deposit Contribution', 'Registration Fee Deduction');

        CreateJournalLine(MemberNo, PostingDate, RemainingFee,
            'Registration Fee', 'Registration Fee Deduction');
    end;

    // 🔹 Get total registration fee paid so far
    procedure GetTotalRegistrationFeePaid(MemberNo: Code[20]) TotalPaid: Decimal
    var
        CustLedger2: Record "Detailed Cust. Ledg. Entry";
    begin
        CustLedger2.Reset();
        CustLedger2.SetRange("Customer No.", MemberNo);
        CustLedger2.SetFilter(Description, '*Registration Fee*');
        CustLedger2.CalcSums(Amount);
        exit(Abs(CustLedger2.Amount));
    end;

    // 🔹 Create journal line helper
    procedure CreateJournalLine(MemberNo: Code[20]; PostingDate: Date; Amount: Decimal;
                                TransType: Text; DescTxt: Text)
    begin
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.FindLast() then
            LineNo := GenJournalLine."Line No." + 10000
        else
            LineNo := 10000;

        Aufactory.FnCreateGnlJournalLine(
            BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
            GenJournalLine."Transaction Type"::"Registration Fee",
            GenJournalLine."Account Type"::Customer,
            MemberNo, PostingDate, Amount,
            'BOSA', MemberNo,
            DescTxt + ' - ' + Format(PostingDate),
            MemberNo, 0);
    end;

    procedure CapitalizeShares(MemberNo: Code[20]; RunningBal: Decimal; PostingDate: Date) RunBal: Decimal
    var
        CapitalizedAmount: Decimal;
        RemainingToMinShares: Decimal;
        MaxCapitalize: Decimal;
        Cust: Record Customer;
    begin
        if RunningBal <= 0 then
            exit(RunningBal);

        // Retrieve Sacco setup
        SaccoSetup.Get();

        // Retrieve customer details
        Cust.Reset();
        Cust.SetRange("No.", MemberNo);
        Cust.SetAutoCalcFields("Current Shares", "Shares Retained");

        if Cust.FindFirst() then begin
            // Calculate remaining amount to reach minimum shares
            RemainingToMinShares := SaccoSetup."Retained Shares" - Cust."Shares Retained";
            MaxCapitalize := RunningBal;

            // Determine amount to capitalize
            if RemainingToMinShares < MaxCapitalize then
                CapitalizedAmount := RemainingToMinShares
            else
                CapitalizedAmount := MaxCapitalize;

            if CapitalizedAmount > 0 then begin
                // Create journal line for Deposit Contribution
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.FindLast() then
                    LineNo := GenJournalLine."Line No." + 10000
                else
                    LineNo := 10000;

                Aufactory.FnCreateGnlJournalLine(
                    BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                    GenJournalLine."Transaction Type"::"Deposit Contribution",
                    GenJournalLine."Account Type"::Customer,
                    MemberNo, PostingDate, CapitalizedAmount,
                    'BOSA', MemberNo,
                    'Share Capital Recovered - ' + Format(PostingDate),
                    MemberNo, 0);

                // Create journal line for Share Capital
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.FindLast() then
                    LineNo := GenJournalLine."Line No." + 10000
                else
                    LineNo := 10000;

                Aufactory.FnCreateGnlJournalLine(
                    BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                    GenJournalLine."Transaction Type"::"Share Capital",
                    GenJournalLine."Account Type"::Customer,
                    MemberNo, PostingDate, -CapitalizedAmount,
                    'BOSA', MemberNo,
                    'Share Capital Recovered - ' + Format(PostingDate),
                    MemberNo, 0);
            end;
        end;

        exit(RunningBal);
    end;
}