page 17375 "CountriesLookup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Countries;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Name; Rec."Name")
                {
                    ApplicationArea = All;

                }
                field(Code; Rec.Code) { ApplicationArea = all; }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}