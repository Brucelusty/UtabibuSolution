codeunit 131017 "Fosa Posting Management"
{
    trigger OnRun()
    begin
        
    end;
    
    var
        LoanBalance: Decimal;
        VarTransactionType: Enum FOSATransactionTypesEnum;
        AvailableBalance: Decimal;
        UnClearedBalance: Decimal;
        LoanSecurity: Decimal;
        LoanGuaranteed: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        Account: Record Vendor;
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        GenLedgerSetup: Record "General Ledger Setup";
        MinAccBal: Decimal;
        FeeBelowMinBal: Decimal;
        AccountNo: Code[30];
        NewAccount: Boolean;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        IntervalPenalty: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountAmount: Decimal;
        STODeduction: Decimal;
        Charges: Record Charges;
        "Total Deductions": Decimal;
        STODeductedAmount: Decimal;
        NoticeAmount: Decimal;
        AccountNotices: Record "Account Notices";
        Cust: Record "Members Register";
        AccountHolders: Record Vendor;
        ChargesOnFD: Decimal;
        TotalGuaranted: Decimal;
        VarAmtHolder: Decimal;
        chqtransactions: Record Transactions;
        Trans: Record Transactions;
        TotalUnprocessed: Decimal;
        CustAcc: Record "Members Register";
        AmtAfterWithdrawal: Decimal;
        TransactionsRec: Record Transactions;
        LoansTotal: Decimal;
        Interest: Decimal;
        InterestRate: Decimal;
        OBal: Decimal;
        Principal: Decimal;
        ATMTrans: Decimal;
        ATMBalance: Decimal;
        TotalBal: Decimal;
        DenominationsRec: Record Denominations;
        TillNo: Code[20];
        FOSASetup: Record "Purchases & Payables Setup";
        Acc: Record Vendor;
        ChequeTypes: Record "Cheque Types";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        ChBank: Code[20];
        DValue: Record "Dimension Value";
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        Cheque: Boolean;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        BOSABank: Code[20];
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        GenSetup: Record "Sacco General Set-Up";
        MailContent: Text[150];
        supervisor: Record "Supervisors Approval Levels";
        TEXT1: label 'YOU HAVE A TRANSACTION AWAITING APPROVAL';
        AccP: Record Vendor;
        LoansR: Record "Loans Register";
        ClearingCharge: Decimal;
        ClearingRate: Decimal;

        FChequeVisible: Boolean;

        BChequeVisible: Boolean;

        BReceiptVisible: Boolean;

        BOSAReceiptChequeVisible: Boolean;

        "Branch RefferenceVisible": Boolean;

        LRefVisible: Boolean;
        ChequeTransfVisible: Boolean;

        "Transaction DateEditable": Boolean;
        Excise: Decimal;
        Echarge: Decimal;
        BankLedger: Record "Bank Account Ledger Entry";
        Vend: Record Vendor;
        ChequeBook: Record "Cheques Register";
        BosaSetUp: Record "Sacco General Set-Up";
        CashierTrans: Record Transactions;
        ChequeWithdrawalVisible: Boolean;
        DepositSlipVisible: Boolean;
        OverDraftCharge: Decimal;
        OverDraftChargeAcc: Code[20];
        ChequeWithOll: Boolean;
        ChequeRegister: Record "Cheque Book Register";
        LoanType: Record "Loan Products Setup";
        GraduatedCharge: Record "CWithdrawal Graduated Charges";
        ExciseDuty: Decimal;
        ShareCapDefecit: Decimal;
        HasSpecialMandateVisible: Boolean;
        TransactingAgentVisible: Boolean;
        TransactingAgentNameVisible: Boolean;
        ObjAccountAgents: Record "Account Agent Details";
        ReceiptAllVisible: Boolean;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        SURESTEPFactory: Codeunit "Au Factory";
        ObjTransactions: Record "Receipt Allocation";
        BulkWithVisible: Boolean;
        ObjAccountType: Record "Account Types-Saving Products";
        VarMonthlyInt: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarshowSignatories: Boolean;
        VarShowAgents: Boolean;
        ObjAccountSignatories: Record "FOSA Account Sign. Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjReceiptAllocation: Record "Receipt Allocation";
        ExcessFOSAAccountVisible: Boolean;
        VarNoticeType: Option " ","With Notice","Without Notice";
        ODDetailsVisible: Boolean;
        Rec: Record "Transactions";



    procedure CalcAvailableBal()
    begin
        ATMBalance := 0;

        TCharges := 0;
        AvailableBalance := 0;
        MinAccBal := 0;
        TotalUnprocessed := 0;
        IntervalPenalty := 0;
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, Rec."Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;

        if Account.Get(Rec."Account No") then begin
            Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."ATM Transactions");

            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, Rec."Savings Product");
            if AccountTypes.Find('-') then begin
                MinAccBal := AccountTypes."Minimum Balance";
                FeeBelowMinBal := AccountTypes."Fee Below Minimum Balance";


                //Check Withdrawal Interval
                if Account.Status <> Account.Status::Deceased then begin
                    if VarTransactionType = VarTransactionType::Withdrawal then begin
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Savings Product");
                        if Account."Last Withdrawal Date" <> 0D then begin
                            if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then
                                IntervalPenalty := AccountTypes."Withdrawal Penalty";
                        end;
                    end;
                    //Check Withdrawal Interval

                    //Fixed Deposit
                    ChargesOnFD := 0;
                    if AccountTypes."Fixed Deposit" = true then begin
                        if Account."Expected Maturity Date" > Today then
                            ChargesOnFD := AccountTypes."Charge Closure Before Maturity";
                    end;
                    //Fixed Deposit


                    TotalUnprocessed := Account."Uncleared Cheques";
                    ATMBalance := Account."ATM Transactions";

                    //FD
                    if AccountTypes."Fixed Deposit" = false then begin
                        if Account.Balance < MinAccBal then
                            AvailableBalance := Account.Balance - FeeBelowMinBal - TCharges - MinAccBal - TotalUnprocessed - ATMBalance -
                                              Account."EFT Transactions" + Account."Cheque Discounted"// IntervalPenalty -
                        else
                            AvailableBalance := Account.Balance - TCharges - MinAccBal - TotalUnprocessed - ATMBalance -
                                              Account."EFT Transactions" + Account."Cheque Discounted";//IntervalPenalty -
                    end else begin
                        AvailableBalance := Account.Balance - TCharges - ChargesOnFD - Account."ATM Transactions" + Account."Cheque Discounted";
                    end;
                end;


            end;
        end;

        if Rec."N.A.H Balance" <> 0 then
            AvailableBalance := Rec."N.A.H Balance";
        //MESSAGE('Available balance is %1',AvailableBalance);

    end;


}