page 14125504 "Credit limit logs"
{
    ApplicationArea = All;
    Caption = 'Credit limit logs';
    PageType = List;
    SourceTable = "Credit limit logs";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("Loan product type"; Rec."Loan product type")
                {
                    ToolTip = 'Specifies the value of the Loan product type field.', Comment = '%';
                }
                field("Loan no"; Rec."Loan no")
                {
                    ToolTip = 'Specifies the value of the Loan no field.', Comment = '%';
                }
                field("Loan amount"; Rec."Loan amoount")
                {
                    ToolTip = 'Specifies the value of the Loan amoount field.', Comment = '%';
                }
                field("Previous limit"; Rec."Previous limit")
                {
                    ToolTip = 'Specifies the value of the Previous limit field.', Comment = '%';
                }
                field("Current limit"; Rec."Current limit")
                {
                    ToolTip = 'Specifies the value of the Current limit field.', Comment = '%';
                }
                field("Date logged"; Rec."Date logged")
                {
                    ToolTip = 'Specifies the value of the Date logged field.', Comment = '%';
                }
                field("Norification sent"; Rec."Norification sent")
                {
                    ToolTip = 'Specifies the value of the Norification sent field.', Comment = '%';
                }
            }
        }
    }
}
