table 173018 "Bank Acc. Reconciliation Conv"
{
    Caption = 'Bank Acc. Reconciliation';
    DataCaptionFields = "Bank Account No.", "Statement No.";
    // LookupPageID = 388;
    Permissions = TableData 1220 = rimd;

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            NotBlank = true;
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                //Added as a control to ensure that only one bank reconciliation per bank exists at a particular time
                BankAccRecon.RESET;
                BankAccRecon.SETRANGE("Bank Account No.", "Bank Account No.");
                IF BankAccRecon.FIND('-') THEN
                    ERROR(Text003);
                // End Addition

                IF "Statement No." = '' THEN BEGIN
                    BankAcc.LOCKTABLE;
                    BankAcc.GET("Bank Account No.");

                    IF "Statement Type" = "Statement Type"::"Payment Application" THEN BEGIN
                        ValidateIfLastPaymentStatementHasNumber(BankAcc);

                        "Statement No." := INCSTR(BankAcc."Last Payment Statement No.");
                        BankAcc."Last Payment Statement No." := "Statement No.";
                    END ELSE BEGIN
                        "Statement No." := INCSTR(BankAcc."Last Statement No.");
                        BankAcc."Last Statement No." := "Statement No.";
                    END;

                    "Balance Last Statement" := BankAcc."Balance Last Statement";
                    BankAcc.MODIFY;
                END;

                CreateDim(DATABASE::"Bank Account", BankAcc."No.");
            end;
        }
        field(2; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            NotBlank = true;

            trigger OnValidate()
            begin
                TESTFIELD("Bank Account No.");
                IF "Statement Type" = "Statement Type"::"Bank Reconciliation" THEN BEGIN
                    BankAcc.LOCKTABLE;
                    BankAcc.GET("Bank Account No.");
                    BankAcc."Last Statement No." := "Statement No.";
                    BankAcc.MODIFY;
                END;
            end;
        }
        field(3; "Statement Ending Balance"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Statement Ending Balance';

            trigger OnValidate()
            begin
                CALCFIELDS("Total Reconciled", "Total Unreconciled");
                "Difference Btw Statements" := "Statement Ending Balance" - ("Balance Last Statement" + "Total Reconciled");

                MESSAGE('Statement Ending Balance is %1', "Statement Ending Balance");
                MESSAGE('Balance Last Statement is %1', "Balance Last Statement");
                MESSAGE('Total Reconciled is %1', "Total Reconciled");
            end;
        }
        field(4; "Statement Date"; Date)
        {
            Caption = 'Statement Date';
        }
        field(5; "Balance Last Statement"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Balance Last Statement';
            Editable = true;

            trigger OnValidate()
            begin
                TESTFIELD("Statement Type", "Statement Type"::"Bank Reconciliation");
                BankAcc.GET("Bank Account No.");
                IF "Balance Last Statement" <> BankAcc."Balance Last Statement" THEN
                    IF NOT
                       CONFIRM(
                         Text002, FALSE,
                         FIELDCAPTION("Balance Last Statement"), BankAcc.FIELDCAPTION("Balance Last Statement"),
                         BankAcc.TABLECAPTION)
                    THEN
                        "Balance Last Statement" := xRec."Balance Last Statement";
            end;
        }
        field(6; "Bank Statement"; BLOB)
        {
            Caption = 'Bank Statement';
        }
        field(7; "Total Balance on Bank Account"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("Bank Account No.")));
            Caption = 'Total Balance on Bank Account';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Total Applied Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            CalcFormula = Sum("Bank Acc. Reconciliation Line"."Applied Amount" WHERE("Statement Type" = FIELD("Statement Type"),
                                                                                      "Bank Account No." = FIELD("Bank Account No."),
                                                                                      "Statement No." = FIELD("Statement No.")));
            Caption = 'Total Applied Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Total Transaction Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Acc. Reconciliation Line"."Statement Amount" WHERE("Statement Type" = FIELD("Statement Type"),
                                                                                        "Bank Account No." = FIELD("Bank Account No."),
                                                                                        "Statement No." = FIELD("Statement No.")));
            Caption = 'Total Transaction Amount';
            Editable = false;
        }
        field(20; "Statement Type"; Option)
        {
            Caption = 'Statement Type';
            OptionCaption = 'Bank Reconciliation,Payment Application';
            OptionMembers = "Bank Reconciliation","Payment Application";
        }
        field(21; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;
        }
        field(50000; "Total Reconciled"; Decimal)
        {
            CalcFormula = Sum("Bank Acc. Reconciliation Line"."Applied Amount" WHERE("Bank Account No." = FIELD("Bank Account No."),
                                                                                      Reconciled = FILTER(True)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Difference Btw Statements"; Decimal)
        {
        }
        field(50002; "Total Unreconciled"; Decimal)
        {
            CalcFormula = Sum("Bank Acc. Reconciliation Line"."Statement Amount" WHERE("Bank Account No." = FIELD("Bank Account No."),
                                                                                        Reconciled = CONST(False)));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Statement Type", "Bank Account No.", "Statement No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('You cannot delete a bank account reconciliation');
        //IF BankAccReconLine.LinesExist(Rec) THEN
        //BankAccReconLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        TESTFIELD("Bank Account No.");
        TESTFIELD("Statement No.");
        BankAccRecon.RESET;
        BankAccRecon.SETRANGE("Statement Type", BankAccRecon."Statement Type");
        BankAccRecon.SETRANGE("Bank Account No.", "Bank Account No.");
        CASE "Statement Type" OF
            "Statement Type"::"Bank Reconciliation":
                IF PostedBankAccStmt.GET("Bank Account No.", "Statement No.") THEN
                    ERROR(Text000, "Statement No.");
            "Statement Type"::"Payment Application":
                IF PostedPaymentReconHdr.GET("Bank Account No.", "Statement No.") THEN
                    ERROR(Text000, "Statement No.");
        END;
    end;

    trigger OnRename()
    begin
        //ERROR(Text001,TABLECAPTION);
    end;

    var
        Text000: Label 'Statement %1 already exists.';
        Text001: Label 'You cannot rename a %1.';
        Text002: Label '%1 is different from %2 on the %3. Do you want to change the value?';
        BankAcc: Record "270";
        BankAccRecon: Record "273";
        BankAccReconLine: Record 173016;
        PostedBankAccStmt: Record "275";
        PostedPaymentReconHdr: Record "1295";
        DimMgt: Codeunit "408";
        DimMgt2: Codeunit DimensionManagement;
        YouChangedDimQst: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        NoBankAccountsMsg: Label 'You have not set up a bank account.\To use the payments import process, set up a bank account.';
        NoBankAccWithFileFormatMsg: Label 'No bank account exists that is ready for import of bank statement files.\Fill the Bank Statement Import Format field on the card of the bank account that you want to use.';
        PostHighConfidentLinesQst: Label 'All imported bank statement lines were applied with high confidence level.\Do you want to post the payment applications?';
        MustHaveValueQst: Label 'The bank account must have a value in %1. Do you want to open the bank account card?';
        Text003: Label 'Another Bank Statement already exists for this Bank finalize with it first';
        BankAccStatementLine: Record 173017;


    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        SourceCodeSetup: Record "242";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        // "Dimension Set ID" :=
        // DimMgt.GetDefaultDimID(
        // TableID,No,SourceCodeSetup."Payment Reconciliation Journal","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",0,0);

        IF (OldDimSetID <> "Dimension Set ID") AND LinesExist THEN BEGIN
            MODIFY;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;


    procedure GetCurrencyCode(): Code[10]
    var
        BankAcc2: Record "270";
    begin
        IF "Bank Account No." = BankAcc2."No." THEN
            EXIT(BankAcc2."Currency Code");

        IF BankAcc2.GET("Bank Account No.") THEN
            EXIT(BankAcc2."Currency Code");

        EXIT('');
    end;


    procedure MatchSingle(DateRange: Integer)
    var
        MatchBankRecLines: Codeunit "1252";
    begin
        //MatchBankRecLines.MatchSingle(Rec,DateRange);//**changes to change matching criteria
        // MatchBankRecLines.MatchSingle2(Rec,DateRange);
    end;


    procedure ImportBankStatement()
    var
        PostingExch: Record "1220";
        ProcessBankAccRecLines: Codeunit "1248";
    begin
        //BankAccStatementLine.RESET;
        //BankAccStatementLine.SETRANGE("Bank Account No.","Bank Account No.");
        //BankAccStatementLine.SETRANGE("Statement No.","Statement No.");
        //BankAccStatementLine.DELETEALL;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit "408";
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        // "Dimension Set ID" :=
        //   DimMgt.EditDimensionSet2(
        //     "Dimension Set ID",STRSUBSTNO('%1 %2',TABLECAPTION,"Statement No."),
        //     "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        BankAccReconciliationLine: Record "274";
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.
        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;

        BankAccReconciliationLine.LOCKTABLE;
        // IF BankAccReconciliationLine.LinesExist(Rec) THEN BEGIN
        IF NOT CONFIRM(YouChangedDimQst) THEN
            EXIT;

        REPEAT
            NewDimSetID :=
              DimMgt.GetDeltaDimSetID(BankAccReconciliationLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
            IF BankAccReconciliationLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                BankAccReconciliationLine."Dimension Set ID" := NewDimSetID;
                DimMgt.UpdateGlobalDimFromDimSetID(
                  BankAccReconciliationLine."Dimension Set ID",
                  BankAccReconciliationLine."Shortcut Dimension 1 Code",
                  BankAccReconciliationLine."Shortcut Dimension 2 Code");
                BankAccReconciliationLine.MODIFY;
            END;
        UNTIL BankAccReconciliationLine.NEXT = 0;
        // END;
    end;


    procedure OpenNewWorksheet()
    var
        BankAccount: Record "270";
        BankAccReconciliation: Record "273";
    begin
        IF NOT SelectBankAccountToUse(BankAccount, FALSE) THEN
            EXIT;

        CreateNewBankPaymentAppBatch(BankAccount."No.", BankAccReconciliation);
        OpenWorksheet(BankAccReconciliation);
    end;

    procedure ImportAndProcessToNewStatement()
    var
        BankAccount: Record 270;
        BankAccReconciliation: Record 273;
        PostingExch: Record 1220;
        PostingExchDef: Record 1222;
    begin
        IF NOT SelectBankAccountToUse(BankAccount, TRUE) THEN
            EXIT;
        BankAccount.GetDataExchDef(PostingExchDef);

        IF NOT PostingExch.ImportFileContent(PostingExchDef) THEN
            EXIT;

        CreateNewBankPaymentAppBatch(BankAccount."No.", BankAccReconciliation);
        //ImportAndProcessStatement(BankAccReconciliation,PostingExch);
    end;

    local procedure ImportAndProcessStatement(BankAccReconciliation: Record 273; PostingExch: Record 1220; ProcessBankAccRecLines: Codeunit "1248"; ProcessBankAccRecLines2: Codeunit "50000")
    var
        ProcessBankAccRecLines3: Codeunit 1248;
    begin
        // IF NOT ProcessBankAccRecLines2.ImportBankStatement(BankAccReconciliation,PostingExch) THEN
        // EXIT;

        COMMIT;
        CODEUNIT.RUN(CODEUNIT::"Match Bank Pmt. Appl.", BankAccReconciliation);

        IF ConfidenceLevelPermitToPost(BankAccReconciliation) THEN
            CODEUNIT.RUN(CODEUNIT::"Bank Acc. Reconciliation Post", BankAccReconciliation)
        ELSE
            OpenWorksheet(BankAccReconciliation);
    end;


    procedure CreateNewBankPaymentAppBatch(BankAccountNo: Code[20]; var BankAccReconciliation: Record "273")
    begin
        BankAccReconciliation.INIT;
        BankAccReconciliation."Statement Type" := BankAccReconciliation."Statement Type"::"Payment Application";
        BankAccReconciliation.VALIDATE("Bank Account No.", BankAccountNo);
        BankAccReconciliation.INSERT(TRUE);
    end;

    local procedure SelectBankAccountToUse(var BankAccount: Record 270; OnlyWithImportFormatSet: Boolean): Boolean
    var
        PaymentBankAccountList: Page 1282;
    begin
        IF OnlyWithImportFormatSet THEN
            BankAccount.SETFILTER("Bank Statement Import Format", '<>%1', '');

        CASE BankAccount.COUNT OF
            0:
                BEGIN
                    IF NOT BankAccount.GET(CantFindBancAccToUseInPaymentFileImport) THEN
                        EXIT(FALSE);

                    EXIT(TRUE);
                END;
            1:
                BankAccount.FINDFIRST;
            ELSE BEGIN
                PaymentBankAccountList.LOOKUPMODE(TRUE);
                PaymentBankAccountList.SETTABLEVIEW(BankAccount);
                IF PaymentBankAccountList.RUNMODAL = ACTION::LookupOK THEN
                    PaymentBankAccountList.GETRECORD(BankAccount)
                ELSE
                    EXIT(FALSE);
            END;
        END;

        EXIT(TRUE);
    end;

    procedure OpenWorksheet(BankAccReconciliation: Record "273")
    var
        BankAccReconciliationLine: Record "274";
    begin
        SetFiltersOnBankAccReconLineTable(BankAccReconciliation, BankAccReconciliationLine);
        PAGE.RUN(PAGE::"Payment Reconciliation Journal", BankAccReconciliationLine);
    end;

    local procedure CantFindBancAccToUseInPaymentFileImport(): Code[20]
    var
        BankAccount: Record "270";
    begin
        IF BankAccount.COUNT = 0 THEN
            MESSAGE(NoBankAccountsMsg)
        ELSE
            MESSAGE(NoBankAccWithFileFormatMsg);

        IF PAGE.RUNMODAL(PAGE::"Payment Bank Account List", BankAccount) = ACTION::LookupOK THEN
            IF BankAccount."Bank Statement Import Format" <> '' THEN
                EXIT(BankAccount."No.");

        EXIT('');
    end;

    local procedure ValidateIfLastPaymentStatementHasNumber(var BankAccount: Record "270")
    begin
        IF BankAccount."Last Payment Statement No." = '' THEN BEGIN
            BankAccount."Last Payment Statement No." := '0';
            BankAccount.MODIFY;
        END;
    end;


    procedure SetFiltersOnBankAccReconLineTable(BankAccReconciliation: Record "273"; var BankAccReconciliationLine: Record "274")
    begin
        BankAccReconciliationLine.FILTERGROUP := 2;
        BankAccReconciliationLine.SETRANGE("Statement Type", BankAccReconciliation."Statement Type");
        BankAccReconciliationLine.SETRANGE("Bank Account No.", BankAccReconciliation."Bank Account No.");
        BankAccReconciliationLine.SETRANGE("Statement No.", BankAccReconciliation."Statement No.");
        BankAccReconciliationLine.FILTERGROUP := 0;
    end;

    local procedure ConfidenceLevelPermitToPost(BankAccReconciliation: Record "273"): Boolean
    var
        BankAccReconciliationLine: Record "274";
    begin
        SetFiltersOnBankAccReconLineTable(BankAccReconciliation, BankAccReconciliationLine);
        IF BankAccReconciliationLine.COUNT = 0 THEN
            EXIT(FALSE);

        BankAccReconciliationLine.SETFILTER("Match Confidence", '<>%1', BankAccReconciliationLine."Match Confidence"::High);
        IF BankAccReconciliationLine.COUNT <> 0 THEN
            EXIT(FALSE);

        IF CONFIRM(PostHighConfidentLinesQst) THEN
            EXIT(TRUE);

        EXIT(FALSE);
    end;

    local procedure LinesExist(): Boolean
    var
        BankAccReconciliationLine: Record "274";
    begin
        // EXIT(BankAccReconciliationLine.LinesExist(Rec));
    end;

    local procedure BankAccountCouldBeUsedForImport(): Boolean
    var
        BankAccount: Record "270";
    begin
        BankAccount.GET("Bank Account No.");
        IF BankAccount."Bank Statement Import Format" <> '' THEN
            EXIT(TRUE);

        IF NOT CONFIRM(MustHaveValueQst, TRUE, BankAccount.FIELDCAPTION("Bank Statement Import Format")) THEN
            EXIT(FALSE);

        IF PAGE.RUNMODAL(PAGE::"Payment Bank Account Card", BankAccount) = ACTION::LookupOK THEN
            IF BankAccount."Bank Statement Import Format" <> '' THEN
                EXIT(TRUE);

        EXIT(FALSE);
    end;
}


