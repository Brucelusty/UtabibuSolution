table 172729 "Training Participants"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            TableRelation = "HR Training Applications"."Application No";
            DataClassification = CustomerContent;
            Caption = 'Code';
            editable= false;
        }

        field(3; "Employee No"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "HR Employees";
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    Designation := Employee."Department Name";

                end;
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Name';
            Editable = false;
        }
        field(5; Designation; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Designation';
            Editable = false;
        }

    }

    keys
    {
        key(Key1; Code, "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HR Employees";
}