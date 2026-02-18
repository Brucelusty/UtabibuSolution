xmlport 80005 "Import Gl Entry"
{
    Caption = 'Import Gl Entry';

    Direction = Import;

    Format = VariableText;


    schema
    {
        textelement(root)
        {
            XmlName = 'ImportData';
            tableelement(DetailedCustLedgEntry; "G/L Entry")
            {

                fieldelement(EntryNo; DetailedCustLedgEntry."Entry No.")
                {
                }
                fieldelement(CustLedgerEntryNo; DetailedCustLedgEntry."G/L Account No.")
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
                fieldelement(RemainingAmount; DetailedCustLedgEntry."Transaction No.") { }
                fieldelement(AmountLCY; DetailedCustLedgEntry."Debit Amount")
                {
                }

                fieldelement(CustomerNo; DetailedCustLedgEntry."Credit Amount")
                {
                }
                fieldelement(positive; DetailedCustLedgEntry."Document Date") { }
                fieldelement(TransactionNo; DetailedCustLedgEntry."External Document No.")
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

