//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172451 "Supervisors Approval Levels"
{
    //nownPage51516572;
    //nownPage51516572;

    fields
    {
        field(1; "Supervisor ID"; Code[50])
        {
            Caption = 'User ID';

            TableRelation = "User Setup"."User ID";

        }
        field(2; "Maximum Approval Amount"; Decimal)
        {
        }
        field(3; "Transaction Type"; Option)
        {
            OptionMembers = "Cash Deposits","Cheque Deposits",Withdrawals;
        }
        field(4; "E-mail Address"; Text[30])
        {
        }
        field(5; "Supervisor Name"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Supervisor ID", "Transaction Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserMgt: Codeunit "User Setup Management";
        User: Record User;
}




