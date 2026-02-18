Table 80006 "Sms Entry 2"
{

    fields
    {
        field(1; EntryNo; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; Message; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Phone Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Success,Failed';
            OptionMembers = ,Success,Failed;
        }
        field(5; Response; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Messageid; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Message Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Message Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Bulk"; Boolean) { }
        field(10; "Attemted"; Boolean) { }
        field(11; "Response id"; text[250]) { }

    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if Message = '' then exit;
    end;
}




