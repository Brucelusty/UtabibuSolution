page 17446 "Bank Acc. Reconciliation Conv"
{
    Caption = 'Bank Acc. Reconciliation';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Bank,Matching';
    SaveValues = false;
    SourceTable = "Bank Acc. Reconciliation";
    SourceTableView = WHERE("Statement Type" = CONST("Bank Reconciliation"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(BankAccountNo; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                    trigger OnValidate()
                    var
                        BankAccReconciliationLine: record "Bank Acc. Reconciliation Line";
                    begin
                        if BankAccReconciliationLine.BankStatementLinesListIsEmpty(Rec."Statement No.", Rec."Statement Type".AsInteger(), Rec."Bank Account No.") then
                            CreateEmptyListNotification();

                        if not WarnIfOngoingBankReconciliations(Rec."Bank Account No.") then
                            Error('');
                        CurrPage.ApplyBankLedgerEntries.Page.AssignBankAccReconciliation(Rec);
                        BankAccountNoIsEditable := false;
                        CheckBankAccLedgerEntriesAlreadyMatched();
                        CurrPage.Update(false);
                    end;
                }
                field(StatementNo; Rec."Statement No.")
                {
                    Caption = 'Statement No.';
                    Editable = false;
                }
                field(StatementDate; Rec."Statement Date")
                {
                    Caption = 'Statement Date';
                }
                field(BalanceLastStatement; Rec."Balance Last Statement")
                {
                    Caption = 'Balance Last Statement';
                    Editable = false;
                }
                field(StatementEndingBalance; Rec."Statement Ending Balance")
                {
                    Caption = 'Statement Ending Balance';
                    trigger OnValidate()
                    begin

                        rec."Difference Btw Statements" := (Rec."Statement Ending Balance" - rec."Balance Last Statement") - rec."Total Reconciled";
                    end;
                }
                field("Difference Btw Statements"; Rec."Difference Btw Statements")
                {
                    Editable = false;
                }
                field("Total Unreconciled"; Rec."Total Unreconciled")
                {
                }
                field("Total Reconciled"; Rec."Total Reconciled")
                {
                    Visible = true;
                    trigger OnValidate()
                    begin
                        Rec."Statement Ending Balance" := rec."Total Reconciled" + rec."Balance Last Statement";
                    end;
                }
            }
            // part(StmtLine; "Bank Acc. Recon Lines Conv")
            // {
            //     Caption = 'Bank Reconciliation Lines';
            //     SubPageLink = "Bank Account No."=FIELD("Bank Account No."),
            //                   "Statement No."=FIELD("Statement No.");
            // }
            part(Stmt; "Bank Acc. Reconciliation Lines")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Reconciliation Lines';
                SubPageLink = "Bank Account No." = field("Bank Account No."),
                                "Statement No." = field("Statement No.");
            }
            // part(StmtLine; "Bank Acc. Reconciliation Lines")
            // {
            //     Caption = 'Bank Reconciliation Lines';
            //     SubPageLink = "Bank Account No."=FIELD("Bank Account No."),
            //                   "Statement No."=FIELD("Statement No.");
            // }
            group(Conv)
            {
                part(ApplyBankLedgerEntries; 381)
                {
                    Caption = 'Bank Account Ledger Entries';
                    SubPageLink = "Bank Account No." = FIELD("Bank Account No."),
                                  Open = CONST(True),
                                  "Statement Status" = FILTER(Open | "Bank Acc. Entry Applied" | "Check Entry Applied");
                }
                part(StmtLine2; "Bank Acc Statement Lines")
                {
                    Caption = 'Bank Statement Lines';
                    SubPageLink = "Bank Account No." = FIELD("Bank Account No."),
                                  "Statement No." = FIELD("Statement No.");
                }
            }
        }
        area(factboxes)
        {
            // systempart(;Links)
            // {
            //     Visible = false;
            // }
            // systempart(;Notes)
            // {
            //     Visible = false;
            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Recon.")
            {
                Caption = '&Recon.';
                Image = BankAccountRec;
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page 370;
                    RunPageLink = "No." = FIELD("Bank Account No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Clear Lines")
                {
                    Caption = 'Clear Bank Rec. lines';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Image = ClearLog;
                    Visible = false;

                    trigger OnAction()
                    var
                        bankRec: Record "Bank Acc. Reconciliation Line";
                    begin
                        bankRec.Reset();
                        bankRec.SetRange("Bank Account No.", Rec."Bank Account No.");
                        bankRec.SetRange("Statement No.", Rec."Statement No.");
                        if bankRec.find('-') then begin
                            repeat
                                bankRec.DELETE;
                            until bankRec.NEXT = 0;
                        end;
                    end;
                }
                action("Statement Lines")
                {
                    Caption = 'Statement Lines';
                    Image = Splitlines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Acc Statement Lines List";
                    RunPageLink = "Bank Account No." = FIELD("Bank Account No."),
                                  "Statement No." = FIELD("Statement No.");
                }
                action(SuggestLines)
                {
                    Caption = 'Suggest Lines';
                    Ellipsis = true;
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        BankRecLines: Record "274";
                        MatchBankRecLines: Codeunit "1252";
                        TempBankAccountLedgerEntry: Record 271 temporary;
                    begin

                        BankRecLines.RESET;
                        BankRecLines.SETRANGE("Bank Account No.", Rec."Bank Account No.");
                        BankRecLines.SETRANGE("Statement No.", Rec."Statement No.");

                        IF BankRecLines.FIND('-') THEN BEGIN
                            // IF BankRecLines.Reconciled=FALSE THEN
                            REPEAT
                            // BankRecLines.DELETE;
                            UNTIL BankRecLines.NEXT = 0;
                        END;
                        // COMMIT;

                        currentStatement := Rec."Statement No.";

                        BankEntry.RESET;
                        BankEntry.SETRANGE(BankEntry."Bank Account No.", Rec."Bank Account No.");
                        BankEntry.SETRANGE(BankEntry.Open, TRUE);
                        //BankEntry.SETRANGE(BankEntry."Bank Account NoBankEntry."Statement Status"::"Bank Acc. Entry Applied");.",'BK0003');
                        // BankEntry.SETRANGE(BankEntry."Statement Status", BankEntry."Statement Status"::"Bank Acc. Entry Applied|");
                        IF BankEntry.FIND('-') THEN BEGIN
                            IF ((BankEntry."Statement Status" = BankEntry."Statement Status"::Open) or (BankEntry."Statement Status" = BankEntry."Statement Status"::"Bank Acc. Entry Applied") or (BankEntry."Statement Status" = BankEntry."Statement Status"::"Check Entry Applied")) and (BankEntry."Statement No." <> currentStatement) THEN begin
                                REPEAT
                                    BankEntry."Statement Status" := BankEntry."Statement Status"::Open;
                                    BankEntry."Statement No." := '';
                                    BankEntry."Statement Line No." := 0;
                                    BankEntry.MODIFY;
                                UNTIL BankEntry.NEXT = 0;
                            end;
                        END;
                        COMMIT;

                        SuggestBankAccStatement.SetStmt(Rec);
                        SuggestBankAccStatement.RUNMODAL;
                        CLEAR(SuggestBankAccStatement);

                        /*//MatchBankRecLines.RemoveMatch(TempBankAccReconciliationLine,TempBankAccountLedgerEntry);
                        BankRecLines.RESET;
                        BankRecLines.SETRANGE("Bank Account No.","Bank Account No.");
                        BankRecLines.SETRANGE("Statement No.","Statement No.");
                        IF BankRecLines.FINDSET THEN
                        REPEAT
                          MatchBankRecLines.RemoveMatch(BankRecLines,TempBankAccountLedgerEntry);
                        UNTIL BankRecLines.NEXT =0;
                        BankRecLines.RESET;
                        BankRecLines.SETRANGE("Bank Account No.","Bank Account No.");
                        BankRecLines.SETRANGE("Statement No.","Statement No.");
                        //BankRecLines.SETRANGE(BankRecLines."Statement Amount","Statement Amount");
                        IF BankRecLines.Reconciled=FALSE THEN
                        BankRecLines.DELETEALL;
                        COMMIT;*/

                    end;
                }
                action("Transfer to General Journal")
                {
                    Caption = 'Transfer to General Journal';
                    Ellipsis = true;
                    Image = TransferToGeneralJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin

                        // SetBankAccRecon(Rec);
                        TransferToGLJnl.RUN;
                    end;
                }
            }
            group("Ba&nk")
            {
                Caption = 'Ba&nk';
                action(ImportBankStatement)
                {
                    Caption = 'Import Bank Statement';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record "274" temporary;
                        TempBankAccountLedgerEntry: Record "271" temporary;
                        MatchBankRecLines: Codeunit "1252";
                        BankRecLines: Record "274";
                    begin
                        /*BankRecLines.RESET;
                        BankRecLines.SETRANGE("Statement Type","Statement Type");
                        BankRecLines.SETRANGE("Bank Account No.","Bank Account No.");
                        BankRecLines.SETRANGE("Statement No.","Statement No.");
                        IF BankRecLines.FINDSET THEN
                        REPEAT
                          MatchBankRecLines.RemoveMatch(BankRecLines,TempBankAccountLedgerEntry);
                        UNTIL BankRecLines.NEXT = 0;
                        ImportBankStatement;
                        //to be continued here
                        {
                        SuggestBankAccStatement.SetStmt(Rec);
                        SuggestBankAccStatement.RUNMODAL;
                        CLEAR(SuggestBankAccStatement);
                        }
                        */
                        XMLPORT.RUN(50514);

                    end;
                }
            }
            group("M&atching")
            {
                Caption = 'M&atching';
                action(MatchAuto)
                {
                    Caption = 'AutoMatch';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ReconCount := 0;
                        ReconcilliationBuffer.RESET;
                        ReconcilliationBuffer.SETRANGE(ReconcilliationBuffer."Bank Account No.", Rec."Bank Account No.");
                        ReconcilliationBuffer.SETRANGE(ReconcilliationBuffer."Statement No.", Rec."Statement No.");
                        IF ReconcilliationBuffer.FIND('-') THEN BEGIN
                            // IF ReconcilliationBuffer."Check No."='NAV9JFYZ6Z' THEN BEGIN

                            REPEAT
                                ObjReconcilliationLine.RESET;
                                ObjReconcilliationLine.SETRANGE(ObjReconcilliationLine."Bank Account No.", ReconcilliationBuffer."Bank Account No.");
                                ObjReconcilliationLine.SETRANGE(ObjReconcilliationLine."Statement No.", ReconcilliationBuffer."Statement No.");
                                ObjReconcilliationLine.SETRANGE(ObjReconcilliationLine."Document No.", ReconcilliationBuffer."Check No.");
                                // ObjReconcilliationLine.SETRANGE(ObjReconcilliationLine."Transaction Date",ReconcilliationBuffer."Transaction Date");
                                ObjReconcilliationLine.SETRANGE(ObjReconcilliationLine."Statement Amount", ReconcilliationBuffer."Statement Amount");

                                IF ObjReconcilliationLine.FIND('-') THEN BEGIN
                                    // REPEAT
                                    ObjReconcilliationLine.Reconciled := TRUE;
                                    ObjReconcilliationLine."Reconciling Date" := TODAY;
                                    ObjReconcilliationLine."Applied Amount" := ReconcilliationBuffer."Statement Amount";
                                    ObjReconcilliationLine.Difference := 0;
                                    ObjReconcilliationLine."Applied Entries" := 1;
                                    ObjReconcilliationLine.MODIFY;
                                    ReconCount := ReconCount + 1;

                                    ReconcilliationBuffer2.RESET;
                                    ReconcilliationBuffer2.SETRANGE(ReconcilliationBuffer2."Bank Account No.", ObjReconcilliationLine."Bank Account No.");
                                    ReconcilliationBuffer2.SETRANGE(ReconcilliationBuffer2."Statement No.", ObjReconcilliationLine."Statement No.");
                                    ReconcilliationBuffer2.SETRANGE(ReconcilliationBuffer2."Check No.", ObjReconcilliationLine."Document No.");
                                    ReconcilliationBuffer2.SETRANGE(ReconcilliationBuffer2."Statement Amount", ObjReconcilliationLine."Statement Amount");
                                    IF ReconcilliationBuffer2.FINDFIRST() THEN BEGIN
                                        ReconcilliationBuffer2.Reconciled := TRUE;
                                        ReconcilliationBuffer2."Reconciling Date" := TODAY;
                                        ReconcilliationBuffer2.Difference := 0;
                                        ReconcilliationBuffer2."Applied Entries" := 1;
                                        ReconcilliationBuffer2.MODIFY;
                                    END;

                                    //UNTIL ObjReconcilliationLine.NEXT=0;
                                END;
                            UNTIL ReconcilliationBuffer.NEXT = 0;

                            //END//Testing
                        END;
                        MESSAGE('Process Completed successfully. %1 items found a match', ReconCount);
                    end;
                }
                action(MatchAutomatically)
                {
                    Caption = 'Match Automatically';
                    Image = MapAccounts;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.SETRANGE("Statement Type", Rec."Statement Type");
                        Rec.SETRANGE("Bank Account No.", Rec."Bank Account No.");
                        Rec.SETRANGE("Statement No.", Rec."Statement No.");
                        REPORT.RUN(REPORT::"Match Bank Entries", TRUE, TRUE, Rec);
                    end;
                }
                action(MatchManually)
                {
                    Caption = 'Match Manually';
                    Image = CheckRulesSyntax;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record "Bank Account Statement Line" temporary;
                        TempBankAccountLedgerEntry: Record "271" temporary;
                        MatchBankRecLines: Codeunit "1252";
                        TempBankAccReconciliationLine2: Record "274" temporary;
                        BankAccountLedgerEntry: Record "271";
                        bankAccStatementLine: Record "Bank Account Statement Line";
                    begin
                        /*
                        CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                        CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
                        MatchBankRecLines.MatchManually(TempBankAccReconciliationLine,TempBankAccountLedgerEntry);
                        */
                        bankAccStatementLine.RESET;
                        bankAccStatementLine.SETRANGE("Bank Account No.", Rec."Bank Account No.");
                        bankAccStatementLine.SETRANGE("Statement No.", Rec."Statement No.");
                        IF NOT bankAccStatementLine.FINDSET THEN BEGIN
                            //   CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine2);
                            BankAccountLedgerEntry.RESET;
                            BankAccountLedgerEntry.SETRANGE("Entry No.", TempBankAccReconciliationLine2."Bank Ledger Entry Line No");
                            IF BankAccountLedgerEntry.FINDSET THEN
                                MatchBankRecLines.MatchManually(TempBankAccReconciliationLine2, BankAccountLedgerEntry);
                        END
                        ELSE BEGIN
                            //   CurrPage.StmtLine2.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                            CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
                            //   MatchBankRecLines.MatchManually2(TempBankAccReconciliationLine,TempBankAccountLedgerEntry);
                        END

                    end;
                }
                action(RemoveMatch)
                {
                    Caption = 'Remove Match';
                    Image = RemoveContacts;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        TempBankAccReconciliationLine: Record 173016 temporary;
                        TempBankAccountLedgerEntry: Record 271 temporary;
                        MatchBankRecLines: Codeunit 1252;
                        bankAccStatementLine: Record 173017;
                        TempBankAccReconciliationLine2: Record 274 temporary;
                        BankAccountLedgerEntry: Record 271;
                    begin

                        /*CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                        CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
                        MatchBankRecLines.RemoveMatch(TempBankAccReconciliationLine,TempBankAccountLedgerEntry);
                         */
                        bankAccStatementLine.RESET;
                        bankAccStatementLine.SETRANGE("Bank Account No.", Rec."Bank Account No.");
                        bankAccStatementLine.SETRANGE("Statement No.", Rec."Statement No.");
                        IF NOT bankAccStatementLine.FINDSET THEN BEGIN
                            //   CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine2);
                            BankAccountLedgerEntry.RESET;
                            BankAccountLedgerEntry.SETRANGE("Entry No.", TempBankAccReconciliationLine2."Bank Ledger Entry Line No");
                            IF BankAccountLedgerEntry.FINDSET THEN
                                MatchBankRecLines.RemoveMatch(TempBankAccReconciliationLine2, BankAccountLedgerEntry);
                        END
                        ELSE BEGIN
                            //*changes to use statement line instead of recon line
                            //   CurrPage.StmtLine2.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                            CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
                            //   MatchBankRecLines.RemoveMatch2(TempBankAccReconciliationLine,TempBankAccountLedgerEntry);

                        END

                    end;
                }
                action(All)
                {
                    Caption = 'Show All';
                    Image = AddWatch;

                    trigger OnAction()
                    begin
                        // CurrPage.StmtLine.PAGE.ToggleMatchedFilter(FALSE);
                        // CurrPage.ApplyBankLedgerEntries.PAGE.ToggleMatchedFilter(FALSE);
                        CurrPage.ApplyBankLedgerEntries.PAGE.ShowAll();
                    end;
                }
                action(NotMatched)
                {
                    Caption = 'Show Nonmatched';
                    Image = AddWatch;

                    trigger OnAction()
                    begin
                        // CurrPage.StmtLine.PAGE.ToggleMatchedFilter(TRUE);
                        // CurrPage.ApplyBankLedgerEntries.PAGE.ToggleMatchedFilter(TRUE);
                        CurrPage.ApplyBankLedgerEntries.PAGE.ShowNonMatched();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("&Test Report")
                {
                    Caption = '&Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    Visible = true;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintBankAccRecon(Rec);

                    end;
                }
                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // RunObject = Codeunit 131075;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        bankRecon: Record "Bank Acc. Reconciliation";
                    begin

                        CLEAR(RecAmt);
                        BankAccReconLine.RESET;
                        BankAccReconLine.SETRANGE(BankAccReconLine."Bank Account No.", Rec."Bank Account No.");
                        BankAccReconLine.SETRANGE(BankAccReconLine."Statement No.", Rec."Statement No.");
                        IF BankAccReconLine.FIND('-') THEN BEGIN
                            REPEAT
                                IF BankAccReconLine.Reconciled = TRUE THEN
                                    RecAmt := RecAmt + BankAccReconLine."Statement Amount";
                            UNTIL BankAccReconLine.NEXT = 0;
                        END;
                        BankDiff := 0;
                        BankDiff := (Rec."Statement Ending Balance" - Rec."Balance Last Statement");

                        IF BankDiff <> RecAmt THEN ERROR('The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts');

                        bankRecon.Reset();
                        bankRecon.SetRange("Bank Account No.", rec."Bank Account No.");
                        bankRecon.SetRange("Statement No.", rec."Statement No.");
                        if bankRecon.Find('-') then begin
                            Codeunit.Run(80028, Rec);
                        end;
                    end;
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 372;
                    ShortCutKey = 'Shift+F9';
                    Visible = true;

                    trigger OnAction()
                    begin

                        CLEAR(RecAmt);
                        BankAccReconLine.RESET;
                        BankAccReconLine.SETRANGE(BankAccReconLine."Bank Account No.", Rec."Bank Account No.");
                        BankAccReconLine.SETRANGE(BankAccReconLine."Statement No.", Rec."Statement No.");
                        IF BankAccReconLine.FIND('-') THEN BEGIN
                            REPEAT
                                IF BankAccReconLine.Reconciled = TRUE THEN
                                    RecAmt := RecAmt + BankAccReconLine."Statement Amount";
                            UNTIL BankAccReconLine.NEXT = 0;
                        END;
                        BankDiff := 0;
                        BankDiff := (Rec."Statement Ending Balance" - Rec."Balance Last Statement");

                        IF BankDiff <> RecAmt THEN ERROR('The reconciled amount does not equal bank balance');
                    end;
                }
                action("Bank Recon Report")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = true;

                    trigger OnAction()
                    var
                        bank: Record "Bank Acc. Reconciliation";
                    begin
                        //     ReportPrint.PrintBankAccRecon(Rec);   --To allow for the new format
                        //NewReport.getbankRec(Rec,"Statement Ending Balance");
                        // NewReport.RUN;
                        bank.Reset();
                        bank.SetRange(bank."Bank Account No.", rec."Bank Account No.");
                        bank.SetRange(bank."Statement No.", rec."Statement No.");
                        if bank.Find('-') then begin
                            REPORT.RUN(50055, TRUE, FALSE, bank);
                        end;
                    end;
                }
            }
        }
    }

    var
        SuggestBankAccStatement: Report 1496;
        TransferToGLJnl: Report 1497;
        ReportPrint: Codeunit 228;
        BankAccReconPost: Codeunit 371;
        ReconLines: Record 274;
        BankAccReconLine: Record 274;
        BankAccReconLine2: Record 274;
        BankAcc: Record 270;
        BankAccLedgEntry: Record 271;
        CheckLedgEntry: Record 272;
        CheckLedgEntry2: Record 272;
        BankAccStmt: Record 275;
        BankAccStmtLine: Record 276;
        AppliedAmount: Decimal;
        TotalAmount: Decimal;
        currentStatement: Code[20];
        TotalAppliedAmount: Decimal;
        TotalDiff: Decimal;
        Lines: Integer;
        Window: Dialog;
        TotalPresented: Decimal;
        VarBankRec: Record "Bank Acc. Reconciliation";
        TestingReport: Report 50089;
        ReconReport: Report 50089;
        UserSetup: Record "User Setup";
        NewReport: Report 50089;
        RecAmt: Decimal;
        BankDiff: Decimal;
        BankEntry: Record "Bank Account Ledger Entry";
        ReconCount: Decimal;
        ReconcilliationBuffer: Record "Bank Acc. Statement Line Conv";
        ObjReconcilliationLine: Record 274;
        ReconcilliationBuffer2: Record "Bank Acc. Statement Line Conv";
        bankreconHeader: Record 172135;


    procedure TotalPresentedFunc(var BankReconcile: Record 273)
    var
        BankRecPresented: Record 274;
    begin
        TotalPresented := 0;
        VarBankRec := BankReconcile;
        BankRecPresented.RESET;
        BankRecPresented.SETRANGE(BankRecPresented."Bank Account No.", VarBankRec."Bank Account No.");
        BankRecPresented.SETRANGE(BankRecPresented."Statement No.", VarBankRec."Statement No.");
        BankRecPresented.SETRANGE(BankRecPresented.Reconciled, TRUE);

        IF BankRecPresented.FIND('-') THEN BEGIN
            REPEAT
                TotalPresented := TotalPresented + BankRecPresented."Applied Amount";
            //MESSAGE('%1',Totalpresented);
            UNTIL BankRecPresented.NEXT = 0;
        END
        ELSE
            MESSAGE('No records');
    end;

    // local procedure GetImportBankStatementNotificatoinId(): Guid
    // begin
    //     exit('aa54bf06-b8b9-420d-a4a8-1f55a3da3e2a');
    // end;

    // local procedure CreateEmptyListNotification()
    // var
    //     BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
    //     ImportBankStatementNotification: Notification;
    // begin
    //     ImportBankStatementNotification.Id := GetImportBankStatementNotificatoinId();
    //     if ImportBankStatementNotification.Recall() then;
    //     if not BankAccReconciliationLine.BankStatementLinesListIsEmpty(Rec."Statement No.", Rec."Statement Type".AsInteger(), Rec."Bank Account No.") then
    //         exit;

    //     ImportBankStatementNotification.Message := ListEmptyMsg;
    //     ImportBankStatementNotification.Scope := NotificationScope::LocalScope;
    //     ImportBankStatementNotification.Send();
    // end;

    // local procedure RecallEmptyListNotification()
    // var
    //     ImportBankStatementNotification: Notification;
    // begin
    //     ImportBankStatementNotification.Id := GetImportBankStatementNotificatoinId();
    //     if ImportBankStatementNotification.Recall() then;
    // end;

    trigger OnOpenPage()
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        // FeatureTelemetry.LogUptake('0000JLL', Rec.GetBankReconciliationTelemetryFeatureName(), Enum::"Feature Uptake Status"::Discovered);
        // FeatureTelemetry.LogUptake('0000JM9', Rec.GetBankReconciliationTelemetryFeatureName(), Enum::"Feature Uptake Status"::"Set up");
        CreateEmptyListNotification();

        if (Rec."Bank Account No." <> '') then begin
            BankAccountNoIsEditable := false;
            CheckBankAccLedgerEntriesAlreadyMatched();
            CurrPage.ApplyBankLedgerEntries.Page.AssignBankAccReconciliation(Rec);
            //  CurrPage.ApplyBankLedgerEntries.Page.SetBankRecDateFilter(Rec.MatchCandidateFilterDate());
        end
        else
            BankAccountNoIsEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        BankAccount: Record "Bank Account";
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankAccountNumber: Code[20];
    begin
        if (Rec."Bank Account No." <> '') then
            exit;
        if BankAccount.FindSet() then begin
            BankAccountNumber := BankAccount."No.";
            if BankAccount.Next() = 0 then begin
                Rec."Statement Type" := BankAccReconciliation."Statement Type"::"Bank Reconciliation";
                Rec.Validate("Bank Account No.", BankAccountNumber);
                BankAccountNoIsEditable := false;
            end;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        RecallEmptyListNotification();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if UpdatedBankAccountLESystemId <> Rec.SystemId then begin
            UpdatedBankAccountLESystemId := Rec.SystemId;
            // CurrPage.ApplyBankLedgerEntries.Page.SetBankRecDateFilter(Rec.MatchCandidateFilterDate());
        end;

        CurrPage.ApplyBankLedgerEntries.Page.AssignBankAccReconciliation(Rec);
    end;

#if not CLEAN22
    internal procedure UpdateBankAccountLedgerEntrySubpageOnAfterSetFilters(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
        OnUpdateBankAccountLedgerEntrySubpageOnAfterSetFilters(BankAccountLedgerEntry);
    end;
#endif

    local procedure GetImportBankStatementNotificatoinId(): Guid
    begin
        exit('aa54bf06-b8b9-420d-a4a8-1f55a3da3e2a');
    end;

    local procedure CreateEmptyListNotification()
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        ImportBankStatementNotification: Notification;
    begin
        ImportBankStatementNotification.Id := GetImportBankStatementNotificatoinId();
        if ImportBankStatementNotification.Recall() then;
        if not BankAccReconciliationLine.BankStatementLinesListIsEmpty(Rec."Statement No.", Rec."Statement Type".AsInteger(), Rec."Bank Account No.") then
            exit;

        ImportBankStatementNotification.Message := ListEmptyMsg;
        ImportBankStatementNotification.Scope := NotificationScope::LocalScope;
        ImportBankStatementNotification.Send();
    end;

    local procedure RecallEmptyListNotification()
    var
        ImportBankStatementNotification: Notification;
    begin
        ImportBankStatementNotification.Id := GetImportBankStatementNotificatoinId();
        if ImportBankStatementNotification.Recall() then;
    end;

    local procedure CheckStatementDate()
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
    begin
        BankAccReconciliationLine.SetFilter("Bank Account No.", Rec."Bank Account No.");
        BankAccReconciliationLine.SetFilter("Statement No.", Rec."Statement No.");
        BankAccReconciliationLine.SetCurrentKey("Transaction Date");
        BankAccReconciliationLine.Ascending := false;
        if BankAccReconciliationLine.FindFirst() then begin
            BankAccReconciliation.GetBySystemId(Rec.SystemId);
            if BankAccReconciliation."Statement Date" = 0D then begin
                if Confirm(StrSubstNo(StatementDateEmptyMsg, Format(BankAccReconciliationLine."Transaction Date"))) then begin
                    Rec."Statement Date" := BankAccReconciliationLine."Transaction Date";
                    Rec.Modify();
                end;
            end else
                if BankAccReconciliation."Statement Date" < BankAccReconciliationLine."Transaction Date" then
                    Message(ImportedLinesAfterStatementDateMsg);
            //  CurrPage.ApplyBankLedgerEntries.Page.SetBankRecDateFilter(BankAccReconciliation.MatchCandidateFilterDate());
        end;
    end;

    local procedure WarnIfOngoingBankReconciliations(BankAccountNoCode: Code[20]): Boolean
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
    begin
        BankAccReconciliation.SetRange("Bank Account No.", BankAccountNoCode);
        BankAccReconciliation.SetRange("Statement Type", BankAccReconciliation."Statement Type"::"Bank Reconciliation");
        if not BankAccReconciliation.FindSet() then
            exit(true);
        repeat
            if BankAccReconciliation."Statement No." <> Rec."Statement No." then
                // exit(Dialog.Confirm(StrSubstNo(IgnoreExistingBankAccReconciliationAndContinueQst)));
                Error(ExistingBankAccReconciliationAndContinueQst);
        until BankAccReconciliation.Next() = 0;
        exit(true);
    end;

    local procedure ConfirmSelectedEntriesWithExternalMatchForModification(var TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary): Boolean
    var
        ReturnValue: Boolean;
        bank: Record "Bank Acc. Reconciliation";
    begin
        bank.Reset();
        bank.SetRange("Bank Account No.", Rec."Bank Account No.");
        bank.SetRange("Statement No.", rec."Statement No.");
        if bank.Find('-') then begin
            TempBankAccountLedgerEntry.SetFilter("Statement No.", '<> %1 & <> ''''', Rec."Statement No.");
            if TempBankAccountLedgerEntry.IsEmpty() then begin
                ReturnValue := true
            end;
            // else 
            // begin
            //     ReturnValue := Confirm(ModifyBankAccLedgerEntriesForModificationQst, false);
            //     if ReturnValue then
            //         // Session.LogMessage('0000JLM', '', Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', Bank.GetBankReconciliationTelemetryFeatureName());
            // end;

            TempBankAccountLedgerEntry.SetRange("Statement No.");
            TempBankAccountLedgerEntry.FindSet();
            exit(ReturnValue);
        end;
    end;

    local procedure CheckBankAccLedgerEntriesAlreadyMatched()
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccountLedgerEntry.SetRange("Bank Account No.", Rec."Bank Account No.");
        BankAccountLedgerEntry.SetRange(Open, true);
        BankAccountLedgerEntry.SetFilter("Statement No.", '<> %1 & <> ''''', Rec."Statement No.");
        BankAccountLedgerEntry.SetFilter("Statement Status", '<> Closed');
        if (Rec."Statement Date" <> 0D) then
            BankAccountLedgerEntry.SetFilter("Posting Date", '<= %1', Rec."Statement Date");

        if not BankAccountLedgerEntry.IsEmpty() then
            Message(ExistingBankAccReconciliationAndContinueMsg);
    end;

    var
        SuggestBankAccReconLines: Report "Suggest Bank Acc. Recon. Lines";
        TransBankRecToGenJnl: Report "Trans. Bank Rec. to Gen. Jnl.";
        TestReportPrint: Codeunit "Test Report-Print";
        BankAccountNoIsEditable: Boolean;
        ListEmptyMsg: Label 'No bank statement lines exist. Choose the Import Bank Statement action to fill in the lines from a file, or enter lines manually.';
        ImportedLinesAfterStatementDateMsg: Label 'There are lines on the imported bank statement with dates that are after the statement date.';
        StatementDateEmptyMsg: Label 'The bank account reconciliation does not have a statement date. %1 is the latest date on a line. Do you want to use that date for the statement?', Comment = '%1 - statement date';
        NoBankAccReconcilliationLineWithDiffSellectedErr: Label 'Select the bank statement lines that have differences to transfer to the general journal.';
        UpdatedBankAccountLESystemId: Guid;
        IgnoreExistingBankAccReconciliationAndContinueQst: Label 'There are ongoing reconciliations for this bank account. \\Do you want to continue?';
        ExistingBankAccReconciliationAndContinueQst: Label 'There are ongoing reconciliations for this bank account.';
        ExistingBankAccReconciliationAndContinueMsg: Label 'There are ongoing reconciliations for this bank account in which entries are matched.';
        ModifyBankAccLedgerEntriesForModificationQst: Label 'One or more of the selected entries have been matched on another bank account reconciliation.\\Do you want to continue?';

#if not CLEAN22
    [Obsolete('Use the event OnAfterApplyControledFilters in ApplyBankLedferEntries.Page.al', '22.0')]
    [IntegrationEvent(false, false)]
    local procedure OnUpdateBankAccountLedgerEntrySubpageOnAfterSetFilters(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
    end;
#endif

    [IntegrationEvent(false, false)]
    local procedure OnActionSuggestLinesOnBeforeSuggestBankAccReconLines(var BankAccReconciliation: Record "Bank Acc. Reconciliation"; var IsHandled: Boolean)
    begin
    end;
}

