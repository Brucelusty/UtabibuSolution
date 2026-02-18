report 50088 "Bank Acc. Reconciliation Conv"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\BankAccReconciliationn.rdlc';
    Caption = 'Posted Bank Account Reconciliation Report';

    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {
            RequestFilterFields = "Bank Account No.", "Statement No.";
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement No.")
            {
            }
            column(StatementDate_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Date")
            {
            }
            column(TotalBalanceonBankAccount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Balance on Bank Account")
            {
            }
            column(TotalAppliedAmount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Applied Amount")
            {
            }
            column(TotalTransactionAmount_BankAccReconciliation; "Bank Acc. Reconciliation"."Total Transaction Amount")
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(StatementEndingBalance_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Ending Balance")
            {
            }
            column(BankName; BankName)
            {
            }
            column(DifferenceBtwStatements_BankAccReconciliation; "Bank Acc. Reconciliation"."Difference Btw Statements")
            {
            }
            column(BankAccountBalanceasperCashBook; BankAccountBalanceasperCashBook)
            {
            }
            column(UnpresentedChequesTotal; UnpresentedChequesTotal)
            {
            }
            column(UncreditedBanking; UncreditedBanking)
            {
            }
            column(ReconciliationStatement; ReconciliationStatement)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            dataitem("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."),
                               "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE(Reconciled = CONST(False),
                                          "Statement Amount" = FILTER(< 0));
                column(CheckNo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Check No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Transaction Date")
                {
                }
                column(StatementLineNo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Statement Line No.")
                {
                }
                column(Description_BankAccReconciliationLine; "Bank Acc. Reconciliation Line".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Statement Amount")
                {
                }
                column(OpenType_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Open Type")
                {
                }
            }
            dataitem("<Bank Acc. Reconciliation Ln1>"; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."),
                               "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE(Reconciled = CONST(False),
                                          "Statement Amount" = FILTER(> 0));
                column(CheckNo_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."Check No.")
                {
                }
                column(StatementLineNo_BankAccReconciliationLn1; "<Bank Acc. Reconciliation Ln1>"."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."Statement Amount")
                {
                }
                column(OpenType_BankAccReconciliationLine1; "<Bank Acc. Reconciliation Ln1>"."Open Type")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                BankCode := '';
                BankAccountNo := '';
                BankName := '';
                BankAccountBalanceasperCashBook := 0;
                UnpresentedChequesTotal := 0;
                UncreditedBanking := 0;

                TotalDiffFunc();

                Bank.RESET;
                Bank.SETRANGE(Bank."No.", "Bank Account No.");
                IF Bank.FIND('-') THEN BEGIN
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    Bank.SETRANGE(Bank."Date Filter", 0D, "Statement Date");
                    Bank.CALCFIELDS(Bank."Net Change");
                    BankAccountBalanceasperCashBook := Bank."Net Change";

                    BankStatementLine.RESET;
                    BankStatementLine.SETRANGE(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SETRANGE(BankStatementLine."Statement No.", "Statement No.");
                    BankStatementLine.SETRANGE(BankStatementLine.Reconciled, FALSE);
                    IF BankStatementLine.FIND('-') THEN
                        REPEAT
                            IF BankStatementLine."Statement Amount" < 0 THEN
                                UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine."Statement Amount"
                            ELSE IF BankStatementLine."Statement Amount" > 0 THEN
                                UncreditedBanking := UncreditedBanking + BankStatementLine."Statement Amount";
                        UNTIL BankStatementLine.NEXT = 0;

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                    BankStatBalance := "Bank Acc. Reconciliation"."Statement Ending Balance";


                    CLEAR(RecAmt);
                    BankAccReconLine.RESET;
                    BankAccReconLine.SETRANGE(BankAccReconLine."Bank Account No.", "Bank Account No.");
                    BankAccReconLine.SETRANGE(BankAccReconLine."Statement No.", "Statement No.");
                    IF BankAccReconLine.FIND('-') THEN BEGIN
                        REPEAT
                            IF BankAccReconLine.Reconciled = TRUE THEN
                                RecAmt := RecAmt + BankAccReconLine."Applied Amount"
                        UNTIL BankAccReconLine.NEXT = 0;
                    END;
                    BankDiff := 0;
                    BankDiff := ("Statement Ending Balance" - "Balance Last Statement");

                    //IF  BankDiff <> RecAmt THEN ERROR ('The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts');

                    Message('%1|%2|%3', BankDiff, RecAmt, "Balance Last Statement");

                    //IF (UnpresentedChequesTotal+TotalDifference) =(BankAccountBalanceasperCashBook-BankStatBalance) THEN
                    IF BankDiff = RecAmt THEN
                        ReconciliationStatement := 'The bank reconciliation is complete!'
                    ELSE
                        ReconciliationStatement := ' The reconciliation is incomplete! The net change between statement ending balance and balance last statement does not equal the reconciled amounts';
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);

                ReconciliationStatement := 'Reconciliation is incomplete please go through it again';
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Bank: Record "270";
        BankCode: Code[20];
        BankAccountNo: Code[20];
        BankName: Text;
        BankAccountBalanceasperCashBook: Decimal;
        UnpresentedChequesTotal: Decimal;
        UncreditedBanking: Decimal;
        BankStatementLine: Record "274";
        CompanyInfo: Record "Company Information";
        ReconciliationStatement: Text;
        TotalDifference: Decimal;
        BankRecPresented: Record "274";
        BankRecUnPresented: Record "274";
        BankStatBalance: Decimal;
        RecAmt: Decimal;
        BankDiff: Decimal;
        BankAccReconLine: Record "274";

    procedure TotalDiffFunc()
    begin
        BankRecPresented.RESET;
        BankRecPresented.SETRANGE(BankRecPresented."Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
        BankRecPresented.SETRANGE(BankRecPresented."Statement No.", "Bank Acc. Reconciliation"."Statement No.");
        BankRecPresented.SETRANGE(BankRecPresented.Reconciled, TRUE);
        IF BankRecPresented.FIND('-') THEN BEGIN
            REPEAT
                TotalDifference := TotalDifference + BankRecPresented.Difference;
            //MESSAGE('%1',TotalDifference);
            UNTIL BankRecPresented.NEXT = 0;
        END;
    end;
}

