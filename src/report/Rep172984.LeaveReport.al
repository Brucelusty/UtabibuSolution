report 172984 LeaveReport
{
    ApplicationArea = All;
    Caption = 'LeaveReport';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/LeaveReport.rdlc';
    dataset
    {
        dataitem(HREmployees; "HR Employees")
        {
            RequestFilterFields = "Leave Type", "Period Filter";

            column(PeriodFilter; "Period Filter")
            {
            }
            column(No_; "No.")
            {

            }
            column(FullName; FullName)
            {

            }
            column(LeaveType; "Leave Type")
            {
            }
            column(LeaveStatus; "Leave Status")
            {
            }
            column(TotalLeaveDays; "Total (Leave Days)")
            {
            }
            column(TotalLeaveTaken; "Total Leave Taken")
            {
            }
            column(LeaveBalanceDays; "Leave Balance Days")
            {
            }
            column(LeaveTypeFilter; "Leave Type Filter")
            {
            }
            column(AnnualLeaveAccount; "Annual Leave Account")
            {
            }
            column(AllocatedLeaveDays; "Allocated Leave Days")
            {
            }
            column(AcruedLeaveDays; "Acrued Leave Days")
            {
            }
            column(MaternityLeaveAcc; "Maternity Leave Acc.")
            {
            }
            column(PaternityLeaveAcc; "Paternity Leave Acc.")
            {
            }
            column(StudyLeaveAcc; "Study Leave Acc")
            {
            }
            column(SickLeaveAcc; "Sick Leave Acc.")
            {
            }
            column(Company_E_Mail; "Company E-Mail")
            {

            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Companyinfo_Name; Companyinfo.Name)
            {
            }
            column(Companyinfo_Address; Companyinfo.Address)
            {
            }
            column(CompanyinfoPicture; Companyinfo.Picture)
            {
            }


            column(Date_Of_Joining_the_Company; "Date Of Joining the Company")
            {

            }
        }
    }

    var

        CompanyInfo: Record "Company Information";
}
