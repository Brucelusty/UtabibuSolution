//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172046 "Post Cheque Rcpts List-Family"
{
    CardPageID = "Posted Cheque Rcpt H-Family";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cheque Receipts-Family";
    SourceTableView = where(Closed = filter(true));

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
        area(creation)
        {
            action("Inward Cheques Report")
            {
                ApplicationArea = Basic;
                Image = Form;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    ObjInwardHeader.Reset;
                    ObjInwardHeader.SetRange(ObjInwardHeader."No.", Rec."No.");
                    if ObjInwardHeader.FindSet then
                        Report.run(172877, true, true, ObjInwardHeader)
                end;
            }
        }
    }

    var
        ObjInwardHeader: Record "Cheque Receipts-Family";
}




