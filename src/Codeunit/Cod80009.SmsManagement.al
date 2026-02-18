codeunit 80009 "Sms Management"
{
    trigger OnRun()
    var
        "count": Integer;
    begin

        //  SendSmsResponse('+254720667019', 'Tests sms from Nav00000');//254723214181

        SendBulkSms();
    end;

    var

        lArrayString: Text;
        lJSONString: Text;

    procedure SendSmsResponse(phonenumber: Code[20]; sms: Text)
    var
        contacts: Record SMSContacts;
        apilogs: Record ApiLogs;
        smsEntry: Record "Sms Entry 2";
        send: Codeunit "Sms Errors 2";
    begin

        smsEntry.Init;
        smsEntry."Phone Number" := phonenumber;
        smsEntry.Message := sms;
        smsEntry.Messageid := CreateGuid;
        smsEntry."Message Date" := Today;
        smsEntry."Message Time" := Time;
        smsEntry.Insert(true);
        FnSendsms(smsEntry);
        // TaskScheduler.CreateTask(Codeunit::"Send sms 2", Codeunit::"Sms Errors 2", true, COMPANYNAME, CurrentDatetime, smsEntry.RecordId);



    end;

    procedure SendBulkSms()
    var
        sms: Record "Sms Entry 2";
        MobilePhone: Text;
        Message: Text;
    begin

        Sms.Reset();
        Sms.SetFilter(Sms.Status, '<>%1', Sms.Status::Success);
        Sms.SetFilter("Message Date", '>=%1', Today);
        sms.SetRange(Bulk, true);
        sms.SetRange(Attemted, false);
        IF Sms.FindSet() THEN begin
            repeat
                sms.Attemted := true;
                sms.Modify(true);
                Commit();
                FnSendsms(sms);
            until Sms.Next() = 0;
        end;


        Sms.Reset();
        Sms.SetFilter(Sms.Status, '<>%1', Sms.Status::Success);
        Sms.SetFilter("Message Date", '>=%1', Today);
        sms.SetRange(Bulk, true);
        sms.SetRange(Response, '');
        sms.SetRange(Attemted, true);
        IF Sms.FindSet() THEN begin
            repeat
                sms.Attemted := true;
                sms.Modify(true);
                Commit();
                FnSendsms(sms);
            until Sms.Next() = 0;
        end;
    end;

    procedure PostRequest(variables: Text; apilink: Text; method: Text) ResponseData: Text
    var


        httpWebRequest: Codeunit "Http Web Request Mgt.";
        DimensionValue: Record "Dimension Value";
        url: Text;
        param: Text;


        Client: HttpClient;
        RequestHeaders: HttpHeaders;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        ResponseText: Text;
        contentHeaders: HttpHeaders;
        responseObj: jsonObject;
        whitelistresp: jsonobject;
        responseToken: JsonToken;
        AJsonObject: JsonObject;
        JSonText: Text;
    begin

        url := apilink;
        IF method = 'POST' then BEGIN
            RequestHeaders := Client.DefaultRequestHeaders();
            RequestContent.WriteFrom(variables);
            RequestContent.GetHeaders(contentHeaders);
            contentHeaders.Clear();
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + '4|facAWSCjMPFErM1YLgp5vxw5GuMoSC6DFRqVoJ3g939661ff');
            contentHeaders.Add('Content-type', 'application/json');
            Client.Post(url, RequestContent, ResponseMessage);
        END ELSE

            IF method = 'WHITELIST' then BEGIN
                RequestHeaders := Client.DefaultRequestHeaders();
                AJsonObject.Add('username', 'UTABIBU');
                AJsonObject.Add('client_secret', '@1ISQoM9mQ4Qj%_T:!16W)ZCX2vQa');
                AJsonObject.WriteTo(JsonText);

                RequestContent.WriteFrom(JSonText);
                RequestContent.GetHeaders(contentHeaders);
                contentHeaders.Clear();
                // Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + smsSetup."EndPoint link");
                contentHeaders.Add('Content-type', 'application/json');
                //Message('message %1', ResponseMessage);
                Client.Post('https://payments.auinnovation.co.ke:44315/api/generatetoken/', RequestContent, ResponseMessage);
                ResponseMessage.Content().ReadAs(ResponseText);
                // Message('Response Text: %1', ResponseText);
                responseObj.ReadFrom(ResponseText);
                responseObj.Get('access_token', responseToken);
                if ResponseText <> '' then begin
                    RequestHeaders := Client.DefaultRequestHeaders();
                    RequestContent.WriteFrom(variables);
                    RequestContent.GetHeaders(contentHeaders);
                    contentHeaders.Clear();
                    Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + responseToken.AsValue().AsText());
                    contentHeaders.Add('Content-type', 'application/json');
                    //Message('message %1', ResponseMessage);
                    Client.Post('https://payments.auinnovation.co.ke:44315/api/whitelist', RequestContent, ResponseMessage);
                    ResponseMessage.Content().ReadAs(ResponseText);
                    // Message('Response Text: %1', ResponseText);
                    exit('TRUE');
                end;
            END

            ELSE
                IF method = 'GET' THEN BEGIN

                    client.Get(url, ResponseMessage);
                END;
        ResponseMessage.Content().ReadAs(ResponseText);
        ResponseData := ResponseText;


    end;

    procedure Whitelist(MobielApplications: Record "MOBILE Applications")
    var
        requestobj: JsonObject;
        requestarray: JsonArray;
        requestText: Text;
        responsetext: Text;
    begin
        // if MobielApplications.Whitelisted = false then begin
        requestobj.Add('phone', MobielApplications.Telephone);
        requestobj.Add('idNumber', MobielApplications."ID No");
        requestobj.Add('name', MobielApplications."Account Name");
        requestobj.Add('memberaccountNo', MobielApplications."Account No");
        requestobj.Add('applicationNo', MobielApplications."No.");
        requestarray.Add(requestobj);
        requestarray.WriteTo(requestText);
        responsetext := PostRequest(requestText, 'https://localhost:44315/api/whitelist', 'WHITELIST');
        if responsetext = 'TRUE' then
            MobielApplications.Whitelisted := true;
        MobielApplications.Modify();





    end;


    procedure FnSendsms(var SmsEntry: Record "Sms Entry 2")
    var
        JsonOut: Text;
        returnout: Text;
        responseData: Text;
        smsSetup: Record "Sms Setup 2";
        jdata: JsonObject;
        responsjson: JsonObject;
        responsetoken: JsonToken;
        responsjsoninner: JsonObject;
    begin
        Clear(jdata);

        jdata.Add('sender_id', 'UTABIBUCSCS');
        jdata.add('message', SmsEntry.Message);
        jdata.Add('recipient', SmsEntry."Phone Number");
        jdata.add('type', 'plain');
        // JsonOut := '{"sender_id": "' + 'UTABIBUCSCS' + '", ' +
        //            '"message": "' + SmsEntry.Message + '", ' +
        //            '"recipient": "' + SmsEntry."Phone Number" + '", ' +
        //            '"type": "plain"}';
        jdata.WriteTo(JsonOut);
        returnout := JsonOut;
        responseData := PostRequest(returnout, 'http://sms.auinnovation.co.ke:7272/ausms/api/v3/sms/send', 'POST');
        IF responseData <> '' THEN BEGIN
            if responsjson.ReadFrom(responseData) then begin
                responsjson.get('status', responsetoken);
                if responsetoken.AsValue().AsText() = 'success' then begin
                    responsjson.get('message', responsetoken);
                    SmsEntry.Response := responsetoken.AsValue().AsText();
                    responsjson.get('data', responsetoken);
                    responsjsoninner := responsetoken.AsObject();
                    responsjsoninner.get('status', responsetoken);
                    SmsEntry."Response id" := responsetoken.AsValue().AsText();
                    SmsEntry.Status := SmsEntry.Status::Success;
                    SmsEntry.Attemted := true;
                    SmsEntry.MODIFY;
                end
                else begin
                    SmsEntry.Status := SmsEntry.Status::Failed;
                    SmsEntry.Attemted := true;

                    responsjson.get('message', responsetoken);
                    SmsEntry.Response := responsetoken.AsValue().AsText();
                    SmsEntry.MODIFY;
                end;
            end else begin
                SmsEntry.Status := SmsEntry.Status::Failed;
                SmsEntry.Attemted := true;
                SmsEntry.MODIFY;
            end;
        END;

    end;

    procedure SendSmsResponseTest(phonenumber: Code[20]; sms: Text)
    var
        contacts: Record SMSContacts;
        apilogs: Record ApiLogs;
        smsEntry: Record "Sms Entry 2";
        send: Codeunit "Sms Errors 2";
    begin
        smsEntry.Init;
        smsEntry."Phone Number" := phonenumber;
        smsEntry.Message := sms;
        smsEntry.Messageid := CreateGuid;
        smsEntry."Message Date" := Today;
        smsEntry."Message Time" := Time;
        smsEntry.Insert(true);
        FnSendsms(smsEntry);
        // TaskScheduler.CreateTask(Codeunit::"Send sms 2", Codeunit::"Sms Errors 2", true, COMPANYNAME, CurrentDatetime, smsEntry.RecordId);
    end;
}

