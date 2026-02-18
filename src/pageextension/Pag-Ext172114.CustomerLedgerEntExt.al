//************************************************************************
pageextension 172114 "CustomerLedgerEntExt" extends "Customer Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Transaction Type";Rec."Transaction Type")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Loan No";Rec."Loan No")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Loan Type";Rec."Loan Type")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;

            }
            field("Final Amount";Rec."Final Amount")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;

            }
            field("Transaction Amount";Rec."Transaction Amount")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;

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


