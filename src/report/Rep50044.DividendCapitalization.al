report 50044 "Dividend Capitalization"
{
    ApplicationArea = All;
    Caption = 'Dividend Capitalization';
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Capitalization.rdlc';
    dataset
    {
        dataitem(Customer; Customer)
        {
            column(Name; Name)
            {

            }
            column(No; "No.")
            {
            }
            column(DividendAmount; "Dividend Amount")
            {
            }
            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                GenJournalLine.DeleteAll();
            end;

            trigger OnAfterGetRecord()
            begin
                if Capitalize then begin
                    Customer.CalcFields("Dividend Amount");
                    RunBal := Customer."Dividend Amount";
                    RunBal := CapitalizeShares(Customer."No.", RunBal);
                end;
                if CombineIODTODIv then begin
                    Customer.CalcFields("Interest On Deposits");
                    RunBal := Customer."Interest On Deposits";
                    RunBal := CombineIOTODIV(Customer."No.", RunBal);
                end;
                //CapitalizDeposit(Customer."No.", RunBal);
                // RecoverDividendLoan(Customer."No.", RunBal)
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(PostingDate; PostingDate)
                    {

                    }
                    field(Capitalize; Capitalize) { }
                    field(CombineIODTODIv; CombineIODTODIv) { }

                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        PostingDate: Date;
        Capitalize: Boolean;
        CombineIODTODIv: Boolean;
        RunBal: Decimal;
        Cust: Record Customer;
        SaccoSetup: Record "Sacco General Set-Up";
        LineNo: Integer;
        Aufactory: Codeunit "Au Factory";
        SharCapitalized: Decimal;
        BATCH_NAME: Label 'DEFAULT';
        BATCH_TEMPLATE: Label 'GENERAL';
        DOCUMENT_NO: Label 'DIV_2024';
        GenJournalLine: Record "Gen. Journal Line";
        AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        LoanApp: Record "Loans Register";
        AmountToDeduct: Decimal;

    procedure RecoverDividendLoan(MemberNo: Code[20]; RunningBal: Decimal) RunBal: Decimal
    begin
        if RunningBal > 0 then begin
            AmountToDeduct := 0;
            LoanApp.Reset();
            LoanApp.SetRange("Client Code", MemberNo);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'DIVIDEND');
            LoanApp.SetAutoCalcFields("Outstanding Balance");
            if LoanApp.Find('-') then begin
                repeat
                    AmountToDeduct := LoanApp."Outstanding Balance";
                    if AmountToDeduct > RunningBal then begin
                        AmountToDeduct := RunningBal;
                    end else begin
                        AmountToDeduct := AmountToDeduct;
                    end;
                    LineNo := LineNo + 10000;
                    Aufactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                    GenJournalLine."account type"::Customer, MemberNo, PostingDate, AmountToDeduct, 'BOSA', LoanApp."Loan  No.",
                    'Loan in Arrears Recovered- ' + Format(LoanApp."Loan  No."), LoanApp."Loan  No.", AppSource::" ");

                    LineNo := LineNo + 10000;
                    Aufactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                    GenJournalLine."account type"::Customer, MemberNo, PostingDate, AmountToDeduct * -1, 'BOSA', LoanApp."Loan  No.",
                    'Loan In Arrears Recovered From Dividend- ' + Format(LoanApp."Loan  No."), LoanApp."Loan  No.", AppSource::" ");
                until LoanApp.Next() = 0
            end;

        end;
        exit(RunningBal);
    end;

    procedure CapitalizeShares(MemberNo: Code[20]; RunningBal: Decimal) RunBal: Decimal
    begin
        if RunningBal > 0 then begin
            SharCapitalized := 0;
            SaccoSetup.Get();
            Cust.Reset();
            Cust.SetRange("No.", MemberNo);
            Cust.SetAutoCalcFields("Current Shares", "Shares Retained");
            //Cust.SetFilter(Status, '%1|%2', Cust.Status::Active, Cust.Status::Dormant);
            if Cust.FindFirst() then begin
                SharCapitalized := SaccoSetup."Retained Shares" - Cust."Shares Retained";
                if SharCapitalized > RunningBal then begin
                    SharCapitalized := RunningBal
                end else begin
                    SharCapitalized := SharCapitalized;
                end;
                //  SharCapitalized := RunningBal;
                IF SharCapitalized > 0 THEN begin

                    LineNo := LineNo + 10000;
                    Aufactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                    GenJournalLine."account type"::Customer, MemberNo, PostingDate, SharCapitalized, 'BOSA', MemberNo,
                    'Share Capital  Capitalized- ' + Format(MemberNo), MemberNo, AppSource::" ");

                    LineNo := LineNo + 10000;
                    Aufactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Share Capital",
                    GenJournalLine."account type"::Customer, MemberNo, PostingDate, SharCapitalized * -1, 'BOSA', MemberNo,
                    'Share Capital Capitalized- ' + Format(PostingDate), MemberNo, AppSource::" ");

                    // // //CU posting															
                    // GenJournalLine.Reset;
                    // GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                    // GenJournalLine.SetRange("Journal Batch Name", 'DIVIDEND');
                    // if GenJournalLine.Find('-') thensss
                    //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                end;
            end;
        end;
        exit(RunningBal);
    end;

    procedure 
    CombineIOTODIV(MemberNo: Code[20]; RunningBal: Decimal) RunBal: Decimal
    begin
        if RunningBal > 0 then begin
            SharCapitalized := 0;
            SaccoSetup.Get();
            Cust.Reset();
            Cust.SetRange("No.", MemberNo);
            Cust.SetAutoCalcFields("Current Shares", "Shares Retained");
            //Cust.SetFilter(Status, '%1|%2', Cust.Status::Active, Cust.Status::Dormant);
            if Cust.FindFirst() then begin
                // SharCapitalized := SaccoSetup."Retained Shares" - Cust."Shares Retained";
                // if SharCapitalized > RunningBal then begin
                //     SharCapitalized := RunningBal
                // end else begin
                //     SharCapitalized := SharCapitalized;
                // end;
                SharCapitalized := RunningBal;
                IF SharCapitalized > 0 THEN begin

                    LineNo := LineNo + 10000;
                    Aufactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest on Deposits",
                    GenJournalLine."account type"::Customer, MemberNo, PostingDate, SharCapitalized, 'BOSA', MemberNo,
                    'Interest on deposit Transferred- ' + Format(MemberNo), MemberNo, AppSource::" ");

                    LineNo := LineNo + 10000;
                    Aufactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Dividend,
                    GenJournalLine."account type"::Customer, MemberNo, PostingDate, SharCapitalized * -1, 'BOSA', MemberNo,
                    'Interest on deposit Transferred- ' + Format(PostingDate), MemberNo, AppSource::" ");

                    // // //CU posting															
                    // GenJournalLine.Reset;
                    // GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                    // GenJournalLine.SetRange("Journal Batch Name", 'DIVIDEND');
                    // if GenJournalLine.Find('-') thensss
                    //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                end;
            end;
        end;
        exit(RunningBal);
    end;


    procedure CapitalizDeposit(MemberNo: Code[20]; RunningBal: Decimal) RunBal: Decimal
    begin
        if RunningBal > 0 then begin
            SharCapitalized := 0;
            SaccoSetup.Get();
            Cust.Reset();
            Cust.SetRange("No.", MemberNo);
            Cust.SetAutoCalcFields("Current Shares", "Shares Retained");
            //Cust.SetFilter(Status, '%1|%2', Cust.Status::Active, Cust.Status::Dormant);
            if Cust.FindFirst() then begin
                SharCapitalized := RunningBal;
                LineNo := LineNo + 10000;
                Aufactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                GenJournalLine."account type"::Customer, MemberNo, PostingDate, SharCapitalized, 'BOSA', MemberNo,
                'Deposits  Capitalized- ' + Format(MemberNo), MemberNo, AppSource::" ");

                LineNo := LineNo + 10000;
                Aufactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                GenJournalLine."account type"::Customer, MemberNo, PostingDate, SharCapitalized * -1, 'BOSA', MemberNo,
                'Deposits Capitalized- ' + Format(PostingDate), MemberNo, AppSource::" ");

                // // //CU posting															
                // GenJournalLine.Reset;
                // GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                // GenJournalLine.SetRange("Journal Batch Name", 'DIVIDEND');
                // if GenJournalLine.Find('-') thensss
                //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
            end;
            //end;
        end;
        exit(RunningBal);
    end;

}
