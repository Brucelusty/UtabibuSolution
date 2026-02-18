//<---------------------------------------------------------------------->															
Report 50071 "Send Member Statement"
{
    RDLCLayout = 'Layouts/SendMemberStatement.rdlc';
    DefaultLayout = RDLC;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            trigger OnAfterGetRecord();
            var
                OutStr: OutStream;
                tmpBlob: Codeunit "Temp Blob";
                recRef: RecordRef;
                Inst: InStream;
                EmailMessage: Codeunit "Email Message";
                Email: Codeunit Email;
            begin
                VarReportStartDate := Customer.GetRangeMin(Customer."Date Filter");
                VarReportToDate := Customer.GetRangemax(Customer."Date Filter");
                VarDateFilter := Customer.GetFilter(Customer."Date Filter");
                ObjMember.Reset;
                ObjMember.SetRange(ObjMember."No.", Customer."No.");
                if ObjMember.FindSet then begin
                    recRef.GetTable(ObjMember);
                    tmpBlob.CreateOutStream(OutStr);
                    Report.SaveAs(Report::"Member Account Statement(Ver1)", '', ReportFormat::Pdf, OutStr, recRef);
                    VarMemberEmail := ObjMember."E-Mail (Personal)";
                    VarMailSubject := 'Member Account Statement: ' + ObjMember."No.";
                    VarMailBody := 'Kindly find attached your Member Account Statement ';

                    tmpBlob.CreateInStream(Inst);
                    EmailMessage.Create(VarMemberEmail, VarMailSubject, ' ', true);
                    EmailMessage.AppendToBody(VarMailBody);
                    EmailMessage.AddAttachment(ObjMember."No." + '.pdf', '', Inst);
                    Email.Send(EmailMessage);

                    Message('The Statement for Member No. ' + ObjMember."No." + ' has successfully been sent to ' + VarMemberEmail + '.');
                end else
                    Message('The Email ' + VarMemberEmail + ' for Member No ' + ObjMember."No." + ' is not indemnified');
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

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
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
        VarReportStartDate: Date;
        VarDateFilter: Text;
        ObjVendor: Record Vendor;
        Filename: Text;
        FilePath: Text;
        VarMemberEmail: Text;
        VarMailSubject: Text;
        VarMailBody: Text;
        SFactory: Codeunit "Au Factory";
        // SMTPSetup: Record "SMTP Mail Setup";															
        VarReportToDate: Date;
        ObjMember: Record Customer;
}



