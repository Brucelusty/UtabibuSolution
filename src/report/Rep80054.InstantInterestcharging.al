report 80054 "Instant Interest charging"
{
    RDLCLayout = './Layouts/ Monthly Instant Interest2.rdlc';
    DefaultLayout = RDLC;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance", "Last Int Date";
            DataItemTableView = where("Loan Product Type" = filter('INSTANT'), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan  No.", "Issued Date", "Date filter", Source, "Client Code", "Account No", "Loan Product Type", "Outstanding Interest", "Interest Due", "Interest Paid";

            trigger OnPreDataItem()
            begin
                "Loans Register".SetFilter("Loan Product Type", 'INSTANT');
                "Loans Register".SetFilter("Issued Date", '>=01012021D');

                if PostDate = 0D then
                    PostDate := Today;
                if DocNo = '' then
                    DocNo := 'INSTANTINTEREST';

                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'INT DUE 1');
                GenJournalLine.DeleteAll();

                GenBatches.Reset();
                GenBatches.SetRange("Journal Template Name", 'General');
                GenBatches.SetRange(Name, 'INT DUE 1');
                if not GenBatches.FindFirst() then begin
                    GenBatches.Init();
                    GenBatches."Journal Template Name" := 'General';
                    GenBatches.Name := 'INT DUE 1';
                    GenBatches.Description := 'Instant Interest Due';
                    GenBatches.Insert(true);
                end;
            end;

            trigger OnAfterGetRecord()
            var
                StartOfMonth: Date;
                EndOfMonth: Date;
                DueDateList: array[9] of Date;
                i: Integer;
            begin
                loanapp.Reset();
                loanapp.SetRange("Loan  No.", "Loan  No.");
                loanapp.SetAutoCalcFields("Outstanding Balance");
                if not loanapp.FindFirst() then
                    exit;

                if loanapp."Loan Disbursement Date" = 0D then
                    CurrReport.Skip();

                OutstandingBalance := loanapp."Outstanding Balance";
                if OutstandingBalance <= 0 then
                    CurrReport.Skip();

                DueDateList[1] := CalcDate('30D', loanapp."Loan Disbursement Date");
                DueDateList[2] := CalcDate('60D', loanapp."Loan Disbursement Date");
                DueDateList[3] := CalcDate('90D', loanapp."Loan Disbursement Date");
                DueDateList[4] := CalcDate('120D', loanapp."Loan Disbursement Date");
                DueDateList[5] := CalcDate('150D', loanapp."Loan Disbursement Date");
                DueDateList[6] := CalcDate('180D', loanapp."Loan Disbursement Date");
                DueDateList[7] := CalcDate('210D', loanapp."Loan Disbursement Date");
                DueDateList[8] := CalcDate('240D', loanapp."Loan Disbursement Date");
                DueDateList[9] := CalcDate('270D', loanapp."Loan Disbursement Date");

                Over90Days := CalcDate('271D', loanapp."Loan Disbursement Date");
                if Today > Over90Days then
                    CurrReport.Skip();

                IsDue := false;
                for i := 1 to 9 do
                    if DueDateList[i] = PostDate then
                        IsDue := true;

                if not IsDue then
                    CurrReport.Skip();

                StartOfMonth := DMY2Date(1, Date2DMY(PostDate, 2), Date2DMY(PostDate, 3));
                EndOfMonth := CALCDATE('CM+1D-1D', PostDate);


                CustLedger.Reset();
                CustLedger.SetRange("Loan No", "Loan  No.");
                CustLedger.SetFilter("Transaction Type", '%1', CustLedger."Transaction Type"::"Interest Due");
                CustLedger.SetFilter("Posting Date", '%1..%2', StartOfMonth, EndOfMonth);
                CustLedger.SetRange(Reversed, false);
                if CustLedger.FindFirst() then
                    CurrReport.Skip();

                LineNo += 10000;
                GenJournalLine.Init();
                GenJournalLine."Journal Template Name" := 'General';
                GenJournalLine."Journal Batch Name" := 'INT DUE 1';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                GenJournalLine."Account No." := loanapp."Client Code";
                GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Due";
                GenJournalLine.Validate("Account No.");
                GenJournalLine."Document No." := Format(PostDate, 0, '<Month Text,3>') + ' Instant Loan';
                GenJournalLine."Posting Date" := PostDate;
                GenJournalLine.Description := 'Instant Loan Interest Charged';
                GenJournalLine.Amount := ROUND(OutstandingBalance * (3.333333 / 100), 1, '>');
                GenJournalLine.Validate(Amount);

                if LoanType.Get(loanapp."Loan Product Type") then begin
                    GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                    GenJournalLine.Validate("Bal. Account No.");
                end;

                if loanapp.Source = loanapp.Source::BOSA then begin
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := 'NAIROBI';
                end else if loanapp.Source = loanapp.Source::FOSA then begin
                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := 'NAIROBI';
                end;

                GenJournalLine.Validate("Shortcut Dimension 1 Code");
                GenJournalLine.Validate("Shortcut Dimension 2 Code");
                GenJournalLine."Loan No" := loanapp."Loan  No.";

                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert();
            end;

            trigger OnPostDataItem()
            begin
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'INT DUE 1');
                if GenJournalLine.FindFirst() then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(PostDate; PostDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                    Editable = true;
                }
                field(DocNo; DocNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No.';
                    Editable = true;
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        AccountingPeriod.SetRange(Closed, false);
        if AccountingPeriod.FindFirst() then begin
            FiscalYearStartDate := AccountingPeriod."Interest Calcuation Date";
            PostDate := FiscalYearStartDate;
            DocNo := AccountingPeriod.Name + ' ' + Format(PostDate);
        end;
    end;

    var
        GenBatches: Record "Gen. Journal Batch";
        PostDate: Date;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        CustLedger: Record "Detailed Cust. Ledg. Entry";
        loanapp: Record "Loans Register";
        OutstandingBalance: Decimal;
        AccountingPeriod: Record "Interest Due Period";
        FiscalYearStartDate: Date;
        Over90Days: Date;
        IsDue: Boolean;
}
