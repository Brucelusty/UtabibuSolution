Table 80005 "Sms Setup 2"
{

    fields
    {
        field(1;"Primary Key";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"User id";Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Authenticatio Mode";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Basic,Jwt,ApiKey';
            OptionMembers = "None",Basic,Jwt,ApiKey;
        }
        field(4;Username;Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(5;Password;Text[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(6;"Jwt Token";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Api Key";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8;Vendor;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Sms balance";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Price per sms";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11;Package;Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"EndPoint link";Text[80])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

