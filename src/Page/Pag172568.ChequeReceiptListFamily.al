//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172568 "Cheque Receipt List-Family"
{
    CardPageID = "Cheque Receipt Header-Family";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cheque Receipts-Family";
    SourceTableView = where(Closed = filter(false));

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
                field("Transaction Date";Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Refference Document";Rec."Refference Document")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time";Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Unpaid By";Rec."Unpaid By")
                {
                    ApplicationArea = Basic;
                }
                field(Unpaid; Rec.Unpaid)
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




