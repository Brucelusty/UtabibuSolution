//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172133 "Credit Scoring Criteria"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Credit Score Criteria";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic;
                }
                field("Credit Score";Rec."Credit Score")
                {
                    ApplicationArea = Basic;
                }
                field("Min Relationship Length(Years)";Rec."Min Relationship Length(Years)")
                {
                    ApplicationArea = Basic;
                }
                field("Max Relationship Length(Years)";Rec."Max Relationship Length(Years)")
                {
                    ApplicationArea = Basic;
                }
                field("Min Count Range";Rec."Min Count Range")
                {
                    ApplicationArea = Basic;
                }
                field("Max Count Range";Rec."Max Count Range")
                {
                    ApplicationArea = Basic;
                }
                field("YES/No";Rec."YES/No")
                {
                    ApplicationArea = Basic;
                }
                field("Min Amount Range";Rec."Min Amount Range")
                {
                    ApplicationArea = Basic;
                }
                field("Max Amount Range";Rec."Max Amount Range")
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




