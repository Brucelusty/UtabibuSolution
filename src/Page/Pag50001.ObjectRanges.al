page 50001 "Object Ranges"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "License Permission";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;

                }
                field("Object Number"; Rec."Object Number")
                { ApplicationArea = all; }
                // field(From; From) { ApplicationArea = all; }
                // field(Index; Index) { ApplicationArea = all; }
                // field(To; "To") { ApplicationArea = all; }
                field("Insert Permission"; Rec."Insert Permission") { ApplicationArea = All; }
                field("Read Permission"; Rec."Read Permission") { ApplicationArea = all; }
                field("Delete Permission"; Rec."Delete Permission") { ApplicationArea = all; }
                field("Modify Permission"; Rec."Modify Permission") { ApplicationArea = all; }
                field("Execute Permission"; Rec."Execute Permission") { ApplicationArea = all; }
                field("Limited Usage Permission"; Rec."Limited Usage Permission") { ApplicationArea = all; }
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