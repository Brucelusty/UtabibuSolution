pageextension 172183 "BankAccotReclins" extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        addafter(Difference)
        {
            field(Reconciled; Rec.Reconciled){ApplicationArea=all;}
    }
        }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}