//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17207 "Account Signatories Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "FOSA Account Sign. Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No.";Rec."Member No.")
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
                field("Mobile No";Rec."Mobile No")
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
                field("Expiry Date";Rec."Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address";Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Limit Amount";Rec."Limit Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control5;"Account Signatorie Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                SubPageLink = "Document No" = field("Document No");
            }
            part(Control4;"Account Signator Signature")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "Document No" = field("Document No");
            }
        }
    }

    actions
    {
    }
}




