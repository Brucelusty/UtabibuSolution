Table 172616 "STK PUSH Logs"
{

    fields
    {
        field(1; Entry; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; MerchantRequestID; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; CheckoutRequestID; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; paybillno; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; ResultCode; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; ResultDesc; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; telephone; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; receiptno; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; phonenumber; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; ResponseDescription; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Account No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; Entry)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

