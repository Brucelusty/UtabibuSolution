page 80086 "Dashboard Images"
{
    Caption = 'Dashboard Company Image';
    PageType = Card;
    SourceTable = "Dashboard Visualization";
    UsageCategory = Administration;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Organization Logo"; Rec."Organization Logo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Organization Logo field.';
                }

            }
        }
    }
}
