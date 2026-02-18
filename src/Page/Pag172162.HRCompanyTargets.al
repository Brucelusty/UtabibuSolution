//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172162 "HR Company Targets"
{
    CardPageID = "HR AppraisalCompanyTarget list";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Appraisal Company Target";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Score;Rec.Score)
                {
                    ApplicationArea = Basic;
                }
                field(Recommendations;Rec.Recommendations)
                {
                    ApplicationArea = Basic;
                }
                field("Description 2";Rec."Description 2")
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




