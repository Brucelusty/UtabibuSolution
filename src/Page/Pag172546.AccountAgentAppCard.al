//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172546 "Account Agent App Card"
{
    PageType = Card;
    SourceTable = "Account Agents App Details";

    layout
    {
        area(content)
        {
            group(General)
            {
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
                field("ID No.";Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No.";Rec."Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address";Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth";Rec."Date Of Birth")
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
                field("Expiry Date";Rec."Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control7; "Account Agent Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
            }
            part(Control8; "Account Agent Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
            }
        }
    }

    actions
    {
    }
}




