Table 80009 SMSContacts
{

    fields
    {
        field(1;contactId;Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Phone Number";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Name;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Email;Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;contactId)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

