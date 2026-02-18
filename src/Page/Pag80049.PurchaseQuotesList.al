page 80049 "Purchase Quotes List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Header";
    CardPageId = "Purchase QuoteV";
    SourceTableView = where("Document Type" = const(Quote),
                            "AU Form Type" = filter('Purchase Quotes'),"LPO Awarded"=filter(false),"LPO Not Awarded"=filter(false));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.") { ApplicationArea = ALL; }
                field("Buy-from Vendor No.";Rec."Buy-from Vendor No."){Caption='Vendor No';}
                field("Buy-from Vendor Name";Rec."Buy-from Vendor Name"){Caption='Vendor Name';}
                field("RFQ No";Rec."RFQ No"){}
                field("Posting Description";Rec."Posting Description"){}
                field("Amount Including VAT";Rec."Amount Including VAT"){}
                //field("AU Form Type";Rec."AU Form Type"){ApplicationArea=all;}
              
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code") { ApplicationArea = all;Visible = false; }
                field("Responsibility Center"; Rec."Responsibility Center") { ApplicationArea = all;Visible = false; Enabled = false; Caption = 'Department'; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = all; Visible = false; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = all; Caption = 'Date'; }
                field("AU Form Type"; Rec."AU Form Type") { ApplicationArea = all; Visible = false; }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //Rec.SetRange("User ID", UserId);
    end;
}