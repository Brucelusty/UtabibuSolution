//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50024 "Posted Internal Transfer List."
{
    CardPageID = "Sacco Transfer Card";
    Editable = false;
    PageType = List;
    SourceTable = "Sacco Transfers";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Total";Rec."Schedule Total")
                {
                    ApplicationArea = Basic;
                }
                field(Approved; rec.Approved)
                {
                    ApplicationArea = Basic;
                }
                field("Approved By";Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Type";Rec."Source Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No.";Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Source Transaction Type";Rec."Source Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Name";Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Source Loan No";Rec."Source Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Debit; rec.Debit)
                {
                    ApplicationArea = Basic;
                }
                field(Refund; rec.Refund)
                {
                    ApplicationArea = Basic;
                }
                field("Guarantor Recovery";Rec."Guarantor Recovery")
                {
                    ApplicationArea = Basic;
                }
                field("Payrol No.";Rec."Payrol No.")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bosa Number";Rec."Bosa Number")
                {
                    ApplicationArea = Basic;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Savings Account Type";Rec."Savings Account Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        rec.SetRange("Created By", UserId);
    end;
}




