// report 80056 "Batch Merge Defaulter Loans"
// {
//     ProcessingOnly = true;
//     ApplicationArea = All;
//     UsageCategory = Tasks;
//     RDLCLayout = 'Layouts/mergeDefaulter.rdlc';

//     dataset
//     {
//         dataitem(Customer; Customer)
//         {
//             trigger OnAfterGetRecord()
//             var
//                 LoanRec: Record "Loans Register";
//                 ClientLoans: Record "Loans Register";
//                 MasterLoan: Record "Loans Register";
//                 MasterLoanNo: Code[20];

//                 TotalOutstanding: Decimal;
//                 TotalInterest: Decimal;
//                 TotalPenalty: Decimal;

//                 LoanCount: Integer;
//             begin

//                 LoanRec.Reset();
//                 LoanRec.SetRange("Client Code", Customer."No.");
//                 LoanRec.SetRange("Loan Product Type", 'DEFAULTER');
//                 // Include both Disbursed and Closed
//                 LoanRec.SetFilter("Loan Status", '%1|%2',
//                     LoanRec."Loan Status"::Disbursed,
//                     LoanRec."Loan Status"::Closed);

//                 if LoanRec.FindSet() then begin
//                     LoanCount := 0;
//                     Clear(TotalOutstanding);
//                     Clear(TotalInterest);
//                     Clear(TotalPenalty);

//                     // Pick the first loan as master
//                     MasterLoan := LoanRec;
//                     MasterLoanNo := MasterLoan."Loan  No.";

//                     repeat
//                         LoanRec.CalcFields("Outstanding Balance", "Outstanding Interest");

//                         LoanCount += 1;
//                         TotalOutstanding += LoanRec."Outstanding Balance";
//                         TotalInterest += LoanRec."Outstanding Interest";
//                         TotalPenalty += LoanRec."Outstanding Penalty";

//                     until LoanRec.Next() = 0;

//                     if LoanCount > 1 then begin

//                         MasterLoan."Outstanding Balance" := TotalOutstanding;
//                         MasterLoan."Loan Status" := MasterLoan."Loan Status"::Disbursed;
//                         MasterLoan.Modify();

//                         ClientLoans.Reset();
//                         ClientLoans.SetRange("Client Code", Customer."No.");
//                         ClientLoans.SetRange("Loan Product Type", 'DEFAULTER');
//                         ClientLoans.SetFilter("Loan Status", '%1|%2',
//                             ClientLoans."Loan Status"::Disbursed,
//                             ClientLoans."Loan Status"::Closed);

//                         if ClientLoans.FindSet() then
//                             repeat
//                                 if ClientLoans."Loan  No." <> MasterLoanNo then begin
//                                     ClientLoans."Outstanding Balance" := 0;

//                                     ClientLoans."Loan Status" := ClientLoans."Loan Status"::Disbursed;
//                                     ClientLoans.Modify();
//                                 end;
//                             until ClientLoans.Next() = 0;
//                     end;
//                 end;
//             end;

//         }
//     }
// }
