page 20375 "Politically Exposed Persons"
{
    ApplicationArea = All;
    Caption = 'Politically Exposed Persons';
    PageType = List;
    SourceTable = "Politically Exposed Persons";
    UsageCategory = Administration;
    
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
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("County Code"; Rec."County Code")
                {
                    ToolTip = 'Specifies the value of the County Code field.';
                }
                field("County Name"; Rec."County Name")
                {
                    ToolTip = 'Specifies the value of the County Name field.';
                }
                field("ID/Passport No"; Rec."ID/Passport No")
                {
                    ToolTip = 'Specifies the value of the ID/Passport No field.';
                }
                field("Position Runing For"; Rec."Position Runing For")
                {
                    ToolTip = 'Specifies the value of the Position Runing For field.';
                }
            }
        }
    }
}
