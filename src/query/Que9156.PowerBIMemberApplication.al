query 9156 "Power BI Member Application"
{
    /* QueryType = API;
    APIPublisher = 'PublisherName';
    APIGroup = 'GroupName';
    APIVersion = 'VersionList';
    EntityName = 'EntityName';
    EntitySetName = 'EntitySetName'; */

    elements
    {
        dataitem(Membership_Applications; "Membership Applications")
        {
            
            column(No_; "No.")
            {

            }
            column(Date_of_Birth; "Date of Birth")
            {

            }
            column(ID_No_; "ID No.")
            {

            }
            column(Status; Status)
            { }
            column(Registration_Date; "Registration Date")
            {

            }
            column(Gender; Gender)
            {

            }


            column(Age; Age)
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