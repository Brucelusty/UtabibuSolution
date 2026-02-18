report 80031 "Payroll Summary New"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Payroll Summary New.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions."; "prPeriod Transactions.")
        {
            DataItemTableView = WHERE("Transaction Code" = FILTER(<> 'E009'));
            RequestFilterFields = "Payroll Period";
            column(CompName; info.Name)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(Addr1; info.Address)
            {
            }
            column(Addr2; info."Address 2")
            {
            }
            column(Email; info."E-Mail")
            {
            }
            column(Year; Year)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(EmployeeCode_prPeriodTransactions; "prPeriod Transactions."."Employee Code")
            {
            }
            column(TransactionCode_prPeriodTransactions; "prPeriod Transactions."."Transaction Code")
            {
            }
            column(GroupText_prPeriodTransactions; "prPeriod Transactions."."Group Text")
            {
            }
            column(TransactionName_prPeriodTransactions; "prPeriod Transactions."."Transaction Name")
            {
            }
            column(Amount_prPeriodTransactions; "prPeriod Transactions.".Amount)
            {
            }
            column(Balance_prPeriodTransactions; "prPeriod Transactions.".Balance)
            {
            }
            column(OriginalAmount_prPeriodTransactions; "prPeriod Transactions."."Original Amount")
            {
            }
            column(GroupOrder_prPeriodTransactions; "prPeriod Transactions."."Group Order")
            {
            }
            column(SubGroupOrder_prPeriodTransactions; "prPeriod Transactions."."Sub Group Order")
            {
            }
            column(PeriodMonth_prPeriodTransactions; "prPeriod Transactions."."Period Month")
            {
            }
            column(PeriodYear_prPeriodTransactions; "prPeriod Transactions."."Period Year")
            {
            }
            column(PeriodFilter_prPeriodTransactions; "prPeriod Transactions."."Period Filter")
            {
            }
            column(PayrollPeriod_prPeriodTransactions; "prPeriod Transactions."."Payroll Period")
            {
            }
            column(Membership_prPeriodTransactions; "prPeriod Transactions.".Membership)
            {
            }
            column(ReferenceNo_prPeriodTransactions; "prPeriod Transactions."."Reference No")
            {
            }
            column(DepartmentCode_prPeriodTransactions; "prPeriod Transactions."."Department Code")
            {
            }
            column(Lumpsumitems_prPeriodTransactions; "prPeriod Transactions.".Lumpsumitems)
            {
            }
            column(TravelAllowance_prPeriodTransactions; "prPeriod Transactions.".TravelAllowance)
            {
            }
            column(GLAccount_prPeriodTransactions; "prPeriod Transactions."."GL Account")
            {
            }
            column(CompanyDeduction_prPeriodTransactions; "prPeriod Transactions."."Company Deduction")
            {
            }
            column(EmpAmount_prPeriodTransactions; "prPeriod Transactions."."Emp Amount")
            {
            }
            column(EmpBalance_prPeriodTransactions; "prPeriod Transactions."."Emp Balance")
            {
            }
            column(JournalAccountCode_prPeriodTransactions; "prPeriod Transactions."."Journal Account Code")
            {
            }
            column(JournalAccountType_prPeriodTransactions; "prPeriod Transactions."."Journal Account Type")
            {
            }
            column(PostAs_prPeriodTransactions; "prPeriod Transactions."."Post As")
            {
            }
            column(LoanNumber_prPeriodTransactions; "prPeriod Transactions."."Loan Number")
            {
            }
            column(coopparameters_prPeriodTransactions; "prPeriod Transactions."."coop parameters")
            {
            }
            column(PayrollCode_prPeriodTransactions; "prPeriod Transactions."."Payroll Code")
            {
            }
            column(PaymentMode_prPeriodTransactions; "prPeriod Transactions."."Payment Mode")
            {
            }
            column(FosaAccountNo_prPeriodTransactions; "prPeriod Transactions."."Fosa Account No.")
            {
            }
            column(employeeName; employeeName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if HREmployees.Get("prPeriod Transactions."."Employee Code") then
                    employeeName := HREmployees.Firstname + ' ' + HREmployees.Lastname + ' ' + HREmployees.Surname;

                if "prPeriod Transactions."."Group Order" = 6 then
                    CurrReport.Skip;
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", "Payroll Period");
                if PeriodTrans.Find('-') then begin
                    Year := PeriodTrans."Period Year";
                    PeriodName := FORMAT(PeriodTrans."Payroll Period", 0, '<Month Text,3> ');
                    //Message('%1', PeriodTrans."Payroll Period");
                    if PeriodTrans.Amount = 0 then
                        CurrReport.Skip;


                end;
                objPeriod.Reset;
                objPeriod.SetRange("Date Opened", "Payroll Period");
                if objPeriod.Find() then begin
                    //Message('%1', objPeriod."Date Opened");
                    PeriodName := objPeriod."Period Name";
                end;
                if PeriodTrans."Transaction Code" = 'E009' then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                if UserSetup.Get(UserId) then begin
                    if UserSetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
                end else begin
                    Error('You have been setup in the user setup!');
                end;

                SelectedPeriod := PeriodFilter;
                objPeriod.Reset;
                if objPeriod.Get(SelectedPeriod) then
                    PeriodName := objPeriod."Period Name";

                info.Get;
                info.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        HREmployees: Record "Payroll Employee.";
        employeeName: Text;
        info: Record "Company Information";
        CompName: Text[50];
        Addr1: Text[50];
        Addr2: Text[50];
        Email: Text[50];
        UserSetup: Record "User Setup";
        SelectedPeriod: Date;
        objPeriod: Record "Payroll Calender.";
        PeriodFilter: Date;
        PeriodName: Text;
        PeriodTrans: Record "prPeriod Transactions.";
        Year: Integer;
}

