page 80063 "TRADE"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Type of Trade";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Type of Trade"; Rec."Type of Trade")
                {
                    ApplicationArea = All;

                }
                field("Trade Description"; Rec."Trade Description") { ApplicationArea = ALL; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}