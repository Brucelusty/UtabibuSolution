//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172197 "HR Employee Qualifications"
{
    Caption = 'Employee Qualification';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Qualified Employees";
    LookupPageID = "Employee Qualifications";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "HR Employees"."No.";
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Institution/Company"; Text[30])
        {
            Caption = 'Institution/Company';
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(10; "Course Grade"; Text[30])
        {
            Caption = 'Course Grade';
        }
        field(11; "Employee Status"; Enum "Employee Status")
        {
            Caption = 'Employee Status';
            Editable = false;
            // OptionCaption = 'Active,Inactive,Terminated';
            // OptionMembers = Active,Inactive,Terminated;
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const("Employee Qualification"),
                                                                     "No." = field("Employee No."),
                                                                     "Table Line No." = field("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(14; "Qualification Type"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HR Lookup Values".Code where(Type = filter("Qualification Type"));
        }
        field(15; "Qualification Code"; Code[30])
        {
            Editable = true;
            NotBlank = true;
            Caption = 'Qualification Code';
            DataClassification = CustomerContent;
            TableRelation = Qualifications.Code where("Qualification Type" = const(Academic), "Field of Study" = field("Field of Study"), "Education Level" = field("Education Level"));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                Qualifications: Record Qualifications;
            begin
                if Qualifications.Get("Qualification Code") then
                    "Qualification Description" := Qualifications.Description;
            end;
        }
        field(16; "Qualification Description"; Text[100])
        {
        }
        field(172000; "Course of Study"; Text[70])
        {
        }
        field(172001; "Institution Type"; Enum "Education Institution Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Institution Type';
        }
        field(172002; "Institution Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Education Institution"."Institution Code" where(Type = field("Institution Type"));
            Caption = 'Institution Code';

            trigger OnValidate()
            var
                Institutions: Record "Education Institution";
            begin
                if Institutions.Get("Institution Code") then
                    "Institution/Company" := Institutions."Institution Name";
            end;
        }
        field(172003; "Field of Study"; Code[50])
        {
            Caption = 'Field of Study';
            DataClassification = CustomerContent;
            TableRelation = "Field of Study";
        }
        field(172004; "Education Type"; Enum "Education Types")
        {
            Caption = 'Education Type';
            DataClassification = CustomerContent;
        }
        field(172005; "Education Level"; Enum "Education Level")
        {
            Caption = 'Education Level';
            DataClassification = CustomerContent;
        }
        field(172006; "Proficiency Level"; Enum "Proficiency Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Proficiency Level';
        }
        field(172007; Country; Code[50])
        {
            Caption = 'Country';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(172008; Score; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }

    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Comment then
            Error(Text000);
    end;

    trigger OnInsert()
    begin
        Employee.Get("Employee No.");
        "Employee Status" := Employee.Status;
    end;

    var
        Text000: label 'You cannot delete employee qualification information if there are comments associated with it.';
        HRLookupValues: Record "HR Lookup Values";
        Employee: Record "HR Employees";
        HRQualifications: Record "HR Job Qualifications";
}




