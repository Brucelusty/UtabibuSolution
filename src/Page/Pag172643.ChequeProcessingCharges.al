//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172643 "Cheque Processing Charges"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cheque Processing Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = Basic;
                }
                field(Charges; Rec.Charges)
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Income"; Rec."Sacco Income")
                {
                    ApplicationArea = Basic;
                }
                field(Range; Rec.Range)
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




