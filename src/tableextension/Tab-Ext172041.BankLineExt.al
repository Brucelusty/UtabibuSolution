//************************************************************************
tableextension 172041 "BankLineExt" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        // Add changes to table fields here
        field(172004; "Open Type"; Option)
        {
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = " ",Unpresented,Uncredited;
        }
        field(172005; "Bank Ledger Entry Line No"; Integer)
        {
        }
        field(172006; "Bank Statement Entry Line No"; Integer)
        {
        }
        field(172007; Reversed; Boolean)
        {
        }
        field(172008; "Reconciling Date"; Date)
        {
        }
        field(5151600; Reconciled; Boolean)
        {

        }
        field(5151601; DocumentNo; Code[100])
        {

        }

    }

    var
        myInt: Integer;
}


