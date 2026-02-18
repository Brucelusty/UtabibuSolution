
Report 80041 "Send Payslips Via Mail"
{
    RDLCLayout = 'Layouts/SendPayslipsViaMail.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "No.", "Current Month Filter";
            column(ReportForNavId_1102755000; 1102755000) { }
            column(No; "Payroll Employee."."No.")
            {
            }
            trigger OnAfterGetRecord();
            var
                RecRef: RecordRef;
                Outstream2: OutStream;
                Instr: InStream;
                Templob: Codeunit "Temp Blob";
                EmailMessage: Codeunit "Email Message";
                Email: Codeunit Email;
            begin
                ObjPayrollEmployee.Reset;
                ObjPayrollEmployee.SetRange(ObjPayrollEmployee."No.", "No.");
                ObjPayrollEmployee.SetRange("Current Month Filter", SelectedPeriod);
                if ObjPayrollEmployee.FindSet then begin
                    Templob.CreateOutStream(Outstream2);
                    RecRef.GetTable(ObjPayrollEmployee);
                    VarEmployeeEmail := Lowercase(ObjPayrollEmployee."Employee Email");


                    Report.SaveAs(Report::"Payroll Payslip.", '', ReportFormat::Pdf, Outstream2, RecRef);
                    Templob.CreateInStream(Instr);
                    VarEmployeeName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Firstname);
                    VarEmailSubject := 'Payslip For  - ' + Format(SelectedPeriod, 0, '<Day,2> <Month Text,3> <Year4>');
                    VarEmailBody := 'Kindly find attached your payslip for ' + Format(SelectedPeriod, 0, '<Day,2> <Month Text,3> <Year4>') + '.';
                    EmailMessage.Create(VarEmployeeEmail, VarEmailSubject, '', true);
                    EmailMessage.AppendToBody(VarEmailBody);
                    EmailMessage.AddAttachment(ObjPayrollEmployee."No." + '.pdf', '', Instr);
                    Email.Send(EmailMessage);

                end;
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(SelectedPeriod; SelectedPeriod)
                    {
                        TableRelation = "Payroll Calender.";
                    }

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            //:= false;															
        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        Filename: Text[100];

        SalCard: Record "Payroll Employee.";
        Attachment: Text[250];
        EmpEmail: Text;
        HrEmps: Record "Salary Processing Header";
        objPeriod: Record "Payroll Calender.";
        SelectedPeriod: Date;
        Contracttype: Option Contract;
        Emps: Record "Payroll Employee.";
        VarEmployeeEmail: Text;
        VarEmployeeName: Text;
        SurestepFactory: Codeunit "Au Factory";
        VarEmailSubject: Text;
        VarEmailBody: Text;
        ObjPayrollEmployees: Record "Payroll Employee.";
        varPayrollPeriod: Date;
        ObjPayrollEmployee: Record "Payroll Employee.";


}


