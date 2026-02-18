table 172079 "Boarb Payments Lines"
{
    Caption = 'Board Payments Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No';
        }
        field(2; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
        }
        field(3; "Amount Paid"; Decimal)
        {
            Caption = 'Amount Paid';
            trigger OnValidate()
            begin
                InsiderLending33.Reset();
                InsiderLending33.SetRange("Member No", "Board No");
                if InsiderLending33.Find('-') then begin
                    "Net  Amount" := "Amount Paid";
                end;

            end;
        }
        field(4; "Paye Amount"; Decimal)
        {
            Caption = 'Paye Amount';
            trigger OnValidate()
            begin
                InsiderLending33.Reset();
                InsiderLending33.SetRange("Member No", "Board No");
                if InsiderLending33.Find('-') then begin
                    "Net  Amount" := "Net  Amount" - "Paye Amount";
                end;
            end;
        }
        field(5; "Housing Leavy"; Decimal)
        {
            Caption = 'Housing Leavy';
            trigger OnValidate()
            begin
                InsiderLending33.Reset();
                InsiderLending33.SetRange("Member No", "Board No");
                if InsiderLending33.Find('-') then begin
                    "Net  Amount" := "Net  Amount" - "Housing Leavy";
                end;
            end;
        }
        field(6; "Payment Descrition"; Text[2048])
        {
            Caption = 'Payment Descrition';
        }
        field(7; "Net  Amount"; Decimal)
        {
            Editable = false;
        }
        field(8; "Board No"; code[20])

        {
            TableRelation = InsiderLending."Member No";
            trigger OnValidate()
            begin
                InsiderLending33.Reset();
                InsiderLending33.SetRange("Member No", "Board No");
                if InsiderLending33.FindFirst() then begin
                    Name := InsiderLending33."Member Name";
                    "Staff\Board" := InsiderLending33."Board/Staff";
                end;
            end;
        }
        field(10; "Name"; Text[100])
        {
            Editable = false;
        }

        field(11; "Transaction Type"; Enum TransactionTypesEnum)
        {

        }

        field(12; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Board No"), "Outstanding Balance" = filter(> 0));
        }
        field(13; "Member Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                InsiderLending33.Reset();
                InsiderLending33.SetRange("Member No", "Board No");
                if InsiderLending33.Find('-') then begin
                    "Net  Amount" := "Net  Amount" - "Member Amount";
                end;
            end;
        }
        field(14; "Staff\Board"; Option)
        {
            OptionCaption = ' ,Staff,Board Member';
            OptionMembers = ,Staff,"Board Member";
        }
    }
    keys
    {
        key(PK; "Document No", "Amount Paid", "Payment Descrition", "Board No")
        {
            Clustered = true;
        }
    }
    var
        InsiderLending33: Record InsiderLending;

}
