//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172521 "MOBILE Applications"
{

    fields
    {
        field(1; "No."; Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SaccoNoSeries.Get;
                    NoSeriesMgt.TestManual(SaccoNoSeries."Mobile Reg No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No"; Code[30])
        {
            Editable = true;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin

                varMobilebanking.RESET;
                varMobilebanking.SETRANGE(varMobilebanking."Account No", "Account No");
                Accounts.SETRANGE(Accounts."Customer Type", Accounts."Customer Type"::Member);
                IF varMobilebanking.FIND('-') THEN BEGIN
                    if varMobilebanking."Account Name" <> '' then begin
                        IF Accounts."No." <> "No." THEN
                            ERROR('Member already registered.');
                    END;
                end;

                Accounts.Reset();
                Accounts.SetRange(Accounts."No.", "Account No");
                if Accounts.FindFirst() then begin
                    "Account Name" := Accounts.Name;
                    Telephone := Accounts."Mobile Phone No";
                    "ID No" := Accounts."ID No.";
                    "Account No" := Accounts."No.";
                    "Time Applied" := Time;
                    "Date Applied" := Today;
                end;


            end;



        }
        field(3; "Account Name"; Text[50])
        {
            Editable = false;
            Enabled = true;
        }
        field(4; Telephone; Code[20])
        {
            Editable = false;
            Enabled = true;
        }
        field(5; "ID No"; Code[20])
        {
            Editable = false;
            Enabled = true;
        }
        field(6; Status; Option)
        {
            Editable = false;
            Enabled = true;
            OptionCaption = 'Application, Pending Approval,Approved,Rejected';
            OptionMembers = Application," Pending Approval",Approved,Rejected;
        }
        field(7; "Date Applied"; Date)
        {
            Editable = true;
            Enabled = true;
        }
        field(8; "Time Applied"; Time)
        {
            Editable = true;
            Enabled = true;
        }
        field(9; "Created By"; Code[50])
        {
            Editable = true;
        }
        field(10; Sent; Boolean)
        {
            Editable = false;
        }
        field(11; "No. Series"; Code[50])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; SentToServer; Boolean)
        {
            Editable = true;
        }
        field(14; "Last PIN Reset"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Reset By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "PIN Requested"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; Guid; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Username"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Password"; Text[2042])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "OTP Code"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "IsMember"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Application"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Security Code"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Security Answer"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Activated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Whitelisted"; Boolean)
        {

        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            SaccoNoSeries.Get;
            SaccoNoSeries.TestField(SaccoNoSeries."Mobile Reg No.");
            NoSeriesMgt.InitSeries(SaccoNoSeries."Mobile Reg No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;


        "Time Applied" := Time;
        "Created By" := UserId;
        "Date Applied" := Today;
        Guid := CreateGuid;
    end;

    var
        SaccoNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Accounts: Record Customer;
        varMobilebanking: Record "MOBILE Applications";
}




