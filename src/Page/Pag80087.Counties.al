page 80087 Counties
{
    
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Counties;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("County Code"; Rec."County Code")
                {
                    ApplicationArea = All;

                }
                field("County Name"; Rec."County Name") { ApplicationArea = all; }
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