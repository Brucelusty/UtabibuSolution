//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17276 "Supervisor Approval Levels"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Supervisors Approval Levels";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Approval Amount"; Rec."Maximum Approval Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("E-mail Address"; Rec."E-mail Address")
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




