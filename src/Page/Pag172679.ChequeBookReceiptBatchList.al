//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172679 "Cheque Book Receipt Batch List"
{
    CardPageID = "Cheque Book Receipt Batch Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cheque Book  Receipt Batch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Batch No.";Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                }
                field("Description/Remarks";Rec."Description/Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Requested; Rec.Requested)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Created";Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested";Rec."Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Requested By";Rec."Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Prepared By";Rec."Prepared By")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";Rec."No. Series")
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




