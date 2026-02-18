//<---------------------------------------------------------------------->															

Report 50085 "HR Leave Application"
{
    RDLCLayout = 'Layouts/HR Leave Application.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("HR Leave Application"; "HR Leave Application")
        {
            RequestFilterFields = "Application Code";
            RequestFilterHeading = 'Document Number';
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(EmployeeNo_HRLeaveApplication; "Employee No")
            {
                IncludeCaption = true;
            }
            column(EmployeeName; EmpName)
            {
            }
            column(DaysApplied_HRLeaveApplication; "Days Applied")
            {
                IncludeCaption = true;
            }
            column(ApplicationCode_HRLeaveApplication; "Application Code")
            {
                IncludeCaption = true;
            }
            column(RequestLeaveAllowance_HRLeaveApplication; "Request Leave Allowance")
            {
                IncludeCaption = true;
            }
            column(LeaveAllowanceAmount_HRLeaveApplication; "Leave Allowance Amount")
            {
                IncludeCaption = true;
            }
            column(NumberofPreviousAttempts_HRLeaveApplication; "Number of Previous Attempts")
            {
                IncludeCaption = true;
            }
            column(DetailsofExamination_HRLeaveApplication; "Details of Examination")
            {
                IncludeCaption = true;
            }
            column(DateofExam_HRLeavseApplication; "Date of Exam")
            {
                IncludeCaption = true;
            }
            column(Reliever_HRLeaveApplication; Reliever)
            {
                IncludeCaption = true;
            }
            column(RelieverName_HRLeaveApplication; "Reliever Name")
            {
                IncludeCaption = true;
            }
            column(StartDate_HRLeaveApplication; "Start Date")
            {
                IncludeCaption = true;
            }
            column(ReturnDate_HRLeaveApplication; "Return Date")
            {
                IncludeCaption = true;
            }
            column(LeaveType_HRLeaveApplication; "Leave Type")
            {
                IncludeCaption = true;
            }
            column(JobTittle_HRLeaveApplication; "Job Tittle")
            {
                IncludeCaption = true;
            }
            column(ApplicationDate_HRLeaveApplication; "Application Date")
            {
                IncludeCaption = true;
            }
            column(EmailAddress_HRLeaveApplication; "E-mail Address")
            {
                IncludeCaption = true;
            }
            column(CellPhoneNumber_HRLeaveApplication; "Cell Phone Number")
            {
                IncludeCaption = true;
            }
            column(Approveddays_HRLeaveApplication; "Approved days")
            {
            }
            column(daysearned; daysearned)
            {
            }
            column(daystaken; daystaken)
            {
            }
            column(daysleft; daysleft)
            {
            }
            column(Supervisor; Supervisor)
            {

            }
            column(Approver_Comments; "Approver Comments")
            {

            }


            dataitem("Approval Comment Line"; "Approval Comment Line")
            {
                DataItemLink = "Document No." = FIELD("Application Code");
                DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
                column(ApprovedDays_ApprovalCommentLine; "Approval Comment Line"."Approved Days")
                {
                    IncludeCaption = true;
                }
                column(Comment_ApprovalCommentLine; "Approval Comment Line".Comment)
                {
                    IncludeCaption = true;
                }
                // column(ApprovedStartDate_ApprovalCommentLine;"Approval Comment Line"."Approved Start Date")
                // {
                //     IncludeCaption = true;
                // }
                // column(ApprovedReturnDate_ApprovalCommentLine;"Approval Comment Line"."Approved Return Date")
                // {
                //     IncludeCaption = true;
                // }
                //column(Reason_ApprovalCommentLine;"Approval Comment Line".Reason)
                //{
                // IncludeCaption = true;
                //  }
                // column(LeaveAllowanceGranted_ApprovalCommentLine;"Approval Comment Line"."Leave Allowance Granted")
                // {
                //     IncludeCaption = true;
                // }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("Application Code");
                DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.") ORDER(Ascending);
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                    IncludeCaption = true;
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    DataItemTableView = SORTING("User ID") ORDER(Ascending);
                }
                column(Approver_ID; "Approver ID")
                {
                    IncludeCaption = true;
                }
            }

            trigger OnAfterGetRecord()
            begin
                if "HR Employees".Get("HR Leave Application"."Employee No") then begin
                    "HR Employees".SetFilter("Leave Type Filter", "HR Leave Application"."Leave Type");
                    daysearned := "HR Employees"."Total (Leave Days)";
                    "HR Employees".CalcFields("HR Employees"."Total Leave Taken");
                    daystaken := "HR Employees"."Total Leave Taken";
                    daysleft := "HR Employees"."Leave Balance";
                end;

                "HR Employees".Reset;
                if "HR Employees".Get("Employee No") then begin
                    EmpName := "HR Employees"."First Name" + ' ' + "HR Employees"."Middle Name" + ' ' + "HR Employees"."Last Name";
                    "Job Tittle" := "HR Employees"."Job Title";
                end;
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

    trigger OnPreReport()
    begin
        CI.Get;
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        "HR Employees": Record "HR Employees";
        daysearned: Decimal;
        daystaken: Decimal;
        daysleft: Decimal;
        EmpName: Text[50];
}

