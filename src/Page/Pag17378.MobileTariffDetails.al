page 17378 "Mobile Tariff Details"
{
    ApplicationArea = All;
    Caption = 'Mobile Tariff Details';
    PageType = List;
    SourceTable = "Tariff Details";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ToolTip = 'Specifies the value of the Lower Limit field.';
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ToolTip = 'Specifies the value of the Upper Limit field.';
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ToolTip = 'Specifies the value of the Charge Amount field.';
                }
            }
        }
    }
}
