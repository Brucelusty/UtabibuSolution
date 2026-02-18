tableextension 172135 BankReconHeader extends "Bank Acc. Reconciliation"
{
    fields
    {
        // Add changes to table fields here
        field(5000; "Reconciled Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(true), "Statement No." = field("Statement No."), Reversed = filter(false), "Bank Account No." = field("Bank Account No.")));

        }
        field(5001; "Unreconciled"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(false), "Statement No." = field("Statement No."), Reversed = filter(false), "Bank Account No." = field("Bank Account No.")));

        }
        field(5002; "Cleared Cheques and Payments"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(true), Amount = filter(< 0), Reversed = filter(false), "Statement No." = field("Statement No."), Reversed = filter(false), "Bank Account No." = field("Bank Account No.")));

        }
        field(5003; "Cleared Deposit and Credits"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(true), Amount = filter(> 0), Reversed = filter(false), "Statement No." = field("Statement No."), Reversed = filter(false), "Bank Account No." = field("Bank Account No.")));

        }
        field(5004; "UnCleared Cheques and Payments"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(false), Amount = filter(< 0), Reversed = filter(false), "Statement No." = field("Statement No."), "Bank Account No." = field("Bank Account No.")));

        }
        field(5005; "UnCleared Deposit and Credits"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where(Reconciled = filter(false), Reversed = filter(false), Amount = filter(> 0), "Statement No." = field("Statement No."), "Bank Account No." = field("Bank Account No.")));

        }
        field(5006; "Difference"; Decimal)
        {

        }
        field(5007; "Test Report Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5008; "Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5009; "Statement Start Date"; Date)
        {

        }
        field(5010; "Total Reconciled"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = Sum("Bank Acc. Reconciliation Line"."Applied Amount" WHERE("Bank Account No." = FIELD("Bank Account No."), Reconciled = FILTER(True)));
            Editable = false;
        }
        field(5011; "Difference Btw Statements"; Decimal)
        {

        }
        field(5012; "Total Unreconciled"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = Sum("Bank Acc. Reconciliation Line"."Statement Amount" WHERE("Bank Account No." = FIELD("Bank Account No."), Reconciled = CONST(False)));
            Editable = false;
        }

    }

    var
        myInt: Integer;
        bankrec: Record "Bank Acc. Reconciliation";
        BankAccRecon: Record "Bank Acc. Reconciliation";
        Bankledger: record 271;
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        BankAccSetStmtNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
        StartDate: Date;
        EndDate: Date;
        EventNameTelemetryTxt: Label 'Suggest lines', Locked = true;
        IncludeChecks: Boolean;
        EOFBankAccLedgEntries: Boolean;
        ExcludeReversedEntries: Boolean;

    procedure SetStmtnew(var BankAccRecon2: Record "Bank Acc. Reconciliation")
    begin
        BankAccRecon := BankAccRecon2;
        EndDate := Bankledger."Posting Date";

    end;
}