//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172091 "Account Types Interest Rates"
{
    PageType = ListPart;
    SourceTable = "Account Types Interest Rates";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Minimum Balance"; Rec."Minimum Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Balance"; Rec."Maximum Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate"; Rec."Interest Rate")
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




