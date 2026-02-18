report 50045 "Share Caspital Recovery"
{
    ApplicationArea = All;
    Caption = 'Share Capital Recovery';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/ShareCapitalRecovery3.rdlc';
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
                shareRecovered := 0;
                Customer2.Reset();
                Customer2.SetRange("No.", Customer."No.");
                Customer2.SetAutoCalcFields("Current Shares", "Shares Retained");
                Customer2.SetFilter("Date Filter", '..%1', RunDate);
                if Customer2.Find('-') then begin
                    SaccoSetup.Get();
                    shareRecovered := SaccoSetup."Retained Shares" - Customer2."Shares Retained";
                    if shareRecovered > 0 then begin
                        CapitalizeShares(Customer2."No.", Customer2."Current Shares", RunDate);
                    end;

                end;

            end;

            trigger OnPostDataItem()
            begin
                // //CU posting															
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then
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
                group(GroupName)
                {
                    field(RunDate; RunDate)
                    {
                        ApplicationArea = All;
                    }
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
        RunBal: Decimal;
        Cust: Record Customer;
        SaccoSetup: Record "Sacco General Set-Up";
        LineNo: Integer;
        Aufactory: Codeunit "Au Factory";
        SharCapitalized: Decimal;
        BATCH_NAME: Label 'DEFAULT';
        BATCH_TEMPLATE: Label 'GENERAL';
        DOCUMENT_NO: Label 'SharesRecoverd';
        GenJournalLine: Record "Gen. Journal Line";
        AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        LoanApp: Record "Loans Register";
        AmountToDeduct: Decimal;
        Customer2: record Customer;
        shareRecovered: Decimal;
        RunDate: Date;

    procedure CapitalizeShares(MemberNo: Code[20]; RunningBal: Decimal; PostingDate: Date) RunBal: Decimal
    begin
        if RunningBal > 0 then begin
            SharCapitalized := 0;
            SaccoSetup.Get();
            Cust.Reset();
            Cust.SetRange("No.", MemberNo);
            Cust.SetAutoCalcFields("Current Shares", "Shares Retained");
            if Cust.FindFirst() then begin
                SharCapitalized := SaccoSetup."Retained Shares" - Cust."Shares Retained";
                if SharCapitalized > RunningBal then begin
                    SharCapitalized := RunningBal
                end else begin
                    SharCapitalized := SharCapitalized;
                end;
                IF SharCapitalized > 0 THEN begin

                    LineNo := LineNo + 10000;
                    Aufactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Customer, MemberNo, PostingDate, SharCapitalized, 'BOSA', MemberNo,
                    'Share Capital  Recovered- ' + Format(PostingDate), MemberNo, AppSource::" ");

                    LineNo := LineNo + 10000;
                    Aufactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Share Capital",
                    GenJournalLine."account type"::Customer, MemberNo, PostingDate, SharCapitalized * -1, 'BOSA', MemberNo,
                    'Share Capital Recovered- ' + Format(PostingDate), MemberNo, AppSource::" ");


                end;
            end;
        end;
        exit(RunningBal);
    end;
}
