table 172262 "OTP LOGS"
{
    Caption = 'OTP LOGS';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User Id"; Code[20])
        {
            Caption = 'User Id';
        }
        field(2; OTP; Integer)
        {
            Caption = 'OTP';
        }
        field(3; "Generated On"; DateTime)
        {
            Caption = 'Generated On';
        }
        field(4; "Session ID"; Integer)
        {
            Caption = 'Session ID';
        }
        field(5; "Entry No"; Integer)
        {

        }
    }
    keys
    {
        key(PK; "User Id", "Session ID", "Entry No")
        {
            Clustered = true;
        }
    }
}
