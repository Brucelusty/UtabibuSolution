page 80026 "Insider List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = InsiderLending;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;

                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Position Held"; Rec."Position Held")
                {
                    ApplicationArea = all;
                }
                field("Board/Staff"; Rec."Board/Staff") { ApplicationArea = all; }
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