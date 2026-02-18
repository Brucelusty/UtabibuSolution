report 173011 "Note 13"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Note of The Financial Statement';
    DefaultLayout = RDLC;
    RdlcLayout = 'Layouts/Note13.rdlc';

    dataset
    {
        dataitem(ReportHeader; "Company Information")
        {
            column(CompanyName; CompanyInfo.Name) { }
            column(ReportTitle; 'Note of The Financial Statement') { }
            column(AsOfDate; 'As of: ' + Format(AsOfDateParam, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(CurrentYearLabel; 'Current Year: ' + Format(Date2DMY(AsOfDateParam, 3))) { }
            column(PreviousYearLabel; 'Previous Year: ' + Format(Date2DMY(AsOfDateParam, 3) - 1)) { }
            column(DateFilter; DateFilterText) { }

            // Table Headers
            column(Header_AccountName; 'Account Name') { }
            column(Header_AccountNo; 'Account No.') { }
            column(Header_CurrentYear; Format(Date2DMY(AsOfDateParam, 3))) { }
            column(Header_PreviousYear; Format(Date2DMY(AsOfDateParam, 3) - 1)) { }

            // ===== MEMBER DEPOSITS SECTION =====
            column(MemberDeposits_Header; 'MEMBER DEPOSITS') { }

            column(NonWithdrawable_Name; 'Non Withdrawable Deposits') { }
            column(NonWithdrawable_Current; GetAccountBalance('700030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(NonWithdrawable_Previous; GetAccountBalance('700030', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // Current Year Values
            column(Refunds_Debit_CY; GetSpecificDebit('700030', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Contribution_Credit_CY; GetSpecificCredit('700030', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            // Previous Year Values
            column(Refunds_Debit_PY; GetSpecificDebit('700030', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Contribution_Credit_PY; GetSpecificCredit('700030', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // Member Deposits Total
            column(MemberDeposits_Total_Name; 'Total Member Deposits') { }
            column(MemberDeposits_Total_Current; MemberDeposits_Total_Current) { DecimalPlaces = 2 : 2; }
            column(MemberDeposits_Total_Previous; MemberDeposits_Total_Previous) { DecimalPlaces = 2 : 2; }

            // ===== OTHER PAYABLES SECTION =====
            column(OtherPayables_Header; 'OTHER PAYABLES') { }

            column(Creditors_Name; 'Creditors') { }
            column(Creditors_Current; GetAccountBalance('705020', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Creditors_Previous; GetAccountBalance('705020', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(InterestWHT_Name; 'Interest on Programmed Deposits') { }
            column(InterestWHT_Current; GetAccountBalance('702021', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InterestWHT_Previous; GetAccountBalance('702021', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StaffPayable_Name; 'Staff-Statutory Deduction Payable') { }
            column(StaffPayable_Current; StaffPayable_Current) { DecimalPlaces = 2 : 2; }
            column(StaffPayable_Previous; StaffPayable_Previous) { DecimalPlaces = 2 : 2; }

            column(PrepaidRent_Name; 'Prepaid Rent') { }
            column(PrepaidRent_Current; GetAccountBalance('400047', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(PrepaidRent_Previous; GetAccountBalance('400047', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(AccExpenses_Name; 'Accrued Expenses') { }
            column(AccExpenses_Current; GetAccountBalance('705030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(AccExpenses_Previous; GetAccountBalance('705030', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(UnallocatedFunds_Name; 'Unallocated Funds') { }
            column(UnallocatedFunds_Current; GetAccountBalance('705050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(UnallocatedFunds_Previous; GetAccountBalance('705050', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(BoardWelfare_Name; 'Board Welfare') { }
            column(BoardWelfare_Current; GetAccountBalance('705036', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BoardWelfare_Previous; GetAccountBalance('705036', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StandingOrder_Name; 'Member Standing Order & Defaulted Loan Recovery') { }
            column(StandingOrder_Current; StandingOrder_Current) { DecimalPlaces = 2 : 2; }
            column(StandingOrder_Previous; StandingOrder_Previous) { DecimalPlaces = 2 : 2; }

            // Other Payables Total
            column(OtherPayables_Total_Name; 'Total Other Payables') { }
            column(OtherPayables_Total_Current; OtherPayables_Total_Current) { DecimalPlaces = 2 : 2; }
            column(OtherPayables_Total_Previous; OtherPayables_Total_Previous) { DecimalPlaces = 2 : 2; }

            // ===== SUNDRY CREDITORS SECTION =====
            column(SundryCreditors_Header; 'SUNDRY CREDITORS') { }

            column(LoanPayment_Name; 'Loan Part Payment') { }
            column(LoanPayment_Current; GetAccountBalance('707001', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(LoanPayment_Previous; GetAccountBalance('707001', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(ProgrammedDepo_Name; 'Programmed Deposists') { }
            column(ProgrammedDepo_Current; GetAccountBalance('700050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(ProgrammedDepo_Previous; GetAccountBalance('700050', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // Sundry Creditors Total
            column(SundryCreditors_Total_Name; 'Total Sundry Creditors') { }
            column(SundryCreditors_Total_Current; SundryCreditors_Total_Current) { DecimalPlaces = 2 : 2; }
            column(SundryCreditors_Total_Previous; SundryCreditors_Total_Previous) { DecimalPlaces = 2 : 2; }

            //Sundry Receivables
            Column(SundryReceivables_Name; 'Sundry Receivables') { }
            Column(SundryReceivables_Current; GetAccountBalance('400221', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(SundryReceivables_Previous; GetAccountBalance('400221', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(SaccoPersonalLoan_Debit_CY; GetSpecificDebit('400221', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(LessAmount_Credit_CY; GetSpecificCredit('400221', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            // Previous Year Values
            column(SaccoPersonalLoan_Debit_PY; GetSpecificDebit('400221', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(LessAmount_Credit_PY; GetSpecificCredit('400221', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(LessProvision_Current; GetAccountBalance('400226', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(LessProvision_Previous; GetAccountBalance('400226', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(SundryReceivables_Total_Name; 'Total Sundry Receivables') { }
            column(SundryReceivables_Total_Current; SundryReceivables_Total_Current) { DecimalPlaces = 2 : 2; }
            column(SundryReceivables_Total_Previous; SundryReceivables_Total_Previous) { DecimalPlaces = 2 : 2; }

            //Interest Payable
            Column(InterestPayable_Name; 'Interest Payable') { }
            Column(InterestPayable_Current; GetAccountBalance('702020', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(InterestPayable_Previous; GetAccountBalance('702020', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Paid_Debit_CY; GetSpecificDebit('702020', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Provision_Credit_CY; GetSpecificCredit('702020', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            // Previous Year Values
            column(Paid_Debit_PY; GetSpecificDebit('702020', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Provision_Credit_PY; GetSpecificCredit('702020', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Interest_Total_Name; 'Total Interest Payable') { }
            column(InterestPayable_Total_Current; SundryReceivables_Total_Current) { DecimalPlaces = 2 : 2; }
            column(InterestPayable_Total_Previous; SundryReceivables_Total_Previous) { DecimalPlaces = 2 : 2; }

            //Dividend Payable
            Column(DividendPayable_Name; 'Dividend Payable') { }
            Column(DividendPayable_Current; GetAccountBalance('702040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(DividendPayable_Previous; GetAccountBalance('702040', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Dividend_Debit_CY; GetSpecificDebit('702040', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Dividend_Credit_CY; GetSpecificCredit('702040', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            // Previous Year Values
            column(Dividend_Debit_PY; GetSpecificDebit('702040', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Dividend_Credit_PY; GetSpecificCredit('702040', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Dividend_Total_Name; 'Total Dividend Payable') { }
            column(DividendPayable_Total_Current; SundryReceivables_Total_Current) { DecimalPlaces = 2 : 2; }
            column(DividendPayable_Total_Previous; SundryReceivables_Total_Previous) { DecimalPlaces = 2 : 2; }

            //Reserves
            Column(PriorYearRetainedEarnings_Name; 'Prior Year Retained Earnings') { }
            Column(PriorYearRetainedEarnings_Current; GetClosingBalance('500060', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(PriorYearRetainedEarnings_Previous; GetClosingBalance('500060', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            //Prior Years Adjustment
            Column(PriorYearsAdjustment_Name; 'Prior Years Adjustment') { }
            Column(PriorYearsAdjustment_Current; GetClosingBalance('500080', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(PriorYearsAdjustment_Previous; GetClosingBalance('500080', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            //Current Year Net Surplus/Deficit
            Column(CurrentYearNetSurplusDeficit_Name; 'Current Year Net Surplus') { }
            Column(CurrentYearNetSurplusDeficit_Current; GetClosingBalance('999999', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(CurrentYearNetSurplusDeficit_Previous; GetClosingBalance('999999', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            //Statutory Reserve
            Column(StatutoryReserve_Name; 'Statutory Reserve') { }
            Column(StatutoryReserve_Current; GetClosingBalance('500230', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(StatutoryReserve_Previous; GetClosingBalance('500230', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            //Insurance Reserve
            Column(InsuranceReserve_Name; 'Insurance Fund') { }
            Column(InsuranceReserve_Current; GetAccountBalance('500240|500241', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(InsuranceReserve_Previous; GetAccountBalance('500240|500241', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            //Fair Value Reserve
            Column(FairValueReserve_Name; 'Fair Value Reserve') { }
            Column(FairValueReserve_Current; GetAccountBalance('500231', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(FairValueReserve_Previous; GetAccountBalance('500231', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            //Capital Reserve
            Column(CapitalReserve_Name; 'Capital Reserve') { }
            Column(CapitalReserve_Current; GetAccountBalance('500220', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(CapitalReserve_Previous; GetAccountBalance('500220', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            //General Reserve
            Column(GeneralReserve_Name; 'General Reserve') { }
            Column(GeneralReserve_Current; GetAccountBalance('500232', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(GeneralReserve_Previous; GetAccountBalance('500232', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            //Total Reserves
            Column(TotalReserves_Name; 'Total Reserves') { }
            Column(TotalReserves_Current;
                GetClosingBalance('500060', CurrentYearEnd) +
                GetClosingBalance('500080', CurrentYearEnd) +
                GetClosingBalance('999999', CurrentYearEnd) +
                GetClosingBalance('500230', CurrentYearEnd) +
                GetAccountBalance('500231', CurrentYearStart, CurrentYearEnd) +
                GetAccountBalance('500241', CurrentYearStart, CurrentYearEnd) +
                GetAccountBalance('500240', CurrentYearStart, CurrentYearEnd) +
                GetAccountBalance('500220', CurrentYearStart, CurrentYearEnd) +
                GetAccountBalance('500232', CurrentYearStart, CurrentYearEnd)
            )
            { DecimalPlaces = 2 : 2; }
            Column(TotalReserves_Previous; GetAccountBalance('500060', PreviousYearStart, PreviousYearEnd) +
                                          GetAccountBalance('500080', PreviousYearStart, PreviousYearEnd) +
                                          GetAccountBalance('999999', PreviousYearStart, PreviousYearEnd) +
                                          GetAccountBalance('500230', PreviousYearStart, PreviousYearEnd) +
                                          InsuranceReserve_Previous +
                                          GetAccountBalance('500231', PreviousYearStart, PreviousYearEnd) +
                                          GetAccountBalance('500220', PreviousYearStart, PreviousYearEnd) +
                                          GetAccountBalance('500232', PreviousYearStart, PreviousYearEnd))
            { DecimalPlaces = 2 : 2; }

            trigger OnAfterGetRecord()
            begin
                if AsOfDateParam = 0D then
                    AsOfDateParam := WorkDate();
                    
// git remote add origin https://github.com/Brucelusty/Doctors-SACCO.git
// git branch -M main
// git push -u origin main
                UpdateDateRanges();

                // Calculate aggregated values
                CalculateCurrentPeriod();
                CalculatePreviousPeriod();

                // Calculate category totals
                CalculateCategoryTotals();
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

    var
        AsOfDateParam: Date;
        ShowZeroBalancesParam: Boolean;
        CurrentYearStart: Date;
        CurrentYearEnd: Date;
        PreviousYearStart: Date;
        PreviousYearEnd: Date;
        CurrentYearRangeText: Text;
        PreviousYearRangeText: Text;
        DateFilterText: Text;
        CompanyInfo: Record "Company Information";
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        StaffPayable_Current: Decimal;
        StaffPayable_Previous: Decimal;
        StandingOrder_Current: Decimal;
        StandingOrder_Previous: Decimal;
        MemberDeposits_Total_Current: Decimal;
        MemberDeposits_Total_Previous: Decimal;
        OtherPayables_Total_Current: Decimal;
        OtherPayables_Total_Previous: Decimal;
        SundryCreditors_Total_Current: Decimal;
        SundryCreditors_Total_Previous: Decimal;
        SundryReceivables_Total_Current: Decimal;
        SundryReceivables_Total_Previous: Decimal;

        InterestPayable_Total_Current: Decimal;
        InterestPayable_Total_Previous: Decimal;
        DividendPayable_Total_Current: Decimal;
        DividendPayable_Total_Previous: Decimal;
        InsuranceReserve_Current: Decimal;
        InsuranceReserve_Previous: Decimal;



    local procedure UpdateDateRanges()
    begin
        CurrentYearStart := CalcDate('<-CY>', AsOfDateParam);
        CurrentYearEnd := AsOfDateParam;
        PreviousYearStart := CalcDate('<-1Y-CY>', AsOfDateParam);
        PreviousYearEnd := CalcDate('<-1Y>', AsOfDateParam);

        CurrentYearRangeText := Format(CurrentYearStart, 0, '<Day,2>/<Month,2>/<Year4>') + ' - ' + Format(CurrentYearEnd, 0, '<Day,2>/<Month,2>/<Year4>');
        PreviousYearRangeText := Format(PreviousYearStart, 0, '<Day,2>/<Month,2>/<Year4>') + ' - ' + Format(PreviousYearEnd, 0, '<Day,2>/<Month,2>/<Year4>');
        DateFilterText := 'Current Year: ' + CurrentYearRangeText + ', Previous Year: ' + PreviousYearRangeText;
    end;

    local procedure GetAccountBalance(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        Balance: Decimal;
    begin
        if not GLAccount.Get(AccountNo) then
            exit(0);

        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        if GLEntry.CalcSums(Amount) then
            Balance := GLEntry.Amount
        else
            Balance := 0;

        if not ShowZeroBalancesParam and (Balance = 0) then
            exit(0);

        exit(Balance);
    end;

    local procedure GetSpecificDebit(AccountNo: Code[20]; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", 0D, EndDate); // Life-to-Date
        if GLEntry.CalcSums("Debit Amount") then
            exit(GLEntry."Debit Amount");
        exit(0);
    end;

    local procedure GetSpecificCredit(AccountNo: Code[20]; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", 0D, EndDate); // Life-to-Date
        if GLEntry.CalcSums("Credit Amount") then
            exit(GLEntry."Credit Amount");
        exit(0);
    end;

    local procedure GetInsuranceReserve(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal


    begin
        InsuranceReserve_Current := GetAccountBalance('500240', StartDate, EndDate) +
                                   GetAccountBalance('500241', StartDate, EndDate);
    end;


    local procedure CalculateCurrentPeriod()
    begin
        StaffPayable_Current := GetAccountBalance('703020', CurrentYearStart, CurrentYearEnd) +
                                GetAccountBalance('703096', CurrentYearStart, CurrentYearEnd) +
                                GetAccountBalance('704030', CurrentYearStart, CurrentYearEnd) +
                                GetAccountBalance('704032', CurrentYearStart, CurrentYearEnd);

        StandingOrder_Current := 0; // Add calculation logic if needed
    end;

    local procedure CalculatePreviousPeriod()
    begin
        StaffPayable_Previous := GetAccountBalance('703020', PreviousYearStart, PreviousYearEnd) +
                                 GetAccountBalance('703096', PreviousYearStart, PreviousYearEnd) +
                                 GetAccountBalance('704030', PreviousYearStart, PreviousYearEnd) +
                                 GetAccountBalance('704032', PreviousYearStart, PreviousYearEnd);

        StandingOrder_Previous := 0; // Add calculation logic if needed
    end;

    local procedure CalculateCategoryTotals()
    begin
        // Member Deposits Total (Current Year)
        MemberDeposits_Total_Current := GetAccountBalance('700030', CurrentYearStart, CurrentYearEnd);

        // Member Deposits Total (Previous Year)
        MemberDeposits_Total_Previous := GetAccountBalance('700030', PreviousYearStart, PreviousYearEnd);

        // Other Payables Total (Current Year)
        OtherPayables_Total_Current := GetAccountBalance('705020', CurrentYearStart, CurrentYearEnd) +
                                        GetAccountBalance('702021', CurrentYearStart, CurrentYearEnd) +
                                        StaffPayable_Current +
                                        GetAccountBalance('400047', CurrentYearStart, CurrentYearEnd) +
                                        GetAccountBalance('705030', CurrentYearStart, CurrentYearEnd) +
                                        GetAccountBalance('705050', CurrentYearStart, CurrentYearEnd) +
                                        GetAccountBalance('705036', CurrentYearStart, CurrentYearEnd) +
                                        StandingOrder_Current;

        // Other Payables Total (Previous Year)
        OtherPayables_Total_Previous := GetAccountBalance('705020', PreviousYearStart, PreviousYearEnd) +
                                         GetAccountBalance('702021', PreviousYearStart, PreviousYearEnd) +
                                         StaffPayable_Previous +
                                         GetAccountBalance('400047', PreviousYearStart, PreviousYearEnd) +
                                         GetAccountBalance('705030', PreviousYearStart, PreviousYearEnd) +
                                         GetAccountBalance('705050', PreviousYearStart, PreviousYearEnd) +
                                         GetAccountBalance('705036', PreviousYearStart, PreviousYearEnd) +
                                         StandingOrder_Previous;

        // Sundry Creditors Total (Current Year)
        SundryCreditors_Total_Current := GetAccountBalance('707001', CurrentYearStart, CurrentYearEnd) +
                                          GetAccountBalance('700050', CurrentYearStart, CurrentYearEnd);

        // Sundry Creditors Total (Previous Year)
        SundryCreditors_Total_Previous := GetAccountBalance('707001', PreviousYearStart, PreviousYearEnd) +
                                           GetAccountBalance('700050', PreviousYearStart, PreviousYearEnd);

        //Sundry Receivables Total (Current Year)
        SundryReceivables_Total_Current := GetAccountBalance('400221', CurrentYearStart, CurrentYearEnd) +
                                           GetAccountBalance('400226', CurrentYearStart, CurrentYearEnd);
        //Sundry Receivables Total (Previous Year)
        SundryReceivables_Total_Previous := GetAccountBalance('400221', PreviousYearStart, PreviousYearEnd) +
                                            GetAccountBalance('400226', PreviousYearStart, PreviousYearEnd);

        //INTEREST PAYABLE TOTALS
        //Interest Payable Total (Current Year)
        InterestPayable_Total_Current := GetAccountBalance('702020', CurrentYearStart, CurrentYearEnd) +
                                          GetSpecificDebit('702020', CurrentYearEnd) +
                                          GetspecificCredit('702020', CurrentYearEnd);

        //Interest Payable Total (Previous Year)
        InterestPayable_Total_Previous := GetAccountBalance('702020', PreviousYearStart, PreviousYearEnd) +
                                          GetSpecificDebit('702020', PreviousYearEnd) +
                                          GetspecificCredit('702020', PreviousYearEnd);

        //Dividend Payable Total (Current Year)
        DividendPayable_Total_Current := GetAccountBalance('702040', CurrentYearStart, CurrentYearEnd) +
                                          GetSpecificDebit('702040', CurrentYearEnd) +
                                          GetspecificCredit('702040', CurrentYearEnd);
        //Dividend Payable Total (Previous Year)
        DividendPayable_Total_Previous := GetAccountBalance('702040', PreviousYearStart, PreviousYearEnd) +
                                          GetSpecificDebit('702040', PreviousYearEnd) +
                                          GetspecificCredit('702040', PreviousYearEnd);
    end;

    local procedure GetClosingBalance(AccountNo: Code[20]; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry