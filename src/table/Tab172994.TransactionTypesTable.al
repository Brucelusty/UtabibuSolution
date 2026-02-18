//************************************************************************
table 172994 "Transaction Types Table"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Transaction Type"; Enum TransactionTypesEnum)
        {
            // DataClassification = ToBeClassified;
            // OptionCaption = ' ,Registration Fee,Share Capital,Deposit Contribution,Interest Due,Interest Paid,Loan,Repayment,Insurance Fee,Dividend,Interest on Deposits,Chama Savings,Rejoining Fee,FOSA Account,Unallocated Funds';
            // OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Interest Due","Interest Paid",Loan,Repayment,"Insurance Fee",Dividend,"Interest on Deposits","Chama Savings","Rejoining Fee","FOSA Account","Unallocated Funds";

            // ;
        }
        field(2; "Posting Group Code"; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
    }

    keys
    {
        key(Key1; "Transaction Type")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}


