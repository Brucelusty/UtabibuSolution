table 173016 "Bank Acc. Recon Line Conv"
{
    Caption = 'Bank Acc. Reconciliation Line';
    Permissions = TableData 1221 = rimd;

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(2; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            TableRelation = "Bank Acc. Reconciliation"."Statement No." WHERE ("Bank Account No."=FIELD("Bank Account No."));
        }
        field(3; "Statement Line No."; Integer)
        {
            Caption = 'Statement Line No.';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; "Statement Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Statement Amount';

            trigger OnValidate()
            begin
                Difference := "Statement Amount" - "Applied Amount";
            end;
        }
        field(8; Difference; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Difference';

            trigger OnValidate()
            begin
                "Statement Amount" := "Applied Amount" + Difference;
            end;
        }
        field(9; "Applied Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Applied Amount';
            Editable = false;

            trigger OnLookup()
            begin
                DisplayApplication;
            end;

            trigger OnValidate()
            begin
                Difference := "Statement Amount" - "Applied Amount";
            end;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Bank Account Ledger Entry,Check Ledger Entry,Difference';
            OptionMembers = "Bank Account Ledger Entry","Check Ledger Entry",Difference;

            trigger OnValidate()
            begin
                IF (Type <> xRec.Type) AND
                   ("Applied Entries" <> 0)
                THEN
                    IF CONFIRM(Text001, FALSE) THEN BEGIN
                        RemoveApplication(xRec.Type);
                        VALIDATE("Applied Amount", 0);
                        "Applied Entries" := 0;
                        "Check No." := '';
                    END ELSE
                        ERROR(Text002);
            end;
        }
        field(11; "Applied Entries"; Integer)
        {
            Caption = 'Applied Entries';
            Editable = false;

            trigger OnLookup()
            begin
                DisplayApplication;
            end;
        }
        field(12; "Value Date"; Date)
        {
            Caption = 'Value Date';
        }
        field(13; "Ready for Application"; Boolean)
        {
            Caption = 'Ready for Application';
        }
        field(14; "Check No."; Code[30])
        {
            Caption = 'Check No.';
        }
        field(15; "Related-Party Name"; Text[50])
        {
            Caption = 'Related-Party Name';
        }
        field(16; "Additional Transaction Info"; Text[100])
        {
            Caption = 'Additional Transaction Info';
        }
        field(17; "Posting Exch. Entry No."; Integer)
        {
            Caption = 'Posting Exch. Entry No.';
            Editable = false;
            TableRelation = "Data Exch.";
        }
        field(18; "Posting Exch. Line No."; Integer)
        {
            Caption = 'Posting Exch. Line No.';
            Editable = false;
        }
        field(20; "Statement Type"; Option)
        {
            Caption = 'Statement Type';
            OptionCaption = 'Bank Reconciliation,Payment Application';
            OptionMembers = "Bank Reconciliation","Payment Application";
        }
        field(21; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";

            trigger OnValidate()
            begin
                TESTFIELD("Applied Amount", 0);
            end;
        }
        field(22; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type"=CONST("G/L Account")) "G/L Account" WHERE ("Account Type"=CONST(Posting),
                                                                                      Blocked=CONST(False))
                                                                                      ELSE IF ("Account Type"=CONST(Customer)) Customer
                                                                                      ELSE IF ("Account Type"=CONST(Vendor)) Vendor
                                                                                      ELSE IF ("Account Type"=CONST("Bank Account")) "Bank Account"
                                                                                      ELSE IF ("Account Type"=CONST("Fixed Asset")) "Fixed Asset"
                                                                                      ELSE IF ("Account Type"=CONST("IC Partner")) "IC Partner";

            trigger OnValidate()
            begin
                TESTFIELD("Applied Amount",0);
                CreateDim(DimMgt.TypeToTableID1("Account Type"),"Account No.");
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
            end;
        }
        field(23;"Transaction Text";Text[140])
        {
            Caption = 'Transaction Text';

            trigger OnValidate()
            begin
                IF ("Statement Type" = "Statement Type"::"Payment Application") OR (Description = '') THEN
                  Description := COPYSTR("Transaction Text",1,MAXSTRLEN(Description));
            end;
        }
        field(24;"Related-Party Bank Acc. No.";Text[50])
        {
            Caption = 'Related-Party Bank Acc. No.';
        }
        field(25;"Related-Party Address";Text[100])
        {
            Caption = 'Related-Party Address';
        }
        field(26;"Related-Party City";Text[50])
        {
            Caption = 'Related-Party City';
        }
        field(31;"Shortcut Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(32;"Shortcut Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(50;"Match Confidence";Option)
        {
            CalcFormula = Max("Applied Payment Entry"."Match Confidence" WHERE ("Statement Type"=FIELD("Statement Type"),
                                                                                "Bank Account No."=FIELD("Bank Account No."),
                                                                                "Statement No."=FIELD("Statement No."),
                                                                                "Statement Line No."=FIELD("Statement Line No.")));
            Caption = 'Match Confidence';
            Editable = false;
            FieldClass = FlowField;
            InitValue = "None";
            OptionCaption = 'None,Low,Medium,High,High - Text-to-Account Mapping,Manual,Accepted';
            OptionMembers = "None",Low,Medium,High,"High - Text-to-Account Mapping",Manual,Accepted;
        }
        field(51;"Match Quality";Integer)
        {
            CalcFormula = Max("Applied Payment Entry".Quality WHERE ("Bank Account No."=FIELD("Bank Account No."),
                                                                     "Statement No."=FIELD("Statement No."),
                                                                     "Statement Line No."=FIELD("Statement Line No."),
                                                                     "Statement Type"=FIELD("Statement Type")));
            Caption = 'Match Quality';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60;"Sorting Order";Integer)
        {
            Caption = 'Sorting Order';
        }
        field(480;"Dimension Set ID";Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(50000;Reconciled;Boolean)
        {

            trigger OnValidate()
            var
                BankAccStatementLine: Record 173017;
            begin
                /*
                IF xRec.Reconciled = FALSE THEN ERROR('Please use the match manually function');
                //IF "Bank Ledger Entry Line No" = TRUE THEN ERROR('Please remove match for this entry from the bank statement');
                IF NOT CONFIRM('Are you sure you want to un-reconcile this entry') THEN ERROR('You have chosen to leave entry reconciled');
                RemoveApplication(Type);
                
                //**changes
                BankAccStatementLine.RESET;
                BankAccStatementLine.SETRANGE("Bank Account No.","Bank Account No.");
                BankAccStatementLine.SETRANGE("Statement No.","Statement No.");
                BankAccStatementLine.SETRANGE("Statement Line No.","Bank Statement Entry Line No");
                IF BankAccStatementLine.FINDFIRST THEN
                BEGIN
                
                  BankAccStatementLine."Applied Amount" -= "Statement Amount";
                  BankAccStatementLine."Applied Entries" := BankAccStatementLine."Applied Entries" - 1;
                
                  BankAccStatementLine.VALIDATE("Statement Amount");
                  BankAccStatementLine.MODIFY;
                END
                */

            end;
        }
        field(50004;"Open Type";Option)
        {
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = " ",Unpresented,Uncredited;
        }
        field(50005;"Bank Ledger Entry Line No";Integer)
        {
        }
        field(50006;"Bank Statement Entry Line No";Integer)
        {
        }
        field(50007;"Reconciling Date";Date)
        {
        }
    }

    keys
    {
        key(Key1;"Statement Type","Bank Account No.","Statement No.","Statement Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = "Statement Amount",Difference;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RemoveApplication(Type);
        ClearPostExchEntries;
        RemoveAppliedPaymentEntries;
        DeletePaymentMatchingDetails;
        FIND;
    end;

    trigger OnInsert()
    begin
        BankAccRecon.GET("Statement Type","Bank Account No.","Statement No.");
        "Applied Entries" := 0;
        VALIDATE("Applied Amount",0);
    end;

    trigger OnModify()
    begin
        IF xRec."Statement Amount" <> "Statement Amount" THEN
          RemoveApplication(Type);
    end;

    trigger OnRename()
    begin
        ERROR(Text000,TABLECAPTION);
    end;

    var
        Text000: Label 'You cannot rename a %1.';
        Text001: Label 'Delete application?';
        Text002: Label 'Update canceled.';
        BankAccLedgEntry: Record "271";
        CheckLedgEntry: Record "272";
        BankAccRecon: Record "273";
        BankAccSetStmtNo: Codeunit "375";
        CheckSetStmtNo: Codeunit "376";
        DimMgt: Codeunit "408";
        AmountWithinToleranceRangeTok: Label '>=%1&<=%2', Comment='Do not translate.';
        AmountOustideToleranceRangeTok: Label '<%1|>%2', Comment='Do not translate.';

   // [Scope('OnPrem')]
    procedure DisplayApplication()
    var
        PaymentApplication: Page "1292";
    begin
        CASE "Statement Type" OF
          "Statement Type"::"Bank Reconciliation":
            CASE Type OF
              Type::"Bank Account Ledger Entry":
                BEGIN
                  BankAccLedgEntry.RESET;
                  BankAccLedgEntry.SETCURRENTKEY("Bank Account No.",Open);
                  BankAccLedgEntry.SETRANGE("Bank Account No.","Bank Account No.");
                  BankAccLedgEntry.SETRANGE(Open,TRUE);
                  BankAccLedgEntry.SETRANGE(
                    "Statement Status",BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                  BankAccLedgEntry.SETRANGE("Statement No.","Statement No.");
                  BankAccLedgEntry.SETRANGE("Statement Line No.","Statement Line No.");
                  PAGE.RUN(0,BankAccLedgEntry);
                END;
              Type::"Check Ledger Entry":
                BEGIN
                  CheckLedgEntry.RESET;
                  CheckLedgEntry.SETCURRENTKEY("Bank Account No.",Open);
                  CheckLedgEntry.SETRANGE("Bank Account No.","Bank Account No.");
                  CheckLedgEntry.SETRANGE(Open,TRUE);
                  CheckLedgEntry.SETRANGE(
                    "Statement Status",CheckLedgEntry."Statement Status"::"Check Entry Applied");
                  CheckLedgEntry.SETRANGE("Statement No.","Statement No.");
                  CheckLedgEntry.SETRANGE("Statement Line No.","Statement Line No.");
                  PAGE.RUN(0,CheckLedgEntry);
                END;
            END;
          "Statement Type"::"Payment Application":
            BEGIN
              TESTFIELD("Statement Amount");
              // PaymentApplication.SetBankAccReconcLine(Rec);
              PaymentApplication.RUNMODAL;
            END;
        END;
    end;

 
    procedure GetCurrencyCode(): Code[10]
    var
        BankAcc: Record "270";
    begin
        IF "Bank Account No." = BankAcc."No." THEN
          EXIT(BankAcc."Currency Code");

        IF BankAcc.GET("Bank Account No.") THEN
          EXIT(BankAcc."Currency Code");

        EXIT('');
    end;

    procedure GetStyle(): Text
    begin
        IF "Applied Entries" <> 0 THEN
          EXIT('Favorable');

        EXIT('');
    end;

  
    procedure ClearPostExchEntries()
    var
        PostExchField: Record "1221";
        BankAccReconciliationLine: Record "274";
    begin
        PostExchField.DeleteRelatedRecords("Posting Exch. Entry No.","Posting Exch. Line No.");

        BankAccReconciliationLine.SETRANGE("Statement Type","Statement Type");
        BankAccReconciliationLine.SETRANGE("Bank Account No.","Bank Account No.");
        BankAccReconciliationLine.SETRANGE("Statement No.","Statement No.");
        // BankAccReconciliationLine.SETRANGE("Posting Exch. Entry No.","Posting Exch. Entry No.");
        BankAccReconciliationLine.SETFILTER("Statement Line No.",'<>%1',"Statement Line No.");
        IF BankAccReconciliationLine.ISEMPTY THEN
          PostExchField.DeleteRelatedRecords("Posting Exch. Entry No.",0);
    end;

    
    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID",STRSUBSTNO('%1 %2 %3',TABLECAPTION,"Statement No.","Statement Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
    end;

 
    procedure CreateDim(Type1: Integer;No1: Code[20])
    var
        SourceCodeSetup: Record "242";
        BankAccReconciliation: Record "273";
        TableID: array [10] of Integer;
        No: array [10] of Code[20];
    begin
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        BankAccReconciliation.GET("Statement Type","Bank Account No.","Statement No.");
        // "Dimension Set ID" :=
        //   DimMgt.GetDefaultDimID(
        //     TableID,No,SourceCodeSetup."Payment Reconciliation Journal",
        //     "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",BankAccReconciliation."Dimension Set ID",DATABASE::"Bank Account");
    end;

   
    procedure SetUpNewLine()
    begin
        "Transaction Date" := WORKDATE;
        "Match Confidence" := "Match Confidence"::None;
        "Document No." := '';
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber,ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber,ShortcutDimCode);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array [8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID",ShortcutDimCode);
    end;

  
    procedure AcceptAppliedPaymentEntriesSelectedLines()
    begin
        IF FINDSET THEN
          REPEAT
            AcceptApplication;
          UNTIL NEXT = 0;
    end;

    
    procedure RejectAppliedPaymentEntriesSelectedLines()
    begin
        IF FINDSET THEN
          REPEAT
            RejectAppliedPayment;
          UNTIL NEXT = 0;
    end;

    
    procedure RejectAppliedPayment()
    begin
        RemoveAppliedPaymentEntries;
        DeletePaymentMatchingDetails;
    end;

   
    procedure AcceptApplication()
    var
        AppliedPaymentEntry: Record "1294";
    begin
        IF Difference > 0 THEN
          TransferRemainingAmountToAccount;

        // AppliedPaymentEntry.FilterAppliedPmtEntry(Rec);
        AppliedPaymentEntry.MODIFYALL("Match Confidence","Match Confidence"::Accepted);
    end;

    procedure RemoveApplication(AppliedType: Option)
    begin
        IF "Statement Type" = "Statement Type"::"Bank Reconciliation" THEN
          CASE AppliedType OF
            Type::"Bank Account Ledger Entry":
              BEGIN
                BankAccLedgEntry.RESET;
                BankAccLedgEntry.SETCURRENTKEY("Bank Account No.",Open);
                BankAccLedgEntry.SETRANGE("Bank Account No.","Bank Account No.");
                BankAccLedgEntry.SETRANGE(Open,TRUE);
                BankAccLedgEntry.SETRANGE(
                  "Statement Status",BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                BankAccLedgEntry.SETRANGE("Statement No.","Statement No.");
                BankAccLedgEntry.SETRANGE("Statement Line No.","Statement Line No.");
                BankAccLedgEntry.LOCKTABLE;
                CheckLedgEntry.LOCKTABLE;
                IF BankAccLedgEntry.FIND('-') THEN
                  REPEAT
                    // BankAccSetStmtNo.RemoveReconNo(BankAccLedgEntry,Rec,TRUE);
                  UNTIL BankAccLedgEntry.NEXT = 0;
                "Applied Entries" := 0;
                VALIDATE("Applied Amount",0);
                MODIFY;
              END;
            Type::"Check Ledger Entry":
              BEGIN
                CheckLedgEntry.RESET;
                CheckLedgEntry.SETCURRENTKEY("Bank Account No.",Open);
                CheckLedgEntry.SETRANGE("Bank Account No.","Bank Account No.");
                CheckLedgEntry.SETRANGE(Open,TRUE);
                CheckLedgEntry.SETRANGE(
                  "Statement Status",CheckLedgEntry."Statement Status"::"Check Entry Applied");
                CheckLedgEntry.SETRANGE("Statement No.","Statement No.");
                CheckLedgEntry.SETRANGE("Statement Line No.","Statement Line No.");
                BankAccLedgEntry.LOCKTABLE;
                CheckLedgEntry.LOCKTABLE;
                IF CheckLedgEntry.FIND('-') THEN
                  REPEAT
                    // CheckSetStmtNo.RemoveReconNo(CheckLedgEntry,Rec,TRUE);
                  UNTIL CheckLedgEntry.NEXT = 0;
                "Applied Entries" := 0;
                VALIDATE("Applied Amount",0);
                "Check No." := '';
                MODIFY;
              END;
          END;
    end;

    procedure SetManualApplication()
    var
        AppliedPaymentEntry: Record "1294";
    begin
        // AppliedPaymentEntry.FilterAppliedPmtEntry(Rec);
        AppliedPaymentEntry.MODIFYALL("Match Confidence","Match Confidence"::Manual)
    end;

    local procedure RemoveAppliedPaymentEntries()
    var
        AppliedPmtEntry: Record "1294";
    begin
        AppliedPmtEntry.SETRANGE("Statement Type","Statement Type");
        AppliedPmtEntry.SETRANGE("Bank Account No.","Bank Account No.");
        AppliedPmtEntry.SETRANGE("Statement No.","Statement No.");
        AppliedPmtEntry.SETRANGE("Statement Line No.","Statement Line No.");
        AppliedPmtEntry.DELETEALL;
        // AppliedPmtEntry.FilterAppliedPmtEntry(Rec);
        AppliedPmtEntry.DELETEALL(TRUE);

        VALIDATE("Applied Amount",0);
        VALIDATE("Applied Entries",0);
        MODIFY(TRUE);
    end;

    local procedure DeletePaymentMatchingDetails()
    var
        PaymentMatchingDetails: Record "1299";
    begin
        PaymentMatchingDetails.SETRANGE("Statement Type","Statement Type");
        PaymentMatchingDetails.SETRANGE("Bank Account No.","Bank Account No.");
        PaymentMatchingDetails.SETRANGE("Statement No.","Statement No.");
        PaymentMatchingDetails.SETRANGE("Statement Line No.","Statement Line No.");
        PaymentMatchingDetails.DELETEALL(TRUE);
    end;

    procedure GetAppliedToName(): Text
    var
        Customer: Record "18";
        Vendor: Record "23";
        GLAccount: Record "15";
        Name: Text;
    begin
        Name := '';

        CASE "Account Type" OF
          "Account Type"::Customer:
            IF Customer.GET("Account No.") THEN
              Name := Customer.Name;
          "Account Type"::Vendor:
            IF Vendor.GET("Account No.") THEN
              Name := Vendor.Name;
          "Account Type"::"G/L Account":
            IF GLAccount.GET("Account No.") THEN
              Name := GLAccount.Name;
        END;

        EXIT(Name);
    end;

 
    procedure AppliedToDrillDown()
    var
        Customer: Record "18";
        Vendor: Record "23";
        GLAccount: Record "15";
    begin
        CASE "Account Type" OF
          "Account Type"::Customer:
            BEGIN
              Customer.GET("Account No.");
              PAGE.RUN(PAGE::"Customer Card",Customer);
            END;
          "Account Type"::Vendor:
            BEGIN
              Vendor.GET("Account No.");
              PAGE.RUN(PAGE::"Vendor Card",Vendor);
            END;
          "Account Type"::"G/L Account":
            BEGIN
              GLAccount.GET("Account No.");
              PAGE.RUN(PAGE::"G/L Account Card",GLAccount);
            END;
        END;
    end;

 
    procedure DrillDownOnNoOfLedgerEntriesWithinAmountTolerance()
    begin
        DrillDownOnNoOfLedgerEntriesBasedOnAmount(AmountWithinToleranceRangeTok);
    end;

 
    procedure DrillDownOnNoOfLedgerEntriesOutsideOfAmountTolerance()
    begin
        DrillDownOnNoOfLedgerEntriesBasedOnAmount(AmountOustideToleranceRangeTok);
    end;

    local procedure DrillDownOnNoOfLedgerEntriesBasedOnAmount(AmountFilter: Text)
    var
        CustLedgerEntry: Record "21";
        VendorLedgerEntry: Record "25";
        MinAmount: Decimal;
        MaxAmount: Decimal;
    begin
        GetAmountRangeForTolerance(MinAmount,MaxAmount);

        CASE "Account Type" OF
          "Account Type"::Customer:
            BEGIN
              GetCustomerLedgerEntriesInAmountRange(CustLedgerEntry,"Account No.",AmountFilter,MinAmount,MaxAmount);
              PAGE.RUN(PAGE::"Customer Ledger Entries",CustLedgerEntry);
            END;
          "Account Type"::Vendor:
            BEGIN
              GetVendorLedgerEntriesInAmountRange(VendorLedgerEntry,"Account No.",AmountFilter,MinAmount,MaxAmount);
              PAGE.RUN(PAGE::"Vendor Ledger Entries",VendorLedgerEntry);
            END;
        END;
    end;

   
    procedure GetCustomerLedgerEntriesInAmountRange(var CustLedgerEntry: Record "21";AccountNo: Code[20];AmountFilter: Text;MinAmount: Decimal;MaxAmount: Decimal): Integer
    var
        BankAccount: Record "270";
    begin
        CustLedgerEntry.SETAUTOCALCFIELDS("Remaining Amount","Remaining Amt. (LCY)");
        BankAccount.GET("Bank Account No.");
        GetApplicableCustomerLedgerEntries(CustLedgerEntry,BankAccount."Currency Code",AccountNo);

        IF BankAccount.IsInLocalCurrency THEN
          CustLedgerEntry.SETFILTER("Remaining Amt. (LCY)",AmountFilter,MinAmount,MaxAmount)
        ELSE
          CustLedgerEntry.SETFILTER("Remaining Amount",AmountFilter,MinAmount,MaxAmount);

        EXIT(CustLedgerEntry.COUNT);
    end;

  
    procedure GetVendorLedgerEntriesInAmountRange(var VendorLedgerEntry: Record "25";AccountNo: Code[20];AmountFilter: Text;MinAmount: Decimal;MaxAmount: Decimal): Integer
    var
        BankAccount: Record "270";
    begin
        VendorLedgerEntry.SETAUTOCALCFIELDS("Remaining Amount","Remaining Amt. (LCY)");

        BankAccount.GET("Bank Account No.");
        GetApplicableVendorLedgerEntries(VendorLedgerEntry,BankAccount."Currency Code",AccountNo);

        IF BankAccount.IsInLocalCurrency THEN
          VendorLedgerEntry.SETFILTER("Remaining Amt. (LCY)",AmountFilter,MinAmount,MaxAmount)
        ELSE
          VendorLedgerEntry.SETFILTER("Remaining Amount",AmountFilter,MinAmount,MaxAmount);

        EXIT(VendorLedgerEntry.COUNT);
    end;

    local procedure GetApplicableCustomerLedgerEntries(var CustLedgerEntry: Record "21";CurrencyCode: Code[10];AccountNo: Code[20])
    begin
        CustLedgerEntry.SETRANGE(Open,TRUE);
        CustLedgerEntry.SETRANGE("Applies-to ID",'');
        CustLedgerEntry.SETFILTER("Document Type",'<>%1&<>%2',
          CustLedgerEntry."Document Type"::Payment,
          CustLedgerEntry."Document Type"::Refund);

        IF CurrencyCode <> '' THEN
          CustLedgerEntry.SETRANGE("Currency Code",CurrencyCode);

        IF AccountNo <> '' THEN
          CustLedgerEntry.SETFILTER("Customer No.",AccountNo);
    end;

    local procedure GetApplicableVendorLedgerEntries(var VendorLedgerEntry: Record "25";CurrencyCode: Code[10];AccountNo: Code[20])
    begin
        VendorLedgerEntry.SETRANGE(Open,TRUE);
        VendorLedgerEntry.SETRANGE("Applies-to ID",'');
        VendorLedgerEntry.SETFILTER("Document Type",'<>%1&<>%2',
          VendorLedgerEntry."Document Type"::Payment,
          VendorLedgerEntry."Document Type"::Refund);

        IF CurrencyCode <> '' THEN
          VendorLedgerEntry.SETRANGE("Currency Code",CurrencyCode);

        IF AccountNo <> '' THEN
          VendorLedgerEntry.SETFILTER("Vendor No.",AccountNo);
    end;

  
    procedure FilterBankRecLines(BankAccRecon: Record "273")
    begin
        RESET;
        SETRANGE("Statement Type",BankAccRecon."Statement Type");
        SETRANGE("Bank Account No.",BankAccRecon."Bank Account No.");
        SETRANGE("Statement No.",BankAccRecon."Statement No.");
    end;

    procedure LinesExist(BankAccRecon: Record "273"): Boolean
    begin
        FilterBankRecLines(BankAccRecon);
        EXIT(FINDSET);
    end;

    procedure GetAppliedToDocumentNo(): Text
    var
        ApplyType: Option "Document No.","Entry No.";
    begin
        EXIT(GetAppliedNo(ApplyType::"Document No."));
    end;

    procedure GetAppliedToEntryNo(): Text
    var
        ApplyType: Option "Document No.","Entry No.";
    begin
        EXIT(GetAppliedNo(ApplyType::"Entry No."));
    end;

    local procedure GetAppliedNo(ApplyType: Option "Document No.","Entry No."): Text
    var
        AppliedPaymentEntry: Record 1294;
        AppliedNumbers: Text;
    begin
        AppliedPaymentEntry.SETRANGE("Statement Type","Statement Type");
        AppliedPaymentEntry.SETRANGE("Bank Account No.","Bank Account No.");
        AppliedPaymentEntry.SETRANGE("Statement No.","Statement No.");
        AppliedPaymentEntry.SETRANGE("Statement Line No.","Statement Line No.");

        AppliedNumbers := '';
        IF AppliedPaymentEntry.FINDSET THEN BEGIN
          REPEAT
            IF ApplyType = ApplyType::"Document No." THEN BEGIN
              IF AppliedPaymentEntry."Document No." <> '' THEN
                IF AppliedNumbers = '' THEN
                  AppliedNumbers := AppliedPaymentEntry."Document No."
                ELSE
                  AppliedNumbers := AppliedNumbers + ', ' + AppliedPaymentEntry."Document No.";
            END ELSE BEGIN
              IF AppliedPaymentEntry."Applies-to Entry No." <> 0 THEN
                IF AppliedNumbers = '' THEN
                  AppliedNumbers := FORMAT(AppliedPaymentEntry."Applies-to Entry No.")
                ELSE
                  AppliedNumbers := AppliedNumbers + ', ' + FORMAT(AppliedPaymentEntry."Applies-to Entry No.");
            END;
          UNTIL AppliedPaymentEntry.NEXT = 0;
        END;

        EXIT(AppliedNumbers);
    end;

    procedure TransferRemainingAmountToAccount()
    var
        AppliedPaymentEntry: Record "1294";
    begin
        TESTFIELD("Account No.");

        // AppliedPaymentEntry.TransferFromBankAccReconLine(Rec);
        AppliedPaymentEntry."Account Type" := "Account Type";
        AppliedPaymentEntry."Account No." := "Account No.";
        AppliedPaymentEntry.VALIDATE("Applied Amount",Difference);
        AppliedPaymentEntry.VALIDATE("Match Confidence",AppliedPaymentEntry."Match Confidence"::Manual);
        AppliedPaymentEntry.INSERT(TRUE);
    end;

    procedure GetAmountRangeForTolerance(var MinAmount: Decimal;var MaxAmount: Decimal)
    var
        BankAccount: Record "270";
        TempAmount: Decimal;
    begin
        BankAccount.GET("Bank Account No.");
        CASE BankAccount."Match Tolerance Type" OF
          BankAccount."Match Tolerance Type"::Amount:
            BEGIN
              MinAmount := "Statement Amount" - BankAccount."Match Tolerance Value";
              MaxAmount := "Statement Amount" + BankAccount."Match Tolerance Value";

              IF ("Statement Amount" >= 0) AND (MinAmount < 0) THEN
                MinAmount := 0
              ELSE
                IF ("Statement Amount" < 0) AND (MaxAmount > 0) THEN
                  MaxAmount := 0;
            END;
          BankAccount."Match Tolerance Type"::Percentage:
            BEGIN
              MinAmount := "Statement Amount" / (1 + BankAccount."Match Tolerance Value" / 100);
              MaxAmount := "Statement Amount" / (1 - BankAccount."Match Tolerance Value" / 100);

              IF "Statement Amount" < 0 THEN BEGIN
                TempAmount := MinAmount;
                MinAmount := MaxAmount;
                MaxAmount := TempAmount;
              END;
            END;
        END;

        MinAmount := ROUND(MinAmount);
        MaxAmount := ROUND(MaxAmount);
    end;
}

