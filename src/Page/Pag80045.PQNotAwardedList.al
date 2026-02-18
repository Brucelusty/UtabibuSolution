page 80045 "PQ Not Awarded List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Header";
    CardPageId = "Purchase QuoteV";
    SourceTableView = where("Document Type" = const(Quote),
                            "AU Form Type" = filter('Purchase Quotes'), "LPO Awarded" = filter(false));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.") { ApplicationArea = ALL; }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code") { ApplicationArea = all; }
                field("Responsibility Center"; Rec."Responsibility Center") { ApplicationArea = all; Enabled = false; Caption = 'Department'; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = all; Visible = false; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = all; Caption = 'Date'; }
                field("AU Form Type"; Rec."AU Form Type") { ApplicationArea = all; Visible = true; }
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