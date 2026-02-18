page 80069 "Online Member Accessibility"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Online Portal Users";

    layout
    {
        area(Content)
        {

            repeater(List)
            {
                Editable = false;
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;

                }
                field("Member Name"; Rec."Member Name") { ApplicationArea = all; }
                field("Email Address"; Rec."Email Address") { ApplicationArea = all; }
                field("Changed Password"; Rec."Changed Password") { ApplicationArea = all; }
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