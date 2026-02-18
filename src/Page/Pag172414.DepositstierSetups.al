//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172414 "Deposits tier Setups"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Member Deposit Tier";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Amount";Rec."Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Amount";Rec."Maximum Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Use Percentage";Rec."Use Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Percentage of Amount";Rec."Percentage of Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Account";Rec."Charge Account")
                {
                    ApplicationArea = Basic;
                }
                field("Notice Status";Rec."Notice Status")
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




