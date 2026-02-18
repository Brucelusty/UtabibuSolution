//************************************************************************
tableextension 172002 "VendorledgerExt" extends "Vendor Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(172061; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(172062; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(172063; "Application Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,CBS,ATM,Mobile,Internet,MPESA,Equity,Co-op,Family,SMS Banking';
            OptionMembers = " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        }
        field(172064; Alerted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(172065; "Member No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(172066; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(172067; "Cheque Maturity Date"; Date)
        {
            //TODO after Fixing transactions table
            // CalcFormula = Lookup(Transactions."Expected Maturity Date" WHERE(No = FIELD("Document No.")));
            // FieldClass = FlowField;
        }
        field(172068; "Computer Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(172069; "Member No II"; Code[30])
        {
            CalcFormula = Lookup(Vendor."BOSA Account No" WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
    }

    var
        myInt: Integer;
}


