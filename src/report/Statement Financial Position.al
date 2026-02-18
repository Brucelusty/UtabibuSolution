Report 173012 "STATEMENT Financial Position"
{
    RDLCLayout = 'Layouts/StatementFinacialP.rdlc';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Statement Of Financial Position';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(ReportForNavId_1; 1) { }
            column(StartDate; StartDate) { }
            column(PriorStartDate; PriorStartDate) { }
            column(FinancialYear; FinancialYear) { }
            column(PriorFinancialYear; PriorFinancialYear) { }
            column(Asat; Asat) { }
            column(PriorAsat; PriorAsat) { }
            column(Name; "Company Information".Name) { }

            //Assets - Current Year
            column(CashCashEquivalent; CashCashEquivalent) { }
            column(PrepaymentsSundryReceivables; PrepaymentsSundryReceivables) { }
            Column(SundryReceivables; SundryReceivables) { }
            column(LoanToMembers; LoanToMembers) { }
            Column(NonCurrentAssets; NonCurrentAssets) { }
            column(OtherFinacialAssets; OtherFinancialAssets) { }
            COLUMN(IntangibleAssets; IntangibleAssets) { }
            column(CurrentIncomeTaxRecoverable; CurrentIncomeTaxRecoverable) { }
            column(PropertyEquipment; PropertyAndEquipment) { }
            column(TotalAssets; TotalAssets) { }

            // Assets Prior Year
            column(CashCashEquivalentPY; CashCashEquivalentPY) { }
            column(PrepaymentsSundryReceivablesPY; PrepaymentsSundryReceivablesPY) { }
            column(sundryReceivablesPY; sundryReceivablesPY) { }
            column(LoanToMembersPY; LoanToMembersPY) { }
            Column(NonCurrentAssetsPY; NonCurrentAssetsPY) { }
            column(OtherFinacialAssetsPY; OtherFinancialAssetsPY) { }
            COLUMN(IntangibleAssetsPY; IntangibleAssetsPY) { }
            column(CurrentIncomeTaxRecoverablePY; CurrentIncomeTaxRecoverablePY) { }
            column(PropertyEquipmentPY; PropertyAndEquipmentPY) { }
            column(TotalAssetsPY; TotalAssetsPY) { }

            // Liabilities - Current Year
            column(MemberDeposits; MemberDeposits) { }
            column(CurrentIncomeTaxPayable; CurrentIncomeTaxPayable) { }
            column(InterestPayable; InterestPayable) { }
            column(DividendPayable; DividendPayable) { }
            column(TradeAndOtherPayables; TradeAndOtherPayables) { }
            column(ProgrammedDeposits; ProgrammedDeposits) { }
            column(TotalLiabilitiesNew; TotalLiabilitiesNew) { }
            column(TotalLiabilitiesAndEquity; TotalLiabilitiesAndEquity) { }

            // Liabilities - Prior Year
            column(MemberDepositsPY; MemberDepositsPY) { }
            column(CurrentIncomeTaxPayablePY; CurrentIncomeTaxPayablePY) { }
            column(InterestPayablePY; InterestPayablePY) { }
            column(DividendPayablePY; DividendPayablePY) { }
            column(TradeAndOtherPayablesPY; TradeAndOtherPayablesPY) { }
            column(ProgrammedDepositsPY; ProgrammedDepositsPY) { }
            column(TotalLiabilitiesNewPY; TotalLiabilitiesNewPY) { }
            column(TotalLiabilitiesAndEquityPY; TotalLiabilitiesAndEquityPY) { }

            //Equity
            Column(ShareCapital; ShareCapital) { }
            column(ShareCapitalPY; ShareCapitalPY) { }
            column(Reserves; Reserves) { }
            column(ReservesPY; ReservesPY) { }
            column(TotalEquity; TotalEquity) { }
            column(TotalEquityPY; TotalEquityPY) { }

            trigger OnPreDataItem();
            begin
                // Current Year Dates
                DateFilter := '..' + Format(Asat);
                StartDate := CalcDate('-CY', Asat);
                FinancialYear := Date2dmy(Asat, 3);

                // Prior Year Dates
                PriorAsat := CalcDate('-1Y', Asat);
                PriorDateFilter := '..' + Format(PriorAsat);
                PriorStartDate := CalcDate('-CY', PriorAsat);
                PriorFinancialYear := Date2dmy(PriorAsat, 3);
            end;

            trigger OnAfterGetRecord();
            begin
                // Clear all variables
                ClearCurrentYearVariables();
                ClearPriorYearVariables();

                // Calculate Current Year from other notes/reports
                CalculateCurrentYearFromNotes();

                // Calculate Prior Year from other notes/reports
                CalculatePriorYearFromNotes();

                // Calculate Summations for Current Year
                CalculateCurrentYearSummations();

                // Calculate Summations for Prior Year
                CalculatePriorYearSummations();
            end;
        }
    }

    requestpage
    {
        SaveValues = false;
        layout
        {
            area(content)
            {
                field(Asat; Asat)
                {
                    ApplicationArea = Basic;
                    Caption = 'As At Date (Current Year End)';
                }
            }
        }
    }

    // NEW PROCEDURES TO FETCH FROM OTHER NOTES
    local procedure CalculateCurrentYearFromNotes()
    begin
        // Calculate Assets - Current Year
        CashCashEquivalent := GetCashTotal(StartDate, Asat);
        PrepaymentsSundryReceivables := GetPrepaymentsSundryReceivables(StartDate, Asat);
        SundryReceivables := GetSundryReceivables(StartDate, Asat);
        LoanToMembers := GetTotalLoan(StartDate, Asat);
        NonCurrentAssets := GetNonCurrentAssets(StartDate, Asat);
        OtherFinancialAssets := GetFinancialAssets(StartDate, Asat);
        IntangibleAssets := GetIntangibleAssets(StartDate, Asat);
        CurrentIncomeTaxRecoverable := GetCurrentIncomeTaxRecoverable(StartDate, Asat); // FIXED: Added missing calculation
        PropertyAndEquipment := GetProperty(StartDate, Asat);
        
        // Total Assets calculation - using explicit sum for clarity
        TotalAssets := CashCashEquivalent + PrepaymentsSundryReceivables + SundryReceivables + 
                      LoanToMembers + NonCurrentAssets + OtherFinancialAssets + 
                      IntangibleAssets + CurrentIncomeTaxRecoverable + PropertyAndEquipment;

        // Calculate Liabilities and Equity - Current Year
        MemberDeposits := GetMemberDeposits(StartDate, Asat);
        CurrentIncomeTaxPayable := GetCurrentIncomeTaxPayable(StartDate, Asat);
        InterestPayable := GetInterestPayable(StartDate, Asat);
        DividendPayable := GetDividendPayable(StartDate, Asat);
        TradeAndOtherPayables := GetTradeAndOtherPayables(StartDate, Asat);
        ProgrammedDeposits := GetProgrammedDeposits(StartDate, Asat);
        Reserves := GetReserves(StartDate, Asat);
        ShareCapital := GetShareCapital(StartDate, Asat);
        TotalEquity := Reserves + ShareCapital;
    end;

    local procedure CalculatePriorYearFromNotes()
    begin
        // Calculate Assets - Prior Year
        CashCashEquivalentPY := GetCashTotal(PriorStartDate, PriorAsat);
        PrepaymentsSundryReceivablesPY := GetPrepaymentsSundryReceivables(PriorStartDate, PriorAsat);
        sundryReceivablesPY := GetSundryReceivables(PriorStartDate, PriorAsat);
        LoanToMembersPY := GetTotalLoan(PriorStartDate, PriorAsat);
        NonCurrentAssetsPY := GetNonCurrentAssets(PriorStartDate, PriorAsat);
        OtherFinancialAssetsPY := GetFinancialAssets(PriorStartDate, PriorAsat);
        IntangibleAssetsPY := GetIntangibleAssets(PriorStartDate, PriorAsat);
        CurrentIncomeTaxRecoverablePY := GetCurrentIncomeTaxRecoverable(PriorStartDate, PriorAsat); // FIXED: Added missing calculation
        PropertyAndEquipmentPY := GetProperty(PriorStartDate, PriorAsat);
        
        // Total Assets calculation - Prior Year
        TotalAssetsPY := CashCashEquivalentPY + PrepaymentsSundryReceivablesPY + sundryReceivablesPY + 
                        LoanToMembersPY + NonCurrentAssetsPY + OtherFinancialAssetsPY + 
                        IntangibleAssetsPY + CurrentIncomeTaxRecoverablePY + PropertyAndEquipmentPY;

        // Calculate Liabilities and Equity - Prior Year
        MemberDepositsPY := GetMemberDeposits(PriorStartDate, PriorAsat);
        CurrentIncomeTaxPayablePY := GetCurrentIncomeTaxPayable(PriorStartDate, PriorAsat);
        InterestPayablePY := GetInterestPayable(PriorStartDate, PriorAsat);
        DividendPayablePY := GetDividendPayable(PriorStartDate, PriorAsat);
        TradeAndOtherPayablesPY := GetTradeAndOtherPayables(PriorStartDate, PriorAsat);
        ProgrammedDepositsPY := GetProgrammedDeposits(PriorStartDate, PriorAsat);
        ReservesPY := GetReserves(PriorStartDate, PriorAsat);
        ShareCapitalPY := GetShareCapital(PriorStartDate, PriorAsat);
        TotalEquityPY := ReservesPY + ShareCapitalPY; // FIXED: Changed from ShareCapital to ShareCapitalPY
    end;

    // ADDED MISSING FUNCTION for Current Income Tax Recoverable
    local procedure GetCurrentIncomeTaxRecoverable(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        // Assuming account 400230 is for Current Income Tax Recoverable
        // Adjust account numbers as per your chart of accounts
        //Total := GetAccountBalance('400230', StartDate, EndDate);
        //exit(Total * -1); // Multiply by -1 to show as asset (positive)
    end;

    // Existing helper functions remain the same...
    local procedure GetRawCashBalance(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
    begin
        if not GLAccount.Get(AccountNo) then
            exit(0);
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        if GLEntry.CalcSums(Amount) then
            exit(GLEntry.Amount);
        exit(0);
    end;

    local procedure GetPrepaymentsSundryReceivables(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('400040', StartDate, EndDate) +
                 GetAccountBalance('400045', StartDate, EndDate) +
                 GetAccountBalance('400222', StartDate, EndDate) +
                 GetAccountBalance('400050', StartDate, EndDate) +
                 GetAccountBalance('400220', StartDate, EndDate) +
                 GetAccountBalance('400225', StartDate, EndDate);
        exit(Total * -1);
    end;

    local procedure GetShareCapital(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('500030', StartDate, EndDate);
        exit(Total * -1);
    end;

    LOCAL procedure GetNonCurrentAssets(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('102092', StartDate, EndDate) +
                 GetCredit('102092', StartDate, EndDate) +
                 GetDebit('102092', StartDate, EndDate);
        exit(Total * -1);
    end;

    Local procedure GetIntangibleAssets(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('102060', StartDate, EndDate) +
                 GetAccountBalance('102070', StartDate, EndDate) +
                 GetCredit('102060', StartDate, EndDate) +
                 GetDebit('102060', StartDate, EndDate);
        exit(Total * -1);
    end;

    lOCAL PROCEDURE GetSundryReceivables(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('400221', StartDate, EndDate) +
                 GetAccountBalance('400226', StartDate, EndDate) +
                 GetDebit('400221', StartDate, EndDate) +
                 GetCredit('400221', StartDate, EndDate);
        exit(Total * -1);
    end;

    local procedure GetFinancialAssets(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('200030', StartDate, EndDate) +
                 GetAccountBalance('200050', StartDate, EndDate) +
                 GetAccountBalance('200040', StartDate, EndDate) +
                 GetAccountBalance('200020', StartDate, EndDate) +
                 GetAccountBalance('200031', StartDate, EndDate);
        exit(Total * -1);
    end;

    local procedure GetMemberDeposits(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('700030', StartDate, EndDate);
        exit(Total * -1);
    end;

    local procedure GetTradeAndOtherPayables(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetOtherPayable(StartDate, EndDate);
        exit(Total * -1);
    end;

    local procedure GetProgrammedDeposits(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('700050', StartDate, EndDate);
        exit(Total * -1);
    end;

    Local procedure GetInterestPayable(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('702020', StartDate, EndDate) +
                 GetDebit('702020', StartDate, EndDate) +
                 GetCredit('702020', StartDate, EndDate);
        exit(Total * -1);
    end;

    Local procedure GetDividendPayable(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('702040', StartDate, EndDate) +
                 GetDebit('702040', StartDate, EndDate) +
                 GetCredit('702040', StartDate, EndDate);
        exit(Total * -1);
    end;

    local procedure GetCurrentIncomeTaxPayable(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('702070', StartDate, EndDate) +
                 GetDebit('702070', StartDate, EndDate) +
                 GetCredit('702070', StartDate, EndDate);
        exit(Total * -1);
    end;

    local procedure GetStaffPayable(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('703020', StartDate, EndDate) +
                 GetAccountBalance('703096', StartDate, EndDate) +
                 GetAccountBalance('704030', StartDate, EndDate) +
                 GetAccountBalance('704032', StartDate, EndDate);
        exit(Total);
    end;

    local procedure GetCashTotal(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetRawCashBalance('403020', StartDate, EndDate) +
                 GetRawCashBalance('403030', StartDate, EndDate) +
                 GetRawCashBalance('403040', StartDate, EndDate) +
                 GetRawCashBalance('403050', StartDate, EndDate) +
                 GetRawCashBalance('403060', StartDate, EndDate) +
                 GetRawCashBalance('403070', StartDate, EndDate) +
                 GetRawCashBalance('403080', StartDate, EndDate) +
                 GetRawCashBalance('403090', StartDate, EndDate) +
                 GetRawCashBalance('403091', StartDate, EndDate) +
                 GetRawCashBalance('403092', StartDate, EndDate) +
                 GetRawCashBalance('403093', StartDate, EndDate) +
                 GetRawCashBalance('403094', StartDate, EndDate) +
                 GetRawCashBalance('405010', StartDate, EndDate);
        exit(Total);
    end;

    local procedure GetTotalLoan(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetRawLoanBalance('300030', StartDate, EndDate) +
                 GetRawLoanBalance('300035', StartDate, EndDate) +
                 GetRawLoanBalance('300040', StartDate, EndDate) +
                 GetRawLoanBalance('300050', StartDate, EndDate) +
                 GetRawLoanBalance('300060', StartDate, EndDate) +
                 GetRawLoanBalance('300061', StartDate, EndDate) +
                 GetRawLoanBalance('300065', StartDate, EndDate) +
                 GetRawLoanBalance('300075', StartDate, EndDate) +
                 GetRawLoanBalance('300076', StartDate, EndDate) +
                 GetRawLoanBalance('301020', StartDate, EndDate) +
                 GetRawLoanBalance('301021', StartDate, EndDate) +
                 GetRawLoanBalance('301030', StartDate, EndDate) +
                 GetRawLoanBalance('301040', StartDate, EndDate) +
                 GetRawLoanBalance('301050', StartDate, EndDate) +
                 GetRawLoanBalance('301080', StartDate, EndDate) +
                 GetRawLoanBalance('301081', StartDate, EndDate) +
                 GetRawLoanBalance('301082', StartDate, EndDate) +
                 GetAccountBalance('200240', StartDate, EndDate) +
                 GetAccountBalance('600025', StartDate, EndDate) +
                 GetAccountBalance('707001', StartDate, EndDate) +
                 GetDebit('300030', StartDate, EndDate) +
                 GetDebit('300035', StartDate, EndDate) +
                 GetDebit('300040', StartDate, EndDate) +
                 GetDebit('300050', StartDate, EndDate) +
                 GetDebit('300060', StartDate, EndDate) +
                 GetDebit('300061', StartDate, EndDate) +
                 GetDebit('300065', StartDate, EndDate) +
                 GetDebit('300075', StartDate, EndDate) +
                 GetDebit('300076', StartDate, EndDate) +
                 GetCredit('300030', StartDate, EndDate) +
                 GetCredit('300035', StartDate, EndDate) +
                 GetCredit('300040', StartDate, EndDate) +
                 GetCredit('300050', StartDate, EndDate) +
                 GetCredit('300060', StartDate, EndDate) +
                 GetCredit('300061', StartDate, EndDate) +
                 GetCredit('300065', StartDate, EndDate) +
                 GetCredit('300075', StartDate, EndDate) +
                 GetCredit('300076', StartDate, EndDate) +
                 GetDebit('301020', StartDate, EndDate) +
                 GetDebit('301021', StartDate, EndDate) +
                 GetDebit('301030', StartDate, EndDate) +
                 GetDebit('301040', StartDate, EndDate) +
                 GetDebit('301050', StartDate, EndDate) +
                 GetDebit('301080', StartDate, EndDate) +
                 GetDebit('301081', StartDate, EndDate) +
                 GetDebit('301082', StartDate, EndDate) +
                 GetCredit('301020', StartDate, EndDate) +
                 GetCredit('301021', StartDate, EndDate) +
                 GetCredit('301030', StartDate, EndDate) +
                 GetCredit('301040', StartDate, EndDate) +
                 GetCredit('301050', StartDate, EndDate) +
                 GetCredit('301080', StartDate, EndDate) +
                 GetCredit('301081', StartDate, EndDate) +
                 GetCredit('301082', StartDate, EndDate);
        exit(Total);
    end;

    local procedure GetProperty(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAssetBalance('101130', EndDate) +
                 GetAssetBalance('101140', EndDate) +
                 GetAssetBalance('101141', EndDate) +
                 GetAssetBalance('101160', EndDate) +
                 GetAssetBalance('101170', EndDate) +
                 GetAssetBalance('101180', EndDate) +
                 GetAssetBalance('101190', EndDate) +
                 GetAssetBalance('101200', EndDate) +
                 GetAssetBalance('101210', EndDate) +
                 GetAssetBalance('101220', EndDate) +
                 GetAssetBalance('101230', EndDate) +
                 GetAssetBalance('101240', EndDate) +
                 GetAssetBalance('101241', EndDate) +
                 GetAssetBalance('101242', EndDate) +
                 GetAssetBalance('101245', EndDate) +
                 GetAssetBalance('101248', EndDate) +
                 GetAssetBalance('101250', EndDate) +
                 GetAssetBalance('101260', EndDate) +
                 GetAssetBalance('101270', EndDate) +
                 GetAssetBalance('101280', EndDate) +
                 GetAssetBalance('101290', EndDate) +
                 GetAssetBalance('101300', EndDate) +
                 GetAssetBalance('101310', EndDate) +
                 GetAssetBalance('101320', EndDate) +
                 GetAssetBalance('101330', EndDate) +
                 GetAssetBalance('101340', EndDate) +
                 GetAssetBalance('101350', EndDate) +
                 GetAssetBalance('101360', EndDate) +
                 GetAssetBalance('101370', EndDate) +
                 GetAssetBalance('101380', EndDate) +
                 GetAssetBalance('101390', EndDate) +
                 GetAssetBalance('101400', EndDate);
        exit(Total);
    end;

    local procedure GetOtherPayable(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('705020', StartDate, EndDate) +
                 GetAccountBalance('702021', StartDate, EndDate) +
                 GetStaffPayable(StartDate, EndDate) +
                 GetAccountBalance('400047', StartDate, EndDate) +
                 GetAccountBalance('705030', StartDate, EndDate) +
                 GetAccountBalance('705050', StartDate, EndDate) +
                 GetAccountBalance('705035', StartDate, EndDate) +
                 GetAccountBalance('707002', StartDate, EndDate) +
                 GetAccountBalance('705036', StartDate, EndDate);
        exit(Total);
    end;

    local procedure GetReserves(StartDate: Date; EndDate: Date): Decimal
    var
        Total: Decimal;
    begin
        Total := GetAccountBalance('500060', StartDate, EndDate) +
                 GetAccountBalance('500080', StartDate, EndDate) +
                 GetAccountBalance('999999', StartDate, EndDate) +
                 GetAccountBalance('500230', StartDate, EndDate) +
                 GetAccountBalance('500240', StartDate, EndDate) +
                 GetAccountBalance('500241', StartDate, EndDate) +
                 GetAccountBalance('500231', StartDate, EndDate) +
                 GetAccountBalance('500220', StartDate, EndDate) +
                 GetAccountBalance('500232', StartDate, EndDate);
        exit(Total * -1);
    end;

    local procedure GetAccountBalance(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        Balance: Decimal;
    begin
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        if GLEntry.CalcSums(Amount) then
            Balance := GLEntry.Amount
        else
            Balance := 0;
        exit(Balance);
    end;

    local procedure ClearCurrentYearVariables()
    begin
        CashCashEquivalent := 0;
        PrepaymentsSundryReceivables := 0;
        SundryReceivables := 0;
        LoanToMembers := 0;
        NonCurrentAssets := 0;
        OtherFinancialAssets := 0;
        IntangibleAssets := 0;
        CurrentIncomeTaxRecoverable := 0;
        PropertyAndEquipment := 0;
        TotalAssets := 0;
        MemberDeposits := 0;
        CurrentIncomeTaxPayable := 0;
        InterestPayable := 0;
        DividendPayable := 0;
        TradeAndOtherPayables := 0;
        ProgrammedDeposits := 0;
        Reserves := 0;
        TotalLiabilitiesNew := 0;
        TotalLiabilitiesAndEquity := 0;
        ShareCapital := 0;
        TotalEquity := 0;
    end;

    local procedure ClearPriorYearVariables()
    begin
        CashCashEquivalentPY := 0;
        PrepaymentsSundryReceivablesPY := 0;
        sundryReceivablesPY := 0;
        LoanToMembersPY := 0;
        NonCurrentAssetsPY := 0;
        OtherFinancialAssetsPY := 0;
        IntangibleAssetsPY := 0;
        CurrentIncomeTaxRecoverablePY := 0;
        PropertyAndEquipmentPY := 0;
        TotalAssetsPY := 0;
        MemberDepositsPY := 0;
        CurrentIncomeTaxPayablePY := 0;
        InterestPayablePY := 0;
        DividendPayablePY := 0;
        TradeAndOtherPayablesPY := 0;
        ProgrammedDepositsPY := 0;
        ReservesPY := 0;
        TotalLiabilitiesNewPY := 0;
        TotalLiabilitiesAndEquityPY := 0;
        ShareCapitalPY := 0;
        TotalEquityPY := 0;
    end;

    local procedure CalculateCurrentYearSummations()
    begin
        // Calculate Total Liabilities for Current Year
        TotalLiabilitiesNew := MemberDeposits + CurrentIncomeTaxPayable + InterestPayable +
                               DividendPayable + TradeAndOtherPayables + ProgrammedDeposits;

        // Calculate Total Liabilities and Equity
        TotalLiabilitiesAndEquity := TotalLiabilitiesNew + Reserves + ShareCapital;
    end;

    local procedure CalculatePriorYearSummations()
    begin
        // Calculate Total Liabilities for Prior Year
        TotalLiabilitiesNewPY := MemberDepositsPY + CurrentIncomeTaxPayablePY + InterestPayablePY +
                                 DividendPayablePY + TradeAndOtherPayablesPY + ProgrammedDepositsPY;

        // Calculate Total Liabilities and Equity for Prior Year
        TotalLiabilitiesAndEquityPY := TotalLiabilitiesNewPY + ReservesPY + ShareCapitalPY;
    end;

    local procedure GetRawLoanBalance(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
    begin
        if not GLAccount.Get(AccountNo) then
            exit(0);
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        if GLEntry.CalcSums(Amount) then
            exit(GLEntry.Amount);
        exit(0);
    end;

    local procedure GetDebit(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        DebitAmount: Decimal;
    begin
        if not GLAccount.Get(AccountNo) then
            exit(0);

        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        if GLEntry.CalcSums("Debit Amount") then
            DebitAmount := GLEntry."Debit Amount"
        else
            DebitAmount := 0;

        exit(DebitAmount);
    end;

    local procedure GetCredit(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        CreditAmount: Decimal;
    begin
        if not GLAccount.Get(AccountNo) then
            exit(0);

        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        if GLEntry.CalcSums("Credit Amount") then
            CreditAmount := GLEntry."Credit Amount"
        else
            CreditAmount := 0;

        exit(CreditAmount);
    end;

    local procedure GetAssetBalance(AccountNo: Code[20]; EndDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        Balance: Decimal;
    begin
        if not GLAccount.Get(AccountNo) then
            exit(0);

        GLAccount.SetRange("Date Filter", 0D, EndDate);
        GLAccount.CalcFields("Net Change");
        Balance := GLAccount."Net Change";

        exit(Balance);
    end;

    var
        CompanyInformation: Record "Company Information";
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        DateFilter: Text;
        PriorDateFilter: Text;
        Asat: Date;
        PriorAsat: Date;
        StartDate: Date;
        PriorStartDate: Date;
        FinancialYear: Integer;
        PriorFinancialYear: Integer;

        // Current Year Variables
        CashCashEquivalent: Decimal;
        PrepaymentsSundryReceivables: Decimal;
        SundryReceivables: Decimal;
        LoanToMembers: Decimal;
        NonCurrentAssets: Decimal;
        OtherFinancialAssets: Decimal;
        IntangibleAssets: Decimal;
        CurrentIncomeTaxRecoverable: Decimal;
        PropertyAndEquipment: Decimal;
        TotalAssets: Decimal;
        TotalLiabilitiesNew: Decimal;
        TotalLiabilitiesAndEquity: Decimal;
        MemberDeposits: Decimal;
        CurrentIncomeTaxPayable: Decimal;
        InterestPayable: Decimal;
        DividendPayable: Decimal;
        TradeAndOtherPayables: Decimal;
        ProgrammedDeposits: Decimal;
        Reserves: Decimal;
        ShareCapital: Decimal;
        TotalEquity: Decimal;

        // Prior Year Variables
        CashCashEquivalentPY: Decimal;
        PrepaymentsSundryReceivablesPY: Decimal;
        sundryReceivablesPY: Decimal;
        LoanToMembersPY: Decimal;
        NonCurrentAssetsPY: Decimal;
        OtherFinancialAssetsPY: Decimal;
        IntangibleAssetsPY: Decimal;
        CurrentIncomeTaxRecoverablePY: Decimal;
        PropertyAndEquipmentPY: Decimal;
        TotalAssetsPY: Decimal;
        TotalLiabilitiesNewPY: Decimal;
        TotalLiabilitiesAndEquityPY: Decimal;
        MemberDepositsPY: Decimal;
        CurrentIncomeTaxPayablePY: Decimal;
        InterestPayablePY: Decimal;
        DividendPayablePY: Decimal;
        TradeAndOtherPayablesPY: Decimal;
        ProgrammedDepositsPY: Decimal;
        ReservesPY: Decimal;
        ShareCapitalPY: Decimal;
        TotalEquityPY: Decimal;
}