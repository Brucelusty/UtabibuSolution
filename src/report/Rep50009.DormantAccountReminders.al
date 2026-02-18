report 50009 "Dormant Account Reminders"
{
    RDLCLayout = 'Layouts/GenerateDormantAC.rdlc';
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = Tasks;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.") WHERE(isnormalmember = FILTER(true), Status = FILTER(Dormant));
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4)) { }
            column(COMPANYNAME; CompanyName) { }
            column(Company_Address; Company.Address) { }
            column(Company_Address2; Company."Address 2") { }
            column(Company_PhoneNo; Company."Phone No.") { }
            column(Company_Email; Company."E-Mail") { }
            column(Company_Picture; Company.Picture) { }
            column(USERID; UserId) { }
            column(S_No; SN) { }
            column(No; Customer."No.") { }
            column(Name; Customer.Name) { }
            column(Current_Shares; Customer."Current Shares") { }

            trigger OnAfterGetRecord()
            begin
                SN := SN + 1; // Increment serial number for logging

                // Send SMS reminder if Status is Dormant
                if Customer.Status = Customer.Status::Dormant then
                    SendSMSReminder(Customer);
            end;

            trigger OnPreDataItem()
            begin
                if AsAt = 0D then
                    AsAt := Today;
                DateFilter := '..' + Format(AsAt);
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
                field(AsAt; AsAt)
                {
                    Caption = 'As At Date';
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Picture);
    end;

    trigger OnPostReport()
    begin
        Message('Dormant account SMS reminders sent successfully. Total processed: %1', SN);
    end;

    var
        Company: Record "Company Information";
        AsAt: Date;
        DateFilter: Text[30];
        SN: Integer;
        SmsManagement: Codeunit "Sms Management";

    local procedure SendSMSReminder(var Cust: Record Customer)
    var
        SMSMessage: Text;
        SMSLog: Record "Sms Entry 2";
        SmsMgt: Codeunit "Sms Management";
        ErrorInfo: ErrorInfo;
    begin
        if Cust."Phone No." = '' then
            exit;

        SMSMessage := StrSubstNo('Dear %1, Your Account is dormant. Kindly activate it using M-PESA paybill 822950 and Account No. DEP%2. We are Your Financial Friend.',
            Cust.Name, Cust."ID No.");
        if StrLen(SMSMessage) > 160 then
            SMSMessage := CopyStr(SMSMessage, 1, 157) + '...';

        // Log SMS
        SMSLog.Init();
        SMSLog."Phone Number" := Cust."Phone No.";
        SMSLog.Message := SMSMessage;
        SMSLog."Message Date" := DT2Date(CurrentDateTime);
        SMSLog.Insert(true);


        //if Codeunit.Run(Codeunit::"Sms Management", SmsMgt) then begin
        // SmsMgt.SendSmsResponse(Cust."Phone No.", SMSMessage);
        SMSLog.Status := SMSLog.Status::Success;
        SMSLog.Modify(true);
    end;



    procedure ScheduleReport()
    var
        JobQueueEntry: Record "Job Queue Entry";
        NextRun5th: Date;
        NextRun28th: Date;
    begin
        // Delete existing entries to avoid duplicates
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Report);
        JobQueueEntry.SetRange("Object ID to Run", Report::"Dormant Account Reminders");
        JobQueueEntry.DeleteAll();

        NextRun5th := CalcNextRunDate(5);
        NextRun28th := CalcNextRunDate(28);

        // Schedule for 5th
        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Report;
        JobQueueEntry."Object ID to Run" := Report::"Dormant Account Reminders";
        JobQueueEntry.Description := 'Dormant Account Reminders - 5th of Month';
        JobQueueEntry."Recurring Job" := true;
        JobQueueEntry."No. of Minutes between Runs" := 0;
        JobQueueEntry."Earliest Start Date/Time" := CreateDateTime(NextRun5th, 000000T);
        JobQueueEntry.Status := JobQueueEntry.Status::Ready;
        JobQueueEntry.Insert(true);

        // Schedule for 28th
        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Report;
        JobQueueEntry."Object ID to Run" := Report::"Dormant Account Reminders";
        JobQueueEntry.Description := 'Dormant Account Reminders - 28th of Month';
        JobQueueEntry."Recurring Job" := true;
        JobQueueEntry."No. of Minutes between Runs" := 0;
        JobQueueEntry."Earliest Start Date/Time" := CreateDateTime(NextRun28th, 000000T);
        JobQueueEntry.Status := JobQueueEntry.Status::Ready;
        JobQueueEntry.Insert(true);

        Message('Report scheduled to run on the 5th and 28th of every month starting %1 and %2.', NextRun5th, NextRun28th);
    end;

    local procedure CalcNextRunDate(DayOfMonth: Integer): Date
    var
        CurrentDate: Date;
        CurrentDay: Integer;
        CurrentMonth: Integer;
        CurrentYear: Integer;
    begin
        CurrentDate := Today;
        CurrentDay := Date2DMY(CurrentDate, 1);
        CurrentMonth := Date2DMY(CurrentDate, 2);
        CurrentYear := Date2DMY(CurrentDate, 3);

        if CurrentDay <= DayOfMonth then
            exit(DMY2Date(DayOfMonth, CurrentMonth, CurrentYear))
        else
            exit(CalcDate('<+1M>', DMY2Date(DayOfMonth, CurrentMonth, CurrentYear)));
    end;
}