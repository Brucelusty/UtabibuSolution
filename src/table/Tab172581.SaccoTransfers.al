//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172581 "Sacco Transfers"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSetup.Get(0);
                    NoSeriesMgt.TestManual(No);
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Schedule Total"; Decimal)
        {
            CalcFormula = sum("Sacco Transfers Schedule".Amount where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(4; Approved; Boolean)
        {
        }
        field(5; "Approved By"; Code[10])
        {
            trigger OnValidate()
            begin
                if Approved then begin
                    "Approved By" := UserId;
                    // "Approved Date" := Today; 
                end else begin
                    CLEAR("Approved By");

                end;
            end;
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; "Responsibility Center"; Code[10])
        {
        }
        field(9; "Transaction Description"; Code[100])
        {
        }
        field(10; "Source Account Type"; Option)
        {
            OptionCaption = ',Customer,,Bank,G/L ACCOUNT,MEMBER';
            OptionMembers = ,Customer,MWANANGU,Bank,"G/L ACCOUNT",MEMBER;

            trigger OnValidate()
            begin

            end;
        }
        field(11; "Source Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Source Account Type" = const(Customer)) Customer."No." where(ISNormalMember = filter(true))
            else
            if ("Source Account Type" = const(MWANANGU)) Vendor."No." where("BOSA Account No" = field("Member No"))
            else
            if ("Source Account Type" = const("G/L ACCOUNT")) "G/L Account"."No."
            else
            if ("Source Account Type" = const(Bank)) "Bank Account"."No.";

            trigger OnValidate()
            begin
                // IF "Source Account Type"="Source Account Type"::Customer THEN BEGIN
                // Cust.RESET;
                // IF Cust.GET("Source Account No") THEN BEGIN
                // "Source Account Name":=Cust.Name;
                // "Source Transaction Type":="Source Transaction Type"::"38";
                // VALIDATE("Source Account No");
                // END;
                // END;
                //
                // IF "Source Account Type"="Source Account Type"::Bank THEN BEGIN
                // Bank.RESET;
                // IF Bank.GET("Source Account No") THEN BEGIN
                // "Source Account Name":=Bank.Name;
                // "Global Dimension 2 Code":=Bank."Global Dimension 2 Code";
                // END;
                // END;
                //
                // IF "Source Account Type"="Source Account Type"::MWANANGU THEN BEGIN
                // Vend.RESET;
                // IF Vend.GET("Source Account No") THEN BEGIN
                //  Vend.CALCFIELDS(Balance);
                //  IF Vend.Balance<=0 THEN
                //    ERROR('Account has insufficient Balance');
                // "Source Account Name":=Vend.Name;
                // "Global Dimension 2 Code":=Vend."Global Dimension 2 Code";
                // END;
                // END;
                //
                // IF "Source Account Type"="Source Account Type"::MEMBER THEN BEGIN
                memb.Reset;
                if memb.Get("Source Account No.") then begin
                    "Source Account Name" := memb.Name;
                    "Bosa Number" := memb."No.";
                    "Global Dimension 2 Code" := memb."Global Dimension 2 Code";
                end;
                // END;
                //
                //
                // IF "Source Account Type"="Source Account Type"::"G/L ACCOUNT" THEN BEGIN
                // "G/L".RESET;
                // IF "G/L".GET("Source Account No") THEN BEGIN
                // "Source Account Name":="G/L".Name;
                // END;
                // END;
            end;
        }
        field(12; "Source Transaction Type"; Enum TransactionTypesEnum)
        {
            // OptionCaption = ' ,Registration Fee,Share Capital,Deposit Contribution,Interest Due,Interest Paid,Loan,Repayment,Insurance Fee,Dividend,Interest on Deposits,Chama Savings,Rejoining Fee,FOSA Account,Unallocated Funds';
            // OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Interest Due","Interest Paid",Loan,Repayment,"Insurance Fee",Dividend,"Interest on Deposits","Chama Savings","Rejoining Fee","FOSA Account","Unallocated Funds";
            trigger OnValidate()
            begin
                "Header Amount" := 0;
                // if ("Source Transaction Type" = "source transaction type"::"Share Capital") then begin
                //  Error('share Capital is not a transferable account');
                // end;
                if ("Source Transaction Type" = "source transaction type"::"Deposit Contribution") then begin
                    ObjCust.Reset;
                    ObjCust.SetRange("No.", "Source Account No.");
                    if ObjCust.Find('-') then begin
                        ObjCust.CalcFields("Current Shares", "Shares Retained");
                        "Header Amount" := ObjCust."Current Shares";
                    end
                end;
                if ("Source Transaction Type" = "source transaction type"::Dividend) then begin
                    ObjCust.Reset;
                    ObjCust.SetRange("No.", "Source Account No.");
                    if ObjCust.Find('-') then begin
                        ObjCust.CalcFields("Dividend Amount");
                        "Header Amount" := ObjCust."Dividend Amount";
                    end
                end;
                if ("Source Transaction Type" = "source transaction type"::"Programmed Deposits") then begin
                    ObjCust.Reset;
                    ObjCust.SetRange("No.", "Source Account No.");
                    if ObjCust.Find('-') then begin
                        ObjCust.CalcFields("Programmed Deposits");
                        "Header Amount" := ObjCust."Programmed Deposits";
                    end
                end;
                Modify;
            end;
        }
        field(13; "Source Account Name"; Text[50])
        {
        }
        field(14; "Source Loan No"; Code[20])
        {
            TableRelation = if ("Source Account Type" = filter(MWANANGU)) "Loans Register"."Loan  No." where("Client Code" = field("Source Account No."))
            else
            if ("Source Account Type" = filter(Customer)) "Loans Register"."Loan  No." where("Client Code" = field("Source Account No."));

            trigger OnValidate()
            begin
                "Header Amount" := 0;
                ObjLoans.Reset;
                ObjLoans.SetRange("Loan  No.", "Source Loan No");
                if ObjLoans.Find('-') then begin
                    if (("Source Transaction Type" = "source transaction type"::Repayment) or
                      ("Source Transaction Type" = "source transaction type"::"Interest Paid")) then begin
                        ObjLoans.CalcFields("Outstanding Balance", "Outstanding Interest");
                        if (("Source Transaction Type" = "source transaction type"::Repayment) and (ObjLoans."Outstanding Balance" <> 0)) then
                            "Header Amount" := Abs(ObjLoans."Outstanding Balance");
                        if (("Source Transaction Type" = "source transaction type"::"Interest Paid") and (ObjLoans."Outstanding Interest" < 0)) then
                            "Header Amount" := Abs(ObjLoans."Outstanding Interest");
                    end;
                end;
                Modify;
            end;
        }
        field(15; "Created By"; Code[30])
        {
        }
        field(16; Debit; Text[30])
        {
            Editable = false;
        }
        field(17; Refund; Boolean)
        {
        }
        field(18; "Guarantor Recovery"; Boolean)
        {
        }
        field(19; "Payrol No."; Code[30])
        {
        }
        field(20; "Global Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(21; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(22; "Bosa Number"; Code[30])
        {
            Editable = false;
        }
        field(172061; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(172062; "Savings Account Type"; Code[30])
        {
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(172063; "Deposit Debit Options"; Option)
        {
            OptionCaption = ' ,Partial Refund,Loan Recovery,Posting Adjustment';
            OptionMembers = " ","Partial Refund","Loan Recovery","Posting Adjustment";
        }
        field(172064; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    "Member Name" := ObjCust.Name;
                end;

            end;
        }
        field(172065; "Member Name"; Code[100])
        {
        }
        field(172066; "Header Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Charge Transfer Fee" then
                    Validate("Charge Transfer Fee");
            end;
        }
        field(172067; "Receipt No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(172068; "Charge Transfer Fee"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                TransSch: Record "Sacco Transfers Schedule";
            begin

                //IF xRec."Charge Transfer Fee"<>Rec."Charge Transfer Fee" THEN BEGIN
                TransferCharges := 0;
                NetTransferable := 0;
                if "Charge Transfer Fee" then begin
                    TestField("Header Amount");
                    TransferCharges := GetTransferFee;
                    NetTransferable := "Header Amount" - TransferCharges;
                    TransSch.Reset;
                    TransSch.SetRange("No.", Rec.No);
                    if TransSch.FindFirst then begin
                        TransSch.Amount := NetTransferable;
                        TransSch.Modify;
                    end;

                end;
                // END;
            end;
        }
        field(172069; NetTransferable; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172070; TransferCharges; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(172071; "Credit Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Approved or Posted then
            Error('Cannot delete posted or approved batch');
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."BOSA Transfer Nos");
            NoSeriesMgt.InitSeries(NoSetup."BOSA Transfer Nos", xRec."No. Series", 0D, No, "No. Series");
        end;
        "Transaction Date" := Today;
        "Created By" := UserId;
        Debit := 'Credit';
    end;

    trigger OnModify()
    begin
        if Posted then
            Error('Cannot modify a posted batch');
    end;

    trigger OnRename()
    begin
        if Posted then
            Error('Cannot rename a posted batch');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
        Bank: Record "Bank Account";
        Vend: Record Vendor;
        memb: Record Customer;
        "G/L": Record "G/L Account";
        ObjCust: Record Customer;
        ObjLoans: Record "Loans Register";


    procedure GetTransferFee() TransferFee: Decimal
    var
        SaccoGeneralSetUp: Record "Sacco General Set-Up";
        CalculatedTransferFee: Decimal;
        "Net Transferable": Decimal;
    begin
        if "Charge Transfer Fee" then begin

            SaccoGeneralSetUp.Get;
            SaccoGeneralSetUp.TestField("Internal Transfer Fee");
            SaccoGeneralSetUp.TestField("Internal Transfer Fee Account");
            TransferFee := SaccoGeneralSetUp."Internal Transfer Fee";
            CalculatedTransferFee := 0.05 * "Header Amount";
            if TransferFee < CalculatedTransferFee then
                TransferFee := CalculatedTransferFee;
            if TransferFee > "Header Amount" then
                TransferFee := "Schedule Total";
            TransferFee := ROUND(TransferFee, 0.05, '>');
        end;
    end;


    procedure GetNetTransferable() TransferFee: Decimal
    var
        SaccoGeneralSetUp: Record "Sacco General Set-Up";
        CalculatedTransferFee: Decimal;
    begin
    end;
}




