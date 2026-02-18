page 17379 "Approve-Internal Transfer List"
{
    CardPageID = "Sacco Transfer Card";
    ApplicationArea = All;
    Caption = 'Approve-Internal Transfer List';
    PageType = List;
    SourceTable = "Sacco Transfers";
    UsageCategory = Lists;
    SourceTableView = where(Posted = filter(false), Status = filter(Approved));

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
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Total"; Rec."Schedule Total")
                {
                    ApplicationArea = Basic;
                }
                field(Approved; rec.Approved)
                {
                    ApplicationArea = Basic;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Type"; Rec."Source Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Source Transaction Type"; Rec."Source Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Source Loan No"; Rec."Source Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
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
                field("Guarantor Recovery"; Rec."Guarantor Recovery")
                {
                    ApplicationArea = Basic;
                }
                field("Payrol No."; Rec."Payrol No.")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bosa Number"; Rec."Bosa Number")
                {
                    ApplicationArea = Basic;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Savings Account Type"; Rec."Savings Account Type")
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




