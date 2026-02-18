table 50002 "Interest Buffer Table"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = InterestCharged;
    LookupPageId = InterestCharged;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Member No"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Member Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Loan No"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Interest Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Transaction Date"; Date)
        {

        }
        field(7; Description; Text[250])
        {

        }
        field(8; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
                
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
        key(Key2; "Member No")
        {

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