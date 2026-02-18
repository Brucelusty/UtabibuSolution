table 50003 "Picture and Signatures"
{
    Caption = 'Picture and Signatures';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[50])
        {
            Caption = 'No';
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(3; Picture; Blob)
        {
            Caption = 'Picture';
        }
        field(4; Signature; Blob)
        {
            Caption = 'Signature';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
