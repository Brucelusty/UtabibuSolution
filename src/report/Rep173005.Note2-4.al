report 173005 "Notes2-4"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Notes to Financial Statements - Income and Expenses';
    RDLCLayout = 'Layouts/Notes2-4.rdlc';

    dataset
    {
        dataitem("Sacco Information"; SaccoInformation)
        {
            column(CompanyName; CompanyProperty.Name) { }
            column(ReportTitle; ReportTitle) { }
            column(BeginDate; BeginDate) { }
            column(EndDate; EndDate) { }
            column(CurrentYear; Format(Date2DMY(EndDate, 3))) { }
            column(PreviousYear; Format(Date2DMY(EndDate, 3) - 1)) { }

            // 2(a) Interest Income - Bosa Loans
            column(Header_BosaLoans; 'Bosa Loans') { }
            column(BosaLoans_Current; GetInterestReceipts(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BosaLoans_Previous; GetInterestReceipts(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // 2(b) Other Interest Income
            column(Header_MoneyMarketBritam; 'Money Market Britam') { }
            column(InterestFromMoneyMarketBritam; InterestFromMoneyMarketBritam) { }
            column(InterestFromMoneyMarketBritam_Prev; InterestFromMoneyMarketBritam_Prev) { }

            //---Money Market CIC---//
            column(Header_MoneyMarketCIC; 'Money Market CIC') { }
            column(InterestFromMoneyMarketCIC; InterestFromMoneyMarketCIC) { }
            column(InterestFromMoneyMarketCIC_Prev; InterestFromMoneyMarketCIC_Prev) { }
            //---Money Market Total---//
            column(Header_MoneyMarket; 'Money Market') { }
            column(InterestFromMoneyMarket; InterestFromMoneyMarket) { }
            column(InterestFromMoneyMarket_Prev; InterestFromMoneyMarket_Prev) { }

            column(Header_TotalOtherInterestIncome; 'Total Other Interest Income') { }
            column(TotalOtherInterestIncome; TotalOtherInterestIncome) { }
            column(TotalOtherInterestIncome_Prev; TotalOtherInterestIncome_Prev) { }

            // 3 Interest Expense
            column(Header_InterestExpense; 'Interest On Member Depoists 10.5%') { }
            column(InterestOnMemberDeposits; InterestOnMemberDeposits) { }
            column(InterestOnMemberDeposits_Prev; InterestOnMemberDeposits_Prev) { }
            //---Interest On Programmed Deposits---//
            column(Header_InterestOnProgrammedDeposits; 'Interest On Programmed Deposits 7%') { }
            column(InterestOnProgrammedDeposits; InterestOnProgrammedDeposits) { }
            column(InterestOnProgrammedDeposits_Prev; InterestOnProgrammedDeposits_Prev) { }
            //---Interest On Bank Loans---//
            column(Header_InterestOnBankLoans; 'Interest On Bank Loans') { }
            column(InterestOnBankLoans; InterestOnBankLoans) { }
            column(InterestOnBankLoans_Prev; InterestOnBankLoans_Prev) { }
            //---Total Interest Expense---//
            column(Header_TotalInterestExpense; 'Total Interest Expense') { }
            column(TotalInterestExpense; TotalInterestExpense) { }
            column(TotalInterestExpense_Prev; TotalInterestExpense_Prev) { }

            // 4 Other Operating Income

            column(Header_RentIncome; 'Rent Income') { }
            column(RentIncome; RentIncome) { }
            column(RentIncome_Prev; RentIncome_Prev) { }
            //---Membership Fee---//
            column(Header_MembershipFee; 'Membership Fee') { }
            column(MembershipFee; MembershipFee) { }
            column(MembershipFee_Prev; MembershipFee_Prev) { }
            //---Dividends---//
            column(Header_Dividends; 'Dividends') { }
            column(DividendIncome; DividendIncome) { }
            column(DividendIncome_Prev; DividendIncome_Prev) { }

            //---Commissions---//
            column(Header_Commissions; 'Commissions') { }
            column(Commissions; Commissions) { }
            column(Commissions_Prev; Commissions_Prev) { }
            //---Tendering---//
            column(Header_Tendering; 'Tendering') { }
            column(Tendering; Tendering) { }
            column(Tendering_Prev; Tendering_Prev) { }
            //---Other Incomes---//
            column(Header_OtherIncomes; 'Other Incomes(Shares Transfer Fee, W Fees)') { }
            column(OtherIncomes; OtherIncomes) { }
            column(OtherIncomes_Prev; OtherIncomes_Prev) { }
            //---Total Other Operating Income---//
            column(Header_TotalOtherOperatingIncome; 'Total Other Operating Income') { }
            column(TotalOtherOperatingIncome; TotalOtherOperatingIncome) { }
            column(TotalOtherOperatingIncome_Prev; TotalOtherOperatingIncome_Prev) { }

            trigger OnAfterGetRecord()
            begin
                // Validate input dates
                if BeginDate = 0D then
                    Error('Please enter a valid Begin Date');
                if EndDate = 0D then
                    Error('Please enter a valid End Date');
                if BeginDate > EndDate then
                    Error('Begin Date cannot be after End Date');

                // Calculate previous year dates
                PrevBeginDate := CalcDate('<-1Y>', BeginDate);
                PrevEndDate := CalcDate('<-1Y>', EndDate);

                // Initialize all values
                ClearAllValues();

                // Calculate all current period values
                CalculateCurrentPeriod();

                // Calculate all previous period values
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
                group(DateRange)
                {
                    Caption = 'Date Range';

                    field(BeginDateField; BeginDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Begin Date';
                        ToolTip = 'Enter the start date for the report period';

                        trigger OnValidate()
                        begin
                            if (BeginDate <> 0D) and (EndDate <> 0D) and (BeginDate > EndDate) then
                                Error('Begin Date cannot be after End Date');
                        end;
                    }

                    field(EndDateField; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Enter the end date for the report period';

                        trigger OnValidate()
                        begin
                            if (BeginDate <> 0D) and (EndDate <> 0D) and (BeginDate > EndDate) then
                                Error('Begin Date cannot be after End Date');
                        end;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if BeginDate = 0D then
                BeginDate := CalcDate('<-CY>', WorkDate());
            if EndDate = 0D then
                EndDate := WorkDate();
        end;
    }

    var
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        CompanyProperty: Record "Company Information";
        CurrentYearStart: Date;
        CurrentYearEnd: Date;
        PreviousYearStart: Date;
        PreviousYearEnd: Date;

        BeginDate: Date;
        EndDate: Date;
        PrevBeginDate: Date;
        PrevEndDate: Date;
        ReportTitle: Text;

        // 2(a) Interest Income
        InterestOnLoans: Decimal;
        InterestOnLoans_Prev: Decimal;

        // 2(b) Other Interest Income
        InterestFromMoneyMarketBritam: Decimal;
        InterestFromMoneyMarketBritam_Prev: Decimal;
        InterestFromMoneyMarketCIC: Decimal;
        InterestFromMoneyMarketCIC_Prev: Decimal;
        InterestFromMoneyMarket: Decimal;
        InterestFromMoneyMarket_Prev: Decimal;
        TotalOtherInterestIncome: Decimal;
        TotalOtherInterestIncome_Prev: Decimal;

        // 3 Interest Expense
        InterestOnMemberDeposits: Decimal;
        InterestOnMemberDeposits_Prev: Decimal;
        InterestOnProgrammedDeposits: Decimal;
        InterestOnProgrammedDeposits_Prev: Decimal;
        InterestOnBankLoans: Decimal;
        InterestOnBankLoans_Prev: Decimal;
        TotalInterestExpense: Decimal;
        TotalInterestExpense_Prev: Decimal;

        // 4 Other Operating Income
        RentIncome: Decimal;
        RentIncome_Prev: Decimal;
        MembershipFee: Decimal;
        MembershipFee_Prev: Decimal;
        DividendIncome: Decimal;
        DividendFromCIC: Decimal;
        DividendIncome_Prev: Decimal;
        DividendFromCoopHolding: Decimal;
        DividendFromCoopHolding_Prev: Decimal;
        DividendFromUtabibu: Decimal;
        DividendFromUtabibu_Prev: Decimal;
        Commissions: Decimal;
        Commissions_Prev: Decimal;
        EftCommissions: Decimal;
        EftCommissions_Prev: Decimal;
        MpesaCommissions: Decimal;
        MpesaCommissions_Prev: Decimal;

        Tendering: Decimal;
        Tendering_Prev: Decimal;
        OtherIncomes: Decimal;
        OtherIncomes_Prev: Decimal;
        TotalOtherOperatingIncome: Decimal;
        TotalOtherOperatingIncome_Prev: Decimal;

    local procedure ClearAllValues()
    begin
        InterestOnLoans := 0;
        InterestOnLoans_Prev := 0;
        InterestFromMoneyMarketBritam := 0;
        InterestFromMoneyMarketBritam_Prev := 0;
        InterestFromMoneyMarketCIC := 0;
        InterestFromMoneyMarketCIC_Prev := 0;
        InterestFromMoneyMarket := 0;
        InterestFromMoneyMarket_Prev := 0;
        TotalOtherInterestIncome := 0;
        TotalOtherInterestIncome_Prev := 0;
        InterestOnMemberDeposits := 0;
        InterestOnMemberDeposits_Prev := 0;
        InterestOnProgrammedDeposits := 0;
        InterestOnProgrammedDeposits_Prev := 0;
        InterestOnBankLoans := 0;
        InterestOnBankLoans_Prev := 0;
        TotalInterestExpense := 0;
        TotalInterestExpense_Prev := 0;
        RentIncome := 0;
        RentIncome_Prev := 0;
        MembershipFee := 0;
        MembershipFee_Prev := 0;
        DividendIncome := 0;
        DividendIncome_Prev := 0;
        DividendFromCoopHolding := 0;
        DividendFromCoopHolding_Prev := 0;
        DividendFromUtabibu := 0;
        DividendFromUtabibu_Prev := 0;
        Commissions := 0;
        Commissions_Prev := 0;
        EftCommissions := 0;
        EftCommissions_Prev := 0;
        MpesaCommissions := 0;
        MpesaCommissions_Prev := 0;
        Tendering := 0;
        Tendering_Prev := 0;
        OtherIncomes := 0;
        OtherIncomes_Prev := 0;
        TotalOtherOperatingIncome := 0;
        TotalOtherOperatingIncome_Prev := 0;
    end;

    local procedure CalculateCurrentPeriod()
    begin
        // 2(a) Interest Income - Bosa Loans
        // InterestOnLoans := GetGLAmountByAccountNo('801999', BeginDate, EndDate, true);

        // 2(b) Other Interest Income - Add specific account filters
        InterestFromMoneyMarketBritam := GetGLAmountByAccountNo('803056', BeginDate, EndDate );
        InterestFromMoneyMarketCIC := GetGLAmountByAccountNo('803061', BeginDate, EndDate );
        InterestFromMoneyMarket := InterestFromMoneyMarketBritam + InterestFromMoneyMarketCIC;
        TotalOtherInterestIncome := InterestFromMoneyMarket;

        // 3 Interest Expense
        InterestOnMemberDeposits := GetGLAmountByAccountNo('903050', BeginDate, EndDate);
        InterestOnProgrammedDeposits := GetGLAmountByAccountNo('903040', BeginDate, EndDate);
        InterestOnBankLoans := GetGLAmountByAccountNo('903030', BeginDate, EndDate);
        TotalInterestExpense := InterestOnMemberDeposits + InterestOnProgrammedDeposits + InterestOnBankLoans;

        // 4 Other Operating Income
        RentIncome := GetGLAmountByAccountNo('804012', BeginDate, EndDate);
        MembershipFee := GetGLAmountByAccountNo('803030', BeginDate, EndDate);

        DividendIncome := GetGLAmountByAccountNo('804020', BeginDate, EndDate) ;
                         

        Commissions := GetGLAmountByAccountNo('803050', BeginDate, EndDate) +
                       GetGLAmountByAccountNo('803055', BeginDate, EndDate);
        Tendering := GetGLAmountByAccountNo('804011', BeginDate, EndDate);
        OtherIncomes := GetGLAmountByAccountNo('803032', BeginDate, EndDate) +
                        GetGLAmountByAccountNo('803040', BeginDate, EndDate);
        TotalOtherOperatingIncome := RentIncome + MembershipFee + DividendIncome +
                                      Commissions + Tendering + OtherIncomes;
    end;

    // Add this new procedure to get amounts by specific account number
    local procedure GetGLAmountByAccountNo(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        Amount: Decimal;
    begin
        Amount := 0;

        GLEntry.Reset;
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        GLEntry.CalcSums(Amount);

        // if NegateAmount then
        //     Amount := -1 * GLEntry.Amount
        // else
            Amount := GLEntry.Amount;

        exit(Amount);
    end;

    local procedure CalculatePreviousPeriod()
    begin
        // 2(a) Interest Income - Bosa Loans    801999
        //InterestOnLoans_Prev := GetGLAmountByAccountNo('801999', PrevBeginDate, PrevEndDate);

        // 2(b) Other Interest Income - Add specific account filters
        InterestFromMoneyMarketBritam_Prev := GetGLAmountByAccountNo('803056', PrevBeginDate, PrevEndDate);
        InterestFromMoneyMarketCIC_Prev := GetGLAmountByAccountNo('803061', PrevBeginDate, PrevEndDate);
        InterestFromMoneyMarket_Prev := InterestFromMoneyMarketBritam_Prev + InterestFromMoneyMarketCIC_Prev;
        TotalOtherInterestIncome_Prev := InterestFromMoneyMarket_Prev;

        // 3 Interest Expense
        InterestOnMemberDeposits_Prev := GetGLAmountByAccountNo('903050', PrevBeginDate, PrevEndDate);
        InterestOnProgrammedDeposits_Prev := GetGLAmountByAccountNo('903040', PrevBeginDate, PrevEndDate);
        InterestOnBankLoans_Prev := GetGLAmountByAccountNo('903030', PrevBeginDate, PrevEndDate);
        TotalInterestExpense_Prev := InterestOnMemberDeposits_Prev + InterestOnProgrammedDeposits_Prev + InterestOnBankLoans_Prev;

        // 4 Other Operating Income
        RentIncome_Prev := GetGLAmountByAccountNo('804012', PrevBeginDate, PrevEndDate);
        MembershipFee_Prev := GetGLAmountByAccountNo('803030', PrevBeginDate, PrevEndDate);

        DividendIncome_Prev := GetGLAmountByAccountNo('804020', PrevBeginDate, PrevEndDate);

        Commissions_Prev := GetGLAmountByAccountNo('803050', PrevBeginDate, PrevEndDate) +
                            GetGLAmountByAccountNo('803055', PrevBeginDate, PrevEndDate);
        Tendering_Prev := GetGLAmountByAccountNo('804011', PrevBeginDate, PrevEndDate);
        OtherIncomes_Prev := GetGLAmountByAccountNo('803032', PrevBeginDate, PrevEndDate) +
                             GetGLAmountByAccountNo('803040', PrevBeginDate, PrevEndDate);
        TotalOtherOperatingIncome_Prev := RentIncome_Prev + MembershipFee_Prev + DividendIncome_Prev +
                                           Commissions_Prev + Tendering_Prev + OtherIncomes_Prev;
    end;

    local procedure GetGLAmount(IncomeFilter: Option; StartDate: Date; EndDate: Date; NegateAmount: Boolean): Decimal
    var
        Amount: Decimal;
    begin
        Amount := 0;
        GLAccount.Reset;
        GLAccount.SetFilter(GLAccount.Incomes, '%1', IncomeFilter);
        if GLAccount.FindSet then begin
            repeat
                GLEntry.Reset;
                GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartDate, EndDate);
                if GLEntry.FindSet then begin
                    GLEntry.CalcSums(Amount);
                    if NegateAmount then
                        Amount += -1 * GLEntry.Amount
                    else
                        Amount += GLEntry.Amount;
                end;
            until GLAccount.Next = 0;
        end;
        exit(Amount);
    end;

    local procedure GetGLAmountByLiability(LiabilityFilter: Option; StartDate: Date; EndDate: Date; NegateAmount: Boolean): Decimal
    var
        Amount: Decimal;
    begin
        Amount := 0;
        GLAccount.Reset;
        GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', LiabilityFilter);
        if GLAccount.FindSet then begin
            repeat
                GLEntry.Reset;
                GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartDate, EndDate);
                if GLEntry.FindSet then begin
                    GLEntry.CalcSums(Amount);
                    if NegateAmount then
                        Amount += -1 * GLEntry.Amount
                    else
                        Amount += GLEntry.Amount;
                end;
            until GLAccount.Next = 0;
        end;
        exit(Amount);
    end;

    local procedure GetInterestReceipts(StartDate: Date; EndDate: Date): Decimal
     var
        GLAccount: Record "G/L Account";
        Amount: Decimal;
    begin
        Amount := 0;

        // Method 1: Using GL Account classification
        GLAccount.Reset();
        GLAccount.SetRange("Form2F(Statement of C Income)",
                           GLAccount."Form2F(Statement of C Income)"::InterestonLoanPortfolio);
        if GLAccount.FindSet() then
            repeat
                Amount += GetGLAmountByAccountNo(GLAccount."No.", StartDate, EndDate, true);
            until GLAccount.Next() = 0;

       // If classification returns 0, try specific account numbers
        if Amount = 0 then begin
            Amount := GetGLAmountByAccountNo('801999', StartDate, EndDate, true);//801999
           // Add other specific interest on loan accounts as needed
        end;

        exit(Amount);
    end;
    local procedure GetGLAmountByAccountNo(AccountNo: Code[20]; StartDate: Date; EndDate: Date; NegateAmount: Boolean): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        // Validate account exists
        if not GLAccount.Get(AccountNo) then begin
            // Uncomment for debugging during development
            // Message('Warning: Account %1 not found', AccountNo);
            exit(0);
        end;

        Amount := 0;

        GLEntry.Reset();
        GLEntry.SetCurrentKey("G/L Account No.", "Posting Date");
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);

        if GLEntry.FindSet() then
            repeat
                if NegateAmount then
                    Amount := Amount - GLEntry.Amount
                else
                    Amount := Amount + GLEntry.Amount;
            until GLEntry.Next() = 0;

        exit(Amount);
    end;
}