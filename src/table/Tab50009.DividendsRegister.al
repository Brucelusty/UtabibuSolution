//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50009 "Dividends Register"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
        }
        field(2; "Posting Date"; Date)
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
        field(9; "Dividend Year"; Integer) { }
        field(10; "Employer Code"; Code[100]) { }
        field(11; "Member Name"; text[100]) { }

        field(12; "Employer Name"; Text[100]) { }

        field(13; "Document No"; Code[100]) { }
        field(14; "Total Dividend"; Decimal) { }
        field(15; "IOD withholding Tax"; Decimal) { }
        field(16; "Dividend Withholding Tax"; Decimal) { }

        field(17; "Chama withholding Tax"; Decimal) { }
        field(18; "Net Interest On Chama"; Decimal) { }
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
    }

    keys
    {
        key(Key1; "Member No", "Posting Date")
        {
            Clustered = true;
            SumIndexFields = "Gross Dividends", "Net Dividends", Shares, "Qualifying Shares", "Witholding Tax";
        }
        key(Key2; "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}




