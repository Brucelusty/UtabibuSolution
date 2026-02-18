report 80029 "Holiday Savings Interest"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            begin

                Cust.Reset();
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", '..%1', PostingDate);
                Cust.SetAutoCalcFields("Holiday Savings");
                if Cust.Find('-') then begin


                //     LineNo := LineNo + 10000;
                //     AuFactory.FnCreateGnlJournalLine('GENERAL', 'HolidayInt', DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Holiday Savings",
                //     GenJournalLine."Account Type"::Customer, Cust."No.", PostingDate, (Cust."Holiday Savings" * 0.04 / 12)*-1, '', Cust."No.",
                //     'Holiday Saving interet', Cust."No.", GenJournalLine."Application Source"::" ");
                    
                //     //credit income account
                //     LineNo := LineNo + 10000;
                //     AuFactory.FnCreateGnlJournalLine('GENERAL', 'HolidayInt', DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                //    GenJournalLine."Account Type"::"G/L Account", '40101', PostingDate, Cust."Holiday Savings" * 0.04 / 12 , '', Cust."No.",
                //    'Holiday Saving interet', Cust."No.", GenJournalLine."Application Source"::" ");

                end;
            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset();
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'HolidayInt');
                if GenJournalLine.Find() then begin
                    GenJournalLine.DeleteAll();
                end;
                Getbatches.Reset();
                Getbatches.SetRange(Getbatches."Journal Template Name", 'GENERAL');
                Getbatches.SetRange(Getbatches.Name, 'HolidayInt');
                if Getbatches.Find('-') = false then begin
                    Getbatches."Journal Template Name" := 'GENERAL';
                    Getbatches.Name := 'HolidayInt';
                    Getbatches.Insert(true);
                end;
            end;

        }
    }

    requestpage
    {
        SaveValues = false;
        layout
        {
            area(content)
            {
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = Basic;
                }
                field(DOCUMENT_NO; DOCUMENT_NO)
                {
                    ApplicationArea = Basic;
                }

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/mylayout2.rdl';
        }
    }

    var
        myInt: Integer;
        PostingDate: Date;
        Cust: Record Customer;
        Getbatches: Record 232;
        AuFactory: Codeunit "Au Factory";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        DOCUMENT_NO: Code[100];

        LoanType: Record "Loan Products Setup";
}