page 20372 "Customer Net Income Risk Rates"
{
    ApplicationArea = All;
    Caption = 'Customer Net Income Risk Rates';
    PageType = List;
    SourceTable = "Customer Net Income Risk Rates";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Max Monthlyl Income"; Rec."Max Monthlyl Income")
                {
                    ToolTip = 'Specifies the value of the Max Monthlyl Income field.';
                }
                field("Min Monthly Income"; Rec."Min Monthly Income")
                {
                    ToolTip = 'Specifies the value of the Min Monthly Income field.';
                }
                field("Risk Rate"; Rec."Risk Rate")
                {
                    ToolTip = 'Specifies the value of the Risk Rate field.';
                }
            }
        }
    }
}
