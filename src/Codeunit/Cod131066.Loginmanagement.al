codeunit 131066 "Login management"
{
    Permissions = tabledata "User Setup" = rim,
                          tabledata "Sms Entry 2" = rimd;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::LogInManagement, OnShowTermsAndConditions, '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", OnAfterLogin, '', false, false)]
    local procedure LoginStatus()
    var
        ClientTypeManagement: Codeunit "Client Type Management";
        ActiveSession: Record "Active Session";
        UserSetup: Record "User Setup";
        OTPLog: Record "OTP LOGS"; // Custom table to stoare OTP details
        OTP: Integer;
        InputCount: Integer;
        Success: Boolean;
        TwoFactorAuth: Page TwoFactorAuth;
        OtpKeyed: Integer;
        SmsManagement: Codeunit "Sms Management";
        SMSMessages: Record "Login Sms";
        iEntryNo: Integer;
        ExpirationTime: DateTime;
        smsEntry: Record "Sms Entry 2";
    begin
        //Check if an OTP is already generated for this session
        //if UserSetup.Get(UserId) then begin
        OTPLog.reset;
        OTPLog.SetRange("User Id", UserId);
        if OTPLog.Find('-') then begin
            OTPLog.DeleteAll();
        end;
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            if UserSetup."User ID" <> 'AU' then begin
                //Message('get Type %1', ClientTypeManagement.GetCurrentClientType());
                if ClientTypeManagement.GetCurrentClientType() = ClientType::Web then
                    if UserSetup."Excempt OTP" = false then begin
                        ExpirationTime := CurrentDateTime + (2 * 60);
                        OTPLog.SetRange(OTPLog."User ID", UserSetup."User ID");
                        OTPLog.SetFilter("Generated On", '>=%1', ExpirationTime);
                        //OTPLog.SetRange(OTPLog."Session ID", SESSIONID);
                        if OTPLog.FindFirst() = false then begin
                            OTP := GenerateOTP();// Random(10000);

                            OTPLog.Init();
                            OTPLog."User ID" := UserId;
                            OTPLog."OTP" := OTP;
                            OTPLog."Entry No" := NextAvailableEntryNo2(OTPLog);
                            OTPLog."Generated On" := CurrentDateTime();
                            OTPLog."Session ID" := SESSIONID;
                            OTPLog.Insert(true);

                            iEntryNo := NextAvailableEntryNo(SMSMessages); // Method to get next entry number
                            SMSMessages.Init();
                            SMSMessages."Entry No" := iEntryNo;
                            SMSMessages."Date Entered" := Today;
                            SMSMessages."Time Entered" := Time;
                            SMSMessages.Source := 'OTP';
                            SMSMessages."Entered By" := USERID;
                            SMSMessages."Telephone No" := UserSetup."Phone No.";
                            SMSMessages."SMS Message" := 'Dear ' + USERID + ', Your one-time password for ERP login is: ' + Format(OTP);
                            SMSMessages.Insert(true);
                            Message('Check your phone for OTP');
                            Commit();
                            //end;
                        end;




                        // OTP Validation Process
                        InputCount := 0;
                        Success := false;

                        repeat
                            Clear(TwoFactorAuth);
                            Clear(TwoFactorAuth);
                            if TwoFactorAuth.RunModal() = Action::Cancel then begin
                                Error('OTP Entry Cancelled');
                            end;
                            if TwoFactorAuth.RunModal() <> Action::OK then
                                Error('OTP Entry Cancelled');



                            OtpKeyed := TwoFactorAuth.GetEnteredOTP();
                            if OtpKeyed = OTP then
                                Success := true
                            else begin
                                InputCount += 1;

                                Message('Incorrect OTP. Please try again.');
                            end;
                        until (InputCount >= 3) or Success;

                        if not Success then
                            Error('Access Denied! Too many incorrect OTP attempts.');
                    end;
            end;
        end;
        //end;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", OnAfterInitialization, '', false, false)]
    local procedure RestrictLogInWithOTP()
    var
        ClientTypeManagement: Codeunit "Client Type Management";
        ActiveSession: Record "Active Session";
        UserSetup: Record "User Setup";
        OTPLog: Record "OTP LOGS"; // Custom table to stoare OTP details
        OTP: Integer;

        InputCount: Integer;
        Success: Boolean;
        TwoFactorAuth: Page TwoFactorAuth;
        OtpKeyed: Integer;
        SmsManagement: Codeunit "Sms Management";
        SMSMessages: Record "Login Sms";
        iEntryNo: Integer;
        ExpirationTime: DateTime;
        smsEntry: Record "Sms Entry 2";
    begin

    end;

    local procedure GenerateOTP(): Integer
    var
        Randomn: Text;
        OTP: Integer;
    begin
        Randomize();
        Randomn := Format(Random(8)) + Format(Random(7)) + Format(Random(4)) + Format(Random(7));// + Format(Random(6));
        Evaluate(OTP, Randomn);
        exit(OTP);
    end;

    local procedure NextAvailableEntryNo(var SMSMessages: Record "Login Sms"): Integer
    var
        MaxEntryNo: Integer;
    begin
        SMSMessages.Reset();
        if SMSMessages.FindLast() then
            MaxEntryNo := SMSMessages."Entry No";
        exit(MaxEntryNo + 1);
    end;

    local procedure NextAvailableEntryNo2(var SMSMessages: Record "OTP LOGS"): Integer
    var
        MaxEntryNo: Integer;
    begin
        SMSMessages.Reset();
        if SMSMessages.FindLast() then
            MaxEntryNo := SMSMessages."Entry No";
        exit(MaxEntryNo + 1);
    end;


    //     //[EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", OnAfterLogin, '', false, false)]
    //     // local procedure InitPasswordLogIfEmpty()
    //     // var
    //     //     ChangePassword: Record "Password History";
    //     //     UserSetup: Record "User Setup";
    //     //     ICTSetup: Record "ICT Setup";
    //     //     TwoFactorAuth: Page OTP;
    //     //     LoginEnd2: Codeunit LogInManagement;
    //     //     User: Record "User Setup";
    //     //     OTP: Integer;
    //     //     ptext2: Text;
    //     //     Count: Integer;
    //     //     Success: Boolean;
    //     //     Status: Integer;
    //     //     Otpkeyed: Integer;
    //     //     IEntryNo: Integer;
    //     //     Randomn: Text;
    //     //     dtext: Text;
    //     //     ptext: Text;
    //     //     SMSMessages: Record "SMS Messages";
    //     //     EmailMessage: Codeunit "Email Message";
    //     //     EmailSend: Codeunit Email;
    //     //     smsEntry: Record "Sms Entry 2";
    //     //     TextBuilder: TextBuilder;
    //     //     Dear: Label '<p>Dear %1 </p></br>';
    //     //     Message: Label '<p>your One Time Password is <strong> %2 </strong> </p></br> ';
    //     //     Regards: Label 'Thank You';
    //     //     NewBody: Text;
    //     //     FormattedBody: Text;
    //     //     OTPSend: Boolean;
    //     //     SmsMessagesCodeunit: Codeunit "Sms Management";
    //     //     LogInManagement: Codeunit LogInManagement;
    //     //     OTPExpirationTime: DateTime;
    //     //     ActiveSession: Record "Active Session";
    //     //     Deartext: Text[100];
    //     //     Pleasetext: Text[100];
    //     //     InputCount: Integer;

    //     // begin
    //     // end;

    //     //ron Addition
    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", OnAfterLogin, '', false, false)]
    //     local procedure InitPasswordLogIfEmpty2()
    //     var
    //         ChangePassword: Record "Password History";
    //         UserSetup: Record "User Setup";
    //         ICTSetup: Record "ICT Setup";
    //         PasswordExpiryMsg: Label 'Hi %1, Your password has expired. You will be required to change it on your next login';
    //     begin
    //         ICTSetup.Reset();
    //         ICTSetup.SetRange("Enforce Password Expiry", true);
    //         if ICTSetup.Find('-') then begin

    //             UserSetup.Reset();
    //             UserSetup.SetRange("User ID", UserId);
    //             UserSetup.SetRange("Password Does Not Expire", false);
    //             if UserSetup.FindSet() then begin

    //                 ChangePassword.Reset();
    //                 ChangePassword.SetRange(UserName, UserSetup."User ID");
    //                 if not ChangePassword.FindFirst() then begin

    //                     ChangePassword.Init();
    //                     ChangePassword.No := ChangePassword.GetNextLineNo();
    //                     ChangePassword.UserName := UserSetup."User ID";
    //                     ChangePassword.Validate("Last Password Change", Today());
    //                     ChangePassword."User Security ID" := GetUserSecurityID(UserSetup."User ID");
    //                     ChangePassword."Changed?" := false;
    //                     ChangePassword.Insert(true);
    //                     Message(StrSubstNo(PasswordExpiryMsg, UserId()));
    //                 end;
    //             end;
    //         end;
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", OnAfterLogin, '', false, false)]
    //     local procedure CheckifPasswordhadExpired()
    //     var
    //         ChangePassword: Record "Password History";
    //         ICTSetup: Record "ICT Setup";
    //         UserSetup: Record "User Setup";
    //         User: Record User;
    //         PasswordExpiryMsg: Label 'Hi %1, Your password has expired. You will be required to change it on your next login';
    //     begin
    //         ICTSetup.Reset();
    //         ICTSetup.SetRange("Enforce Password Expiry", true);
    //         if ICTSetup.Find('-') then begin
    //             if ICTSetup."Enforce Password Expiry" = true then begin
    //                 UserSetup.Reset();
    //                 UserSetup.SetRange("User ID", UserId);
    //                 UserSetup.SetRange("Password Does Not Expire", false);
    //                 if UserSetup.Find('-') then begin
    //                     ChangePassword.Reset();
    //                     ChangePassword.SetRange(UserName, UserId);
    //                     if ChangePassword.Find('-') then
    //                         if ChangePassword."Next Password Change" <= Today() then begin
    //                             ChangePassword.Validate("Next Password Change");
    //                             if User.Get(ChangePassword."User Security ID") then begin
    //                                 Message(StrSubstNo(PasswordExpiryMsg, UserId()));
    //                                 User.Validate("Change Password", true);
    //                                 User.Modify(true)
    //                             end;

    //                         end;
    //                 end;
    //             end;
    //         end;
    //     end;

    local procedure GetUserSecurityID(UserName: Code[50]): GUID
    var
        UserRec: Record User;
    begin
        UserRec.SetRange("User Name", UserName);
        if UserRec.FindFirst() then
            exit(UserRec."User Security ID");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", OnAfterLogin, '', false, false)]
    local procedure InitPasswordLogIfEmpty2()
    var
        ChangePassword: Record "Password History";
        UserSetup: Record "User Setup";
        ICTSetup: Record "ICT Setup";
    begin
        ICTSetup.Reset();
        ICTSetup.SetRange("Enforce Password Expiry", true);
        if ICTSetup.Find('-') then begin

            UserSetup.Reset();
            UserSetup.SetRange("User ID", UserId);
            UserSetup.SetRange("Password Does Not Expire", false);
            if UserSetup.FindSet() then begin

                ChangePassword.Reset();
                ChangePassword.SetRange(UserName, UserSetup."User ID");
                if not ChangePassword.FindFirst() then begin

                    ChangePassword.Init();
                    ChangePassword.No := ChangePassword.GetNextLineNo();
                    ChangePassword.UserName := UserSetup."User ID";
                    ChangePassword.Validate("Last Password Change", Today());
                    ChangePassword."User Security ID" := GetUserSecurityID(UserSetup."User ID");
                    ChangePassword."Changed?" := false;
                    ChangePassword.Insert(true);
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", OnAfterLogin, '', false, false)]
    local procedure CheckifPasswordhadExpired()
    var
        ChangePassword: Record "Password History";
        ICTSetup: Record "ICT Setup";
        UserSetup: Record "User Setup";
        User: Record User;
        PasswordExpiryMsg: Label 'Hi %1, Your password has expired. You will be required to change it on your next login';
    begin
        ICTSetup.Reset();
        ICTSetup.SetRange("Enforce Password Expiry", true);
        if ICTSetup.Find('-') then begin
            if ICTSetup."Enforce Password Expiry" = true then begin
                UserSetup.Reset();
                UserSetup.SetRange("User ID", UserId);
                UserSetup.SetRange("Password Does Not Expire", false);
                if UserSetup.Find('-') then begin
                    ChangePassword.Reset();
                    ChangePassword.SetRange(UserName, UserId);
                    if ChangePassword.Find('-') then
                        if ChangePassword."Next Password Change" <= Today() then begin
                            ChangePassword.Validate("Next Password Change");
                            User.Reset();
                            User.SetRange("User Name", UserSetup."User ID");
                            if User.Find('-') then begin
                                Message(StrSubstNo(PasswordExpiryMsg, UserId()));
                                User.Validate("Change Password", true);
                                User.Modify(true)
                            end;

                        end;
                end;
            end;
        end;
    end;

}
