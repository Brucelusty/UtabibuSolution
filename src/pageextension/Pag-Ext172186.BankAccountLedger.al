pageextension 172186 "Bank Account Ledger" extends "Bank Account Ledger Entries"
{

    layout
    {
        // Add changes to page layout here
        addafter("Document No.")
        {
            // field("Transactional code"; Rec."Transactional code") { }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
                Caption = 'Ref/Cheque No';
            }



        }



    }

    actions
    {
        modify("Reverse Transaction")
        {
            Visible = FALSE;
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}




