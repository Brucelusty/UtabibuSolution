//************************************************************************
Page 172602 "Sub Counties"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Sub Counties";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."County Code")
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit"; Rec."Sub-County Name")
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




