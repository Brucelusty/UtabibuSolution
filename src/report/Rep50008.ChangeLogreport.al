report 50008 ChangeLogreport
{
    // version AUDIT

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Change Log Report.rdlc';

    dataset
    {
        dataitem("Change Log Entry"; "Change Log Entry")
        {
            RequestFilterFields = "Entry No.", "Date and Time", "User ID", "Table No.";
            column(EntryNo_ChangeLogEntry; "Change Log Entry"."Entry No.")
            {
            }
            column(DateandTime_ChangeLogEntry; "Change Log Entry"."Date and Time")
            {
            }
            column(Time_ChangeLogEntry; "Change Log Entry".Time)
            {
            }
            column(UserID_ChangeLogEntry; "Change Log Entry"."User ID")
            {
            }
            column(TableNo_ChangeLogEntry; "Change Log Entry"."Table No.")
            {
            }
            column(TableCaption_ChangeLogEntry; "Change Log Entry"."Table Caption")
            {
            }
            column(FieldNo_ChangeLogEntry; "Change Log Entry"."Field No.")
            {
            }
            column(FieldCaption_ChangeLogEntry; "Change Log Entry"."Field Caption")
            {
            }
            column(TypeofChange_ChangeLogEntry; "Change Log Entry"."Type of Change")
            {
            }
            column(OldValue_ChangeLogEntry; "Change Log Entry"."Old Value")
            {
            }
            column(NewValue_ChangeLogEntry; "Change Log Entry"."New Value")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_City; Company.City)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.GET;
        Company.CALCFIELDS(Picture);
    end;

    var
        Company: Record 79;
        Series: Integer;
}

