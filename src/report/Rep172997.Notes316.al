report 172997 "Notes3-16"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'statement of changes in equity Previous Period';
    RDLCLayout = './Layouts/Notes3-16.rdlc';

    dataset
    {
        dataitem("Sacco Information"; SaccoInformation)
        {
            column(Code; Code)
            {

            }
            column(Cashatbank; Cashatbank) { }
            column(LCashatbank; LCashatbank) { }
            column(endCashatbank; endCashatbank) { }
            column(EndLCashatbank; EndLCashatbank) { }
            column(PreviousYear; PreviousYear)
            {

            }
            column(CurrentYear; CurrentYear)
            {

            }
            column(EndofLastyear; EndofLastyear)
            {

            }
            column(LoanandAdvances; LoanandAdvances)
            {
            }
            column(LLoanandAdvances; LLoanandAdvances)
            {
            }
            column(FinancialAssets; FinancialAssets)
            {
            }
            column(LFinancialAssets; LFinancialAssets)
            {
            }
            column(TradeandOtherPayables; TradeandOtherPayables)
            {
            }
            column(LTradeandOtherPayables; LTradeandOtherPayables)
            {
            }
            column(Hononaria; Hononaria)
            {
            }
            column(LHononaria; LHononaria)
            {
            }
            column(Nonwithdrawabledeposits; Nonwithdrawabledeposits)
            {
            }
            column(LNonwithdrawabledeposits; LNonwithdrawabledeposits)
            {
            }
            column(InterestonMemberdeposits; InterestonMemberdeposits)
            {

            }
            column(LInterestonMemberDeposits; LInterestonMemberDeposits)
            {

            }
            column(InvestmentIncome; InvestmentIncome)
            {

            }
            column(LInvestmentIncome; LInvestmentIncome)
            {

            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(LShareCapital; LShareCapital)
            { }
            column(LOtherOperatingincome; LOtherOperatingincome)
            {

            }
            column(OtherOperatingincome; OtherOperatingincome)
            {

            }
            column(InterestonLoans; InterestonLoans) { }
            column(LInterestonLoans; LInterestonLoans) { }
            column(LInterestExpenses; LInterestExpenses) { }
            column(InterestExpenses; InterestExpenses) { }
            column(ReceivableandPrepayments; ReceivableandPrepayments) { }
            column(LReceivableandPrepayments; LReceivableandPrepayments) { }
            column(ThisYear; ThisYear)
            {

            }
            trigger OnAfterGetRecord()

            begin
                // Validate input date
                if Asat = 0D then
                    Error('Please enter a valid date in the request page');

                DateFormula := '<-CY-1D>';
                DateExpr := '<-1y>';
                InputDate := Asat;
                DateExpr2 := '<-CY>';

                ThisYear := InputDate;
                StartofcurrentYear := CalcDate(DateExpr2, ThisYear);

                CurrentYear := Date2DMY(ThisYear, 3);
                EndofLastyear := CalcDate(DateFormula, ThisYear);
                StartofPreviousYear := CalcDate(DateExpr2, EndofLastyear);
                PreviousYear := CurrentYear - 1;

                // Debug: Show calculated dates
                Message('Date Range - Current: %1 to %2, Previous: %3 to %4',
                        StartofcurrentYear, ThisYear, StartofPreviousYear, EndofLastyear);

                //Interest on Loans (Current Year - CUMULATIVE)
                InterestonLoans := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InterestOnLoans);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InterestonLoans += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Interest on Loans (Previous Year - CUMULATIVE)
                LInterestonLoans := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InterestOnLoans);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LInterestonLoans += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Interest Expenses (Current Year - CUMULATIVE)
                InterestExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InterestExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InterestExpenses += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Interest Expenses (Previous Year - CUMULATIVE)
                LInterestExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InterestExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LInterestExpenses += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Other Operating Income (Current Year - CUMULATIVE)
                OtherOperatingincome := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::OtherOperatingincome);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherOperatingincome += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Other Operating Income (Previous Year - CUMULATIVE) - FIXED!
                LOtherOperatingincome := 0;  // ← FIXED: Was OtherOperatingincome
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::OtherOperatingincome);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LOtherOperatingincome += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Receivables And Prepayments (Period-based)
                ReceivableandPrepayments := 0;
                LReceivableandPrepayments := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::ReceivablesAndPrepayements);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofcurrentYear, ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ReceivableandPrepayments += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::ReceivablesAndPrepayements);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofPreviousYear, EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LReceivableandPrepayments += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Loans and Advances (Period-based)
                LoanandAdvances := 0;
                LLoanandAdvances := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::LoansAndAdvances);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofcurrentYear, ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LoanandAdvances += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::LoansAndAdvances);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofPreviousYear, EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LLoanandAdvances += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Financial Assets (Period-based)
                FinancialAssets := 0;
                LFinancialAssets := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::FinancialAssets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofcurrentYear, ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            FinancialAssets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::FinancialAssets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofPreviousYear, EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LFinancialAssets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Trade and Other Payables (Period-based)
                TradeandOtherPayables := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::TradeandotherPayables);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofcurrentYear, ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TradeandOtherPayables += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                LTradeandOtherPayables := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::TradeandotherPayables);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofPreviousYear, EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LTradeandOtherPayables += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Honoraria (Period-based)
                Hononaria := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Honoria);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofcurrentYear, ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Hononaria += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                LHononaria := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Honoria);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofPreviousYear, EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LHononaria += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Member Deposits (Period-based)
                Nonwithdrawabledeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::MemberDeposits);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofcurrentYear, ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Nonwithdrawabledeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                LNonwithdrawabledeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::MemberDeposits);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofPreviousYear, EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LNonwithdrawabledeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Dividends and Interest Payable (Period-based)
                InterestonMemberdeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::dividendsandInterestPayable);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofcurrentYear, ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InterestonMemberdeposits += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                LInterestonMemberdeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::dividendsandInterestPayable);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartofPreviousYear, EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LInterestonMemberdeposits += -1 * GLEntry.Amount;  // FIXED: Was +1
                        end;
                    until GLAccount.Next = 0;
                end;

                //Investment Income (CUMULATIVE)
                InvestmentIncome := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InvestmentIncome);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InvestmentIncome += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                LInvestmentIncome := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::InvestmentIncome);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LInvestmentIncome += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Share Capital (CUMULATIVE)
                ShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', ThisYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                LShareCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LShareCapital += -1 * GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Cash at Bank - Beginning of Period
                Cashatbank := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofcurrentYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Cashatbank += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                LCashatbank := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', StartofPreviousYear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LCashatbank += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                //Cash at Bank - End of Period
                endCashatbank := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            endCashatbank += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                EndLCashatbank := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '..%1', EndofLastyear);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            EndLCashatbank += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                // Debug: Show calculated totals
                Message('Current Year Totals - Loans: %1, Cash: %2, Share Capital: %3',
                        LoanandAdvances, Cashatbank, ShareCapital);
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
                    field(AsOfDate; AsAt)
                    {
                        ApplicationArea = All;
                        Caption = 'As of Date';
                        ToolTip = 'Enter the date for which you want to run the report. Previous year will be calculated automatically.';

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
            ShowZeroBalancesParam := true;
            UpdateDateRanges();
        end;
    }

    Var
        myInt: Integer;
        InputDate: Date;
        DateFormula: Text;
        DateExpr: Text;
        StartofcurrentYear: Date;
        StartofPreviousYear: Date;
        DateExpr2: Text;
        Cashatbank: Decimal;
        LCashatbank: Decimal;

        endCashatbank: Decimal;
        EndLCashatbank: Decimal;
        AsAt: Date;
        ReceivableandPrepayments: Decimal;
        LReceivableandPrepayments: Decimal;
        LInterestExpenses: Decimal;
        InterestExpenses: Decimal;
        PreviousYear: Integer;
        CurrentYear: Integer;
        EndofLastyear: date;
        ThisYear: Date;
        InterestonLoans: Decimal;
        LInterestonLoans: Decimal;
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        LoanandAdvances: Decimal;
        LLoanandAdvances: Decimal;
        FinancialAssets: Decimal;
        LFinancialAssets: Decimal;
        Hononaria: Decimal;
        LHononaria: Decimal;
        InvestmentIncome: Decimal;
        LInvestmentIncome: Decimal;
        TradeandOtherPayables: Decimal;
        LTradeandOtherPayables: Decimal;
        LInterestonMemberDeposits: Decimal;
        InterestonMemberdeposits: Decimal;
        LOtherOperatingincome: Decimal;
        OtherOperatingincome: Decimal;
        Nonwithdrawabledeposits: Decimal;
        LNonwithdrawabledeposits: Decimal;
        ShareCapital: Decimal;
        LShareCapital: Decimal;


        AsOfDateParam: Date;
        ShowZeroBalancesParam: Boolean;
        CurrentYearStart: Date;
        CurrentYearEnd: Date;
        PreviousYearStart: Date;
        PreviousYearEnd: Date;
        CurrentYearRangeText: Text;
        PreviousYearRangeText: Text;
        DateFilterText: Text;


    local procedure UpdateDateRanges()
    begin
        CurrentYearStart := CalcDate('<-CY>', AsAt);
        CurrentYearEnd := AsAt;
        PreviousYearStart := CalcDate('<-1Y-CY>', AsAt);
        PreviousYearEnd := CalcDate('<-1Y>', AsAt);

        CurrentYearRangeText := Format(CurrentYearStart, 0, '<Day,2>/<Month,2>/<Year4>') + ' - ' + Format(CurrentYearEnd, 0, '<Day,2>/<Month,2>/<Year4>');
        PreviousYearRangeText := Format(PreviousYearStart, 0, '<Day,2>/<Month,2>/<Year4>') + ' - ' + Format(PreviousYearEnd, 0, '<Day,2>/<Month,2>/<Year4>');
        DateFilterText := 'Current Year: ' + CurrentYearRangeText + ', Previous Year: ' + PreviousYearRangeText;
    end;


}



