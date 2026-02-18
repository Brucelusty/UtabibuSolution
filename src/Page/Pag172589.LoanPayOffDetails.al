//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172589 "Loan PayOff Details"
{
    PageType = ListPart;
    SourceTable = "Loans PayOff Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Loan to PayOff"; Rec."Loan to PayOff")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Outstanding"; Rec."Loan Outstanding")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Insurance"; Rec."Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Debt Collector Fee"; Rec."Debt Collector Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total PayOff"; Rec."Total PayOff")
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




