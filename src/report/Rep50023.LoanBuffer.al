report 50023 LoanBuffer
{
    ApplicationArea = All;
    Caption = 'LoanBuffer';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/BuffeLoan.rdlc';
    dataset
    {
        dataitem(LoansImportBuffer; "Loans Import Buffer")
        {
            column(LoanNo; "Loan No.")
            {
            }
            column("Ïnterest"; "Ïnterest") { }

            trigger OnAfterGetRecord()
            var
                Loansregister: Record "Loans Register";
            begin
                Loansregister.Reset();
                Loansregister.SetRange("Loan  No.", LoansImportBuffer."Loan No.");
                if Loansregister.FindFirst() then begin
                    Loansregister.Interest := LoansImportBuffer."Ïnterest";
                    Loansregister.Modify(true);
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
}
