//************************************************************************
tableextension 172030 "BankAccStmtExt" extends "Bank Account Statement"
{
    fields
    {
        // Add changes to table fields here

        field(172000; "Cash Book Balance"; Decimal)
        {
            Editable = false;
        }
        field(172001; "Approver1Signature"; Blob)
        {

        }
        field(172002; "RequesterSignature"; Blob)
        {

        }

    }

    var
        myInt: Integer;
}


