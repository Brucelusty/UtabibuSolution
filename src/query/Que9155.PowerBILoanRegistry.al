query 9155 "Power BI Loan Registry"
{
    /* QueryType = API;
    APIPublisher = 'PublisherName';
    APIGroup = 'GroupName';
    APIVersion = 'VersionList';
    EntityName = 'EntityName';
    EntitySetName = 'EntitySetName'; */

    elements
    {
        dataitem(Loans_Register; "Loans Register")
        {
            column(Loan_No; "Loan  No.")
            {

            }
            column(Client_Code; "Client Code")
            {

            }
            column(Application_Date; "Application Date")
            {
            }
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Requested_Amount; "Requested Amount")
            {

            }
            column(Amount_Disbursed; "Amount Disbursed")
            {

            }
            column(Loans_Category_SASRA; "Loans Category-SASRA")
            {

            }
            column(Loans_Category; "Loans Category")
            {

            }
            column(Member_Share_Capital; "Member Share Capital")
            {

            }
            column(Member_Deposits; "Member Deposits")
            {

            }
            column(Defaulter_Loan; "Defaulter Loan")
            {

            }
            column(Defaulter_Overide_Reasons; "Defaulter Overide Reasons")
            {

            }
            column(Gender; Gender)
            {

            }

            column(Defaulted; Defaulted)
            {

            }
            column(Total_Repayment; "Total Repayment")
            {

            }
            column(Total_Principle_Paid; "Total Principle Paid")
            {

            }
            column(Rescheduled; Rescheduled)
            {

            }
            column(Outstanding_Balance; "Outstanding Balance")
            {

            }



        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}