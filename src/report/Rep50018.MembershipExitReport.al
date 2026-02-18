report 50018 "Membership Exit Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Membership Withdrawal Report.rdlc';

    dataset
    {
        dataitem("Membership Exit";"Membership Exist")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.","Member No.","Closing Date",Status,"Closure Type";
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;CompanyName)
            {
            }
            column(Company_Name;Company.Name)
            {
            }
            column(Company_Address;Company.Address)
            {
            }
            column(Company_Address_2;Company."Address 2")
            {
            }
            column(Company_Phone_No;Company."Phone No.")
            {
            }
            column(Company_Fax_No;Company."Fax No.")
            {
            }
            column(Company_Picture;Company.Picture)
            {
            }
            column(Company_Email;Company."E-Mail")
            {
            }
          
            column(USERID;UserId)
            {
            }
            column(EntryNo;EntryNo)
            {
            }
            column(No_MembershipWithdrawals;"Membership Exit"."No.")
            {
            }
            column(MemberNo_MembershipWithdrawals;"Membership Exit"."Member No.")
            {
            }
            column(MemberName_MembershipWithdrawals;"Membership Exit"."Member Name")
            {
            }
            column(ClosingDate_MembershipWithdrawals;Format("Membership Exit"."Closing Date"))
            {
            }
            column(Status_MembershipWithdrawals;"Membership Exit".Status)
            {
            }
            column(Posted_MembershipWithdrawals;"Membership Exit".Posted)
            {
            }
            column(TotalLoan_MembershipWithdrawals;"Membership Exit"."Total Loan")
            {
            }
            column(TotalInterest_MembershipWithdrawals;"Membership Exit"."Total Interest")
            {
            }
            column(MemberDeposits_MembershipWithdrawals;"Membership Exit"."Member Deposits")
            {
            }
            column(NoSeries_MembershipWithdrawals;"Membership Exit"."No. Series")
            {
            }
            column(ClosureType_MembershipWithdrawals;"Membership Exit"."Closure Type")
            {
            }
            column(ModeOfDisbursement_MembershipWithdrawals;"Membership Exit"."Mode Of Disbursement")
            {
            }
            column(PayingBank_MembershipWithdrawals;"Membership Exit"."Paying Bank")
            {
            }
            column(ChequeNo_MembershipWithdrawals;"Membership Exit"."Cheque No.")
            {
            }
            column(FOSAAccountNo_MembershipWithdrawals;"Membership Exit"."FOSA Account No.")
            {
            }
            column(Payee_MembershipWithdrawals;"Membership Exit".Payee)
            {
            }
            column(NetPay_MembershipWithdrawals;"Membership Exit"."Net Pay")
            {
            }
            column(RiskFund_MembershipWithdrawals;"Membership Exit"."Risk Fund")
            {
            }
            column(RiskBeneficiary_MembershipWithdrawals;"Membership Exit"."Risk Beneficiary")
            {
            }
            column(RiskRefundable_MembershipWithdrawals;"Membership Exit"."Risk Refundable")
            {
            }
            column(TotalAdds_MembershipWithdrawals;"Membership Exit"."Total Adds")
            {
            }
            column(TotalLesses_MembershipWithdrawals;"Membership Exit"."Total Lesses")
            {
            }
            column(UnpaidDividends_MembershipWithdrawals;"Membership Exit"."Unpaid Dividends")
            {
            }
            column(TotalLoansFOSA_MembershipWithdrawals;"Membership Exit"."Total Loans FOSA")
            {
            }
            column(TotalOustandingIntFOSA_MembershipWithdrawals;"Membership Exit"."Total Oustanding Int FOSA")
            {
            }
            column(NetPayabletotheMember_MembershipWithdrawals;"Membership Exit"."Net Payable to the Member")
            {
            }
            column(RiskFundArrears_MembershipWithdrawals;"Membership Exit"."Risk Fund Arrears")
            {
            }

            trigger OnAfterGetRecord()
            begin
                EntryNo:=EntryNo+1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
                Company.Get();
                Company.CalcFields(Company.Picture);
    end;

    trigger OnPreReport()
    begin
                if "COMPY INFOR".Get then
                begin
        "COMPY INFOR".CalcFields("COMPY INFOR".Picture);
                NAME:="COMPY INFOR".Name;
                end;
    end;

    var
        RPeriod: Decimal;
        BatchL: Code[100];
        Batches: Record "Loan Disburesment-Batching";
      
        LocationFilter: Code[20];
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
        Loans_RegisterCaptionLbl: Label 'Approved Loans Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Loan_TypeCaptionLbl: Label 'Loan Type';
        Client_No_CaptionLbl: Label 'Client No.';
        Outstanding_LoanCaptionLbl: Label 'Outstanding Loan';
        PeriodCaptionLbl: Label 'Period';
        Approved_DateCaptionLbl: Label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: Label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: Label 'Verified By..................';
        Confirmed_By__________________________________________________CaptionLbl: Label 'Confirmed By..................';
        Sign________________________CaptionLbl: Label 'Sign...............';
        Sign________________________Caption_Control1102755003Lbl: Label 'Sign...............';
        Date________________________CaptionLbl: Label 'Date..............';
        Date________________________Caption_Control1102755005Lbl: Label 'Date..............';
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
        TotalUpfronts: Decimal;
        TotalNetPay: Decimal;
        NameCreditOff: Label 'Name.......................';
        NameCreditDate: Label 'Date........................';
        NameCreditSign: Label 'Signature..................';
        NameCreditMNG: Label 'Name.......................';
        NameCreditMNGDate: Label 'Date........................';
        NameCreditMNGSign: Label 'Signature..................';
        NameCEO: Label 'Name......................';
        NameCEOSign: Label 'Signature.................';
        NameCEODate: Label 'Date.......................';
        CreditCom1: Label 'Name......................';
        CreditCom1Sign: Label 'Signature.................';
        CreditCom1Date: Label 'Date.......................';
        CreditCom2: Label 'Name......................';
        CreditCom2Sign: Label 'Signature.................';
        CreditCom2Date: Label 'Date......................';
        CreditCom3: Label 'Name.....................';
        CreditComDate3: Label 'Date......................';
        CreditComSign3: Label 'Signature.................';
        Comment: Label '....................';
        "COMPY INFOR": Record "Company Information";
        NAME: Text;
        PICTURE: Text;
        EntryNo: Integer;
        PrevousMobileNo: Code[20];
}

