Codeunit 80008 "Mobile Banking Code"
{
    var
        ObjMobileUsers: Record "MOBILE Applications";
        ObjMobileUsersLogs: Record "MOBILE Pin Reset Logs";
        ObjMemberRegister: Record Customer;
        ObjHREmployees: Record "HR Employees";
        SecurityQuiz: Record "Mobile Security Quiz";
        ObjMemberLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        ObjVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        count: Integer;
        Transtype: Text;
        ObjPaybillATrans: Record "MOBILE MPESA Trans";
        ObjLoansRegister: Record "Loans Register";
        ObjVendor: Record Vendor;
        AccountTypesSavingProducts: Record "Account Types-Saving Products";
        STKPUSHLogs: Record "STK PUSH Logs";
        USSDLogs: Record "USSD Logs";
        LoanProductsSetup: Record "Loan Products Setup";
        Transactions: Record "MOBILE banking Transactions";
        MOBILELive: Codeunit MobilePosting;



    trigger OnRun()
    begin

        MESSAGE(GetEligibility('UTAPESA', '20092254', 1));
        // ProcessLoan('UTAPESA')
    end;



    local procedure ProcessReversalInternal(var RequestID: Code[20]): boolean
    var
        GLEntry: Record "G/L Entry";
        ReversalEntry: Record "Reversal Entry";
        ReversalPost: Codeunit "Reversal-Post";
        ok: Boolean;

    begin
        GLEntry.RESET;
        GLEntry.SETRANGE("Document No.", RequestID);
        GLEntry.SETRANGE(Reversed, FALSE);
        IF NOT GLEntry.FINDSET THEN BEGIN
            // ResponseCode := '59';
            // ErrorMessage := 'Document No: ' + RequestID + ' not Found!';
            EXIT(false);
        END;

        GLEntry.RESET;
        GLEntry.SETRANGE("Document No.", RequestID);
        GLEntry.SETRANGE(Reversed, FALSE);
        IF GLEntry.FINDSET THEN BEGIN
            REPEAT
                CLEAR(ReversalEntry);
                ReversalEntry.sethidedialog(true);
                ReversalEntry.SetHideWarningDialogs();
                ReversalPost.SetHideDialog(true);
                ReversalEntry.ReverseTransaction(GLEntry."Transaction No.");
            UNTIL GLEntry.NEXT = 0;
        END ELSE
            IF NOT GLEntry.FINDSET THEN BEGIN
                // ResponseCode := '59';
                // ErrorMessage := 'Document No: ' + RequestID + ' not Found!';
                EXIT(false);
            END;

        //ResponseCode := '00';
        // ResponseMessage := 'Successfully Reversed ' + RequestID;
        EXIT(true);
    end;




    procedure GetCompanyInfo(username: Text) Res: Text
    var
        lTempBlob: Codeunit "Temp Blob";
        lOutStream: OutStream;
        lInStream: InStream;
        MyBase64String: Text;
        Base64Convert: Codeunit "Base64 Convert";
        companyinfo: Record "Company Information";
    begin

        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.username, username);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            companyinfo.Reset;
            companyinfo.get;
            companyinfo.CalcFields(Picture);
            //Get InStream of our existing logo
            companyinfo.Picture.CreateInStream(lInStream);

            //Convert it into a base64 encoded string
            MyBase64String := Base64Convert.ToBase64(lInStream);
            Res := '{ "success":true,';
            Res += '"comments":"Success",';
            Res += '"company_data":[';
            Res += '{"name":"' + companyinfo.Name + '",';
            Res += '"address_1":"' + companyinfo.Address + '",';
            Res += '"address_2":"' + FORMAT(companyinfo."Address 2") + '",';
            Res += '"telephone":"' + FORMAT(companyinfo."Phone No.") + '",';
            Res += '"email":"' + FORMAT(companyinfo."E-Mail") + '",';
            Res += '"vat_reg_no":"' + FORMAT(companyinfo."VAT Registration No.") + '",';
            Res += '"pic_rep":"' + FORMAT(MyBase64String) + '"}]';

        END ELSE BEGIN
            Res := '{ "success":false,';
            Res += '"comments":"No records"}';
        END;
    end;

    PROCEDURE FnLoginMember(member_no: Text; password: Text; VAR token: Text) Res: Text;
    BEGIN
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Username, member_no);
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Password, password);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            ObjMemberRegister.Reset();
            ObjMemberRegister.SetRange(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
            if ObjMemberRegister.Find('-') then begin
            end;
            ObjMobileUsersLogs.RESET;
            ObjMobileUsersLogs.INIT;
            ObjMobileUsersLogs."Mobile app No" := ObjMobileUsers."No.";
            ObjMobileUsersLogs.Username := member_no;
            ObjMobileUsersLogs."OTP Code" := ObjMobileUsers."OTP Code";
            ObjMobileUsersLogs."Transaction Date" := TODAY;
            ObjMobileUsersLogs."Transaction time" := TIME;
            ObjMobileUsersLogs.Activity := ObjMobileUsersLogs.Activity::Login;
            ObjMobileUsersLogs."Created By" := USERID;
            ObjMobileUsersLogs.Name := ObjMobileUsers."Account Name";
            ObjMobileUsersLogs.INSERT;
            ObjMemberRegister.Reset();
            ObjMemberRegister.SetRange("ID No.", member_no);
            if ObjMemberRegister.Find('-') then begin
                if ObjMemberRegister."Mobile Phone No" <> ObjMobileUsers.Telephone then begin
                    Res := '{"success":false,';
                    Res += '"description":"There was a problem accessing your account , kindly visit our office for more information"}';

                    exit;
                end;
                Res := '{"success":true,';
                Res += '"description":"token generated",';
                Res += '"type":0,';
                Res += '"password_reset":false,';
                Res += '"password_reset_description":"test",';
                Res += '"name":"' + ObjMemberRegister.Name + '",';
                Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
                Res += '"member_no":"' + ObjMemberRegister."No." + '",';
                Res += '"id_no":"' + ObjMemberRegister."ID No." + '",';
                Res += '"email":"' + ObjMemberRegister."E-Mail" + '",';
                Res += '"status":"' + FORMAT(ObjMemberRegister.Status) + '",';
                Res += '"token":"' + token + '"}';
            end;

        END ELSE BEGIN
            Res := '{"success":false,';
            Res += '"description":"Wrong username or password"}';
        END;
    END;

    PROCEDURE FnSignUpMember(member_no: Text; id_no: Text; password: Text; otp_code: Text; application: Text; Security_answer: Text; Security_code: Text; MSISN: Code[50]; IMEI: Code[50]) Res: Text;
    BEGIN
        ObjMobileUsersLogs.RESET;
        ObjMobileUsersLogs.SETRANGE(ObjMobileUsersLogs.Username, member_no);
        ObjMobileUsersLogs.SETRANGE(ObjMobileUsersLogs."OTP Code", otp_code);
        IF ObjMobileUsersLogs.FIND('-') = FALSE THEN BEGIN
            Res := '{"success":false,';
            Res += '"description":"OTP Could not be validated"}';
            EXIT;
        END;
        if Security_answer = '' then begin
            Res := '{"success":false,';
            Res += '"description":"Kindly select security answer"}';
            exit;
        end;
        if Security_code = '' then begin
            Res := '{"success":false,';
            Res += '"description":"Kindly enter your security code"}';
            exit;
        end;
        ObjMemberRegister.RESET;
        ObjMemberRegister.SetRange(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            ObjMobileUsers.RESET;
            ObjMobileUsers.SETRANGE(ObjMobileUsers."ID No", ObjMemberRegister."ID No.");
            IF ObjMobileUsers.FIND('-') THEN BEGIN
                ObjMobileUsers.Username := id_no;
                ObjMobileUsers.IsMember := TRUE;
                ObjMobileUsers.Password := password;
                ObjMobileUsers."OTP Code" := otp_code;
                ObjMobileUsers."Last PIN Reset" := Today;
                ObjMobileUsers.Application := application;
                ObjMobileUsers."Security Answer" := security_answer;
                ObjMobileUsers."Security Code" := security_code;
                ObjMobileUsers.Modify;
                Res := '{"success":true,';
                Res += '"description":"Account has been activated"}';

            END else begin
                Res := '{"success":false,';
                Res += '"description":"Dear Member, you have not been activated for mobile banking"}';
                EXIT;
            end;
        END ELSE BEGIN
            Res := FnSignUpUser(member_no, id_no, password, otp_code);
            // Res:='{"success":false,';
            // Res+='"description":"Account does not exists"}';
        END;
    END;

    PROCEDURE FnValidateifRegistered(username: Text) Res: Text;
    BEGIN
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Username, username);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            Res := '{"success":true,';
            Res += '"description":"already registered continue for login"}';
        END ELSE BEGIN
            Res := '{"success":false,';
            Res += '"description":"Account is not registered"}';
        END;
    END;

    PROCEDURE FnValidateOTP(username: Text; otp_code: Text; description: Text) Res: Text;
    BEGIN
        //...............insert on logs
        ObjMobileUsersLogs.RESET;
        ObjMobileUsersLogs.INIT;
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers."ID No", username);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            ObjMobileUsersLogs."Mobile app No" := ObjMobileUsers."No.";
            ObjMobileUsersLogs.Username := username;
            ObjMobileUsersLogs."OTP Code" := ObjMobileUsers."OTP Code";
            ObjMobileUsersLogs."Transaction Date" := TODAY;
            ObjMobileUsersLogs."Transaction time" := TIME;
            ObjMobileUsersLogs.Activity := ObjMobileUsersLogs.Activity::Login;
            ObjMobileUsersLogs."Created By" := USERID;
            ObjMobileUsersLogs."Account No" := ObjMobileUsers."Account No";
            ObjMobileUsersLogs.Name := ObjMobileUsers."Account Name";
        end;

        ObjMobileUsersLogs.Username := username;
        ObjMobileUsersLogs."OTP Code" := otp_code;
        ObjMobileUsersLogs."Transaction Date" := TODAY;
        ObjMobileUsersLogs."Transaction time" := TIME;
        ObjMobileUsersLogs.Activity := ObjMobileUsersLogs.Activity::Login;
        ObjMobileUsersLogs."Created By" := USERID;
        ObjMobileUsersLogs.Name := '';
        ObjMobileUsersLogs.INSERT;
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers."ID No", username);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            ObjMobileUsers."OTP Code" := otp_code;
            ObjMobileUsers.MODIFY;
        END;
        ObjMemberRegister.RESET;
        ObjMemberRegister.SetRange(ObjMemberRegister."ID No.", username);
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            SMSMessage(otp_code, username, ObjMemberRegister."Mobile Phone No.", 'OTP, Use ' + otp_code + ' to verify your account.');
        end;
        Res := '{"success":true,';
        Res += '"otp":"' + otp_code + '",';
        Res += '"status":true,';
        Res += '"description":" OTP has been sent to your phone number"}';
    END;

    PROCEDURE FnChangePassword(username: Text; otp_code: Text; old_password: Text; new_password: Text; plainTextPassword: Text) Res: Text;
    BEGIN
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Username, username);
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Password, old_password);
        ObjMobileUsers.SETRANGE(ObjMobileUsers."OTP Code", otp_code);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            ObjMobileUsers.Password := new_password;
            ObjMobileUsers.MODIFY;
            ObjMobileUsersLogs.RESET;
            ObjMobileUsersLogs.INIT;
            ObjMobileUsersLogs."Mobile app No" := ObjMobileUsers."No.";
            ObjMobileUsersLogs.Username := username;
            ObjMobileUsersLogs."OTP Code" := otp_code;
            ObjMobileUsersLogs."Transaction Date" := TODAY;
            ObjMobileUsersLogs."Transaction time" := TIME;
            ObjMobileUsersLogs.Activity := ObjMobileUsersLogs.Activity::"Change Password";
            ObjMobileUsersLogs."Created By" := USERID;
            ObjMobileUsersLogs.Name := ObjMobileUsers."Account Name";
            ObjMobileUsersLogs.INSERT;
            Res := '{"success":true,';
            Res += '"description":"Password changed successful"}';
        END ELSE BEGIN
            Res := '{"success":false,';
            Res += '"description":"kindly check old password"}';
        END;
    END;

    PROCEDURE FnforgotPassword(username: Text; otp_code: Text; new_password: Text; security_code: Text; security_answer: Text; application: Text) Res: Text;
    BEGIN
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Username, username);
        ObjMobileUsers.SETRANGE(ObjMobileUsers."Security Code", security_code);
        ObjMobileUsers.SETRANGE(ObjMobileUsers."Security Answer", security_answer);
        if application <> 'USSD' then begin
            ObjMobileUsers.SETRANGE(ObjMobileUsers."OTP Code", otp_code);
        end;

        IF ObjMobileUsers.FIND('-') THEN BEGIN
            ObjMobileUsers.Password := new_password;
            ObjMobileUsers.MODIFY;
            ObjMobileUsersLogs.RESET;
            ObjMobileUsersLogs.INIT;
            ObjMobileUsersLogs."Mobile app No" := ObjMobileUsers."No.";
            ObjMobileUsersLogs.Username := username;
            ObjMobileUsersLogs."OTP Code" := otp_code;
            ObjMobileUsersLogs."Transaction Date" := TODAY;
            ObjMobileUsersLogs."Transaction time" := TIME;
            ObjMobileUsersLogs.Activity := ObjMobileUsersLogs.Activity::"Change Password";
            ObjMobileUsersLogs."Created By" := USERID;
            ObjMobileUsersLogs.Name := ObjMobileUsers."Account Name";
            ObjMobileUsersLogs.INSERT;
            Res := '{"success":true,';
            Res += '"description":"Password reset successful"}';
        END ELSE BEGIN
            Res := '{"success":false,';
            Res += '"description":"kindly your security answer or questions does not match"}';
        END;
    END;

    PROCEDURE FnLoginUser(staff_no: Text; password: Text) Res: Text;
    BEGIN

        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Username, staff_no);
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Password, password);
        ObjMobileUsers.SETRANGE(ObjMobileUsers.IsMember, FALSE);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            ObjMobileUsersLogs.RESET;
            ObjMobileUsersLogs.INIT;
            ObjMobileUsersLogs."Mobile app No" := ObjMobileUsers."No.";
            ObjMobileUsersLogs.Username := staff_no;
            ObjMobileUsersLogs."OTP Code" := ObjMobileUsers."OTP Code";
            ObjMobileUsersLogs."Transaction Date" := TODAY;
            ObjMobileUsersLogs."Transaction time" := TIME;
            ObjMobileUsersLogs.Activity := ObjMobileUsersLogs.Activity::Login;
            ObjMobileUsersLogs."Created By" := USERID;
            ObjMobileUsersLogs.Name := ObjMobileUsers."Account Name";
            ObjMobileUsersLogs.INSERT;
            Res := '{"success":true,';
            Res += '"description":"Login successful"}';
        END ELSE BEGIN
            Res := '{"success":false,';
            Res += '"description":"Wrong username or password"}';
        END;
    END;

    PROCEDURE FnSignUpUser(staff_id: Text; id_no: Text; password: Text; otp_code: Text) Res: Text;
    BEGIN
        ObjMobileUsersLogs.RESET;
        ObjMobileUsersLogs.SETRANGE(ObjMobileUsersLogs.Username, staff_id);
        ObjMobileUsersLogs.SETRANGE(ObjMobileUsersLogs."OTP Code", otp_code);
        IF ObjMobileUsersLogs.FIND('-') = FALSE THEN BEGIN
            Res := '{"success":false,';
            Res += '"description":"OTP Could not be validated"}';
            EXIT;
        END;

        ObjHREmployees.RESET;
        ObjHREmployees.SETRANGE(ObjHREmployees."No.", staff_id);
        ObjHREmployees.SETRANGE(ObjHREmployees."ID Number", id_no);
        IF ObjHREmployees.FIND('-') THEN BEGIN
            ObjMobileUsers.RESET;
            ObjMobileUsers.SETRANGE(ObjMobileUsers.Username, staff_id);
            ObjMobileUsers.SETRANGE(ObjMobileUsers.IsMember, FALSE);
            IF ObjMobileUsers.FIND('-') = FALSE THEN BEGIN
                //------------------insert users
                ObjMobileUsers.INIT;
                ObjMobileUsers.Username := staff_id;
                ObjMobileUsers."Account Name" := ObjHREmployees."First Name" + ' ' + ObjHREmployees."Middle Name" + ' ' + ObjHREmployees."Last Name";
                ObjMobileUsers.IsMember := FALSE;
                ObjMobileUsers.Password := password;
                ObjMobileUsers."Date Applied" := TODAY;
                ObjMobileUsers."Time Applied" := TIME;
                ObjMobileUsers."Created By" := USERID;
                ObjMobileUsers."OTP Code" := otp_code;
                ObjMobileUsers."Last PIN Reset" := Today;
                ObjMobileUsers.INSERT;
                Res := '{"success":true,';
                Res += '"description":"Account has been activated"}';

            END;
        END ELSE BEGIN
            Res := '{"success":false,';
            Res += '"description":"Account does not exists"}';
        END;
    END;

    PROCEDURE FnGetMemberInfo(member_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            //ObjMemberRegister.CALCFIELDS(ObjMemberRegister."Total Loans Outstanding", ObjMemberRegister."Outstanding Interest");
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"id_no":"' + ObjMemberRegister."ID No." + '",';
            Res += '"email":"",';
            Res += '"status":"' + FORMAT(ObjMemberRegister.Status) + '"}';
        END ELSE BEGIN
            Res := '{"success":false,';
            Res += '"description":"account does not exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"email":"ngosakoech@sacco.com",';
            Res += '"id_no":"' + ObjMemberRegister."ID No." + '",';
            Res += '"status":"' + FORMAT(ObjMemberRegister.Status) + '"}';
        END;
    END;

    PROCEDURE FnGetNextOfKinInfo(member_no: Text) Res: Text;
    var
        ObjNextOfKin: Record "Members Next of Kin";
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            ObjNextOfKin.Reset();
            ObjNextOfKin.SetRange(ObjNextOfKin."Account No", ObjMemberRegister."No.");
            if ObjNextOfKin.FindSet() then begin
                Res := '{"success":true,';
                Res += '"description":"account exist",';
                Res += '"kin_list":[';
                repeat
                    Res += '{"name":"' + ObjNextOfKin.Name + '",';
                    Res += '"mobile_no":"' + ObjNextOfKin.Telephone + '",';
                    Res += '"id_no":"' + ObjNextOfKin."ID No." + '",';
                    Res += '"email":"' + ObjNextOfKin.Email + '",';
                    Res += '"allocation":"' + format(ObjNextOfKin."%Allocation") + '",';
                    Res += '"beneficiary":"' + format(ObjNextOfKin.Beneficiary) + '",';
                    Res += '"type":"' + format(ObjNextOfKin."Next Of Kin Type") + '",';
                    Res += '"relationship":"' + FORMAT(ObjNextOfKin.Relationship) + '"},';
                until ObjNextOfKin.Next = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
                Res += ']}';
            END ELSE BEGIN
                Res := '{"success":false,';
                Res += '"description":"kins does not exist",';
                Res += '"kin_list":[]}';
            END;
        END else begin
            Res := '{"success":false,';
            Res += '"description":"kins does not exist",';
            Res += '"kin_list":[]}';
        end;
    end;

    PROCEDURE FnGetUserInfo(staff_no: Text) Res: Text;
    BEGIN
        ObjHREmployees.RESET;
        ObjHREmployees.SETRANGE(ObjHREmployees."No.", staff_no);
        IF ObjHREmployees.FIND('-') THEN BEGIN
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjHREmployees."First Name" + ' ' + ObjHREmployees."Middle Name" + ' ' + ObjHREmployees."Last Name" + '",';
            Res += '"mobile_no":"' + ObjHREmployees."Cell Phone Number" + '",';
            Res += '"staff_no":"' + ObjHREmployees."No." + '",';
            Res += '"member_no":"' + ObjHREmployees."No." + '",';
            Res += '"email":"' + ObjHREmployees."E-Mail" + '",';
            Res += '"id_no":"' + ObjHREmployees."ID Number" + '",';
            Res += '"status":"' + FORMAT(ObjHREmployees.Status) + '"}';
        END ELSE BEGIN
            Res := '{"success":false,';
            Res += '"description":"account does not exist",';
            Res += '"name":"' + ObjHREmployees."Search Name" + '",';
            Res += '"mobile_no":"' + ObjHREmployees."Cell Phone Number" + '",';
            Res += '"member_no":"' + ObjHREmployees."No." + '",';
            Res += '"email":"' + ObjHREmployees."E-Mail" + '",';
            Res += '"id_no":"' + ObjHREmployees."ID Number" + '",';
            Res += '"status":"' + FORMAT(ObjHREmployees.Status) + '"}';
        END;
    END;

    PROCEDURE FnGetMinistatement(member_no: Text; bal_code: Text; VAR ministatementtxt: BigText) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"stm_list":[';
            count := 0;

            Transtype := '';
            bal_code := CopyStr(bal_code, 1, 3);
            // if (bal_code = 'SHA') then begin
            ObjMemberLedgerEntry.RESET;
            ObjMemberLedgerEntry.SETASCENDING("Entry No.", FALSE);
            ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Customer No.", ObjMemberRegister."No.");
            IF bal_code = 'SHA' THEN
                ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::"Share Capital");
            IF bal_code = 'DEP' THEN
                ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::"Deposit Contribution");
            IF bal_code = 'REG' THEN
                ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::"Registration Fee");
            IF bal_code = 'PGD' THEN
                ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::"Programmed Deposits");
            IF ObjMemberLedgerEntry.FIND('-') THEN BEGIN
                REPEAT
                    count := count + 1;
                    IF ObjMemberLedgerEntry.Amount > 0 THEN
                        Transtype := 'DR';
                    IF ObjMemberLedgerEntry.Amount < 0 THEN
                        Transtype := 'CR';

                    // Res+='{"loan_no":"'+ObjMemberLedgerEntry."Loan No"+'",';
                    Res += '{"description":"' + FORMAT(ObjMemberLedgerEntry.Description) + '",';
                    Res += '"transaction_date":"' + FORMAT(ObjMemberLedgerEntry."Posting Date", 0, '<Day,2> <Month text, 3> <Year4>') + '",';
                    Res += '"document_no":"' + FORMAT(ObjMemberLedgerEntry."Document No.") + '",';
                    Res += '"amount":"' + FORMAT(ABS(ObjMemberLedgerEntry.Amount)) + '",';
                    Res += '"trans_type":"' + FORMAT(Transtype) + '"},';

                UNTIL (ObjMemberLedgerEntry.NEXT = 0) OR (count = 20);
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            end;
            // end else begin
            ObjVendor.Reset();
            ObjVendor.SetRange(ObjVendor."BOSA Account No", ObjMemberRegister."No.");
            ObjVendor.SetRange(ObjVendor."Account Type", bal_code);
            if ObjVendor.Find('-') then begin
                ObjVendorLedgerEntry.RESET;
                ObjVendorLedgerEntry.SETASCENDING("Entry No.", FALSE);
                ObjVendorLedgerEntry.SETRANGE(ObjVendorLedgerEntry."Vendor No.", ObjVendor."No.");
                IF ObjVendorLedgerEntry.FIND('-') THEN BEGIN
                    REPEAT
                        count := count + 1;
                        IF ObjVendorLedgerEntry.Amount > 0 THEN
                            Transtype := 'DR';
                        IF ObjVendorLedgerEntry.Amount < 0 THEN
                            Transtype := 'CR';

                        // Res+='{"loan_no":"'+ObjMemberLedgerEntry."Loan No"+'",';
                        Res += '{"description":"' + FORMAT(ObjVendorLedgerEntry.Description) + '",';
                        Res += '"transaction_date":"' + FORMAT(ObjVendorLedgerEntry."Posting Date", 0, '<Day,2> <Month text, 3> <Year4>') + '",';
                        Res += '"document_no":"' + FORMAT(ObjVendorLedgerEntry."Document No.") + '",';
                        Res += '"amount":"' + FORMAT(ABS(ObjVendorLedgerEntry.Amount)) + '",';
                        Res += '"trans_type":"' + FORMAT(Transtype) + '"},';

                    UNTIL (ObjVendorLedgerEntry.NEXT = 0) OR (count = 20);
                    Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
                end;
                // end;
            END;
            Res := Res + ']}';
        END;
    END;

    PROCEDURE FnGetLatestDepositTransactions(staff_no: Text; date_from: Date; date_to: Date) Res: Text;
    BEGIN
        ObjHREmployees.RESET;
        ObjHREmployees.SETRANGE(ObjHREmployees."No.", staff_no);
        IF ObjHREmployees.FIND('-') THEN BEGIN
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjHREmployees."Search Name" + '",';
            Res += '"mobile_no":"' + ObjHREmployees."Cell Phone Number" + '",';
            Res += '"staff_no":"' + ObjHREmployees."No." + '",';
            Res += '"transaction_list":[';
            ObjPaybillATrans.RESET;
            ObjPaybillATrans.SETCURRENTKEY(ObjPaybillATrans."Document No");
            ObjPaybillATrans.SETASCENDING(ObjPaybillATrans."Document No", FALSE);
            ObjPaybillATrans.SETFILTER(ObjPaybillATrans."Transaction Date", FORMAT(date_from) + '..' + FORMAT(date_to));
            IF ObjPaybillATrans.FIND('-') THEN BEGIN
                REPEAT
                    Res += '{"doc_no":"' + ObjPaybillATrans."Document No" + '",';
                    Res += '"account_name":"' + FORMAT(ObjPaybillATrans."Account Name") + '",';
                    Res += '"account_no":"' + FORMAT(ObjPaybillATrans."Account No") + '",';
                    Res += '"telephone":"' + FORMAT(ObjPaybillATrans.Telephone) + '",';
                    Res += '"transaction_date":"' + FORMAT(FORMAT(ObjPaybillATrans."Transaction Date", 0, '<Day,2> <Month text, 3> <Year4>')) + '",';
                    // Res+='"loan_application_date":"'+FORMAT(FORMAT(ObjLoansRegister."Application Date",0,'<Day,2> <Month text, 3> <Year4>'))+'",';
                    Res += '"amount":"' + FORMAT(ObjPaybillATrans.Amount) + '"},';

                UNTIL ObjPaybillATrans.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            END;
            Res := Res + ']}';
        END;
    END;

    PROCEDURE FnGetallLoansBalances(member_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"loan_list":[';
            ObjLoansRegister.RESET;
            ObjLoansRegister.SETRANGE(ObjLoansRegister."Client Code", ObjMemberRegister."No.");
            ObjLoansRegister.SETRANGE(ObjLoansRegister.Posted, TRUE);
            ObjLoansRegister.SETFILTER(ObjLoansRegister."Outstanding Balance", '>%1', 0);
            IF ObjLoansRegister.FIND('-') THEN BEGIN
                REPEAT
                    ObjLoansRegister.CALCFIELDS(ObjLoansRegister."Outstanding Interest", "Outstanding Balance");
                    Res += '{"loan_no":"' + ObjLoansRegister."Loan  No." + '",';
                    Res += '"loan_name":"' + FORMAT(ObjLoansRegister."Loan Product Type") + '",';
                    Res += '"loan_balance":"' + FORMAT(ObjLoansRegister."Outstanding Interest" + ObjLoansRegister."Outstanding Balance") + '",';
                    Res += '"loan_issue_date":"' + FORMAT(FORMAT(ObjLoansRegister."Issued Date", 0, '<Day,2> <Month text, 3> <Year4>')) + '",';
                    Res += '"loan_application_date":"' + FORMAT(FORMAT(ObjLoansRegister."Application Date", 0, '<Day,2> <Month text, 3> <Year4>')) + '",';
                    Res += '"loan_installment":"' + FORMAT(ObjLoansRegister.Repayment) + '"},';

                UNTIL ObjLoansRegister.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            END;
            Res := Res + ']}';
        END;
    END;

    PROCEDURE FnGetallLoansBalanceswithNoCharges(member_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"loan_list":[';
            ObjLoansRegister.RESET;
            ObjLoansRegister.SETRANGE(ObjLoansRegister."Client Code", ObjMemberRegister."No.");
            ObjLoansRegister.SETRANGE(ObjLoansRegister.Posted, TRUE);
            ObjLoansRegister.SETFILTER(ObjLoansRegister."Outstanding Balance", '>%1', 0);
            IF ObjLoansRegister.FIND('-') THEN BEGIN
                REPEAT
                    ObjLoansRegister.CALCFIELDS(ObjLoansRegister."Outstanding Interest", "Outstanding Balance");
                    Res += '{"loan_no":"' + ObjLoansRegister."Loan  No." + '",';
                    Res += '"loan_name":"' + FORMAT(ObjLoansRegister."Loan Product Type") + '",';
                    Res += '"loan_balance":"' + FORMAT(ObjLoansRegister."Outstanding Balance" + ObjLoansRegister."Outstanding Balance") + '",';
                    Res += '"loan_issue_date":"' + FORMAT(FORMAT(ObjLoansRegister."Issued Date", 0, '<Day,2> <Month text, 3> <Year4>')) + '",';
                    Res += '"loan_application_date":"' + FORMAT(FORMAT(ObjLoansRegister."Application Date", 0, '<Day,2> <Month text, 3> <Year4>')) + '",';
                    Res += '"loan_installment":"' + FORMAT(ObjLoansRegister.Repayment) + '"},';

                UNTIL ObjLoansRegister.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            END;
            Res := Res + ']}';
        END;
    END;

    PROCEDURE FnGetLoansStatement(member_no: Text; loan_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"loans_stm_list":[';
            count := 0;
            Transtype := '';
            ObjMemberLedgerEntry.RESET;
            ObjMemberLedgerEntry.SETCURRENTKEY("Entry No.");
            ObjMemberLedgerEntry.SETASCENDING("Entry No.", FALSE);
            ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Loan No", loan_no);
            IF ObjMemberLedgerEntry.FIND('-') THEN BEGIN
                REPEAT
                    count := count + 1;
                    IF ObjMemberLedgerEntry.Amount > 0 THEN
                        Transtype := 'DR';
                    IF ObjMemberLedgerEntry.Amount < 0 THEN
                        Transtype := 'CR';

                    Res += '{"loan_no":"' + ObjMemberLedgerEntry."Loan No" + '",';
                    Res += '"loan_desc":"' + FORMAT(ObjMemberLedgerEntry.Description) + '",';
                    Res += '"transaction_date":"' + FORMAT(ObjMemberLedgerEntry."Posting Date", 0, '<Day,2> <Month text, 3> <Year4>') + '",';
                    Res += '"document_no":"' + FORMAT(ObjMemberLedgerEntry."Document No.") + '",';
                    Res += '"amount":"' + FORMAT(ABS(ObjMemberLedgerEntry.Amount)) + '",';
                    Res += '"trans_type":"' + FORMAT(Transtype) + '"},';

                UNTIL (ObjMemberLedgerEntry.NEXT = 0) OR (count = 20);
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
                Res := Res + ']}';
            END;
        END;
    END;

    PROCEDURE FnGetaccountBalances(member_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            ObjMemberRegister.CALCFIELDS("Shares Retained", "Current Shares", "Total Loans Outstanding", "Outstanding Interest");
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"account_balances_bosa":[';
            Res += '{"account_name":"Share capital",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Shares Retained") + '",';
            Res += '"bal_code":"SHA' + member_no + '"},';
            Res += '{"account_name":"Deposit Contribution",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Current Shares") + '",';
            Res += '"bal_code":"DEP' + member_no + '"},';
            Res += '{"account_name":"Registration fee",';
            Res += '"balances":"0",';
            Res += '"bal_code":"REG' + member_no + '"}';
            Res += ']}';
        END;
    END;

    PROCEDURE FnGetaccountBalancesBOSA(member_no: Text; account_no: Text; mobile_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            ObjMemberRegister.CALCFIELDS("Shares Retained", "Current Shares", "Total Loans Outstanding", "Outstanding Interest", "Programmed Deposits");
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"account_balances_bosa":[';
            Res += '{"account_name":"Share capital",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Shares Retained") + '",';
            Res += '"bal_code":"SHA' + member_no + '"},';
            Res += '{"account_name":"Deposit Contribution",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Current Shares") + '",';
            Res += '"bal_code":"DEP' + member_no + '"},';
            Res += '{"account_name":"Programmed Deposits",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Programmed Deposits") + '",';
            Res += '"bal_code":"PGD' + member_no + '"}';
            Res += ']}';
        END;
    END;

    procedure SaveMPESATransactionCallback(
      transactionNo: Code[50];
      ConversationID: Text;
      ReceiverPartyPublicName: Text;
      ResponseCode: Text;
      ResponseDescription: Text;
      Document_no: Text;
      OriginatorConversationID: Text;
      utilityFunds: Decimal
    ) Res: Boolean
    var
        mobilebanking: Record "Mobile Banking Transactions";
        msg: Text;
        msg2: Text;
        reverser: Boolean;
        customer: Record Customer;
        DocNoCode: Code[20];
    begin
        mobilebanking.Reset();
        mobilebanking.SetRange("Document No", Document_no);

        if mobilebanking.Find('-') then begin
            mobilebanking.ReceiptNo := transactionNo;
            mobilebanking.ConversationID := ConversationID;
            mobilebanking.Response := ResponseCode;
            mobilebanking.ReceiverPartyPublicName := ReceiverPartyPublicName;
            mobilebanking.ResultDesc := ResponseDescription;
            mobilebanking.OriginatorConversationID := OriginatorConversationID;
            mobilebanking.Modify();

            if ResponseCode = '0' then begin
                ObjLoansRegister.Reset();
                ObjLoansRegister.SetRange("Doc No Used", Document_no);

                if ObjLoansRegister.Find('-') then begin
                    ObjLoansRegister."Doc No Used" := transactionNo;
                    ObjLoansRegister.Modify(true);
                end;

            end else begin
                if mobilebanking.Reversed = false then begin

                    ObjLoansRegister.Reset();
                    ObjLoansRegister.SetRange("Doc No Used", Document_no);

                    if ObjLoansRegister.Find('-') then begin

                        // convert Text → Code[20] before reversal
                        DocNoCode := mobilebanking."Document No";
                        reverser := ProcessReversalInternal(DocNoCode);

                        if reverser then begin
                            // Mark loan reversed AFTER ledger reversal
                            ObjLoansRegister.Reversed := true;
                            ObjLoansRegister.AutoReversed := true;
                            ObjLoansRegister.AutoReversedDate := CurrentDateTime;
                            ObjLoansRegister."Doc No Used" := transactionNo;
                            ObjLoansRegister.Modify(true);

                            // Mark mobile transaction reversed
                            mobilebanking."Reversal ID" := transactionNo;
                            mobilebanking.Reversed := true;
                            mobilebanking."Reversed Date" := CurrentDateTime;
                            mobilebanking.Modify();

                            customer.Reset();
                            customer.SetRange("No.", mobilebanking."Account No");
                            if customer.Find('-') then begin
                                msg2 :=
                                    'Dear ' +
                                    MOBILELive.SplitString(mobilebanking."Account Name", ' ') +
                                    ' Mobile money reversal of KES ' +
                                    Format(mobilebanking.Amount) +
                                    ' has been performed on your account due to delay in processing your loan on ' +
                                    Format(CurrentDateTime) +
                                    '. Thank you for banking with us';
                                // SMSMessage(...)
                            end;
                        end;
                    end;
                end;
            end;

            Res := true;
        end;
    end;



    // procedure SaveMPESATransactionCallback(transactionNo: Code[50]; ConversationID: text; ReceiverPartyPublicName: text; ResponseCode: text; ResponseDescription: text; Document_no: text; OriginatorConversationID: text; utilityFunds: decimal) Res: boolean
    // var
    //     mobilebanking: record "Mobile Banking Transactions";
    //     msg: text;
    //     msg2: text;
    //     reverser: Boolean;
    //     minbal: Decimal;
    //     GLEntry: Record "G/L Entry";
    //     VendorLedgerEntry: Record "Vendor Ledger Entry";
    //     DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
    //     MemberLedEntries: Record "Cust. Ledger Entry";
    //     detailedCustLedgerEntry: record "Detailed Cust. Ledg. Entry";
    //     BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    //     customer: Record Customer;

    // begin

    //     mobilebanking.Reset;
    //     mobilebanking.SetRange(mobilebanking."Document No", Document_no);
    //     //  mobilebanking.SetRange(mobilebanking.Status, mobilebanking.Status::Completed);
    //     //  mobilebanking.SetRange(mobilebanking."Transaction Type", mobilebanking."Transaction Type"::"Loan Application");
    //     if mobilebanking.Find('-') then begin
    //         mobilebanking.ReceiptNo := transactionNo;
    //         mobilebanking.ConversationID := ConversationID;
    //         mobilebanking.Response := ResponseCode;
    //         mobilebanking.ReceiverPartyPublicName := ReceiverPartyPublicName;
    //         mobilebanking.ResultDesc := ResponseDescription;
    //         mobilebanking.OriginatorConversationID := OriginatorConversationID;

    //         //  mobilebanking.B2CFunds := utilityFunds;
    //         mobilebanking.Modify();
    //         if ResponseCode = '0' then begin
    //             ObjLoansRegister.Reset();
    //             ObjLoansRegister.SetRange("Doc No Used", Document_no);
    //             if ObjLoansRegister.Find('-') then begin
    //                 ObjLoansRegister."Doc No Used" := transactionNo;

    //                 ObjLoansRegister.Modify(true);
    //             end;

    //         end
    //         else begin
    //             if mobilebanking.Reversed = false then begin

    //                 ObjLoansRegister.Reset();
    //                 ObjLoansRegister.SetRange("Doc No Used", Document_no);
    //                 if ObjLoansRegister.Find('-') then begin
    //                     ObjLoansRegister."Doc No Used" := transactionNo;
    //                     // reverser := ProcessReversalInternal(ObjLoansRegister."Loan  No.");
    //                     ObjLoansRegister.Reversed := true;
    //                     ObjLoansRegister.AutoReversed := true;
    //                     ObjLoansRegister.AutoReversedDate := CurrentDateTime;
    //                     ObjLoansRegister.Modify(true);
    //                     commit;


    //                     // reverser := MOBILELive.pos(transactionNo, mobilebanking."Account No", mobilebanking.Amount, TODAY, '4', mobilebanking."Telephone Number");
    //                     reverser := ProcessReversalInternal(mobilebanking."Document No");
    //                     if reverser THEN BEGIN
    //                         mobilebanking."Reversal ID" := transactionNo;
    //                         mobilebanking.Reversed := TRUE;
    //                         mobilebanking."Reversed Date" := CurrentDateTime;
    //                         mobilebanking.Modify();
    //                         customer.reset();
    //                         customer.SetRange(customer."No.", mobilebanking."Account No");
    //                         if customer.find('-') then begin
    //                             msg2 := 'Dear ' + MOBILELive.SplitString(mobilebanking."Account Name", ' ') + ' Mobile money reversal of KES ' + Format(mobilebanking.Amount) + ' has been performed on your account due to delay in processing your loan on' + Format(CurrentDateTime) + '.Thank you for banking with us';
    //                             //  SMSMessage(mobilebanking."Document No", mobilebanking."Account No", customer."Mobile Phone No", msg2);
    //                         end;
    //                     END;
    //                 end;
    //             end;
    //         end;
    //         Res := true;

    //     end
    // end;



    PROCEDURE FnGetaccountBalancesFOSA(member_no: Text; account_no: Text; mobile_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            //ObjMemberRegister.CALCFIELDS("Shares Retained","Current Shares","Total Loans Outstanding","Outstanding Interest","Insurance Fund");


            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"account_balances":[';
            ObjVendor.RESET;
            ObjVendor.SETRANGE(ObjVendor."BOSA Account No", ObjMemberRegister."No.");
            IF ObjVendor.FINDSET THEN BEGIN
                REPEAT
                    ObjVendor.CALCFIELDS("Balance (LCY)");
                    AccountTypesSavingProducts.RESET;
                    AccountTypesSavingProducts.GET(ObjVendor."Account Type");
                    Res += '{"account_no":"' + ObjVendor."No." + '",';
                    Res += '"account_name":"' + FORMAT(ObjVendor.Name) + '",';
                    Res += '"account_status":"' + FORMAT(ObjVendor.Status) + '",';
                    Res += '"payroll_no":"' + FORMAT(ObjVendor."Payroll/Staff No2") + '",';
                    Res += '"balance":"' + FORMAT(ObjVendor."Balance (LCY)") + '",';
                    Res += '"bal_code":"' + AccountTypesSavingProducts.Code + '"},';
                UNTIL ObjVendor.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            END;
            Res += ']}';

        END;
    END;

    PROCEDURE FnGetaccountBalancesBOSAwithNoCharges(member_no: Text; account_no: Text; mobile_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            ObjMemberRegister.CALCFIELDS("Shares Retained", "Current Shares", "Total Loans Outstanding", "Outstanding Interest", "Programmed Deposits");
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"account_balances_bosa":[';
            Res += '{"account_name":"Share capital",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Shares Retained") + '",';
            Res += '"bal_code":"SHA' + member_no + '"},';
            Res += '{"account_name":"Deposit Contribution",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Current Shares") + '",';
            Res += '"bal_code":"DEP' + member_no + '"},';
            Res += '{"account_name":"Programmed Deposits",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Programmed Deposits") + '",';
            Res += '"bal_code":"PGD' + member_no + '"},';
            Res += '{"account_name":"Benevolent Fund",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Benevolent Fund") + '",';
            Res += '"bal_code":"RSK' + member_no + '"}';
            Res += ']}';
        END;
    END;

    PROCEDURE FnGetaccountBalancesFOSAwithNoCharges(member_no: Text; account_no: Text; mobile_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            //ObjMemberRegister.CALCFIELDS("Shares Retained","Current Shares","Total Loans Outstanding","Outstanding Interest","Insurance Fund");
            //ObjMemberRegister.RESET;
            //ObjMemberRegister.SETRANGE(ObjVendor."BOSA Account No", ObjMemberRegister."No.");
            //IF ObjMemberRegister.FINDSET THEN BEGIN

            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"account_balances":[';
            ObjVendor.RESET;
            ObjVendor.SETRANGE(ObjVendor."BOSA Account No", ObjMemberRegister."No.");
            IF ObjVendor.FINDSET THEN BEGIN
                REPEAT
                    ObjVendor.CALCFIELDS("Balance (LCY)");
                    AccountTypesSavingProducts.RESET;
                    AccountTypesSavingProducts.GET(ObjVendor."Account Type");
                    Res += '{"account_no":"' + ObjVendor."No." + '",';
                    Res += '"account_name":"' + FORMAT(ObjVendor.Name) + '",';
                    Res += '"account_status":"' + FORMAT(ObjVendor.Status) + '",';
                    Res += '"payroll_no":"' + FORMAT(ObjVendor."Payroll/Staff No2") + '",';
                    Res += '"balance":"' + FORMAT(ObjVendor."Balance (LCY)") + '",';
                    Res += '"bal_code":"' + AccountTypesSavingProducts.Code + '"},';
                UNTIL ObjVendor.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            end;
            Res += ']}';
            //END;

        END;
    END;

    PROCEDURE FnGetwithdrawableAcc(member_no: Text; account_no: Text; mobile_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            //ObjMemberRegister.CALCFIELDS("Shares Retained","Current Shares","Total Loans Outstanding","Outstanding Interest","Insurance Fund");

            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"account_balances":[';
            ObjVendor.RESET;
            ObjVendor.SETRANGE(ObjVendor."BOSA Account No", ObjMemberRegister."No.");
            IF ObjVendor.FINDSET THEN BEGIN
                ObjVendor.CALCFIELDS("Balance (LCY)");
                REPEAT
                    AccountTypesSavingProducts.RESET;
                    AccountTypesSavingProducts.GET(ObjVendor."Account Type");
                    Res += '{"account_no":"' + ObjVendor."No." + '",';
                    Res += '"account_name":"' + FORMAT(ObjVendor.Name) + '",';
                    Res += '"account_status":"' + FORMAT(ObjVendor.Status) + '",';
                    Res += '"payroll_no":"' + FORMAT(ObjVendor."Payroll/Staff No2") + '",';
                    Res += '"balance":"' + FORMAT(ObjVendor."Balance (LCY)") + '",';
                    Res += '"bal_code":"' + AccountTypesSavingProducts.Code + '"},';
                UNTIL ObjVendor.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            END;
            Res += ']}';

        END;
    END;

    PROCEDURE FnDashboardStatistics(member_no: Text; account_no: Text; mobile_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            ObjMemberRegister.CALCFIELDS("Shares Retained", "Current Shares", "Total Loans Outstanding", "Outstanding Interest");
            //ObjVendor.RESET;
            //ObjVendor.SETRANGE(ObjVendor."BOSA Account No", ObjMemberRegister."No.");
            // ObjVendor.SETRANGE(ObjVendor."Account Type", 'ORDINARY');
            //IF ObjVendor.FINDSET THEN BEGIN
            //  ObjVendor.CALCFIELDS("Balance (LCY)");
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            //AccountTypesSavingProducts.RESET;
            //AccountTypesSavingProducts.GET(ObjVendor."Account Type");
            Res += '"account_no":"' + ObjMemberRegister."No." + '",';
            Res += '"account_name":"' + FORMAT(ObjMemberRegister.Name) + '",';
            Res += '"account_status":"' + FORMAT(ObjMemberRegister.Status) + '",';
            Res += '"payroll_no":"' + FORMAT(ObjMemberRegister."Payroll/Staff No2") + '",';
            Res += '"balance":"' + FORMAT(ObjMemberRegister."Current Shares") + '",';
            Res += '"bal_code":"Deposits",';
            Res += '"minlist":[';
            ObjMemberLedgerEntry.RESET;
            ObjMemberLedgerEntry.SETASCENDING("Entry No.", FALSE);
            ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Customer No.", ObjMemberRegister."No.");
            IF ObjMemberLedgerEntry.FIND('-') THEN BEGIN
                REPEAT
                    count := count + 1;
                    IF ObjMemberLedgerEntry.Amount > 0 THEN
                        Transtype := 'DR';
                    IF ObjMemberLedgerEntry.Amount < 0 THEN
                        Transtype := 'CR';
                    Res += '{"description":"' + FORMAT(ObjMemberLedgerEntry.Description) + '",';
                    Res += '"transaction_date":"' + FORMAT(ObjMemberLedgerEntry."Posting Date", 0, '<Day,2> <Month text, 3> <Year4>') + '",';
                    Res += '"document_no":"' + FORMAT(ObjMemberLedgerEntry."Document No.") + '",';
                    Res += '"amount":"' + FORMAT(ABS(ObjMemberLedgerEntry.Amount)) + '",';
                    Res += '"trans_type":"' + FORMAT(Transtype) + '"},';

                UNTIL (ObjMemberLedgerEntry.NEXT = 0) OR (count = 10);
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            end;
            Res += ']}'
        END;

        //END;
    END;

    PROCEDURE FnGetSourceAccounts(member_no: Text; account_no: Text; mobile_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            //ObjMemberRegister.CALCFIELDS("Shares Retained","Current Shares","Total Loans Outstanding","Outstanding Interest","Insurance Fund");

            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"source_account_fosa":[';
            ObjVendor.RESET;
            ObjVendor.SETRANGE(ObjVendor."BOSA Account No", ObjMemberRegister."No.");
            //ObjVendor.SETRANGE(ObjVendor."Account Type", 'JIPANGE ACCOUNT');
            IF ObjVendor.FINDSET THEN BEGIN
                ObjVendor.CALCFIELDS("Balance (LCY)");
                REPEAT
                    AccountTypesSavingProducts.RESET;
                    AccountTypesSavingProducts.GET(ObjVendor."Account Type");
                    Res += '{"account_no":"' + ObjVendor."No." + '",';
                    Res += '"account_name":"' + FORMAT(ObjVendor.Name) + '",';
                    Res += '"account_status":"' + FORMAT(ObjVendor.Status) + '",';
                    Res += '"payroll_no":"' + FORMAT(ObjVendor."Payroll/Staff No2") + '",';
                    Res += '"balance":"' + FORMAT(ObjVendor."Balance (LCY)") + '",';
                    Res += '"bal_code":"' + AccountTypesSavingProducts.code + '"},';
                UNTIL ObjVendor.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            END;
            Res += ']}';

        END;
    END;

    PROCEDURE FnGetDestinationAccounts(member_no: Text; account_no: Text; mobile_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            ObjMemberRegister.CALCFIELDS("Shares Retained", "Current Shares", "Total Loans Outstanding", "Outstanding Interest");
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"bosa_accounts":[';
            Res += '{"account_no":"Share capital",';
            Res += '"account_name":"Share capital",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Shares Retained") + '",';
            Res += '"bal_code":"SHA"},';
            Res += '{"account_no":"Deposit Contribution",';
            Res += '"account_name":"Deposit Contribution",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Current Shares") + '",';
            Res += '"bal_code":"DEP"}],';
            // Res += '{"account_no":"Benevolent Fund",';
            // Res += '"account_name":"Benevolent Fund",';
            // Res += '"balances":"' + FORMAT(ObjMemberRegister."Benevolent Fund") + '",';
            // Res += '"bal_code":"RSK"}],';
            ObjVendor.RESET;
            ObjVendor.SETRANGE(ObjVendor."BOSA Account No", ObjMemberRegister."No.");
            ObjVendor.SETFILTER(ObjVendor."Account Type", '<>%1', 'JIPANGE ACCOUNT');
            IF ObjVendor.FINDSET THEN BEGIN

                Res += '"fosa_accounts":[';
                REPEAT
                    ObjVendor.CALCFIELDS("Balance (LCY)");
                    AccountTypesSavingProducts.RESET;
                    AccountTypesSavingProducts.GET(ObjVendor."Account Type");
                    Res += '{"account_no":"' + ObjVendor."No." + '",';
                    Res += '"account_name":"' + FORMAT(ObjVendor.Name) + '",';
                    Res += '"account_status":"' + FORMAT(ObjVendor.Status) + '",';
                    Res += '"payroll_no":"' + FORMAT(ObjVendor."Payroll/Staff No2") + '",';
                    Res += '"balance":"' + FORMAT(ObjVendor."Balance (LCY)") + '",';
                    Res += '"bal_code":"' + AccountTypesSavingProducts.Code + '"},';
                UNTIL ObjVendor.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
                Res += '],';
            END;
            Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            Res += '}';
        END;
    END;

    PROCEDURE FnGetMyClients(username: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", '04882');
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"client_list":[';
            count := 0;
            Transtype := '';
            REPEAT
                ObjMemberRegister.CALCFIELDS(ObjMemberRegister."Total Loans Outstanding", ObjMemberRegister."Outstanding Interest");
                Res += '{"member_no":"' + ObjMemberRegister."No." + '",';
                Res += '"name":"' + FORMAT(ObjMemberRegister.Name) + '",';
                Res += '"mobile_no":"' + FORMAT(ObjMemberRegister."Mobile Phone No") + '",';
                Res += '"id_no":"' + FORMAT(ObjMemberRegister."ID No.") + '",';
                Res += '"total_loan_bal":"' + FORMAT(ObjMemberRegister."Total Loans Outstanding" + ObjMemberRegister."Outstanding Interest") + '",';
                Res += '"status":"' + FORMAT(ObjMemberRegister.Status) + '",';
                Res += '"email":"' + FORMAT(ObjMemberRegister."E-Mail") + '"},';

            UNTIL (ObjMemberRegister.NEXT = 0);
            Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            Res := Res + ']}';
        END;
    END;

    PROCEDURE FnDepositStatement(username: Text; date_from: Date; date_to: Date) Res: Text;
    BEGIN
    END;

    PROCEDURE FnGetphoneno(username: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."ID No.", username);
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            Res := ObjMemberRegister."Mobile Phone No";
            EXIT;
        END;
    END;

    PROCEDURE FnGetAccountusingPhone(username: Text) Res: Text;
    BEGIN
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Username, username);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            ObjMemberRegister.reset;
            ObjMemberRegister.SetRange(ObjMemberRegister."No.", ObjMobileUsers."Account No");
            if ObjMemberRegister.Find('-') then begin
                Res := ObjMemberRegister."No.";
                EXIT;
            end;

        END;

        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Telephone, username);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            Res := ObjMobileUsers."Account No";
            EXIT;
        END;
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Telephone, '+' + username);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            Res := ObjMobileUsers."Account No";
            EXIT;
        END;
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Telephone, '0' + COPYSTR(username, 4, 13));
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            Res := ObjMobileUsers."Account No";
            EXIT;
        END;
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Telephone, COPYSTR(username, 4, 13));
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            Res := ObjMobileUsers."Account No";
            EXIT;
        END;

        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Telephone, COPYSTR(username, 1, 13));
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            Res := ObjMobileUsers."Account No";
            EXIT;
        END;
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers."ID No", username);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            ObjMemberRegister.reset;
            ObjMemberRegister.SetRange(ObjMemberRegister."No.", ObjMobileUsers."Account No");
            if ObjMemberRegister.Find('-') then begin
                Res := ObjMemberRegister."No.";
                EXIT;
            end;

        END;

    END;

    PROCEDURE FnGetPhone(username: Text) Res: Text;
    begin
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Telephone, COPYSTR(username, 1, 13));
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            Res := ObjMobileUsers."ID No";
            EXIT;
        END;
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Telephone, '0' + COPYSTR(username, 4, 13));
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            Res := ObjMobileUsers."ID No";
            EXIT;
        END;
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Telephone, username);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            Res := ObjMobileUsers."ID No";
            EXIT;
        END;

    end;

    PROCEDURE FnGetAccount(username: Text) Res: Boolean;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", username);
        IF ObjMemberRegister.FIND('-') THEN BEGIN

        END;
    END;

    PROCEDURE FnSaveSTKResponseComplete(VAR loanno: Text; MerchantRequestID: Text; CheckoutRequestID: Text; VAR amount: Decimal; VAR paybillno: Text; ResultCode: Text; ResultDesc: Text; VAR telephone: Text; receiptno: Text; phonenumber: Text) Res: Boolean;
    BEGIN
        STKPUSHLogs.RESET;
        STKPUSHLogs.SETRANGE(STKPUSHLogs.MerchantRequestID, MerchantRequestID);
        IF STKPUSHLogs.FIND('-') THEN BEGIN
            STKPUSHLogs.ResultCode := ResultCode;
            STKPUSHLogs.ResultDesc := ResultDesc;
            STKPUSHLogs.receiptno := receiptno;
            STKPUSHLogs.phonenumber := phonenumber;
            STKPUSHLogs.MODIFY;
            ObjPaybillATrans.Reset();
            ObjPaybillATrans.Init();
            ObjPaybillATrans.Amount := STKPUSHLogs.amount;
            ObjPaybillATrans."Account Name" := STKPUSHLogs."Account No";
            ObjPaybillATrans."Document Date" := Today;
            ObjPaybillATrans."Key Word" := STKPUSHLogs."Account No";
            ObjPaybillATrans."Document No" := receiptno;
            ObjPaybillATrans."Transaction Date" := Today;
            ObjPaybillATrans."Transaction Time" := Time;
            ObjPaybillATrans."Transaction Type" := 'PAYBILL';
            ObjPaybillATrans.Telephone := STKPUSHLogs.phonenumber;
            ObjPaybillATrans.Insert();
            //MOBILELive.PaybillSwitch(receiptno);

        END;
    END;

    PROCEDURE FnSaveSTKResponse(VAR loanno: Text; MerchantRequestID: Text; CheckoutRequestID: Text; VAR amount: Decimal; VAR paybillno: Text; ResultCode: Text; ResultDesc: Text; VAR telephone: Text; receiptno: Text; phonenumber: Text) Res: Boolean;
    BEGIN
        STKPUSHLogs.RESET;
        STKPUSHLogs.SETRANGE(STKPUSHLogs.MerchantRequestID, MerchantRequestID);
        IF STKPUSHLogs.FIND('-') THEN BEGIN
            STKPUSHLogs.ResultCode := ResultCode;
            STKPUSHLogs.ResultDesc := ResultDesc;
            STKPUSHLogs.receiptno := receiptno;
            STKPUSHLogs.phonenumber := phonenumber;
            STKPUSHLogs.MODIFY;

        END;
    END;

    PROCEDURE FnInsertTransactions(VAR loanno: Text; MerchantRequestID: Text; CheckoutRequestID: Text; VAR amount: Decimal; VAR paybillno: Text; ResultCode: Text; ResultDesc: Text; VAR telephone: Text; receiptno: Text; phonenumber: Text) Res: Boolean;
    BEGIN
        STKPUSHLogs.RESET;
        STKPUSHLogs.INIT;
        STKPUSHLogs."Account No" := loanno;
        STKPUSHLogs.MerchantRequestID := MerchantRequestID;
        STKPUSHLogs.CheckoutRequestID := CheckoutRequestID;
        STKPUSHLogs.amount := amount;
        STKPUSHLogs.paybillno := paybillno;
        STKPUSHLogs.ResultCode := ResultCode;
        STKPUSHLogs.ResponseDescription := ResultDesc;
        STKPUSHLogs.telephone := telephone;
        STKPUSHLogs.INSERT;

    END;

    PROCEDURE FnGetaccountsummary(member_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            ObjMemberRegister.CALCFIELDS("Shares Retained", "Current Shares", "Total Loans Outstanding", "Outstanding Interest", "Programmed Deposits");
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"account_balances":[';
            Res += '{"account_name":"Shares",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Shares Retained") + '",';
            Res += '"bal_code":"SHA' + member_no + '"},';
            Res += '{"account_name":"Deposits",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Current Shares") + '",';
            Res += '"bal_code":"DEP' + member_no + '"},';
            Res += '{"account_name":"Programmed Deposits",';
            Res += '"balances":"' + FORMAT(ObjMemberRegister."Programmed Deposits") + '",';
            Res += '"bal_code":"PGD' + member_no + '"},';
            ObjVendor.RESET;
            ObjVendor.SETRANGE(ObjVendor."BOSA Account No", ObjMemberRegister."No.");
            IF ObjVendor.FINDSET THEN BEGIN
                ObjVendor.CALCFIELDS("Balance (LCY)");
                REPEAT
                    AccountTypesSavingProducts.RESET;
                    AccountTypesSavingProducts.GET(ObjVendor."Account Type");
                    Res += '{"account_no":"' + ObjVendor."No." + '",';
                    Res += '"account_name":"' + FORMAT(AccountTypesSavingProducts.Code) + '",';
                    Res += '"account_status":"' + FORMAT(ObjVendor.Status) + '",';
                    Res += '"payroll_no":"' + FORMAT(ObjVendor."Payroll/Staff No2") + '",';
                    Res += '"balances":"' + FORMAT(ObjVendor."Balance (LCY)") + '",';
                    Res += '"bal_code":"' + AccountTypesSavingProducts.Code + '"},';
                UNTIL ObjVendor.NEXT = 0;
            END;
            ObjLoansRegister.RESET;
            ObjLoansRegister.SETRANGE(ObjLoansRegister."Client Code", ObjMemberRegister."No.");
            ObjLoansRegister.SETRANGE(ObjLoansRegister.Posted, TRUE);
            ObjLoansRegister.SETFILTER(ObjLoansRegister."Outstanding Balance", '>%1', 0);
            IF ObjLoansRegister.FIND('-') THEN BEGIN
                REPEAT
                    ObjLoansRegister.CALCFIELDS(ObjLoansRegister."Outstanding Interest", "Outstanding Balance");
                    Res += '{"bal_code":"' + ObjLoansRegister."Loan  No." + '",';
                    Res += '"account_name":"' + FORMAT(ObjLoansRegister."Loan Product Type") + '",';
                    Res += '"balances":"' + FORMAT(ObjLoansRegister."Outstanding Interest" + ObjLoansRegister."Outstanding Balance") + '"},';
                UNTIL ObjLoansRegister.NEXT = 0;
                //Res:=COPYSTR(Res,1,STRLEN(Res)-1);
            END;
            Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            Res += ']}';
        END;
    END;

    PROCEDURE FnGetinsertpaybilltransactions(accountNo: Code[50]; "account name": Text; receiptNO: Text; mpesaname: Text; telephone: Text; keyword: Text; amount: Decimal; paybillba: Decimal; transactiontype: Text) Res: Text;
    var
        AuPaybill: Codeunit "AU Paybill Automations";
    BEGIN

        ObjPaybillATrans.Reset();
        ObjPaybillATrans.SetRange(ObjPaybillATrans."Document No", receiptNO);
        if ObjPaybillATrans.FindFirst() = false then begin
            ObjPaybillATrans.RESET;
            ObjPaybillATrans."Document No" := receiptNO;
            ObjPaybillATrans."Account No" := accountNo;
            ObjPaybillATrans."Account Name" := "account name";
            ObjPaybillATrans.Description := "account name";
            // ObjPaybillATrans."Account Name" := mpesaname;minista
            ObjPaybillATrans.Telephone := telephone;
            ObjPaybillATrans."Key Word" := keyword;
            ObjPaybillATrans."Transaction Date" := TODAY;
            ObjPaybillATrans."Transaction Time" := TIME;
            ObjPaybillATrans.Amount := amount;
            ObjPaybillATrans."Document Date" := TODAY;
            ObjPaybillATrans."Approved By" := USERID;
            ObjPaybillATrans.INSERT;
            // MOBILELive.PaybillSwitch(receiptno);
            Res := '{"success":true,';
            Res += '"description":"Paybill posted successfuly"}';
            Commit();
        end;
        AuPaybill.FnInsertPaybillTransactions(receiptNO, transactiontype, amount, '', accountNo, '', paybillba, '', telephone, "account name", '', '', 1, keyword);
    END;

    PROCEDURE FnSaveUSSD(SESSIONID: Text; USSDCODE: Text; MSISDN: Text; INPUT: Text; NETWORK: Text; Requestcount: Integer; isactive: Boolean; response: Text; USSD_STRING: Code[50]) Res: Text;
    BEGIN
        USSDLogs.RESET;
        USSDLogs.SETRANGE(USSDLogs.SESSIONID, SESSIONID);
        IF USSDLogs.FIND('-') = FALSE THEN BEGIN
            USSDLogs.INIT;
            USSDLogs.SESSIONID := SESSIONID;
            USSDLogs.USSDCODE := USSDCODE;
            USSDLogs.MSISDN := MSISDN;
            USSDLogs.INPUT := INPUT;
            USSDLogs.NETWORK := NETWORK;
            USSDLogs.RequestCount := Requestcount;
            USSDLogs."Document Date" := CURRENTDATETIME;
            USSDLogs."Created By" := USERID;
            USSDLogs.Active := isactive;
            USSDLogs.Response := response;
            USSDLogs.TransactionDate := TODAY;
            USSDLogs.USSD_STRING := USSD_STRING;
            USSDLogs.INSERT;
        END;
    END;

    PROCEDURE FnUPDATEUSSD(Requestcount: Integer; isactive: Boolean; response: Text; USSD_STRING: Code[50]; SESSIONID: Text; INPUT: Text; Concat: Text) Res: Text;
    BEGIN
        USSDLogs.RESET;
        USSDLogs.SETRANGE(USSDLogs.SESSIONID, SESSIONID);
        IF USSDLogs.FIND('-') THEN BEGIN
            USSDLogs.RequestCount := Requestcount;
            USSDLogs."Document Date" := CURRENTDATETIME;
            USSDLogs.Active := isactive;
            USSDLogs.Response := response;
            USSDLogs.TransactionDate := TODAY;
            USSDLogs.USSD_STRING := USSD_STRING;
            USSDLogs.INPUT := INPUT;
            USSDLogs.ConcatString := Concat;
            USSDLogs.MODIFY;
        END;
    END;

    PROCEDURE FnGetSessionUSSD(SESSIONID: Text) Res: Text;
    BEGIN
        USSDLogs.RESET;
        USSDLogs.SETRANGE(USSDLogs.SESSIONID, SESSIONID);
        IF USSDLogs.FIND('-') THEN BEGIN
            Res := '{"SESSIONID":"' + USSDLogs.SESSIONID + '",';
            Res += '"MSISDN":"' + USSDLogs.MSISDN + '",';
            Res += '"USSDCODE":"' + USSDLogs.USSDCODE + '",';
            Res += '"INPUT":"' + USSDLogs.INPUT + '",';
            Res += '"NETWORK":"' + USSDLogs.NETWORK + '",';
            Res += '"RequestCount":' + FORMAT(USSDLogs.RequestCount) + ',';
            Res += '"Active":true,';
            Res += '"DOCUMENTDATE":"' + FORMAT(USSDLogs."Document Date") + '",';
            Res += '"CONCATSTR":"' + FORMAT(USSDLogs.ConcatString) + '",';
            Res += '"USSD_STRING":"' + USSDLogs.USSD_STRING + '"}';
        END;
    END;

    PROCEDURE LoanProductDetails() Res: Text;
    BEGIN
        BEGIN
            LoanProductsSetup.RESET;
            LoanProductsSetup.SetFilter(LoanProductsSetup.Code, 'UTAPESA|DIVIDEND');
            LoanProductsSetup.SetRange("Availabe Mobile Loan", true);
            //LoanProductsSetup.SETFILTER(Code, '<>%1', '');
            IF LoanProductsSetup.FIND('-') THEN BEGIN
                Res := '{"success":true,';
                Res += '"description":"account exist",';
                Res += '"loan_products":[';
                REPEAT
                    Res += '{"product_code":"' + LoanProductsSetup.Code + '",';
                    Res += '"product_description":"' + LoanProductsSetup."Product Description" + '",';
                    Res += '"installment_period":' + FORMAT(LoanProductsSetup."No of Installment") + ',';
                    Res += '"interest":"' + DELCHR(FORMAT(LoanProductsSetup."Interest rate"), '=', ',') + '",';
                    Res += '"maximum_loan_amt":"' + DELCHR(FORMAT(LoanProductsSetup."Max. Loan Amount"), '=', ',') + '",';
                    Res += '"min_loan_amt":"' + DELCHR(FORMAT(LoanProductsSetup."Min. Loan Amount"), '=', ',') + '",';
                    Res += '"repayment_method":"' + FORMAT(LoanProductsSetup."Repayment Method") + '"},';
                UNTIL LoanProductsSetup.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
                Res += ']}';
            END
        END
    END;

    PROCEDURE GetSecurityQuiz47() Res: Text;
    BEGIN
        BEGIN
            SecurityQuiz.RESET;
            SecurityQuiz.SETASCENDING(SecurityQuiz."Entry No", TRUE);
            SecurityQuiz.SETFILTER(SecurityQuiz.Sec_code, '<>%1', '');
            IF SecurityQuiz.FIND('-') THEN BEGIN
                Res := '{"success":true,';
                Res += '"description":"security quiz",';
                Res += '"data":[';
                REPEAT
                    Res += '{"id":' + FORMAT(SecurityQuiz."Entry No") + ',';
                    Res += '"code":"' + SecurityQuiz.Sec_code + '",';
                    Res += '"description":"' + SecurityQuiz.Descriptions + '"},';

                UNTIL SecurityQuiz.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
                Res += ']}';
            END;
        END
    END;

    PROCEDURE GetSecurityQuiz() Res: Text;
    BEGIN
        BEGIN
            SecurityQuiz.RESET;
            SecurityQuiz.SETASCENDING(SecurityQuiz."Entry No", TRUE);
            SecurityQuiz.SETFILTER(SecurityQuiz.Sec_code, '<>%1', '');
            IF SecurityQuiz.FIND('-') THEN BEGIN
                Res := '{"success":true,';
                Res += '"description":"security quiz",';
                Res += '"data":[';
                REPEAT
                    Res += '{"id":' + FORMAT(SecurityQuiz."Entry No") + ',';
                    Res += '"code":"' + SecurityQuiz.Sec_code + '",';
                    Res += '"description":"' + SecurityQuiz.Descriptions + '"},';

                UNTIL SecurityQuiz.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
                Res += ']}';
            END;
        END
    END;

    PROCEDURE FnGetallGuarantors(member_no: Text) Res: Text;
    var
        ObjLoanQuarantee: Record "Loans Guarantee Details";
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."ID No.", member_no);
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"loan_list":[';
            ObjLoanQuarantee.RESET;
            ObjLoanQuarantee.SETRANGE(ObjLoanQuarantee."Member No", ObjMemberRegister."No.");
            ObjLoanQuarantee.SETFILTER(ObjLoanQuarantee."Outstanding Balance", '>%1', 0);
            IF ObjLoanQuarantee.FIND('-') THEN BEGIN
                REPEAT
                    ObjLoansRegister.CALCFIELDS(ObjLoansRegister."Outstanding Interest", "Outstanding Balance");
                    Res += '{"loan_no":"' + ObjLoansRegister."Loan  No." + '",';
                    Res += '"loan_name":"' + FORMAT(ObjLoansRegister."Loan Product Type Name") + '",';
                    Res += '"loan_balance":"' + FORMAT(ObjLoansRegister."Outstanding Interest" + ObjLoansRegister."Outstanding Balance") + '",';
                    Res += '"loan_issue_date":"' + FORMAT(FORMAT(ObjLoansRegister."Issued Date", 0, '<Day,2> <Month text, 3> <Year4>')) + '",';
                    Res += '"loan_application_date":"' + FORMAT(FORMAT(ObjLoansRegister."Application Date", 0, '<Day,2> <Month text, 3> <Year4>')) + '",';
                    if ObjLoansRegister."Loan Product Type" = 'DIVIDEND' then
                        Res += '"loan_installment":"' + FORMAT(ObjLoansRegister."Outstanding Balance") + '"},' ELSE
                        Res += '"loan_installment":"' + FORMAT(ObjLoansRegister.Repayment) + '"},';


                UNTIL ObjLoanQuarantee.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            END;
            Res := Res + ']}';
        END;
    END;

    PROCEDURE FnGetLoansQuaranteed(member_no: Text) Res: Text;
    var
        ObjLoanQuarantee: Record "Loans Guarantee Details";
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."ID No.", member_no);
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            Res := '{"success":true,';
            Res += '"description":"account exist",';
            Res += '"name":"' + ObjMemberRegister.Name + '",';
            Res += '"mobile_no":"' + ObjMemberRegister."Mobile Phone No" + '",';
            Res += '"member_no":"' + ObjMemberRegister."No." + '",';
            Res += '"loan_list":[';
            ObjLoanQuarantee.RESET;
            ObjLoanQuarantee.SETRANGE(ObjLoanQuarantee."Member No", ObjMemberRegister."No.");
            ObjLoanQuarantee.SETFILTER(ObjLoanQuarantee."Outstanding Balance", '>%1', 0);
            IF ObjLoanQuarantee.FIND('-') THEN BEGIN
                REPEAT
                    ObjLoansRegister.CALCFIELDS(ObjLoansRegister."Outstanding Interest", "Outstanding Balance");
                    Res += '{"loan_no":"' + ObjLoansRegister."Loan  No." + '",';
                    Res += '"loan_name":"' + FORMAT(ObjLoansRegister."Loan Product Type Name") + '",';
                    Res += '"loan_balance":"' + FORMAT(ObjLoansRegister."Outstanding Interest" + ObjLoansRegister."Outstanding Balance") + '",';
                    Res += '"loan_issue_date":"' + FORMAT(FORMAT(ObjLoansRegister."Issued Date", 0, '<Day,2> <Month text, 3> <Year4>')) + '",';
                    Res += '"loan_application_date":"' + FORMAT(FORMAT(ObjLoansRegister."Application Date", 0, '<Day,2> <Month text, 3> <Year4>')) + '",';
                    Res += '"loan_installment":"' + FORMAT(ObjLoansRegister.Repayment) + '"},';

                UNTIL ObjLoanQuarantee.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            END;
            Res := Res + ']}';
        END;
    END;

    PROCEDURE FnsendFeedback(username: Text; feedback: Text; names: Text) Res: Text;
    BEGIN
        BEGIN
            SecurityQuiz.RESET;
            SecurityQuiz.SETASCENDING(SecurityQuiz."Entry No", TRUE);
            SecurityQuiz.SETFILTER(SecurityQuiz.Sec_code, '<>%1', '');
            IF SecurityQuiz.FIND('-') THEN BEGIN
                Res := '{"success":true,';
                Res += '"description":"security quiz",';
                Res += '"data":[';
                REPEAT
                    Res += '{"id":' + FORMAT(SecurityQuiz."Entry No") + ',';
                    Res += '"code":"' + SecurityQuiz.Sec_code + '",';
                    Res += '"description":"' + SecurityQuiz.Descriptions + '"},';

                UNTIL SecurityQuiz.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
                Res += ']}';
            END;
        END
    END;

    PROCEDURE LoanProductDetailsFOSA() Res: Text;
    BEGIN
        BEGIN
            LoanProductsSetup.RESET;
            LoanProductsSetup.SETRANGE(Source, LoanProductsSetup.Source::BOSA);
            LoanProductsSetup.SETFILTER(Code, '<>%1', 'SHAREBOOST');
            IF LoanProductsSetup.FIND('-') THEN BEGIN
                Res := '{"success":true,';
                Res += '"description":"account exist",';
                Res += '"loan_products":[';
                REPEAT
                    Res += '{"product_code":"' + LoanProductsSetup.Code + '",';
                    Res += '"product_description":"' + LoanProductsSetup."Product Description" + '",';
                    Res += '"installment_period":' + FORMAT(LoanProductsSetup."No of Installment") + ',';
                    Res += '"interest":"' + DELCHR(FORMAT(LoanProductsSetup."Interest rate"), '=', ',') + '",';
                    Res += '"maximum_loan_amt":"' + DELCHR(FORMAT(LoanProductsSetup."Max. Loan Amount"), '=', ',') + '",';
                    Res += '"min_loan_amt":"' + DELCHR(FORMAT(LoanProductsSetup."Min. Loan Amount"), '=', ',') + '",';
                    Res += '"repayment_method":"' + FORMAT(LoanProductsSetup."Repayment Method") + '"},';
                UNTIL LoanProductsSetup.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
                Res += ']}';
            END
        END
    END;

    PROCEDURE LoanProductDetailsMICRO() Res: Text;
    BEGIN
        BEGIN
            LoanProductsSetup.RESET;
            LoanProductsSetup.SETRANGE(Source, LoanProductsSetup.Source::Investment);
            LoanProductsSetup.SETFILTER(Code, '<>%1', 'SHAREBOOST');
            IF LoanProductsSetup.FIND('-') THEN BEGIN
                Res := '{"success":true,';
                Res += '"description":"account exist",';
                Res += '"loan_products":[';
                REPEAT
                    Res += '{"product_code":"' + LoanProductsSetup.Code + '",';
                    Res += '"product_description":"' + LoanProductsSetup."Product Description" + '",';
                    Res += '"installment_period":' + FORMAT(LoanProductsSetup."No of Installment") + ',';
                    Res += '"interest":"' + DELCHR(FORMAT(LoanProductsSetup."Interest rate"), '=', ',') + '",';
                    Res += '"maximum_loan_amt":"' + DELCHR(FORMAT(LoanProductsSetup."Max. Loan Amount"), '=', ',') + '",';
                    Res += '"min_loan_amt":"' + DELCHR(FORMAT(LoanProductsSetup."Min. Loan Amount"), '=', ',') + '",';
                    Res += '"repayment_method":"' + FORMAT(LoanProductsSetup."Repayment Method") + '"},';
                UNTIL LoanProductsSetup.NEXT = 0;
                Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
                Res += ']}';
            END
        END
    END;

    PROCEDURE FnGetMPESATransactions() Res: Text;
    var
        mobilebanking: record "Mobile Banking Transactions";
    BEGIN
        mobilebanking.Reset();
        mobilebanking.SetRange(Processed, false);
        mobilebanking.SetRange(Posted, true);
        mobilebanking.SetRange(mobilebanking.Status, mobilebanking.Status::Completed);
        mobilebanking.SetRange(mobilebanking."Posting Date", Today);
        mobilebanking.SetRange(mobilebanking."Transaction Type", mobilebanking."Transaction Type"::"Loan Application");
        IF mobilebanking.Find('-') then begin
            Res := '{"success":true,';
            Res += '"SecurityCredential":"GexW7u7G9db+WXo1rh9CnLuSgRIW5U1kfnMYMw8GGx0g0JRhJtAkQLHklHFK9lJ0gPGIqaq5xgEPO0CxMh+wMkBgAvPUghXHaRc+wnDWGFYGnMPqr5LTXDZYQUnAjGGDxQOqrspvHW9CYFicF0Q3KEAX1mPeEYnJq6aOe1Agb+PlGbPnS5GJlgXxaBNMY40kvO4gsRD4waSmFeikukcrawrQB1xREcWVpaIXl4ThKV+xGvTe8sbm3k3vQVR1/RyCNw6fURICp6V54LihEnLCbS/6pXXptQqIrwRjh7gMjqGXEQaAwwK/1E5rI6cF4o/cTk8K1foITBtUgUs2SM9m6g==",';
            Res += '"mpesa_lists":[';
            REPEAT
                Res += '{"success":true,';
                Res += '"status":true,';
                Res += '"telephone":"' + mobilebanking."Telephone Number" + '",';
                Res += '"account_name":"' + mobilebanking."Account Name" + '",';
                Res += '"account_no":"' + mobilebanking."Account No" + '",';
                Res += '"transactionNo":"' + mobilebanking."Document No" + '",';
                Res += '"amount":"' + format(mobilebanking.Amount) + '",';
                Res += '"AccountReference":"' + format(mobilebanking."Account No2") + '",';
                Res += '"PartyB":"' + format(mobilebanking.client) + '",';
                Res += '"PartyB_Name":"' + format(mobilebanking."Description") + '",';
                if mobilebanking."Transaction Type" = mobilebanking."Transaction Type"::"Loan Application" then
                    Res += '"Transaction_Type":"withdrawal",';
                if mobilebanking."Transaction Type" = mobilebanking."Transaction Type"::"Utility Payment" then
                    Res += '"Transaction_Type":"utility",';
                Res += '"description":"Successful"},';
            UNTIL (mobilebanking.NEXT = 0);
            Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
            Res := Res + ']}';
        END;
    END;




    PROCEDURE GetEligibility(Product_code: Code[50]; account_no: Code[50]; period: Integer) Res: Text;
    var
        qualifiedamount: Decimal;
        MpesaDisbus: Record "Mobile Loans";
        totalloans: Decimal;
        creditlogs: Record "Credit limit logs";
        previousAMT: Decimal;
        varQualifyAmt: Decimal;
    BEGIN
        BEGIN
            ObjMemberRegister.RESET;
            ObjMemberRegister.SETRANGE(ObjMemberRegister."ID No.", account_no);
            IF ObjMemberRegister.FIND('-') THEN BEGIN

                IF Product_code = 'UTAPESA' THEN begin

                    MpesaDisbus.Reset;
                    MpesaDisbus.SetCurrentkey(MpesaDisbus."Loan Amount");
                    MpesaDisbus.Ascending(true);
                    MpesaDisbus.SetRange(MpesaDisbus."Member No", ObjMemberRegister."No.");
                    MpesaDisbus.SetFilter("Document Date", Format(20250701D) + '..' + Format(Today));
                    if MpesaDisbus.Findlast then begin
                        ObjLoansRegister.Get(MpesaDisbus."Loan No");
                        ObjLoansRegister.CalcFields("Outstanding Balance");
                        IF ObjLoansRegister."Outstanding Balance" = 0 THEN BEGIN
                            creditlogs.Reset();
                            creditlogs.SetRange("Member No", ObjMemberRegister."No.");
                            creditlogs.SetCurrentKey(EntryNo);
                            creditlogs.Ascending(true);
                            previousAMT := MpesaDisbus."Loan Amount";
                            if not creditlogs.FindLast() then begin
                                if (previousAMT >= 2000) and (previousAMT <= 11000) then
                                    previousAMT += 2000 else
                                    if (previousAMT > 11000) and (previousAMT <= 20000) then
                                        previousAMT += 3000 else
                                        if (previousAMT > 20000) and (previousAMT <= 32000) then
                                            previousAMT += 4000 else
                                            if (previousAMT > 32000) and (previousAMT <= 50000) then previousAMT += 5000;
                                MOBILELive.updateUtapesacreditlimit(ObjMemberRegister."No.", false, 0, 0, previousAMT, MpesaDisbus."Loan Amount", '', false);
                            end else begin
                                if previousAMT > 0 then begin
                                    //  MOBILELive.updateUtapesacreditlimit(ObjMemberRegister."No.", false, 0, 0, previousAMT, 0, '', previousAMT < creditlogs."Current limit");
                                    if (previousAMT >= 2000) and (previousAMT <= 11000) then
                                        previousAMT += 2000 else
                                        if (previousAMT > 11000) and (previousAMT <= 20000) then
                                            previousAMT += 3000 else
                                            if (previousAMT > 20000) and (previousAMT <= 32000) then
                                                previousAMT += 4000 else
                                                if (previousAMT > 32000) and (previousAMT <= 50000) then previousAMT += 5000;
                                    MOBILELive.updateUtapesacreditlimit(ObjMemberRegister."No.", false, 0, 0, previousAMT, 0, '', false);

                                end;
                            end;
                        end;
                    END;

                    Res := MOBILELive.AdvanceEligibility(ObjMemberRegister."No.", period, qualifiedamount)
                end

                ELSE
                    IF Product_code = 'DIVIDEND' THEN
                        Res := MOBILELive.AdvanceEligibilitydIVIDEND(ObjMemberRegister."No.", period, varQualifyAmt)
                    // Res := ''// MOBILELive.AdvanceEligibilitySalary(account_no, period, '')
                    ELSE BEGIN
                        Res := '{"status":false,';
                        Res += '"description":"The loan product is not enabled for mobile banking",';
                        Res += '"amount":0}';
                    END;
            END;
        END;
    END;

    PROCEDURE GetTransactionCharges(account_no: Code[50]; amount: Decimal; transaction_code: Code[50]) Res: Text;
    VAR
        charges: Decimal;
    BEGIN
        charges := MOBILELive.GetCharge(amount, transaction_code);
        Res := '{"status":true,';
        Res += '"description":"charges of transactions",';
        Res += '"charges":' + DELCHR(FORMAT(charges), '=', ',') + '}';
    END;

    PROCEDURE registernewmember(name: Text; dob: Date; national_id: Text; mobile_phone: Text; email_id: text) Res: text
    begin
        Res := 'test';
    end;

    PROCEDURE ProcessLoan(Product_code: Code[50]; account_no: Code[50]; period: Integer; amount: Decimal; app_type: Code[10]; doc_no: Text; otp_code: text) Res: Text;
    var
        InterestAmount: Decimal;
        bankcharges: Decimal;
        qualfiedamount: Decimal;
        VarQualifyAmount: Decimal;
        qualifiedamount: Decimal;
    BEGIN
        BEGIN


            ObjMobileUsers.RESET;
            ObjMobileUsers.SETRANGE(ObjMobileUsers.Username, account_no);
            IF ObjMobileUsers.FIND('-') = FALSE THEN BEGIN
                Res := '{"success":false,';
                Res += '"description":"You cannot transact while your account is inactive"}';
                EXIT;
            end;
            if app_type <> 'USSD' THEN BEGIN
                ObjMobileUsersLogs.RESET;
                ObjMobileUsersLogs.SETRANGE(ObjMobileUsersLogs.Username, account_no);
                ObjMobileUsersLogs.SETRANGE(ObjMobileUsersLogs."OTP Code", otp_code);
                //ObjMobileUsersLogs.SetRange(ObjMobileUsersLogs.OTPUSED, false);
                IF ObjMobileUsersLogs.FIND('-') = false THEN BEGIN
                    Res := '{"success":false,';
                    Res += '"description":"OTP Could not be validated"}';
                    EXIT;
                END else begin
                    IF ObjMobileUsersLogs.OTPUSED = true THEN BEGIN
                        Res := '{"success":false,';
                        Res += '"description":"OTP Could not be validated"}';
                        EXIT;
                    end;
                    ObjMobileUsersLogs.OTPUSED := true;
                    ObjMobileUsersLogs.Modify();
                end;
            END;
            ObjMemberRegister.RESET;
            ObjMemberRegister.SETRANGE(ObjMemberRegister."ID No.", account_no);
            IF ObjMemberRegister.FIND('-') THEN BEGIN


                IF Product_code = 'UTAPESA' THEN begin

                    MOBILELive.AdvanceEligibility(ObjMemberRegister."No.", period, VarQualifyAmount);
                    if amount > VarQualifyAmount then begin

                        Res := '{"status":false,';
                        Res += '"status":false,';
                        Res += '"description":"Amount Entered is Greater than Qualified Amount",';
                        Res += '"amount":0}';
                        exit;
                    end else begin
                        Res := MOBILELive.PostNormalLoan(doc_no, ObjMemberRegister."No.", amount, period, InterestAmount);
                    end;
                end

                ELSE
                    IF Product_code = 'DIVIDEND' THEN begin
                        MOBILELive.AdvanceEligibilitydIVIDEND(ObjMemberRegister."No.", period, VarQualifyAmount);
                        if amount > VarQualifyAmount then begin

                            Res := '{"status":false,';
                            Res += '"status":false,';
                            Res += '"description":"Amount Entered is Greater than Qualified Amount",';
                            Res += '"amount":0}';
                            exit;
                        end else begin
                            InterestAmount := 0;
                            Res := MOBILELive.PostDividendLoan(doc_no, ObjMemberRegister."No.", amount, period, InterestAmount);
                            // InterestAmount := 0;
                        end;

                    end
                    ELSE BEGIN
                        Res := '{"status":false,';
                        Res += '"description":"The loan product is not enabled for mobile banking",';
                        Res += '"amount":0}';
                        exit;
                    END;

                if Res = 'TRUE' then begin
                    Res := '{"success":true,';
                    Res += '"status":true,';
                    Res += '"telephone":"' + ObjMobileUsers.telephone + '",';
                    Res += '"account_name":"' + ObjMobileUsers."Account Name" + '",';
                    Res += '"account_no":"' + ObjMobileUsers."Account No" + '",';
                    Res += '"interest_amount":' + DelChr(Format(InterestAmount), '=', ',') + ',';
                    Res += '"transactionNo":"' + doc_no + '",';
                    Res += '"SecurityCredential":"GexW7u7G9db+WXo1rh9CnLuSgRIW5U1kfnMYMw8GGx0g0JRhJtAkQLHklHFK9lJ0gPGIqaq5xgEPO0CxMh+wMkBgAvPUghXHaRc+wnDWGFYGnMPqr5LTXDZYQUnAjGGDxQOqrspvHW9CYFicF0Q3KEAX1mPeEYnJq6aOe1Agb+PlGbPnS5GJlgXxaBNMY40kvO4gsRD4waSmFeikukcrawrQB1xREcWVpaIXl4ThKV+xGvTe8sbm3k3vQVR1/RyCNw6fURICp6V54LihEnLCbS/6pXXptQqIrwRjh7gMjqGXEQaAwwK/1E5rI6cF4o/cTk8K1foITBtUgUs2SM9m6g==",';

                    Res += '"description":"Successful"}';
                    //post to mpesa

                end else
                    if Res = 'REFEXISTS' then begin
                        Res := '{"success":false,';
                        Res += '"description":"Your Request cannot be processed at the moment,Document number is already used"}';
                    end;
            END;
        END;
    END;

    PROCEDURE TransferbtwFOSAAccounts(source_account_no: Code[50]; destination_account: Code[50]; amount: Decimal; app_type: Code[10]; doc_no: Text; otp_code: Text) Res: Text;
    BEGIN

        Res := MOBILELive.FundsTransferFOSA(source_account_no, destination_account, doc_no, amount, app_type);

        IF Res = 'REFEXISTS' THEN BEGIN
            Res := '{"success":false,';
            Res += '"description":"Document number already has been used, Kindly generate another document number"}';
        END ELSE
            IF Res = 'TRUE' THEN BEGIN
                Res := '{"success":true,';
                Res += '"description":"Successful"}';
            END ELSE
                IF Res = 'INSUFFICIENT' THEN BEGIN
                    Res := '{"success":false,';
                    Res += '"description":"You have insufficient funds to complete this request"}';

                END ELSE
                    IF Res = 'ACC2INEXISTENT' THEN BEGIN
                        Res := '{"success":false,';
                        Res += '"description":"Destination account does not exists"}';

                    END ELSE
                        IF Res = 'ACCINEXISTENT' THEN BEGIN
                            Res := '{"success":false,';
                            Res += '"description":"Source account does not exists"}';
                        END;
    END;

    PROCEDURE LoanrepaymentfromFOSA(source_acc: Code[50]; loan_no: Code[50]; amount: Decimal; app_type: Code[10]; doc_no: Text; otp_code: text) Res: Text;
    BEGIN
        Res := MOBILELive.LoanRepayment(source_acc, loan_no, doc_no, amount);

        IF Res = 'REFEXISTS' THEN BEGIN
            Res := '{"success":false,';
            Res += '"description":"Document number already has been used, Kindly generate another document number"}';
        END ELSE
            IF Res = 'TRUE' THEN BEGIN
                Res := '{"success":true,';
                Res += '"description":"Successful"}';
            END ELSE
                IF Res = 'INSUFFICIENT' THEN BEGIN
                    Res := '{"success":false,';
                    Res += '"description":"You have insufficient funds to complete this request"}';

                END ELSE
                    IF Res = 'ACC2INEXISTENT' THEN BEGIN
                        Res := '{"success":false,';
                        Res += '"description":"Destination account does not exists"}';

                    END ELSE
                        IF Res = 'ACCINEXISTENT' THEN BEGIN
                            Res := '{"success":false,';
                            Res += '"description":"Source account does not exists"}';
                        END ELSE
                            IF Res = 'MEMBERINEXISTENT' THEN BEGIN
                                Res := '{"success":false,';
                                Res += '"description":"Source account does not exists"}';

                            END;
    END;

    PROCEDURE TransfertoBosaAccounts(source_account_no: Code[50]; bosa_account: Text; amount: Decimal; app_type: Code[10]; doc_no: Text; otp_code: text; mobile_no: Text) Res: Text;
    BEGIN

        Res := MOBILELive.FundsTransferBOSA(source_account_no, bosa_account, doc_no, amount, app_type);

        IF Res = 'REFEXISTS' THEN BEGIN
            Res := '{"success":false,';
            Res += '"description":"Document number already has been used, Kindly generate another document number"}';
        END ELSE
            IF Res = 'TRUE' THEN BEGIN
                Res := '{"success":true,';
                Res += '"description":"Successful"}';
            END ELSE
                IF Res = 'INSUFFICIENT' THEN BEGIN
                    Res := '{"success":false,';
                    Res += '"description":"You have insufficient funds to complete this request"}';

                END ELSE
                    IF Res = 'ACC2INEXISTENT' THEN BEGIN
                        Res := '{"success":false,';
                        Res += '"description":"Destination account does not exists"}';

                    END ELSE
                        IF Res = 'ACCINEXISTENT' THEN BEGIN
                            Res := '{"success":false,';
                            Res += '"description":"Source account does not exists"}';
                        END;
    END;

    procedure SaveMPESATransaction(transactionNo: Code[50]; ConversationID: text; OriginatorConversationID: text; ResponseCode: text; ResponseDescription: text)
    var
        mobilebanking: record "Mobile Banking Transactions";
    begin
        mobilebanking.Reset;
        mobilebanking.SetRange(mobilebanking."Document No", transactionNo);
        if mobilebanking.Find('-') then begin
            mobilebanking.OriginatorConversationID := OriginatorConversationID;
            mobilebanking.ConversationID := ConversationID;
            mobilebanking.ResponseCode := ResponseCode;
            mobilebanking.ResponseDescription := ResponseDescription;
            mobilebanking.Modify();
        end;

        mobilebanking.Reset;
        mobilebanking.SetRange(mobilebanking.OriginatorConversationID, transactionNo);
        if mobilebanking.Find('-') then begin
            mobilebanking.ReceiptNo := ConversationID;
            mobilebanking.Response := ResponseCode;
            mobilebanking.ReceiverPartyPublicName := OriginatorConversationID;
            mobilebanking.ResultDesc := ResponseDescription;
            mobilebanking.Modify();
        end
    end;

    PROCEDURE PostMPESATransactions(account_no: Code[50]; amount: Decimal; app_type: Code[10]; doc_no: Text; transaction_date: Date; otp_code: Code[10]; phone: text; member_no: text) Res: Text;
    BEGIN
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Username, member_no);
        //ObjMobileUsers.SetRange(ObjMobileUsers.Status, ObjMobileUsers.Status::Approved);
        IF ObjMobileUsers.FIND('-') = FALSE THEN BEGIN
            Res := '{"success":false,';
            Res += '"description":"You cannot transact while your account is inactive"}';
            EXIT;
        end;
        if app_type <> 'USSD' THEN BEGIN
            ObjMobileUsersLogs.RESET;
            ObjMobileUsersLogs.SETRANGE(ObjMobileUsersLogs.Username, member_no);
            ObjMobileUsersLogs.SETRANGE(ObjMobileUsersLogs."OTP Code", otp_code);
            IF ObjMobileUsersLogs.FIND('-') = FALSE THEN BEGIN
                Res := '{"success":false,';
                Res += '"description":"OTP Could not be validated"}';
                EXIT;
            END;
        END;

        ObjVendor.reset;
        ObjVendor.SetRange(ObjVendor."No.", ObjMobileUsers."Account No");
        ObjVendor.SetRange(ObjVendor."Account Type", account_no);
        if ObjVendor.Find('-') then
            Res := MOBILELive.PostMPESATrans(doc_no, ObjVendor."No.", amount, transaction_date, '4')
        else
            Res := MOBILELive.PostMPESATrans(doc_no, account_no, amount, transaction_date, '4');

        IF Res = 'REFEXISTS' THEN BEGIN
            Res := '{"success":false,';
            Res += '"status":false,';
            Res += '"description":"Document number already has been used, Kindly generate another document number"}';
        END ELSE
            IF Res = 'TRUE' THEN BEGIN
                Res := '{"success":true,';
                Res += '"status":true,';
                Res += '"telephone":"' + ObjMobileUsers.telephone + '",';
                Res += '"account_name":"' + ObjMobileUsers."Account Name" + '",';
                Res += '"account_no":"' + ObjMobileUsers."Account No" + '",';
                Res += '"transactionNo":"' + doc_no + '",';
                Res += '"SecurityCredential":"",';
                Res += '"description":"Successful"}';
            END ELSE
                IF Res = 'INSUFFICIENT' THEN BEGIN
                    Res := '{"success":false,';
                    Res += '"status":false,';
                    Res += '"description":"You have insufficient funds to complete this request"}';

                END ELSE
                    IF Res = 'ACC2INEXISTENT' THEN BEGIN
                        Res := '{"success":false,';
                        Res += '"status":false,';
                        Res += '"description":"Destination account does not exists"}';

                    END ELSE
                        IF Res = 'ACCINEXISTENT' THEN BEGIN
                            Res := '{"success":false,';
                            Res += '"status":false,';
                            Res += '"description":"Source account does not exists"}';
                        END;
    END;



    PROCEDURE FnValidateifRegisteredUSSD(telephone: Text) Res: Text;
    BEGIN
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers."Account No", FnGetAccountusingPhone(telephone));
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            IF ObjMobileUsers.Activated = true then begin
                Res := '{"success":true,';
                Res += '"description":"already registered continue for login",';
                Res += '"onboarded":true,';
                Res += '"member_no":"' + FORMAT(ObjMobileUsers.Username) + '",';
                Res += '"name":"' + FORMAT(ObjMobileUsers."Account Name") + '"}';
            end else begin
                Res := '{"success":false,';
                Res += '"onboarded":true,';
                Res += '"description":"already registered continue for login",';
                Res += '"member_no":"' + FORMAT(ObjMobileUsers.Username) + '",';
                Res += '"name":"' + FORMAT(ObjMobileUsers."Account Name") + '"}';
            end;

        END ELSE BEGIN
            Res := '{"success":false,';
            Res += '"description":"Account is not registered"}';
        END;
    END;

    PROCEDURE FnSignUpMemberUSSD(telephone: Text; password: Text; security_code: Text; security_answer: Text; sessionID: Text; plainTextPassword: Text) Res: Text;
    BEGIN
        if security_answer = '' then begin
            Res := '{"success":false,';
            Res += '"description":"Kindly select security answer"}';
            exit;
        end;
        if security_code = '' then begin
            Res := '{"success":false,';
            Res += '"description":"Kindly enter your security code"}';
            exit;
        end;
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers."Account No", FnGetAccountusingPhone(telephone));
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            //------------------insert users
            ObjMobileUsers.Username := ObjMobileUsers."ID No";
            ObjMobileUsers.IsMember := TRUE;
            ObjMobileUsers.Password := password;
            ObjMobileUsers."OTP Code" := CopyStr(sessionID, 1, 10);
            ObjMobileUsers.Activated := true;
            ObjMobileUsers."Security Answer" := security_answer;
            ObjMobileUsers."Security Code" := security_code;
            ObjMobileUsers."Last PIN Reset" := Today;
            ObjMobileUsers.Application := 'USSD';
            ObjMobileUsers.Modify();
            Res := '{"success":true,';
            Res += '"description":"Account has been activated"}';
            SMSMessage(Format(sessionID), ObjMobileUsers."No.", telephone, 'Dear ' + ObjMobileUsers."Account Name" + ' You have successfuly activated your account for mobile banking');

        END;

    END;

    PROCEDURE FnChangePasswordUSSD(username: Text; old_password: Text; new_password: Text; plaintext: Text) Res: Text;
    BEGIN
        ObjMobileUsers.RESET;
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Username, username);
        ObjMobileUsers.SETRANGE(ObjMobileUsers.Password, old_password);
        IF ObjMobileUsers.FIND('-') THEN BEGIN
            ObjMobileUsers.Password := new_password;
            ObjMobileUsers.MODIFY;
            ObjMobileUsersLogs.RESET;
            ObjMobileUsersLogs.INIT;
            ObjMobileUsersLogs."Mobile app No" := ObjMobileUsers."No.";
            ObjMobileUsersLogs.Username := username;
            ObjMobileUsersLogs."OTP Code" := 'USSD';
            ObjMobileUsersLogs."Transaction Date" := TODAY;
            ObjMobileUsersLogs."Transaction time" := TIME;
            ObjMobileUsersLogs.Activity := ObjMobileUsersLogs.Activity::"Change Password";
            ObjMobileUsersLogs."Created By" := USERID;
            ObjMobileUsersLogs.Name := ObjMobileUsers."Account Name";
            ObjMobileUsersLogs.INSERT;
            Res := '{"success":true,';
            Res += '"description":"Password changed successful"}';
        END ELSE BEGIN
            Res := '{"success":false,';
            Res += '"description":"kindly check old password"}';
        END;
    END;

    PROCEDURE FnSaveTransactions(sessionID: Text; MemberNo: Text; telephone: Text; accountNo: Text; loanNo: Text; TransactionType: Integer; amount: Decimal);
    VAR
        Res: Text;
    BEGIN
        Transactions.RESET;
        Transactions.SETRANGE(Transactions."Document No", sessionID);
        IF Transactions.FIND('-') = FALSE THEN BEGIN
            ObjMemberRegister.RESET;
            ObjMemberRegister.SetRange(ObjMemberRegister."No.", FnGetAccountusingPhone(MemberNo));
            IF ObjMemberRegister.Find('-') then begin
                Transactions.INIT;
                Transactions."Account Name" := ObjMemberRegister.Name;
                Transactions."Account No" := accountNo;
                Transactions."Document No" := sessionID;
                Transactions.Amount := amount;
                Transactions."Document Date" := TODAY;
                Transactions."Transaction Time" := TIME;
                Transactions."Telephone Number" := telephone;
                Transactions."Posting Date" := TODAY;
                Transactions.Posted := TRUE;
                Transactions."Date Posted" := CURRENTDATETIME;
                Transactions."Loan No" := loanNo;
                // Transactions."Transaction Type" := TransactionType::Others;
                Transactions.Status := Transactions.Status::Completed;
                Transactions.INSERT;
            end;

            IF TransactionType = 4 THEN BEGIN
                Res := FnGetMinistatementUSSD(ObjMemberRegister."No.", accountNo);
                IF Res <> '' THEN BEGIN
                    SMSMessage(sessionID, MemberNo, telephone, Res);
                END;
            END;

            IF TransactionType = 6 THEN BEGIN
                Res := FnGetallLoansBalancesUSSD(loanNo);
                IF Res <> '' THEN BEGIN
                    SMSMessage(sessionID, MemberNo, telephone, Res);
                END;
            END;

            IF TransactionType = 3 THEN BEGIN
                Res := FnGetaccountBalancesUSSD(ObjMemberRegister."No.");
                IF Res <> '' THEN BEGIN
                    //  SMSMessage(sessionID, MemberNo, telephone, Res);
                END;
            END;
        END;
    END;

    local procedure EmailEdit(CustomerId: Code[20]): Text
    var
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        email: Codeunit Email;
        emailMsg: Codeunit "Email Message";
        recRef: RecordRef;
        Customer: Record Customer;

    begin
        Customer.Get(CustomerId);
        Customer.SetRange("No.", CustomerId);
        recRef.GetTable(Customer);
        tmpBlob.CreateOutStream(OutStr);
        if Report.SaveAs(Report::"Customer - Order Summary", '', format::Pdf, OutStr, recRef) then begin
            tmpBlob.CreateInStream(InStr);
            txtB64 := cnv64.ToBase64(InStr, true);
            emailMsg.Create('', '', '');
            emailMsg.AddAttachment('OrderSummary.pdf', 'application/pdf', txtB64);
            email.OpenInEditor(emailMsg);
        end;
    end;

    procedure ReduceSpaces(InputString: Text) OutputString: Text
    var
        i: integer;
        n: Integer;
        CRLF: Text;

    begin

        // n := STRLEN(InputString);
        // FOR i := 1 TO n DO
        //     IF (InputString[i] = ' ') AND (i < n) THEN BEGIN
        //         IF NOT (InputString[i + 1] IN [32 .. 47, 58 .. 63]) THEN //if the next char is special as 'empty space,.,!' etc we do not copy the current space
        //             OutputString += FORMAT(InputString[i])
        //     END ELSE
        //         OutputString += FORMAT(InputString[i]);

        // OutputString := DELCHR(OutputString, '=', ' ');
        CRLF[1] := 10;
        CRLF[2] := 13;
        OutputString := DELCHR(InputString, '=', CRLF);
    end;

    PROCEDURE GetDetailedStatement(member_no: Text; DateFrom: Date; DateTo: Date; DocNo: Text) Res: Text;
    var
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;

    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."ID No.", member_no);
        //ObjMemberRegister.SetFilter(ObjMemberRegister."Date Filter", Format(DateFrom) + '..' + Format(DateTo));

        recRef.GetTable(ObjMemberRegister);
        tmpBlob.CreateOutStream(OutStr);
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            tmpBlob.CreateOutStream(OutStr);
            if Report.SaveAs(80007, DocNo, format::Pdf, OutStr, recRef) then begin
                tmpBlob.CreateInStream(InStr);
                txtB64 := cnv64.ToBase64(InStr, true);
            end;
            Res := '{"success":true,';
            Res += '"base_report":"' + ReduceSpaces(txtB64) + '"}';
        end;
    end;

    PROCEDURE GetLoansGuaranteed(member_no: Text; DocNo: Text) Res: Text
    var
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;

    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."ID No.", member_no);

        recRef.GetTable(ObjMemberRegister);
        tmpBlob.CreateOutStream(OutStr);
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            tmpBlob.CreateOutStream(OutStr);
            if Report.SaveAs(80009, DocNo, format::Pdf, OutStr, recRef) then begin
                tmpBlob.CreateInStream(InStr);
                txtB64 := cnv64.ToBase64(InStr, true);
            end;
            Res := '{"success":true,';
            Res += '"base_report":"' + ReduceSpaces(txtB64) + '"}';
        end;
    end;

    PROCEDURE memberisloanquaranteed(member_no: Text; DocNo: Text) Res: Text;
    var
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;

    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."ID No.", member_no);

        recRef.GetTable(ObjMemberRegister);
        tmpBlob.CreateOutStream(OutStr);
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            tmpBlob.CreateOutStream(OutStr);
            if Report.SaveAs(80010, DocNo, format::Pdf, OutStr, recRef) then begin
                tmpBlob.CreateInStream(InStr);
                txtB64 := cnv64.ToBase64(InStr, true);
            end;
            Res := '{"success":true,';
            Res += '"base_report":"' + ReduceSpaces(txtB64) + '"}';
        end;
    end;

    PROCEDURE LoanStatemement(member_no: Text; DocNo: Text) Res: Text;
    var
        tmpBlob: Codeunit "Temp Blob";
        cnv64: Codeunit "Base64 Convert";
        InStr: InStream;
        OutStr: OutStream;
        txtB64: Text;
        format: ReportFormat;
        recRef: RecordRef;

    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."ID No.", member_no);

        recRef.GetTable(ObjMemberRegister);
        tmpBlob.CreateOutStream(OutStr);
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            tmpBlob.CreateOutStream(OutStr);
            if Report.SaveAs(80027, DocNo, format::Pdf, OutStr, recRef) then begin
                tmpBlob.CreateInStream(InStr);
                txtB64 := cnv64.ToBase64(InStr, true);
            end;
            Res := '{"success":true,';
            Res += '"base_report":"' + ReduceSpaces(txtB64) + '"}';
        end;
    end;


    PROCEDURE FnGetMinistatementUSSD(member_no: Text; bal_code: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SetRange(ObjMemberRegister."No.", member_no);
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            count := 0;
            Transtype := '';
            ObjMemberLedgerEntry.RESET;
            ObjMemberLedgerEntry.SETASCENDING("Entry No.", FALSE);
            ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Customer No.", member_no);
            IF bal_code = 'SHA' THEN
                ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::"Share Capital");
            IF bal_code = 'DEP' THEN
                ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::"Deposit Contribution");
            IF bal_code = 'REG' THEN
                ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::"Registration Fee");
            IF bal_code = 'TLA' THEN
                ObjMemberLedgerEntry.SETRANGE(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."Transaction Type"::Loan);
            IF ObjMemberLedgerEntry.FIND('-') THEN BEGIN
                REPEAT
                    count := count + 1;
                    IF ObjMemberLedgerEntry.Amount > 0 THEN
                        Transtype := 'DR';
                    IF ObjMemberLedgerEntry.Amount < 0 THEN
                        Transtype := 'CR';
                    Res += FORMAT(ObjMemberLedgerEntry."Posting Date", 0, '<Day,2> <Month text, 3> <Year4>') + ' ' + FORMAT(ObjMemberLedgerEntry.Description) + ' ' + FORMAT(ABS(ObjMemberLedgerEntry.Amount));

                UNTIL (ObjMemberLedgerEntry.NEXT = 0) OR (count = 5);
            END;
        END;
    END;

    PROCEDURE FnGetallLoansBalancesUSSD(member_no: Text) Res: Text;
    BEGIN
        //ObjMemberRegister.RESET;
        //ObjMemberRegister.SetRange(ObjMemberRegister."No.", member_no);
        //IF ObjMemberRegister.FIND('-') THEN BEGIN
        ObjLoansRegister.RESET;
        ObjLoansRegister.SETRANGE(ObjLoansRegister."Client Code", member_no);
        ObjLoansRegister.SETRANGE(ObjLoansRegister.Posted, TRUE);
        ObjLoansRegister.SETFILTER(ObjLoansRegister."Outstanding Balance", '>%1', 0);
        IF ObjLoansRegister.FIND('-') THEN BEGIN
            REPEAT
                ObjLoansRegister.CALCFIELDS(ObjLoansRegister."Outstanding Interest", "Outstanding Balance");
                Res += ObjLoansRegister."Loan  No.";
                Res += '-' + FORMAT(ObjLoansRegister."Loan Product Type");
                Res += '-Ksh. ' + FORMAT(ObjLoansRegister."Outstanding Interest" + ObjLoansRegister."Outstanding Balance");
            UNTIL ObjLoansRegister.NEXT = 0;
            Res := COPYSTR(Res, 1, STRLEN(Res) - 1);
        END;
        // END;
    END;

    PROCEDURE FnGetaccountBalancesUSSD(member_no: Text) Res: Text;
    BEGIN
        ObjMemberRegister.RESET;
        ObjMemberRegister.SetRange(ObjMemberRegister."No.", member_no);
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            ObjMemberRegister.CALCFIELDS("Shares Retained", "Current Shares", "Total Loans Outstanding", "Outstanding Interest");
            Res += 'Share capital Ksh.' + FORMAT(ObjMemberRegister."Shares Retained");
            Res += ' Deposit Contribution Ksh.' + FORMAT(ObjMemberRegister."Current Shares");
            // Res += ' Loan balances Ksh.' + FORMAT(ObjMemberRegister."Total Loans Outstanding");
        END;
    END;

    PROCEDURE SMSMessage(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[250]);
    VAR
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        SmsMessage: Codeunit "Sms Management";
    BEGIN

        SMSMessages.RESET;
        IF SMSMessages.FIND('+') THEN BEGIN
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        END
        ELSE BEGIN
            iEntryNo := 1;
        END;
        SMSMessages.INIT;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := TODAY;
        SMSMessages."Time Entered" := TIME;
        SMSMessages.Source := 'MOBILETRAN';
        SMSMessages."Entered By" := USERID;
        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
        SMSMessages."SMS Message" := message;
        SMSMessages."Telephone No" := phone;
        IF SMSMessages."Telephone No" <> '' THEN
            SMSMessages.INSERT;
        SmsMessage.SendSmsResponse(phone, message);
        // SendAdvantaSMS(phone, message, iEntryNo);
    END;

    procedure SendAdvantaSMS(mobile: Text; smsbody: Text; entryNo: Integer)
    var

        Client: HttpClient;
        Content: HttpContent;
        Response: HttpResponseMessage;
        ResponseText: Text;
        JObject: JsonObject;
        JsonText: Text;
        IsSuccessful: Boolean;
        HttpStatusCode: Integer;
        statusCode: Text;
        status: Text;
        messageid: Text;
        responsedescc: Text;
        controlCode: Text;
        qrCode: Text;
        invoiceType: Text;
        serialNo: Text;
        ArrayJSONManagement: Codeunit "JSON Management";
        JSONManagement: Codeunit "JSON Management";
        ObjectJSONManagement: Codeunit "JSON Management";
        ArrayString: Text;
        JSONArray: JsonArray;
        ShipToJsonObject: Text;
        i: Integer;
        SMSMessages: Record "SMS Messages";
    begin

        //send to kra url
        IsSuccessful := Client.Get('https://quicksms.advantasms.com/api/services/sendsms/?mobile=' + mobile + '&shortcode=EPASACCOLTD&message=' + smsbody + '&apikey=510fbbd3fabc37416d9d1a52638fda98&partnerID=3554', Response);

        if not IsSuccessful then begin
            // handle the error
        end;

        if not Response.IsSuccessStatusCode() then begin
            HttpStatusCode := response.HttpStatusCode();
            // handle the error (depending on the HTTP status code)
        end;

        Response.Content().ReadAs(ResponseText);
        //unpack on json
        JSONManagement.InitializeObject(ResponseText);
        ObjectJSONManagement.InitializeObject(ResponseText);
        ArrayString := ResponseText;
        ObjectJSONManagement.GetStringPropertyValueByName('responses', statusCode);
        ArrayJSONManagement.InitializeCollection(statusCode);
        for i := 0 to ArrayJSONManagement.GetCollectionCount() - 1 do begin
            ArrayJSONManagement.GetObjectFromCollectionByIndex(ShipToJsonObject, i);
            ObjectJSONManagement.InitializeObject(ShipToJsonObject);
            ObjectJSONManagement.GetStringPropertyValueByName('response-description', responsedescc);
            ObjectJSONManagement.GetStringPropertyValueByName('messageid', messageid);
            SMSMessages.reset;
            SMSMessages.SetRange("Entry No", entryNo);
            if SMSMessages.Find('-') then begin
                SMSMessages."Delivery Status" := responsedescc;
                SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::Yes;
                SMSMessages."Date Sent to Server" := CurrentDateTime;
                SMSMessages."Time Sent To Server" := Time;
                SMSMessages."Batch No" := messageid;
                SMSMessages.Modify();
            end;
        end;
    end;


    PROCEDURE FnGetEligibility(member_no: Text) Res: Text;
    BEGIN

        ObjMemberRegister.RESET;
        ObjMemberRegister.SetRange(ObjMemberRegister."No.", FnGetAccountusingPhone(member_no));
        IF ObjMemberRegister.FIND('-') THEN BEGIN

        END ELSE BEGIN
            Res := '{"success":false,';
            Res += '"description":"Account does not exists"}';
        END;
    END;

    PROCEDURE FnPostAdvance(member_no: Text; amount: Decimal; period: Decimal; sessionid: Text) Res: Text;
    var
        Rst: Text;
        interestamt: Decimal;

    BEGIN

        ObjMemberRegister.RESET;
        ObjMemberRegister.SETRANGE(ObjMemberRegister."ID No.", member_no);
        IF ObjMemberRegister.FIND('-') THEN BEGIN
            Rst := MOBILELive.PostNormalLoan(sessionid, ObjMemberRegister."No.", amount, period, interestamt);
            if Rst = 'TRUE' then begin
                Res := '{"success":true,';
                Res += '"description":"Processed successfuly, You will Receive SMS Notification"}';
            end else
                if RST = 'REFEXISTS' then begin
                    Res := '{"success":false,';
                    Res += '"description":"Your Request cannot be processed at the moment,Document number is already used"}';
                end else begin
                    Res := '{"success":false,';
                    Res += '"description":"Your Request cannot be processed at the moment"}';
                end;





        END ELSE BEGIN

            Res := '{"success":false,';
            Res += '"description":"Account does not exists"}';
        END;
    END;

    PROCEDURE FnvalidateCustOMER(username: Text) res: Boolean;
    BEGIN
        ObjMemberRegister.Reset();
        ObjMemberRegister.SetRange(ObjMemberRegister."ID No.", username);
        if ObjMemberRegister.FindFirst() then
            res := TRUE;
    END;

    procedure FnPostIntrestMobile() return: Text
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        lineNo: Integer;
        Memberledger: Record "Cust. Ledger Entry";
        aufactory: Codeunit "Au Factory";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        LoanRepaymentSchedule.RESET;
        LoanRepaymentSchedule.SETRANGE("Repayment Date", TODAY);
        LoanRepaymentSchedule.SETRANGE("Loan Category", 'UTAPESA');
        IF LoanRepaymentSchedule.FINDFIRST THEN BEGIN
            lineNo := 1000;
            aufactory.FnClearGnlJournalLine('GENERAL', 'MOBILELOAN');
            REPEAT
                ObjLoansRegister.GET(LoanRepaymentSchedule."Loan No.");
                ObjLoansRegister.CalcFields("Outstanding Balance");
                if ObjLoansRegister."Outstanding Balance" > 0 then begin
                    Memberledger.RESET;
                    Memberledger.SETRANGE("Posting Date", LoanRepaymentSchedule."Repayment Date");
                    Memberledger.SETRANGE("Transaction Type", Memberledger."Transaction Type"::"Interest Due");
                    Memberledger.SETRANGE("Loan No", ObjLoansRegister."Loan  No.");
                    Memberledger.SETRANGE(Reversed, FALSE);
                    IF NOT Memberledger.FINDSET THEN BEGIN
                        ObjLoansRegister.Get(LoanRepaymentSchedule."Loan No.");
                        ObjLoansRegister.CalcFields("Outstanding Balance");
                        if ObjLoansRegister."Outstanding Balance" > 0 then begin
                            LoanProductsSetup.GET(ObjLoansRegister."Loan Product Type");
                            aufactory.FnCreateGnlJournalLineBalanced('GENERAL', 'MOBILELOAN', FORMAT(LoanRepaymentSchedule."Repayment Date"), lineNo, GenJournalLine."Transaction Type"::"Interest Due",
                             GenJournalLine."Account Type"::Customer, ObjLoansRegister."Client Code", LoanRepaymentSchedule."Repayment Date",
                              FORMAT(LoanRepaymentSchedule."Repayment Date") + ' Interest due', GenJournalLine."Account Type"::"G/L Account",
                               LoanProductsSetup."Receivable Interest Account", LoanRepaymentSchedule."Monthly Interest",

                            'BOSA', ObjLoansRegister."Loan  No.");
                            lineNo += 1000;
                        end;
                    END;
                    return += 'Interest posted for Loan No ' + ObjLoansRegister."Loan  No." + ' For client ' +
                    ObjLoansRegister."Client Name" + ' Interest amount ' + FORMAT(LoanRepaymentSchedule."Monthly Interest") +
                    ' for the day ' + FORMAT(LoanRepaymentSchedule."Repayment Date") + '<<<<<<<<<NEXT>>>>>>>>>>>';
                end;
            UNTIL LoanRepaymentSchedule.NEXT = 0;
            aufactory.FnPostGnlJournalLine('GENERAL', 'MOBILELOAN');
        END;

    end;



    procedure FnPostIntrestMobileAuto(RepaymentDate: Date; loanno: code[50]) return: Text
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        lineNo: Integer;
        Memberledger: Record "Cust. Ledger Entry";
        aufactory: Codeunit "Au Factory";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        LoanRepaymentSchedule.RESET;
        LoanRepaymentSchedule.SETRANGE("Repayment Date", RepaymentDate);
        LoanRepaymentSchedule.SETRANGE("Loan Category", 'UTAPESA');
        LoanRepaymentSchedule.SetRange("Loan No.", loanno);
        IF LoanRepaymentSchedule.FINDFIRST THEN BEGIN
            lineNo := 1000;
            //  aufactory.FnClearGnlJournalLine('GENERAL', 'MOBILELOAN2');
            REPEAT
                ObjLoansRegister.GET(LoanRepaymentSchedule."Loan No.");
                ObjLoansRegister.CalcFields("Outstanding Balance");
                if ObjLoansRegister."Outstanding Balance" > 0 then begin
                    Memberledger.RESET;
                    Memberledger.SETRANGE("Posting Date", LoanRepaymentSchedule."Repayment Date");
                    Memberledger.SETRANGE("Transaction Type", Memberledger."Transaction Type"::"Interest Due");
                    Memberledger.SETRANGE("Loan No", ObjLoansRegister."Loan  No.");
                    Memberledger.SETRANGE(Reversed, FALSE);
                    IF NOT Memberledger.FINDSET THEN BEGIN
                        ObjLoansRegister.Get(LoanRepaymentSchedule."Loan No.");
                        ObjLoansRegister.CalcFields("Outstanding Balance");
                        if ObjLoansRegister."Outstanding Balance" > 0 then begin
                            LoanProductsSetup.GET(ObjLoansRegister."Loan Product Type");
                            aufactory.FnCreateGnlJournalLineBalanced('GENERAL', 'INTMOBILE', FORMAT(LoanRepaymentSchedule."Repayment Date"), lineNo, GenJournalLine."Transaction Type"::"Interest Due",
                             GenJournalLine."Account Type"::Customer, ObjLoansRegister."Client Code", LoanRepaymentSchedule."Repayment Date",
                              FORMAT(LoanRepaymentSchedule."Repayment Date") + ' Interest due', GenJournalLine."Account Type"::"G/L Account",
                               LoanProductsSetup."Receivable Interest Account", LoanRepaymentSchedule."Monthly Interest",

                            'BOSA', ObjLoansRegister."Loan  No.");
                            lineNo += 1000;
                        end;
                    END;
                    return += 'Interest posted for Loan No ' + ObjLoansRegister."Loan  No." + ' For client ' +
                    ObjLoansRegister."Client Name" + ' Interest amount ' + FORMAT(LoanRepaymentSchedule."Monthly Interest") +
                    ' for the day ' + FORMAT(LoanRepaymentSchedule."Repayment Date") + '<<<<<<<<<NEXT>>>>>>>>>>>';
                end;
            UNTIL LoanRepaymentSchedule.NEXT = 0;
            //aufactory.FnPostGnlJournalLine('GENERAL', 'MOBILELOAN2');
        END;

    end;


    procedure PostPenalties()
    var
        loansReg: Record "Loans Register";
    begin
        loansReg.reset;
        loansReg.SetRange("Loan Product Type", 'UTAPESA');
        if loansReg.FindFirst() then begin
            Report.Run(Report::"Test Utapesa Recovery", false, false, loansReg);
        end
    end;

}