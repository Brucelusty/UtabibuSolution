//************************************************************************
tableextension 172037 "ApprovalEntryExt" extends "Approval Entry"
{
    fields
    {
        // Add changes to table fields here
        field(33; "First Modified By User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "First Modified On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; Comments; Text[2048])
        {

        }
    }

    var
        myInt: Integer;
}


