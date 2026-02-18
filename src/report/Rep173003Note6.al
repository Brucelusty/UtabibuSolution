report 173003 "Note 6"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Expenses';
    DefaultLayout = RDLC;
    RdlcLayout = 'Layouts/Note6.rdlc';

    dataset
    {
        dataitem(ReportHeader; "Company Information")
        {
            column(CompanyName; CompanyInfo.Name) { }
            column(ReportTitle; 'EXPENSES ANALYSIS REPORT') { }
            column(AsOfDate; 'As of: ' + Format(AsOfDateParam, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(CurrentYearLabel; 'Current Year: ' + Format(Date2DMY(AsOfDateParam, 3))) { }
            column(PreviousYearLabel; 'Previous Year: ' + Format(Date2DMY(AsOfDateParam, 3) - 1)) { }
            column(DateFilter; DateFilterText) { }

            // Table Headers
            column(Header_AccountName; 'Account Name') { }
            column(Header_AccountNo; 'Account No.') { }
            column(Header_CurrentYear; Format(Date2DMY(AsOfDateParam, 3))) { }
            column(Header_PreviousYear; Format(Date2DMY(AsOfDateParam, 3) - 1)) { }

            // ADMINISTRATIVE EXPENSES SECTION
            column(AdminExpensesSectionTitle; 'ADMINISTRATIVE EXPENSES') { }

            column(AnnualGeneralMeeting_No; '900030') { }


            column(UshirikaDay_No; '900050') { }
            column(UshirikaDay_Name; 'Ushirika Day Celebration') { }
            column(UshirikaDay_Current; GetExpenseBalance('900050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(UshirikaDay_Previous; GetExpenseBalance('900050', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StrategicPlan_No; '900051') { }
            column(StrategicPlan_Name; 'Strategic Plan Formulation & Review') { }
            column(StrategicPlan_Current; GetExpenseBalance('900051', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StrategicPlan_Previous; GetExpenseBalance('900051', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(PoliciesFormulation_No; '900052') { }
            column(PoliciesFormulation_Name; 'Policies Formulation & Review') { }
            column(PoliciesFormulation_Current; GetExpenseBalance('900052', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(PoliciesFormulation_Previous; GetExpenseBalance('900052', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(CorporateSocialResp_No; '901021') { }
            column(CorporateSocialResp_Name; 'Donation (CSR)') { }
            column(CorporateSocialResp_Current; GetExpenseBalance('901021', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(CorporateSocialResp_Previous; GetExpenseBalance('901021', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(FeasibilityStudy_No; '900053') { }
            column(FeasibilityStudy_Name; 'Feasibility Study') { }
            column(FeasibilityStudy_Current; GetExpenseBalance('900053', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(FeasibilityStudy_Previous; GetExpenseBalance('900053', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(AuditingSupervision_No; '900060') { }
            column(AuditingSupervision_Name; 'External Audit') { }
            column(AuditingSupervision_Current; GetExpenseBalance('900060', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(AuditingSupervision_Previous; GetExpenseBalance('900060', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(HousingLevyDirectors_No; '900111') { }
            column(HousingLevyDirectors_Name; 'Housing Levy On Directors\ Allowance') { }
            column(HousingLevyDirectors_Current; GetExpenseBalance('900111', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(HousingLevyDirectors_Previous; GetExpenseBalance('900111', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(DirectorsTelephone_No; '900120') { }
            column(DirectorsTelephone_Name; 'Directors\ Telephone Allowance') { }
            column(DirectorsTelephone_Current; GetExpenseBalance('900120', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DirectorsTelephone_Previous; GetExpenseBalance('900120', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(NitaDirectors_No; '900121') { }
            column(NitaDirectors_Name; 'Nita For Directors') { }
            column(NitaDirectors_Current; GetExpenseBalance('900121', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(NitaDirectors_Previous; GetExpenseBalance('900121', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(DirectorsTraining_No; '900130') { }
            column(DirectorsTraining_Name; 'Directors\ Training') { }
            column(DirectorsTraining_Current; GetExpenseBalance('900130', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DirectorsTraining_Previous; GetExpenseBalance('900130', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(InternalAuditor_No; '900151') { }
            column(InternalAuditor_Name; 'Internal Auditor') { }
            column(InternalAuditor_Current; GetExpenseBalance('900151', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InternalAuditor_Previous; GetExpenseBalance('900151', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(EndYearParty_No; '902090') { }
            column(EndYearParty_Name; 'Year End Party') { }
            column(EndYearParty_Current; GetExpenseBalance('902090', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(EndYearParty_Previous; GetExpenseBalance('902090', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(TotalAdminExpenses_Name; 'Total Administrative Expenses') { }
            column(TotalAdminExpenses_Current; GetAdministrativeExpensesTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(TotalAdminExpenses_Previous; GetAdministrativeExpensesTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // COMMITTEE ALLOWANCES SECTION
            column(CommitteeAllowancesSectionTitle; 'COMMITTEE ALLOWANCES') { }

            // Committee Sitting Allowances
            column(CommitteeSittingTitle; 'Committee Sitting Allowance') { }

            column(CreditRiskSitting_No; '900170') { }
            column(CreditRiskSitting_Name; 'Credit & Risk Com. Sitting Allowance') { }
            column(CreditRiskSitting_Current; GetExpenseBalance('900170', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(CreditRiskSitting_Previous; GetExpenseBalance('900170', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(FinanceAdminSitting_No; '900190') { }
            column(FinanceAdminSitting_Name; 'Finance & Administration Com Sitting Allowance') { }
            column(FinanceAdminSitting_Current; GetExpenseBalance('900190', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(FinanceAdminSitting_Previous; GetExpenseBalance('900190', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(SupervisoryComSitting_No; '900210') { }
            column(SupervisoryComSitting_Name; 'Supervisory Com. Sitting Allowances') { }
            column(SupervisoryComSitting_Current; GetExpenseBalance('900210', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SupervisoryComSitting_Previous; GetExpenseBalance('900210', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(BoardSittingAllowance_No; '900220') { }
            column(BoardSittingAllowance_Name; 'Board Sitting Allowance') { }
            column(BoardSittingAllowance_Current; GetExpenseBalance('900220', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BoardSittingAllowance_Previous; GetExpenseBalance('900220', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(JointBoardSitting_No; '900230') { }
            column(JointBoardSitting_Name; 'Joint Board/Supervisory Com Sitting Allowance') { }
            column(JointBoardSitting_Current; GetExpenseBalance('900230', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(JointBoardSitting_Previous; GetExpenseBalance('900230', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(EducationBusinessSitting_No; '900240') { }
            column(EducationBusinessSitting_Name; 'Education & Business Development Com. Sitting Allowance') { }
            column(EducationBusinessSitting_Current; GetExpenseBalance('900240', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(EducationBusinessSitting_Previous; GetExpenseBalance('900240', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(CommitteeSittingSubtotal_Name; 'Committee Sitting Allowance') { }
            column(CommitteeSittingSubtotal_Current; GetCommitteeSittingTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(CommitteeSittingSubtotal_Previous; GetCommitteeSittingTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // Committee Transport Allowances
            column(CommitteeTransportTitle; 'Committee Transport Allowance') { }

            column(CreditRiskTransport_No; '900310') { }
            column(CreditRiskTransport_Name; 'Credit & Risk Com. Transport Allowance') { }
            column(CreditRiskTransport_Current; GetExpenseBalance('900310', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(CreditRiskTransport_Previous; GetExpenseBalance('900310', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(FinanceAdminTransport_No; '900330') { }
            column(FinanceAdminTransport_Name; 'Finance & Administration Com. Transport Allowance') { }
            column(FinanceAdminTransport_Current; GetExpenseBalance('900330', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(FinanceAdminTransport_Previous; GetExpenseBalance('900330', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(SupervisoryComTransport_No; '900350') { }
            column(SupervisoryComTransport_Name; 'Supervisory Com.Transport Allowance') { }
            column(SupervisoryComTransport_Current; GetExpenseBalance('900350', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SupervisoryComTransport_Previous; GetExpenseBalance('900350', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(BoardTransportAllowance_No; '900360') { }
            column(BoardTransportAllowance_Name; 'Board Transport Allowance') { }
            column(BoardTransportAllowance_Current; GetExpenseBalance('900360', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BoardTransportAllowance_Previous; GetExpenseBalance('900360', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(JointSupBoardTransport_No; '900370') { }
            column(JointSupBoardTransport_Name; 'Joint Sup/Board Transport Allowance') { }
            column(JointSupBoardTransport_Current; GetExpenseBalance('900370', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(JointSupBoardTransport_Previous; GetExpenseBalance('900370', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(EducationBusinessTransport_No; '900380') { }
            column(EducationBusinessTransport_Name; 'Education & Business Development Com.Transport Allowance') { }
            column(EducationBusinessTransport_Current; GetExpenseBalance('900380', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(EducationBusinessTransport_Previous; GetExpenseBalance('900380', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(NominationCommittee_No; '900381') { }
            column(NominationCommittee_Name; 'Nomination Committee') { }
            column(NominationCommittee_Current; GetExpenseBalance('900381', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(NominationCommittee_Previous; GetExpenseBalance('900381', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(CommitteeTransportSubtotal_Name; 'Committee Transport Allowance') { }
            column(CommitteeTransportSubtotal_Current; GetCommitteeTransportTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(CommitteeTransportSubtotal_Previous; GetCommitteeTransportTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // Committee Subsistence Allowances
            column(CommitteeSubsistenceTitle; 'Committee Subsistence Allowance') { }

            column(CreditRiskSubsistence_No; '900501') { }
            column(CreditRiskSubsistence_Name; 'Credit & Risk Com. Subsistence Allowance') { }
            column(CreditRiskSubsistence_Current; GetExpenseBalance('900501', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(CreditRiskSubsistence_Previous; GetExpenseBalance('900501', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(FinanceAdminSubsistence_No; '900502') { }
            column(FinanceAdminSubsistence_Name; 'Finance & Administration Com.Subsistence Allowance') { }
            column(FinanceAdminSubsistence_Current; GetExpenseBalance('900502', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(FinanceAdminSubsistence_Previous; GetExpenseBalance('900502', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(SupervisoryComSubsistence_No; '900503') { }
            column(SupervisoryComSubsistence_Name; 'Supervisory Com. Subsistence Allowance') { }
            column(SupervisoryComSubsistence_Current; GetExpenseBalance('900503', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SupervisoryComSubsistence_Previous; GetExpenseBalance('900503', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(BoardSubsistenceAllowance_No; '900504') { }
            column(BoardSubsistenceAllowance_Name; 'Board Subsistence Allowance') { }
            column(BoardSubsistenceAllowance_Current; GetExpenseBalance('900504', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BoardSubsistenceAllowance_Previous; GetExpenseBalance('900504', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(JointSupBoardSubsistence_No; '900505') { }
            column(JointSupBoardSubsistence_Name; 'Joint Sup/Board Subsistence Allowance') { }
            column(JointSupBoardSubsistence_Current; GetExpenseBalance('900505', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(JointSupBoardSubsistence_Previous; GetExpenseBalance('900505', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(EducationBusinessSubsistence_No; '900506') { }
            column(EducationBusinessSubsistence_Name; 'Education & Business Development Com.Subsistence Allowance') { }
            column(EducationBusinessSubsistence_Current; GetExpenseBalance('900506', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(EducationBusinessSubsistence_Previous; GetExpenseBalance('900506', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(CommitteeSubsistenceSubtotal_Name; 'Committee Subsistence Allowance') { }
            column(CommitteeSubsistenceSubtotal_Current; GetCommitteeSubsistenceTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(CommitteeSubsistenceSubtotal_Previous; GetCommitteeSubsistenceTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

           

            //Governce Expenses
            column(DirectorChristmasVoucher_Name; 'Director Christmas Voucher') { }
            column(DirectorChristmasVoucher_Current; GetExpenseBalance('900140', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DirectorChristmasVoucher_Previous; GetExpenseBalance('900140', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(DirectorTraining_Name; 'Director Training') { }
            column(DirectorTraining_Current; GetExpenseBalance('900130', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DirectorTraining_Previous; GetExpenseBalance('900130', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            Column(SittingAllowance_Name; 'Sitting Allowance') { }
            Column(SittingAllowance_Current; GetExpenseBalance('900299', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(SittingAllowance_Previous; GetExpenseBalance('900299', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Transport_Name; 'Transport') { }
            column(Transport_Current; GetExpenseBalance('900499', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Transport_Previous; GetExpenseBalance('900499', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Telephone_Name; 'Telephone') { }
            column(Telephone_Current; GetExpenseBalance('900120', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Telephone_Previous; GetExpenseBalance('900120', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(AnnualGeneralMeeting_Name; 'Annual General Meeting') { }
            column(AnnualGeneralMeeting_Current; GetExpenseBalance('900030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(AnnualGeneralMeeting_Previous; GetExpenseBalance('900030', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(EducationDay_Name; 'Education Day') { }
            column(EducationDay_Current; GetExpenseBalance('900040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(EducationDay_Previous; GetExpenseBalance('900040', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Nita_Name; 'NITA') { }
            column(Nita_Current; GetExpenseBalance('900121', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Nita_Previous; GetExpenseBalance('900121', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            Column(HousingLevy_Name; 'Housing Levy') { }
            Column(HousingLevy_Current; GetExpenseBalance('900111', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            Column(HousingLevy_Previous; GetExpenseBalance('900111', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(GovernanceExpensesTotal_Name; 'Total Governance Expenses') { }
            column(GovernanceExpensesTotal_Current; GetGovernanceExpensesTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(GovernanceExpensesTotal_Previous; GetGovernanceExpensesTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }


            // MARKETING EXPENSES SECTION
            column(MarketingExpensesSectionTitle; 'MARKETING EXPENSES') { }

            column(PromotionAdvertising_No; '901020') { }
            column(PromotionAdvertising_Name; 'Promotion And Advertising') { }
            column(PromotionAdvertising_Current; GetExpenseBalance('901020', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(PromotionAdvertising_Previous; GetExpenseBalance('901020', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

             column(MembersRecruitment_No; '901030') { }
            column(MembersRecruitment_Name; 'Members Recruitment') { }
            column(MembersRecruitment_Current; GetExpenseBalance('901030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(MembersRecruitment_Previous; GetExpenseBalance('901030', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Anniversary_No; '901023') { }
            column(Anniversary_Name; '50th Anniversary') { }
            column(Anniversary_Current; GetExpenseBalance('901023', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Anniversary_Previous; GetExpenseBalance('901023', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(TotalMarketingExpenses_Name; 'Total Marketing Expenses') { }
            column(TotalMarketingExpenses_Current; GetMarketingExpensesTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(TotalMarketingExpenses_Previous; GetMarketingExpensesTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // OPERATING EXPENSES SECTION
            column(OperatingExpensesSectionTitle; 'OPERATING EXPENSES') { }

            column(PrintingStationeries_No; '902020') { }
            column(PrintingStationeries_Name; 'Printing And Stationeries') { }
            column(PrintingStationeries_Current; GetExpenseBalance('902020', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(PrintingStationeries_Previous; GetExpenseBalance('902020', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Rent_No; '902021') { }
            column(Rent_Name; 'Rent') { }
            column(Rent_Current; GetExpenseBalance('902021', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Rent_Previous; GetExpenseBalance('902021', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Electricity_No; '902022') { }
            column(Electricity_Name; 'Electricity') { }
            column(Electricity_Current; GetExpenseBalance('902022', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Electricity_Previous; GetExpenseBalance('902022', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(SASRALevy_No; '902023') { }
            column(SASRALevy_Name; 'SASRA Levy') { }
            column(SASRALevy_Current; GetExpenseBalance('902023', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SASRALevy_Previous; GetExpenseBalance('902023', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(BusinessLicense_No; '902024') { }
            column(BusinessLicense_Name; 'Business License') { }
            column(BusinessLicense_Current; GetExpenseBalance('902024', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BusinessLicense_Previous; GetExpenseBalance('902024', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(OccupationalHealthSafety_No; '902025') { }
            column(OccupationalHealthSafety_Name; 'Occupational Health & Safety') { }
            column(OccupationalHealthSafety_Current; GetExpenseBalance('902025', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OccupationalHealthSafety_Previous; GetExpenseBalance('902025', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(ServiceCharge_No; '902026') { }
            column(ServiceCharge_Name; 'Service Charge') { }
            column(ServiceCharge_Current; GetExpenseBalance('902026', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(ServiceCharge_Previous; GetExpenseBalance('902026', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(LegalFees_No; '902028') { }
            column(LegalFees_Name; 'Legal Fees') { }
            column(LegalFees_Current; GetExpenseBalance('902028', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(LegalFees_Previous; GetExpenseBalance('902028', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(ConsultancyFee_No; '902029') { }
            column(ConsultancyFee_Name; 'Consultancy Fee') { }
            column(ConsultancyFee_Current; GetExpenseBalance('902029', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(ConsultancyFee_Previous; GetExpenseBalance('902029', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(OfficeTransport_No; '902030') { }
            column(OfficeTransport_Name; 'Office Transport') { }
            column(OfficeTransport_Current; GetExpenseBalance('902030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OfficeTransport_Previous; GetExpenseBalance('902030', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(PostageTelephone_No; '902040') { }
            column(PostageTelephone_Name; 'Postage And Telephone') { }
            column(PostageTelephone_Current; GetExpenseBalance('902040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(PostageTelephone_Previous; GetExpenseBalance('902040', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(LoansInsurance_No; '902041') { }
            column(LoansInsurance_Name; 'Loans Cover') { }
            column(LoansInsurance_Current; GetExpenseBalance('902041', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(LoansInsurance_Previous; GetExpenseBalance('902041', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(UsapesaSupport_No; '902042') { }
            column(UsapesaSupport_Name; 'Utapesa Support') { }
            column(UsapesaSupport_Current; GetExpenseBalance('902042', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(UsapesaSupport_Previous; GetExpenseBalance('902042', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(ComputerHardwareRepairs_No; '902050') { }
            column(ComputerHardwareRepairs_Name; 'Computer (Hardware) Repairs') { }
            column(ComputerHardwareRepairs_Current; GetExpenseBalance('902050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(ComputerHardwareRepairs_Previous; GetExpenseBalance('902050', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(ComputerSoftwareMaintenance_No; '902060') { }
            column(ComputerSoftwareMaintenance_Name; 'Computer (Software) Maintenance') { }
            column(ComputerSoftwareMaintenance_Current; GetExpenseBalance('902060', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(ComputerSoftwareMaintenance_Previous; GetExpenseBalance('902060', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(WebsiteMaintenance_No; '902070') { }
            column(WebsiteMaintenance_Name; 'Website Maintenance') { }
            column(WebsiteMaintenance_Current; GetExpenseBalance('902070', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(WebsiteMaintenance_Previous; GetExpenseBalance('902070', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(InternetBackup_No; '902071') { }
            column(InternetBackup_Name; 'Internet and Backup') { }
            column(InternetBackup_Current; GetExpenseBalance('902071', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InternetBackup_Previous; GetExpenseBalance('902071', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(OtherOfficeRepairs_No; '902080') { }
            column(OtherOfficeRepairs_Name; 'Other Office Repairs & Maintenance') { }
            column(OtherOfficeRepairs_Current; GetExpenseBalance('902080', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OtherOfficeRepairs_Previous; GetExpenseBalance('902080', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(InsuranceOfficeEquipments_No; '902100') { }
            column(InsuranceOfficeEquipments_Name; 'Insurance Of Office Equipments') { }
            column(InsuranceOfficeEquipments_Current; GetExpenseBalance('902100', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InsuranceOfficeEquipments_Previous; GetExpenseBalance('902100', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(OfficeConsumables_No; '902110') { }
            column(OfficeConsumables_Name; 'Office Consumables') { }
            column(OfficeConsumables_Current; GetExpenseBalance('902110', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OfficeConsumables_Previous; GetExpenseBalance('902110', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(IncomeTaxExpenses_No; '902130') { }
            column(IncomeTaxExpenses_Name; 'Income Tax Expenses') { }
            column(IncomeTaxExpenses_Current; GetExpenseBalance('902130', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(IncomeTaxExpenses_Previous; GetExpenseBalance('902130', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Depreciation_No; '902140') { }
            column(Depreciation_Name; 'Depreciation') { }
            column(Depreciation_Current; GetExpenseBalance('902140', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Depreciation_Previous; GetExpenseBalance('902140', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(OtherRoutingExpenses_No; '902160') { }
            column(OtherRoutingExpenses_Name; 'Other Routing Expenses') { }
            column(OtherRoutingExpenses_Current; GetExpenseBalance('902160', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OtherRoutingExpenses_Previous; GetExpenseBalance('902160', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(OfficeSecurityServices_No; '902180') { }
            column(OfficeSecurityServices_Name; 'Office Security Services') { }
            column(OfficeSecurityServices_Current; GetExpenseBalance('902180', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(OfficeSecurityServices_Previous; GetExpenseBalance('902180', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(TotalOperatingExpenses_Name; 'Total Operating Expenses') { }
            column(TotalOperatingExpenses_Current; GetOperatingExpensesTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(TotalOperatingExpenses_Previous; GetOperatingExpensesTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // FINANCIAL EXPENSES SECTION
            column(FinancialExpensesSectionTitle; 'FINANCIAL EXPENSES') { }

            column(BankCharges_No; '903020') { }
            column(BankCharges_Name; 'Bank Charges') { }
            column(BankCharges_Current; GetExpenseBalance('903020', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BankCharges_Previous; GetExpenseBalance('903020', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(InterestBankLoan_No; '903030') { }
            column(InterestBankLoan_Name; 'Interest On Bank Loan') { }
            column(InterestBankLoan_Current; GetExpenseBalance('903030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InterestBankLoan_Previous; GetExpenseBalance('903030', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(InterestProgrammedDeposits_No; '903040') { }
            column(InterestProgrammedDeposits_Name; 'Interest On Programmed Deposits') { }
            column(InterestProgrammedDeposits_Current; GetExpenseBalance('903040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InterestProgrammedDeposits_Previous; GetExpenseBalance('903040', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(InterestMembersDeposits_No; '903050') { }
            column(InterestMembersDeposits_Name; 'Interest Interest On Members Deposits') { }
            column(InterestMembersDeposits_Current; GetExpenseBalance('903050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(InterestMembersDeposits_Previous; GetExpenseBalance('903050', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(DividendShareCapital_No; '903051') { }
            column(DividendShareCapital_Name; 'Dividend Payable') { }
            column(DividendShareCapital_Current; GetExpenseBalance('903051', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DividendShareCapital_Previous; GetExpenseBalance('903051', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(BadDebt_No; '903052') { }
            column(BadDebt_Name; 'Bad Debt (KUSCCO Shares)') { }
            column(BadDebt_Current; GetExpenseBalance('903052', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BadDebt_Previous; GetExpenseBalance('903052', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(ProvisionMonarchDevelopers_No; '903053') { }
            column(ProvisionMonarchDevelopers_Name; 'Provision for sundry Receivables') { }
            column(ProvisionMonarchDevelopers_Current; GetExpenseBalance('903053', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(ProvisionMonarchDevelopers_Previous; GetExpenseBalance('903053', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(ProvisionPlotDebtors_No; '903054') { }
            column(ProvisionPlotDebtors_Name; 'Provision for Plot Debtors') { }
            column(ProvisionPlotDebtors_Current; GetExpenseBalance('903054', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(ProvisionPlotDebtors_Previous; GetExpenseBalance('903054', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(ProvisionLoansLoss_No; '903055') { }
            column(ProvisionLoansLoss_Name; 'Provision For Loans Loss') { }
            column(ProvisionLoansLoss_Current; GetExpenseBalance('903055', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(ProvisionLoansLoss_Previous; GetExpenseBalance('903055', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(DebtCollectionFees_No; '903056') { }
            column(DebtCollectionFees_Name; 'Debt Collection Fees') { }
            column(DebtCollectionFees_Current; GetExpenseBalance('903056', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DebtCollectionFees_Previous; GetExpenseBalance('903056', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(BonusShares_No; '903057') { }
            column(BonusShares_Name; 'Bonus Shares') { }
            column(BonusShares_Current; GetExpenseBalance('903057', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BonusShares_Previous; GetExpenseBalance('903057', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(BonusDeposits_No; '903058') { }
            column(BonusDeposits_Name; 'Bonus on Deposits') { }
            column(BonusDeposits_Current; GetExpenseBalance('903058', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(BonusDeposits_Previous; GetExpenseBalance('903058', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(TotalFinancialExpenses_Name; 'Total Financial Expenses') { }
            column(TotalFinancialExpenses_Current; GetFinancialExpensesTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(TotalFinancialExpenses_Previous; GetFinancialExpensesTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // PAYROLL EXPENSES SECTION
            column(PayrollExpensesSectionTitle; 'PAYROLL EXPENSES') { }

            column(SalariesWages_No; '904020') { }
            column(SalariesWages_Name; 'Salaries & Wages') { }
            column(SalariesWages_Current; GetExpenseBalance('904020', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(SalariesWages_Previous; GetExpenseBalance('904020', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StaffHousingLevy_No; '904026') { }
            column(StaffHousingLevy_Name; 'Staff Housing Levy Expense') { }
            column(StaffHousingLevy_Current; GetExpenseBalance('904026', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffHousingLevy_Previous; GetExpenseBalance('904026', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Nssf_No; '904030') { }
            column(Nssf_Name; 'Nssf') { }
            column(Nssf_Current; GetExpenseBalance('904030', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Nssf_Previous; GetExpenseBalance('904030', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(Pension_No; '904040') { }
            column(Pension_Name; 'Pension') { }
            column(Pension_Current; GetExpenseBalance('904040', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Pension_Previous; GetExpenseBalance('904040', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(LeaveAllowance_No; '904050') { }
            column(LeaveAllowance_Name; 'Leave Allowance') { }
            column(LeaveAllowance_Current; GetExpenseBalance('904050', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(LeaveAllowance_Previous; GetExpenseBalance('904050', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StaffBonus_No; '904060') { }
            column(StaffBonus_Name; 'Staff Bonus') { }
            column(StaffBonus_Current; GetExpenseBalance('904060', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffBonus_Previous; GetExpenseBalance('904060', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StaffMedical_No; '904070') { }
            column(StaffMedical_Name; 'Staff Medical') { }
            column(StaffMedical_Current; GetExpenseBalance('904070', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffMedical_Previous; GetExpenseBalance('904070', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StaffAssuranceWiba_No; '904080') { }
            column(StaffAssuranceWiba_Name; 'Staff Assurance-Wiba & Group Life') { }
            column(StaffAssuranceWiba_Current; GetExpenseBalance('904080', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffAssuranceWiba_Previous; GetExpenseBalance('904080', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StaffProvidentFund_No; '904090') { }
            column(StaffProvidentFund_Name; 'Staff Provident Fund') { }
            column(StaffProvidentFund_Current; GetExpenseBalance('904090', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffProvidentFund_Previous; GetExpenseBalance('904090', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StaffOvertime_No; '904100') { }
            column(StaffOvertime_Name; 'Staff Overtime') { }
            column(StaffOvertime_Current; GetExpenseBalance('904100', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffOvertime_Previous; GetExpenseBalance('904100', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StaffActingAllowance_No; '904110') { }
            column(StaffActingAllowance_Name; 'Staff Acting Allowance') { }
            column(StaffActingAllowance_Current; GetExpenseBalance('904110', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffActingAllowance_Previous; GetExpenseBalance('904110', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StaffTraining_No; '904111') { }
            column(StaffTraining_Name; 'Staff Training') { }
            column(StaffTraining_Current; GetExpenseBalance('904111', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffTraining_Previous; GetExpenseBalance('904111', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(NitaStaff_No; '904112') { }
            column(NitaStaff_Name; 'Nita Staff') { }
            column(NitaStaff_Current; GetExpenseBalance('904112', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(NitaStaff_Previous; GetExpenseBalance('904112', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(StaffLoanInterestBenefit_No; '904113') { }
            column(StaffLoanInterestBenefit_Name; 'Staff Loan Interest Benefit') { }
            column(StaffLoanInterestBenefit_Current; GetExpenseBalance('904113', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(StaffLoanInterestBenefit_Previous; GetExpenseBalance('904113', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(TotalPayrollExpenses_Name; 'Total Payroll Expenses') { }
            column(TotalPayrollExpenses_Current; GetPayrollExpensesTotal(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(TotalPayrollExpenses_Previous; GetPayrollExpensesTotal(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            Column(DepreciationAmortisation_Name; 'Depreciation/Amortisation') { }
            column(DepreciationAmortisation_Current; GetExpenseBalance('902140', CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(DepreciationAmortisation_Previous; GetExpenseBalance('902140', PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            // GRAND TOTAL
            column(TotalExpenses_Name; 'TOTAL EXPENSES') { }
            column(TotalExpenses_Current; GetTotalExpenses(CurrentYearStart, CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(TotalExpenses_Previous; GetTotalExpenses(PreviousYearStart, PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

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

    local procedure GetExpenseBalance(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
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

    local procedure GetRawExpenseBalance(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
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

    local procedure GetAdministrativeExpensesTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            
            GetRawExpenseBalance('900050', StartDate, EndDate) +
            GetRawExpenseBalance('900051', StartDate, EndDate) +
            GetRawExpenseBalance('900052', StartDate, EndDate) +
            GetRawExpenseBalance('900053', StartDate, EndDate) +
            GetRawExpenseBalance('900060', StartDate, EndDate) +
            GetRawExpenseBalance('900111', StartDate, EndDate) +
            GetRawExpenseBalance('900120', StartDate, EndDate) +
            GetRawExpenseBalance('900121', StartDate, EndDate) +
            GetRawExpenseBalance('900130', StartDate, EndDate) +
            GetRawExpenseBalance('902020', StartDate, EndDate) +
            GetRawExpenseBalance('902021', StartDate, EndDate) +
            GetRawExpenseBalance('902022', StartDate, EndDate) +
            GetRawExpenseBalance('902023', StartDate, EndDate) +
            GetRawExpenseBalance('902024', StartDate, EndDate) +
            GetRawExpenseBalance('902025', StartDate, EndDate) +
            GetRawExpenseBalance('902026', StartDate, EndDate) +
            GetRawExpenseBalance('902028', StartDate, EndDate) +
            GetRawExpenseBalance('902029', StartDate, EndDate) +
            GetRawExpenseBalance('902030', StartDate, EndDate) +
            GetRawExpenseBalance('902040', StartDate, EndDate) +
            GetRawExpenseBalance('902041', StartDate, EndDate) +
            GetRawExpenseBalance('902042', StartDate, EndDate) +
            GetRawExpenseBalance('902050', StartDate, EndDate) +
            GetRawExpenseBalance('902060', StartDate, EndDate) +
            GetRawExpenseBalance('902070', StartDate, EndDate) +
            GetRawExpenseBalance('902071', StartDate, EndDate) +
            GetRawExpenseBalance('902080', StartDate, EndDate) );
            // GetRawExpenseBalance('902100', StartDate, EndDate) +
            // GetRawExpenseBalance('902110', StartDate, EndDate) +
            // GetRawExpenseBalance('902160', StartDate, EndDate) +
            // GetRawExpenseBalance('902180', StartDate, EndDate)+
            // GetRawExpenseBalance('900151', StartDate, EndDate));
    end;

    local procedure GetCommitteeSittingTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetRawExpenseBalance('900170', StartDate, EndDate) +
            GetRawExpenseBalance('900190', StartDate, EndDate) +
            GetRawExpenseBalance('900210', StartDate, EndDate) +
            GetRawExpenseBalance('900220', StartDate, EndDate) +
            GetRawExpenseBalance('900230', StartDate, EndDate) +
            GetRawExpenseBalance('900240', StartDate, EndDate));
    end;

    local procedure GetCommitteeTransportTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetRawExpenseBalance('900310', StartDate, EndDate) +
            GetRawExpenseBalance('900330', StartDate, EndDate) +
            GetRawExpenseBalance('900350', StartDate, EndDate) +
            GetRawExpenseBalance('900360', StartDate, EndDate) +
            GetRawExpenseBalance('900370', StartDate, EndDate) +
            GetRawExpenseBalance('900380', StartDate, EndDate) +
            GetRawExpenseBalance('900381', StartDate, EndDate));
    end;

    local procedure GetCommitteeSubsistenceTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetRawExpenseBalance('900501', StartDate, EndDate) +
            GetRawExpenseBalance('900502', StartDate, EndDate) +
            GetRawExpenseBalance('900503', StartDate, EndDate) +
            GetRawExpenseBalance('900504', StartDate, EndDate) +
            GetRawExpenseBalance('900505', StartDate, EndDate) +
            GetRawExpenseBalance('900506', StartDate, EndDate));
    end;

    // local procedure GetTotalAdminGeneralExpenses(StartDate: Date; EndDate: Date): Decimal
    // begin
    //     exit(
    //         GetAdministrativeExpensesTotal(StartDate, EndDate) +
            
    // end;

    local procedure GetGovernanceExpensesTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetExpenseBalance('900140', StartDate, EndDate) +
            GetExpenseBalance('900130', StartDate, EndDate) +
            GetExpenseBalance('900299', StartDate, EndDate) +
            GetExpenseBalance('900499', StartDate, EndDate) +
            GetExpenseBalance('900120', StartDate, EndDate) +
            GetExpenseBalance('900030', StartDate, EndDate) +
            GetExpenseBalance('900040', StartDate, EndDate) +
            GetExpenseBalance('900121', StartDate, EndDate) +
            GetExpenseBalance('900111', StartDate, EndDate));
    end;

    local procedure GetMarketingExpensesTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetRawExpenseBalance('901020', StartDate, EndDate) +
            GetRawExpenseBalance('901023', StartDate, EndDate) +
            GetRawExpenseBalance('901030', StartDate, EndDate));
    end;

    local procedure GetOperatingExpensesTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        // exit(
            
    end;

    local procedure GetFinancialExpensesTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetRawExpenseBalance('903020', StartDate, EndDate) +
            GetRawExpenseBalance('903030', StartDate, EndDate) +
            GetRawExpenseBalance('903040', StartDate, EndDate) +
            GetRawExpenseBalance('903050', StartDate, EndDate) +
            GetRawExpenseBalance('903051', StartDate, EndDate) +
            GetRawExpenseBalance('903052', StartDate, EndDate) +
            GetRawExpenseBalance('903053', StartDate, EndDate) +
            GetRawExpenseBalance('903054', StartDate, EndDate) +
            GetRawExpenseBalance('903055', StartDate, EndDate) +
            GetRawExpenseBalance('903056', StartDate, EndDate) +
            GetRawExpenseBalance('903057', StartDate, EndDate) +
            GetRawExpenseBalance('903058', StartDate, EndDate));
    end;

    local procedure GetPayrollExpensesTotal(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetRawExpenseBalance('904020', StartDate, EndDate) +
            GetRawExpenseBalance('904026', StartDate, EndDate) +
            GetRawExpenseBalance('904030', StartDate, EndDate) +
            GetRawExpenseBalance('904040', StartDate, EndDate) +
            GetRawExpenseBalance('904050', StartDate, EndDate) +

            GetRawExpenseBalance('904070', StartDate, EndDate) +
            GetRawExpenseBalance('904080', StartDate, EndDate) +

            GetRawExpenseBalance('904100', StartDate, EndDate) +
            GetRawExpenseBalance('904110', StartDate, EndDate) +
            GetRawExpenseBalance('904111', StartDate, EndDate) +
            GetRawExpenseBalance('904112', StartDate, EndDate) +
            GetRawExpenseBalance('904113', StartDate, EndDate));
    end;

    local procedure GetTotalExpenses(StartDate: Date; EndDate: Date): Decimal
    begin
        exit(
            GetAdministrativeExpensesTotal(StartDate, EndDate) +
            GetMarketingExpensesTotal(StartDate, EndDate) +
            GetFinancialExpensesTotal(StartDate, EndDate) +
             GetGovernanceExpensesTotal(StartDate, EndDate) +
            // GetExpenseBalance('902140', StartDate, EndDate) +
            GetPayrollExpensesTotal(StartDate, EndDate));
    end;
}