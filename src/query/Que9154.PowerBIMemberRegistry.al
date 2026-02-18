query 9154 "Power BI Member Registry"
{
    Caption = 'Power BI Member Registry';
    /* QueryType = API;
    APIPublisher = 'PublisherName';
    APIGroup = 'GroupName';
    APIVersion = 'VersionList';
    EntityName = 'EntityName';
    EntitySetName = 'EntitySetName'; */

    elements
    {
        dataitem(Customer; Customer)
        {
            DataItemTableFilter = ISNormalMember = filter(true);

            column(No_; "No.")
            {

            }
            column(Mmeber_Deposits; "Current Shares")
            {
            }
            column(ID_No_; "ID No.")
            {

            }
            column(Share_Capital; "Shares Retained")
            {

            }
            column(Registration_Date; "Registration Date")
            {
            }
            column(Age; Age)
            {

            }
            column(Date_Of_Birth; "Date Of Birth")
            {
            }
            column(Gender; Gender)
            {

            }

            column(Status; Status)
            {


            }
            column(Current_Loan; "Current Loan")
            {

            }
            column(Current_Savings; "Current Savings")
            {

            }
            column(Current_Shares; "Current Shares")
            {

            }
            column(Monthly_Contribution; "Monthly Contribution")
            {

            }
            column(Gender2; Gender2)
            {

            }

        }



    }


    var
        myInt: Integer;
        Membercue: Record "Membership Cue";

    trigger OnBeforeOpen()
    begin

    end;

}