// tableextension 50000 "BankReconExtensin" extends "Bank Acc. Reconciliation"

// {
//     fields
//     {
//         // Add changes to table fields here
//         field(172000; Unreconciled; Decimal)
//         {
//             //DataClassification = ToBeClassified;
//             FieldClass = FlowField;
//             CalcFormula = sum("Bank Acc. Reconciliation Line"."Applied Amount" where("Bank Account No." = field("Bank Account No."), Reconciled = filter(false)));
//         }

//         field(172001; TotalReconciled; Decimal)
//         {
//             //DataClassification = ToBeClassified;
//             ///TableRelation = "Bank Account Ledger Entry";
//             FieldClass = FlowField;
//             CalcFormula = sum("Bank Acc. Reconciliation Line"."Applied Amount" where("Bank Account No." = field("Bank Account No."), Reconciled = filter(true)));
//             //CalcFormula = sum("Bank Account Ledger Entry");
//         }
//         field(172003; "Difference Btw Statement"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         modify("Statement Ending Balance")
//         {
//             trigger OnAfterValidate()
//             begin
//                 CalcFields(TotalReconciled, Unreconciled);
//                 "Difference Btw Statement" := "Statement Ending Balance" - ("Balance Last Statement" + TotalReconciled + Unreconciled);
//                 if "Difference Btw Statement" <> 0 then
//                     Error('Reconciliation failed! Difference: %1', "Difference Btw Statement");
//             end;
//         }
//     }

//     var
//         myInt: Integer;
// }