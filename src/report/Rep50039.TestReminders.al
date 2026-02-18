report 50039 TestReminders
{
    Caption = 'TestReminders';
    UsageCategory = Administration;
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/TestReport.rdlc';
    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            RequestFilterFields = "Loan  No.";
            trigger OnAfterGetRecord()
            begin
                LoanNotification()
            end;
        }

    }


    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnPreReport()




    begin
        LoanNotification()

    end;

    trigger OnInitReport()
    begin

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
        Email: Text;
        Customer: Record Customer;

        AuFactory: Codeunit "Au Factory";
        MobilePhone: code[200];
        VarSMSBody: Text;
        CompanyInfo: record "Company Information";
        ScheduleBalance: Decimal;
        ExpectedLoanBalance: Decimal;

    procedure LoanNotification()
    begin
        RepaymentDate := 0D;
        ExpectedLoanBalance := 0;
        ScheduleBalance := 0;
        LoansRegister.Reset();
        LoansRegister.SetFilter("Date filter", '..%1', Today);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        if LoansRegister.FindSet() then begin
            repeat
                LoansRegister.CalcFields("Outstanding Balance");

                LoanRepaymentSchedule.Reset();
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter("Repayment Date", '..%1', Today);
                if LoanRepaymentSchedule.FindLast() then begin
                    RepaymentDate := LoanRepaymentSchedule."Repayment Date";
                    ScheduleBalance := LoanRepaymentSchedule."Loan Balance";
                    Message('%1-%2', Today, RepaymentDate);
                end;
                ExpectedLoanBalance := LoansRegister."Outstanding Balance" - ScheduleBalance;
                if ExpectedLoanBalance <= 0 then exit;
                if RepaymentDate = CalcDate('-3D', Today) then begin
                    Customer.Reset();
                    Customer.SetRange("No.", LoansRegister."Client Code");
                    if Customer.Find('-') then begin
                        Email := Customer."E-Mail (Personal)";
                        MobilePhone := Customer."Mobile Phone No";
                        VarSMSBody := 'Your Loan repayment  is Due in 3days';
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

                if RepaymentDate = Today then begin
                    Customer.Reset();
                    Customer.SetRange("No.", LoansRegister."Client Code");
                    if Customer.Find('-') then begin
                        Email := Customer."E-Mail (Personal)";
                        MobilePhone := Customer."Mobile Phone No";
                        VarSMSBody := 'Your Loan repayment  is today';
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
                if RepaymentDate = CalcDate('10D', Today) then begin
                    Customer.Reset();
                    Customer.SetRange("No.", LoansRegister."Client Code");
                    if Customer.Find('-') then begin
                        Email := Customer."E-Mail (Personal)";
                        MobilePhone := Customer."Mobile Phone No";
                        VarSMSBody := 'Your Loan repayment  is OverDue';
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




