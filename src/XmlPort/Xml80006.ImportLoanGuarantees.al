xmlport 80006 "Import Loan Guarantees"
{
    Caption = 'Import Loan Guarantees';


    Direction = Import;

    Format = VariableText;


    schema
    {
        textelement(root)
        {
            XmlName = 'ImportData';
            tableelement(DetailedCustLedgEntry; "Loans Guarantee Details")
            {


                fieldelement(CustLedgerEntryNo; DetailedCustLedgEntry."Loan No")
                {
                }

                fieldelement(EntryType; DetailedCustLedgEntry."Member No") { }
                fieldelement(EntryNo; DetailedCustLedgEntry."Entry No.")
                {
                }
                fieldelement(PostingDate; DetailedCustLedgEntry.Name)
                {
                }
                fieldelement(DocumentNo; DetailedCustLedgEntry.Substituted)
                {
                }

                fieldelement(Amount; DetailedCustLedgEntry."Amont Guaranteed")
                {
                }
                fieldelement(RemainingAmount; DetailedCustLedgEntry."Self Guarantee") { }
                fieldelement(AmountLCY; DetailedCustLedgEntry."ID No.")
                {
                }

                fieldelement(CustomerNo; DetailedCustLedgEntry."Free Shares")
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

