table 80002 "RFQ"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Vendor No"; Code[100])
        {
            TableRelation = Vendor."No.";
            trigger
            OnValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.Reset();
                Vend.SetRange(Vend."No.", "Vendor No");
                if Vend.Find('-') then begin
                    "Vendor Name" := Vend.Name;
                    Email:=Vend."E-Mail";
                    "Captured by" := UserId;
                    "Date Time" := CurrentDateTime;
                end;
            end;
        }
        field(3; "Vendor Name"; Text[100])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(4; "Captured by"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
         field(9; Email; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No, "Vendor No")
        {
            Clustered = true;
        }
        key(Key2; "Vendor No")
        {

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