report 172993 CashFlow
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Cash Flow Statement';
    RDLCLayout = './Layouts/cashflowsreport.rdlc';

    dataset
    {
        dataitem("Sacco Information"; SaccoInformation)
        {
            column(Code; Code) { }
            column(Cashatbank; Cashatbank) { }
            column(LCashatbank; LCashatbank) { }
            column(endCashatbank; endCashatbank) { }
            column(EndLCashatbank; EndLCashatbank) { }
            column(PreviousYear; PreviousYear) { }
            column(CurrentYear; CurrentYear) { }
            column(EndofLastyear; EndofLastyear) { }
            column(LoanandAdvances; LoanandAdvances) { }
            column(LLoanandAdvances; LLoanandAdvances) { }
            column(FinancialAssets; FinancialAssets) { }
            column(LFinancialAssets; LFinancialAssets) { }
            column(TradeandOtherPayables; TradeandOtherPayables) { }
            column(LTradeandOtherPayables; LTradeandOtherPayables) { }
            column(Hononaria; Hononaria) { }
            column(LHononaria; LHononaria) { }
            column(Nonwithdrawabledeposits; Nonwithdrawabledeposits) { }
            column(LNonwithdrawabledeposits; LNonwithdrawabledeposits) { }
            column(InterestonMemberdeposits; InterestonMemberdeposits) { }
            column(LInterestonMemberDeposits; LInterestonMemberDeposits) { }
            column(InvestmentIncome; InvestmentIncome) { }
            column(LInvestmentIncome; LInvestmentIncome) { }
            column(ShareCapital; ShareCapital) { }
            column(LShareCapital; LShareCapital) { }
            column(LOtherOperatingincome; LOtherOperatingincome) { }
            column(OtherOperatingincome; OtherOperatingincome) { }
            column(InterestonLoans; InterestonLoans) { }
            column(LInterestonLoans; LInterestonLoans) { }
            column(LInterestExpenses; LInterestExpenses) { }
            column(InterestExpenses; InterestExpenses) { }
            column(ReceivableandPrepayments; ReceivableandPrepayments) { }
            column(LReceivableandPrepayments; LReceivableandPrepayments) { }
            column(ThisYear; ThisYear) { }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                // Calculate date ranges
                CalculateDateRanges();

                // Operating Activities - Income Items
                InterestonLoans := CalculateIncomeAmount(GLAccount.Incomes::InterestOnLoans, StartofcurrentYear, AsAt);
                LInterestonLoans := CalculateIncomeAmount(GLAccount.Incomes::InterestOnLoans, StartofPreviousYear, EndofLastyear);

                InvestmentIncome := CalculateIncomeAmount(GLAccount.Incomes::InvestmentIncome, StartofcurrentYear, AsAt);
                LInvestmentIncome := CalculateIncomeAmount(GLAccount.Incomes::InvestmentIncome, StartofPreviousYear, EndofLastyear);

                OtherOperatingincome := CalculateIncomeAmount(GLAccount.Incomes::OtherOperatingincome, StartofcurrentYear, AsAt);
                LOtherOperatingincome := CalculateIncomeAmount(GLAccount.Incomes::OtherOperatingincome, StartofPreviousYear, EndofLastyear);

                // Operating Activities - Expense Items
                InterestExpenses := CalculateIncomeAmount(GLAccount.Incomes::InterestExpenses, StartofcurrentYear, AsAt);
                LInterestExpenses := CalculateIncomeAmount(GLAccount.Incomes::InterestExpenses, StartofPreviousYear, EndofLastyear);

                // Working Capital Changes - Assets (Increase = negative cash flow)
                ReceivableandPrepayments := -1 * CalculateAssetChange(GLAccount.Assets::ReceivablesAndPrepayements, StartofcurrentYear, AsAt);
                LReceivableandPrepayments := -1 * CalculateAssetChange(GLAccount.Assets::ReceivablesAndPrepayements, StartofPreviousYear, EndofLastyear);

                // Investing Activities - Loans and Advances (Increase = negative cash flow)
                LoanandAdvances := -1 * CalculateAssetChange(GLAccount.Assets::LoansAndAdvances, StartofcurrentYear, AsAt);
                LLoanandAdvances := -1 * CalculateAssetChange(GLAccount.Assets::LoansAndAdvances, StartofPreviousYear, EndofLastyear);

                // Investing Activities - Financial Assets (Increase = negative cash flow)
                FinancialAssets := -1 * CalculateAssetChange(GLAccount.Assets::FinancialAssets, StartofcurrentYear, AsAt);
                LFinancialAssets := -1 * CalculateAssetChange(GLAccount.Assets::FinancialAssets, StartofPreviousYear, EndofLastyear);

                // Working Capital Changes - Liabilities (Increase = positive cash flow)
                TradeandOtherPayables := CalculateLiabilityChange(GLAccount.MkopoLiabilities::TradeandotherPayables, StartofcurrentYear, AsAt);
                LTradeandOtherPayables := CalculateLiabilityChange(GLAccount.MkopoLiabilities::TradeandotherPayables, StartofPreviousYear, EndofLastyear);

                Hononaria := CalculateLiabilityChange(GLAccount.MkopoLiabilities::Honoria, StartofcurrentYear, AsAt);
                LHononaria := CalculateLiabilityChange(GLAccount.MkopoLiabilities::Honoria, StartofPreviousYear, EndofLastyear);

                Nonwithdrawabledeposits := CalculateLiabilityChange(GLAccount.MkopoLiabilities::MemberDeposits, StartofcurrentYear, AsAt);
                LNonwithdrawabledeposits := CalculateLiabilityChange(GLAccount.MkopoLiabilities::MemberDeposits, StartofPreviousYear, EndofLastyear);

                InterestonMemberdeposits := CalculateLiabilityChange(GLAccount.MkopoLiabilities::dividendsandInterestPayable, StartofcurrentYear, AsAt);
                LInterestonMemberDeposits := CalculateLiabilityChange(GLAccount.MkopoLiabilities::dividendsandInterestPayable, StartofPreviousYear, EndofLastyear);

                // Financing Activities - Share Capital (Change during period)
                ShareCapital := CalculateEquityChange(GLAccount.FinancedBy::Sharecapital, StartofcurrentYear, AsAt);
                LShareCapital := CalculateEquityChange(GLAccount.FinancedBy::Sharecapital, StartofPreviousYear, EndofLastyear);

                // Cash and Cash Equivalents
                // Beginning balances (as at day before period start)
                Cashatbank := CalculateCashBalance(StartofcurrentYear - 1);
                LCashatbank := CalculateCashBalance(StartofPreviousYear - 1);

                // Ending balances
                endCashatbank := CalculateCashBalance(AsAt);
                EndLCashatbank := CalculateCashBalance(EndofLastyear);
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
                    field(AsAt; AsAt)
                    {
                        ApplicationArea = All;
                        Caption = 'As At Date';
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

    local procedure CalculateDateRanges()
    begin
        // Current year calculations
        ThisYear := AsAt;
        CurrentYear := Date2DMY(ThisYear, 3);
        StartofcurrentYear := CalcDate('<CY>', ThisYear); // First day of current year

        // Previous year calculations
        EndofLastyear := CalcDate('<-CY-1D>', ThisYear); // Last day of previous year
        PreviousYear := CurrentYear - 1;
        StartofPreviousYear := CalcDate('<CY>', EndofLastyear); // First day of previous year
    end;

    local procedure CalculateIncomeAmount(IncomeType: Option; StartDate: Date; EndDate: Date): Decimal
    var
        TempGLAccount: Record "G/L Account";
        TempGLEntry: Record "G/L Entry";
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;
        TempGLAccount.Reset();
        TempGLAccount.SetFilter(TempGLAccount.Incomes, '%1', IncomeType);
        if TempGLAccount.FindSet() then begin
            repeat
                TempGLEntry.Reset();
                TempGLEntry.SetRange(TempGLEntry."G/L Account No.", TempGLAccount."No.");
                TempGLEntry.SetRange(TempGLEntry."Posting Date", StartDate, EndDate);
                if TempGLEntry.FindSet() then begin
                    TempGLEntry.CalcSums(Amount);
                    // Income accounts are typically credit balance (negative in AL)
                    // Multiply by -1 to show positive income
                    TotalAmount += -1 * TempGLEntry.Amount;
                end;
            until TempGLAccount.Next() = 0;
        end;
        exit(TotalAmount);
    end;

    local procedure CalculateAssetChange(AssetType: Option; StartDate: Date; EndDate: Date): Decimal
    var
        TempGLAccount: Record "G/L Account";
        TempGLEntry: Record "G/L Entry";
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;
        TempGLAccount.Reset();
        TempGLAccount.SetFilter(TempGLAccount.Assets, '%1', AssetType);
        if TempGLAccount.FindSet() then begin
            repeat
                TempGLEntry.Reset();
                TempGLEntry.SetRange(TempGLEntry."G/L Account No.", TempGLAccount."No.");
                TempGLEntry.SetRange(TempGLEntry."Posting Date", StartDate, EndDate);
                if TempGLEntry.FindSet() then begin
                    TempGLEntry.CalcSums(Amount);
                    // Asset accounts are debit balance (positive in AL)
                    // Return the change as-is (increase in assets = positive value)
                    TotalAmount += TempGLEntry.Amount;
                end;
            until TempGLAccount.Next() = 0;
        end;
        exit(TotalAmount);
    end;

    local procedure CalculateLiabilityChange(LiabilityType: Option; StartDate: Date; EndDate: Date): Decimal
    var
        TempGLAccount: Record "G/L Account";
        TempGLEntry: Record "G/L Entry";
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;
        TempGLAccount.Reset();
        TempGLAccount.SetFilter(TempGLAccount.MkopoLiabilities, '%1', LiabilityType);
        if TempGLAccount.FindSet() then begin
            repeat
                TempGLEntry.Reset();
                TempGLEntry.SetRange(TempGLEntry."G/L Account No.", TempGLAccount."No.");
                TempGLEntry.SetRange(TempGLEntry."Posting Date", StartDate, EndDate);
                if TempGLEntry.FindSet() then begin
                    TempGLEntry.CalcSums(Amount);
                    // Liability accounts are credit balance (negative in AL)
                    // Multiply by -1 to show increase in liability as positive
                    TotalAmount += -1 * TempGLEntry.Amount;
                end;
            until TempGLAccount.Next() = 0;
        end;
        exit(TotalAmount);
    end;

    local procedure CalculateEquityChange(EquityType: Option; StartDate: Date; EndDate: Date): Decimal
    var
        TempGLAccount: Record "G/L Account";
        TempGLEntry: Record "G/L Entry";
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;
        TempGLAccount.Reset();
        TempGLAccount.SetFilter(TempGLAccount.FinancedBy, '%1', EquityType);
        if TempGLAccount.FindSet() then begin
            repeat
                TempGLEntry.Reset();
                TempGLEntry.SetRange(TempGLEntry."G/L Account No.", TempGLAccount."No.");
                TempGLEntry.SetRange(TempGLEntry."Posting Date", StartDate, EndDate);
                if TempGLEntry.FindSet() then begin
                    TempGLEntry.CalcSums(Amount);
                    // Equity accounts are credit balance (negative in AL)
                    // Multiply by -1 to show increase in equity as positive
                    TotalAmount += -1 * TempGLEntry.Amount;
                end;
            until TempGLAccount.Next() = 0;
        end;
        exit(TotalAmount);
    end;

    local procedure CalculateCashBalance(BalanceDate: Date): Decimal
    var
        TempGLAccount: Record "G/L Account";
        TempGLEntry: Record "G/L Entry";
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;
        TempGLAccount.Reset();
        TempGLAccount.SetFilter(TempGLAccount.Assets, '%1', TempGLAccount.Assets::CashAndEquivalents);
        if TempGLAccount.FindSet() then begin
            repeat
                TempGLEntry.Reset();
                TempGLEntry.SetRange(TempGLEntry."G/L Account No.", TempGLAccount."No.");
                TempGLEntry.SetFilter(TempGLEntry."Posting Date", '..%1', BalanceDate);
                if TempGLEntry.FindSet() then begin
                    TempGLEntry.CalcSums(Amount);
                    // Cash is an asset (debit balance = positive in AL)
                    TotalAmount += TempGLEntry.Amount;
                end;
            until TempGLAccount.Next() = 0;
        end;
        exit(TotalAmount);
    end;

    var
        // Cash balances
        Cashatbank: Decimal;
        LCashatbank: Decimal;
        endCashatbank: Decimal;
        EndLCashatbank: Decimal;

        // Date variables
        AsAt: Date;
        PreviousYear: Integer;
        CurrentYear: Integer;
        EndofLastyear: Date;
        ThisYear: Date;
        StartofcurrentYear: Date;
        StartofPreviousYear: Date;

        // Operating income
        InterestonLoans: Decimal;
        LInterestonLoans: Decimal;
        InvestmentIncome: Decimal;
        LInvestmentIncome: Decimal;
        OtherOperatingincome: Decimal;
        LOtherOperatingincome: Decimal;

        // Operating expenses
        InterestExpenses: Decimal;
        LInterestExpenses: Decimal;

        // Working capital - Assets
        ReceivableandPrepayments: Decimal;
        LReceivableandPrepayments: Decimal;

        // Investing activities
        LoanandAdvances: Decimal;
        LLoanandAdvances: Decimal;
        FinancialAssets: Decimal;
        LFinancialAssets: Decimal;

        // Working capital - Liabilities
        TradeandOtherPayables: Decimal;
        LTradeandOtherPayables: Decimal;
        Hononaria: Decimal;
        LHononaria: Decimal;
        Nonwithdrawabledeposits: Decimal;
        LNonwithdrawabledeposits: Decimal;
        InterestonMemberdeposits: Decimal;
        LInterestonMemberDeposits: Decimal;

        // Financing activities
        ShareCapital: Decimal;
        LShareCapital: Decimal;

        // Record variables
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
}
