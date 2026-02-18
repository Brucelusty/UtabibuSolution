//************************************************************************
pageextension 172113 "CustPostingGroupext" extends "Customer Posting Groups"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {

            field("Shares Deposits Account";Rec."Shares Deposits Account")
            {

            }
            field("Registration Fees Account";Rec."Registration Fees Account")
            {

            }
            field("Dividend Account";Rec."Dividend Account")
            {

            }
            field("Withdrawal Fee";Rec."Withdrawal Fee")
            {

            }
            field("Investment Account";Rec."Investment Account")
            {


            }
            field("Un-allocated Funds Account";Rec."Un-allocated Funds Account")
            {


            }
            field("Prepayment Account";Rec."Prepayment Account")
            {

            }
            field("Withdrawable Deposits";Rec."Withdrawable Deposits")
            {



            }
            field("Loan Form Fee";Rec."Loan Form Fee")
            {

            }
            field("Passbook Fee";Rec."Passbook Fee")
            {

            }
            field("Risk Fund Charged Account";Rec."Risk Fund Charged Account")
            {

            }
            field("Risk Fund Paid Account";Rec."Risk Fund Paid Account")
            {

            }
            field("Group Shares";Rec."Group Shares")
            {

            }
            field("Savings Account";Rec."Savings Account")
            {

            }
            field("Shares Capital Account";Rec."Shares Capital Account")
            {

            }
            field("Insurance Fund Account";Rec."Insurance Fund Account")
            {

            }
            field("Benevolent Fund Account";Rec."Benevolent Fund Account")
            {

            }
            field("Recovery Account";Rec."Recovery Account")
            {

            }
            field("FOSA Shares";Rec."FOSA Shares")
            {

            }
            field("Additional Shares";Rec."Additional Shares")
            {

            }
            field("Junior Savings Account";Rec."Junior Savings Account")
            {

            }
            field("Safari Savings Account";Rec."Safari Savings Account")
            {

            }
            field("Silver Savings Account";Rec."Silver Savings Account")
            {

            }


        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}


