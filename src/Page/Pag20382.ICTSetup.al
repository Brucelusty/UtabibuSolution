page 20382 "ICT Setup"
{
    ApplicationArea = All;
    Caption = 'ICT Setup';
    PageType = List;
    SourceTable = "ICT Setup";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Primary Key"; Rec."Primary Key")
                {
                    ToolTip = 'Specifies the value of the Primary Key field.';
                }
                field("Enforce Password Expiry"; Rec."Enforce Password Expiry")
                {
                    ToolTip = 'Specifies the value of the Enforce Password Expiry field.';
                }
                field("Password Change Dateformula"; Rec."Password Change Dateformula")
                {
                    ToolTip = 'Specifies the value of the Password Change Dateformula field.';
                }

            }
        }
    }
}
