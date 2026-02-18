page 20377 "Service Sms"
{
    ApplicationArea = All;
    Caption = 'Service Sms';
    PageType = List;
    SourceTable = "Login Sms";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Entry No field.', Comment = '%';
                }
                field("SMS Message"; Rec."SMS Message")
                {
                    ToolTip = 'Specifies the value of the SMS Message field.', Comment = '%';
                }
                field("Sent To Server"; Rec."Sent To Server")
                {
                    ToolTip = 'Specifies the value of the Sent To Server field.', Comment = '%';
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ToolTip = 'Specifies the value of the Telephone No field.', Comment = '%';
                }
                field("Date Entered"; Rec."Date Entered") { }
                field("Time Entered"; Rec."Time Entered")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.', Comment = '%';
                }
                field("Time Sent To Server"; Rec."Time Sent To Server")
                {
                    ToolTip = 'Specifies the value of the Time Sent To Server field.', Comment = '%';
                }
            }
        }
    }
}
