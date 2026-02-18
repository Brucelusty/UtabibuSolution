table 50008 "Notification"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry Date"; DateTime)
        {
            DataClassification = ToBeClassified;

        }
        field(2; Notification; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Entered by"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry Date")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}