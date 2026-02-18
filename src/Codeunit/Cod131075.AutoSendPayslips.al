codeunit 131075 "Auto Send Payslips "

{


    trigger OnRun()
    begin

    end;

    local procedure SendPayslipsForPeriod(var PayrollPeriod: Record "Payroll Calender.")
    var
        PayrollEmp: Record "Payroll Employee.";
        TempBlob: Codeunit "Temp Blob";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        OutStr: OutStream;
        InStr: InStream;
        RecRef: RecordRef;
        FileName: Text;
        Subject: Text;
        Body: Text;
        EmpEmail: Text;
        Factory: Codeunit "Au Factory";
    begin

        if PayrollPeriod."Payslips Sent" then
            exit;

        PayrollEmp.Reset();
        PayrollEmp.SetRange(Status, PayrollEmp.Status::Active);
        if PayrollEmp.FindSet() then
            repeat

                PayrollEmp.SetRange("Current Month Filter", PayrollPeriod."Date Opened");

                if (PayrollEmp."Employee Email" <> '') and PayrollEmp."Employee Email".Contains('@') then begin
                    EmpEmail := LowerCase(PayrollEmp."Employee Email");

                    TempBlob.CreateOutStream(OutStr);
                    RecRef.GetTable(PayrollEmp);


                    if Report.SaveAs(Report::"Payroll Payslip.", '', ReportFormat::Pdf, OutStr, RecRef) then begin

                        FileName := StrSubstNo('%1 - Payslip %2 %3.pdf',
                                        PayrollEmp."No.",
                                        Format(PayrollPeriod."Date Opened", 0, '<Month Text,3>'),
                                        Format(PayrollPeriod."Date Opened", 0, '<Year4>'));

                        Subject := StrSubstNo('Payslip – %1', PayrollPeriod."Period Name");

                        Body := StrSubstNo(
                                  '<p>Dear %1,</p><p>Please find attached your payslip for <strong>%2</strong>.</p><p>Regards,<br/>Human Resources</p>',
                                  Factory.FnConvertTexttoBeginingWordstostartWithCapital(PayrollEmp.Firstname),
                                  PayrollPeriod."Period Name");

                        TempBlob.CreateInStream(InStr);

                        EmailMsg.Create(EmpEmail, Subject, Body, true);
                        EmailMsg.AddAttachment(FileName, 'application/pdf', InStr);
                        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                    end;
                end;


                PayrollEmp.SetRange("Current Month Filter");

            until PayrollEmp.Next() = 0;

        PayrollPeriod."Payslips Sent" := true;
        PayrollPeriod.Modify();

        Message('Payslips have been sent automatically for period: %1', PayrollPeriod."Period Name");
    end;

    // THIS IS THE MAGIC – fires automatically the moment someone ticks "Closed"
    [EventSubscriber(ObjectType::Table, Database::"Payroll Calender.", 'OnAfterModifyEvent', '', true, true)]
    local procedure OnAfterClosePayrollPeriod(var Rec: Record "Payroll Calender."; var xRec: Record "Payroll Calender.")
    begin
        // Only when Closed goes from False → True and payslips not sent yet
        if Rec.Closed and (not xRec.Closed) and (not Rec."Payslips Sent") then
            SendPayslipsForPeriod(Rec);
    end;
}