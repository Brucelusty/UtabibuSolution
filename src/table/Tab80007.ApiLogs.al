Table 80007 ApiLogs
{

    fields
    {
        field(1;EntryNo;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;Id;Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(3;Message;Text[250])
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

