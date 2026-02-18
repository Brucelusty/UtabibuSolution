//************************************************************************
tableextension 172015 "FaPostingrpEXT" extends "FA Posting Group"
{
    fields
    {
        // Add changes to table fields here
        field(172060; "Depreciation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Straight-Line,Declining-Balance 1,Declining-Balance 2,DB1/SL,DB2/SL,User-Defined,Manual';
            OptionMembers = "Straight-Line","Declining-Balance 1","Declining-Balance 2","DB1/SL","DB2/SL","User-Defined",Manual;
        }
        field(172061; "Depreciation %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172062; "Asset Disposal Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(172063; "Asset Writeoff Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }

    var
        myInt: Integer;
}


