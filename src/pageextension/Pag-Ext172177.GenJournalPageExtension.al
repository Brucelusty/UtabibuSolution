//************************************************************************
pageextension 172177 "GenJournalPageExtension" extends "General Journal"
{
    layout
    {

        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;

        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
        // Add changes to page layout here
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify(Comment)
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = true;
        }
        addbefore(Amount)
        {
            field("DebitAmount"; Rec."Debit Amount") { }
            field("CreditAmount"; Rec."Credit Amount") { }

        }

        addlast(Control1)
        {
            field("Transaction Type"; Rec."Transaction Type")
            {

            }
            field("Loan No"; Rec."Loan No")
            {

            }
            field("Loan Product Type"; Rec."Loan Product Type") { }


            field("Line No."; Rec."Line No.")
            { }
            field(GeneralPostingType; Rec."Gen. Posting Type") { }
            field("VAT ProdPosting Group"; Rec."VAT Prod. Posting Group") { }
            field("VATBusPosting Group"; Rec."VAT Bus. Posting Group") { }



        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(PostAndPrint)
        {
            //  /action("Account closure Slip")
            action("Import Journal")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Import Csvs';
                Promoted = true;
                Image = Import;
                PromotedCategory = Process;
                RunObject = xmlport "Import Journals";
            }

            action("Import Loans Journal")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Import Loans Csvs';
                Promoted = true;
                Image = Import;
                PromotedCategory = Process;
                RunObject = xmlport "Import Loans Journals";
            }


        }
    }

    // trigger OnOpenPage()
    // begin
    //     if cust.Get(Rec."Account No.") then begin
    //         if cust.ISNormalMember then begin
    //             Rec.ISNormalMember := true;
    //             Rec.Modify(true);
    //         end;
    //     end;
    // end;

    // trigger OnAfterGetRecord()
    // begin
    //     if cust.GET(Rec."Account No.") then begin
    //         if cust.ISNormalMember then begin
    //             Rec.ISNormalMember := true;
    //             Rec.Modify(true);
    //         end;
    //     end;
    // end;

    var
        myInt: Integer;
        cust: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";

}

pageextension 17350 "General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("Debit Amount2"; Rec."Debit Amount")
            { }
            field("Credit Amount2"; Rec."Credit Amount")
            { }
        }

        // Add changes to page layout here
        addafter("Entry No.")
        {

            field("Source No2."; Rec."Source No.")
            {

            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}


