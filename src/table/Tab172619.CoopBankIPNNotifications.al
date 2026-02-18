table 172619 "Coop Bank IPN Notifications"
{
    Caption = 'Coop Bank IPN Notifications';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Entry; Integer)
        {
            Caption = 'Entry';
            AutoIncrement = true;
        }
        field(2; TransactionId; Text[100])
        {
            Caption = 'TransactionId';
        }
        field(3; PaymentRef; Text[100])
        {
            Caption = 'PaymentRef';
        }
        field(4; Currency; Text[20])
        {
            Caption = 'Currency';
        }
        field(5; Narration; Text[250])
        {
            Caption = 'Narration';
        }
        field(6; TransactionDate; DateTime)
        {
            Caption = 'TransactionDate';
        }
        field(7; AcctNo; Text[100])
        {
            Caption = 'AcctNo';
        }
        field(8; CustMemoLine1; Text[250])
        {
            Caption = 'CustMemoLine1';
        }
        field(9; CustMemoLine2; Text[250])
        {
            Caption = 'CustMemoLine2';
        }
        field(10; CustMemoLine3; Text[250])
        {
            Caption = 'CustMemoLine3';
        }
        field(11; BookedBalance; Decimal)
        {
            Caption = 'BookedBalance';
        }
        field(12; ClearedBalance; Decimal)
        {
            Caption = 'ClearedBalance';
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(14; EventType; Text[250])
        {
            Caption = 'EventType';
        }
        field(15; ExchangeRate; Text[100])
        {
            Caption = 'ExchangeRate';
        }
        field(16; PostingDate; DateTime)
        {
            Caption = 'PostingDate';
        }
        field(17; ValueDate; DateTime)
        {
            Caption = 'ValueDate';
        }
        field(18; "Document Date"; DateTime)
        {
            Caption = 'Document Date';
        }
    }
    keys
    {
        key(PK; Entry)
        {
            Clustered = true;
        }
    }
}
