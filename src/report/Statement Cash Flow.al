report 173017 "Cash Flow Statement"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Cash Flow ';
    RDLCLayout = 'Layouts/CashFlow.rdlc';

    dataset
    {
        dataitem("Sacco Information"; SaccoInformation)
        {
            
            //Cashflow

            column(CurrentYear; Format(Date2DMY(EndDate, 3))) { }
            column(PreviousYear; Format(Date2DMY(EndDate, 3) - 1)) { }
            
            //Cash Flow from Operating Activities
            column(InterestReceipts_Current; GetInterestReceipts(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(InterestReceipts_Previous; GetInterestReceipts(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            Column(InterestMemberDeposits_Current; GetInterestOnMemberDeposits(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            Column(InterestMemberDeposits_Previous; GetInterestOnMemberDeposits(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(OtherOperatingIncome_Current; GetOtherOperatingIncome(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(OtherOperatingIncome_Previous; GetOtherOperatingIncome(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(PaymentstoEmployeesandSuppliers_Current; GetPaymentsToEmployeesAndSuppliers(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(PaymentstoEmployeesandSuppliers_Previous; GetPaymentsToEmployeesAndSuppliers(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // Subtotal after main operating items
            column(SubtotalOperatingBeforeChanges_Current; GetSubtotalOperatingBeforeChanges(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(SubtotalOperatingBeforeChanges_Previous; GetSubtotalOperatingBeforeChanges(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            //Increase/Decrease in Operating Assets
            column(PriorYearAdjustment_Current; GetPriorYearAdjustment(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(PriorYearAdjustment_Previous; GetPriorYearAdjustment(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(LoantoMembers_Current; GetLoansToMembersChange(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(LoantoMembers_Previous; GetLoansToMembersChange(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(SundryDebtors_Current; GetSundryDebtorsChange(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }   
            column(SundryDebtors_Previous; GetSundryDebtorsChange(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(TradeandotherReceivables_Current; GetTradeAndOtherReceivablesChange(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(TradeandotherReceivables_Previous; GetTradeAndOtherReceivablesChange(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // Subtotal Operating Assets
            column(TotalOperatingAssetsChange_Current; GetTotalOperatingAssetsChange(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(TotalOperatingAssetsChange_Previous; GetTotalOperatingAssetsChange(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            //Increase/Decrease in Operating Liabilities
            column(MemberDeposits_Current; GetMemberDepositsChange(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(MemberDeposits_Previous; GetMemberDepositsChange(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(InsuranceFund_Current; GetInsuranceFundsChange(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(InsuranceFund_Previous; GetInsuranceFundsChange(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(ProgrammedDeposits_Current; GetProgrammedDepositsChange(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ProgrammedDeposits_Previous; GetProgrammedDepositsChange(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(TradeandOtherPayables_Current; GetTradeAndOtherPayablesChange(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(TradeandOtherPayables_Previous; GetTradeAndOtherPayablesChange(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // Subtotal Operating Liabilities
            column(TotalOperatingLiabilitiesChange_Current; GetTotalOperatingLiabilitiesChange(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(TotalOperatingLiabilitiesChange_Previous; GetTotalOperatingLiabilitiesChange(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            //Net Cash Flow from Operating Activities Before Income Tax
            column(NetCashFlowBeforeTax_Current; GetNetCashFlowBeforeTax(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(NetCashFlowBeforeTax_Previous; GetNetCashFlowBeforeTax(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(TaxPaid_Current; GetTaxPaid(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(TaxPaid_Previous; GetTaxPaid(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // Net Cash Flow from Operating Activities
            column(NetCashFlowOperating_Current; GetNetCashFlowOperating(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(NetCashFlowOperating_Previous; GetNetCashFlowOperating(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            //Cash Flow from Investing Activities
            column(PurchaseofTangibleIntangibleAssets_Current; GetPurchaseOfPPE(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(PurchaseofTangibleIntangibleAssets_Previous; GetPurchaseOfPPE(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(HeldforSaleAssets_Current; GetHeldForSaleAssets(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(HeldforSaleAssets_Previous; GetHeldForSaleAssets(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            Column(DividendIncome_Current; GetDividendIncome(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            Column(DividendIncome_Previous; GetDividendIncome(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(InterestfromMoneyMarket_Current; GetInterestFromMoneyMarket(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(InterestfromMoneyMarket_Previous; GetInterestFromMoneyMarket(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // Net Cash Flow from Investing Activities
            column(NetCashFlowInvesting_Current; GetNetCashFlowInvesting(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(NetCashFlowInvesting_Previous; GetNetCashFlowInvesting(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            //Cash Flow from Financing Activities
            column(ShareCapital_Current; GetShareCapitalChange(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(ShareCapital_Previous; GetShareCapitalChange(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(DividendsPaid_Current; GetDividendsPaid(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(DividendsPaid_Previous; GetDividendsPaid(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(CooperativeBankLoan_Current; GetCooperativeBankLoanChange(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; } 
            column(CooperativeBankLoan_Previous; GetCooperativeBankLoanChange(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            column(InterestPaidonCooperativeBankLoan_Current; GetInterestOnCooperativeBankLoan(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(InterestPaidonCooperativeBankLoan_Previous; GetInterestOnCooperativeBankLoan(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            // Net Cash Flow from Financing Activities
            column(NetCashFlowFinancing_Current; GetNetCashFlowFinancing(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(NetCashFlowFinancing_Previous; GetNetCashFlowFinancing(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }

            //Net Increase/Decrease in Cash and Cash Equivalents
            column(NetIncreaseDecreaseCash_Current; GetNetIncreaseDecreaseCash(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(NetIncreaseDecreaseCash_Previous; GetNetIncreaseDecreaseCash(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2:2; }
            
            column(CashBeginningYear_Current; GetCashAndCashEquivalents(CurrentYearStart)) { DecimalPlaces = 2:2; }
            column(CashBeginningYear_Previous; GetCashAndCashEquivalents(PreviousYearStart)) { DecimalPlaces = 2:2; }
            
            column(CashEndYear_Current; GetCashAndCashEquivalents(CurrentYearEnd)) { DecimalPlaces = 2:2; }
            column(CashEndYear_Previous; GetCashAndCashEquivalents(PreviousYearEnd)) { DecimalPlaces = 2:2; }

            
            
            trigger OnAfterGetRecord()
            begin
                // Update date ranges for current and previous periods
                UpdateDateRanges();

                // Debug: Uncomment to verify date ranges during testing
                // Message('Current Year: %1 to %2\\Previous Year: %3 to %4',
                //         CurrentYearStart, CurrentYearEnd, PreviousYearStart, PreviousYearEnd);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Asat; Asat)
                    {
                        ApplicationArea = All;
                        Caption = 'As At Date';
                        ToolTip = 'Enter the end date for the cash flow statement';

                        trigger OnValidate()
                        begin
                            if Asat = 0D then
                                Error('Please enter a valid As At Date');
                        end;
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

        trigger OnOpenPage()
        begin
            if Asat = 0D then
                Asat := WorkDate();
        end;
    }

    trigger OnInitReport()
    begin
        ;
    end;

    trigger OnPostReport()
    begin
        ;
    end;

    trigger OnPreReport()
    begin
        // Pre-calculate date ranges
        if Asat = 0D then
            Error('Please enter a valid As At Date');
        
        UpdateDateRanges();
    end;

    var
        AsAt: Date;
        CurrentYearStart: Date;
        CurrentYearEnd: Date;
        PreviousYearStart: Date;
        PreviousYearEnd: Date;
        EndDate: Date;

    // ============================================================================
    // DATE RANGE CALCULATION
    // ============================================================================
    
    local procedure UpdateDateRanges()
    var
        DateFormula: Text;
        DateExpr2: Text;
    begin
        DateFormula := '<-CY-1D>';
        DateExpr2 := '<-CY>';

        // Set EndDate from AsAt
        EndDate := AsAt;

        // Current year calculations
        CurrentYearStart := CalcDate(DateExpr2, AsAt);
        CurrentYearEnd := AsAt;

        // Previous year calculations
        PreviousYearEnd := CalcDate(DateFormula, AsAt);
        PreviousYearStart := CalcDate(DateExpr2, PreviousYearEnd);
    end;

    // ============================================================================
    // CORE HELPER PROCEDURES
    // ============================================================================

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

    // ============================================================================
    // CASH FLOW FROM OPERATING ACTIVITIES
    // ============================================================================

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
        // if Amount = 0 then begin
        //     Amount := GetGLAmountByAccountNo('803010', StartDate, EndDate, true);//801999
            // Add other specific interest on loan accounts as needed
        //end;

        exit(Amount);
    end;

    local procedure GetInterestOnMemberDeposits(StartDate: Date; EndDate: Date): Decimal
     var
        GLEntry: Record "G/L Entry";
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        DebitAmount := 0;
        CreditAmount := 0;

        
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", '702020');
        GLEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
        if GLEntry.FindSet() then begin
            GLEntry.CalcSums("Debit Amount", "Credit Amount");
            DebitAmount := GLEntry."Debit Amount";
            CreditAmount := GLEntry."Credit Amount";
        end;

        
        exit(DebitAmount);
         
    end;

           

    local procedure GetOtherOperatingIncome(StartDate: Date; EndDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
     begin
        Amount := 0;

        GLAccount.Reset();
        GLAccount.SetFilter(GLAccount.Incomes, '%1', GLAccount.Incomes::OtherOperatingincome);
        if GLAccount.FindSet() then
            repeat
                GLEntry.Reset();
                GLEntry.SetRange(GLEntry."G/L Account No.", '803032|803040|803050|803055|803062|804011|804012|804031');
                GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartDate, EndDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums(Amount);
                    Amount += -1 * GLEntry.Amount;
                end;
            until GLAccount.Next() = 0;

        // Fallback to specific accounts
        // if Amount = 0 then begin
            // Amount :=  GetGLAmountByAccountNo('803032', StartDate, EndDate, true) +
            //           GetGLAmountByAccountNo('803040', StartDate, EndDate, true) +
            //           GetGLAmountByAccountNo('803050', StartDate, EndDate, true) +
            //           GetGLAmountByAccountNo('803055', StartDate, EndDate, true) +
            //           GetGLAmountByAccountNo('803062', StartDate, EndDate, true) +
            //           GetGLAmountByAccountNo('804012', StartDate, EndDate, true) +
            //           GetGLAmountByAccountNo('804011', StartDate, EndDate, true) +
            //           GetGLAmountByAccountNo('804031', StartDate, EndDate, true);
        // end;

        exit(Amount);
    end;

    local procedure GetPaymentsToEmployeesAndSuppliers(StartDate: Date; EndDate: Date): Decimal
    var
        Amount: Decimal;
    begin
        // Personnel expenses
        Amount := GetGLAmountByAccountNo('900159', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('900299', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('900499', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('900599', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('901999', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('904999', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902041', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902040', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902030', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902029', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902028', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902026', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902025', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902024', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902023', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902022', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902021', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902020', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902042', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902050', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902060', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902070', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902071', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902080', StartDate, EndDate, false)+
                  GetGLAmountByAccountNo('903030', StartDate, EndDate, false) +//Interest on bank loan
                  GetGLAmountByAccountNo('903056', StartDate, EndDate, false) +//Debt Collection fees
                  GetGLAmountByAccountNo('902090', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902091', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902100', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902110', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902160', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('902180', StartDate, EndDate, false) +
                  GetGLAmountByAccountNo('903020', StartDate, EndDate, false); // Bank Charges

        exit(Amount);
    end;

    // ============================================================================
    // OPERATING ASSETS CHANGES
    // ============================================================================

    local procedure GetPriorYearAdjustment(StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        DebitAmount := 0;
        CreditAmount := 0;

        // Prior year adjustment - specific account needed
        // TODO: Replace '999999' with actual account number
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", '500080');
        GLEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
        if GLEntry.FindSet() then begin
            GLEntry.CalcSums("Debit Amount", "Credit Amount");
            DebitAmount := GLEntry."Debit Amount";
            CreditAmount := GLEntry."Credit Amount";
        end;

        // Net change = Debit - Credit (adjust based on your account type)
        exit(DebitAmount - CreditAmount);
    end;

    local procedure GetLoansToMembersChange(StartDate: Date; EndDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        // Amount := 0;
        // DebitAmount := 0;
        // CreditAmount := 0;

        // GLAccount.Reset();
        // GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::LoansAndAdvances);
        // if GLAccount.FindSet() then
        //     repeat
                GLEntry.Reset();
                GLEntry.SetRange(GLEntry."G/L Account No.", '359999');
                GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartDate, EndDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums("Debit Amount", "Credit Amount");
                    DebitAmount += GLEntry."Debit Amount";
                    CreditAmount += GLEntry."Credit Amount";
                end;
          //  until GLAccount.Next() = 0;

        // Net change = Debit - Credit (increase in loans is a debit/use of cash)
        Amount := DebitAmount - CreditAmount;

        exit(Amount);
    end;

    local procedure GetSundryDebtorsChange(StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        DebitAmount := 0;
        CreditAmount := 0;

        // Sundry debtors - specific account
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", '400221');
        GLEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
        if GLEntry.FindSet() then begin
            GLEntry.CalcSums("Debit Amount", "Credit Amount");
            DebitAmount := GLEntry."Debit Amount";
            CreditAmount := GLEntry."Credit Amount";
        end;

        // Net change = Debit - Credit
        exit(DebitAmount - CreditAmount);
    end;

    local procedure GetTradeAndOtherReceivablesChange(StartDate: Date; EndDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        // Amount := 0;
        // DebitAmount := 0;
        // CreditAmount := 0;

        // GLAccount.Reset();
        // GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::ReceivablesAndPrepayements);
        // if GLAccount.FindSet() then
        //     repeat
                GLEntry.Reset();
                GLEntry.SetRange(GLEntry."G/L Account No.", '400020|400222|400223|400224');
                GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartDate, EndDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums("Debit Amount", "Credit Amount");
                    DebitAmount += GLEntry."Debit Amount";
                    CreditAmount += GLEntry."Credit Amount";
                end;
           // until GLAccount.Next() = 0;

        // Net change = Debit - Credit (increase in receivables is a debit/use of cash)
        Amount := DebitAmount - CreditAmount;

        exit(Amount);
    end;

    // ============================================================================
    // OPERATING LIABILITIES CHANGES
    // ============================================================================

    local procedure GetTradeAndOtherPayablesChange(StartDate: Date; EndDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        // Amount := 0;
        // DebitAmount := 0;
        // CreditAmount := 0;

        // GLAccount.Reset();
        // GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::TradeandotherPayables);
        // if GLAccount.FindSet() then
        //     repeat
                GLEntry.Reset();
                GLEntry.SetRange(GLEntry."G/L Account No.", '702021|703999|704020|704030|704032|704040|704050|704051|707002|706999');
                GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartDate, EndDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums("Debit Amount", "Credit Amount");
                    DebitAmount += GLEntry."Debit Amount";
                    CreditAmount += GLEntry."Credit Amount";
                end;
           // until GLAccount.Next() = 0;

        // Net change = Credit - Debit (increase in payables is a credit/source of cash)
        Amount := DebitAmount;

        exit(Amount);
    end;

    local procedure GetInsuranceFundsChange(StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        DebitAmount := 0;
        CreditAmount := 0;

        // Insurance funds - specific account
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", '500240|500241');
        GLEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
        if GLEntry.FindSet() then begin
            GLEntry.CalcSums("Debit Amount", "Credit Amount");
            DebitAmount := GLEntry."Debit Amount";
            CreditAmount := GLEntry."Credit Amount";
        end;

        // Net change = Credit - Debit (increase in liability is a source of cash)
        exit(CreditAmount - DebitAmount);
    end;

    local procedure GetMemberDepositsChange(StartDate: Date; EndDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        Amount := 0;
        DebitAmount := 0;
        CreditAmount := 0;

        GLAccount.Reset();
        GLAccount.SetFilter(GLAccount.MkopoLiabilities, '%1', GLAccount.MkopoLiabilities::MemberDeposits);
        if GLAccount.FindSet() then
            repeat
                GLEntry.Reset();
                GLEntry.SetRange(GLEntry."G/L Account No.", '700030');
                GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartDate, EndDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums("Debit Amount", "Credit Amount");
                    DebitAmount += GLEntry."Debit Amount";
                    CreditAmount += GLEntry."Credit Amount";
                end;
            until GLAccount.Next() = 0;

        // Net change = Credit - Debit (increase in deposits is a credit/source of cash)
        Amount := CreditAmount - DebitAmount;

        exit(Amount);
    end;

    local procedure GetProgrammedDepositsChange(StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        DebitAmount := 0;
        CreditAmount := 0;

        // Programmed deposits - specific account
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", '700050');
        GLEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
        if GLEntry.FindSet() then begin
            GLEntry.CalcSums("Debit Amount", "Credit Amount");
            DebitAmount := GLEntry."Debit Amount";
            CreditAmount := GLEntry."Credit Amount";
        end;

        // Net change = Credit - Debit (increase in deposits is a source of cash)
        exit(CreditAmount - DebitAmount);
    end;

    local procedure GetTaxPaid(StartDate: Date; EndDate: Date): Decimal
    var
     GLEntry: Record "G/L Entry";
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        DebitAmount := 0;
        CreditAmount := 0;

        
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", '70403');
        GLEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
        if GLEntry.FindSet() then begin
            GLEntry.CalcSums("Debit Amount", "Credit Amount");
            DebitAmount := GLEntry."Debit Amount";
            CreditAmount := GLEntry."Credit Amount";
        end;

        // Net change = Credit - Debit (increase in loan is a credit/source of cash)
        exit(CreditAmount - DebitAmount);
         // var
    //     Amount: Decimal;
    // begin
    //     Amount := GetGLAmountByAccountNo('704031', StartDate, EndDate, false);
    //     exit(Amount);
    // end;
    end;
   

    // ============================================================================
    // INVESTING ACTIVITIES
    // ============================================================================

    local procedure GetPurchaseOfPPE(StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        // Property, Plant & Equipment purchases (debit movements)
        Amount := 0;
        
        GLEntry.Reset();
        GLEntry.SetRange("Posting Date", StartDate, EndDate);
        // Add filter for PPE accounts (200000 range typically)
        GLEntry.SetFilter("G/L Account No.", '101180|101220|101242|101260|101300|101340|101380|102060');
        if GLEntry.FindSet() then
            repeat
                if GLEntry."Debit Amount" > 0 then
                    Amount += GLEntry."Debit Amount";
            until GLEntry.Next() = 0;

        exit(Amount);
    end;

    local procedure GetHeldForSaleAssets(StartDate: Date; EndDate: Date): Decimal
    var
        Amount: Decimal;
    begin
        // Assets held for sale - specific account
        Amount := GetGLAmountByAccountNo('102092', StartDate, EndDate, false);
        exit(Amount);
    end;
    local procedure GetDividendIncome(StartDate: Date; EndDate: Date): Decimal
    var
        Amount: Decimal;
    begin
        // Assets held for sale - specific account
        Amount := GetGLAmountByAccountNo('804020', StartDate, EndDate, false);
        exit(Amount);
    end;

    local procedure GetInterestFromMoneyMarket(StartDate: Date; EndDate: Date): Decimal
    var
        Amount: Decimal;
    begin
        Amount := GetGLAmountByAccountNo('803057', StartDate, EndDate, true) +
                  GetGLAmountByAccountNo('803060', StartDate, EndDate, true) +
                  GetGLAmountByAccountNo('803061', StartDate, EndDate, true) +
                  GetGLAmountByAccountNo('803056', StartDate, EndDate, true);
        exit(Amount);
    end;

    // ============================================================================
    // FINANCING ACTIVITIES
    // ============================================================================

    local procedure GetShareCapitalChange(StartDate: Date; EndDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        Amount := 0;
        DebitAmount := 0;
        CreditAmount := 0;

        GLAccount.Reset();
        GLAccount.SetFilter(GLAccount.FinancedBy, '%1', GLAccount.FinancedBy::Sharecapital);
        if GLAccount.FindSet() then
            repeat
                GLEntry.Reset();
                GLEntry.SetRange(GLEntry."G/L Account No.", '500030');
                GLEntry.SetFilter(GLEntry."Posting Date", '%1..%2', StartDate, EndDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums("Debit Amount", "Credit Amount");
                    DebitAmount += GLEntry."Debit Amount";
                    CreditAmount += GLEntry."Credit Amount";
                end;
            until GLAccount.Next() = 0;

        // Net change = Credit - Debit (increase in share capital is a credit/source of cash)
        Amount := CreditAmount - DebitAmount;

        exit(Amount);
    end;

    local procedure GetDividendsPaid(StartDate: Date; EndDate: Date): Decimal
    var
        Amount: Decimal;
    begin
        Amount := GetGLAmountByAccountNo('702040', StartDate, EndDate, false);
        exit(Amount);
    end;

    local procedure GetCooperativeBankLoanChange(StartDate: Date; EndDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
        DebitAmount: Decimal;
        CreditAmount: Decimal;
    begin
        DebitAmount := 0;
        CreditAmount := 0;

        // Cooperative bank loan - specific account
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", '600010|600020');
        GLEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
        if GLEntry.FindSet() then begin
            GLEntry.CalcSums("Debit Amount", "Credit Amount");
            DebitAmount := GLEntry."Debit Amount";
            CreditAmount := GLEntry."Credit Amount";
        end;

        // Net change = Credit - Debit (increase in loan is a credit/source of cash)
        exit(CreditAmount - DebitAmount);
    end;

    local procedure GetInterestOnCooperativeBankLoan(StartDate: Date; EndDate: Date): Decimal
    var
        Amount: Decimal;
    begin
        Amount := GetGLAmountByAccountNo('903030', StartDate, EndDate, false);
        exit(Amount);
    end;

    // ============================================================================
    // CASH AND CASH EQUIVALENTS
    // ============================================================================

    local procedure GetCashAndCashEquivalents(AsAtDate: Date): Decimal
    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        Amount := 0;

        GLAccount.Reset();
        GLAccount.SetFilter(GLAccount.Assets, '%1', GLAccount.Assets::CashAndEquivalents);
        if GLAccount.FindSet() then
            repeat
                GLEntry.Reset();
                GLEntry.SetRange(GLEntry."G/L Account No.", '406999');
                GLEntry.SetFilter(GLEntry."Posting Date", '..%1', AsAtDate);
                if GLEntry.FindSet() then begin
                    GLEntry.CalcSums(Amount);
                    Amount += GLEntry.Amount;
                end;
            until GLAccount.Next() = 0;

        exit(Amount);
    end;

    // ============================================================================
    // SUBTOTALS AND SUMMARY CALCULATIONS
    // ============================================================================

    local procedure GetSubtotalOperatingBeforeChanges(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetInterestReceipts(StartDate, EndDate) +
            GetInterestOnMemberDeposits(StartDate, EndDate) +
            GetOtherOperatingIncome(StartDate, EndDate) +
            GetPaymentsToEmployeesAndSuppliers(StartDate, EndDate));
    end;

    local procedure GetTotalOperatingAssetsChange(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetPriorYearAdjustment(StartDate, EndDate) +
            GetLoansToMembersChange(StartDate, EndDate) +
            GetSundryDebtorsChange(StartDate, EndDate) +
            GetTradeAndOtherReceivablesChange(StartDate, EndDate));
    end;

    local procedure GetTotalOperatingLiabilitiesChange(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetMemberDepositsChange(StartDate, EndDate) +
            GetInsuranceFundsChange(StartDate, EndDate) +
            GetProgrammedDepositsChange(StartDate, EndDate) +
            GetTradeAndOtherPayablesChange(StartDate, EndDate));
    end;

    local procedure GetNetCashFlowBeforeTax(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetSubtotalOperatingBeforeChanges(StartDate, EndDate) +
            GetTotalOperatingAssetsChange(StartDate, EndDate) +
            GetTotalOperatingLiabilitiesChange(StartDate, EndDate));
    end;

    local procedure GetNetCashFlowOperating(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetNetCashFlowBeforeTax(StartDate, EndDate) -
            GetTaxPaid(StartDate, EndDate));
    end;

    local procedure GetNetCashFlowInvesting(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            -GetPurchaseOfPPE(StartDate, EndDate) +
            GetHeldForSaleAssets(StartDate, EndDate) +
           GetDividendIncome(StartDate, EndDate) +
            GetInterestFromMoneyMarket(StartDate, EndDate));
    end;

    local procedure GetNetCashFlowFinancing(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetShareCapitalChange(StartDate, EndDate) -
            GetDividendsPaid(StartDate, EndDate) +
            GetCooperativeBankLoanChange(StartDate, EndDate) -
            GetInterestOnCooperativeBankLoan(StartDate, EndDate));
    end;

    local procedure GetNetIncreaseDecreaseCash(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetNetCashFlowOperating(StartDate, EndDate) +
            GetNetCashFlowInvesting(StartDate, EndDate) +
            GetNetCashFlowFinancing(StartDate, EndDate));
    end;

   
}
