report 50077 "Charge Penalties On Late Payme"
{
    ApplicationArea = All;
    Caption = 'Charge Penalties On Late Payme';
    UsageCategory = Administration;
    ProcessingOnly = true;
    dataset
    {
        dataitem(LoansRegister; "Loans Register")
        {
            DataItemTableView = where("Recovery Mode" = filter("Standing Order"), "Outstanding Balance" = filter(> 0), "Loan Product Type" = filter(<> 'INSTANT'));
            RequestFilterFields = "Loan Product Type", "Loan  No.";
            column(LoanNo; "Loan  No.")
            {
            }
            trigger OnPreDataItem()
            begin
                Gnljnline.Reset();
                Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                Gnljnline.SetRange("Journal Batch Name", 'PENALTY');
                if Gnljnline.Find('-') then begin
                    Gnljnline.DeleteAll();
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                ScheduleBal := 0;
                Arrears := 0;
                RepaymentDate := 0D;
                if PDate = 0D then begin
                    PDate := Today;
                end;
                LoanSchedule.Reset();
                LoanSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanSchedule.SetFilter("Repayment Date", '..%1', CalcDate('1M', PDate));
                if LoanSchedule.FindFirst() then begin
                    RepaymentDate := LoanSchedule."Repayment Date";
                end;
                if LoansRegister."Repayment Start Date" >= PDate then CurrReport.Skip();
                if RepaymentDate >= PDate then CurrReport.Skip();
                LoanSchedule.Reset();
                LoanSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanSchedule.SetFilter("Repayment Date", '..%1', CalcDate('-CM-1D', PDate));
                if LoanSchedule.FindLast() then begin
                    ScheduleBal := LoanSchedule."Loan Balance";
                end;
                //skip if already charged
                CustLedger.Reset;
                CustLedger.SetRange(CustLedger."Loan No", "Loan  No.");
                CustLedger.SetFilter(CustLedger."Transaction Type", '%1', CustLedger."transaction type"::"Penalty Charged");
                CustLedger.SetFilter("Posting Date", '%1..%2', CalcDate('-CM', PDate), CalcDate('CM', PDate));
                CustLedger.SetRange(Reversed, false);
                if CustLedger.Find('-') then
                    CurrReport.Skip();
                //end charging
                LoansRegister.SetFilter("Date filter", '..%1', PDate);
                LoansRegister.CalcFields("Outstanding Balance");
                Arrears := LoansRegister."Outstanding Balance" - ScheduleBal;
                if Arrears > 0 then begin
                    if LoanType.Get(LoansRegister."Loan Product Type") then begin
                        DocNo := 'Pen ' + LoansRegister."Loan  No.";
                        LineNo := LineNo + 10000;
                        Gnljnline.Init;
                        Gnljnline."Journal Template Name" := 'GENERAL';
                        Gnljnline."Journal Batch Name" := 'PENALTY';
                        Gnljnline."Line No." := LineNo;
                        Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                        Gnljnline."Account No." := LoansRegister."Client Code";
                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Penalty Charged";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No." := DocNo;
                        Gnljnline."Posting Date" := PDate;
                        Gnljnline.Description := 'Late Payment Penalty ' + LoansRegister."Loan Product Type";
                        Gnljnline.Amount := ROUND((Arrears) * (LoanType."Penalty Percentage" / 100), 0.05, '>');
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Bal. Account Type" := Gnljnline."bal. account type"::"G/L Account";
                        Gnljnline."Bal. Account No." := LoanType."Penalty Paid Account";
                        Gnljnline.Validate(Gnljnline."Bal. Account No.");
                        Gnljnline."Loan No" := LoansRegister."Loan  No.";
                        if Gnljnline.Amount <> 0 then
                            Gnljnline.Insert;
                    end;
                end;

            end;

            trigger OnPostDataItem()
            begin
                Message('generated successfully');
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
                    field(PDate; PDate)
                    {
                        Caption = 'RunDate';
                        ApplicationArea = all;
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
        LoanType: Record "Loan Products Setup";
        Gnljnline: Record "Gen. Journal Line";
        CustLedger: Record "Detailed Cust. Ledg. Entry";
        ToatlPaidAmount: Decimal;
        ScheduleBal: Decimal;
        Arrears: Decimal;
        LineNo: Integer;
        principlePaid: Decimal;
        DocNo: Code[20];
        PDate: Date;
        LoansCaptionLbl: label 'Loans';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        VarienceCaptionLbl: label 'Varience';
        CurrDate: Date;
        Months: Integer;
        DateFilt: Date;
        LoanSchedule: Record "Loan Repayment Schedule";
        TotaliNterest: Decimal;
        Months1: Decimal;
        Months2: Decimal;
        Loans: Record "Loans Register";
        LoansR: Record "Loans Register";
        GenJournalLine: Record "Gen. Journal Line";
        InterestDue: Decimal;
        DetailedLedger: Record "Detailed Cust. Ledg. Entry";
        InterestDueP: Decimal;
        OutBal: Decimal;
        VarInt: Integer;
        VARDATE: Date;
        VARIDATE: Integer;
        VARDATEP: Integer;
        DateFilter: Text;
        INTERESTPAID: Decimal;
        TenPercent: Decimal;

        InteretP: Decimal;
        CheckAmount: Decimal;
        CompletionDate: Date;
        AsAt: Date;
        RepaymentDate: Date;
}
