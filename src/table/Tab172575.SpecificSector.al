//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172575 "Specific Sector"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Description; Text[1000])
        {
        }
        field(3; No; Code[50])
        {
        }
        field(4; Amount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Loans Register"."Loan Disbursed Amount" where("Sector Specific" = field("code"), "Issued Date" = field("Date Filter")));
        }
        field(5; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; Description, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}




