pageextension 172185 "PayablesSetup" extends "Purchases & Payables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posted Credit Memo Nos.")
        {
            field("Requisition No"; Rec."Requisition No") { ApplicationArea = all; }
            field("Tender Request No"; Rec."Tender Request No") { Caption = 'Purchase Quotes Nos'; ApplicationArea = all; }
            field("Quotation Request No"; Rec."Quotation Request No") { ApplicationArea = all; }
            field("Requisition Default Vendor"; Rec."Requisition Default Vendor") { ApplicationArea = all; }
            field("Vendor Posting Group"; Rec."Vendor Posting Group") { ApplicationArea = all; }
            field("Board Payments"; Rec."Study Form Nos") { ApplicationArea = all; }
            field("Stores Requisition No"; Rec."Stores Requisition No") { ApplicationArea = all; }
            field("Stores Issue No"; Rec."Stores Issue No") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}