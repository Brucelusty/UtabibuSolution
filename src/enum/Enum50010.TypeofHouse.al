enum 50010 "Type of House"
{
    Extensible = true;

    value(0; " ")
    {
    }
    value(1; "Permanent") { }
    value(2; "Semi-Permanent") { }
    value(3; Temporary) { }
}

enum 50012 "Monthly Income Range"
{
    value(0; "Below 10K") { }
    value(1; "Between 10K and 20K") { }
    value(2; "Between 20K and 30K") { }
    value(3; "Between 30K and 40K") { }
    value(4; "Between 40K and 50K") { }
    value(5; "Above 50K") { }

}

Enum 50013 "True $ False"
{
    value(0; Yes) { }
    value(1; N0) { }
}

enum 50014 " Bank Category"
{
    value(0; " ") { }
    value(1; Cash) { }
    value(2; cheque) { }
    value(3; "M-Pesa") { }
}

enum 50015 "Household"
{
    value(0; " ") { }
    value(1; "Less than 3") { }
    value(2; "between 3 -6") { }
    value(3; "between 7 -10") { }
    value(4; "Above 10") { }
}