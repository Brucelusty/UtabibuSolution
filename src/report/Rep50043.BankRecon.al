report 50043 BankRecon
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Layouts/BankRecontatement.Rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Acc. Reconciliation")
        {
            column(Picture; CompanyInfo.Picture)
            {

            }
            column(OutstsndingDeposits; OutstsndingDeposits)
            { }
            column
            (ComanyName; COMPANYPROPERTY.DISPLAYNAME)
            { }

            column(phone; CompanyInfo."Phone No.")
            {

            }
            column(Address; CompanyInfo.Address)
            {

            }
            column(Email; CompanyInfo."E-Mail")
            {

            }
            column(PostalCode; CompanyInfo."Post Code")

            {

            }
            column(Address2; CompanyInfo."Address 2")

            {

            }
            column(Name; CompanyInfo.Name)
            {

            }

            column(StatementDate_BankAccountStatement; "Statement Date")
            {

            }
            column(BankAccountName; BankAccountName)
            {

            }
            column(StatementEndingBalance_BankAccountStatement; "Statement Ending Balance")
            {

            }
            column(BalanceLastStatement_BankAccountStatement; "Balance Last Statement")
            {

            }
            column(BankAccStmtTableCaptFltr; TABLECAPTION + ': ' + BankAccStmtFilter)

            {

            }
            column(BankAccStmtFilter; BankAccStmtFilter)
            {

            }
            column(BankAccountStatementStatementDate; "Statement Date")
            {


            }
            column(StmtNo_BankAccStmt; "Statement No.")
            {

            }

            column(BankAccNo_BankAccStmt; "Bank Account No.")
            {

            }
            column(CreditAmount; CreditAmount)
            {

            }
            column(OutstsndingPayments2; OutstsndingPayments2)
            {

            }
            column(DebitAmount; DebitAmount)
            {

            }
            column(ComputerBankBal; ComputerBankBal)
            {

            }
            column(DiffBankBal; DiffBankBal)
            {

            }
            column(ReconBankBal; ReconBankBal)

            {

            }
            column(Date; BankAccStmtLines."Transaction Date")
            {

            }
            column(Description; BankAccStmtLines.Description)
            {

            }
            column(Amount; BankAccStmtLines."Statement Amount")
            {

            }
            column(BankAccBalance; BankAccBalance)
            {

            }
            column(BankAccBalanceLCY; BankAccBalanceLCY)
            {

            }
            column(Approver; Approver)
            {

            }
            column(ApprovedDate; ApprovedDate)
            {

            }
            column(Prepared; Prepared) { }
            column(PreparedDate; PreparedDate) { }
            column(Desription; Desription)
            {

            }
            column(ComputedDeposits; ComputedDeposits) { }
            column(ComputedPayemts; ComputedPayemts) { }
            column(DocNo; DocNo) { }
            column(Amount2; Amount2) { }
            column(PostingDate; Date) { }


            dataitem("Bank Account Statement Line"; "Bank Acc. Reconciliation Line")
            {

                DataItemTableView = WHERE(Reconciled = filter(true));
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = FIELD("Statement No.");

                column(TransactionDate_BankAccountStatementLine; "Transaction Date")
                {

                }
                column(Description_BankAccountStatementLine; Description)
                {

                }
                column(Reconciled; Reconciled)
                {

                }
                column(DocumentNo_BankAccountStatementLine; "Document No.")
                {

                }
                column(StatementAmount_BankAccountStatementLine; "Statement Amount")
                {

                }
                column(BankAccBalanceLCY3; BankAccBalanceLCY)
                {

                }
                column(BankAccBalance3; BankAccBalance)
                {

                }
                column(Empty2; Empty2)
                {


                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    BankAccLedgEntryExists := FALSE;
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Empty2 := '';

                    BankAccLedgEntryExists := TRUE;
                    IF BankStmtLine."Statement Amount" < 0 THEN BEGIN
                        BankAccBalance := BankAccBalance + "Statement Amount";
                    END;
                    IF BankStmtLine."Statement Amount" > 0 THEN BEGIN
                        BankAccBalanceLCY := BankAccBalanceLCY + "Statement Amount";
                    END;
                    //MESSAGE('%1-%2',BankAccBalance,BankAccBalanceLCY);

                end;

            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No.");
                column(DimensionSetID_BankAccountLedgerEntry; "Dimension Set ID")
                {

                }

                column(OutstsndingPayments; OutstsndingPayments)
                {

                }
                column(BankBalance; BankBalance)
                {

                }
                column(CreditAppAmt; CreditAppAmt)
                {

                }
                column(DocumentNo_Caption; "Document No.")
                {

                }
                column(PostingDate_Caption; "Posting Date")
                {

                }
                column(Description_Caption; Description)
                {

                }
                column(Amount_Caption; Amount)
                {

                }
                column(EntryNo_BankAccountLedgerEntry; "Entry No.")
                {

                }
                column(BankAccountNo_BankAccountLedgerEntry; "Bank Account No.")
                {

                }
                column(PostingDate_BankAccountLedgerEntry; FORMAT("Bank Account Ledger Entry"."Posting Date", 0, '<Closing><Day,2>-<Month,2>-<Year>'))
                {

                }
                column(DocumentType_BankAccountLedgerEntry; "Document Type")
                {

                }
                column(DocumentNo_BankAccountLedgerEntry; "Document No.")
                {

                }
                column(Description_BankAccountLedgerEntry; Desription)
                {

                }
                column(CurrencyCode_BankAccountLedgerEntry; "Currency Code")
                {

                }
                column(Amount_BankAccountLedgerEntry; Amount)

                {

                }
                column(RemainingAmount_BankAccountLedgerEntry; "Remaining Amount")
                {

                }
                column(AmountLCY_BankAccountLedgerEntry; "Amount (LCY)")
                {

                }
                column(BankAccPostingGroup_BankAccountLedgerEntry; "Bank Acc. Posting Group")
                {

                }
                column(GlobalDimension1Code_BankAccountLedgerEntry; "Global Dimension 1 Code")
                {

                }
                column(GlobalDimension2Code_BankAccountLedgerEntry; "Global Dimension 2 Code")
                {

                }
                column(OurContactCode_BankAccountLedgerEntry; "Our Contact Code")
                {

                }
                column(UserID_BankAccountLedgerEntry; "User ID")
                {

                }
                column(SourceCode_BankAccountLedgerEntry; "Source Code")
                {

                }
                column(Open_BankAccountLedgerEntry; Open)
                {

                }
                column(Positive_BankAccountLedgerEntry; Positive)
                {

                }
                column(ClosedbyEntryNo_BankAccountLedgerEntry; "Closed by Entry No.")
                {

                }
                column(ClosedatDate_BankAccountLedgerEntry; "Closed at Date")
                {

                }
                column(JournalBatchName_BankAccountLedgerEntry; "Journal Batch Name")
                {

                }
                column(ReasonCode_BankAccountLedgerEntry; "Reason Code")

                {

                }
                column(BalAccountType_BankAccountLedgerEntry; "Bal. Account Type")
                {

                }
                column(BalAccountNo_BankAccountLedgerEntry; "Bal. Account No.")
                {

                }
                column(TransactionNo_BankAccountLedgerEntry; "Transaction No.")
                {

                }
                column(StatementStatus_BankAccountLedgerEntry; "Statement Status")
                {

                }
                column(StatementNo_BankAccountLedgerEntry; "Statement No.")
                {

                }
                column(StatementLineNo_BankAccountLedgerEntry; "Statement Line No.")
                {

                }
                column(DebitAmount_BankAccountLedgerEntry; "Debit Amount")
                {

                }
                column(CreditAmount_BankAccountLedgerEntry; "Credit Amount")
                {

                }
                column(DebitAmountLCY_BankAccountLedgerEntry; "Debit Amount (LCY)")
                {

                }
                column(CreditAmountLCY_BankAccountLedgerEntry; "Credit Amount (LCY)")
                {

                }
                column(DocumentDate_BankAccountLedgerEntry; "Document Date")
                {

                }
                column(ExternalDocumentNo_BankAccountLedgerEntry; "External Document No.")
                {

                }
                column(Reversed_BankAccountLedgerEntry; Reversed)
                {

                }
                column(ReversedbyEntryNo_BankAccountLedgerEntry; "Reversed by Entry No.")
                {

                }
                column(ReversedEntryNo_BankAccountLedgerEntry; "Reversed Entry No.")
                { }
                column(CheckLedgerEntries_BankAccountLedgerEntry; "Check Ledger Entries")
                {

                }
                column(Empty; Empty)
                { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    "Bank Account Ledger Entry".SETRANGE(Open, true);
                    "Bank Account Ledger Entry".SETFILTER("Posting Date", '%1..%2', 20190101D, "Bank Account Statement"."Statement Date");



                    IF "Bank Account Ledger Entry".Amount < 0 THEN
                        DebitAmount := DebitAmount + "Bank Account Ledger Entry".Amount;
                    IF "Bank Account Ledger Entry".Amount > 0 THEN
                        CreditAmount := CreditAmount + "Bank Account Ledger Entry".Amount;

                    SETFILTER("Posting Date", '%1..%2', 20190101D, "Bank Account Statement"."Statement Date");

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Empty := '';
                    OutstsndingDeposits := 0;
                    OutstsndingPayments := 0;
                    BankAcLedgerEntry.RESET;
                    BankAcLedgerEntry.SETRANGE("Bank Account No.", "Bank Account Statement"."Bank Account No.");
                    BankAcLedgerEntry.SETFILTER("Posting Date", '..%1', "Bank Account Statement"."Statement Date");
                    BankAcLedgerEntry.SETRANGE(Open, TRUE);
                    BankAcLedgerEntry.SETFILTER(Amount, '>%1', 0);
                    BankAcLedgerEntry.SETRANGE(Reversed, FALSE);
                    IF BankAcLedgerEntry.FINDSET THEN BEGIN
                        REPEAT
                            OutstsndingDeposits += BankAcLedgerEntry.Amount;
                        UNTIL BankAcLedgerEntry.NEXT = 0;
                    END;
                    OutstsndingPayments2 := 0;
                    BankAcLedgerEntry.RESET;
                    BankAcLedgerEntry.SETRANGE("Bank Account No.", "Bank Account Statement"."Bank Account No.");
                    BankAcLedgerEntry.SETFILTER("Posting Date", '..%1', "Bank Account Statement"."Statement Date");
                    BankAcLedgerEntry.SETRANGE(Open, TRUE);
                    BankAcLedgerEntry.SETFILTER(Amount, '<%1', 0);
                    BankAcLedgerEntry.SETRANGE(Reversed, FALSE);
                    IF BankAcLedgerEntry.FINDSET THEN BEGIN
                        REPEAT
                            OutstsndingPayments += BankAcLedgerEntry.Amount;
                        UNTIL BankAcLedgerEntry.NEXT = 0;
                    END;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CreditAmount := 0;
                DebitAmount := 0;
                ReconBankBal := 0;
                ComputerBankBal := 0;
                DiffBankBal := 0;
                BankBalance := 0;
                IF BankAccounts.GET("Bank Account Statement"."Bank Account No.") THEN BEGIN
                    BankAccountName := BankAccounts.Name;
                    BankAccountBal := BankAccounts.Balance;
                END;

                //Get computer bank balance upto statement date

                OutstsndingPayments22 := 0;
                BankAcLedgerEntry.RESET;
                BankAcLedgerEntry.SETRANGE("Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAcLedgerEntry.SETFILTER("Posting Date", '..%1', "Bank Account Statement"."Statement Date");
                BankAcLedgerEntry.SETRANGE(Open, TRUE);
                //BankAcLedgerEntry.SETFILTER(Amount,'%1',0);
                BankAcLedgerEntry.SETRANGE(Reversed, FALSE);
                IF BankAcLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        //MESSAGE('yyhhh');
                        OutstsndingPayments22 += BankAcLedgerEntry.Amount;
                    UNTIL BankAcLedgerEntry.NEXT = 0;
                END;

                BankAcLedgerEntry.SETRANGE("Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAcLedgerEntry.SETFILTER("Posting Date", '..%1', "Bank Account Statement"."Statement Date");
                BankAcLedgerEntry.SETRANGE(Open, FALSE);
                BankAcLedgerEntry.SETRANGE("Statement No.", "Bank Account Statement"."Statement No.");
                BankAcLedgerEntry.SETRANGE(Reversed, FALSE);
                IF BankAcLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        ComputerBankBal += BankAcLedgerEntry.Amount;
                    UNTIL BankAcLedgerEntry.NEXT = 0;
                END;

                //Calculate debits and credits

                BankAcLedgerEntry.RESET;
                BankAcLedgerEntry.SETRANGE("Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAcLedgerEntry.SETFILTER("Posting Date", '..%1', "Bank Account Statement"."Statement Date");
                //BankAcLedgerEntry.SETRANGE(Open,TRUE);
                BankAcLedgerEntry.SETRANGE("Statement No.", "Bank Account Statement"."Statement No.");
                BankAcLedgerEntry.SETRANGE(Open, FALSE);
                BankAcLedgerEntry.SETRANGE(Reversed, FALSE);
                IF BankAcLedgerEntry.FINDFIRST THEN BEGIN

                    REPEAT
                        IF BankAcLedgerEntry.Amount > 0 THEN
                            DebitAmount += BankAcLedgerEntry.Amount;
                        IF BankAcLedgerEntry.Amount < 0 THEN
                            CreditAmount += BankAcLedgerEntry.Amount;
                    UNTIL BankAcLedgerEntry.NEXT = 0;
                END;



                OutstsndingPayments2 += "Bank Account Statement"."Statement Ending Balance" + OutstsndingPayments22;

                //MESSAGE('Paid Credit %1 - unpaind Amount%2 -Recon bal%3',ComputerBankBal,OutstsndingPayments2,ReconBankBal);

                // IF BankAccStmtLines."Statement Amount" =0 THEN
                // CurrReport.SKIP
                ComputedDeposits := 0;
                ComputedPayemts := 0;
                BankAccStmtLines.RESET;
                BankAccStmtLines.SETRANGE("Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccStmtLines.SETRANGE("Statement No.", "Bank Account Statement"."Statement No.");
                BankAccStmtLines.SETFILTER("Statement Amount", '>%1', 0);
                BankAcLedgerEntry.SETRANGE(Reversed, FALSE);
                IF BankAccStmtLines.FINDSET THEN BEGIN
                    REPEAT
                        ComputedDeposits += BankAccStmtLines."Statement Amount";
                    UNTIL BankAccStmtLines.NEXT = 0;

                END;
                BankAccStmtLines.RESET;
                BankAccStmtLines.SETRANGE("Bank Account No.", "Bank Account Statement"."Bank Account No.");
                BankAccStmtLines.SETRANGE("Statement No.", "Bank Account Statement"."Statement No.");
                BankAccStmtLines.SETFILTER("Statement Amount", '<%1', 0);
                IF BankAccStmtLines.FINDSET THEN BEGIN
                    REPEAT
                        ComputedPayemts += BankAccStmtLines."Statement Amount";

                    UNTIL BankAccStmtLines.NEXT = 0;

                END;

                ReconBankBal := "Bank Account Statement"."Statement Ending Balance" + (ComputedPayemts + ComputedDeposits);
                //MESSAGE('%1-%2',ComputedDeposits,ComputedPayemts);
                ApprovalEntry.RESET;
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                ApprovalEntry.SETRANGE("Document No.", "Bank Account No." + "Statement No.");
                IF ApprovalEntry.FINDFIRST THEN BEGIN
                    ApprovedDate := ApprovalEntry."Last Date-Time Modified";
                    HREmployees.RESET;
                    HREmployees.SETRANGE("User ID", ApprovalEntry."Approver ID");
                    IF HREmployees.FINDFIRST THEN BEGIN
                        HREmployees.CALCFIELDS("Employee Signature");
                        Approver := HREmployees.FullName;
                        // "Bank Account Statement".Approver1Signature := HREmployees."Employee Signature";

                    END;
                END;

                ApprovalEntry.RESET;
                ApprovalEntry.SETRANGE("Document No.", "Bank Account No." + "Statement No.");
                IF ApprovalEntry.FINDFIRST THEN BEGIN
                    PreparedDate := ApprovalEntry."Last Date-Time Modified";
                    HREmployees.RESET;
                    HREmployees.SETRANGE("User ID", ApprovalEntry."Sender ID");
                    IF HREmployees.FINDFIRST THEN BEGIN
                        HREmployees.CALCFIELDS("Employee Signature");
                        Prepared := HREmployees.FullName;
                        //"Bank Account Statement".RequesterSignature := HREmployees."Employee Signature";

                    END;
                END;

            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        //CompanyInformation.CALCFIELDS("Official Stamp");
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);

    end;


    var
        BankAccStmtLines: Record "Bank Account Statement Line";
        BankAccStmtFilter: Text;
        CreditAppAmt: Decimal;
        DebitAppAmt: Decimal;
        CreditAmount: Decimal;
        DebitAmount: Decimal;
        BankAccounts: Record "Bank Account";
        BankAccountName: Text;
        BankAccountBal: Decimal;
        ReconBankBal: Decimal;
        ComputerBankBal1: Decimal;
        ComputerBankBal: Decimal;
        DiffBankBal: Decimal;
        StartDate: Date;
        CompanyInformation: Record "Company Information";
        CompanyInfo: Record "Company Information";
        BankAccBalance: Decimal;
        BankAccBalanceLCY: Decimal;
        BankAccLedgEntryExists: Boolean;

        PrintReversedEntries: Boolean;
        Approver: Text;
        Requester: Text;
        ApprovalEntry: Record "Approval Entry";
        HREmployees: Record "HR Employees";
        ApprovedDate: DateTime;
        Prepared: Text;
        PreparedDate: DateTime;
        Desription: Text;
        DocNo: Code[45];
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        Amount2: Decimal;
        Date: Date;
        BankAccountStatement: Record "Bank Account Statement";
        Empty: Text;
        Empty2: Text;
        ComputedDeposits: Decimal;
        ComputedPayemts: Decimal;
        OutstsndingPayments: Decimal;
        OutstsndingDeposits: Decimal;
        BankBalance: Decimal;
        OutstsndingPayments2: Decimal;
        OutstsndingPayments22: Decimal;
        BankAcLedgerEntry: Record "Bank Account Ledger Entry";
        BankStmtLine: Record "Bank Account Statement Line";

}