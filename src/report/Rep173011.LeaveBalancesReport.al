report 173016 "Leave Balances Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/HR Leave Balance Report.rdlc';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            RequestFilterFields = "No.";
            DataItemTableView = WHERE(Status = CONST(Active));

            column(No; "No.")
            {
            }
            column(Surname; "Last Name")
            {
            }
            column(Firstname; "First Name")
            {
            }
            column(Middle; "Middle Name")
            {
            }
            column(AnnualLeave; AnnualLeave)
            {
            }
            column(CompassionateLeave; CompassionateLeave)
            {
            }
            column(MaternityLeave; MaternityLeave)
            {
            }
            column(PaternityLeave; PaternityLeave)
            {
            }
            column(SickLeave; SickLeave)
            {
            }
            column(StudyLeave; StudyLeave)
            {
            }
            column(CTOLeave; CTOLeave)
            {
            }
            column(Liability; Liability)
            {
            }

            trigger OnAfterGetRecord()
            var
                HRLeaveLedger: Record "HR Leave Ledger Entries";
                PayrollEmp: Record "Payroll Employee.";
            begin
                // Initialize balances
                AnnualLeave := 0;
                CompassionateLeave := 0;
                MaternityLeave := 0;
                PaternityLeave := 0;
                SickLeave := 0;
                StudyLeave := 0;
                CTOLeave := 0;

                // Filter ledger entries up to AsAtDate
                HRLeaveLedger.SetRange("Staff No.", "HR Employees"."No.");
                HRLeaveLedger.SetRange("Posting Date", 0D, AsAtDate);

                if HRLeaveLedger.FindSet() then
                    repeat
                        // Check leave type as Code field
                        if HRLeaveLedger."Leave Type" = 'ANNUAL' then
                            AnnualLeave += HRLeaveLedger."No. of Days";
                        if HRLeaveLedger."Leave Type" = 'COMPASSIONATE' then
                            CompassionateLeave += HRLeaveLedger."No. of Days";
                        if HRLeaveLedger."Leave Type" = 'MATERNITY' then
                            MaternityLeave += HRLeaveLedger."No. of Days";
                        if HRLeaveLedger."Leave Type" = 'PATERNITY' then
                            PaternityLeave += HRLeaveLedger."No. of Days";
                        if HRLeaveLedger."Leave Type" = 'SICK' then
                            SickLeave += HRLeaveLedger."No. of Days";
                        if HRLeaveLedger."Leave Type" = 'EXAM' then
                            StudyLeave += HRLeaveLedger."No. of Days";
                        if HRLeaveLedger."Leave Type" = 'CTO' then
                            CTOLeave += HRLeaveLedger."No. of Days";
                    until HRLeaveLedger.Next() = 0;

                // Calculate liability for Annual Leave
                Liability := 0;
                if PayrollEmp.Get("HR Employees"."No.") then
                    Liability := Round((PayrollEmp."Basic Pay" / 22) * AnnualLeave, 0.01);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(AsAtDate; AsAtDate)
                    {
                        Caption = 'Balance As At';
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if AsAtDate = 0D then
                AsAtDate := WorkDate();
        end;
    }

    var
        AsAtDate: Date;
        Liability: Decimal;
        AnnualLeave: Decimal;
        CompassionateLeave: Decimal;
        MaternityLeave: Decimal;
        PaternityLeave: Decimal;
        SickLeave: Decimal;
        StudyLeave: Decimal;
        CTOLeave: Decimal;
}
