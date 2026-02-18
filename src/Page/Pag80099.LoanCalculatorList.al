page 80099 "Loan Calculator List"
{
    ApplicationArea = All;
    Caption = 'Loan Calculator List';
    PageType = List;
    SourceTable = "Loan Calculator";
    UsageCategory = Lists;
    CardPageId= "Loan Calculator";
    ModifyAllowed= false;
    DeleteAllowed= false;
    
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
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ToolTip = 'Specifies the value of the Loan Product Type field.', Comment = '%';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ToolTip = 'Specifies the value of the Requested Amount field.', Comment = '%';
                }
            }
        }
    }
}
