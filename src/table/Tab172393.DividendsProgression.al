//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172393 "Dividends Progression"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Gross Dividends"; Decimal)
        {
        }
        field(4; "Witholding Tax"; Decimal)
        {
        }
        field(5; "Net Dividends"; Decimal)
        {
        }
        field(6; "Qualifying Shares"; Decimal)
        {
        }
        field(7; Shares; Decimal)
        {
        }
        field(8; "Net Interest On Deposit"; Decimal) { }
        field(9; "IOD withholding Tax"; Decimal) { }
        field(10; "Dividend Withholding Tax"; Decimal) { }
        field(11; "Chama withholding Tax"; Decimal) { }
        field(12; "Net Interest On Chama"; Decimal) { }
        field(172150; "Share Capital"; Decimal)
        {
        }
        field(172151; "Qualifying Share Capital"; Decimal)
        {
        }
        field(172152; "Gross Interest On Deposit"; Decimal)
        {
        }
        field(172153; "Gross Interest On Chama Saving"; Decimal)
        {
        }
        field(172154; "QualifyingChama"; Decimal)
        {
        }
        field(172155; "Chama saving"; Decimal)
        {
        }
        field(172256; "Interest Type"; Option)
        {
            OptionMembers = " ","Dividends","Interest on Deposit","Other Interest";
        }
    }

    keys
    {
        key(Key1; "Member No", Date, "Interest Type")
        {
            Clustered = true;
            SumIndexFields = "Gross Dividends", "Net Dividends", Shares, "Qualifying Shares", "Witholding Tax";
        }
        key(Key2; Date)
        {
        }
    }

    fieldgroups
    {
    }
}




