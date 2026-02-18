report 80034 "Loans Reprt customized"

{
    RDLCLayout = 'Layouts/LoansreportCustomized.rdlc';
    DefaultLayout = RDLC;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance", "Interest Paid", "Principal Paid", "Scheduled Principal to Date", "Schedule Interest to Date";
            DataItemTableView = sorting("Loan  No.") order(ascending);// | 'OVERDUE-INSTANT' | 'DIVIDEND'));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Loan  No.", Source, "Loan Product Type", "Date filter", "Application Date", "Loan Status", "Issued Date", Posted, "Batch No.", "Captured By", "Branch Code", "Outstanding Balance", "Date Approved", "Employer Code", Closed;
            column(No_of_Months_in_Arrears; "No of Months in Arrears")
            {

            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            // column(CurrReport_PAGENO; CurrReport.PageNo())															
            // {															
            // }															
            column(UserId; UserId)
            {
            }
            column(LoanType; LoanType)
            {
            }
            column(LoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
            {
            }
            column(RFilters; RFilters)
            {
            }
            column(Loans__Loan__No__; "Loans Register"."Loan  No.")
            {
            }
            column(Loans__Client_Code_; "Loans Register"."Client Code")
            {
            }
            column(Loans__Client_Name_; "Loans Register"."Client Name")
            {
            }
            column(Employer_Code; LAppl."Employer Code")
            {
            }
            column(InterestDue; InterestDue)
            {
            }
            column(LoanArrears; LoanArrears)
            {
            }
            column(Staff_No; LAppl."Staff No")
            {
            }
            column(Loans__Requested_Amount_; "Loans Register"."Requested Amount")
            {
            }
            column(TotalsLoanOutstanding_Loans; "Loans Register"."Total loan Outstanding")
            {
            }
            column(Loans__Approved_Amount_; "Loans Register"."Approved Amount")
            {
            }
            column(Upfronts; "Loans Register".Upfronts)
            {
            }
            column(Repayment; Repayment) { }
            column(Cheque_No; LAppl."Cheque No.")
            {
            }
            column(Netdisbursed; Netdisbursed)
            {
            }
            column(CurrentShares_Loans; "Loans Register"."Current Shares")
            {
            }
            column(EmployerName_Loans; "Loans Register"."Employer Name")
            {
            }
            column(TotalUpfronts; TotalUpfronts)
            {
            }
            column(EmployerCode_Loans; "Loans Register"."Employer Code")
            {
            }
            column(TotalNetPay; TotalNetPay)
            {
            }
            column(Loans_Installments; "Loans Register".Installments)
            {
            }
            column(InterestPaid_LoansRegister; "Loans Register"."Interest Paid")
            {
            }
            column(Interestcharged_loansRegister; "Loans Register"."Interest Charged")
            {

            }

            column(Interest_Charged; "Interest Charged")
            {

            }
            column(Penalty_Charged; "Penalty Charged")
            {

            }
            column(Current_Penalty_Due; "Current Penalty Due")
            {

            }
            column(DateApproved_Loans; Format("Loans Register"."Date Approved"))
            {
            }
            column(Loan_Disbursed_Amount; "Loans Register"."Loan Disbursed Amount")
            {

            }
            column(Loans__Loan_Status_; "Loans Register"."Loan Status")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; "Loans Register"."Outstanding Balance")
            {
            }
            column(Loans__Application_Date_; "Loans Register"."Application Date")
            {
            }
            column(Loans__Issued_Date_; "Loans Register"."Issued Date")
            {
            }
            column(Amount_to_Disburse_on_Trunch_1; "Amount to Disburse on Trunch 1")
            {

            }
            column(No_of_Tranch_Disbursment; "No of Tranch Disbursment")
            {

            }
            column(Tranch_Amount_Disbursed; "Tranch Amount Disbursed")
            {

            }

            column(Loans__Oustanding_Interest_; "Loans Register"."Outstanding Interest")
            {
            }
            column(Loans_Loans__Loan_Product_Type_; "Loans Register"."Loan Product Type")
            {
            }
            column(Loans__Last_Pay_Date_; "Loans Register"."Last Pay Date")
            {
            }
            column(Loans__Top_Up_Amount_; "Loans Register"."Loan Offset Amount")
            {
            }
            column(Loans__Approved_Amount__Control1102760017; "Loans Register"."Approved Amount")
            {
            }
            column(Loans__Requested_Amount__Control1102760038; "Loans Register"."Requested Amount")
            {
            }
            column(LCount; LCount)
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1102760040; "Loans Register"."Outstanding Balance")
            {
            }
            column(Loans__Oustanding_Interest__Control1102760041; "Loans Register"."Outstanding Interest")
            {
            }
            column(TopUp_Commission; LAppl."Total Offset Commission")
            {
            }
            column(Bridge_Amount_Release; "Bridge Amount Release")
            {

            }
            column(Loan_Offset_Amount; "Loan Offset Amount")
            {

            }
            column(Loan_Principal_Offset; "Loan Principal Offset")
            {

            }
            column(Current_Principle_Due; "Current Principle Due") { }

            column(Offset_iNTEREST; "Offset iNTEREST")
            {

            }
            column(Offset_Commission; "Offset Commission") { }
            column(Loans__Top_Up_Amount__Control1000000001; "Loans Register"."Loan Offset Amount")
            {
            }
            column(Loans_RegisterCaption; Loans_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Client_No_Caption; Client_No_CaptionLbl)
            {
            }
            column(Comment; Comment)
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Loans__Requested_Amount_Caption; FieldCaption("Requested Amount"))
            {
            }
            column(Loans__Approved_Amount_Caption; FieldCaption("Approved Amount"))
            {
            }
            column(Loans__Loan_Status_Caption; FieldCaption("Loan Status"))
            {
            }
            column(Outstanding_LoanCaption; Outstanding_LoanCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(Expected_Date_of_Completion; "Expected Date of Completion")
            {

            }
            column(Repayment_Frequency; "Repayment Frequency")
            {

            }
            column(Repayment_Method; "Repayment Method")
            {

            }
            column(LoanTotalRepay; LoanTotalRepay) { }

            column(Loans__Application_Date_Caption; FieldCaption("Application Date"))
            {
            }
            column(Approved_DateCaption; Approved_DateCaptionLbl)
            {
            }
            column(Loans__Oustanding_Interest_Caption; FieldCaption("Outstanding Interest"))
            {
            }
            column(Loan_TypeCaption_Control1102760043; Loan_TypeCaption_Control1102760043Lbl)
            {
            }
            column(Loans__Last_Pay_Date_Caption; FieldCaption("Last Pay Date"))
            {
            }

            column(Loans__Top_Up_Amount_Caption; FieldCaption("Loan Offset Amount"))
            {
            }

            column(Verified_By__________________________________________________Caption; Verified_By__________________________________________________CaptionLbl)
            {
            }
            column(Confirmed_By__________________________________________________Caption; Confirmed_By__________________________________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption; Sign________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption_Control1102755003; Sign________________________Caption_Control1102755003Lbl)
            {
            }




            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Client Code");
                column(No_; "No.") { }//"Client Code"
                column(ID_No_; "ID No.") { }
                column(Date_Of_Birth; "Date Of Birth")
                {

                }
                column(Payroll_No; "Payroll No") { }
            }
            dataitem("Loan Offset Details"; "Loan Offset Details")
            {
                DataItemLink = "Loan No." = field("Loan  No.");
                DataItemTableView = where("Principle Top Up" = filter(> 0));
                column(ReportForNavId_4717; 4717)
                {
                }
                column(Loan_No_; "Loan No.")
                {

                }
                column(Client_Code; "Client Code")
                {

                }
                column(Monthly_Repayment; "Monthly Repayment") { }
                column(Loans_Top_up__Principle_Top_Up_; "Principle Top Up")
                {
                }
                column(Loans_Top_up__Loan_Type_; "Loan Type")
                {
                }
                column(Loans_Top_up__Client_Code_; "Client Code")
                {
                }
                column(Loans_Top_up__Loan_No__; "Loan No.")
                {
                }

                column(Loans_Top_up__Interest_Top_Up_; "Interest Top Up")
                {
                }
                column(Loan_Type; "Loan Offset Details"."Loan Type")
                {
                }


                trigger OnAfterGetRecord()
                begin

                    TotalTopUp := ROUND((TotalTopUp + "Principle Top Up"), 0.05, '>');
                    TotalIntPayable := TotalIntPayable + "Monthly Repayment";
                    GTotals := GTotals + ("Principle Top Up" + "Monthly Repayment");
                    if "Loans Register".Get("Loan Offset Details"."Loan No.") then begin
                        if LoanType2.Get("Loans Register"."Loan Product Type") then begin
                        end;
                    end;
                    //"Loan Offset Details".calcsums(Commision);
                    // LoanTopUp.Reset;
                    // LoanTopUp.SetRange(LoanTopUp."Loan No.", "Loans Register"."Loan  No.");
                    // LoanTopUp.SetRange(LoanTopUp."Client Code", "Loans Register"."Client Code");
                    // if LoanTopUp.Find('-') then begin
                    //     repeat
                    //     TopUpComm +=LoanTopUp.Commision;   
                    //     until LoanTopUp.Next = 0;
                    // end;



                    TOTALBRIDGED := TOTALBRIDGED + "Loan Offset Details"."Total Top Up";

                    if TOTALBRIDGED > Recomm then
                        WarnBridged := UpperCase('WARNING: Bridging Total is Higher than the Qualifing Amount.')
                    else
                        WarnBridged := '';
                end;

                trigger OnPreDataItem()
                begin
                    BrTopUpCom := 0;
                    TOTALBRIDGED := 0;
                end;
            }

            trigger OnPreDataItem();
            begin

                // CREATETOTALS("Net Repayment");															
                DateFilter := GetFilter("Loans Register"."Date filter");
                if LoanProdType.Get("Loans Register".GetFilter("Loans Register"."Loan Product Type")) then
                    LoanType := LoanProdType."Product Description";
                LCount := 0;
                if "Loans Register".GetFilter("Loans Register"."Branch Code") <> '' then begin
                    DValue.Reset;
                    DValue.SetRange(DValue."Global Dimension No.", 2);
                    DValue.SetRange(DValue.Code, "Loans Register".GetFilter("Loans Register"."Branch Code"));
                    if DValue.Find('-') then
                        RFilters := 'Branch: ' + DValue.Name;

                end;
            end;

            trigger OnAfterGetRecord();
            var
                AuFactory: Codeunit "Au Factory";
            begin
                //  AuFactory.FnGenerateLoanRepaymentSchedule("Loans Register"."Loan  No.");
                CompanyCode := '';
                if cust.Get("Loans Register"."BOSA No") then
                    CompanyCode := cust."Employer Code";
                LCount := LCount + 1;
                InterestDue := "Loans Register"."Schedule Interest to Date";//SFactory.FnGetInterestDueFiltered("Loans Register",DateFilter);															
                LoanArrears := "Loans Register"."Scheduled Principal to Date" - Abs("Loans Register"."Principal Paid");
                LoanTotalRepay := "Loans Register".Repayment * "Loans Register".Installments;
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
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            ////:= false;															
        end;
    }

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        ;
        // 															

    end;

    trigger OnPostReport()
    begin
        ;
        //															
    end;

    trigger OnPreReport()
    begin
        if "COMPY INFOR".Get then begin
            "COMPY INFOR".CalcFields("COMPY INFOR".Picture);
            Name := "COMPY INFOR".Name;
        end;
        ;
        // 															
    end;

    var
        RPeriod: Decimal;
        BatchL: Code[100];
        Batches: Record "Loan Disburesment-Batching";
        ApprovalSetup: Record "Tenant Permission";
        LocationFilter: Code[20];
        LoanType2: Record "Loan Products Setup";
        TotalApproved: Decimal;
        cust: Record Customer;
        BOSABal: Decimal;
        SuperBal: Decimal;
        LAppl: Record "Loans Register";
        Deposits: Decimal;
        CompanyCode: Code[20];
        LoanType: Text[50];
        LoanProdType: Record "Loan Products Setup";
        LCount: Integer;
        RFilters: Text[250];
        DValue: Record "Dimension Value";
        VALREPAY: Record "Member Ledger Entry";
        Loans_RegisterCaptionLbl: label 'Approved Loans Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................';
        Sign________________________CaptionLbl: label 'Sign...............';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign...............';
        Date________________________CaptionLbl: label 'Date..............';
        Date________________________Caption_Control1102755005Lbl: label 'Date..............';
        GenSetUp: Record "Sacco General Set-Up";
        LoanApp: Record "Loans Register";
        CustRec: Record Customer;
        CustRecord: Record Customer;
        TShares: Decimal;
        TLoans: Decimal;
        LoanShareRatio: Decimal;
        Eligibility: Decimal;
        TotalSec: Decimal;
        saccded: Decimal;
        saccded2: Decimal;
        grosspay: Decimal;
        Tdeduct: Decimal;
        Cshares: Decimal;
        "Cshares*3": Decimal;
        "Cshares*4": Decimal;
        QUALIFY_SHARES: Decimal;
        salary: Decimal;
        LoanG: Record "Loans Guarantee Details";
        GShares: Decimal;
        Recomm: Decimal;
        LoanTotalRepay: Decimal;
        GShares1: Decimal;
        NETTAKEHOME: Decimal;
        Msalary: Decimal;
        RecPeriod: Integer;
        FOSARecomm: Decimal;
        FOSARecoPRD: Integer;
        "Asset Value": Decimal;
        InterestRate: Decimal;
        RepayPeriod: Decimal;
        LBalance: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        SecuredSal: Decimal;
        Linterest1: Integer;
        LOANBALANCE: Decimal;
        BRIDGEDLOANS: Record "Loan Offset Details";
        BRIDGEBAL: Decimal;
        LOANBALANCEFOSASEC: Decimal;
        TotalTopUp: Decimal;
        TotalIntPayable: Decimal;
        GTotals: Decimal;
        TempVal: Decimal;
        TempVal2: Decimal;
        "TempCshares*4": Decimal;
        "TempCshares*3": Decimal;
        InstallP: Decimal;
        RecomRemark: Text[150];
        InstallRecom: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        LoanTopUp: Record "Loan Offset Details";
        "Interest Payable": Decimal;
        "general set-up": Record "Sacco General Set-Up";
        Days: Integer;
        EndMonthInt: Decimal;
        BRIDGEBAL2: Decimal;
        DefaultInfo: Text[80];
        TOTALBRIDGED: Decimal;
        DEpMultiplier: Decimal;
        MAXAvailable: Decimal;
        SalDetails: Record "Loan Appraisal Salary Details";
        Earnings: Decimal;
        Deductions: Decimal;
        BrTopUpCom: Decimal;
        LoanAmount: Decimal;
        Company: Record "Company Information";
        CompanyAddress: Code[20];
        CompanyEmail: Text[30];
        CompanyTel: Code[20];
        CurrentAsset: Decimal;
        CurrentLiability: Decimal;
        FixedAsset: Decimal;
        Equity: Decimal;
        Sales: Decimal;
        SalesOnCredit: Decimal;
        AppraiseDeposits: Boolean;
        AppraiseShares: Boolean;
        AppraiseSalary: Boolean;
        AppraiseGuarantors: Boolean;
        AppraiseBusiness: Boolean;
        TLoan: Decimal;
        LoanBal: Decimal;
        GuaranteedAmount: Decimal;
        RunBal: Decimal;
        TGuaranteedAmount: Decimal;
        GuarantorQualification: Boolean;
        TotalLoanBalance: Decimal;
        TGAmount: Decimal;
        NetSalary: Decimal;
        Riskamount: Decimal;
        WarnBridged: Text;
        WarnSalary: Text;
        WarnDeposits: Text;
        WarnGuarantor: Text;
        WarnShare: Text;
        RiskGshares: Decimal;
        RiskDeposits: Decimal;
        BasicEarnings: Decimal;
        DepX: Decimal;
        LoanPrincipal: Decimal;
        loanInterest: Decimal;
        AmountGuaranteed: Decimal;
        StatDeductions: Decimal;
        GuarOutstanding: Decimal;
        TwoThirds: Decimal;
        Bridged_AmountCaption: Integer;
        LNumber: Code[20];
        TotalLoanDeductions: Decimal;
        TotalRepayments: Decimal;
        Totalinterest: Decimal;
        Band: Decimal;
        TotalOutstanding: Decimal;
        BANDING: Record "Deposit Tier Setup";
        NtTakeHome: Decimal;
        ATHIRD: Decimal;
        Psalary: Decimal;
        LoanApss: Record "Loans Register";
        TotalLoanBal: Decimal;
        TotalBand: Decimal;
        LoanAp: Record "Loans Register";
        TotalRepay: Decimal;
        TotalInt: Decimal;
        LastFieldNo: Integer;
        TotLoans: Decimal;
        JazaLevy: Decimal;
        BridgeLevy: Decimal;
        Upfronts: Decimal;
        Netdisbursed: Decimal;
        TotalLRepayments: Decimal;
        BridgedRepayment: Decimal;
        OutstandingLrepay: Decimal;
        Loantop: Record "Loan Offset Details";
        BRIGEDAMOUNT: Decimal;
        TOTALBRIGEDAMOUNT: Decimal;
        FinalInst: Decimal;
        NonRec: Decimal;
        OffsetLoanType: Text[100];
        LastLoanNo: Code[20];
        TotalUpfronts: Decimal;
        TotalNetPay: Decimal;
        NameCreditOff: label 'Name.......................';
        NameCreditDate: label 'Date........................';
        NameCreditSign: label 'Signature..................';
        NameCreditMNG: label 'Name.......................';
        NameCreditMNGDate: label 'Date........................';
        NameCreditMNGSign: label 'Signature..................';
        NameCEO: label 'Name......................';
        NameCEOSign: label 'Signature.................';
        NameCEODate: label 'Date.......................';
        CreditCom1: label 'Name......................';
        CreditCom1Sign: label 'Signature.................';
        CreditCom1Date: label 'Date.......................';
        CreditCom2: label 'Name......................';
        CreditCom2Sign: label 'Signature.................';
        CreditCom2Date: label 'Date......................';
        CreditCom3: label 'Name.....................';
        CreditComDate3: label 'Date......................';
        CreditComSign3: label 'Signature.................';
        Comment: label '....................';
        "COMPY INFOR": Record "Company Information";
        Name: Text;
        PICTURE: Text;
        InterestDue: Decimal;
        SFactory: Codeunit "Au Factory";
        DateFilter: Text;
        PrincipalDue: Decimal;
        LoanArrears: Decimal;



}



