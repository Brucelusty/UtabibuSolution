Table 172610 "Sms Entry 2 Buff"
{

    fields
    {
        field(1;EntryNo;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;Message;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Phone Number";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Success,Failed';
            OptionMembers = ,Success,Failed;
        }
        field(5;Response;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6;Messageid;Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Message Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Message Time";Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

