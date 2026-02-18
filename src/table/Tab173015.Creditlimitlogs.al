table 173015 "Credit limit logs"
{
    Caption = 'Credit limit logs';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Credit limit logs";
    LookupPageId = "Credit limit logs";

    fields
    {
        field(1; EntryNo; Integer)
        {
            Caption = 'EntryNo';
            AutoIncrement = true;
        }
        field(2; "Member No"; Code[50])
        {
            Caption = 'Member No';
        }
        field(3; "Loan product type"; Code[50])
        {
            Caption = 'Loan product type';
        }
        field(4; "Loan no"; Code[50])
        {
            Caption = 'Loan no';
        }
        field(5; "Date logged"; Date)
        {
            Caption = 'Date logged';
        }
        field(6; "Amount paid"; Decimal)
        {
            Caption = 'Amount paid';
        }
        field(7; "Previous limit"; Decimal)
        {
            Caption = 'Previous limit';
        }
        field(8; "Current limit"; Decimal)
        {
            Caption = 'Current limit';
        }
        field(9; "Loan amoount"; Decimal)
        {
            Caption = 'Loan amoount';
        }
        field(10; "Norification sent"; Boolean)
        {

        }
    }


    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; "Member No", "Loan product type", "Date logged", "Loan amoount", "Previous limit", "Current limit")
        {
        }
    }
}
