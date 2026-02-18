codeunit 80002 "Loan Payment Reminders"
{
    trigger OnRun()
    begin
        LoanNotification();
    end;

    var
        LoansRegister: Record "Loans Register";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        RepaymentDate: Date;

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


    procedure LoanNotification()
    begin
        RepaymentDate := 0D;
        ExpectedLoanBalance := 0;
        ScheduleBalance := 0;
        LoansRegister.Reset();
        //LoansRegister.SetFilter("Date filter", '..%1', Today);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        if LoansRegister.FindSet() then begin
            repeat
                LoanRepaymentSchedule.Reset();
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter("Repayment Date", '..%1', Today);
                if LoanRepaymentSchedule.FindLast() then begin
                    RepaymentDate := LoanRepaymentSchedule."Repayment Date";
                    ScheduleBalance := LoanRepaymentSchedule."Loan Balance";
                end;
                ExpectedLoanBalance := LoansRegister."Outstanding Balance" - ScheduleBalance;
                if ExpectedLoanBalance <= 0 then exit;
                ThreeDay := Date2DMY(CalcDate('-3D', Today), 1);
                TenDay := Date2DMY(CalcDate('10D', Today), 1);
                DateTodat := Date2DMY(Today, 1);
                Date3 := Date2DMY(RepaymentDate, 1);
                LoanRepayment10D := Date2DMY(CalcDate('10D', RepaymentDate), 1);
                LoanRepayment3 := Date2DMY(CalcDate('-3D', RepaymentDate), 1);
                if LoanRepayment3 = ThreeDay then begin
                    Customer.Reset();
                    Customer.SetRange("No.", LoansRegister."Client Code");
                    if Customer.Find('-') then begin
                        Email := Customer."E-Mail (Personal)";
                        MobilePhone := Customer."Mobile Phone No";
                        VarSMSBody := 'Your Loan repayment  is Due in 3days ';
                        AuFactory.FnSendSMS('Reminder', VarSMSBody, LoansRegister."Client Name", MobilePhone);

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

                if Date3 = DateTodat then begin
                    Customer.Reset();
                    Customer.SetRange("No.", LoansRegister."Client Code");
                    if Customer.Find('-') then begin
                        Email := Customer."E-Mail (Personal)";
                        MobilePhone := Customer."Mobile Phone No";
                        VarSMSBody := 'Your Loan repayment  is due today ';
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
                        VarSMSBody := 'Your Loan repayment  is OverDue ';
                        AuFactory.FnSendSMS('Reminder', VarSMSBody, LoansRegister."Client Code", MobilePhone);

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
}
