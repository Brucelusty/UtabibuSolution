codeunit 131072 "BulkSMS Service"
{

    trigger OnRun()
    begin
        Message(PollPendingSMS());
    end;

    var
        SMSMessages: Record "Login Sms";

    procedure PollPendingSMS() MessageDetails: Text
    begin

        SMSMessages.Reset;
        SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
        SMSMessages.SetFilter(SMSMessages."Date Entered", '=%', TODAY);
        if SMSMessages.Find('-') then begin

            if (SMSMessages."Telephone No" = '')
              or (SMSMessages."Telephone No" = '+')
              or (SMSMessages."SMS Message" = '')
              then begin

                SMSMessages."Sent To Server" := SMSMessages."sent to server"::Failed;
                SMSMessages."Entry No." := 'FAILED';
                SMSMessages.Modify;

            end else begin
                MessageDetails := '';

                MessageDetails += SMSMessages."Telephone No" + ':::' + SMSMessages."SMS Message" + ':::' + Format(SMSMessages."Entry No");
            end;
        end;
    end;


    procedure ConfirmSent(TelephoneNo: Text[20]; Status: Integer)
    begin

        SMSMessages.Reset;
        SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
        SMSMessages.SetRange(SMSMessages."Entry No", Status);
        if SMSMessages.FindFirst then begin
            SMSMessages."Sent To Server" := SMSMessages."sent to server"::Yes;
            SMSMessages."Entry No." := 'SUCCESS';
            SMSMessages.Modify;

        end
    end;




}

