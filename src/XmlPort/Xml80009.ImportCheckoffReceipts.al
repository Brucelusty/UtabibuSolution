XmlPort 80009 "Import Checkoff Receipts"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Receipts Processing Lines";"Receipts Processing Lines")
            {
                XmlName = 'ReceiptProcessingLines';
                fieldelement(ReceiptLineNo;"Receipts Processing Lines"."Receipt Line No")
                {
                }
                fieldelement(StaffNo;"Receipts Processing Lines"."Staff/Payroll No")
                {
                }
                fieldelement(Amount;"Receipts Processing Lines".Amount)
                {
                }
                fieldelement(ReceiptHeaderNo;"Receipts Processing Lines"."Receipt Header No")
                {
                }
                fieldelement(EmployerCode;"Receipts Processing Lines"."Employer Code")
                {
                }
                fieldelement(TransType;"Receipts Processing Lines"."Trans Type")
                {
                }
                fieldelement(Principle_Interest;"Receipts Processing Lines"."Principle/Interest")
                {
                    MinOccurs = Zero;
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

