//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172664 "Members Only"
{
    PageType = CardPart;
    SourceTable = "Membership Cue";

    layout
    {
        area(content)
        {
            cuegroup(Members)
            {
                field("Active Members";Rec."Active Members")
                {
                    ApplicationArea = Basic;
                    //image ="None";
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Dormant Members";Rec."Dormant Members")
                {
                    ApplicationArea = Basic;
                    //image ="None";
                }
                field("Non-Active Members";Rec."Non-Active Members")
                {
                    ApplicationArea = Basic;
                    //Image = PEople;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Deceased Members";Rec."Deceased Members")
                {
                    ApplicationArea = Basic;
                    Image = People;
                }
                field("Withdrawn Members";Rec."Withdrawn Members")
                {
                    ApplicationArea = Basic;
                    // //image ="None";
                }
            }
            cuegroup("Account Category")
            {
                Caption = 'Account Categories';
                field("Group Accounts";Rec."Group Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Joint Accounts";Rec."Joint Accounts")
                {
                    ApplicationArea = Basic;
                    //image ="None";
                }
            }
            cuegroup("Account Categories")
            {
                Caption = 'Gender';
                field("Female Members";Rec."Female Members")
                {
                    ApplicationArea = Basic;
                    //image ="None";
                }
                field("Male Members";Rec."Male Members")
                {
                    ApplicationArea = Basic;
                    //image ="None";
                }
                field("Junior Members";Rec."Junior Members")
                {
                    ApplicationArea = Basic;
                    Image = Library;
                }
            }
            cuegroup(Control2)
            {
                field("Requests to Approve";Rec."Requests to Approve")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Requests to Approve";
                }
                field("Requests Sent for Approval";Rec."Requests Sent for Approval")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = Approvals;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get(UserId) then begin
            Rec.Init;
            Rec."User ID" := UserId;
            Rec.Insert;
        end;
    end;
}




