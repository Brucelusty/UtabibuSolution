xmlport 80000 "JournalImport"
{
    schema
    {
        
             //Format = VariableText;
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'table';
                fieldelement(A; "Gen. Journal Line"."Journal Template Name")
                {

                }
                fieldelement(B; "Gen. Journal Line"."Posting Date")
                {

                }
                fieldelement(C; "Gen. Journal Line"."Journal Batch Name")
                {

                }
                fieldelement(D; "Gen. Journal Line"."Document No.")
                {

                }
                fieldelement(E; "Gen. Journal Line".Description)
                {

                }
                fieldelement(F; "Gen. Journal Line"."Account Type")
                {

                }
                fieldelement(G; "Gen. Journal Line"."Account No.")
                {

                }
                fieldelement(H; "Gen. Journal Line"."Transaction Type")
                {

                }
                fieldelement(I; "Gen. Journal Line".Amount)
                {

                }
                fieldelement(J; "Gen. Journal Line"."Shortcut Dimension 1 Code")
                {

                }
                fieldelement(K; "Gen. Journal Line"."Shortcut Dimension 2 Code")
                {

                }
                fieldelement(L; "Gen. Journal Line"."Line No.")
                {

                }

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
                action(ActionName)
                {

                }
            }
        }
    }

    var
        myInt: Integer;
}