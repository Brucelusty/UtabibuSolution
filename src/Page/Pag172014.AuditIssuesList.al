//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172014 "Audit Issues List"
{
    CardPageID = "Audit Tracker Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Audit Issues Tracker";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Audit";Rec."Date Of Audit")
                {
                    ApplicationArea = Basic;
                }
                field("Theme Description";Rec."Theme Description")
                {
                    ApplicationArea = Basic;
                }
                field("Mgt Action Point";Rec."Mgt Action Point")
                {
                    ApplicationArea = Basic;
                }
                field("Action Date";Rec."Action Date")
                {
                    ApplicationArea = Basic;
                }
                field("Day Past";Rec."Day Past")
                {
                    ApplicationArea = Basic;
                }
                field("Action Owner";Rec."Action Owner")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Combined Status";Rec."Combined Status")
                {
                    ApplicationArea = Basic;
                }
                field("Mgt Response";Rec."Mgt Response")
                {
                    ApplicationArea = Basic;
                }
                field("Revised Mgt Comment";Rec."Revised Mgt Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Audit Opinion On Closure";Rec."Audit Opinion On Closure")
                {
                    ApplicationArea = Basic;
                }
                field("Mgt Comment After Review";Rec."Mgt Comment After Review")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.FindSet then begin
            if UserSetup."Is Manager" = false then
                Error('You do not have rights to view this page.');
        end;
    end;

    var
        UserSetup: Record "User Setup";
}




