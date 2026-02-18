report 80001 "PayrollSummary"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/PayrollSummaryReportVerUpdated.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions."; "prPeriod Transactions.")
        {
            RequestFilterFields = "Payroll Period";
            column(Employee_Code; "Employee Code")
            {

            }
            column(Transaction_Code; "Transaction Code") { }
            column(Transaction_Name; "Transaction Name") { }
            column(Amount; Amount) { }
            column(EmployeeName; EmployeeName) { }

            dataitem("Payroll Employee."; "Payroll Employee.")
            {
                DataItemLink = "No." = field("Employee Code");
                column(No_; "No.") { }
                column(Firstname; Firstname) { }
            }
            trigger OnAfterGetRecord();
            var

            begin
                PayrollEmployee.Reset();

                PayrollEmployee.SetRange("No.", "Employee Code");
                if PayrollEmployee.Find('-') then begin
                    EmployeeName := PayrollEmployee."First Name" + ' ' + PayrollEmployee."Middle Name" + ' ' + PayrollEmployee."Last Name";
                end;
            end;



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
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        EmployeeName: text[2500];
        PayrollEmployee: record "HR Employees";

        cust: Record Customer;

}