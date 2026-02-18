Codeunit 131002 "Send sms"
{
    TableNo = "Sms Entry 2";

    trigger OnRun()
    var
        SmsManagement: Codeunit "Sms Management";
    begin

        SmsManagement.FnSendsms(Rec);

        rec.Modify(true);
    end;
}

