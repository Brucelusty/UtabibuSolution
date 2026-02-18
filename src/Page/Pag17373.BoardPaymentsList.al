page 17373 "Board Payments List"
{
    ApplicationArea = All;
    Caption = 'Board Payments List';
    PageType = List;
    SourceTable = "Boad Payments Allowance";
    UsageCategory = Tasks;
    CardPageId = "Board Payments Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Paying Bank"; Rec."Paying Bank")
                {
                    ToolTip = 'Specifies the value of the Paying Bank field.';
                    Editable = false;
                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {
                    ToolTip = 'Specifies the value of the Paying Bank Name field.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {

                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        // BankLedgerEntry.Reset();
        // BankLedgerEntry.SetRange("Document No.", Rec.No);
        // if BankLedgerEntry.Find('-') then begin
        //     repeat
        //         BankLedgerEntry."Posting Date" := Rec."Posting Date";
        //         BankLedgerEntry.Modify(true);
        //     until BankLedgerEntry.Next() = 0;
        // end;
        // GLEntry.Reset();
        // GLEntry.SetRange("Document No.", Rec.No);
        // if GLEntry.Find('-') then begin
        //     repeat
        //         GLEntry."Posting Date" := Rec."Posting Date";
        //         GLEntry.Modify(true);
        //     until GLEntry.Next() = 0;
        // end;

        // CustomerLedgerEntry.Reset();
        // CustomerLedgerEntry.SetRange("Document No.", Rec.No);
        // if CustomerLedgerEntry.Find('-') then begin
        //     repeat
        //         CustomerLedgerEntry."Posting Date" := Rec."Posting Date";
        //         CustomerLedgerEntry.Modify(true);
        //     until CustomerLedgerEntry.Next() = 0;
        // end;

        // DetailedLederEntry.Reset();
        // DetailedLederEntry.SetRange("Document No.", Rec.No);
        // if DetailedLederEntry.Find('-') then begin
        //     repeat
        //         DetailedLederEntry."Posting Date" := Rec."Posting Date";
        //         DetailedLederEntry.Modify(true);
        //     until DetailedLederEntry.Next() = 0;
        // end;
    end;

    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        GLEntry: Record "G/L Entry";

        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        DetailedLederEntry: Record "Detailed Cust. Ledg. Entry";
}
