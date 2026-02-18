report 50050 "HrLeave statement"
{
    Caption = 'HrLeave statement';
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/HR Leave Statement.rdlc';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            RequestFilterFields = "No."//,Field2038
            ;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; "HR Employees"."User ID")
            {
            }

            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(HR_Employees__No__; "No.")
            {
            }
            column(HR_Employees__FullName; "HR Employees"."First Name" + ' ' + "HR Employees"."Middle Name")
            {
            }
            column(HR_Employees__HR_Employees___Leave_Balance_; "HR Employees"."Leave Balance")
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Leave_StatementCaption; Employee_Leave_StatementCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employees__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Leave_BalanceCaption; Leave_BalanceCaptionLbl)
            {
            }
            column(Day_s_Caption; Day_s_CaptionLbl)
            {
            }
            column(No; No)
            {
            }
            column(Employee_No; "HR Employees"."No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Total__Leave_Days_; "Total (Leave Days)") { }

            dataitem("HR Leave Ledger Entries"; "HR Leave Ledger Entries")
            {
                DataItemLink = "Staff No." = FIELD("No.");
                DataItemTableView = WHERE("Leave Type" = CONST('ANNUAL'));
                column(HR_Leave_Ledger_Entries__Leave_Period_; "Leave Period")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_; "Leave Entry Type")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_; "Leave Type")
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_; "No. of days")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_; "Leave Posting Description")
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_; "Posting Date")
                {
                }
                column(HR_Leave_Ledger_Entries__Startingdate; "Leave Start Date")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_Caption; FIELDCAPTION("Leave Entry Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_Caption; FIELDCAPTION("Leave Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_Caption; FIELDCAPTION("No. of days"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_Caption; FIELDCAPTION("Leave Posting Description"))
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
                {
                }

                column(HR_Leave_Ledger_Entries__Leave_Period_Caption; FIELDCAPTION("Leave Period"))
                {
                }
                column(HR_Leave_Ledger_Entries_Entry_No_; "Entry No.")
                {
                }
                column(HR_Leave_Ledger_Entries_Staff_No_; "Staff No.")
                {
                }
                column(LeaveRunningBalance; LeaveRunningBalance) { }
                column(LeaveDaysBeforeApplication; LeaveDaysBeforeApplication) { }
                column(LeaveDaysAfterApplication; LeaveDaysAfterApplication) { }
                column(HR_Leave_Application__Application_Date; ApplicationDate) { }

                dataitem("HR Leave Application"; "HR Leave Application")
                {
                    DataItemLink = "Employee No" = FIELD("Staff No."), "Application Code" = field("Document No.");
                    DataItemTableView = WHERE("Leave Type" = CONST('ANNUAL'));

                    column(Application_Date; "Application Date") { }
                    column(Start_Date; "Start Date") { }
                    column(Return_Date; "Return Date") { }
                    column(End_Date; "End Date") { }

                    trigger OnAfterGetRecord()
                    begin
                        No := No + 1;
                        if "HR Leave Ledger Entries"."Leave Entry Type" = "HR Leave Ledger Entries"."Leave Entry Type"::Positive then
                            ApplicationDate := "HR Leave Ledger Entries"."Posting Date"
                        else
                            ApplicationDate := "Application Date";
                    end;
                }


                trigger OnPreDataItem()
                begin
                    // Initialize the running balance for each employee
                    LeaveRunningBalance := 0;
                    LeaveDaysBeforeApplication := 0;
                    LeaveDaysAfterApplication := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    No := No + 1;


                    LeaveDaysBeforeApplication := LeaveRunningBalance;
                    LeaveRunningBalance := LeaveRunningBalance + "No. of days";
                    LeaveDaysAfterApplication := LeaveRunningBalance;
                    if "Leave Entry Type" = "Leave Entry Type"::Positive then
                        ApplicationDate := "Posting Date"
                    else
                        ApplicationDate := 0D;
                end;
                // end;

                trigger OnPostDataItem()
                begin
                    // Ensure totals are set correctly
                    if not FirstLeaveTaken then
                        LeaveDaysBeforeApplication := LeaveRunningBalance; // All days are before if no leave taken
                end;

            }


            trigger OnAfterGetRecord()
            begin
                CLEAR(Name);

                Name := "HR Employees"."First Name" + ' ' + "HR Employees"."Middle Name" + ' ' + "HR Employees"."Last Name";
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
        trigger OnOpenPage()
        begin
            if CutoffDate = 0D then
                CutoffDate := TODAY; // Default to today's date
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
        // Apply filters from request page to HR Employees
        // if EmployeeNoFilter <> '' then
        //     "HR Employees".SETFILTER("No.", EmployeeNoFilter);
        // if DepartmentFilter <> '' then
        //     "HR Employees".SETFILTER("Department Code", DepartmentFilter); // Assuming "Department Code" exists
        // if StatusFilter <> '' then
        //     "HR Employees".SETFILTER(Status, StatusFilter); // Assuming "Status" exists

        // Apply cutoff date filter to ledger entries if needed
        if CutoffDate <> 0D then
            "HR Leave Ledger Entries".SETFILTER("Posting Date", '<=%1', CutoffDate);
    end;
    // end;



    var
        CI: Record "79";
        LeaveBalance: Decimal;
        EmployeeCaptionLbl: Label 'Employee';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_Leave_StatementCaptionLbl: Label 'Employee Leave Statement';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        NameCaptionLbl: Label 'Name';
        Leave_BalanceCaptionLbl: Label 'Leave Balance';
        Day_s_CaptionLbl: Label 'Day(s)';
        No: Decimal;
        Name: Text[100];
        EmployeeApplicationDate: Date;
        EmployeeStartDate: Date;
        LeaveRunningBalance: Decimal;
        LeaveDaysBeforeApplication: Decimal;
        LeaveDaysAfterApplication: Decimal;
        CutoffDate: Date;
        FirstLeaveTaken: Boolean;
        FirstLeaveDate: Date;
        EmployeeNoFilter: Text;
        DepartmentFilter: Text;
        StatusFilter: Text;
        ApplicationDate: Date;
}

