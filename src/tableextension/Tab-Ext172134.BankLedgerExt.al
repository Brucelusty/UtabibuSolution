//************************************************************************
tableextension 172134 "BankLedgerExt" extends "Bank Account Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(51516061; "Running Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516062; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51516063; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(51516064; "Application Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,CBS,ATM,Mobile,Internet,MPESA,Equity,Co-op,Family,SMS Banking';
            OptionMembers = " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        }
        field(51516065; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(51516066; "Computer Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51516067; "Reconciled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5151608; "Transactional code"; Code[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                IsFound: Boolean;
            begin

                Bosareceipt.Reset();
                Bosareceipt.SetRange(Bosareceipt."Account No.", "Transactional code");
                IsFound := Bosareceipt.FindFirst();
                if IsFound then
                    "Transactional code" := Bosareceipt."Cheque No."
                else
                    Error('No matching record found in the "Receipts & Payments" table for the provided Transaction No.');
            end;

        }

    }

    var
        myInt: Integer;
        Bosareceipt: Record "Receipts & Payments";
}
