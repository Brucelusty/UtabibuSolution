page 17382 "Security Questions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Mobile Security Quiz";

    layout
    {
        area(Content)
        {
            group(GENERAL)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;

                }
                field(Sec_code; Rec.Sec_code)
                {
                    ApplicationArea = All;

                }
                field(Descriptions; Rec.Descriptions)
                {
                    ApplicationArea = All;

                }

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