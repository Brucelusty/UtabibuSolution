#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50061 "Import Checkoff Distributed"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Lines-Distributed"; "Checkoff Lines-Distributed-NT")
            {
                XmlName = 'Paybill';
                fieldelement(CheckoffNo; "Checkoff Lines-Distributed"."Checkoff No") { }
                fieldelement(PAYROLL_NO; "Checkoff Lines-Distributed"."Payroll No") { }
                fieldelement(MemberNo; "Checkoff Lines-Distributed"."Member No") { }
                fieldelement(REGFEE; "Checkoff Lines-Distributed".REGFEE) { }

                fieldelement(Shares; "Checkoff Lines-Distributed".Deposits) { }
                fieldelement(Deposits; "Checkoff Lines-Distributed".SHARES) { }
                fieldelement(DL_P; "Checkoff Lines-Distributed".DL_P) { }
                fieldelement(DL_I; "Checkoff Lines-Distributed".DL_I) { }
                fieldelement(NL_P; "Checkoff Lines-Distributed".NL_P) { }
                fieldelement(NL_I; "Checkoff Lines-Distributed".NL_I) { }
                fieldelement(Em_P; "Checkoff Lines-Distributed".EMER_P) { }
                fieldelement(Em_I; "Checkoff Lines-Distributed".EMER_I) { }
                fieldelement(schoolFee_P; "Checkoff Lines-Distributed".SchoolF_P) { }
                fieldelement(SchoolFee_I; "Checkoff Lines-Distributed".SchoolF_I) { }
                fieldelement(SuperSaverP; "Checkoff Lines-Distributed".SuperSL_P) { }
                fieldelement(SuperSaver_I; "Checkoff Lines-Distributed".SuperSL_I) { }
                fieldelement(SpacialL_P; "Checkoff Lines-Distributed".SpecialL_P) { }
                fieldelement(Special_I; "Checkoff Lines-Distributed".SpecialL_I) { }
                fieldelement(HouseHL_P; "Checkoff Lines-Distributed".HouseHL_P) { }
                fieldelement(HouseHL_I; "Checkoff Lines-Distributed".HouseHL_I) { }
                fieldelement("IL-P"; "Checkoff Lines-Distributed".DeFL_P) { }
                fieldelement("IL-I"; "Checkoff Lines-Distributed".DeFL_I) { }
                fieldelement(SAdvanceL_P; "Checkoff Lines-Distributed".SAdvanceL_P) { }
                fieldelement(SAdvanceL_I; "Checkoff Lines-Distributed".SAdvanceL_I) { }
                fieldelement(Mavuno_P; "Checkoff Lines-Distributed".Mavuno_L) { }
                fieldelement(Mavuno_I; "Checkoff Lines-Distributed".Mavuna_I) { }
                fieldelement(Dhamana_P; "Checkoff Lines-Distributed".DhamanaL_P) { }
                fieldelement(Dhamana_I; "Checkoff Lines-Distributed".DhamanaL_I) { }
                fieldelement("PremiumL-P"; "Checkoff Lines-Distributed"."PremiumL-P") { }
                fieldelement("PremiumL-I"; "Checkoff Lines-Distributed"."PremiumL-I") { }
                fieldelement("SPL-P"; "Checkoff Lines-Distributed".HarakaL_P) { }
                fieldelement("SPL-I"; "Checkoff Lines-Distributed".HarakaL_I) { }
                fieldelement(Jumbo_P; "Checkoff Lines-Distributed".JumboL_P) { }
                fieldelement(Jumbo_I; "Checkoff Lines-Distributed".JumboL_I) { }
                fieldelement(DependandSavings_1; "Checkoff Lines-Distributed"."Dependand Savings 1") { }
                fieldelement(DependandSavings_2; "Checkoff Lines-Distributed"."Dependand Savings 2") { }
                fieldelement(DependandSavings_3; "Checkoff Lines-Distributed"."Dependand Savings 3") { }
                fieldelement(HolidaySavings; "Checkoff Lines-Distributed"."Holiday Savings") { }
                fieldelement(UtafitiHousing; "Checkoff Lines-Distributed"."Utafiti Housing") { }
                fieldelement(UnAllocated; "Checkoff Lines-Distributed".BENEVOLENT) { }



            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

