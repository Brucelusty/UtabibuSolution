//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17357 "Posted Trunch Disbursment List"
{
    CardPageID = "Loan Trunch Disburesment";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loan trunch Disburesment";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Outstanding"; Rec."Balance Outstanding")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Disburse"; Rec."Amount to Disburse")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account"; Rec."Pay Account")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No/Reference No"; Rec."Cheque No/Reference No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
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




