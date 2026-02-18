//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172909 "Safe Custody Custodians"
{
    DrillDownPageId = Custodian;
    LookupPageId = Custodian;

    fields
    {
        field(1; "User ID"; Code[20])
        {
            TableRelation = "User Setup"."User ID";


        }
        field(3; "Permision Type"; Option)
        {
            OptionCaption = 'Custodian';
            OptionMembers = Custodian;
        }
        field(4; "Custodian Of"; Option)
        {
            OptionCaption = ' ,Treasury,Safe Custody';
            OptionMembers = " ",Treasury,"Safe Custody";
        }
    }

    keys
    {
        key(Key1; "User ID", "Permision Type", "Custodian Of")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjUser: Record User;
}




