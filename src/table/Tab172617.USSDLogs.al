table 172617 "USSD Logs"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Entry; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; SESSIONID; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; USSDCODE; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; MSISDN; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; INPUT; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; NETWORK; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; RequestCount; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Document Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Response; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(12; TransactionDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; USSD_STRING; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; ConcatString; Text[1024])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Entry)
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