page 17322 "Pictures"
{
    ApplicationArea = All;
    Caption = 'Pictures ';
    PageType = Card;
    SourceTable = "Picture and Signatures";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Specifies the value of the Picture field.';
                }
                field(Signature; Rec.Signature)
                {
                    ToolTip = 'Specifies the value of the Signature field.';
                }
            }
        }
    }
}

