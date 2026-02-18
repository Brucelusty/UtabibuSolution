codeunit 50030 "Loan Reminders"
{
  trigger OnRun()
    begin
        // LoanNotification();
        // SavingsArrearsReminder();
        // SavingsReminders();
        FnLoanDefaulternotification();
    end;

    var
        LoansRegister: Record "Loans Register";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        RepaymentDate: Date;
        AmountToRecover: Decimal;
        CustomerRecord: Record Customer;
        DetailedCustomer: Record "Detailed Cust. Ledg. Entry";
        Message: Text[2048];
        AuPaybillAutomation: Codeunit "AU Paybill Automations";
        Firstpart: Text;
        MobileExt: Label '254';
        MobilePhoneNo: Code[200];
        MobilePhoneNo3: Text[200];
        MobileRest: Text[250];
        MobilePhoneNo2: Text[200];
        SmsManagement: Codeunit "Sms Management";
        MemberMessage: Text[250];

        EndMothDate: Date;
        SendEmail: Codeunit Email;
        Emailmessage: Codeunit "Email Message";
        cryp: Codeunit "Cryptography Management";
        EmailTextBuilder: TextBuilder;
        FormattedBody: Text;
        DearCandidateLbl: Label 'Dear %1,';
        KindRegardsLbl: Label '<p>Kind Regards</p><br> %2 <br>';
        NewBody: Text;
        LoanRepayment3: Integer;
        LoanRepayment10D: Integer;
        Email: Text;
        DateTodat: Integer;
        Date3: Integer;
        Customer: Record Customer;

        AuFactory: Codeunit "Au Factory";
        MobilePhone: code[200];
        ThreeDay: Integer;
        TenDay: Integer;
        ScheduleBalance: Decimal;
        ExpectedLoanBalance: Decimal;
        VarSMSBody: Text;
        CompanyInfo: record "Company Information";

        LoanG: Record "Loans Guarantee Details";


    procedure LoanNotification()
    begin
        RepaymentDate := 0D;
        ExpectedLoanBalance := 0;
        ScheduleBalance := 0;
        LoansRegister.Reset();
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        if LoansRegister.FindSet() then begin
            repeat
                LoansRegister.CalcFields("Loan Repayment");
                LoanRepaymentSchedule.Reset();
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter("Repayment Date", '<=%1', Today);
                if LoanRepaymentSchedule.FindLast() then begin
                    RepaymentDate := LoanRepaymentSchedule."Repayment Date";
                    ScheduleBalance := LoanRepaymentSchedule."Loan Balance";
                end;
                ExpectedLoanBalance := LoansRegister."Outstanding Balance" - ScheduleBalance;

                if ExpectedLoanBalance <= 0 then exit;
                ThreeDay := Date2DMY(CalcDate('4D', Today), 1);
                TenDay := Date2DMY(CalcDate('-10D', Today), 1);
                DateTodat := Date2DMY(Today, 1);
                Date3 := Date2DMY(RepaymentDate, 1);
                LoanRepayment10D := Date2DMY(RepaymentDate, 1);
                LoanRepayment3 := Date2DMY(RepaymentDate, 1);
                if LoanRepayment3 = ThreeDay then begin
                    Customer.Reset();
                    Customer.SetRange("No.", LoansRegister."Client Code");
                    if Customer.Find('-') then begin
                        MobileRest := ' ';
                        MobileRest := ' ';
                        MobilePhoneNo := ' ';
                        VarSMSBody := 'Your loan installment of ' + Format(LoansRegister."Loan Repayment") + ' is due for repayment on ' + Format(CalcDate('4D', Today)) + ' Pay via Paybill No. 968562.';
                        Email := Customer."E-Mail (Personal)";
                        MobilePhone := Customer."Mobile Phone No";
                        MobilePhoneNo3 := Format(CustomerRecord."Mobile Phone No");
                        Firstpart := CopyStr(MobilePhoneNo3, 1, 1);
                        MobileRest := CopyStr(MobilePhoneNo3, 2, 200);
                        if Firstpart = '0' then
                            MobilePhoneNo := MobileExt + MobileRest
                        else
                            MobilePhoneNo := CustomerRecord."Mobile Phone No";

                        if MobilePhoneNo <> '' then
                            //  SmsCodeunit.SendSmsResponse(MobilePhoneNo, VarSMSBody);

                           // AuFactory.FnSendSMS('Reminder', VarSMSBody, LoansRegister."Client Name", MobilePhone);

                        EmailTextBuilder.Clear();
                        EmailTextBuilder.Append(DearCandidateLbl);
                        EmailTextBuilder.Append(VarSMSBody);
                        EmailTextBuilder.Append(KindRegardsLbl);
                        NewBody := EmailTextBuilder.ToText();
                        FormattedBody := StrSubstNo(NewBody, LoansRegister."Client Name", CompanyInfo.Name);
                        if Email <> '' then begin
                            Emailmessage.create(Email, 'Loan Repayment Reminder', FormattedBody, true);

                        end;
                    end;
                end;

                if Date3 = DateTodat then begin
                    Customer.Reset();
                    Customer.SetRange("No.", LoansRegister."Client Code");
                    if Customer.Find('-') then begin
                        Email := Customer."E-Mail (Personal)";
                        MobilePhone := Customer."Mobile Phone No";
                        MobileRest := ' ';
                        MobileRest := ' ';
                        MobilePhoneNo := ' ';
                        // VarSMSBody := 'Your loan installment of Kes ' + Format(LoansRegister.Repayments + ' is due today, Please ensure prompt payment. ';
                        Email := Customer."E-Mail (Personal)";
                        MobilePhone := Customer."Mobile Phone No";
                        MobilePhoneNo3 := Format(CustomerRecord."Mobile Phone No");
                        Firstpart := CopyStr(MobilePhoneNo3, 1, 1);
                        MobileRest := CopyStr(MobilePhoneNo3, 2, 200);
                        if Firstpart = '0' then
                            MobilePhoneNo := MobileExt + MobileRest
                        else
                            MobilePhoneNo := CustomerRecord."Mobile Phone No";

                        if MobilePhoneNo <> '' then
                            // SmsCodeunit.SendSmsResponse(MobilePhoneNo, VarSMSBody);
                            AuFactory.FnSendSMS('Reminder', VarSMSBody, LoansRegister."Client Code", MobilePhone);

                        EmailTextBuilder.Clear();
                        EmailTextBuilder.Append(DearCandidateLbl);
                        EmailTextBuilder.Append(VarSMSBody);
                        EmailTextBuilder.Append(KindRegardsLbl);
                        NewBody := EmailTextBuilder.ToText();
                        FormattedBody := StrSubstNo(NewBody, LoansRegister."Client Name", CompanyInfo.Name);
                        if Email <> '' then begin
                            Emailmessage.create(Email, 'Loan Repayment Reminder', FormattedBody, true);

                            // SendEmail.send(Emailmessage);
                        end;
                    end;
                end;
                if LoanRepayment10D = DateTodat then begin
                    Customer.Reset();
                    Customer.SetRange("No.", LoansRegister."Client Code");
                    if Customer.Find('-') then begin
                        Email := Customer."E-Mail (Personal)";
                        MobilePhone := Customer."Mobile Phone No";
                        MobileRest := ' ';
                        MobileRest := ' ';
                        MobilePhoneNo := ' ';
                        VarSMSBody := 'Your loan installment was due two days ago. Kindly prioritize payment to maintain your account in good standing. ';
                        MobilePhone := Customer."Mobile Phone No";
                        MobilePhoneNo3 := Format(CustomerRecord."Mobile Phone No");
                        Firstpart := CopyStr(MobilePhoneNo3, 1, 1);
                        MobileRest := CopyStr(MobilePhoneNo3, 2, 200);
                        if Firstpart = '0' then
                            MobilePhoneNo := MobileExt + MobileRest
                        else
                            MobilePhoneNo := CustomerRecord."Mobile Phone No";

                        if MobilePhoneNo <> '' then
                            // SmsCodeunit.SendSmsResponse(MobilePhoneNo, VarSMSBody);
                           // AuFactory.FnSendSMS('Reminder', VarSMSBody, LoansRegister."Client Code", MobilePhone);

                        EmailTextBuilder.Clear();
                        EmailTextBuilder.Append(DearCandidateLbl);
                        EmailTextBuilder.Append(VarSMSBody);
                        EmailTextBuilder.Append(KindRegardsLbl);
                        NewBody := EmailTextBuilder.ToText();
                        FormattedBody := StrSubstNo(NewBody, LoansRegister."Client Name", CompanyInfo.Name);
                        if Email <> '' then begin
                            Emailmessage.create(Email, 'Loan Repayment Reminder', FormattedBody, true);
                            //SendEmail.send(Emailmessage);
                        end;
                    end;
                end;
            until LoansRegister.Next() = 0;
        end;

    end;


    // procedure SavingsReminders()
    // begin
    //     EndMothDate := CalcDate('CM', Today);
    //     Message := ' ';

    //     if EndMothDate = Today then begin
    //         Customer.Reset();
    //         if Customer.FindSet() then begin
    //             repeat
    //                 CustomerRecord.Reset();
    //                 CustomerRecord.Setrange("No.", Customer."No.");
    //                 if CustomerRecord.find('-') then begin
    //                     MobileRest := ' ';
    //                     MobileRest := ' ';
    //                     MobilePhoneNo := ' ';
    //                   //  Message := 'Dear ' + AuPaybillAutomation.SplitString(Customer.Name, ' ') + ',' + ' a friendly reminder to contribute to your Haco Sacco savings this month . Thank you for your commitment!.';
    //                     MobilePhoneNo3 := Format(CustomerRecord."Mobile Phone No");
    //                     Firstpart := CopyStr(MobilePhoneNo3, 1, 1);
    //                     MobileRest := CopyStr(MobilePhoneNo3, 2, 200);
    //                     if Firstpart = '0' then
    //                         MobilePhoneNo := MobileExt + MobileRest
    //                     else
    //                         MobilePhoneNo := CustomerRecord."Mobile Phone No";

    //                     if MobilePhoneNo <> '' then
    //                         SmsCodeunit.FnSendsms(MobilePhoneNo, Message);
    //                 end;

    //             until Customer.Next() = 0;
    //         end;
    //     end
    // end;


    // procedure SavingsArrearsReminder()
    // begin
    //     EndMothDate := CalcDate('CM', Today);
    //     Message := ' ';

    //     if EndMothDate = Today then begin
    //         Customer.Reset();
    //         if Customer.FindSet() then begin
    //             repeat
    //                 DetailedCustomer.Reset();
    //                 DetailedCustomer.SetRange("Customer No.", Customer."No.");
    //                 DetailedCustomer.SetRange("Transaction Type", DetailedCustomer."Transaction Type"::"Deposit Contribution");
    //                 DetailedCustomer.SetFilter("Posting Date", '%1..%2', CalcDate('-CM-1M', Today), Today);
    //                 if DetailedCustomer.Find() = false then
    //                     CustomerRecord.Reset();
    //                 CustomerRecord.Setrange("No.", Customer."No.");
    //                 if CustomerRecord.find('-') then begin
    //                     MobileRest := ' ';
    //                     MobileRest := ' ';
    //                     MobilePhoneNo := ' ';
    //                   //  Message := 'Dear ' + AuPaybillAutomation.SplitString(Customer.Name, ' ') + ',' + ' kindly settle your Haco Sacco monthly savings arrears immediately to enable you continue enjoying Sacco products and services.';
    //                     MobilePhoneNo3 := Format(CustomerRecord."Mobile Phone No");
    //                     Firstpart := CopyStr(MobilePhoneNo3, 1, 1);
    //                     MobileRest := CopyStr(MobilePhoneNo3, 2, 200);
    //                     if Firstpart = '0' then
    //                         MobilePhoneNo := MobileExt + MobileRest
    //                     else
    //                         MobilePhoneNo := CustomerRecord."Mobile Phone No";

    //                     if MobilePhoneNo <> '' then
    //                         SmsCodeunit.SendSmsResponse(MobilePhoneNo, Message);
    //                 end;

    //             until Customer.Next() = 0;
    //         end;
    //     end
    // end;

    procedure FnLoanDefaulterNotification()
    var
        LoansRegister: Record "Loans Register";
        CustomerRecord: Record Customer;
        LoanG: Record "Loans Guarantee Details";
        MobilePhoneNo: Text[20];
        Message: Text[800];
        AmountToRecover: Decimal;
        AuFactory: Codeunit "Au Factory";
        AmountInArrearsText: Text;
        MobileExt: Label '+254';
    begin
        LoansRegister.Reset();
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0); 
        LoansRegister.SetFilter("Loan Product Type", '<>%1', 'INSTANT');
        if LoansRegister.FindSet() then begin
            repeat
                //
                LoansRegister.CalcFields("Outstanding Interest", "Outstanding Balance");

                
                if (LoansRegister."No of Months in Arrears" > 1)  then begin
                    if not LoansRegister."Defaulter Sms 1 Sent" then begin
                        CustomerRecord.Reset();
                        CustomerRecord.SetRange("No.", LoansRegister."Client Code");
                        if CustomerRecord.FindFirst() then begin
                            MobilePhoneNo := FormatMobileNumber(CustomerRecord."Mobile Phone No", MobileExt);

                            Message := 'Dear ' + LoansRegister."Client Name" + ', kind reminder that your ' +
                                       LoansRegister."Loan Product Type" + ' loan is behind schedule. Arrears: KES ' +
                                       Format(LoansRegister."Amount in Arrears") + '. Kindly update or visit the office to avoid inconveniences when you need another facility. M-pesa Paybill No. 822950.';

                            if MobilePhoneNo <> '' then begin
                             AuFactory.FnSendSMS('Reminder', Message, LoansRegister."Client Name", MobilePhoneNo);
                                LoansRegister."Defaulter Sms 1 Sent" := true;
                                LoansRegister.Modify(true);
                             end //else begin
                            //     Error('No mobile number found for customer %1.', LoansRegister."Client Code");
                                
                            //end;
                        end 
                        else begin
                            Error('Customer record not found for client code %1.', LoansRegister."Client Code");
                        end;
                    end;
                end;

                // 2 to <3 months in arrears
                if (LoansRegister."No of Months in Arrears" >= 2) and (LoansRegister."No of Months in Arrears" < 3) then begin
                    if not LoansRegister."Defaulter Sms 2 Sent" then begin
                        CustomerRecord.Reset();
                        CustomerRecord.SetRange("No.", LoansRegister."Client Code");
                        if CustomerRecord.FindFirst() then begin
                            MobilePhoneNo := FormatMobileNumber(CustomerRecord."Mobile Phone No", MobileExt);

                          Message := 'Dear ' + LoansRegister."Client Name" + ', This is a kind reminder that your ' +
                                       LoansRegister."Loan Product Type" + ' loan is behind schedule. Current arrears: KES ' +
                                       Format(LoansRegister."Amount in Arrears") + 
                                       '. Kindly update or visit the office to avoid incoveniences when you need another facility. M-pesa Paybill No. 822950.';

                            if MobilePhoneNo <> '' then begin
                              //  AuFactory.FnSendSMS('Reminder', Message, LoansRegister."Client Name", MobilePhoneNo);
                                LoansRegister."Defaulter Sms 2 Sent" := true;
                                LoansRegister.Modify(true);
                            end else begin
                                Error('No mobile number found for customer %1.', LoansRegister."Client Code");
                            end;
                        end else begin
                            Error('Customer record not found for client code %1.', LoansRegister."Client Code");
                        end;

                        // Notify guarantors
                        // LoanG.Reset();
                        // LoanG.SetRange("Loan No", LoansRegister."Loan  No.");
                        // if LoanG.FindSet() then begin
                        //     repeat
                        //         CustomerRecord.Reset();
                        //         CustomerRecord.SetRange("No.", LoanG."Member No");
                        //         if CustomerRecord.FindFirst() then begin
                        //             MobilePhoneNo := FormatMobileNumber(CustomerRecord."Mobile Phone No", MobileExt);
                        //             AmountInArrearsText := Format(LoansRegister."Amount in Arrears" + LoansRegister."Outstanding Interest", 0, '<Precision,2><Standard Format,0>');
                        //             // Original guarantor message preserved exactly
                        //             Message := 'Dear ' + CustomerRecord.Name + ', please note that member ' + LoansRegister."Client Name" + LoansRegister."Loan Product Type Name" +
                        //                        ' (Loan No: ' + LoansRegister."Loan  No." + ') has defaulted on a loan of KSh ' +
                        //                        AmountInArrearsText + ' in arrears. Kindly follow up to avoid deductions from your savings.';

                        //             if MobilePhoneNo <> '' then begin
                        //                 AuFactory.FnSendSMS('Guarantor', Message, 'LoanSystem', MobilePhoneNo);
                        //             end;
                        //         end;
                        //     until LoanG.Next() = 0;
                        // end;
                    end;
                end;

            // 3+ months in arrears (kept commented out as in original code)
            /*
            if (LoansRegister."No of Months in Arrears" >= 3) and (LoansRegister."No of Months in Arrears" < 4) then begin
                LoanG.Reset();
                LoanG.SetRange("Loan No", LoansRegister."Loan  No.");
                if LoanG.FindSet() then begin
                    repeat
                        AmountToRecover := Round(LoansRegister."Outstanding Balance" / LoansRegister."Approved Amount" * LoanG."Amont Guaranteed", 0.01, '=');
                        CustomerRecord.Reset();
                        CustomerRecord.SetRange("No.", LoanG."Member No");
                        if CustomerRecord.FindFirst() then begin
                            MobilePhoneNo := FormatMobileNumber(CustomerRecord."Mobile Phone No", MobileExt);
                            Message := 'Your KES ' + Format(AmountToRecover) + ' deposits were used to repay the loan of member ' + 
                                       LoansRegister."Client Name" + '. Please contact them directly to recover your money.';
                            
                            if MobilePhoneNo <> '' then
                                AuFactory.FnSendSMS('Guarantor', Message, 'LoanSystem', MobilePhoneNo);
                        end;
                    until LoanG.Next() = 0;
                end;
            end;
            */

            until LoansRegister.Next() = 0;
        end;
    end;

    local procedure FormatMobileNumber(PhoneNo: Text; MobileExt: Text): Text
    var
        MobileRest: Text[200];
        Firstpart: Text[1];
    begin
        if PhoneNo = '' then
            exit('');

        Firstpart := CopyStr(PhoneNo, 1, 1);
        MobileRest := CopyStr(PhoneNo, 2, 200);
        if Firstpart = '0' then
            exit(MobileExt + MobileRest);

        exit(PhoneNo);
    end;
}

    

