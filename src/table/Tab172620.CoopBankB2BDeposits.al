table 172620 "Coop Bank B2B Deposits"
{
    Caption = 'Coop Bank B2B Deposits';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Entry; Integer)
        {
            Caption = 'Entry';
            AutoIncrement = true;
        }
        field(2; AccountName; Text[250])
        {
            Caption = 'AccountName';
        }
        field(3; PaymentMode; Text[250])
        {
            Caption = 'PaymentMode';
        }
        field(4; PaymentCode; Text[250])
        {
            Caption = 'PaymentCode';
        }
        field(5; PaymentReferenceCode; Text[250])
        {
            Caption = 'AccountName';
        }
        field(6; TotalAmount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; Currency; Text[250])
        {
            Caption = 'Currency';
        }
        field(8; BranchCode; Text[50])
        {
            Caption = 'BranchCode';
        }
        field(9; BankCode; Text[50])
        {
            Caption = 'BankCode';
        }
        field(10; AdditionalInfo; Text[250])
        {
            Caption = 'AdditionalInfo';
        }
        field(11; AccountNumber; Text[100])
        {
            Caption = 'AccountNumber';
        }
        field(12; DocumentReferenceNumber; Text[250])
        {
            Caption = 'DocumentReferenceNumber';
        }
        field(13; InstitutionName; Text[250])
        {
            Caption = 'InstitutionName';
        }
        field(14; PaymentAmount; Decimal)
        {
            Caption = 'PaymentAmount';
        }
        field(15; TransactionDate; DateTime)
        {
            Caption = 'Trans Date';
        }
        field(16; TransactionReferenceCode; Text[100])
        {
            Caption = 'TransactionReferenceCode';
        }
        field(17; InstitutionCode; Text[250])
        {
            Caption = 'InstitutionCode';
        }
        field(18; Document_Date; DateTime)
        {
            Caption = 'InstitutionCode';
        }
        field(19; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Failed,Posted;
            OptionCaption = 'Failed,Posted';
            Editable = true;

        }
        field(20; TransType; code[50])
        {
            DataClassification = ToBeClassified;

        }

        field(21; IDNo; code[50])
        {
            DataClassification = ToBeClassified;

        }


    }
    keys
    {
        key(PK; Entry)
        {
            Clustered = true;
        }
    }
}
