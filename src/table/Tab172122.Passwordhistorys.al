table 172122 "Password historys"
{
    Caption = 'Password history';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; No; Integer)
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
        }
        field(2; UserName; Code[150])
        {
            Caption = 'UserName';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(3; "Last Password Change"; Date)
        {
            Caption = 'Last Password Change';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if ICTSetup.Get() then
                    "Next Password Change" := CalcDate(ICTSetup."Password Change Dateformula", "Last Password Change")
                else
                    "Next Password Change" := Today();
            end;
        }
        field(4; "Next Password Change"; Date)
        {
            Caption = 'Next Password Change';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                ICTSetup.Reset();
                ICTSetup.SetRange("Enforce Password Expiry", true);
                if ICTSetup.Find('-') then begin
                    "Next Password Change" := CalcDate(ICTSetup."Password Change Dateformula", "Next Password Change");
                    "Last Password Change" := Today();
                    Modify(true);
                    Message('Your next password change date is %1', "Next Password Change");
                end;

            end;
        }
        field(5; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            DataClassification = ToBeClassified;
        }
        field(6; "Changed?"; Boolean)
        {
            Caption = 'Changed?';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    var
        ICTSetup: Record "ICT Setup";


    procedure GetNextLineNo(): Integer
    var
        PasswordHistory: Record "Password History";
    begin
        PasswordHistory.LockTable();

        PasswordHistory.SetCurrentKey(No);
        if PasswordHistory.FindLast() then
            exit(PasswordHistory.No + 1);

        exit(1);
    end;

}
