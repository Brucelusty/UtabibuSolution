// pageextension 172184 "BankReconLineExt" extends "Bank Acc. Reconciliation"

// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter(StatementEndingBalance)
//         {
//             field("Difference Btw Statement"; Rec."Difference Btw Statement")
//             {
//                 ApplicationArea = all;
//                 Enabled = false;
//                 Visible = false;
//             }

//             field(TotalReconciled; Rec.TotalReconciled) { ApplicationArea = all; Enabled = false; Visible = false; }
//             field(Unreconciled; Rec.Unreconciled) { ApplicationArea = all; Enabled = false; Visible = false; }

//         }
//         modify(ApplyBankLedgerEntries)
//         {
//             Visible = false;
//         }
//     }

//     actions
//     {

//         // Add changes to page actions here
//         addafter("P&osting")
//         {
//             action("Reconciliation Report")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Reconciliation Report';
//                 Ellipsis = true;
//                 Promoted = true;
//                 PromotedCategory = Report;
//                 Image = Report;
//                 ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';
//                 trigger OnAction()
//                 var
//                     BankAccountStatement: Record "Bank Acc. Reconciliation";
//                 begin
//                     BankAccountStatement.RESET;
//                     BankAccountStatement.SETRANGE("Bank Account No.", rec."Bank Account No.");
//                     BankAccountStatement.SETRANGE("Statement No.", rec."Statement No.");
//                     IF BankAccountStatement.FINDFIRST THEN
//                         REPORT.RUN(50059, TRUE, FALSE, BankAccountStatement);

//                 end;
//             }
//         }
//     }



//     var
//         myInt: Integer;
// }