//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172603 "SMS Charges"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "SMS Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Charge Code";Rec."Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Charge Account";Rec."Charge Account")
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




