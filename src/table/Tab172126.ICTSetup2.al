table 172126 "ICT Setup2"
{
    Caption = 'ICT Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';


        }
        field(2; "Enforce Password Expiry"; Boolean)
        {
            Caption = 'Enforce Password Expiry';
        }
        field(3; "Password Change Dateformula"; DateFormula)
        {
            Caption = 'Password Change Dateformula';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
