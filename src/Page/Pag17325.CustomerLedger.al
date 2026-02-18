page 17325 CustomerLedger
{
    ApplicationArea = All;
    Caption = 'CustomerLedger';
    PageType = List;
    SourceTable = "Cust. Ledger Entry";
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Imports';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the amount of the entry.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the customer account number that the entry is linked to.';
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Import Data")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Import customer';
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction();
                begin
                    Xmlport.Run(80002, true, true);
                end;
            }
            action("Import Data2")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Import Detailed Ledger';
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction();
                begin
                    Xmlport.Run(80004, false, true);
                end;
            }
            action("Import Data24")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Import Bank Ledger';
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction();
                begin
                    Xmlport.Run(80003, false, true);
                end;
            }
            action("Import Data25")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Import G_LEntry';
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction();
                begin
                    Xmlport.Run(80005, false, true);
                end;
            }
            action("Import Data253")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Import Loan Guarantors';
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction();
                begin
                    Xmlport.Run(80006, false, true);
                end;
            }
        }
    }

}

