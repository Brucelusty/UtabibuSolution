xmlport 80003 "Import Detailed Ledger"
{
    Direction = Import;
    Caption = 'Import Detailed Ledger';
    Format = VariableText;


    schema
    {
        textelement(root)
        {
            XmlName = 'ImportData';
            tableelement(DetailedCustLedgEntry; "Bank Account Ledger Entry")
            {

                fieldelement(EntryNo; DetailedCustLedgEntry."Entry No.")
                {
                }
                fieldelement(CustLedgerEntryNo; DetailedCustLedgEntry."Bank Account No.")
                {
                }




                fieldelement(EntryType; DetailedCustLedgEntry."Posting Date") { }
                fieldelement(PostingDate; DetailedCustLedgEntry."Document No.")
                {
                }
                fieldelement(DocumentNo; DetailedCustLedgEntry.Description)
                {
                }

                fieldelement(Amount; DetailedCustLedgEntry.Amount)
                {
                }
                fieldelement(RemainingAmount; DetailedCustLedgEntry."Remaining Amount") { }
                fieldelement(AmountLCY; DetailedCustLedgEntry."Amount (LCY)")
                {
                }

                fieldelement(CustomerNo; DetailedCustLedgEntry.Open)
                {
                }
                fieldelement(positive; DetailedCustLedgEntry.Positive) { }
                fieldelement(TransactionNo; DetailedCustLedgEntry."Transaction No.")
                {
                }
                fieldelement(StatemetntStatus; DetailedCustLedgEntry."Statement Status") { }
                fieldelement(DebitAmount; DetailedCustLedgEntry."Debit Amount")
                {
                }
                fieldelement(CreditAmount; DetailedCustLedgEntry."Credit Amount")
                {
                }
                fieldelement(DebitAmountLCY; DetailedCustLedgEntry."Debit Amount (LCY)")
                {
                }
                fieldelement(CreditAmountLCY; DetailedCustLedgEntry."Credit Amount (LCY)")
                {
                }




                fieldelement(InitialEntryDueDate; DetailedCustLedgEntry."Document Date")
                {
                }
                fieldelement(LedgerEntryAmount; DetailedCustLedgEntry."External Document No.")
                {
                }


                fieldelement(TransactionType; DetailedCustLedgEntry.Reversed)
                {
                }

            }
        }
    }
    requestpage
    {
        layout
        {

        }
        actions
        {

        }
    }
}
