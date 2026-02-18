//************************************************************************
tableextension 172001 "DetailedVendorExt" extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        // Add changes to table fields here
        field(172061; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(172062; Reversed; Boolean)
        {
            CalcFormula = Lookup("Vendor Ledger Entry".Reversed WHERE("Transaction No." = FIELD("Transaction No.")));
            FieldClass = FlowField;
        }
        field(172063; "Reversed By"; Code[50])
        {
            CalcFormula = Lookup("Vendor Ledger Entry"."User ID" WHERE("Transaction No." = FIELD("Transaction No.")));
            FieldClass = FlowField;
        }
        field(172064; Description; Text[250])
        {
            CalcFormula = Lookup("Vendor Ledger Entry".Description WHERE("Transaction No." = FIELD("Transaction No."),
                                                                          "Entry No." = FIELD("Vendor Ledger Entry No.")));
            FieldClass = FlowField;
        }
        field(172065; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(172066; "Application Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,CBS,ATM,Mobile,Internet,MPESA,Equity,Co-op,Family,SMS Banking';
            OptionMembers = " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        }
        field(172067; "Account Type"; Code[30])
        {
            CalcFormula = Lookup(Vendor."Account Type" WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
        field(172068; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(172069; "Member No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(172070; Found; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(172071; "Computer Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(172072; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172073; "Member House Group"; Code[30])
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}


