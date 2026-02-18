//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50097 "Payment Lines"
{
    PageType = ListPart;
    SourceTable = "Payment Line";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Type; rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
              
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; Rec."Loan No.")
                {
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
              
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = Basic;

                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = Basic;

                }
                field("VAT Rate"; Rec."VAT Rate")
                {
                    ApplicationArea = Basic;

                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("W/Tax Rate"; Rec."W/Tax Rate")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        rec.TestField("Global Dimension 1 Code");
                        rec.TestField("Shortcut Dimension 2 Code");
                        if Rec."Transaction Type" = Rec."Transaction Type"::"Disbursment Account" then begin
                            if rec.Amount > Rec."Disbusment Amount" then begin
                                Error('the available amount to disburse is %1', Rec."Disbusment Amount");
                            end;

                        end;
                        //check if the payment reference is for farmer purchase
                        if rec."Payment Reference" = rec."payment reference"::"Farmer Purchase" then begin
                            if rec.Amount <> xRec.Amount then begin
                                Error('Amount cannot be modified');
                            end;
                        end;

                        rec."Amount With VAT" := rec.Amount;


                    end;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = Basic;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                }
                field("Disbusment Amount"; Rec."Disbusment Amount")
                {

                }

            }
        }
    }

    actions
    {
    }

    var
        RecPayTypes: Record Logos;
        TarriffCodes: Record "Item Groups";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Quote Specifications";
        LineNo: Integer;
        CustLedger: Record "Vendor Ledger Entry";
        CustLedger1: Record "Vendor Ledger Entry";
        Amt: Decimal;
        TotAmt: Decimal;
        ApplyInvoice: Codeunit "Purchase Header Apply";
        AppliedEntries: Record "Payments Header";
        VendEntries: Record "Vendor Ledger Entry";
        PInv: Record "Purch. Inv. Header";
        VATPaid: Decimal;
        VATToPay: Decimal;
        PInvLine: Record "Purch. Inv. Line";
        VATBase: Decimal;
}




