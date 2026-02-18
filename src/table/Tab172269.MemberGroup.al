table 172269 "Member Group"
{
    Caption = 'Member Group';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Member Group List";
    LookupPageId = "Member Group List";
    fields
    {
        field(1; No; Code[100])
        {
            Caption = 'No';
            Editable = false;
            trigger OnValidate()

            begin
                if No <> xRec.No then
                    if not Rec.Get(Rec.No) then begin
                        SaccoNoSeries.Get();
                        NoSeriesMgt.TestManual(SaccoNoSeries."Member Group Nos");
                        "No. Series" := '';
                    end;
            end;
        }
        field(2; "Group Name"; Text[1040])
        {
            Caption = 'Group Name';
        }
        field(3; "KRA Pin"; Code[500])
        {
            Caption = 'KRA Pin';
        }
        field(4; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
        }
        field(5; "No. Series"; Code[100])
        {

        }
        field(6; "Created by"; Code[20])
        {
            Editable = false;
        }
        field(7; "Creation TimeDate"; DateTime)
        {
            Editable = false;
        }
    }
    keys
    {
        key(PK; No, "Group Name", "KRA Pin")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(dropdown; No, "KRA Pin", "Group Name") { }
        fieldgroup(Brick; No, "Group Name") { }

    }
    var
        SaccoNoSeries: Record "Sacco No. Series";

        NoseriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if No = '' then begin
            SaccoNoSeries.Get();
            SaccoNoSeries.TestField("Member Group Nos");
            NoSeriesMgt.InitSeries(SaccoNoSeries."Member Group Nos", xRec."No. Series", 0D, No, "No. Series");
            "Created by" := UserId;
            "Creation TimeDate" := CurrentDateTime;
        end;
    end;
}
