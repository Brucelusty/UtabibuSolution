//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172548 "Account Agent Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Account Agent Details";

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
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No.";Rec."BOSA No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Agent Member No';
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                    Caption = 'Agent Name';
                }
                field("Mobile No.";Rec."Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address";Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth";Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Balance Enquiry";Rec."Allowed Balance Enquiry")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed  Correspondence";Rec."Allowed  Correspondence")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed FOSA Withdrawals";Rec."Allowed FOSA Withdrawals")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Loan Processing";Rec."Allowed Loan Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Cheque Processing";Rec."Allow Cheque Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Operation Instruction";Rec."Operation Instruction")
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
            part(Control2; "Account Agent Picture-Uploaded")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Document No" = field("Document No");
            }
            part(Control1; "Account AgenSignatory-Uploaded")
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

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //"Entry No":=10000+1;
    end;
}




