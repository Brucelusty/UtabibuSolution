codeunit 131063 "Setup Dormant Report Schedule"
{
    trigger OnRun()
    var
        DormantReport: Report "Dormant Account Reminders";
    begin
        DormantReport.ScheduleReport();
    end;
}
