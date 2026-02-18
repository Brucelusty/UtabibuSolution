//************************************************************************
page 17212 "Product App Signatories"
{
    // version FOSA ManagementV1.0(Surestep Systems)

    CardPageID = "Product App Signatories Card";
    Editable = false;
    PageType = Card;
    SourceTable = "Product App Signatories";

    layout
    {
        area(content)
        {
            repeater(Content2)
            {
                field("Account No";Rec."Account No")
                {
                }
                field("Document No";Rec."Document No")
                {
                    trigger OnValidate()
                    begin
                        DocNo := Rec."Document No";
                    end;

                }
                field("Staff/Payroll";Rec."Staff/Payroll")
                {
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                    Caption = 'Staff/Payroll No';
                }
                field(Names; Rec.Names)
                {
                }
                field("ID No.";Rec."ID No.")
                {
                }
                field(Signatory; Rec.Signatory)
                {
                }
                field("Must Sign";Rec."Must Sign")
                {
                }
                field(Signature; Rec.Signature)
                {
                }

                field("Expiry Date";Rec."Expiry Date")
                {
                    Editable = false;
                }
                field("BOSA No.";Rec."BOSA No.")
                {
                }
                field(DocNo; DocNo)
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Picture; "Account Agent Picture-App")
            {
                //  SubPageLink =   = field("Document No");


            }
            part(Signature1; "Account Agent Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                // SubPageLink = "Document No" = FIELD("Document No");
            }
        }
    }

    actions
    {

    }

    trigger OnOpenPage()
    begin
        MemberApp.RESET;
        MemberApp.SETRANGE(MemberApp."No.", Rec."Document No");
        IF MemberApp.FIND('-') THEN BEGIN
            IF MemberApp.Status = MemberApp.Status::Approved THEN BEGIN
                CurrPage.EDITABLE := FALSE;
            END ELSE
                CurrPage.EDITABLE := TRUE;
        END;
    end;

    var
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
        CUST: Record Customer;
        DocNo: code[40];
}




