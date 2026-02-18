//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172644 "Cheque Transaction Charges(B)"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cheque Transaction Charges(B)";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("code"; Rec.code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Income"; Rec."Sacco Income")
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




