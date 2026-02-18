report 173004 "Note 8"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Cash & Cash Equivalent';
    DefaultLayout = RDLC;
    RdlcLayout = 'Layouts/Note8.rdlc';

    dataset
    {
        dataitem(ReportHeader; "Company Information")
        {
            column(CompanyName; CompanyInfo.Name) { }
            column(ReportTitle; 'CASH AND CASH EQUIVALENTS ANALYSIS REPORT') { }
            column(AsOfDate; 'As of: ' + Format(AsOfDateParam, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(CurrentYearLabel; 'Current Year: ' + Format(Date2DMY(AsOfDateParam, 3))) { }
            column(PreviousYearLabel; 'Previous Year: ' + Format(Date2DMY(AsOfDateParam, 3) - 1)) { }
            column(DateFilter; DateFilterText) { }

            // Table Headers
            column(Header_AccountName; 'Account Name') { }
            column(Header_AccountNo; 'Account No.') { }
            column(Header_CurrentYear; Format(Date2DMY(AsOfDateParam, 3))) { }
            column(Header_PreviousYear; Format(Date2DMY(AsOfDateParam, 3) - 1)) { }


            //  CASH AND CASH EQUIVALENT
            column(CASHCASHEQUIVALENTSectionTitle; 'CASH AND CASH EQUIVALENT') { }

            column(SavingsCoOp_No; '403020') { }
            column(SavingsCoOp_Name; 'Savings A/C Co-Operative Bank') { }
            column(SavingsCoOp_Current; GetCashBalance('403020', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SavingsCoOp_Previous; GetCashBalance('403020', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(MainCurrentCoOp_No; '403030') { }
            column(MainCurrentCoOp_Name; 'Main Current A/C Co-Operative Bank') { }
            column(MainCurrentCoOp_Current; GetCashBalance('403030', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(MainCurrentCoOp_Previous; GetCashBalance('403030', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(InstantLoanCoOp_No; '403040') { }
            column(InstantLoanCoOp_Name; 'Instant Loan Current A/C Co-Operative Bank') { }
            column(InstantLoanCoOp_Current; GetCashBalance('403040', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InstantLoanCoOp_Previous; GetCashBalance('403040', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(MainCurrentDiamond_No; '403050') { }
            column(MainCurrentDiamond_Name; 'Main Current A/C Diamond Trust Bank') { }
            column(MainCurrentDiamond_Current; GetCashBalance('403050', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(MainCurrentDiamond_Previous; GetCashBalance('403050',  PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(InstantLoanDiamond_No; '403060') { }
            column(InstantLoanDiamond_Name; 'Instant Loan Current A/C Diamond Trust Bank') { }
            column(InstantLoanDiamond_Current; GetCashBalance('403060', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InstantLoanDiamond_Previous; GetCashBalance('403060', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(HousingCurrentDiamond_No; '403070') { }
            column(HousingCurrentDiamond_Name; 'Housing Current A/C Diamond Trust Bank') { }
            column(HousingCurrentDiamond_Current; GetCashBalance('403070', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(HousingCurrentDiamond_Previous; GetCashBalance('403070', PreviousYearStart)) { DecimalPlaces = 2 : 2; }


            column(MpesaPaybill_No; '403080') { }
            column(MpesaPaybill_Name; 'Mpesa Paybill Account') { }
            column(MpesaPaybill_Current; GetCashBalance('403080', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(MpesaPaybill_Previous; GetCashBalance('403080', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(MpesaBulkPayment_No; '403090') { }
            column(MpesaBulkPayment_Name; 'Mpesa Bulk Payment Account') { }
            column(MpesaBulkPayment_Current; GetCashBalance('403090', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(MpesaBulkPayment_Previous; GetCashBalance('403090',  PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(CicUnitTrust_No; '403091') { }
            column(CicUnitTrust_Name; 'Cic Money Market') { }
            column(CicUnitTrust_Current; GetCashBalance('403091',  CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(CicUnitTrust_Previous; GetCashBalance('403091',  PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(BritamMoneyMarket_No; '403092') { }
            column(BritamMoneyMarket_Name; 'Britam Money Market Fund') { }
            column(BritamMoneyMarket_Current; GetCashBalance('403092',  CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BritamMoneyMarket_Previous; GetCashBalance('403092',  PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(NCBABank_No; '403093') { }
            column(NCBABank_Name; 'NCBA Bank') { }
            column(NCBABank_Current; GetCashBalance('403093', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(NCBABank_Previous; GetCashBalance('403093',  PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(SIB_No; '403094') { }
            column(SIB_Name; 'SIB') { }
            column(SIB_Current; GetCashBalance('403094',  CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SIB_Previous; GetCashBalance('403094', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Collateral_No; '403073') { }
            column(Collateral_Name; 'Collateral Account') { }
            column(Collateral_Current; GetCashBalance('403073',  CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Collateral_Previous; GetCashBalance('403073', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(PettyCash_No; '405010') { }
            column(PettyCash_Name; 'Cash In Hand') { }
            column(PettyCash_Current; GetCashBalance('405010',  CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(PettyCash_Previous; GetCashBalance('405010',  PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(CashAtBankSubtotal_Name; 'TOTAL CASH AND CASH EQUIVALENT') { }
            column(CashAtBankSubtotal_Current; GetCashAtBankTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(CashAtBankSubtotal_Previous; GetCashAtBankTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            //TAXABLE PAYABLE
            column(TaxPayableHeader_No; '704000') { }
            column(TaxPayableHeader_Name; 'Tax Payable (Header)') { }
            column(TaxPayableHeader_Current; GetTaxBalance('704000', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(TaxPayableHeader_Previous; GetTaxBalance('704000', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(WithholdingTaxIntDiv_No; '704020') { }
            column(WithholdingTaxIntDiv_Name; 'Withholding Tax On Interest & Dividend Payable') { }
            column(WithholdingTaxIntDiv_Current; GetTaxBalance('704020', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(WithholdingTaxIntDiv_Previous; GetTaxBalance('704020', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(PayeDirectorsAllow_No; '704030') { }
            column(PayeDirectorsAllow_Name; 'Paye On Directors'' Allowances') { }
            column(PayeDirectorsAllow_Current; GetTaxBalance('704030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(PayeDirectorsAllow_Previous; GetTaxBalance('704030', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(CorporateTaxPayable_No; '704031') { }
            column(CorporateTaxPayable_Name; 'Corporate Tax Payable') { }
            column(CorporateTaxPayable_Current; GetTaxBalance('704031', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(CorporateTaxPayable_Previous; GetTaxBalance('704031', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(HousingLevy_No; '704032') { }
            column(HousingLevy_Name; 'Housing Levy On Directors'' Allowances Payable') { }
            column(HousingLevy_Current; GetTaxBalance('704032', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(HousingLevy_Previous; GetTaxBalance('704032', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(ExciseDuty_No; '704040') { }
            column(ExciseDuty_Name; 'Excise Duty') { }
            column(ExciseDuty_Current; GetTaxBalance('704040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(ExciseDuty_Previous; GetTaxBalance('704040', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(WithholdingTaxFees_No; '704050') { }
            column(WithholdingTaxFees_Name; 'Withholding Tax On Conctractual & Professional Fees ...') { }
            column(WithholdingTaxFees_Current; GetTaxBalance('704050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(WithholdingTaxFees_Previous; GetTaxBalance('704050', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(WithholdingVat_No; '704051') { }
            column(WithholdingVat_Name; 'Withholding Vat Payable') { }
            column(WithholdingVat_Current; GetTaxBalance('704051', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(WithholdingVat_Previous; GetTaxBalance('704051', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(TaxGrandTotal_No; '704999') { }
            column(TaxGrandTotal_Name; 'TOTAL TAX PAYABLE') { }
            column(TaxGrandTotal_Current; GetTaxGrandTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(TaxGrandTotal_Previous; GetTaxGrandTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            column(Header_TaxableIncome; 'Taxable Income') { }
            column(TaxableIncome; TaxableIncome) { DecimalPlaces = 2 : 2; }
            column(TaxableIncome_Prev; TaxableIncome_Prev) { DecimalPlaces = 2 : 2; }
            column(Header_LessExemptedIncome; 'Less Exempted Income')
            { }
            column(FiftyPercentOfTaxableIncome; FiftyPercentOfTaxableIncome) { DecimalPlaces = 2 : 2; }
            column(FiftyPercentOfTaxableIncome_Prev; FiftyPercentOfTaxableIncome_Prev) { DecimalPlaces = 2 : 2; }


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
        TaxableIncome_Prev: Decimal;
        TaxableIncome: Decimal;
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        FiftyPercentOfTaxableIncome: Decimal;
        FiftyPercentOfTaxableIncome_Prev: Decimal;



    local procedure ClearVariables()
    begin
        TaxableIncome := 0;
        TaxableIncome_Prev := 0;
    end;


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

    local procedure GetCashBalance(AccountNo: Code[20]; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
    begin
        // Calculate cumulative balance from the beginning up to EndDate
        // This gives the running/closing balance shown on the ledger
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", 0D, EndDate);
        if GLEntry.CalcSums(Amount) then
            exit(GLEntry.Amount);
        exit(0);
    end;

    local procedure GetRawCashBalance(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
    begin
        if not GLAccount.Get(AccountNo) then
            exit(0);

        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", 0D, EndDate);  // Changed: 0D instead of StartDate
        if GLEntry.CalcSums(Amount) then
            exit(GLEntry.Amount);
        exit(0);
    end;

    local procedure GetCashAtBankTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetRawCashBalance('403020', StartDate, EndDate) +
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
            GetRawCashBalance('403073', StartDate, EndDate) +
            GetRawCashBalance('405010', StartDate, EndDate) +
            GetRawCashBalance('403094', StartDate, EndDate));
    end;





    local procedure GetTaxBalance(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
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

    local procedure GetRawTaxBalance(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
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

    local procedure GetTaxGrandTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        // Summing up all accounts shown in the image (except the header 704000)
        exit(
            GetRawTaxBalance('704020', StartDate, EndDate) +
            GetRawTaxBalance('704030', StartDate, EndDate) +
            GetRawTaxBalance('704031', StartDate, EndDate) +
            GetRawTaxBalance('704032', StartDate, EndDate) +
            GetRawTaxBalance('704040', StartDate, EndDate) +
            GetRawTaxBalance('704050', StartDate, EndDate) +
            GetRawTaxBalance('704051', StartDate, EndDate)
        );
    end;

    local procedure CalculateCurrentPeriod(StartDate: Date; EndDate: Date): Decimal
    begin

        TaxableIncome := GetGLAmountByAccountNo('803056', StartDate, EndDate, true) +
                           GetGLAmountByAccountNo('803057', StartDate, EndDate, true) +
                           GetGLAmountByAccountNo('803060', StartDate, EndDate, true) +
                           GetGLAmountByAccountNo('803061', StartDate, EndDate, true) +
                           GetGLAmountByAccountNo('803062', StartDate, EndDate, true);

        FiftyPercentOfTaxableIncome := TaxableIncome * 0.5;


        exit(FiftyPercentOfTaxableIncome);

    end;

    local procedure CalculatePreviousPeriod(StartDate: Date; EndDate: Date): Decimal
    begin
        TaxableIncome_Prev := GetGLAmountByAccountNo('803056', StartDate, EndDate, true) +
                      GetGLAmountByAccountNo('803057', StartDate, EndDate, true) +
                      GetGLAmountByAccountNo('803060', StartDate, EndDate, true) +
                      GetGLAmountByAccountNo('803061', StartDate, EndDate, true) +
                      GetGLAmountByAccountNo('803062', StartDate, EndDate, true);

        FiftyPercentOfTaxableIncome_Prev := TaxableIncome * 0.5;


        exit(FiftyPercentOfTaxableIncome_Prev);

    end;

    local procedure GetGLAmountByAccountNo(AccountNo: Code[20]; StartDate: Date; EndDate: Date; NegateAmount: Boolean): Decimal
    var
        Amount: Decimal;
    begin
        Amount := 0;

        GLEntry.Reset;
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        GLEntry.CalcSums(Amount);

        if NegateAmount then
            Amount := -1 * GLEntry.Amount
        else
            Amount := GLEntry.Amount;

        exit(Amount);
    end;

}