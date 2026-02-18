//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172033 "ATM Card Linking List"
{
    CardPageID = "ATM No Linking Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "ATM Card Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
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
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Card No";Rec."Card No")
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




