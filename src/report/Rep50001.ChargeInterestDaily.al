report 50001 "Charge Interest Daily"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(DataItemName; "Loans Register")
        {
            column(Loan__No_; "Loan  No.")
            {

            }
            trigger OnAfterGetRecord();
            begin
                if AsAt = 0D then AsAt := today;
                Amount := 0;
                interestChargedAmount := 0;
                DifferenceAmount := 0;
                RepayemntAmount := 0;
                OutstandingBalance := 0;
                DateOftheMonth := 0D;
                DateOftheMonth := CalcDate('CM', Today);
                Divisible := Date2DMY(DateOftheMonth, 1);

                DetailedLedgerEntry.Reset();
                DetailedLedgerEntry.SetFilter(Description, '%1', 'InterestCharged');
                DetailedLedgerEntry.SetRange("Posting Date", CalcDate('-CM-1D', Today));
                if DetailedLedgerEntry.Find('-') then begin
                    interestChargedAmount := DetailedLedgerEntry.Amount;
                end;
                DetailedLedgerEntry.Reset();
                DetailedLedgerEntry.SetFilter("Transaction Type", '%1', DetailedLedgerEntry."Transaction Type"::Repayment);
                DetailedLedgerEntry.SetFilter("Posting Date", '%1..%2', CalcDate('-CM', Today), Today);
                if DetailedLedgerEntry.Find('-') then begin
                    DetailedLedgerEntry.CalcSums(Amount);
                    RepayemntAmount := DetailedLedgerEntry.Amount * -1;
                end;

                DifferenceAmount := interestChargedAmount - RepayemntAmount;
                //Message('%1-%2', RepayemntAmount, interestBuffer);
                loanapp.Reset;
                loanapp.SetRange(loanapp."Loan  No.", "Loan  No.");
                loanapp.SetFilter(loanapp."Outstanding Balance", '>%1', 0);
                loanapp.SetFilter(loanapp."Date filter", '..%1', AsAt);
                if loanapp.Find('-') then begin
                    loanapp.CalcFields(loanapp."Outstanding Balance", loanapp.OutstandingLessInt);
                    if DifferenceAmount > 0 then
                        OutstandingBalance := loanapp.OutstandingLessInt
                    else
                        OutstandingBalance := loanapp."Outstanding Balance";
                end;

                loanapp.Reset;
                loanapp.SetRange(loanapp."Loan  No.", "Loan  No.");
                loanapp.SetFilter(loanapp."Outstanding Balance", '>%1', 0);
                loanapp.SetFilter(loanapp."Date filter", '..%1', AsAt);
                if loanapp.Find('-') then begin
                    loanapp.CalcFields(loanapp."OutstandingLessInt");
                    if loanapp.Installments > 12 then
                        Amount := ROUND(OutstandingBalance * (loanapp.Interest / 100 / Divisible), 0.01, '=');

                    if interestBuffer.FindLast() then
                        EntryNumber := interestBuffer."Entry No" + 1;
                    interestBuffer.Init();
                    interestBuffer."Entry No" := EntryNumber;
                    interestBuffer.Description := 'Interest Due';
                    interestBuffer."Loan No" := loanapp."Loan  No.";
                    interestBuffer."Member No" := loanapp."Client Code";
                    interestBuffer."Member Name" := loanapp."Client Name";
                    interestBuffer."Interest Amount" := Amount;
                    interestBuffer."Transaction Date" := Today;
                    interestBuffer.Time := Time;
                    interestBuffer.Insert(true);
                end

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Run Date")
                {
                    field(AsAt; AsAt)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/mylayout.rdl';
        }
    }

    var
        LoanType: Record "Loan Products Setup";
        loanapp: Record "Loans Register";
        Amount: Decimal;
        EntryNumber: Integer;
        DateOftheMonth: Date;
        Divisible: Integer;
        interestBuffer: Record "Interest Buffer Table";

        DetailedLedgerEntry: Record "Detailed Cust. Ledg. Entry";

        interestChargedAmount: Decimal;

        RepayemntAmount: Decimal;

        DifferenceAmount: Decimal;

        OutstandingBalance: Decimal;
        AsAt: Date;
}

