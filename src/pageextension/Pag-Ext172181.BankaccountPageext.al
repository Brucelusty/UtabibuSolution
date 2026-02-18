//************************************************************************
pageextension 172181 "BankaccountPageext" extends "Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Posting)
        {

            group("Teller/Treasury Addon")
            {
                Caption = 'Teller/Treasury Addon';
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Teller Withholding"; Rec."Maximum Teller Withholding")
                {
                    ApplicationArea = Basic;
                }
                field("Max Withdrawal Limit"; Rec."Max Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Max Deposit Limit"; Rec."Max Deposit Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Max Cheque Deposit Limit"; Rec."Max Cheque Deposit Limit")
                {
                    ApplicationArea = Basic;
                }
                field(CashierID; Rec.CashierID)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Clearing Bank"; Rec."Cheque Clearing Bank")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Bankers Cheque Clearing Bank"; Rec."Bankers Cheque Clearing Bank")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("EFT/RTGS Bank"; Rec."EFT/RTGS Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Type"; Rec."Bank Type") { ApplicationArea = all; }
                field("Bank Category"; Rec."Bank Category") { }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify("Detail Trial Balance")
        {
            Caption = 'CashBook Report';
        }
    }

    var
        myInt: Integer;
}
pageextension 50010 BankPageExt extends "Bank Account List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify("Detail Trial Balance")
        {
            Caption = 'CashBook Report';
        }
    }

    var
        myInt: Integer;
}


