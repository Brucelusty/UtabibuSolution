report 173010 "Note 12"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Note 12 - Loans to Members';
    DefaultLayout = RDLC;
    RdlcLayout = 'Layouts/Note12.rdlc';

    dataset
    {
        dataitem(ReportHeader; "Company Information")
        {
            column(CompanyName; CompanyInfo.Name) { }
            column(ReportTitle; 'LOANS TO MEMBERS ANALYSIS REPORT') { }
            column(AsOfDate; 'As of: ' + Format(AsOfDateParam, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(CurrentYearLabel; 'Current Year: ' + Format(Date2DMY(AsOfDateParam, 3))) { }
            column(PreviousYearLabel; 'Previous Year: ' + Format(Date2DMY(AsOfDateParam, 3) - 1)) { }
            column(DateFilter; DateFilterText) { }

            // Table Headers
            column(Header_AccountName; 'Account Name') { }
            column(Header_AccountNo; 'Account No.') { }
            column(Header_CurrentYear; Format(Date2DMY(AsOfDateParam, 3))) { }
            column(Header_PreviousYear; Format(Date2DMY(AsOfDateParam, 3) - 1)) { }
            column(Header_GrantedDuringYear; 'Granted During the Year') { }
            column(Header_PaymentDuringYear; 'Payment During the Year') { }

            // ORDINARY LOANS SECTION
            column(OrdinaryLoansSectionTitle; 'ORDINARY LOANS') { }

            column(DevelopmentLoans_No; '300030') { }
            column(DevelopmentLoans_Name; 'Development Loans') { }
            column(DevelopmentLoans_Current; GetLoanBalance('300030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DevelopmentLoans_Previous; GetLoanBalance('300030', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DevelopmentLoans_Granted; GetLoanDebit('300030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DevelopmentLoans_Payment; GetLoanCredit('300030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(DevelopmentPlusLoans_No; '300035') { }
            column(DevelopmentPlusLoans_Name; 'Development Plus Loans') { }
            column(DevelopmentPlusLoans_Current; GetLoanBalance('300035', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DevelopmentPlusLoans_Previous; GetLoanBalance('300035', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DevelopmentPlusLoans_Granted; GetLoanDebit('300035', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DevelopmentPlusLoans_Payment; GetLoanCredit('300035', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(RefinancingLoans_No; '300040') { }
            column(RefinancingLoans_Name; 'Refinancing Loans') { }
            column(RefinancingLoans_Current; GetLoanBalance('300040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(RefinancingLoans_Previous; GetLoanBalance('300040', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(RefinancingLoans_Granted; GetLoanDebit('300040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(RefinancingLoans_Payment; GetLoanCredit('300040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(EmergencyLoans_No; '300050') { }
            column(EmergencyLoans_Name; 'Emergency Loans') { }
            column(EmergencyLoans_Current; GetLoanBalance('300050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(EmergencyLoans_Previous; GetLoanBalance('300050', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(EmergencyLoans_Granted; GetLoanDebit('300050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(EmergencyLoans_Payment; GetLoanCredit('300050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(SchoolFeesLoans_No; '300060') { }
            column(SchoolFeesLoans_Name; 'School Fees Loans') { }
            column(SchoolFeesLoans_Current; GetLoanBalance('300060', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SchoolFeesLoans_Previous; GetLoanBalance('300060', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SchoolFeesLoans_Granted; GetLoanDebit('300060', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SchoolFeesLoans_Payment; GetLoanCredit('300060', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(SpecialEmergencyLoans_No; '300061') { }
            column(SpecialEmergencyLoans_Name; 'Special Emergency Loans') { }
            column(SpecialEmergencyLoans_Current; GetLoanBalance('300061', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SpecialEmergencyLoans_Previous; GetLoanBalance('300061', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SpecialEmergencyLoans_Granted; GetLoanDebit('300061', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SpecialEmergencyLoans_Payment; GetLoanCredit('300061', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Coop41Loans_No; '300065') { }
            column(Coop41Loans_Name; 'Coop 41 Loans') { }
            column(Coop41Loans_Current; GetLoanBalance('300065', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Coop41Loans_Previous; GetLoanBalance('300065', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Coop41Loans_Granted; GetLoanDebit('300065', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Coop41Loans_Payment; GetLoanCredit('300065', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(DefaultersLoans_No; '300075') { }
            column(DefaultersLoans_Name; 'Defaulters'' Loans') { }
            column(DefaultersLoans_Current; GetLoanBalance('300075', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DefaultersLoans_Previous; GetLoanBalance('300075', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DefaultersLoans_Granted; GetLoanDebit('300075', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DefaultersLoans_Payment; GetLoanCredit('300075', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StaffLoans_No; '300076') { }
            column(StaffLoans_Name; 'Staff Loans') { }
            column(StaffLoans_Current; GetLoanBalance('300076', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffLoans_Previous; GetLoanBalance('300076', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffLoans_Granted; GetLoanDebit('300076', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffLoans_Payment; GetLoanCredit('300076', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(OrdinaryLoansSubtotal_Name; 'Total Ordinary Loans') { }
            column(OrdinaryLoansSubtotal_Current; GetOrdinaryLoansTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OrdinaryLoansSubtotal_Previous; GetOrdinaryLoansTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OrdinaryLoansSubtotal_Granted; GetOrdinaryLoansGranted(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OrdinaryLoansSubtotal_Payment; GetOrdinaryLoansPayment(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            // SPECIAL LOANS SECTION
            column(SpecialLoansSectionTitle; 'SPECIAL LOANS') { }

            column(InstantLoans_No; '301020') { }
            column(InstantLoans_Name; 'Instant Loans') { }
            column(InstantLoans_Current; GetLoanBalance('301020', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InstantLoans_Previous; GetLoanBalance('301020', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InstantLoans_Granted; GetLoanDebit('301020', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InstantLoans_Payment; GetLoanCredit('301020', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(OverdueInstantLoans_No; '301021') { }
            column(OverdueInstantLoans_Name; 'Overdue Instant Loans') { }
            column(OverdueInstantLoans_Current; GetLoanBalance('301021', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OverdueInstantLoans_Previous; GetLoanBalance('301021', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OverdueInstantLoans_Granted; GetLoanDebit('301021', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OverdueInstantLoans_Payment; GetLoanCredit('301021', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(EpukaShylockLoans_No; '301030') { }
            column(EpukaShylockLoans_Name; 'Epuka Shylock Loans') { }
            column(EpukaShylockLoans_Current; GetLoanBalance('301030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(EpukaShylockLoans_Previous; GetLoanBalance('301030', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(EpukaShylockLoans_Granted; GetLoanDebit('301030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(EpukaShylockLoans_Payment; GetLoanCredit('301030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(JibambeLoans_No; '301040') { }
            column(JibambeLoans_Name; 'Jibambe Loans') { }
            column(JibambeLoans_Current; GetLoanBalance('301040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(JibambeLoans_Previous; GetLoanBalance('301040', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(JibambeLoans_Granted; GetLoanDebit('301040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(JibambeLoans_Payment; GetLoanCredit('301040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(SuperLoans_No; '301050') { }
            column(SuperLoans_Name; 'Super Loans') { }
            column(SuperLoans_Current; GetLoanBalance('301050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SuperLoans_Previous; GetLoanBalance('301050', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SuperLoans_Granted; GetLoanDebit('301050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SuperLoans_Payment; GetLoanCredit('301050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(DividendLoans_No; '301080') { }
            column(DividendLoans_Name; 'Dividend Loans') { }
            column(DividendLoans_Current; GetLoanBalance('301080', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DividendLoans_Previous; GetLoanBalance('301080', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DividendLoans_Granted; GetLoanDebit('301080', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DividendLoans_Payment; GetLoanCredit('301080', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(BoosterLoans_No; '301081') { }
            column(BoosterLoans_Name; 'Booster Loans') { }
            column(BoosterLoans_Current; GetLoanBalance('301081', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BoosterLoans_Previous; GetLoanBalance('301081', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BoosterLoans_Granted; GetLoanDebit('301081', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BoosterLoans_Payment; GetLoanCredit('301081', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(UtapesaLoans_No; '301082') { }
            column(UtapesaLoans_Name; 'Utapesa Loans') { }
            column(UtapesaLoans_Current; GetLoanBalance('301082', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(UtapesaLoans_Previous; GetLoanBalance('301082', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(UtapesaLoans_Granted; GetLoanDebit('301082', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(UtapesaLoans_Payment; GetLoanCredit('301082', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            column(SpecialLoansSubtotal_Name; 'Total Special Loans') { }
            column(SpecialLoansSubtotal_Current; GetSpecialLoansTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SpecialLoansSubtotal_Previous; GetSpecialLoansTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SpecialLoansSubtotal_Granted; GetSpecialLoansGranted(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SpecialLoansSubtotal_Payment; GetSpecialLoansPayment(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }

            //Utabibu Investment Repossession
            column(UtabibuInvestment_Name; 'Utabibu Investment Repossession') { }
            column(UtabibuInvestment_Current; GetLoanBalance('200240', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(UtabibuInvestment_Previous; GetLoanBalance('200240', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            //Provision for Loan Loss
            column(LoanLoss_Name; 'Provision for Loan Loss') { }
            column(LoanLoss_Current; GetLoanBalance('600025', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(LoanLoss_Previous; GetLoanBalance('600025', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // GRAND TOTAL
            column(LoansGrandTotal_Name; 'Total Loan To Members') { }
            column(LoansGrandTotal_Current; GetLoansGrandTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(LoansGrandTotal_Previous; GetLoansGrandTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // Granted  During the Year
            column(LoansGrantedTotal_Name; 'Granted During the Year') { }
            column(LoansGrandTotal_Granted; GetLoansGrantedGrandTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(LoansGrantedTotal_Previous; GetLoansGrantedGrandTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // Payment During the Year
            column(LoansPaymentTotal_Name; 'Payment During the Year') { }
            column(LoansGrandTotal_Payment; GetLoansPaymentGrandTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(LoansPaymentTotal_Previous; GetLoansPaymentGrandTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            //Prepayment&Sundry Receivables
            Column(PrepaymentSundryReceivables_Name; 'Prepayment & Sundry Receivables') { }
            Column(PrepaymentSundryReceivables_Current; GetLoanBalance('400223', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(PrepaymentSundryReceivables_Previous; GetLoanBalance('400223', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            Column(LessProvision_Name; 'Less Provision') { }
            Column(LessProvisionAmount_Current; GetLoanBalance('400227', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(LessProvision_Previous; GetLoanBalance('400227', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(TotalPrepaymentSundryReceivables_Name; 'Total Prepayment & Sundry Receivables') { }
            column(TotalPrepaymentSundryReceivables_Current; GetLoanBalance('400223', CurrentYearStart, CurrentYearEnd) +
                                                             GetLoanBalance('400227', CurrentYearStart, CurrentYearEnd))
            { DecimalPlaces = 2 : 2; }
            column(TotalPrepaymentSundryReceivables_Previous;GetLoanBalance('400223', PreviousYearStart, PreviousYearEnd) +
                                                             GetLoanBalance('400227', PreviousYearStart, PreviousYearEnd))
            { DecimalPlaces = 2 : 2; }

            column(LoanDisbursed_Name; 'Loan Disbursement Account'){}
            column(oanDisbursed_Current;GetLoanBalance('707001', CurrentYearStart,CurrentYearEnd)){DecimalPlaces=2:2;}
            column(oanDisbursed_Previous;GetLoanBalance('707001', PreviousYearStart,PreviousYearEnd)){DecimalPlaces=2:2;}
            



            trigger OnAfterGetRecord()
            begin
                if AsOfDateParam = 0D then
                    AsOfDateParam := WorkDate();
                UpdateDateRanges();
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

    local procedure GetLoanBalance(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
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

    local procedure GetLoanDebit(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
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

    local procedure GetLoanCredit(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
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

    // Ordinary Loans Totals
    local procedure GetOrdinaryLoansTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetRawLoanBalance('300030', StartDate, EndDate) +
            GetRawLoanBalance('300035', StartDate, EndDate) +
            GetRawLoanBalance('300040', StartDate, EndDate) +
            GetRawLoanBalance('300050', StartDate, EndDate) +
            GetRawLoanBalance('300060', StartDate, EndDate) +
            GetRawLoanBalance('300061', StartDate, EndDate) +
            GetRawLoanBalance('300065', StartDate, EndDate) +
            GetRawLoanBalance('300075', StartDate, EndDate) +
            GetRawLoanBalance('300076', StartDate, EndDate));
    end;

    local procedure GetOrdinaryLoansGranted(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetLoanDebit('300030', StartDate, EndDate) +
            GetLoanDebit('300035', StartDate, EndDate) +
            GetLoanDebit('300040', StartDate, EndDate) +
            GetLoanDebit('300050', StartDate, EndDate) +
            GetLoanDebit('300060', StartDate, EndDate) +
            GetLoanDebit('300061', StartDate, EndDate) +
            GetLoanDebit('300065', StartDate, EndDate) +
            GetLoanDebit('300075', StartDate, EndDate) +
            GetLoanDebit('300076', StartDate, EndDate));
    end;

    local procedure GetOrdinaryLoansPayment(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetLoanCredit('300030', StartDate, EndDate) +
            GetLoanCredit('300035', StartDate, EndDate) +
            GetLoanCredit('300040', StartDate, EndDate) +
            GetLoanCredit('300050', StartDate, EndDate) +
            GetLoanCredit('300060', StartDate, EndDate) +
            GetLoanCredit('300061', StartDate, EndDate) +
            GetLoanCredit('300065', StartDate, EndDate) +
            GetLoanCredit('300075', StartDate, EndDate) +
            GetLoanCredit('300076', StartDate, EndDate));
    end;

    // Special Loans Totals
    local procedure GetSpecialLoansTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetRawLoanBalance('301020', StartDate, EndDate) +
            GetRawLoanBalance('301021', StartDate, EndDate) +
            GetRawLoanBalance('301030', StartDate, EndDate) +
            GetRawLoanBalance('301040', StartDate, EndDate) +
            GetRawLoanBalance('301050', StartDate, EndDate) +
            GetRawLoanBalance('301080', StartDate, EndDate) +
            GetRawLoanBalance('301081', StartDate, EndDate) +
            GetRawLoanBalance('301082', StartDate, EndDate));
    end;

    local procedure GetSpecialLoansGranted(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetLoanDebit('301020', StartDate, EndDate) +
            GetLoanDebit('301021', StartDate, EndDate) +
            GetLoanDebit('301030', StartDate, EndDate) +
            GetLoanDebit('301040', StartDate, EndDate) +
            GetLoanDebit('301050', StartDate, EndDate) +
            GetLoanDebit('301080', StartDate, EndDate) +
            GetLoanDebit('301081', StartDate, EndDate) +
            GetLoanDebit('301082', StartDate, EndDate));
    end;

    local procedure GetSpecialLoansPayment(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetLoanCredit('301020', StartDate, EndDate) +
            GetLoanCredit('301021', StartDate, EndDate) +
            GetLoanCredit('301030', StartDate, EndDate) +
            GetLoanCredit('301040', StartDate, EndDate) +
            GetLoanCredit('301050', StartDate, EndDate) +
            GetLoanCredit('301080', StartDate, EndDate) +
            GetLoanCredit('301081', StartDate, EndDate) +
            GetLoanCredit('301082', StartDate, EndDate));
    end;
    
     local procedure  GetDisbursedTotal(StartDate:Date; EndDate:Date):Decimal
    begin
        GetLoanBalance('707001',StartDate,EndDate);
    end;

    // Grand Totals
    local procedure GetLoansGrandTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetOrdinaryLoansTotal(StartDate, EndDate) + GetSpecialLoansTotal(StartDate, EndDate)+  GetDisbursedTotal(StartDate,EndDate));
    end;

    local procedure GetLoansGrantedGrandTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetOrdinaryLoansGranted(StartDate, EndDate) + GetSpecialLoansGranted(StartDate, EndDate));
    end;

    local procedure GetLoansPaymentGrandTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetOrdinaryLoansPayment(StartDate, EndDate) + GetSpecialLoansPayment(StartDate, EndDate));
    end;
}