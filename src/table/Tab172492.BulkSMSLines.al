//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172492 "Bulk SMS Lines"
{

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = true;
            TableRelation = "Bulk SMS Header".No;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(3; Description; Text[2048])
        {
        }
        field(4; "Message Status"; Option)
        {
            OptionMembers = "Message Not Sent","Message Sent";
        }
        field(5; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";
            trigger OnValidate()
            begin
                Customer.Reset();
                Customer.SetRange("No.", "Member No");
                if Customer.Find('-') then begin
                    Description := Customer.Name;
                    Code := Customer."Mobile Phone No";
                end;
            end;
        }
        field(6; "Send Sms"; Boolean)
        {

        }
        field(7; Group; Code[50])
        {

        }
        field(8; "Branch Code"; Code[30])
        {

        }

    }

    keys
    {
        key(Key1; No, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Customer: Record Customer;

}




