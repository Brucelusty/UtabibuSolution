report 50095 "Instant Loan Extension"
{
    ApplicationArea = All;
    Caption = 'Instant Loan Extension';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/IntantLoanExt.rdlc';
    dataset
    {

        dataitem(LoansRegister; "Loans Register")
        {

            DataItemTableView = where("Loan Product Type" = filter('INSTANT'), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Client Code", "Loan  No.";
            column(ClientCode; "Client Code")
            {
            }
            column(ClientName; "Client Name")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanNo; "Loan  No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                InterestPaid := 0;
                Difference := 0;
                if RunDate = 0D then RunDate := Today;
                LoansR.Reset();
                LoansR.SetRange("Loan  No.", LoansRegister."Loan  No.");
                LoansR.SetFilter("Date filter", '..%1', RunDate);
                if LoansR.Find('-') then begin
                    Interest := 0;
                    Interest := (LoansR."Approved Amount" * 0.1);

                    DetailedLedger.Reset();
                    DetailedLedger.SetRange("Loan No", LoansR."Loan  No.");
                    DetailedLedger.SetFilter("Transaction Type", '%1', DetailedLedger."Transaction Type"::"Interest Paid");
                    DetailedLedger.SetFilter("Posting Date", '..%1', RunDate);
                    if DetailedLedger.Find('-') then begin
                        DetailedLedger.CalcSums(Amount);
                        InterestPaid := DetailedLedger.Amount;
                    end;
                    DetailedLedger.Reset;
                    DetailedLedger.SetRange(DetailedLedger."Transaction Type", DetailedLedger."transaction type"::Repayment);
                    DetailedLedger.SetRange(DetailedLedger."Loan No", LoansR."Loan  No.");
                    DetailedLedger.SetRange(DetailedLedger."Customer No.", LoansR."Client Code");
                    DetailedLedger.SetFilter(DetailedLedger."Posting Date", '..%1', RunDate);
                    if DetailedLedger.FindSet then begin
                        DetailedLedger.CalcSums("Credit Amount");
                        principlePaid := principlePaid + DetailedLedger."Credit Amount";
                    end;
                    ToatlPaidAmount := ToatlPaidAmount + principlePaid + INTERESTPAID;
                    Difference := ToatlPaidAmount - Interest;
                    CompletionDate := 0D;
                    CompletionDate := CalcDate('3M', LoansR."Loan Disbursement Date");
                    if Difference >= 0 then begin
                        if CompletionDate = RunDate then begin
                            LoansR.Extended := true;
                            LoansR."Extension Description" := 'Extended - Interest INSTANT';
                            LoansR."Expected Date of Completion" := CalcDate('6M', LoansR."Loan Disbursement Date");
                            LoansR."Extended Reason" := LoansR."Extended Reason"::"Less Payment";
                            LoansR."Extended Date" := CalcDate('3M', LoansR."Loan Disbursement Date");
                        end
                    end;

                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(RunDate; RunDate)
                    {

                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        LoansR: Record "Loans Register";
        DetailedLedger: Record "Detailed Cust. Ledg. Entry";//
        Interest: Decimal;
        InterestPaid: Decimal;

        RunDate: Date;
        Difference: Decimal;
        principlePaid: Decimal;
        ToatlPaidAmount: Decimal;
        CompletionDate: Date;
}
