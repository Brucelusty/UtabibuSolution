//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172097 "Sub Counties"
{

    fields
    {
        field(1; "County Code"; Code[20])
        {
            Editable = true;
        }
        field(2; "Sub-County Code"; Code[20])
        {

        }
        field(3; "Sub-County Name"; Text[2048])
        {
            Editable = true;
        }

    }

    keys
    {
        key(Key1; "County Code", "Sub-County Name", "Sub-County Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}




