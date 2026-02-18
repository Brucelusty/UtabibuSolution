page 20371 "Customer Risk Rating"
{
    ApplicationArea = All;
    Caption = 'Customer Risk Rating';
    PageType = List;
    SourceTable = "Customer Risk Rating";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field.';
                }

                field("Sub Category Option"; Rec."Sub Category Option")
                {
                    ToolTip = 'Specifies the value of the Sub Category Option field.';
                    Caption = 'Sub Category';
                }
                field("Inherent Risk Rating"; Rec."Inherent Risk Rating")
                {
                    ToolTip = 'Specifies the value of the Inherent Risk Rating field.';
                }
                field("Risk Score"; Rec."Risk Score")
                {
                    ToolTip = 'Specifies the value of the Risk Score field.';
                }
                field("Max Relationship Length(Years)"; Rec."Max Relationship Length(Years)")
                {
                    ToolTip = 'Specifies the value of the Max Relationship Length(Years) field.';
                }
                field("Min Relationship Length(Years)"; Rec."Min Relationship Length(Years)")
                {
                    ToolTip = 'Specifies the value of the Min Relationship Length(Years) field.';
                }

            }
        }
    }
}
