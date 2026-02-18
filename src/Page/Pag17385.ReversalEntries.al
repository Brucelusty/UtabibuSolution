//************************************************************************
page 17385 "Reversal Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Reversal Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No.";Rec."Entry No.")
                {
                    ApplicationArea = All;

                }
                field("Entry Type";Rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Account No.";Rec."Account No.")
                {
                    ApplicationArea = all;
                }
                field("Document Type";Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Source Type";Rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Source No.";Rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Source Code";Rec."Source Code")
                {
                    ApplicationArea = all;
                }
                field("Transaction No.";Rec."Transaction No.")
                {
                    ApplicationArea = all;
                }
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
}
