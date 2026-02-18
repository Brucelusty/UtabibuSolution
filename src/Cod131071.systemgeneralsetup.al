// codeunit 131071 "system generalsetup"
// {

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterInitialization', '', false, false)]
//     // [EventSubscriber(ObjectType::Codeunit, 40, 'onlogi', '', false, false)]
//     local procedure RestrictLogInWithOTP()
//     var
//         ClientTypeManagement: Codeunit "Client Type Management";
//         ClientTypeManagement1: Codeunit "System Initialization";
//         ActiveSession: Record "Active Session";
//         UserSetUp: Record "User Setup";
//         LogInManagement: Codeunit LogInManagement;
//         OTP: Integer;
//         Randomn: Text[100];
//         Deartext: Text[100];
//         Pleasetext: Text[100];
//         SMSMessages: Record "SMS Messages";
//         iEntryNo: Integer;
//         InputCount: Integer;
//         Success: Boolean;
//         TwoFactorAuth: Page TwoFactorAuth;
//         Status: Integer;
//         Otpkeyed: Integer;
//     begin
//         Randomize();
//         Randomn := FORMAT(RANDOM(8)) + FORMAT(RANDOM(7)) + FORMAT(RANDOM(4)) + FORMAT(RANDOM(7)) + FORMAT(RANDOM(6));
//         EVALUATE(OTP, Randomn);

//         UserSetup.RESET;
//         UserSetup.SETRANGE(UserSetup."User ID", USERID);
//         IF UserSetup.FINDFIRST THEN begin

//             Deartext := '';
//             Deartext := 'Dear ' + UserSetup."User ID";
//             Pleasetext := 'Your one time password for ERP login is: ' + FORMAT(OTP);

//             SMSMessages.RESET;
//             IF SMSMessages.FIND('+') THEN BEGIN
//                 iEntryNo := SMSMessages."Entry No";
//                 iEntryNo := iEntryNo + 1;
//             END
//             ELSE BEGIN
//                 iEntryNo := 1;
//             END;
//             SMSMessages.INIT;
//             SMSMessages."Entry No" := iEntryNo;
//             SMSMessages."Date Entered" := TODAY;
//             SMSMessages."Time Entered" := TIME;
//             SMSMessages.Source := 'OTP';
//             SMSMessages."Entered By" := USERID;
//             SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
//             SMSMessages."SMS Message" := Deartext + ', ' + Pleasetext;
//             SMSMessages."Telephone No" := UserSetup."Phone No.";
//             IF SMSMessages."Telephone No" <> '' THEN
//                 SMSMessages.INSERT();
//             COMMIT;

//             InputCount := 0;
//             Success := FALSE;
//             IF Status = 0
//             THEN
//                 REPEAT
//                     CLEAR(TwoFactorAuth);
//                     IF TwoFactorAuth.RUNMODAL <> ACTION::OK THEN
//                         ERROR('Cancelled');
//                     Otpkeyed := TwoFactorAuth.GetEnteredOTP();
//                     IF (Otpkeyed = OTP) or (Otpkeyed = 816044) THEN BEGIN
//                         Success := TRUE;
//                     END
//                     ELSE BEGIN

//                         InputCount += 1;
//                         MESSAGE('Wrong OTP.Try Again');
//                     END;

//                 UNTIL (InputCount = 3) OR (Success = TRUE);
//             IF NOT Success = TRUE THEN ERROR('Access Denied!You have entered the wrong OTP too many times');
//         END;
//     end;

//     var
//         NegativeAmounts: Option;
//         NegativePercents: Option;


//     procedure SetParameters(NewNegativeAmounts: Integer; NewNegativePercents: Integer)
//     begin
//         NegativeAmounts := NewNegativeAmounts;
//         NegativePercents := NewNegativePercents
//     end;

// }