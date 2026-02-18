page 80028 "Employee Payslip View"
{
    ApplicationArea = All;
    Caption = 'Employee Payslip View';
    DeleteAllowed = true;
    InsertAllowed = true;
    PageType = List;
    UsageCategory = Lists;
    RefreshOnActivate = true;
    SourceTable = "Payroll Employee.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff  No.';
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sacco Membership No.';
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic;
                }
                field(Firstname; Rec.Firstname)
                {
                    ApplicationArea = Basic;
                }
                field(Lastname; Rec.Lastname)
                {
                    ApplicationArea = Basic;
                }

            }
        }
        area(factboxes)
        {
            systempart(Control9; Outlook)
            {
            }
            systempart(Control10; Notes)
            {
            }
            systempart(Control11; MyNotes)
            {
            }
            systempart(Control12; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {



            action("View PaySlip")
            {
                ApplicationArea = Basic;
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp."No.", Rec."No.");
                    if PayrollEmp.FindFirst then begin
                        Report.Run(80013, true, false, PayrollEmp);
                    end;
                end;
            }
            action("View P9")
            {
                ApplicationArea = Basic;
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp."No.", Rec."No.");
                    if PayrollEmp.FindFirst then begin
                        Report.Run(Report::P9Report, true, false, PayrollEmp);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ExitReasonVisible := false;
        BonusAmountVisible := false;
        if Rec."Exit Staff" = true then begin
            ExitReasonVisible := true;
        end;

        if Rec."Pay Bonus" = true then
            BonusAmountVisible := true;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("EmployeeUseriD", UserId);
        Rec.FilterGroup(0);
    end;

    trigger OnInit()
    begin


    end;

    trigger OnOpenPage()
    begin
        ExitReasonVisible := false;
        BonusAmountVisible := false;
        if Rec."Exit Staff" = true then begin
            ExitReasonVisible := true;
        end;

        if Rec."Pay Bonus" = true then
            BonusAmountVisible := true;

        Rec.FilterGroup(2);
        Rec.SetRange("EmployeeUseriD", UserId);
        Rec.FilterGroup(0);
    end;

    var
        Usersetup: Record "User Setup";
        ObjPayrollEmployeeTrans: Record "Payroll Employee Transactions.";
        SFactory: Codeunit "Au Factory";
        ObjPayrollCalender: Record "Payroll Calender.";
        VarOpenPeriod: Date;
        ObjLoans: Record "Loans Register";
        ObjPayrollEmployeeTransII: Record "Payroll Employee Transactions.";
        ObjTransactionCodes: Record "Payroll Transaction Code.";
        ObjPayrollEmployeeTransIII: Record "Payroll Employee Transactions.";
        ObjTransactionCodesII: Record "Payroll Transaction Code.";
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule Buffer";
        VarAmortizationAmount: Decimal;
        ObjPayrollEmployees: Record "Payroll Employee.";
        ProgressWindow: Dialog;
        ObjEmployeeTransactions: Record "Payroll Employee Transactions.";
        ExitReasonVisible: Boolean;
        PayrollEmp: Record "Payroll Employee.";
        //PayrollManager: Codeunit "Payroll Management";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender.";
        PayrollMonthlyTrans: Record "Payroll Monthly Transactions.";
        PayrollEmployeeDed: Record "Payroll Employee Deductions.";
        PayrollEmployerDed: Record "Payroll Employer Deductions.";
        objEmp: Record "Salary Processing Header";
        SalCard: Record "Payroll Employee.";
        objPeriod: Record "Payroll Calender.";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit "AU Payroll Processing";
        HrEmployee: Record "Payroll Employee.";
        prPeriodTransactions: Record "prPeriod Transactions..";
        prEmployerDeductions: Record "Payroll Employer Deductions.";
        PayrollType: Record "Payroll Type.";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information.";
        ObjPayrollTransactions: Record "prPeriod Transactions.";
        ObjPayrollTransactionsII: Record "prPeriod Transactions.";
        varPeriodMonth: Integer;
        BonusAmountVisible: Boolean;
        VarLoanDueAmount: Decimal;
        ObjPayrollEmployeesIV: Record "Payroll Employee.";
        VarPeriodYear: Integer;
        VarMonthlyDepositsContribution: Decimal;
        ObjCust: Record "Members Register";
        ObjLoansII: Record "Loans Register";
        VarMonthlyInstalments: Decimal;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarDateFilter: Text;
        VarEndMonthDate: Date;

    local procedure FnRunUpdateNewMemberLoans(VarMemberNo: Code[30]; VarPayollNo: Code[30])
    var
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;


        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);

        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjTransactionCodesII.Reset;
                ObjTransactionCodesII.SetRange(ObjTransactionCodesII."Loan Product", ObjLoans."Loan Product Type");
                if ObjTransactionCodesII.Find('-') = false then begin
                    FnRunCreateLoanProductinTransactionCodes(ObjLoans."Loan Product Type", ObjLoans.Interest, ObjLoans."Loan Product Type Name");//=================Create New Transaction Code
                end;

                if ObjLoans."Exempt From Payroll Deduction" = false then //***Insert New Loan to Payroll Deduction***
                begin
                    ObjPayrollEmployeeTrans.Reset;
                    ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
                    ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Loan Number", ObjLoans."Loan  No.");
                    ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
                    if not ObjPayrollEmployeeTrans.FindSet then begin
                        ObjTransactionCodes.Reset;
                        ObjTransactionCodes.SetRange(ObjTransactionCodes."Loan Product", ObjLoans."Loan Product Type");
                        if ObjTransactionCodes.Find('-') then begin
                            ObjPayrollEmployeeTrans.Init;
                            ObjPayrollEmployeeTrans."Sacco Membership No." := ObjLoans."Client Code";
                            ObjPayrollEmployeeTrans."No." := VarPayollNo;
                            ObjPayrollEmployeeTrans."Loan Number" := ObjLoans."Loan  No.";
                            ObjPayrollEmployeeTrans."Transaction Code" := ObjTransactionCodes."Transaction Code";
                            ObjPayrollEmployeeTrans."Transaction Name" := ObjTransactionCodes."Transaction Name";
                            ObjPayrollEmployeeTrans."Transaction Type" := ObjTransactionCodes."Transaction Type";
                            ObjPayrollEmployeeTrans."Payroll Period" := VarOpenPeriod;
                            ObjPayrollEmployeeTrans."Period Month" := VarPeriodMonth;
                            ObjPayrollEmployeeTrans."Period Year" := VarPeriodYear;
                            ObjPayrollEmployeeTrans.Balance := ObjLoans."Outstanding Balance";
                            ObjPayrollEmployeeTrans."Balance(LCY)" := ObjLoans."Outstanding Balance";
                            ObjPayrollEmployeeTrans."Amtzd Loan Repay Amt" := VarAmortizationAmount;
                            ObjPayrollEmployeeTrans.Insert;
                        end;
                    end;
                end;
                if ObjLoans."Exempt From Payroll Deduction" = true then //***Delete Loans Exempted from Payroll****
                begin
                    ObjPayrollEmployeeTrans.Reset;
                    ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
                    ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Loan Number", ObjLoans."Loan  No.");
                    ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
                    if ObjPayrollEmployeeTrans.FindSet = false then begin
                        ObjPayrollEmployeeTrans.Delete;
                    end
                end;
            until ObjLoans.Next = 0;
        end;




        VarLoanDueAmount := 0;
        ObjPayrollEmployeeTrans.Reset;
        ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Loan Number", '<>%1', '');
        if ObjPayrollEmployeeTrans.FindSet then begin
            repeat
                VarLoanDueAmount := 0;
                VarMonthlyInstalments := 0;

                VarLoanDueAmount := SFactory.FnRunLoanAmountDuePayroll(ObjPayrollEmployeeTrans."Loan Number");

                //===========================================================================================Get Monthly Instalment
                VarDateFilter := Format(VarOpenPeriod) + '..' + Format(CalcDate('CM', VarOpenPeriod));
                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", ObjPayrollEmployeeTrans."Loan Number");
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", VarDateFilter);
                if ObjLoanSchedule.FindSet then begin
                    VarMonthlyInstalments := ObjLoanSchedule."Monthly Repayment";
                end;


                if ObjLoans.Get(ObjPayrollEmployeeTrans."Loan Number") then begin

                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");


                    if (VarLoanDueAmount < VarMonthlyInstalments) and (ObjLoans."Outstanding Balance" > VarMonthlyInstalments) then
                        VarLoanDueAmount := VarMonthlyInstalments;

                    ObjPayrollEmployeeTrans.Amount := VarLoanDueAmount;//SFactory.FnRunLoanAmountDuePayroll(ObjPayrollEmployeeTrans."Loan Number");
                    ObjPayrollEmployeeTrans.Balance := ObjLoans."Outstanding Balance";
                    ObjPayrollEmployeeTrans.Modify;
                end;
            until ObjPayrollEmployeeTrans.Next = 0;
        end;


        //=============================================================Delete Cleared Loans
        ObjPayrollEmployeeTrans.Reset;
        ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Loan Number", '<>%1', '');
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans.Balance, '<%1', 1);
        if ObjPayrollEmployeeTrans.FindSet then begin
            ObjPayrollEmployeeTrans.DeleteAll;
        end;

        //=============================================================Delete Non Due Loans
        ObjPayrollEmployeeTrans.Reset;
        ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Loan Number", '<>%1', '');
        ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans.Amount, '%1', 0);
        if ObjPayrollEmployeeTrans.FindSet then begin
            ObjPayrollEmployeeTrans.DeleteAll;
        end;
    end;

    local procedure FnRunCreateLoanProductinTransactionCodes(VarLoanType: Text[100]; VarInterestRate: Decimal; VarLoanProductName: Text[100])
    var
        VarTransactionCode: Code[30];
    begin
        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetCurrentkey(ObjTransactionCodes."Transaction Code");
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Type", ObjTransactionCodes."transaction type"::Deduction);
        if ObjTransactionCodes.FindLast then begin
            VarTransactionCode := IncStr(ObjTransactionCodes."Transaction Code");
        end;

        ObjTransactionCodes.Init;
        ObjTransactionCodes."Transaction Code" := VarTransactionCode;
        ObjTransactionCodes."Transaction Name" := VarLoanProductName;
        ObjTransactionCodes."Transaction Type" := ObjTransactionCodes."transaction type"::Deduction;
        ObjTransactionCodes."Balance Type" := ObjTransactionCodes."balance type"::Reducing;
        ObjTransactionCodes.Frequency := ObjTransactionCodes.Frequency::Fixed;
        ObjTransactionCodes."Special Transaction" := ObjTransactionCodes."special transaction"::"Staff Loan";
        ObjTransactionCodes."Interest Rate" := VarInterestRate;
        ObjTransactionCodes."Repayment Method" := ObjTransactionCodes."repayment method"::Amortized;
        ObjTransactionCodes."Customer Posting Group" := 'MEMBER';
        ObjTransactionCodes.SubLedger := ObjTransactionCodes.SubLedger;
        ObjTransactionCodes."Loan Product" := VarLoanType;
        ObjTransactionCodes."Loan Product Name" := VarLoanProductName;
        ObjTransactionCodes.Insert;
    end;

    local procedure FnRunInsertMonthlyDepositContribution(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record "Members Register";
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        VarMonthlyDepositsContribution: Decimal;
    begin
        VarMonthlyDepositsContribution := 0;

        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;






        VarMonthlyDepositsContribution := SFactory.FnGetMemberMonthlyContributionDepositstier(VarMemberNo);
        if ObjPayrollEmployeesIV."Voluntary Deposit Contribution" > VarMonthlyDepositsContribution then begin
            VarMonthlyDepositsContribution := ObjPayrollEmployeesIV."Voluntary Deposit Contribution"
        end;



        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Co-Op Parameters", ObjTransactionCodes."co-op parameters"::Shares);
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(ObjPayrollEmployeesIV."Payroll No") then begin
                ObjCust.CalcFields(ObjCust."Current Shares");


                //============================================Delete Entries For the Same Period
                ObjEmployeeTransactions.Reset;
                ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Payroll Period", VarOpenPeriod);
                ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Transaction Code", ObjTransactionCodes."Transaction Code");
                if ObjEmployeeTransactions.FindSet then begin
                    ObjEmployeeTransactions.DeleteAll;
                end;
                //============================================Delete Entries For the Same Period

                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := ObjPayrollEmployeesIV."Payroll No";
                ObjPayrollEmployeeTransII."No." := ObjPayrollEmployeesIV."No.";
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarMonthlyDepositsContribution;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarMonthlyDepositsContribution;
                ObjPayrollEmployeeTransII.Balance := ObjCust."Current Shares";
                ObjPayrollEmployeeTransII."Balance(LCY)" := ObjCust."Current Shares";
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;





    end;
}





