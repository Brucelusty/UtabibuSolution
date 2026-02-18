//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50020 "Posted BOSA Receipts List"
{
    CardPageID = "Posted BOSA Receipt Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Receipts & Payments";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No.";Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No.";Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employer No.";Rec."Employer No.")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Date";Rec."Cheque Date")
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




