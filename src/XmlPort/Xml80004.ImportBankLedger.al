
xmlport 80004 "Import Bank Ledger"
{
    Direction = Import;
    Caption = 'Import Bank Ledger Ledger';
    Format = VariableText;


    schema
    {
        textelement(root)
        {
            XmlName = 'ImportData';
            tableelement(CustLedgerEntry; "Detailed Cust. Ledg. Entry")
            {
                XmlName = 'Imports';
                fieldelement(A; CustLedgerEntry."Entry No.") { }
                fieldelement(B; CustLedgerEntry."Cust. Ledger Entry No.") { }
                fieldelement(C; CustLedgerEntry."Entry Type") { }
                fieldelement(D; CustLedgerEntry."Posting Date") { }
                fieldelement(E; CustLedgerEntry."Document No.") { }
                fieldelement(F; CustLedgerEntry.Amount) { }
                fieldelement(G; CustLedgerEntry."Amount (LCY)") { }
                fieldelement(H; CustLedgerEntry."Customer No.") { }
                fieldelement(I; CustLedgerEntry."Transaction No.") { }
                fieldelement(J; CustLedgerEntry."Debit Amount") { }
                fieldelement(K; CustLedgerEntry."Credit Amount") { }
                fieldelement(L; CustLedgerEntry."Debit Amount (LCY)") { }
                fieldelement(M; CustLedgerEntry."Credit Amount (LCY)") { }
                fieldelement(N; CustLedgerEntry."Initial Entry Due Date") { }
                fieldelement(O; CustLedgerEntry."Ledger Entry Amount") { }
                fieldelement(P; CustLedgerEntry."Transaction Type") { }
                fieldelement(Q; CustLedgerEntry."Loan No") { }

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

