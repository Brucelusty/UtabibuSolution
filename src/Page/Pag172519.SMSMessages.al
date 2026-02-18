//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172519 "SMS Messages"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "SMS Messages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No";Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Telephone No";Rec."Telephone No")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Message";Rec."SMS Message")
                {
                    ApplicationArea = Basic;
                }
                field("Additional Message";Rec."Additional Message")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered";Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered";Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Entered By";Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field("Sent To Server";Rec."Sent To Server")
                {
                    ApplicationArea = Basic;
                }
                field("Date Sent to Server";Rec."Date Sent to Server")
                {
                    ApplicationArea = Basic;
                }
                field(Fetched; Rec.Fetched)
                {
                    ApplicationArea = Basic;
                }
                field("Delivery Status";Rec."Delivery Status")
                {
                    ApplicationArea = Basic;
                }
                field("Bulk SMS Balance";Rec."Bulk SMS Balance")
                {
                    ApplicationArea = Basic;
                }
                field(ScheduledOn; Rec.ScheduledOn)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Resend Message")
            {
                ApplicationArea = Basic;
                Caption = 'Resend Message';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    SMSMessage.Reset;
                    SMSMessage.SetCurrentkey(SMSMessage."Entry No");
                    if SMSMessage.FindLast then begin
                        iEntryNo := SMSMessage."Entry No" + 10;
                    end
                    else begin
                        iEntryNo := 10;
                    end;

                    SMSMessage.Init;
                    SMSMessage."Entry No" := iEntryNo;
                    SMSMessage."Batch No" :=Rec."Batch No";
                    SMSMessage."Document No" :=Rec."Document No";
                    SMSMessage."Account No" :=Rec."Account No";
                    SMSMessage."Date Entered" := Today;
                    SMSMessage."Time Entered" := Time;
                    SMSMessage.Source := Rec.Source;
                    SMSMessage."Entered By" := UserId;
                    SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                    SMSMessage."SMS Message" :=Rec."SMS Message";
                    SMSMessage."Additional Message" :=Rec."Additional Message";
                    SMSMessage."Telephone No" :=Rec."Telephone No";
                    SMSMessage.ScheduledOn := Rec.ScheduledOn;
                    SMSMessage.Insert;

                    Message('The SMS Message:\\%1\\has been resend to %2', Rec."SMS Message" + ' ' + Rec."Additional Message", Rec."Telephone No");
                end;
            }
        }
    }

    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
}




