//************************************************************************
tableextension 172013 "GLSETUPEXT" extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here

        field(172021; "Journal Approval Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(172146; "Bank Balances"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Posting Date" = field("Date Filter")));
            Caption = 'Bank Balances';
            Editable = false;
            FieldClass = FlowField;
        }
        field(172147; "Pending L.O.P"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Amount (LCY)" where("Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Expected Receipt Date" = field("Date Filter"),
                                                                                Amount = filter(<> 0),
                                                                                "Document Type" = filter(<> Quote)));
            FieldClass = FlowField;
        }
        field(17241; "GjnlBatch Approval No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(17242; "LCY Code Decimals"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(17250; "Base No. Series"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Responsibility Center,Shortcut Dimension 1,Shortcut Dimension 2,Shortcut Dimension 3,Shortcut Dimension 4';
            OptionMembers = " ","Responsibility Center","Shortcut Dimension 1","Shortcut Dimension 2","Shortcut Dimension 3","Shortcut Dimension 4","Shortcut Dimension 5","Shortcut Dimension 6","Shortcut Dimension 7","Shortcut Dimension 8";
        }
        field(17251; "Cash Purchases Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(17252; "Payroll Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17253; "Interbank Transfer Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(17254; "Bulk SMS Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(17255; "Agency Application Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(17256; "CloudPESA Comm Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(17257; "Agent Charges Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(17258; "Mobile Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Charges;
        }
        field(17259; "CloudPESA Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17260; "MPESA Settl Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(17261; "PayBill Settl Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(17265; "File Movement Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(17266; "family account bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(17267; "equity bank acc"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(17268; "coop bank acc"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(17269; "Suspense fb"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(17270; "suspense coop bank"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(17271; "suspense equity"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(17272; "Suspense Paybill"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(17273; "Safaricom Paybill"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(17274; "Transaction Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(17275; "Non Earning Cash BenchMark"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17276; "Earning Bank Cash BenchMark"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17277; "Regulator Miinimum Ratio"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17278; "New Member Suspense"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(17279; "CloudPESA Comm Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17280; "Paybill Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17281; "MPESA Recon Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17282; "Mobile Comm Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17283; "Mobile banking Charge"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}


