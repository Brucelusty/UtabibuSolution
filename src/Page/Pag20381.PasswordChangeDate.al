page 20381 PasswordChangeDate
{
    ApplicationArea = All;
    Caption = 'PasswordChangeDate';
    PageType = List;
    SourceTable = "Password history";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(UserName; Rec.UserName)
                {
                    Editable = false;
                }
                field("Last Password Change"; Rec."Last Password Change") { Editable = false; }
                field("Next Password Change"; Rec."Next Password Change") { Editable = false; }
            }
        }
    }
}
