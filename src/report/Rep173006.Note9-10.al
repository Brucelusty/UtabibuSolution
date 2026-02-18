report 173006 "Note9-10"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Notes to Financial Statements - Receivables';
    RDLCLayout = 'Layouts/Note9-10.rdlc';

    dataset
    {
        dataitem("Sacco Information"; SaccoInformation)
        {
            column(CompanyName; CompanyProperty.Name) { }
            column(ReportTitle; ReportTitle) { }
            column(AsOfDate; Format(AsOfDateParam, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(CurrentYear; Format(Date2DMY(AsOfDateParam, 3))) { }
            column(PreviousYear; Format(Date2DMY(AsOfDateParam, 3) - 1)) { }

            // ── 9(a) Prepayments & Sundry Receivables ──────────────────────
            column(Header_9a; 'Prepayments & Sundry Receivables') { }

            // Interest on Loans Receivable = 400040 + 400045 (closing balance)
            column(Header_InterestOnLoansReceivable; 'Interest on Loans Receivable') { }
            column(InterestOnLoansReceivable; InterestOnLoansReceivable) { }
            column(InterestOnLoansReceivable_Prev; InterestOnLoansReceivable_Prev) { }

            // Prepayments (CRB) = 400222 closing balance
            column(Header_PrepaymentsCRB; 'Prepayments (CRB)') { }
            column(PrepaymentsCRB; PrepaymentsCRB) { }
            column(PrepaymentsCRB_Prev; PrepaymentsCRB_Prev) { }

            // Insurance Premium (Prepaid Exp) = 400224 closing balance
            column(Header_InsurancePremium; 'Insurance Premium (Prepaid Expenses)') { }
            column(InsurancePremium; InsurancePremium) { }
            column(InsurancePremium_Prev; InsurancePremium_Prev) { }

            // Loan Disbursement Account (highlighted - needs account no.)
            // column(Header_LoanDisbursementAccount; 'Loan Disbursement Account') { }
            // column(LoanDisbursementAccount; LoanDisbursementAccount) { }
            // column(LoanDisbursementAccount_Prev; LoanDisbursementAccount_Prev) { }

            // Debtor Employer = 400050 closing balance
            column(Header_DebtorEmployer; 'Debtor Employer') { }
            column(DebtorEmployer; DebtorEmployer) { }
            column(DebtorEmployer_Prev; DebtorEmployer_Prev) { }

            // Other Receivables = 400220 closing balance
            column(Header_OtherReceivables; 'Other Receivables') { }
            column(OtherReceivables; OtherReceivables) { }
            column(OtherReceivables_Prev; OtherReceivables_Prev) { }

            // Provision for Other Receivables = 400225 closing balance
            column(Header_ProvisionOtherReceivables; 'Provision for Other Receivables') { }
            column(ProvisionOtherReceivables; ProvisionOtherReceivables) { }
            column(ProvisionOtherReceivables_Prev; ProvisionOtherReceivables_Prev) { }

            // Total 9(a)
            column(Header_Total9a; 'Total ') { }
            column(Total9a; Total9a) { }
            column(Total9a_Prev; Total9a_Prev) { }

            // ── 9(b) Prepayments & Sundry Receivables ──────────────────────
            column(Header_9b; ' Prepayments & Sundry Receivables') { }

            // Monarch Developers Limited (Office Space) = 400223 closing balance
            column(Header_MonarchDevelopers; 'Monarch Developers Limited (Office Space)') { }
            column(MonarchDevelopers; MonarchDevelopers) { }
            column(MonarchDevelopers_Prev; MonarchDevelopers_Prev) { }

            // Less Provision = 400227 closing balance
            column(Header_ProvisionMonarch; 'Less Provision') { }
            column(ProvisionMonarch; ProvisionMonarch) { }
            column(ProvisionMonarch_Prev; ProvisionMonarch_Prev) { }

            // Total 9(b)
            column(Header_Total9b; 'Total ') { }
            column(Total9b; Total9b) { }
            column(Total9b_Prev; Total9b_Prev) { }

            // ── 10 Sundry Receivables ───────────────────────────────────────
            column(Header_10; ' Sundry Receivables') { }

            // Balance Bfwd = 400220 + 400221 closing balance
            column(Header_BalanceBfwd; 'Balance Bfwd') { }
            column(BalanceBfwd; BalanceBfwd) { }
            column(BalanceBfwd_Prev; BalanceBfwd_Prev) { }

            // Sacco Personal Loan = Addns (Debit movements in period)
            column(Header_SaccoPersonalLoan; 'Sacco Personal Loan') { }
            column(SaccoPersonalLoan; SaccoPersonalLoan) { }
            column(SaccoPersonalLoan_Prev; SaccoPersonalLoan_Prev) { }

            // Less Amount Paid during the year = Credit movements in period
            column(Header_LessAmountPaid; 'Less Amount Paid During the Year') { }
            column(LessAmountPaid; LessAmountPaid) { }
            column(LessAmountPaid_Prev; LessAmountPaid_Prev) { }

            // Less Provision = 400226 closing balance
            column(Header_ProvisionSundry; 'Less Provision') { }
            column(ProvisionSundry; ProvisionSundry) { }
            column(ProvisionSundry_Prev; ProvisionSundry_Prev) { }

            // Total 10
            column(Header_Total10; 'Total 10') { }
            column(Total10; Total10) { }
            column(Total10_Prev; Total10_Prev) { }

            trigger OnAfterGetRecord()
            begin
                ReportTitle := 'Notes to Financial Statements - Receivables';

                if AsOfDateParam = 0D then
                    Error('Please enter a valid As Of Date');

                UpdateDateRanges();
                ClearAllValues();
                CalculateCurrentPeriod();
                CalculatePreviousPeriod();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Report Options';

                    field(AsOfDate; AsOfDateParam)
                    {
                        ApplicationArea = All;
                        Caption = 'As of Date';
                        ToolTip = 'Enter the year-end date. Previous year will be calculated automatically.';

                        trigger OnValidate()
                        begin
                            UpdateDateRanges();
                        end;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if AsOfDateParam = 0D then
                AsOfDateParam := WorkDate();
            UpdateDateRanges();
        end;
    }

    var
        GLEntry: Record "G/L Entry";
        CompanyProperty: Record "Company Information";

        AsOfDateParam: Date;
        CurrentYearStart: Date;
        CurrentYearEnd: Date;
        PreviousYearStart: Date;
        PreviousYearEnd: Date;
        ReportTitle: Text;

        // 9(a) variables
        InterestOnLoansReceivable: Decimal;
        InterestOnLoansReceivable_Prev: Decimal;
        PrepaymentsCRB: Decimal;
        PrepaymentsCRB_Prev: Decimal;
        InsurancePremium: Decimal;
        InsurancePremium_Prev: Decimal;
        LoanDisbursementAccount: Decimal;
        LoanDisbursementAccount_Prev: Decimal;
        DebtorEmployer: Decimal;
        DebtorEmployer_Prev: Decimal;
        OtherReceivables: Decimal;
        OtherReceivables_Prev: Decimal;
        ProvisionOtherReceivables: Decimal;
        ProvisionOtherReceivables_Prev: Decimal;
        Total9a: Decimal;
        Total9a_Prev: Decimal;

        // 9(b) variables
        MonarchDevelopers: Decimal;
        MonarchDevelopers_Prev: Decimal;
        ProvisionMonarch: Decimal;
        ProvisionMonarch_Prev: Decimal;
        Total9b: Decimal;
        Total9b_Prev: Decimal;

        // 10 variables
        BalanceBfwd: Decimal;
        BalanceBfwd_Prev: Decimal;
        SaccoPersonalLoan: Decimal;
        SaccoPersonalLoan_Prev: Decimal;
        LessAmountPaid: Decimal;
        LessAmountPaid_Prev: Decimal;
        ProvisionSundry: Decimal;
        ProvisionSundry_Prev: Decimal;
        Total10: Decimal;
        Total10_Prev: Decimal;

    local procedure UpdateDateRanges()
    begin
        CurrentYearStart := CalcDate('<-CY>', AsOfDateParam);
        CurrentYearEnd := AsOfDateParam;
        PreviousYearStart := CalcDate('<-1Y-CY>', AsOfDateParam);
        PreviousYearEnd := CalcDate('<-1Y>', AsOfDateParam);
    end;

    local procedure ClearAllValues()
    begin
        InterestOnLoansReceivable := 0;        InterestOnLoansReceivable_Prev := 0;
        PrepaymentsCRB := 0;                   PrepaymentsCRB_Prev := 0;
        InsurancePremium := 0;                 InsurancePremium_Prev := 0;
        LoanDisbursementAccount := 0;          LoanDisbursementAccount_Prev := 0;
        DebtorEmployer := 0;                   DebtorEmployer_Prev := 0;
        OtherReceivables := 0;                 OtherReceivables_Prev := 0;
        ProvisionOtherReceivables := 0;        ProvisionOtherReceivables_Prev := 0;
        Total9a := 0;                          Total9a_Prev := 0;
        MonarchDevelopers := 0;                MonarchDevelopers_Prev := 0;
        ProvisionMonarch := 0;                 ProvisionMonarch_Prev := 0;
        Total9b := 0;                          Total9b_Prev := 0;
        BalanceBfwd := 0;                      BalanceBfwd_Prev := 0;
        SaccoPersonalLoan := 0;               SaccoPersonalLoan_Prev := 0;
        LessAmountPaid := 0;                   LessAmountPaid_Prev := 0;
        ProvisionSundry := 0;                  ProvisionSundry_Prev := 0;
        Total10 := 0;                          Total10_Prev := 0;
    end;

    local procedure CalculateCurrentPeriod()
    begin
        // ── 9(a) ─────────────────────────────────────────────────────────────
        // Interest on Loans Receivable = 400040 + 400045 (closing balances)
        InterestOnLoansReceivable := GetClosingBalance('400040', CurrentYearEnd) +
                                     GetClosingBalance('400045', CurrentYearEnd);

        // Prepayments CRB = 400222 closing balance
        PrepaymentsCRB := GetClosingBalance('400222', CurrentYearEnd);

        // Insurance Premium (Prepaid Exp) = 400224 closing balance
        InsurancePremium := GetClosingBalance('400224', CurrentYearEnd);

        // Loan Disbursement Account - update account no. when confirmed
        // LoanDisbursementAccount := GetClosingBalance('400048', CurrentYearEnd);

        // Debtor Employer = 400050 closing balance
        DebtorEmployer := GetGLAmountByAccountNo('400050',CurrentYearStart, CurrentYearEnd);

        // Other Receivables = 400220 closing balance
        OtherReceivables := GetGLAmountByAccountNo('400220',CurrentYearStart, CurrentYearEnd);

        // Provision for Other Receivables = 400225 closing balance
        ProvisionOtherReceivables := GetGLAmountByAccountNo('400225',CurrentYearStart, CurrentYearEnd );

        Total9a := InterestOnLoansReceivable + PrepaymentsCRB + InsurancePremium +
                   LoanDisbursementAccount + DebtorEmployer + OtherReceivables +
                   ProvisionOtherReceivables;

        // ── 9(b) ─────────────────────────────────────────────────────────────
        // Monarch Developers = 400223 closing balance
        MonarchDevelopers := GetGLAmountByAccountNo('400223',CurrentYearStart, CurrentYearEnd );

        // Less Provision = 400227 closing balance
        ProvisionMonarch := GetGLAmountByAccountNo('400227', CurrentYearStart, CurrentYearEnd );

        Total9b := MonarchDevelopers + ProvisionMonarch;

        // ── 10 ───────────────────────────────────────────────────────────────
        // Balance Bfwd = 400220 + 400221 closing balance of PREVIOUS year
        // (brought forward = what was the closing balance last year)
        BalanceBfwd := GetClosingBalance('400221', PreviousYearEnd);

        // Sacco Personal Loan = Debit entries only in current period (additions)
        SaccoPersonalLoan := GetPeriodDebits('400220', CurrentYearStart, CurrentYearEnd) +
                             GetPeriodDebits('400221', CurrentYearStart, CurrentYearEnd);

        // Less Amount Paid = Credit entries only in current period (reductions)
        LessAmountPaid := GetPeriodCredits('400220', CurrentYearStart, CurrentYearEnd) +
                          GetPeriodCredits('400221', CurrentYearStart, CurrentYearEnd);

        // Less Provision = 400226 closing balance
        ProvisionSundry := GetClosingBalance('400226', CurrentYearEnd);

        Total10 := BalanceBfwd + SaccoPersonalLoan + LessAmountPaid + ProvisionSundry;
    end;

    local procedure CalculatePreviousPeriod()
    begin
        // ── 9(a) ─────────────────────────────────────────────────────────────
        InterestOnLoansReceivable_Prev := GetClosingBalance('400040', PreviousYearEnd) +
                                          GetClosingBalance('400045', PreviousYearEnd);
        PrepaymentsCRB_Prev := GetClosingBalance('400222', PreviousYearEnd);
        InsurancePremium_Prev := GetClosingBalance('400224', PreviousYearEnd);
        // LoanDisbursementAccount_Prev := GetClosingBalance('400048', PreviousYearEnd);
        DebtorEmployer_Prev := GetGLAmountByAccountNo('400050',PreviousYearStart, PreviousYearEnd );
        OtherReceivables_Prev := GetGLAmountByAccountNo('400220',PreviousYearStart, PreviousYearEnd );
        ProvisionOtherReceivables_Prev := GetGLAmountByAccountNo('400225',PreviousYearStart, PreviousYearEnd );

        Total9a_Prev := InterestOnLoansReceivable_Prev + PrepaymentsCRB_Prev +
                        InsurancePremium_Prev + LoanDisbursementAccount_Prev +
                        DebtorEmployer_Prev + OtherReceivables_Prev +
                        ProvisionOtherReceivables_Prev;

        // ── 9(b) ─────────────────────────────────────────────────────────────
        MonarchDevelopers_Prev := GetGLAmountByAccountNo('400223', PreviousYearStart, PreviousYearEnd );
        ProvisionMonarch_Prev := GetGLAmountByAccountNo ('400227', PreviousYearStart, PreviousYearEnd );
        Total9b_Prev := MonarchDevelopers_Prev + ProvisionMonarch_Prev;

        // ── 10 ───────────────────────────────────────────────────────────────
        // Balance Bfwd for previous year = closing balance of the year before
        BalanceBfwd_Prev := GetClosingBalance('400220', PreviousYearStart - 1) +
                            GetClosingBalance('400221', PreviousYearStart - 1);

        SaccoPersonalLoan_Prev := GetPeriodDebits('400220', PreviousYearStart, PreviousYearEnd) +
                                  GetPeriodDebits('400221', PreviousYearStart, PreviousYearEnd);

        LessAmountPaid_Prev := GetPeriodCredits('400220', PreviousYearStart, PreviousYearEnd) +
                               GetPeriodCredits('400221', PreviousYearStart, PreviousYearEnd);

        ProvisionSundry_Prev := GetClosingBalance('400226', PreviousYearEnd);

        Total10_Prev := BalanceBfwd_Prev + SaccoPersonalLoan_Prev +
                        LessAmountPaid_Prev + ProvisionSundry_Prev;
    end;

    // ── Cumulative closing balance (0D → EndDate) ─────────────────────────────
    // For balance sheet accounts: receivables, payables, provisions
    // Returns the true ledger closing balance
    local procedure GetClosingBalance(AccountNo: Code[20]; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", 0D, EndDate);
        if GLEntry.CalcSums(Amount) then
            exit(GLEntry.Amount);
        exit(0);
    end;

    // ── Period debit movements (additions) ───────────────────────────────────
    // For note 10: captures new loans/additions during the year only
    local procedure GetPeriodDebits(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        TotalDebits: Decimal;
    begin
        TotalDebits := 0;
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        if GLEntry.FindSet() then
            repeat
                if GLEntry.Amount > 0 then
                    TotalDebits += GLEntry.Amount;
            until GLEntry.Next() = 0;
        exit(TotalDebits);
    end;

    // ── Period credit movements (reductions/payments) ────────────────────────
    // For note 10: captures amounts paid/recovered during the year only
    local procedure GetPeriodCredits(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        TotalCredits: Decimal;
    begin
        TotalCredits := 0;
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        if GLEntry.FindSet() then
            repeat
                if GLEntry.Amount < 0 then
                    TotalCredits += GLEntry.Amount;
            until GLEntry.Next() = 0;
        exit(TotalCredits);
    end;

    // ── Period-based net movement (StartDate → EndDate) ──────────────────────
    // For income/expense accounts: activity within a specific period only
    local procedure GetGLAmountByAccountNo(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal //NegateAmount: Boolean
    var
        Amount: Decimal;
    begin
        Amount := 0;
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        GLEntry.CalcSums(GLEntry.Amount);
        // if NegateAmount then
        //     Amount := -1 * GLEntry.Amount
        // else
            Amount := GLEntry.Amount;
        exit(Amount);
    end;
}