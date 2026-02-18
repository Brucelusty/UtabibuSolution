page 17448 "Bank Acc. Recon List Conv"
{
    Caption = 'Bank Acc. Reconciliation List';
    CardPageID = "Bank Acc. Reconciliation Conv";
    Editable = false;
    PageType = List;
    DeleteAllowed = false;
    SourceTable = "Bank Acc. Reconciliation";
    SourceTableView = WHERE("Statement Type" = CONST("Bank Reconciliation"));

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(BankAccountNo; Rec."Bank Account No.")
                {
                }
                field(StatementNo; Rec."Statement No.")
                {
                }
                field(StatementDate; Rec."Statement Date")
                {
                }
                field(BalanceLastStatement; Rec."Balance Last Statement")
                {
                }
                field(StatementEndingBalance; Rec."Statement Ending Balance")
                {
                }
            }
        }
        area(factboxes)
        {
            // systempart(; Links)
            // {
            //     Visible = false;
            // }
            // systempart(; Notes)
            // {
            //     Visible = false;
            // }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 371;
                    ShortCutKey = 'F9';
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 372;
                    ShortCutKey = 'Shift+F9';
                }
            }
        }
    }
}

