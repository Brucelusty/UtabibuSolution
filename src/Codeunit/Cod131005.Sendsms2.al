Codeunit 131005 "Send sms 2"
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

