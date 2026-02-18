//************************************************************************
tableextension 172005 "GLaccountExt" extends "G/L Account"
{
    fields
    {
        // Add changes to table fields here
        field(172000; "Budget Controlled"; Boolean)
        {
        }
        field(172004; "Expense Code"; Code[10])
        {
            TableRelation = "Expense Code";

            trigger OnValidate()
            begin
                //Expense code only applicable if account type is posting and Budgetary control is applicable
                TestField("Account Type", "account type"::Posting);
                TestField("Budget Controlled", true);
            end;
        }
        field(172005; "Donor defined Account"; Boolean)
        {
            Description = 'Select if the Account is donor Defined';
        }
        field(54244; test; Code[20])
        {
        }
        field(54245; "Grant Expense"; Boolean)
        {
        }
        field(54246; Status; Option)
        {
            Editable = true;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(54247; "Responsibility Center"; Code[20])
        {
            //TableRelation = Table55929.Field1;
        }
        field(54248; "Old No."; Code[20])
        {
        }
        field(54249; "Date Created"; Date)
        {
        }
        field(54250; "Created By"; Code[70])
        {
        }
        field(54251; "Capital adequecy"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,ShareCapital,StatutoryReserve,RetainedEarnings,NetSurplusaftertax,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,OtherAssets,PropertyandEquipment,TotalDepositsLiabilities,CapitalGrants';
            OptionMembers = "  ",ShareCapital,StatutoryReserve,RetainedEarnings,NetSurplusaftertax,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,Otherassets,PropertyandEquipment,TotalDepositsLiabilities,CapitalGrants;
        }
        field(54252; "Form2F(Statement of C Income)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,InvestmentinCompaniesshares,InterestExpenseonDeposits,DividendExpenses,FeesCommissionExpense,OtherFinancialExpense,OtherExpense,ProvisionforLoanLosses,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries,FinancialIncome';
            OptionMembers = "  ",InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,InvestmentinCompaniesshares,InterestExpenseonDeposits,DividendExpenses,FeesCommissionExpense,OtherFinancialExpense,OtherExpense,ProvisionforLoanLosses,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries,FinancialIncome;
        }
        field(54253; "Form2F1(Statement of C Income)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries';
            OptionMembers = "  ",PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries;
        }
        field(54254; "Form2E(investment)"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Core_Capital,NonEarningassets,Totaldeposits,Subsidiaryandrelatedentities,Equityinvestment,Otherinvestments,Otherassets';
            OptionMembers = " ",Core_Capital,Nonearningassets,totaldeposits,subsidiaryandrelatedentities,Equityinvestment,Otherinvestments,otherassets;
        }
        field(54255; "Form2E(investment)New"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,NonEarningassets';
            OptionMembers = " ",Nonearningassets;
        }
        field(54256; "Form2E(investment)Land"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,LandBuilding';
            OptionMembers = " ",LandBuilding;
        }
        field(54257; Liquidity; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,TotalOtherliabilitiesNew,TimeDeposits,balanceswithotherfinancialinstitutions,GovSecurities,BankBalances,LocalNotes,OverdraftsandMaturedLoans,LiabilitiesMaturingwithin91Days,MaturedLiabilities';
            OptionMembers = " ",TotalOtherliabilitiesNew,TimeDeposits,balanceswithotherfinancialinsti,GovSecurities,BankBalances,LocalNotes,OverdraftsandMaturedLoans,LiabilitiesMaturingwithin91Days,MaturedLaibilities;
        }
        field(54258; StatementOfFP; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Cashinhand,Cashatbank,GrossLoanPortfolio,PropertyEquipment,AllowanceforLoanLoss,PrepaymentsSundryReceivables,Investmentincompanies,Other Assets,IntangibleAssets,ExternalBorrowings,Placement,EquityInvestments,DividendPayable,CurrentYearSurplus,Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities,PrepaidLease,InvestmentProperties,TaxRecoverable,GovernmentSecurities,CommercialPapers';
            OptionMembers = "  ",Cashinhand,Cashatbank,GrossLoanPortfolio,PropertyEquipment,AllowanceforLoanLoss,PrepaymentsSundryReceivables,Investmentincompanies,"Other Assets",IntangibleAssets,ExternalBorrowings,Placement,EquityInvestments,DividendPayable,CurrentYearSurplus,Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities,PrepaidLease,InvestmentProperties,TaxRecoverable,GovernmentSecurities,CommercialPapers;
        }
        field(54259; StatementOfFP2; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities,Revenue';
            OptionMembers = " ",Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities,Revenue;
        }
        field(54260; "Form 2H other disc"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Core_Cpital,Liquidity,DepositLiabilites,Otherliablilities,CoreCapitalDeduction,AllowanceForLoanLoss,LoansandAdvances';
            OptionMembers = " ",Core_Cpital,Liquidity,Depositliabilites,Otherliablilities,CoreCapitalDeduction,AllowanceForLoanLoss,LoansandAdvances;
        }
        field(54262; "Loan Liability"; Boolean)
        {
        }
        field(54263; "MkopoLiabilities"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,memberdeposits,dividendsandInterestPayable,TradeandotherPayables,Honoria,Taxpayable';
            OptionMembers = " ",memberdeposits,dividendsandInterestPayable,TradeandotherPayables,Honoria,Taxpayable;

        }
        field(54264; "Others"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,ShortTermLiabilities,PriorYearAdjustments';
            OptionMembers = " ",ShortTermLiabilities,PriorYearAdjustments;

        }
        field(54265; "FinancedBy"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,RevenueReserves,Sharecapital,StatutoryReserves';
            OptionMembers = " ",RevenueReserves,Sharecapital,StatutoryReserves;

        }
        field(54266; "Incomes"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,InterestOnLoans,InterestExpenses,OtherOperatingincome,InvestmentIncome,GorvernanceExpenses,AdministrationExpenses,PersonelExpenses,OperatingExpenses,FinancialExpense,MarketingExpenses,DepreciationAmmortisation,IncomeTaxExpense';
            OptionMembers = " ",InterestOnLoans,InterestExpenses,OtherOperatingincome,InvestmentIncome,GorvernanceExpenses,AdministrationExpenses,PersonelExpenses,OperatingExpenses,FinancialExpense,MarketingExpenses,DepreciationAmmortisation,IncomeTaxExpense;

        }
        field(54267; "Assets"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' , ReceivablesAndPrepayements,LoansAndAdvances,FinancialAssets,CashAndEquivalents';
            OptionMembers = " ",ReceivablesAndPrepayements,LoansAndAdvances,FinancialAssets,CashAndEquivalents;

        }
        field(54268; "Financials"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Revenue,Expenses';
            OptionMembers = " ",Revenue,Expenses;

        }


    }
    trigger OnInsert()
    begin
        CheckEditPermission();
    end;

    trigger OnModify()
    begin
        CheckEditPermission();
    end;

    trigger OnDelete()
    begin
        CheckEditPermission();
    end;

    local procedure CheckEditPermission()
    var
        UserSetup: Record "User Setup";
        NoEditPermissionErr: Label 'You do not have permission to edit the Chart of Accounts.';
    begin
        if not UserSetup.Get(UserId) then
            Error(NoEditPermissionErr);

        if not UserSetup."Can Edit COA" then
            Error(NoEditPermissionErr);
    end;

    var
        myInt: Integer;
}


