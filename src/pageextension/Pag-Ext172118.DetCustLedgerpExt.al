//************************************************************************
pageextension 172118 "DetCustLedgerpExt" extends "Detailed Cust. Ledg. Entries"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {

            field(Description; Rec.Description) { }
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Loan No"; Rec."Loan No")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Loan Type"; Rec."Loan Type")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;

            }
            field(Reversed; Rec.Reversed)
            {
                ApplicationArea = basic;
            }
            // field("Loan No";"Loan No"){}
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}


