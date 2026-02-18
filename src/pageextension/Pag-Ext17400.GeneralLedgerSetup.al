pageextension 17400 GeneralLedgerSetup extends "General Ledger Setup"
{
    layout
    {
        addafter(PostingPreviewType)
        {
            field("Transaction Document No"; Rec."Transaction Document No")
            {

            }
        }
    }
}
