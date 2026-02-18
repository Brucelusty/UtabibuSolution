#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50501 "MpesaPESA Paybill"
{
    // Encoding = UTF8;
    Format = VariableText;
    FormatEvaluate = Legacy;
    PreserveWhiteSpace = true;
    TextEncoding = UTF8;

    schema
    {
        textelement("<paybilltran>")
        {
            XmlName = 'PAYBILLTRAN';
            tableelement("MpesaMPESA Trans"; "MOBILE MPESA Trans")
            {
                AutoUpdate = true;
                XmlName = 'PAYBILL';
                fieldelement(A; "MpesaMPESA Trans"."Document No")
                {
                }
                fieldelement(F; "MpesaMPESA Trans".Amount)
                {
                }
                fieldelement(H; "MpesaMPESA Trans"."Paybill Acc Balance")
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

