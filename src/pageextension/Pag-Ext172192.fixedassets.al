pageextension 172192 "fixed assets " extends "Fixed Asset Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Serial No.")
        {
            field("Tag No"; Rec."Tag No")
            {
                ApplicationArea = all;
            }
            field("Supplier Name"; Rec."Supplier Name")
            {
                ApplicationArea = all;
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = all;
            }
            field("Asset Disposal/Writeoff Date"; Rec."Asset Disposal/Writeoff Date")
            {
                ApplicationArea = all;
            }
            field(Custodian; Rec.Custodian)
            {
                ApplicationArea = all;
            }
            field("Custodian Name"; Rec."Custodian Name")
            {
                ApplicationArea = all;
            }
            field("Transaction Date"; Rec."Transaction Date")
            {
                ApplicationArea = all;
                Caption = 'Purcahse Date';
            }
            field("Payment Details"; Rec."Payment Details")
            {
                ApplicationArea = all;
            }
            field(Comment; Rec.Comment) { }
          


        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}



