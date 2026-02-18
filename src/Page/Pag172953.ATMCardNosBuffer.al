//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172953 "ATM Card Nos Buffer"
{
    CardPageID = "Linked ATM No Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "ATM Card Nos Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ATM Card No";Rec."ATM Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("ID No";Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Delink";Rec."Reason For Delink")
                {
                    ApplicationArea = Basic;
                }
                field("Delink ATM Card";Rec."Delink ATM Card")
                {
                    ApplicationArea = Basic;
                }
                field("Delinked By";Rec."Delinked By")
                {
                    ApplicationArea = Basic;
                }
                field("Delinked On";Rec."Delinked On")
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




