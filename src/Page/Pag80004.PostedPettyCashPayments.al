//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80004 "Posted Petty Cash Payments"
{
    CardPageID = "Cash Payment Header";
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type" = const("Petty Cash"),
                            Posted = const(true));

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
                field("Document Type";Rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date";Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; rec.Payee)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)";Rec."Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount";Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount(LCY)";Rec."Net Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Payment Type" := rec."payment type"::"Cash Purchase";
        if FundsSetup.Get then begin
            FundsSetup.TestField(FundsSetup."Cash Account");
            rec."Bank Account" := FundsSetup."Cash Account";
            rec.Validate("Bank Account");
        end;
    end;

    trigger OnOpenPage()
    begin
        rec.SetRange("User ID", UserId);
    end;

    var
        FundsSetup: Record "Funds General Setup";
}




