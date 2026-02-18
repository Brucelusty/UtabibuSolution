xmlport 80002 "Import customer"
{
    Direction = Import;
    Caption = 'Import Customer Ledger';
    Format = VariableText;


    schema
    {
        textelement(root)
        {
            XmlName = 'ImportData';
            tableelement(CustLedgerEntry; "Cust. Ledger Entry")
            {
                XmlName = 'Imports';
                fieldelement(A; CustLedgerEntry."Entry No.") { }
                fieldelement(B; CustLedgerEntry."Customer No.") { }
                fieldelement(C; CustLedgerEntry."Posting Date") { }
                fieldelement(D; CustLedgerEntry."Document No.") { }
                fieldelement(E; CustLedgerEntry.Description) { }
                fieldelement(F; CustLedgerEntry."Transaction No.") { }
                fieldelement(G; CustLedgerEntry."Document Date") { }
                fieldelement(H; CustLedgerEntry."External Document No.") { }
                fieldelement(I; CustLedgerEntry."Loan No") { }
                fieldelement(J; CustLedgerEntry."Transaction Type") { }

            }

        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
