report 173002 "Utapesa loan report"
{
    ApplicationArea = All;
    Caption = 'Utapesa loan report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/Utapesaloanreport.rdlc';
    dataset
    {
        dataitem(LoansRegister; "Loans Register")
        {

            DataItemTableView = where("Loan Product Type" = filter('UTAPESA'));

            column(AccountNo; "Account No")
            {
            }
            column(ActualLoanBalance; "Actual Loan Balance")
            {
            }
            column(ActualLoanBalanceHistorical; "Actual Loan Balance Historical")
            {
            }
            column(AdjtedRepayment; "Adjted Repayment")
            {
            }
            column(Adjustment; Adjustment)
            {
            }
            column(Advice; Advice)
            {
            }
            column(AdviceDate; "Advice Date")
            {
            }
            column(AdviceType; "Advice Type")
            {
            }
            column(AffidavitEstimatedValue1; "Affidavit - Estimated Value 1")
            {
            }
            column(AffidavitEstimatedValue2; "Affidavit - Estimated Value 2")
            {
            }
            column(AffidavitEstimatedValue3; "Affidavit - Estimated Value 3")
            {
            }
            column(AffidavitEstimatedValue4; "Affidavit - Estimated Value 4")
            {
            }
            column(AffidavitEstimatedValue5; "Affidavit - Estimated Value 5")
            {
            }
            column(AffidavitItem1Details; "Affidavit - Item 1 Details")
            {
            }
            column(AffidavitItem2Details; "Affidavit - Item 2 Details")
            {
            }
            column(AffidavitItem3Details; "Affidavit - Item 3 Details")
            {
            }
            column(AffidavitItem4Details; "Affidavit - Item 4 Details")
            {
            }
            column(AffidavitItem5Details; "Affidavit - Item 5 Details")
            {
            }
            column(AffidavitSigned; "Affidavit Signed?")
            {
            }
            column(AmortizationInterestRate; "Amortization Interest Rate")
            {
            }
            column(AmountDisburse; "Amount Disburse")
            {
            }
            column(AmountDisbursed; "Amount Disbursed")
            {
            }
            column(AmountOfTranche; "Amount Of Tranche")
            {
            }
            column(AmountPayedOff; "Amount Payed Off")
            {
            }
            column(AmountinArrears; "Amount in Arrears")
            {
            }
            column(AmounttoDisburseonTrunch1; "Amount to Disburse on Trunch 1")
            {
            }
            column(AppealAmount; "Appeal Amount")
            {
            }
            column(AppealPosted; "Appeal Posted")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(ApplicationFeePaid; "Application Fee Paid")
            {
            }
            column(Applicationtype; "Application type")
            {
            }
            column(ApplnbetweenCurrencies; "Appln. between Currencies")
            {
            }
            column(AppraisalFeePaid; "Appraisal Fee Paid")
            {
            }
            column(AppraisalStatus; "Appraisal Status")
            {
            }
            column(ApprovalStatus; "Approval Status")
            {
            }
            column(Approvalremarks; "Approval remarks")
            {
            }
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(ApprovedBy; "Approved By")
            {
            }
            column(ApprovedRepayment; "Approved Repayment")
            {
            }
            column(ArchiveLoan; "Archive Loan")
            {
            }
            column(ArmotizationFactor; "Armotization Factor")
            {
            }
            column(Attached; Attached)
            {
            }
            column(AttachedAmount; "Attached Amount")
            {
            }
            column(AttachementDate; "Attachement Date")
            {
            }
            column(AutoReversed; AutoReversed)
            {
            }
            column(AutoReversedDate; AutoReversedDate)
            {
            }
            column(BOSADeposits; "BOSA Deposits")
            {
            }
            column(BOSALoanAmount; "BOSA Loan Amount")
            {
            }
            column(BOSALoanNo; "BOSA Loan No.")
            {
            }
            column(BOSANo; "BOSA No")
            {
            }
            column(BSExpensesEducation; "BSExpenses Education")
            {
            }
            column(BSExpensesFood; "BSExpenses Food")
            {
            }
            column(BSExpensesOthers; "BSExpenses Others")
            {
            }
            column(BSExpensesRent; "BSExpenses Rent")
            {
            }
            column(BSExpensesTransport; "BSExpenses Transport")
            {
            }
            column(BSExpensesUtilities; "BSExpenses Utilities")
            {
            }
            column(BalanceBF; "Balance BF")
            {
            }
            column(BankAccountNo; "Bank Account No")
            {
            }
            column(BankBranch; "Bank Branch")
            {
            }
            column(BankBranchName; "Bank Branch Name")
            {
            }
            column(BankBridgeAmount; "Bank Bridge Amount")
            {
            }
            column(BankName; "Bank Name")
            {
            }
            column(BankStatementAvarageCredits; "Bank Statement Avarage Credits")
            {
            }
            column(BankStatementAvarageDebits; "Bank Statement Avarage Debits")
            {
            }
            column(BankStatementNetIncome; "Bank Statement Net Income")
            {
            }
            column(Bankcode; "Bank code")
            {
            }
            column(BasicPay; "Basic Pay")
            {
            }
            column(BasicPayH; "Basic Pay H")
            {
            }
            column(BatchNo; "Batch No.")
            {
            }
            column(BelaBranch; "Bela Branch")
            {
            }
            column(BenevolentFundContrib; "Benevolent Fund Contrib")
            {
            }
            column(BoostthisLoan; "Boost this Loan")
            {
            }
            column(BoostedAmount; "Boosted Amount")
            {
            }
            column(BoostedAmountInterest; "Boosted Amount Interest")
            {
            }
            column(BoosterLoanNo; "Booster Loan No")
            {
            }
            column(BoostingCommision; "Boosting Commision")
            {
            }
            column(BorrowingWithinDeposits; "Borrowing Within Deposits")
            {
            }
            column(BranchCode; "Branch Code")
            {
            }
            column(BridgeAmountRelease; "Bridge Amount Release")
            {
            }
            column(Bridged; Bridged)
            {
            }
            column(BridgingLoanPosted; "Bridging Loan Posted")
            {
            }
            column(BridgingPostingDate; "Bridging Posting Date")
            {
            }
            column(CRBMetro; "CRB Metro")
            {
            }
            column(CRBQuerryCharge; CRBQuerryCharge)
            {
            }
            column(CapitalizedCharges; "Capitalized Charges")
            {
            }
            column(CapturedBy; "Captured By")
            {
            }
            column(CashierBranch; "Cashier Branch")
            {
            }
            column(ChargeablePay; "Chargeable Pay")
            {
            }
            column(CheckedBy; "Checked By")
            {
            }
            column(ChequeDate; "Cheque Date")
            {
            }
            column(ChequeNo; "Cheque No.")
            {
            }
            column(ChequeNumber; "Cheque Number")
            {
            }
            column(ClearedEffects; "Cleared Effects")
            {
            }
            column(ClientCode; "Client Code")
            {
            }
            column(ClientCycle; "Client Cycle")
            {
            }
            column(ClientName; "Client Name")
            {
            }
            column(Closed; Closed)
            {
            }
            column(ClosedBy; "Closed By")
            {
            }
            column(ClosedOn; "Closed On")
            {
            }
            column(CommitementsOffset; "Commitements Offset")
            {
            }
            column(CommitteeApproval; "Committee Approval")
            {
            }
            column(CommitteeApprovalComments; "Committee Approval Comments")
            {
            }
            column(CompoundBalance; "Compound Balance")
            {
            }
            column(ContraAccount; "Contra Account")
            {
            }
            column(Contract; Contract)
            {
            }
            column(ContractualShares; "Contractual Shares")
            {
            }
            column(CopyofID; "Copy of ID")
            {
            }
            column(CorporateLoan; "Corporate Loan")
            {
            }
            column(CreditOfficer; "Credit Officer")
            {
            }
            column(CreditOfficerII; "Credit Officer II")
            {
            }
            column(CurrentInsuranceDue; "Current Insurance Due")
            {
            }
            column(CurrentInterestDue; "Current Interest Due")
            {
            }
            column(CurrentInterestPaid; "Current Interest Paid")
            {
            }
            column(CurrentLocation; "Current Location")
            {
            }
            column(CurrentPenaltyDue; "Current Penalty Due")
            {
            }
            column(CurrentPrincipleDue; "Current Principle Due")
            {
            }
            column(CurrentRepayment; "Current Repayment")
            {
            }
            column(CurrentShares; "Current Shares")
            {
            }
            column(DateApproved; "Date Approved")
            {
            }
            column(DateAuctioneerAssigned; "Date Auctioneer Assigned")
            {
            }
            column(DateRescheduled; "Date Rescheduled")
            {
            }
            column(DateforAffidavit; "Date for Affidavit")
            {
            }
            column(DateofRejection; "Date of Rejection")
            {
            }
            column(DatepaymentProcessed; "Date payment Processed")
            {
            }
            column(DaysInArrears; "Days In Arrears")
            {
            }
            column(DebtCollectiondateAssigned; "Debt Collection date Assigned")
            {
            }
            column(DebtCollectorName; "Debt Collector Name")
            {
            }
            column(Deductible; Deductible)
            {
            }
            column(DefaultloanAttached; "Default loan Attached")
            {
            }
            column(Defaulted; Defaulted)
            {
            }
            column(Defaulter; Defaulter)
            {
            }
            column(DefaulterLoan; "Defaulter Loan")
            {
            }
            column(DefaulterOveride; "Defaulter Overide")
            {
            }
            column(DefaulterOverideReasons; "Defaulter Overide Reasons")
            {
            }
            column(DefaulterSms1Sent; "Defaulter Sms 1 Sent")
            {
            }
            column(DefaulterSms2Sent; "Defaulter Sms 2 Sent")
            {
            }
            column(DefaulterInfo; DefaulterInfo)
            {
            }
            column(DepositBoosting; "Deposit Boosting")
            {
            }
            column(DepositBoostingCommision; "Deposit Boosting Commision")
            {
            }
            column(DepositContrib; "Deposit Contrib")
            {
            }
            column(DepositReinstatement; "Deposit Reinstatement")
            {
            }
            column(Dimension; Dimension)
            {
            }
            column(Disabled; Disabled)
            {
            }
            column(DisburesmentType; "Disburesment Type")
            {
            }
            column(DisbursedBy; "Disbursed By")
            {
            }
            column(Discard; Discard)
            {
            }
            column(DiscountedAmount; "Discounted Amount")
            {
            }
            column(DividendAmount; "Dividend Amount")
            {
            }
            column(DocNoUsed; "Doc No Used")
            {
            }
            column(DoublicateLoans; "Doublicate Loans")
            {
            }
            column(DueLoans; "Due Loans")
            {
            }
            column(EditInterestCalculationMeth; "Edit Interest Calculation Meth")
            {
            }
            column(EditInterestRate; "Edit Interest Rate")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(ExceptFromPenalty; "Except From Penalty")
            {
            }
            column(ExcessLSARecovery; "Excess LSA Recovery")
            {
            }
            column(ExcessUfalmeRecovery; "Excess Ufalme Recovery")
            {
            }
            column(ExemptFromPayrollDeduction; "Exempt From Payroll Deduction")
            {
            }
            column(ExisitingLoansRepayments; "Exisiting Loans Repayments")
            {
            }
            column(ExistingLoan; "Existing Loan")
            {
            }
            column(ExistingLoanRepayments; "Existing Loan Repayments")
            {
            }
            column(ExpRepay; "Exp Repay")
            {
            }
            column(ExpectedDateofCompletion; "Expected Date of Completion")
            {
            }
            column(ExpectedRepayments; "Expected Repayments")
            {
            }
            column(Extended; Extended)
            {
            }
            column(ExtendedDate; "Extended Date")
            {
            }
            column(ExtendedReason; "Extended Reason")
            {
            }
            column(ExtensionDescription; "Extension Description")
            {
            }
            column(ExternalEFT; "External EFT")
            {
            }
            column(FOAPenaltyCharged; "FOA Penalty Charged")
            {
            }
            column(FOAPenaltyDate; "FOA Penalty Date")
            {
            }
            column(FieldOffice; "Field Office")
            {
            }
            column(FinalNotice; "Final Notice")
            {
            }
            column(FlatRatePrincipal; "Flat Rate Principal")
            {
            }
            column(FlatrateInterest; "Flat rate Interest")
            {
            }
            column(FreezeInterestAccrual; "Freeze Interest Accrual")
            {
            }
            column(FreezeUntil; "Freeze Until")
            {
            }
            column(FullyDisbursed; "Fully Disbursed")
            {
            }
            column(Gender; Gender)
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(GracePeriod; "Grace Period")
            {
            }
            column(GracePeriodInterestM; "Grace Period - Interest (M)")
            {
            }
            column(GracePeriodPrincipleM; "Grace Period - Principle (M)")
            {
            }
            column(GrossPay; "Gross Pay")
            {
            }
            column(GroupAccount; "Group Account")
            {
            }
            column(GroupCode; "Group Code")
            {
            }
            column(GroupShares; "Group Shares")
            {
            }
            column(GuarantorAmount; "Guarantor Amount")
            {
            }
            column(HisaAllocation; "Hisa Allocation")
            {
            }
            column(HisaBoostingCommission; "Hisa Boosting Commission")
            {
            }
            column(HisaCommission; "Hisa Commission")
            {
            }
            column(HouseAllowance; "House Allowance")
            {
            }
            column(HouseAllowanceH; "House AllowanceH")
            {
            }
            column(HousingLevy; "Housing Levy")
            {
            }
            column(IDNO; "ID NO")
            {
            }
            column(InDueAttached; InDueAttached)
            {
            }
            column(IncomeType; "Income Type")
            {
            }
            column(InsiderStatus; "Insider Status")
            {
            }
            column(InsiderBoard; "Insider-Board")
            {
            }
            column(InsiderEmployee; "Insider-Employee")
            {
            }
            column(InstallmentDatetoSkipFrom; "Installment Date to Skip From")
            {
            }
            column(InstallmentIncludingGrace; "Installment Including Grace")
            {
            }
            column(Installments; Installments)
            {
            }
            column(InstalmentPeriod; "Instalment Period")
            {
            }
            column(Insurance; Insurance)
            {
            }
            column(Insurance025; "Insurance 0.25")
            {
            }
            column(InsuranceOnShares; "Insurance On Shares")
            {
            }
            column(InsurancePaidHistorical; "Insurance Paid Historical")
            {
            }
            column(InsurancePayoff; "Insurance Payoff")
            {
            }
            column(IntenttoReject; "Intent to Reject")
            {
            }
            column(Interest; Interest)
            {
            }
            column(InterestCalculationMethod; "Interest Calculation Method")
            {
            }
            column(InterestCharged; "Interest Charged")
            {
            }
            column(InterestDebit; "Interest Debit")
            {
            }
            column(InterestDue; "Interest Due")
            {
            }
            column(InterestInArrears; "Interest In Arrears")
            {
            }
            column(InterestPaid; "Interest Paid")
            {
            }
            column(InterestPaidHistorical; "Interest Paid Historical")
            {
            }
            column(InterestUpfront; "Interest Upfront")
            {
            }
            column(InterestUpfrontAmount; "Interest Upfront Amount")
            {
            }
            column(Interesttobepaid; "Interest to be paid")
            {
            }
            column(IntersetInArreas; IntersetInArreas)
            {
            }
            column(IsOffset; "Is Offset")
            {
            }
            column(IssuedDate; "Issued Date")
            {
            }
            column(JazaDeposits; "Jaza Deposits")
            {
            }
            column(LastAdviceDate; "Last Advice Date")
            {
            }
            column(LastIntDate; "Last Int Date")
            {
            }
            column(LastInterestDueDate; "Last Interest Due Date")
            {
            }
            column(LastInterestPayDate; "Last Interest Pay Date")
            {
            }
            column(LastLoanIssueDate; "Last Loan Issue Date")
            {
            }
            column(LastPayDate; "Last Pay Date")
            {
            }
            column(LastRepaymentDate; "Last Repayment Date")
            {
            }
            column(Lastloan; "Last loan")
            {
            }
            column(LeastRetainedAmount; "Least Retained Amount")
            {
            }
            column(LevyOnJazaDeposits; "Levy On Jaza Deposits")
            {
            }
            column(LifeInsurance; "Life Insurance")
            {
            }
            column(LoanCashCleared; "Loan  Cash Cleared")
            {
            }
            column(LoanNo; "Loan  No.")
            {
            }
            column(LoanAccountNo; "Loan Account No")
            {
            }
            column(LoanAmount; "Loan Amount")
            {
            }
            column(LoanAmountDue; "Loan Amount Due")
            {
            }
            column(LoanAppeal; "Loan Appeal")
            {
            }
            column(LoanAppraisalFee; "Loan Appraisal Fee")
            {
            }
            column(LoanAuctioneer; "Loan Auctioneer")
            {
            }
            column(LoanAuctioneerName; "Loan Auctioneer Name")
            {
            }
            column(LoanBalAsAtDebtCollection; "Loan Bal As At Debt Collection")
            {
            }
            column(LoanBalanceatRescheduling; "Loan Balance at Rescheduling")
            {
            }
            column(LoanCalcOffsetLoan; "Loan Calc. Offset Loan")
            {
            }
            column(LoanCashClearancefee; "Loan Cash Clearance fee")
            {
            }
            column(LoanCentre; "Loan Centre")
            {
            }
            column(LoanCollateralSecured; "Loan Collateral Secured")
            {
            }
            column(LoanCount; "Loan Count")
            {
            }
            column(LoanCurrentPayoffAmount; "Loan Current Payoff Amount")
            {
            }
            column(LoanCycle; "Loan Cycle")
            {
            }
            column(LoanDebtCollector; "Loan Debt Collector")
            {
            }
            column(LoanDebtCollectorInterest; "Loan Debt Collector Interest %")
            {
            }
            column(LoanDepositMultiplier; "Loan Deposit Multiplier")
            {
            }
            column(LoanDisbursedAmount; "Loan Disbursed Amount")
            {
            }
            column(LoanDisbursementDate; "Loan Disbursement Date")
            {
            }
            column(LoanDue; "Loan Due")
            {
            }
            column(LoanInstallmentstoSkip; "Loan Installments to Skip")
            {
            }
            column(LoanInsurance; "Loan Insurance")
            {
            }
            column(LoanInsuranceCharged; "Loan Insurance Charged")
            {
            }
            column(LoanInsurancePaid; "Loan Insurance Paid")
            {
            }
            column(LoanInterestRepayment; "Loan Interest Repayment")
            {
            }
            column(LoanLastPaydate2009Nav; "Loan Last Pay date 2009Nav")
            {
            }
            column(LoanMissinginPortfolioProv; "Loan Missing in Portfolio Prov")
            {
            }
            column(LoanNoFound; "Loan No Found")
            {
            }
            column(LoanOffsetAmount; "Loan Offset Amount")
            {
            }
            column(LoanPrincipalOffset; "Loan Principal Offset")
            {
            }
            column(LoanPrincipleRepayment; "Loan Principle Repayment")
            {
            }
            column(LoanProcessing; "Loan Processing")
            {
            }
            column(LoanProcessingFee; "Loan Processing Fee")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanProductTypeName; "Loan Product Type Name")
            {
            }
            column(LoanPurpose; "Loan Purpose")
            {
            }
            column(LoanPurposeDescription; "Loan Purpose Description")
            {
            }
            column(LoanReceived; "Loan Received")
            {
            }
            column(LoanRecoveryAccountFOSA; "Loan Recovery Account FOSA")
            {
            }
            column(LoanRepayment; "Loan Repayment")
            {
            }
            column(LoanReschedule; "Loan Reschedule")
            {
            }
            column(LoanRescheduleInstalments; "Loan Reschedule Instalments")
            {
            }
            column(LoanRescheduledBy; "Loan Rescheduled By")
            {
            }
            column(LoanRescheduledDate; "Loan Rescheduled Date")
            {
            }
            column(LoanSMSFee; "Loan SMS Fee")
            {
            }
            column(LoanSeriesCount; "Loan Series Count")
            {
            }
            column(LoanStageDescription; "Loan Stage Description")
            {
            }
            column(LoanStages; "Loan Stages")
            {
            }
            column(LoanStatus; "Loan Status")
            {
            }
            column(LoanTransferFee; "Loan Transfer Fee")
            {
            }
            column(LoanUnderAuctioneer; "Loan Under Auctioneer")
            {
            }
            column(LoanUnderDebtCollection; "Loan Under Debt Collection")
            {
            }
            column(LoantoReschedule; "Loan to Reschedule")
            {
            }
            column(LoantoShareRatio; "Loan to Share Ratio")
            {
            }
            column(LoansCategory; "Loans Category")
            {
            }
            column(LoansCategorySASRA; "Loans Category-SASRA")
            {
            }
            column(LoansInsurance; "Loans Insurance")
            {
            }
            column(LoansUnderCRBNotice; "Loans Under CRB Notice")
            {
            }
            column(LstLN1; "Lst LN1")
            {
            }
            column(LstLN2; "Lst LN2")
            {
            }
            column(MagistrateName; "Magistrate Name")
            {
            }
            column(MainSector; "Main Sector")
            {
            }
            column(MainSectorDiscription; "Main-Sector Discription")
            {
            }
            column(MarkAsPerforming; "Mark As Performing")
            {
            }
            column(MaxInstallments; "Max. Installments")
            {
            }
            column(MaxLoanAmount; "Max. Loan Amount")
            {
            }
            column(MedicalAllowanceH; "Medical AllowanceH")
            {
            }
            column(MedicalInsurance; "Medical Insurance")
            {
            }
            column(MemberAccountCategory; "Member Account Category")
            {
            }
            column(MemberCategory; "Member Category")
            {
            }
            column(MemberCreditScore; "Member Credit Score")
            {
            }
            column(MemberDepositAccountNo; "Member Deposit Account No")
            {
            }
            column(MemberDeposits; "Member Deposits")
            {
            }
            column(MemberFound; "Member Found")
            {
            }
            column(MemberGroup; "Member Group")
            {
            }
            column(MemberGroupName; "Member Group Name")
            {
            }
            column(MemberHouseGroup; "Member House Group")
            {
            }
            column(MemberHouseGroupName; "Member House Group Name")
            {
            }
            column(MemberNotFound; "Member Not Found")
            {
            }
            column(MemberShareCapital; "Member Share Capital")
            {
            }
            column(MembershipDurationYears; "Membership Duration(Years)")
            {
            }
            column(MileageAllowance; "Mileage Allowance")
            {
            }
            column(MinDepositAsPerTier; "Min Deposit As Per Tier")
            {
            }
            column(MobilePhoneNo; "Mobile Phone No")
            {
            }
            column(ModeofDisbursement; "Mode of Disbursement")
            {
            }
            column(MonthlyContribution; "Monthly Contribution")
            {
            }
            column(MonthlySharesCont; "Monthly Shares Cont")
            {
            }
            column(NHIF; NHIF)
            {
            }
            column(NSSF; NSSF)
            {
            }
            column(NameofChiefAssistant; "Name of Chief/ Assistant")
            {
            }
            column(NetAmount; "Net Amount")
            {
            }
            column(NetIncome; "Net Income")
            {
            }
            column(NetPaymenttoFOSA; "Net Payment to FOSA")
            {
            }
            column(NetSalary; "Net Salary")
            {
            }
            column(NetUtilizableAmount; "Net Utilizable Amount")
            {
            }
            column(NettakeHome; "Net take Home")
            {
            }
            column(Nettakehome2; "Net take home 2")
            {
            }
            column(NewGracePeriod; "New Grace Period")
            {
            }
            column(NewInterestRate; "New Interest Rate")
            {
            }
            column(NewNoofInstalment; "New No. of Instalment")
            {
            }
            column(NewRegularInstalment; "New Regular Instalment")
            {
            }
            column(NewRepaymentPeriod; "New Repayment Period")
            {
            }
            column(NewRepaymentStartDate; "New Repayment Start Date")
            {
            }
            column(NoLoaninMB; "No Loan in MB")
            {
            }
            column(NoofActiveLoans; "No of Active Loans")
            {
            }
            column(NoofGurantorsFOSA; "No of Gurantors FOSA")
            {
            }
            column(NoofMonthsinArrears; "No of Months in Arrears")
            {
            }
            column(NoofTranchDisbursment; "No of Tranch Disbursment")
            {
            }
            column(NoOfGuarantors; "No. Of Guarantors")
            {
            }
            column(NoOfGuarantorsFOSA; "No. Of Guarantors-FOSA")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(NonPayrollPayments; "Non Payroll Payments")
            {
            }
            column(NotifyGuarantorSMS; "Notify Guarantor SMS")
            {
            }
            column(OffsetCommission; "Offset Commission")
            {
            }
            column(OffsetEligibilityAmount; "Offset Eligibility Amount")
            {
            }
            column(OffsetLoanNo; "Offset Loan No")
            {
            }
            column(OffsetiNTEREST; "Offset iNTEREST")
            {
            }
            column(OldAccountNo; "Old Account No.")
            {
            }
            column(OldVendorNo; "Old Vendor No")
            {
            }
            column(OneOffLoanRepayment; "OneOff Loan Repayment")
            {
            }
            column(OriginalApprovedAmount; "Original Approved Amount")
            {
            }
            column(OriginalApprovedUpdated; "Original Approved Updated")
            {
            }
            column(OriginalLoan; "Original Loan")
            {
            }
            column(OriginalLoanee; "Original Loanee")
            {
            }
            column(OtherAllowance; "Other Allowance")
            {
            }
            column(OtherBenefits; "Other Benefits")
            {
            }
            column(OtherCommitmentsClearance; "Other Commitments Clearance")
            {
            }
            column(OtherIncome; "Other Income")
            {
            }
            column(OtherLiabilities; "Other Liabilities")
            {
            }
            column(OtherLoansRepayments; "Other Loans Repayments")
            {
            }
            column(OtherNonTaxable; "Other Non-Taxable")
            {
            }
            column(OtherTaxRelief; "Other Tax Relief")
            {
            }
            column(OustandingInteresttoDate; "Oustanding Interest to Date")
            {
            }
            column(OutstandingBalance; "Outstanding Balance")
            {
            }
            column(OutstandingBalancetoDate; "Outstanding Balance to Date")
            {
            }
            column(OutstandingBalanceCapitalize; "Outstanding Balance-Capitalize")
            {
            }
            column(OutstandingInsurance; "Outstanding Insurance")
            {
            }
            column(OutstandingInterest; "Outstanding Interest")
            {
            }
            column(OutstandingLoan; "Outstanding Loan")
            {
            }
            column(OutstandingLoan2; "Outstanding Loan2")
            {
            }
            column(OutstandingPenalty; "Outstanding Penalty")
            {
            }
            column(OutstandingLessInt; OutstandingLessInt)
            {
            }
            column(PAYE; PAYE)
            {
            }
            column(PPP1; PPP1)
            {
            }
            column(PartialDisbursedAmountDue; "Partial Disbursed(Amount Due)")
            {
            }
            column(PayPayee; PayPayee)
            {
            }
            column(PayingBankAccountNo; "Paying Bank Account No")
            {
            }
            column(PaymentDueDate; "Payment Due Date")
            {
            }
            column(PayrollCodeB; "Payroll CodeB")
            {
            }
            column(PaysInterestDuringGP; "Pays Interest During GP")
            {
            }
            column(Payslip; Payslip)
            {
            }
            column(Penalty; Penalty)
            {
            }
            column(PenaltyCharged; "Penalty Charged")
            {
            }
            column(PenaltyPaid; "Penalty Paid")
            {
            }
            column(PenaltyPaidHistorical; "Penalty Paid Historical")
            {
            }
            column(PenaltyAttached; PenaltyAttached)
            {
            }
            column(Pension; Pension)
            {
            }
            column(PensionScheme; "Pension Scheme")
            {
            }
            column(PercentRepayments; "Percent Repayments")
            {
            }
            column(PersonalLoanOffset; "Personal Loan Off-set")
            {
            }
            column(Posted; Posted)
            {
            }
            column(Prepayments; Prepayments)
            {
            }
            column(PreviousRepayment; "Previous Repayment")
            {
            }
            column(PreviousYearsDividend; "Previous Years Dividend")
            {
            }
            column(PrincipalPaid; "Principal Paid")
            {
            }
            column(PrincipleAmountUpdated; "Principle Amount Updated")
            {
            }
            column(PrinciplePaidHistorical; "Principle Paid Historical")
            {
            }
            column(PrinciplePaidtoDate; "Principle Paid to Date")
            {
            }
            column(PrivateMember; "Private Member")
            {
            }
            column(ProcessedPayment; "Processed Payment")
            {
            }
            column(ProductCode; "Product Code")
            {
            }
            column(ProductCurrencyCode; "Product Currency Code")
            {
            }
            column(ProgrammedDepositContrib; "Programmed Deposit Contrib")
            {
            }
            column(ProjectAccountNo; "Project Account No")
            {
            }
            column(ProjectAmount; "Project Amount")
            {
            }
            column(ProvidentFund; "Provident Fund")
            {
            }
            column(ProvidentFundSelf; "Provident Fund (Self)")
            {
            }
            column(RAmount; RAmount)
            {
            }
            column(Rating; Rating)
            {
            }
            column(ReasonForLoanReschedule; "Reason For Loan Reschedule")
            {
            }
            column(ReceivedCopiesofPayslip; "Received Copies of Payslip")
            {
            }
            column(ReceivedCopyOfID; "Received Copy Of ID")
            {
            }
            column(ReceivedPayslipBankStatemen; "Received Payslip/Bank Statemen")
            {
            }
            column(RecommendedAmount; "Recommended Amount")
            {
            }
            column(ReconIssue; "Recon Issue")
            {
            }
            column(Reconciled; Reconciled)
            {
            }
            column(RecoveredBalance; "Recovered Balance")
            {
            }
            column(RecoveredFromGuarantor; "Recovered From Guarantor")
            {
            }
            column(RecoveredLoan; "Recovered Loan")
            {
            }
            column(RecoveryMode; "Recovery Mode")
            {
            }
            column(RegistrationDate; "Registration Date")
            {
            }
            column(RejectedBy; "Rejected By")
            {
            }
            column(RejectionRemark; "Rejection  Remark")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(ReopeningloanRemarks; "Reopening loan Remarks")
            {
            }
            column(RepayCount; "Repay Count")
            {
            }
            column(Repayment; Repayment)
            {
            }
            column(RepaymentDatesRescheduled; "Repayment Dates Rescheduled")
            {
            }
            column(RepaymentDatesRescheduledBy; "Repayment Dates Rescheduled By")
            {
            }
            column(RepaymentDatesRescheduledOn; "Repayment Dates Rescheduled On")
            {
            }
            column(RepaymentDueDate; "Repayment Due Date")
            {
            }
            column(RepaymentFrequency; "Repayment Frequency")
            {
            }
            column(RepaymentMethod; "Repayment Method")
            {
            }
            column(RepaymentRate; "Repayment Rate")
            {
            }
            column(RepaymentStartDate; "Repayment Start Date")
            {
            }
            column(RepaymentsBF; "Repayments BF")
            {
            }
            column(RequestedAmount; "Requested Amount")
            {
            }
            column(RescheduleEffectiveDate; "Reschedule Effective Date")
            {
            }
            column(Rescheduleby; "Reschedule by")
            {
            }
            column(Rescheduled; Rescheduled)
            {
            }
            column(Reversed; Reversed)
            {
            }
            column(RiskMGT; "Risk MGT")
            {
            }
            column(SExpensesEducation; "SExpenses Education")
            {
            }
            column(SExpensesFood; "SExpenses Food")
            {
            }
            column(SExpensesOthers; "SExpenses Others")
            {
            }
            column(SExpensesRent; "SExpenses Rent")
            {
            }
            column(SExpensesTransport; "SExpenses Transport")
            {
            }
            column(SExpensesUtilities; "SExpenses Utilities")
            {
            }
            column(SaccoDecision; "Sacco Decision")
            {
            }
            column(SaccoDeductions; "Sacco Deductions")
            {
            }
            column(SaccoInterest; "Sacco Interest")
            {
            }
            column(SalaryNetUtilizable; "Salary Net Utilizable")
            {
            }
            column(SalaryTotalIncome; "Salary Total Income")
            {
            }
            column(Savings; Savings)
            {
            }
            column(Sceduled; Sceduled)
            {
            }
            column(ScheduleInterest; "Schedule Interest")
            {
            }
            column(ScheduleInteresttoDate; "Schedule Interest to Date")
            {
            }
            column(ScheduleRepayment; "Schedule Repayment")
            {
            }
            column(ScheduleRepayments; "Schedule Repayments")
            {
            }
            column(ScheduledPrincipaltoDate; "Scheduled Principal to Date")
            {
            }
            column(SectorDescription; "Sector Description")
            {
            }
            column(SectorSpecific; "Sector Specific")
            {
            }
            column(ShareBoostingComission; "Share Boosting Comission")
            {
            }
            column(ShareCapitalContrib; "Share Capital Contrib")
            {
            }
            column(ShareCapitalDue; "Share Capital Due")
            {
            }
            column(SharePurchase; "Share Purchase")
            {
            }
            column(ShareCapitalToDeduct; ShareCapitalToDeduct)
            {
            }
            column(SharesBalance; "Shares Balance")
            {
            }
            column(SharesBoosted; "Shares Boosted")
            {
            }
            column(SharestoBoost; "Shares to Boost")
            {
            }
            column(Signature; Signature)
            {
            }
            column(SkipInstallmentsEffected; "Skip Installments Effected")
            {
            }
            column(SkipInstallmentsEffectedBy; "Skip Installments Effected By")
            {
            }
            column(SkipInstallmentsEffectedOn; "Skip Installments Effected On")
            {
            }
            column(Source; Source)
            {
            }
            column(SourceofFunds; "Source of Funds")
            {
            }
            column(SpecialLoanAmount; "Special Loan Amount")
            {
            }
            column(SpecificSectorDiscription; "Specific-Sector Discription")
            {
            }
            column(Staff; Staff)
            {
            }
            column(StaffAssement; "Staff Assement")
            {
            }
            column(StaffNo; "Staff No")
            {
            }
            column(StaffUnionContribution; "Staff Union Contribution")
            {
            }
            column(StatementAccount; "Statement Account")
            {
            }
            column(SubSector; "Sub Sector")
            {
            }
            column(SubSectorDiscription; "Sub-Sector Discription")
            {
            }
            column(SystemCreated; "System Created")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TotalDeductions; "Total Deductions")
            {
            }
            column(TotalDeductionsSalary; "Total Deductions(Salary)")
            {
            }
            column(TotalDeductionsH; "Total DeductionsH")
            {
            }
            column(TotalDisbursmenttoDate; "Total Disbursment to Date")
            {
            }
            column(TotalEarningsSalary; "Total Earnings(Salary)")
            {
            }
            column(TotalInsurancePaid; "Total Insurance Paid")
            {
            }
            column(TotalInterest; "Total Interest")
            {
            }
            column(TotalInterestPaid; "Total Interest Paid")
            {
            }
            column(TotalLoanGuaranted; "Total Loan Guaranted")
            {
            }
            column(TotalLoanInterest; "Total Loan Interest")
            {
            }
            column(TotalLoanRepayment; "Total Loan Repayment")
            {
            }
            column(TotalLoansOutstanding; "Total Loans Outstanding")
            {
            }
            column(TotalOffsetAmount; "Total Offset Amount")
            {
            }
            column(TotalOffsetCommission; "Total Offset Commission")
            {
            }
            column(TotalOutstandingLoanBAL; "Total Outstanding Loan BAL")
            {
            }
            column(TotalPenaltyPaid; "Total Penalty Paid")
            {
            }
            column(TotalPrinciplePaid; "Total Principle Paid")
            {
            }
            column(TotalRepayment; "Total Repayment")
            {
            }
            column(TotalRepayments; "Total Repayments")
            {
            }
            column(TotalScheduleRepayment; "Total Schedule Repayment")
            {
            }
            column(TotalloanOutstanding; "Total loan Outstanding")
            {
            }
            column(TotalsLoanOutstanding; "Totals Loan Outstanding")
            {
            }
            column(TranchAmountDisbursed; "Tranch Amount Disbursed")
            {
            }
            column(TrancheNumber; "Tranche Number")
            {
            }
            column(TransactingBranch; "Transacting Branch")
            {
            }
            column(TransportAllowance; "Transport Allowance")
            {
            }
            column(TransportBusFare; "Transport/Bus Fare")
            {
            }
            column(Upfronts; Upfronts)
            {
            }
            column(Upraised; Upraised)
            {
            }
            column(UtilizableAmount; "Utilizable Amount")
            {
            }
            column(ViewSchedule; "View Schedule")
            {
            }
            column(VoluntaryDeductions; "Voluntary Deductions")
            {
            }
            column(WorkingDate; "Working Date")
            {
            }
            column(loanInterest; "loan  Interest")
            {
            }
            column(partiallyBridged; "partially Bridged")
            {
            }
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
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
