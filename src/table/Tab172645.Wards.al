table 172645 Wards
{
    Caption = 'Wards';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SubCounty Code"; Code[250])
        {
            Caption = 'SubCounty Code';
        }
        field(2; Ward; Text[1000])
        {
            Caption = 'Ward';
        }
    }
    keys
    {
        key(PK; "SubCounty Code", Ward)
        {
            Clustered = true;
        }
    }
}
