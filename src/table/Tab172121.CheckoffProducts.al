Table 172121 "Checkoff Products"
{
    DrillDownPageID = "Checkoff Product Type";
    LookupPageID = "Checkoff Product Type";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = ' ,Deposits,ShareCapital,Benevolent,Repayment,Interest,Savings,RegistrationFee';
            OptionMembers = " ",Deposits,ShareCapital,Benevolent,Repayment,Interest,Savings,RegistrationFee;
        }
        field(4; "Loan Product"; Code[20])
        {
            TableRelation = "Loan Products Setup".Code;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

