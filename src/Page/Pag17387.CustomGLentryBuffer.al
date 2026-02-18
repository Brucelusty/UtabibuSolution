//************************************************************************
page 17387 "CustomGLentryBuffer"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customglentrybuffer;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No.";Rec."Entry No.")
                {
                    ApplicationArea = All;

                }
                field("Document No.";Rec."Document No.")
                {
                    ApplicationArea = All;

                }
                field("Document Date";Rec."Document Date")
                {
                    ApplicationArea = All;

                }
                field("Posting Date";Rec."Posting Date")
                {
                    ApplicationArea = All;

                }
                field("Gen. Posting Type";Rec."Gen. Posting Type")
                {
                    ApplicationArea = All;

                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;

                }
                field("Bal. Account Type";Rec."Bal. Account Type")
                {
                    ApplicationArea = All;

                }
                field("Bal. Account No.";Rec."Bal. Account No.")
                {
                    ApplicationArea = All;

                }
                field("Credit Amount";Rec."Credit Amount")
                {
                    ApplicationArea = All;

                }
                field("Debit Amount";Rec."Debit Amount")
                {
                    ApplicationArea = All;

                }
                field("Gen. Bus. Posting Group";Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;

                }
                field("Gen. Prod. Posting Group";Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;

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


