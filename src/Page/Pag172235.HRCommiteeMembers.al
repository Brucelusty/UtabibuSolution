//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172235 "HR Commitee Members"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Commitee Members";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Member No.";Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = Basic;
                }
                field("Date Appointed";Rec."Date Appointed")
                {
                    ApplicationArea = Basic;
                }
                field(Active; Rec.Active)
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




