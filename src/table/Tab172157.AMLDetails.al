table 172157 "AML Details"
{
    Caption = 'AML Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "AML No"; Integer)
        {
            Caption = 'AML No';
            AutoIncrement = true;
        }
        field(2; "Member No"; Code[20])
        {
            Caption = 'Member No';
        }
        field(3; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
        }
        field(4; "Deposits Analysis"; Decimal)
        {
            Caption = 'Deposits Analysis';
        }
        field(5; "Current Deposits"; Decimal)
        {
            Caption = 'Current Deposits';
        }
        field(6; "Current Share Capital"; Decimal)
        {
            Caption = 'Current Share Capital';
        }
        field(7; "Date Listed"; date)
        {
            Caption = 'Date Listed';
        }
        field(8; "Customer Risk Rate"; Decimal)
        {
            Editable = false;
        }
        field(9; "Frequency Contribution"; Integer)
        {

        }
    }
    keys
    {
        key(PK; "AML No","Member No")
        {
            Clustered = true;
        }
    }
}
