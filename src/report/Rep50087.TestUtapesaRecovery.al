report 50087 "Test Utapesa Recovery"
{
    Caption = 'Test Utapesa Recovery';
    DefaultLayout = RDLC;
    ApplicationArea = all;

    RDLCLayout = 'Layouts/Utapas.rdlc';
    dataset
    {
        dataitem(LoansRegister; "Loans Register")
        {
            DataItemTableView = where("Loan Product Type" = filter('UTAPESA'), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan Product Type";
            column(LoanNo; "Loan  No.")
            {
            }

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    GenJournalLine.DeleteAll();
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                UtapesaFee.RecoverUtapesaLoan(LoansRegister."Loan  No.", LoansRegister."Client Code");
            end;

            trigger OnPostDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                end;
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
        UtapesaFee: Codeunit "Utapesa Loan Recovery";
        BATCH_TEMPLATE: Label 'GENERAL';
        BATCH_NAME: Label 'UTAPESA';
        GenJournalLine: Record "Gen. Journal Line";
}
