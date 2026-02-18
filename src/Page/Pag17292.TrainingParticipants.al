page 17292 "Training Participants"
{
    ApplicationArea = All;
    Caption = 'Training Participants';
    PageType = ListPart;
    SourceTable = "Training Participants";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field';
                }

            }
        }
    }
}