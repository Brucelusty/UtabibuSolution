page 17200 Custodian
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Safe Custody Custodians";

    layout
    {
        area(Content)
        {
            repeater(ListLines)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;

                }
                field("Permision Type"; Rec."Permision Type") { }

                field("Custodian Of";Rec."Custodian Of"){}
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