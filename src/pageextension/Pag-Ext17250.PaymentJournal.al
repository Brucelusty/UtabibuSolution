pageextension 17250 "Payment Journal" extends "Payment Journal"
{
    layout
    {
        addafter("Bal. Account No.")
        {
            field("Transaction Type"; Rec."Transaction Type")
            {

            }
            field("Loan No"; Rec."Loan No")
            {

            }
        }
    }
}
