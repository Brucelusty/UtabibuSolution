//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17211 "Product App Signatories Card"
{
    PageType = Card;
    SourceTable = "Product App Signatories";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No.";Rec."BOSA No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll";Rec."Staff/Payroll")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Signatory; Rec.Signatory)
                {
                    ApplicationArea = Basic;
                }
                field("Must Sign";Rec."Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field("Must be Present";Rec."Must be Present")
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date";Rec."Expiry Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Account Signatorie Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Document No" = field("Document No");
            }
            part(Control2; "Account Signator Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                SubPageLink = "Document No" = field("Document No");
            }
        }
    }

    actions
    {
    }
}




