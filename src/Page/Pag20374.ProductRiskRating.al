page 20374 "Product Risk Rating"
{
    ApplicationArea = All;
    Caption = 'Product Risk Rating';
    PageType = List;
    SourceTable = "Product Risk Rating";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Product Category"; Rec."Product Category")
                {
                    ToolTip = 'Specifies the value of the Product Category field.';
                }
                field("Product Type"; Rec."Product Type")
                {
                    ToolTip = 'Specifies the value of the Product Type field.';
                }

                field("Inherent Risk Rating"; Rec."Inherent Risk Rating")
                {
                    ToolTip = 'Specifies the value of the Inherent Risk Rating field.';
                }
                field("Risk Score"; Rec."Risk Score")
                {
                    ToolTip = 'Specifies the value of the Risk Score field.';
                }
            }
        }
    }
}
