page 17440 "Sms List"
{
    ApplicationArea = All;
    Caption = 'Sms List';
    PageType = List;
    SourceTable = "Sms Entry 2";
    UsageCategory = Administration;
    Editable = false;
    SourceTableView = where(Message = filter(<> ''));
    ModifyAllowed = false;
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ToolTip = 'Specifies the value of the EntryNo field.';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field(Message; Rec.Message)
                {
                    ToolTip = 'Specifies the value of the Message field.';
                }
                field("Message Date"; Rec."Message Date")
                {
                    ToolTip = 'Specifies the value of the Message Date field.';
                }
                field("Message Time"; Rec."Message Time")
                {
                    ToolTip = 'Specifies the value of the Message Time field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Response; Rec.Response) { }
                field("Response id"; Rec."Response id") { }
            }
        }
    }
}
