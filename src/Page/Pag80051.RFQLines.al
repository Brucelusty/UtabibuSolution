page 80051 "RFQ Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Line";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type) { ApplicationArea = all; Enabled = false; Visible = true; }
                field(Description; Rec.Description) { ApplicationArea = all; Caption = 'GL Account '; Enabled = false; }
                field(Description2; Rec."Description 2") { ApplicationArea = all; Caption = 'Item Specification'; Enabled = false; }
                field("Document No."; Rec."Document No.") { ApplicationArea = all; Visible = false; }
                field("Document Type"; Rec."Document Type") { ApplicationArea = all; Visible = false; }
                field("Line No."; Rec."Line No.") { ApplicationArea = all; Visible = false; }

                field("No."; Rec."No.") { ApplicationArea = all; Enabled = false; Visible = false; }

                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Item Description';
                    Visible = false;


                }

                field(Quantity; Rec.Quantity) { ApplicationArea = all; }
                field("Unit of Measure"; Rec."Unit of Measure") { }
                //field("Direct Unit Cost"; Rec."Direct Unit Cost") { ApplicationArea = all; }
                //field(Amount; Rec.Amount) { ApplicationArea = all; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = all; Editable = true; Visible = true; }


            }
        }
    }



    var
        myInt: Integer;
        ApprovalMgt: Codeunit "Approvals Mgmt.";
}