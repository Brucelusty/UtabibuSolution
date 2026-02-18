codeunit 131008 "Hr Emails"
{


    trigger OnRun()
    begin
        SendEmailOnBirthdayToEmployee();
    end;

    var
        HREmployees: Record "HR Employees";
        Birthday: Integer;
        BithMonth: Integer;

        Year: Integer;
        DayMonthYear: date;
        EmailTextBuilder: TextBuilder;
        EmployeeName: Text;

        DearLabel: Label 'Dear %1';
        BirthdayMessaage: Label ' Hi %2, Happy birthday! As you turn a year older, Shofco sacco celebrate you.';
        RegardsLabel: Label 'Kind Regards. Shofco sacco.';
        NewBody: Text;
        FormattedBody: Text;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record Company;
        VarEmailSubject: Label 'Birthday Message';
        CompanyEmail: Text;
        CompanyName: Text;

    procedure SendEmailOnBirthdayToEmployee()
    begin
        // CompanyInfo.Get();
        // CompanyName := CompanyInfo."Display Name";

        EmployeeName := '';
        CompanyEmail := '';
        HREmployees.Reset();
        HREmployees.SetCurrentKey("No.");
        if HREmployees.Find('-') then begin
            EmployeeName := HREmployees."First Name" + ' ' + HREmployees."Last Name";
            Birthday := Date2DMY(HREmployees."Date Of Birth", 1);
            BithMonth := Date2DMY(HREmployees."Date Of Birth", 2);
            Year := Date2DMY(Today, 3);
            DayMonthYear := DMY2Date(Birthday, BithMonth, Year);
            if DayMonthYear = Today then begin
                EmailTextBuilder.Clear();
                EmailTextBuilder.Append(DearLabel);
                EmailTextBuilder.Append(BirthdayMessaage);
                EmailTextBuilder.Append(RegardsLabel);
                NewBody := EmailTextBuilder.ToText();
                FormattedBody := StrSubstNo(NewBody, EmployeeName);
                Emailmessage.create(CompanyEmail, VarEmailSubject, FormattedBody, true);
                Email.send(Emailmessage);

            end;


        end;


    end;

}
