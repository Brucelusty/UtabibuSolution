//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172020 "Member Summary By Branch"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Member Summary By Branch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Branch Code";Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Active Members";Rec."Active Members")
                {
                    ApplicationArea = Basic;
                }
                field("Awaiting Exit Members";Rec."Awaiting Exit Members")
                {
                    ApplicationArea = Basic;
                }
                field("Exited Members";Rec."Exited Members")
                {
                    ApplicationArea = Basic;
                }
                field("Dormant Members";Rec."Dormant Members")
                {
                    ApplicationArea = Basic;
                }
                field("Deceased Members";Rec."Deceased Members")
                {
                    ApplicationArea = Basic;
                }
                field("Total Members";Rec."Total Members")
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




