page 17327 "Paymet Request Lines"
{
    ApplicationArea = All;
    Caption = 'Paymet Request Lines';
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
                

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }



                field(Amount; rec.Amount)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        rec.TestField("Global Dimension 1 Code");
                        rec.TestField("Shortcut Dimension 2 Code");
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


                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic;
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




