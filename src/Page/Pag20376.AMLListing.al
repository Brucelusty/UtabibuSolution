page 20376 "AML Listing"
{
    ApplicationArea = All;
    Caption = 'AML Listing';
    PageType = List;
    SourceTable = "AML Details";
    UsageCategory = History;
    Editable= false;
    ModifyAllowed= false;
    DeleteAllowed= false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("AML No"; Rec."AML No")
                {
                    ToolTip = 'Specifies the value of the AML No field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
                field("Current Deposits"; Rec."Current Deposits")
                {
                    ToolTip = 'Specifies the value of the Current Deposits field.';
                }
                field("Current Share Capital"; Rec."Current Share Capital")
                {
                    ToolTip = 'Specifies the value of the Current Share Capital field.';
                }
                field("Date Listed"; Rec."Date Listed")
                {
                    ToolTip = 'Specifies the value of the Date Listed field.';
                }
                field("Customer Risk Rate"; Rec."Customer Risk Rate")
                {
                    ToolTip = 'Specifies the value of the Customer Risk Rate field.';
                }
                field("Deposits Analysis"; Rec."Deposits Analysis")
                {
                    ToolTip = 'Specifies the value of the Deposits Analysis field.';
                }
                field("Frequency Contribution"; Rec."Frequency Contribution")
                {
                    ToolTip = 'Specifies the value of the Frequency Contribution field.';
                }
            }
        }
    }
}
