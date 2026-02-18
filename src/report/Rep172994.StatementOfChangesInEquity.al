report 172994 StatementOfChangesInEquity
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Statement of Changes in Equity';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Statementofchangesinequity.rdlc';

    dataset
    {
        dataitem("Sacco Information"; SaccoInformation)
        {
            column(Code; Code) { }
            column(CompanyName; CompanyName) { }
            column(ReportTitle; 'STATEMENT OF CHANGES IN EQUITY FOR THE YEAR ENDED ' + Format(EndDate)) { }
            
            // Year headers
            column(CurrentYear; CurrentYear) { }
            column(PreviousYear; PreviousYear) { }
            
            // ===== OPENING BALANCES (As at start of year) =====
            column(OpenBal_ShareCapital_Current; GetOpeningBalance_ShareCapital(CurrentYearStart)) { DecimalPlaces = 2:2; }
            column(OpenBal_ShareCapital_Previous; GetOpeningBalance_ShareCapital(PreviousYearStart)) { DecimalPlaces = 2:2; }
            
            column(OpenBal_FairValue_Current; GetOpeningBalance_FairValue(CurrentYearStart)) { DecimalPlaces = 2:2; }
            column(OpenBal_FairValue_Previous; GetOpeningBalance_FairValue(PreviousYearStart)) { DecimalPlaces = 2:2; }
            
            column(OpenBal_GeneralReserve_Current; GetOpeningBalance_GeneralReserve(CurrentYearStart)) { DecimalPlaces = 2:2; }
            column(OpenBal_GeneralReserve_Previous; GetOpeningBalance_GeneralReserve(PreviousYearStart)) { DecimalPlaces = 2:2; }
            
            column(OpenBal_CapitalReserve_Current; GetOpeningBalance_CapitalReserve(CurrentYearStart)) { DecimalPlaces = 2:2; }
            column(OpenBal_CapitalReserve_Previous; GetOpeningBalance_CapitalReserve(PreviousYearStart)) { DecimalPlaces = 2:2; }
            
            column(OpenBal_StatutoryReserve_Current; GetOpeningBalance_StatutoryReserve(CurrentYearStart)) { DecimalPlaces = 2:2; }
            column(OpenBal_StatutoryReserve_Previous; GetOpeningBalance_StatutoryReserve(PreviousYearStart)) { DecimalPlaces = 2:2; }
            
            column(OpenBal_InsuranceReserve_Current; GetOpeningBalance_InsuranceReserve(CurrentYearStart)) { DecimalPlaces = 2:2; }
            column(OpenBal_InsuranceReserve_Previous; GetOpeningBalance_InsuranceReserve(PreviousYearStart)) { DecimalPlaces = 2:2; }
            
            column(OpenBal_RetainedEarnings_Current; GetOpeningBalance_RetainedEarnings(CurrentYearStart)) { DecimalPlaces = 2:2; }
            column(OpenBal_RetainedEarnings_Previous; GetOpeningBalance_RetainedEarnings(PreviousYearStart)) { DecimalPlaces = 2:2; }
            
            column(OpenBal_Total_Current; GetOpeningBalance_Total(CurrentYearStart)) { DecimalPlaces = 2:2; }
            column(OpenBal_Total_Previous; GetOpeningBalance_Total(PreviousYearStart)) { DecimalPlaces = 2:2; }
            
            // ===== PRIOR YEAR ADJUSTMENTS =====
             column(PriorYearAdj_ShareCapital_Current; GetPriorYearAdjustment(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(PriorYearAdj_ShareCapital_Previous; GetPriorYearAdjustment(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

             column(PriorYearAdj_FairValue_Current; GetPriorYearAdjustment(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(PriorYearAdj_FairValue_Previous; GetPriorYearAdjustment(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(PriorYearAdj_GeneralReserve_Current; GetPriorYearAdjustment(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(PriorYearAdj_GeneralReserve_Previous; GetPriorYearAdjustment(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(PriorYearAdj_CapitalReserve_Current; GetPriorYearAdjustment(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(PriorYearAdj_CapitalReserve_Previous; GetPriorYearAdjustment(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(PriorYearAdj_StatutoryReserve_Current; GetPriorYearAdjustment(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(PriorYearAdj_StatutoryReserve_Previous; GetPriorYearAdjustment(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(PriorYearAdj_InsuranceReserve_Current; GetPriorYearAdjustment(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(PriorYearAdj_InsuranceReserve_Previous; GetPriorYearAdjustment(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
           column(PriorYearAdj_RetainedEarnings_Current; GetPriorYearAdjustment(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(PriorYearAdj_RetainedEarnings_Previous; GetPriorYearAdjustment(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(PriorYearAdj_Total_Current; GetPriorYearAdjustment(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(PriorYearAdj_Total_Previous; GetPriorYearAdjustment(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== ADJUSTMENT TO EQUITY =====
            column(AdjToEquity_ShareCapital_Current;GetAdjustmentToEquity_ShareCapital(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(AdjToEquity_ShareCapital_Previous; GetAdjustmentToEquity_ShareCapital(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(AdjToEquity_FairValue_Current; GetAdjustmentToEquity_FairValue(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(AdjToEquity_FairValue_Previous; GetAdjustmentToEquity_FairValue(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(AdjToEquity_GeneralReserve_Current; GetAdjustmentToEquity_GeneralReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(AdjToEquity_GeneralReserve_Previous; GetAdjustmentToEquity_GeneralReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(adjToEquity_CapitalReserve_Current; GetAdjustmentToEquity_CapitalReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(adjToEquity_CapitalReserve_Previous; GetAdjustmentToEquity_CapitalReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(AdjToEquity_StatutoryReserve_Current; GetAdjustmentToEquity_StatutoryReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(AdjToEquity_StatutoryReserve_Previous; GetAdjustmentToEquity_StatutoryReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(AdjToEquity_InsuranceReserve_Current; GetAdjustmentToEquity_InsuranceReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(AdjToEquity_InsuranceReserve_Previous; GetAdjustmentToEquity_InsuranceReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(AdjToEquity_RetainedEarnings_Current; GetAdjustmentToEquity_RetainedEarnings(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(AdjToEquity_RetainedEarnings_Previous; GetAdjustmentToEquity_RetainedEarnings(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(AdjToEquity_Total_Current; GetAdjustmentToEquity_Total(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(AdjToEquity_Total_Previous; GetAdjustmentToEquity_Total(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== RESTATED BALANCE =====
            column(Restated_ShareCapital_Current; GetRestatedBalance_ShareCapital(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Restated_ShareCapital_Previous; GetRestatedBalance_ShareCapital(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(Restated_FairValue_Current; GetRestatedBalance_FairValue(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Restated_FairValue_Previous; GetRestatedBalance_FairValue(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(Restated_GeneralReserve_Current; GetRestatedBalance_GeneralReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Restated_GeneralReserve_Previous; GetRestatedBalance_GeneralReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(Restated_CapitalReserve_Current; GetRestatedBalance_CapitalReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Restated_CapitalReserve_Previous; GetRestatedBalance_CapitalReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(Restated_StatutoryReserve_Current; GetRestatedBalance_StatutoryReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Restated_StatutoryReserve_Previous; GetRestatedBalance_StatutoryReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(Restated_InsuranceReserve_Current; GetRestatedBalance_InsuranceReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Restated_InsuranceReserve_Previous; GetRestatedBalance_InsuranceReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(Restated_RetainedEarnings_Current; GetRestatedBalance_RetainedEarnings(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Restated_RetainedEarnings_Previous; GetRestatedBalance_RetainedEarnings(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(Restated_Total_Current; GetRestatedBalance_Total(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Restated_Total_Previous; GetRestatedBalance_Total(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== SURPLUS FOR THE YEAR =====
            column(Surplus_ShareCapital_Current; GetSurplusForYear_ShareCapital(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Surplus_ShareCapital_Previous; GetSurplusForYear_ShareCapital(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(Surplus_FairValue_Current; GetSurplusForYear_FairValue(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Surplus_FairValue_Previous; GetSurplusForYear_FairValue(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(Surplus_GeneralReserve_Current; GetSurplusForYear_GeneralReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Surplus_GeneralReserve_Previous; GetSurplusForYear_GeneralReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(Surplus_CapitalReserve_Current; GetSurplusForYear_CapitalReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Surplus_CapitalReserve_Previous; GetSurplusForYear_CapitalReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(Surplus_StatutoryReserve_Current; GetSurplusForYear_StatutoryReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Surplus_StatutoryReserve_Previous; GetSurplusForYear_StatutoryReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            column(Surplus_InsuranceReserve_Current; GetSurplusForYear_InsuranceReserve(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Surplus_InsuranceReserve_Previous; GetSurplusForYear_InsuranceReserve(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(Surplus_RetainedEarnings_Current; GetSurplusForYear_RetainedEarnings(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Surplus_RetainedEarnings_Previous; GetSurplusForYear_RetainedEarnings(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(Surplus_Total_Current; GetSurplusForYear_Total(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Surplus_Total_Previous; GetSurplusForYear_Total(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== CHANGES IN FAIR VALUE =====
            column(ChangeFairValue_FairValue_Current; GetChangeInFairValueMovement(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ChangeFairValue_FairValue_Previous; GetChangeInFairValueMovement(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(ChangeFairValue_Total_Current; GetChangeInFairValueMovement(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ChangeFairValue_Total_Previous; GetChangeInFairValueMovement(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== COMPREHENSIVE INCOME =====
            column(CompIncome_Total_Current; GetTotalComprehensiveIncome(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(CompIncome_Total_Previous; GetTotalComprehensiveIncome(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== STATUTORY RESERVE FUND =====
            column(StatReserveFund_StatutoryReserve_Current; GetStatutoryReserveFundMovement(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(StatReserveFund_StatutoryReserve_Previous; GetStatutoryReserveFundMovement(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(StatReserveFund_RetainedEarnings_Current; -GetStatutoryReserveFundMovement(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(StatReserveFund_RetainedEarnings_Previous; -GetStatutoryReserveFundMovement(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== INSURANCE FUND =====
            column(InsuranceFund_InsuranceReserve_Current; GetInsuranceFundMovement(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(InsuranceFund_InsuranceReserve_Previous; GetInsuranceFundMovement(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(InsuranceFund_RetainedEarnings_Current; -GetInsuranceFundMovement(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(InsuranceFund_RetainedEarnings_Previous; -GetInsuranceFundMovement(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== PROVISION FOR HONORARIA =====
            column(Honoraria_RetainedEarnings_Current; -GetHonorariaProvision(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Honoraria_RetainedEarnings_Previous; -GetHonorariaProvision(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(Honoraria_Total_Current; -GetHonorariaProvision(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(Honoraria_Total_Previous; -GetHonorariaProvision(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== PROVISION FOR STAFF BONUS =====
            column(StaffBonus_RetainedEarnings_Current; -GetStaffBonusProvision(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(StaffBonus_RetainedEarnings_Previous; -GetStaffBonusProvision(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(StaffBonus_Total_Current; -GetStaffBonusProvision(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(StaffBonus_Total_Previous; -GetStaffBonusProvision(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== DIVIDEND CAPITALIZED =====
            column(DivCapitalized_ShareCapital_Current; GetDividendCapitalized(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(DivCapitalized_ShareCapital_Previous; GetDividendCapitalized(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(DivCapitalized_RetainedEarnings_Current; -GetDividendCapitalized(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(DivCapitalized_RetainedEarnings_Previous; -GetDividendCapitalized(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== SHARES ISSUED FOR CASH =====
            column(SharesIssued_ShareCapital_Current; GetSharesIssuedForCash(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(SharesIssued_ShareCapital_Previous; GetSharesIssuedForCash(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(SharesIssued_Total_Current; GetSharesIssuedForCash(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(SharesIssued_Total_Previous; GetSharesIssuedForCash(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== PROPOSED DIVIDENDS =====
            column(ProposedDiv_RetainedEarnings_Current; -GetProposedDividends(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ProposedDiv_RetainedEarnings_Previous; -GetProposedDividends(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(ProposedDiv_Total_Current; -GetProposedDividends(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ProposedDiv_Total_Previous; -GetProposedDividends(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // ===== CLOSING BALANCE =====
            column(ClosingBal_ShareCapital_Current; GetClosingBalance_ShareCapital(CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ClosingBal_ShareCapital_Previous; GetClosingBalance_ShareCapital(PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(ClosingBal_FairValue_Current; GetClosingBalance_FairValue(CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ClosingBal_FairValue_Previous; GetClosingBalance_FairValue(PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(ClosingBal_GeneralReserve_Current; GetClosingBalance_GeneralReserve(CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ClosingBal_GeneralReserve_Previous; GetClosingBalance_GeneralReserve(PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(ClosingBal_CapitalReserve_Current; GetClosingBalance_CapitalReserve(CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ClosingBal_CapitalReserve_Previous; GetClosingBalance_CapitalReserve(PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(ClosingBal_StatutoryReserve_Current; GetClosingBalance_StatutoryReserve(CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ClosingBal_StatutoryReserve_Previous; GetClosingBalance_StatutoryReserve(PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(ClosingBal_InsuranceReserve_Current; GetClosingBalance_InsuranceReserve(CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ClosingBal_InsuranceReserve_Previous; GetClosingBalance_InsuranceReserve(PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(ClosingBal_RetainedEarnings_Current; GetClosingBalance_RetainedEarnings(CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ClosingBal_RetainedEarnings_Previous; GetClosingBalance_RetainedEarnings(PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(ClosingBal_Total_Current; GetClosingBalance_Total(CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ClosingBal_Total_Previous; GetClosingBalance_Total(PreviousYearEnd)) { DecimalPlaces = 2:2; }

            trigger OnAfterGetRecord()
            begin
                if BeginDate = 0D then
                    Error('Please enter a valid Begin Date');
                if EndDate = 0D then
                    Error('Please enter a valid End Date');
                if BeginDate > EndDate then
                    Error('Begin Date cannot be after End Date');

                UpdateDateRanges();
                CurrentYear := Date2DMY(EndDate, 3);
                PreviousYear := CurrentYear - 1;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(BeginDateField; BeginDate)
                {
                    ApplicationArea = All;
                    Caption = 'Begin Date';
                    ToolTip = 'Enter the start date for the report period';
                }

                field(EndDateField; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                    ToolTip = 'Enter the end date for the report period';
                }
            }
        }
    }

    var
        BeginDate: Date;
        EndDate: Date;
        CurrentYearStart: Date;
        CurrentYearEnd: Date;
        PreviousYearStart: Date;
        PreviousYearEnd: Date;
        CurrentYear: Integer;
        PreviousYear: Integer;
        CompanyName: Text[100];

    local procedure UpdateDateRanges()
    begin
        CurrentYearStart := BeginDate;
        CurrentYearEnd := EndDate;
        PreviousYearStart := CalcDate('<-1Y>', CurrentYearStart);
        PreviousYearEnd := CalcDate('<-1Y>', CurrentYearEnd);
    end;

    // ===== OPENING BALANCE PROCEDURES =====
    local procedure GetOpeningBalance_ShareCapital(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500030', CalcDate('<-1D>', AsAtDate), true));
    end;

    local procedure GetOpeningBalance_FairValue(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500231', CalcDate('<-1D>', AsAtDate), true));
    end;

    local procedure GetOpeningBalance_GeneralReserve(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500232', CalcDate('<-1D>', AsAtDate), true));
    end;

    local procedure GetOpeningBalance_CapitalReserve(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500220', CalcDate('<-1D>', AsAtDate), true));
    end;

    local procedure GetOpeningBalance_StatutoryReserve(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500230', CalcDate('<-1D>', AsAtDate), true));
    end;

    local procedure GetOpeningBalance_InsuranceReserve(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500240', CalcDate('<-1D>', AsAtDate), true) +
             GetGLBalanceAsAt('500241', CalcDate('<-1D>', AsAtDate), true));
    end;

    local procedure GetOpeningBalance_RetainedEarnings(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500060', CalcDate('<-1D>', AsAtDate), true));
    end;

    local procedure GetOpeningBalance_Total(AsAtDate: Date): Decimal
    begin
        exit(GetOpeningBalance_ShareCapital(AsAtDate) +
             GetOpeningBalance_FairValue(AsAtDate) +
             GetOpeningBalance_GeneralReserve(AsAtDate) +
             GetOpeningBalance_CapitalReserve(AsAtDate) +
             GetOpeningBalance_StatutoryReserve(AsAtDate) +
             GetOpeningBalance_InsuranceReserve(AsAtDate) +
             GetOpeningBalance_RetainedEarnings(AsAtDate));
    end;

    // ===== MOVEMENT PROCEDURES =====
    local procedure GetPriorYearAdjustment(StartDate: Date; EndDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        Amount := 0;
        GLAccount.Reset();
        GLAccount.SetFilter(Others, '%1', GLAccount.Others::PriorYearAdjustments);
        if GLAccount.FindSet() then
            repeat
                GLEntry.Reset();
                GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                GLEntry.SetRange("Posting Date", StartDate, EndDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums(Amount);
                    Amount += GLEntry.Amount;
                end;
            until GLAccount.Next() = 0;
        exit(Amount);
    end;

   
    local procedure GetAdjustmentToEquity_ShareCapital(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetGLMovement('500030', StartDate, EndDate, true));
    end;

     local procedure GetAdjustmentToEquity_FairValue(StartDate: Date; EndDate: Date): Decimal
    begin
        // Implement based on your specific adjustment logic
        exit(GetGLMovement('500231', StartDate, EndDate, true));
    end;
    local procedure GetAdjustmentToEquity_GeneralReserve(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetGLMovement('500232', StartDate, EndDate, true));
    end;
    local procedure GetAdjustmentToEquity_CapitalReserve(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetGLMovement('500220', StartDate, EndDate, true));
    end;
    local procedure GetAdjustmentToEquity_StatutoryReserve(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetGLMovement('500230', StartDate, EndDate, true));
    end;
    local procedure GetAdjustmentToEquity_InsuranceReserve(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetGLMovement('500240', StartDate, EndDate, true) +
                GetGLMovement('500241', StartDate, EndDate, true));
    end;
    local procedure GetAdjustmentToEquity_RetainedEarnings(StartDate: Date; EndDate: Date): Decimal
    begin
        // Implement based on your specific adjustment logic
         exit(GetGLMovement('500060', StartDate, EndDate, true));
        exit(0);
    end;

    local procedure GetAdjustmentToEquity_Total(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetAdjustmentToEquity_ShareCapital(StartDate, EndDate) +
             GetAdjustmentToEquity_FairValue(StartDate, EndDate) +
             GetAdjustmentToEquity_GeneralReserve(StartDate, EndDate) +
             GetAdjustmentToEquity_CapitalReserve(StartDate, EndDate) +
             GetAdjustmentToEquity_StatutoryReserve(StartDate, EndDate) +
             GetAdjustmentToEquity_InsuranceReserve(StartDate, EndDate) +
             GetAdjustmentToEquity_RetainedEarnings(StartDate, EndDate));
    end;

local procedure GetSurplusForYear_ShareCapital(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetSurplusForYear(StartDate, EndDate));
    end;
    local procedure GetSurplusForYear_FairValue(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetSurplusForYear(StartDate, EndDate));
    end;
    local procedure GetSurplusForYear_GeneralReserve(StartDate: Date; EndDate: Date): Decimal   
    begin
        exit(GetSurplusForYear(StartDate, EndDate));
    end;
    local procedure GetSurplusForYear_CapitalReserve(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetSurplusForYear(StartDate, EndDate));
    end;
    local procedure GetSurplusForYear_StatutoryReserve(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetSurplusForYear(StartDate, EndDate));
    end;
    local procedure GetSurplusForYear_InsuranceReserve(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetSurplusForYear(StartDate, EndDate));
    end;
    local procedure GetSurplusForYear_RetainedEarnings(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetSurplusForYear(StartDate, EndDate));
    end;
    local procedure GetSurplusForYear_Total(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetSurplusForYear_ShareCapital(StartDate, EndDate) +
             GetSurplusForYear_FairValue(StartDate, EndDate) +
             GetSurplusForYear_GeneralReserve(StartDate, EndDate) +
             GetSurplusForYear_CapitalReserve(StartDate, EndDate) +
             GetSurplusForYear_StatutoryReserve(StartDate, EndDate) +
             GetSurplusForYear_InsuranceReserve(StartDate, EndDate) +
             GetSurplusForYear_RetainedEarnings(StartDate, EndDate));
    end;
    local procedure GetSurplusForYear(StartDate: Date; EndDate: Date): Decimal
    var
        Revenue: Decimal;
        Expenses: Decimal;
    begin
        Revenue := GetRevenueForPeriod(StartDate, EndDate);
        Expenses := GetExpensesForPeriod(StartDate, EndDate);
        exit(Revenue - Expenses);
    end;

    local procedure GetChangeInFairValueMovement(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetGLMovement('500231', StartDate, EndDate, true));
    end;

    local procedure GetTotalComprehensiveIncome(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetSurplusForYear(StartDate, EndDate) + 
             GetChangeInFairValueMovement(StartDate, EndDate));
    end;

    local procedure GetStatutoryReserveFundMovement(StartDate: Date; EndDate: Date): Decimal
    var
        Surplus: Decimal;
    begin
        Surplus := GetSurplusForYear(StartDate, EndDate);
        if Surplus > 0 then
            exit(Surplus * 0.10) // 10% of surplus
        else
            exit(0);
    end;

    local procedure GetInsuranceFundMovement(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetGLMovement('500240', StartDate, EndDate, true) +
             GetGLMovement('500241', StartDate, EndDate, true));
    end;

    local procedure GetHonorariaProvision(StartDate: Date; EndDate: Date): Decimal//900090
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        Amount := 0;
        GLAccount.Reset();
        GLAccount.SetFilter(MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::Honoria);
        if GLAccount.FindSet() then
            repeat
                GLEntry.Reset();
                GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                GLEntry.SetRange("Posting Date", StartDate, EndDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums(Amount);
                    Amount += GLEntry.Amount;
                end;
            until GLAccount.Next() = 0;
            if Amount = 0 then begin
            Amount := GetGLBalanceAsAt('900090',EndDate, true);
            // Add other specific interest on loan accounts as needed
        end;
        exit(Amount);
    end;

    local procedure GetStaffBonusProvision(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('904060', EndDate, true));
        exit(0);
    end;

    local procedure GetDividendCapitalized(StartDate: Date; EndDate: Date): Decimal
    begin
        // Implement based on your dividend capitalization logic
        exit(0);
    end;

    local procedure GetSharesIssuedForCash(StartDate: Date; EndDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        Amount := 0;
        GLAccount.Reset();
        GLAccount.SetFilter(FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
        if GLAccount.FindSet() then
            repeat
                GLEntry.Reset();
                GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                GLEntry.SetRange("Posting Date", StartDate, EndDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums(Amount);
                    Amount += -1 * GLEntry.Amount;
                end;
            until GLAccount.Next() = 0;
        exit(Amount);
    end;

    local procedure GetProposedDividends(StartDate: Date; EndDate: Date): Decimal
    var
        SaccoInfo: Record SaccoInformation;
        ShareCapitalBalance: Decimal;
    begin
        ShareCapitalBalance := GetClosingBalance_ShareCapital(EndDate);
        if SaccoInfo.Get() then
            exit(ShareCapitalBalance * (SaccoInfo."Dividends Interest" * 0.01))
        else
            exit(0);
    end;

    // ===== RESTATED BALANCE PROCEDURES =====
    local procedure GetRestatedBalance_ShareCapital(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetOpeningBalance_ShareCapital(StartDate));
    end;

    local procedure GetRestatedBalance_FairValue(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetOpeningBalance_FairValue(StartDate) + 
             GetAdjustmentToEquity_FairValue(StartDate, EndDate));
    end;

    local procedure GetRestatedBalance_GeneralReserve(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetOpeningBalance_GeneralReserve(StartDate));
    end;

    local procedure GetRestatedBalance_CapitalReserve(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetOpeningBalance_CapitalReserve(StartDate));
    end;

    local procedure GetRestatedBalance_StatutoryReserve(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetOpeningBalance_StatutoryReserve(StartDate));
    end;

    local procedure GetRestatedBalance_InsuranceReserve(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetOpeningBalance_InsuranceReserve(StartDate));
    end;

    local procedure GetRestatedBalance_RetainedEarnings(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetOpeningBalance_RetainedEarnings(StartDate) + 
             GetPriorYearAdjustment(StartDate, EndDate) +
             GetAdjustmentToEquity_RetainedEarnings(StartDate, EndDate));
    end;

    local procedure GetRestatedBalance_Total(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(GetRestatedBalance_ShareCapital(StartDate, EndDate) +
             GetRestatedBalance_FairValue(StartDate, EndDate) +
             GetRestatedBalance_GeneralReserve(StartDate, EndDate) +
             GetRestatedBalance_CapitalReserve(StartDate, EndDate) +
             GetRestatedBalance_StatutoryReserve(StartDate, EndDate) +
             GetRestatedBalance_InsuranceReserve(StartDate, EndDate) +
             GetRestatedBalance_RetainedEarnings(StartDate, EndDate));
    end;

    // ===== CLOSING BALANCE PROCEDURES =====
    local procedure GetClosingBalance_ShareCapital(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500030', AsAtDate, true));
    end;

    local procedure GetClosingBalance_FairValue(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500231', AsAtDate, true));
    end;

    local procedure GetClosingBalance_GeneralReserve(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500232', AsAtDate, true));
    end;

    local procedure GetClosingBalance_CapitalReserve(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500220', AsAtDate, true));
    end;

    local procedure GetClosingBalance_StatutoryReserve(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500230', AsAtDate, true));
    end;

    local procedure GetClosingBalance_InsuranceReserve(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500240', AsAtDate, true) +
             GetGLBalanceAsAt('500241', AsAtDate, true));
    end;

    local procedure GetClosingBalance_RetainedEarnings(AsAtDate: Date): Decimal
    begin
        exit(GetGLBalanceAsAt('500060', AsAtDate, true));
    end;

    local procedure GetClosingBalance_Total(AsAtDate: Date): Decimal
    begin
        exit(GetClosingBalance_ShareCapital(AsAtDate) +
             GetClosingBalance_FairValue(AsAtDate) +
             GetClosingBalance_GeneralReserve(AsAtDate) +
             GetClosingBalance_CapitalReserve(AsAtDate) +
             GetClosingBalance_StatutoryReserve(AsAtDate) +
             GetClosingBalance_InsuranceReserve(AsAtDate) +
             GetClosingBalance_RetainedEarnings(AsAtDate));
    end;

    // ===== HELPER PROCEDURES =====
    local procedure GetGLBalanceAsAt(AccountNo: Code[20]; AsAtDate: Date; NegateAmount: Boolean): Decimal
    var
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        Amount := 0;
        GLEntry.Reset();
        GLEntry.SetCurrentKey("G/L Account No.", "Posting Date");
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetFilter("Posting Date", '..%1', AsAtDate);
        if GLEntry.FindSet() then begin
            GLEntry.CalcSums(Amount);
            if NegateAmount then
                Amount := -GLEntry.Amount
            else
                Amount := GLEntry.Amount;
        end;
        exit(Amount);
    end;

    local procedure GetGLMovement(AccountNo: Code[20]; StartDate: Date; EndDate: Date; NegateAmount: Boolean): Decimal
    var
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        Amount := 0;
        GLEntry.Reset();
        GLEntry.SetCurrentKey("G/L Account No.", "Posting Date");
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        if GLEntry.FindSet() then begin
            GLEntry.CalcSums(Amount);
            if NegateAmount then
                Amount := -GLEntry.Amount
            else
                Amount := GLEntry.Amount;
        end;
        exit(Amount);
    end;

    local procedure GetRevenueForPeriod(StartDate: Date; EndDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        Amount := 0;
        GLAccount.Reset();
        GLAccount.SetFilter(Financials, '%1', GLAccount.Financials::Revenue);
        if GLAccount.FindSet() then
            repeat
                GLEntry.Reset();
                GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                GLEntry.SetRange("Posting Date", StartDate, EndDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums(Amount);
                    Amount += -GLEntry.Amount;
                end;
            until GLAccount.Next() = 0;
        exit(Amount);
    end;

    local procedure GetExpensesForPeriod(StartDate: Date; EndDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        Amount := 0;
        GLAccount.Reset();
        GLAccount.SetFilter(Financials, '%1', GLAccount.Financials::Expenses);
        if GLAccount.FindSet() then
            repeat
                GLEntry.Reset();
                GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                GLEntry.SetRange("Posting Date", StartDate, EndDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums(Amount);
                    Amount += GLEntry.Amount;
                end;
            until GLAccount.Next() = 0;
        exit(Amount);
    end;
}