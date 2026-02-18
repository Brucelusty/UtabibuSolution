//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172110 "Closed RFQ List"
{
    CardPageID = "Released Internal Requisitions";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote), DocApprovalType = FILTER(Requisition), Status = CONST(Released), PR = CONST(true), Completed = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description";Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Code";Rec."Ship-to Code")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Name";Rec."Ship-to Name")
                {
                    ApplicationArea = Basic;
                }
                // field("Expected Closing Date";"Expected Closing Date")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Location Code";Rec."Location Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";Rec."Currency Code")
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




