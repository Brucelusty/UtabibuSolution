report 50033 UpdateGname
{
    ApplicationArea = All;
    Caption = 'UpdateGname';
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/UpdateNames.rdlc';
    dataset
    {
        dataitem(LoansGuaranteeDetails; "Loans Guarantee Details")
        {

            column(Member_No; "Member No") { }
            trigger
            OnAfterGetRecord()
            begin

                Cust.Reset();
                Cust.SetRange("No.", "Member No");
                if Cust.FindFirst() then begin

                    LoansGuaranteeDetails.Name := Cust.Name;
                    LoansGuaranteeDetails.Modify(true);
                    Message('kwaheri');
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
        Cust: Record Customer;
        LoanG: Record "Loans Guarantee Details";
}
