table 173011 "Paybill Transactions"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; TransID; Code[40])
        {
            DataClassification = ToBeClassified;

        }
        field(2; TransactionType; Code[40])
        {
            DataClassification = ToBeClassified;

        }

        field(3; TransTime; DateTime)
        {
            DataClassification = ToBeClassified;

        }
        field(4; TransAmount; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(5; BusinessShortCode; Code[40])
        {
            DataClassification = ToBeClassified;

        }
        field(6; BillRefNumber; Code[40])
        {
            DataClassification = ToBeClassified;

        }
        field(7; InvoiceNumber; Code[40])
        {
            DataClassification = ToBeClassified;

        }
        field(8; OrgAccountBalance; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(9; ThirdPartyTransID; Code[40])
        {
            DataClassification = ToBeClassified;

        }

        field(10; MSIDN; Code[400])
        {
            DataClassification = ToBeClassified;

        }

        field(11; FirstName; Text[150])
        {
            DataClassification = ToBeClassified;

        }
        field(12; MiddleName; Text[150])
        {
            DataClassification = ToBeClassified;

        }
        field(13; LastName; Text[150])
        {
            DataClassification = ToBeClassified;

        }
        field(14; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Failed,Posted;
            OptionCaption = 'Failed,Posted';
            Editable = true;

        }
        field(15; Keyword; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(16; TransType; code[50])
        {
            DataClassification = ToBeClassified;

        }

        field(17; IDNo; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(18; Attempted; Boolean) { }



    }

    keys
    {
        key(Key1; TransID)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}