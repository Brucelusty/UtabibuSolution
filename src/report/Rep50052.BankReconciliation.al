report 50052 "Bank Reconciliation"
{
    RDLCLayout = 'Layouts/bankReconciliation.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            column(Picture; CompanyInfo.Picture)
            {

            }
            column(phone; CompanyInfo."Phone No.")
            {

            }
            column(Address; CompanyInfo.Address)
            {

            }
            column(Email; CompanyInfo."E-Mail")
            {

            }
            column(PostalCode; CompanyInfo."Post Code")

            {

            }
            column(Address2; CompanyInfo."Address 2")

            {

            }
            column(Name; CompanyInfo.Name)
            {

            }

        }

    }


    requestpage
    {
        layout
        {
            area(Content)
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
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        //CompanyInformation.CALCFIELDS("Official Stamp");
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);

    end;



    var
        CompanyInfo: Record "Company Information";
}