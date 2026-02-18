table 50007 "InsiderLending"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where(ISNormalMember = filter(true));
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Reset();
                Customer.SetRange("No.", "Member No");
                if Customer.Find('-') then begin
                    "Member Name" := Customer.Name;
                    "ID No." := Customer."ID No.";
                    "E-Mail" := Customer."E-Mail";
                end;
            end;

        }
        field(2; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Position Held"; Option)
        {
            OptionCaption = ' ,Employee,Director,Credit Committee';
            OptionMembers = ,Employee,Director,"Credit Committee";
        }
        field(4; "ID No."; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "E-Mail"; text[1400])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Board/Staff"; Option)
        {
            OptionCaption = ' ,Staff,Board Member';
            OptionMembers = ,Staff,"Board Member";
        }
    }

    keys
    {
        key(PK; "Member No", "Member Name")
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