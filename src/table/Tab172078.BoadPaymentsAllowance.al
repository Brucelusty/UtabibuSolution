table 172078 "Boad Payments Allowance"
{
    Caption = 'Board Payments Allowance';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            Editable = false;
        }
        field(2; Description; Text[2048])
        {
            Caption = 'Description';
        }
        field(3; "Paying Bank"; Code[20])
        {
            Caption = 'Paying Bank';
            TableRelation = "Bank Account"."No.";
            trigger OnValidate()
            var
                Banks: Record "Bank Account";
            begin
                if Banks.get("Paying Bank") then begin
                    "Paying Bank Name" := Banks.Name;
                end;
            end;
        }
        field(4; "Paying Bank Name"; Text[50])
        {
            Caption = 'Paying Bank Name';
            Editable = false;
        }
        field(5; "Posted"; Boolean)
        {
            Editable = false;

        }
        field(6; "No. Series"; Code[20])
        {

        }
        field(7; "Created By"; Code[20])
        {

        }
        field(8; "Posting Date"; Date)
        {

        }
        field(9; "Total Amount Payable"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Boarb Payments Lines"."Net  Amount" where("Document No" = field(No)));
        }
        field(10; "Status"; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
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
        SalesSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        SalesSetup.Get;
        SalesSetup.TestField(SalesSetup."Study Form Nos");
        NoSeriesMgt.InitSeries(SalesSetup."Study Form Nos", xRec.No, 0D, No, "No. Series");
        "Created By" := UserId;
    end;
}
