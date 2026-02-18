report 50016 "Sectorial Lending"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    RDLCLayout = 'Layouts/SectorialLending.rdlc';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Main Sector"; "Main Sector")
        {
            column(Code; Code)
            {
            }
            column(Description; Description) { }
            dataitem("Sub Sector"; "Sub Sector")
            {
                DataItemLink = No = field(Code);
                column(CodeSub; Code) { }
                column(DescriptionSub; Description) { }
                column(Nosub; No) { }
                dataitem("Specific Sector"; "Specific Sector")
                {
                    DataItemLink = No = field(Code);
                    RequestFilterFields = "Date Filter";
                    column(CodeSpecific; Code) { }
                    column(DescriptionSpecific; Description) { }
                    column(No; No) { }
                    column(Amount; Amount) { }
                   
                }
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



    var
        myInt: Integer;
}