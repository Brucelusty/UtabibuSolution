table 50006 "Response"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; MemberNo; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; ActionDate; DateTime)
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Feedback Type"; Option)
        {

            OptionMembers = FeedBack,Response;
            OptionCaption = 'FeedBack,Response';

        }
        field(5; Message; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Feedback; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No.series"; code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Response; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "ID No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Name; code[250])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; No)
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