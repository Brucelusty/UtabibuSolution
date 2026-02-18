//************************************************************************
tableextension 172029 "InventorySetupExt" extends "Inventory Setup"
{
    fields
    {
        // Add changes to table fields here
        field(172003; "Item Jnl Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(172004; "Item Jnl Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name;
        }
        field(172005; "Default Location Stock Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172006; "Internal Return Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    var
        myInt: Integer;
}


