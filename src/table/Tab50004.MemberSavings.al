table 50004 "MemberSavings"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MemberNo; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where(ISNormalMember = filter(true));
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Registration Fee,Shares Capital,Deposit Contribution,Utafiti Housing,Holiday Savings,Dependant 1 Savings,Dependant 2 Savings,Dependant 3 Savings,Repayment';
            OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings",Repayment;

            trigger OnValidate()
            begin
                Description := Format(Type);
                //Modify(true);
            end;

        }

        field(3; Amount; Decimal)

        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Amount On"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()

            begin
                "Amount Off" := Amount;
                Amount := "Amount On";

                /// Description := Format(Type);


                //Modify(true);
            end;

        }
        field(6; "Amount Off"; Decimal) { DataClassification = ToBeClassified; }
        field(7; Remarks; code[250]) { DataClassification = ToBeClassified; }
        field(8; "Last Advice Date"; Date) { DataClassification = ToBeClassified; }
        field(9; EntryNo; Integer) { DataClassification = ToBeClassified; AutoIncrement = true; }

    }

    keys
    {
        key(Key1; MemberNo, EntryNo, Description)
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