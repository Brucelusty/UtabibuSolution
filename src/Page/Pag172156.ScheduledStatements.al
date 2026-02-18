//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172156 "Scheduled Statements"
{
    CardPageID = "Scheduled Statements Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Scheduled Statements";

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
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Statement Period";Rec."Statement Period")
                {
                    ApplicationArea = Basic;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic;
                }
                field("Output Format";Rec."Output Format")
                {
                    ApplicationArea = Basic;
                }
                field("Days of Week";Rec."Days of Week")
                {
                    ApplicationArea = Basic;
                }
                field("Days Of Month";Rec."Days Of Month")
                {
                    ApplicationArea = Basic;
                }
                field("Statement Type";Rec."Statement Type")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Status";Rec."Schedule Status")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Created On";Rec."Created On")
                {
                    ApplicationArea = Basic;
                }
                field("Activated By";Rec."Activated By")
                {
                    ApplicationArea = Basic;
                }
                field("Activated On";Rec."Activated On")
                {
                    ApplicationArea = Basic;
                }
                field("Stopped By";Rec."Stopped By")
                {
                    ApplicationArea = Basic;
                }
                field("Stopped On";Rec."Stopped On")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}




