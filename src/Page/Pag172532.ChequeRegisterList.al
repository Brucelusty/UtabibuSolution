//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172532 "Cheque Register List"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cheques Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque No.";Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Account No.";Rec."Cheque Book Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Action Date";Rec."Action Date")
                {
                    ApplicationArea = Basic;
                }
                field("Application No.";Rec."Application No.")
                {
                    ApplicationArea = Basic;
                }
                field("Actioned By";Rec."Actioned By")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cancel Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to cancel cheque ?', false) = true then begin
                        if Rec.Status <> Rec.Status::Pending then
                            Error('Status must be pending');
                        Rec.Status := Rec.Status::Cancelled;
                        Rec."Action Date" := Today;
                        Rec."Actioned By" := UserId;
                        Rec.Modify;
                    end;
                end;
            }
            action("Stop Cheque")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to stop cheque ?', false) = true then begin
                        if Rec.Status <> Rec.Status::Pending then
                            Error('Status must be pending');
                        Rec.Status := Rec.Status::stopped;
                        Rec."Action Date" := Today;
                        Rec."Actioned By" := UserId;
                        Rec.Modify;
                    end;
                end;
            }
            action("Cancel Cheque Book")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    //reset;
                end;
            }
        }
    }
}




