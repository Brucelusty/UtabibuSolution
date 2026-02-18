//************************************************************************
tableextension 172031 "BankStmtLineExt" extends "Bank Account Statement Line"
{
    fields
    {
        // Add changes to table fields here
        field(172000; Reconciled; Boolean)
        {
        }
        field(172001; "Document Date"; Date)
        {
        }
        field(172002; Debit; Decimal)
        {
            CalcFormula = sum("Bank Account Statement Line"."Statement Amount" where("Statement Amount" = filter(> 0),
                                                                                      "Bank Account No." = field("Bank Account No."),
                                                                                      "Statement Line No." = field("Statement Line No.")));
            FieldClass = FlowField;
        }
        field(172003; Credit; Decimal)
        {
            CalcFormula = sum("Bank Account Statement Line"."Statement Amount" where("Statement Amount" = filter(< 0),
                                                                                      "Bank Account No." = field("Bank Account No."),
                                                                                      "Statement Line No." = field("Statement Line No.")));
            FieldClass = FlowField;
        }
        field(172004; "Open Type"; Option)
        {
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = " ",Unpresented,Uncredited;
        }
    }

    var
        myInt: Integer;
}


