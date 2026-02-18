//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50000 "Transfer Custom Field"
{

    trigger OnRun()
    begin
    end;

    procedure CheckForLetters(PhoneNo: Text[100])
    var
        hasLetters: Boolean;
        i: Integer;
        c: Char;
        PhoneNoCannotContainLettersErr: Label 'Phone Number must not contain letters';
    begin
        hasLetters := false;
        for i := 1 to StrLen(PhoneNo) do begin
            c := PhoneNo[i];
            if ((c >= 'A') and (c <= 'Z')) or ((c >= 'a') and (c <= 'z')) then begin
                hasLetters := true;
                break;
            end;
        end;


        if hasLetters then
            Error(PhoneNoCannotContainLettersErr)

    end;

    procedure GenJnlLineTOGenLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var GenLedgEntry: Record "G/L Entry")
    begin
    end;


    procedure GenJnlLineTOTaxEntry(var GenJnlLine: Record "Gen. Journal Line"; var TaxEntry: Record "VAT Entry")
    begin
    end;


    procedure GenJnlLineTOCustLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
    end;


    procedure GenJnlLineTOVendLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var VendLedgEntry: Record "Vendor Ledger Entry")
    begin
    end;


    procedure GenJnlLineTOBankAccLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var BankAccLedgEntry: Record "Bank Account Ledger Entry")
    begin
    end;


    procedure BankAccLedgEntryTOChkLedgEntry(var BankAccLedgEntry: Record "Bank Account Ledger Entry"; var CheckLedgEntry: Record "Check Ledger Entry")
    begin
    end;


    procedure VendLedgEntryTOCVLedgEntryBuf(var VendLedgEntry: Record "Vendor Ledger Entry"; var CVLedgEntryBuf: Record "CV Ledger Entry Buffer")
    begin
    end;


    procedure CVLedgEntryBufTOVendLedgEntry(var CVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var VendLedgEntry: Record "Vendor Ledger Entry")
    begin
    end;


    procedure CustLedgEntryTOCVLedgEntryBuf(var CustLedgEntry: Record "Cust. Ledger Entry"; var CVLedgEntryBuf: Record "CV Ledger Entry Buffer")
    begin
    end;


    procedure CVLedgEntryBufTOCustLedgEntry(var CVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
    end;


    procedure ItemJnlLineTOItemLedgEntry(var ItemJnlLine: Record "Item Journal Line"; var ItemLedgEntry: Record "Item Ledger Entry")
    begin
    end;


    procedure ItemJnlLineTOPhysInvtLedgEntry(var ItemJnlLine: Record "Item Journal Line"; var PhysInvtLedgEntry: Record "Phys. Inventory Ledger Entry")
    begin
    end;


    procedure ItemJnlLineTOValueEntry(var ItemJnlLine: Record "Item Journal Line"; var ValueEntry: Record "Value Entry")
    begin
    end;


    procedure JobJnlLineTOResJnlLine(var JobJnlLine: Record "Job Journal Line"; var ResJnlLine: Record "Res. Journal Line")
    begin
    end;


    procedure JobJnlLineTOItemJnlLine(var JobJnlLine: Record "Job Journal Line"; var ItemJnlLine: Record "Item Journal Line")
    begin
    end;


    procedure JobJnlLineTOGenJnlLine(var JobJnlLine: Record "Job Journal Line"; var GenJnlLine: Record "Gen. Journal Line")
    begin
    end;


    procedure JobJnlLineTOJobLedgEntry(var JobJnlLine: Record "Job Journal Line"; var JobLedgEntry: Record "Job Ledger Entry")
    begin
    end;


    procedure ResJnlLineTOResLedgEntry(var ResJnlLine: Record "Res. Journal Line"; var ResLedgEntry: Record "Res. Ledger Entry")
    begin
    end;


    procedure GenJnlLineTOMembLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var MembLedgEntry: Record "Member Ledger Entry")
    begin
    end;


    procedure MembLedgEntryTOCVLedgEntryBuf(var MembLedgEntry: Record "Member Ledger Entry"; var CVLedgEntryBuf: Record "CV Ledger Entry Buffer")
    begin
    end;

    var
        Text001: label 'Status must be open';
        MovementTracker: Record "File Movement Tracker";
        FileMovementTracker: Record "File Movement Tracker";
        NextStage: Integer;
        EntryNo: Integer;
        NextLocation: Text[100];
        LoansBatch: Record "Loan Disburesment-Batching";
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        SmsManagement: Codeunit "Sms Management";
        Loans: Record "Loans Register";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        TotalTopupComm: Decimal;
        CustE: Record Customer;
        MpesaPush: Codeunit MobilePosting;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        LoanApps: Record "Loans Register";
        Banks: Record "Bank Account";
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        TotalSpecialLoan: Decimal;
        SpecialLoanCl: Record "Loan Special Clearance";
        Loans2: Record "Loans Register";
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        Refunds: Record "Loan Products Setup";
        TotalRefunds: Decimal;
        WithdrawalFee: Decimal;
        NetPayable: Decimal;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        OutstandingInt: Decimal;
        TSC: Decimal;
        LoanDisbAmount: Decimal;
        NegFee: Decimal;
        DValue: Record "Dimension Value";
        ChBank: Code[20];
        Trans: Record Transactions;
        TransactionCharges: Record "Transaction Charges";
        BChequeRegister: Record "Banker Cheque Register";
        OtherCommitments: Record "Other Commitements Clearance";
        BoostingComm: Decimal;
        BoostingCommTotal: Decimal;
        BridgedLoans: Record "Loan Special Clearance";
        InterestDue: Decimal;
        ContractualShares: Decimal;
        BridgingChanged: Boolean;
        BankersChqNo: Code[20];
        LastPayee: Text[100];
        RunningAmount: Decimal;
        BankersChqNo2: Code[20];
        BankersChqNo3: Code[20];
        EndMonth: Date;
        RemainingDays: Integer;
        PrincipalRepay: Decimal;
        InterestRepay: Decimal;
        TMonthDays: Integer;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Temp: Record Customer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        LBatches: Record "Loan Disburesment-Batching";
        // ApprovalMgt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        DescriptionEditable: Boolean;
        ModeofDisburementEditable: Boolean;
        DocumentNoEditable: Boolean;
        PostingDateEditable: Boolean;
        SourceEditable: Boolean;
        PayingAccountEditable: Boolean;
        ChequeNoEditable: Boolean;
        ChequeNameEditable: Boolean;
        upfronts: Decimal;
        EmergencyInt: Decimal;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        Deductions: Decimal;
        BatchBoostingCom: Decimal;
        HisaRepayment: Decimal;
        HisaLoan: Record "Loans Register";
        BatchHisaRepayment: Decimal;
        BatchFosaHisaComm: Decimal;
        BatchHisaShareBoostComm: Decimal;
        BatchShareCap: Decimal;
        BatchIntinArr: Decimal;
        Loaninsurance: Decimal;
        TLoaninsurance: Decimal;
        ProductCharges: Record "Loan Product Charges";
        InsuranceAcc: Code[20];
        PTEN: Code[20];
        LoanTypes: Record "Loan Products Setup";
        Customer: Record Customer;
        DataSheet: Record "Data Sheet Main";
        SMSAcc: Code[10];
        SMSFee: Decimal;
        UserSetup: Record "User Setup";
        LoanProcessingFee: Decimal;
        LoanProcessingFeeAcc: Code[20];
        InterestUpfrontSavers: Decimal;
        SaccoInterest: Decimal;
        SaccoInterestAccount: Code[20];
        SaccoIntRelief: Decimal;
        ArmotizationFactor: Decimal;
        compinfo: Record "Company Information";
        DisburesmentMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Mafanikio Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Loan Application has been Approved and Posted to your FOSA Account</p><p style="font-family:Verdana,Arial;font-size:9pt">Loan Product Type <b>%2</b></p><br>Regards<p>%3</p><p><b>MAFANIKIO SACCO LTD</b></p>';
        AccruedIntAcc: Code[20];
        AccruedInt: Decimal;
        TSCInterest: Decimal;
        TSCInterestAc: Code[20];
        IntCapitalized: Decimal;
        IntCapitalizedAcc: Code[20];
        LApplicationFee: Decimal;
        LApplicationFeeAcc: Code[20];
        IntCapitalizationFactor: Integer;
        VarAmounttoDisburse: Decimal;
        SFactory: Codeunit "Au Factory";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EFTAmount: Decimal;
        RTGSAmount: Decimal;
        MpesaChargeAmount: Decimal;
        VarMemberName: Text;
        ObjLoans: Record "Loans Register";
        ObjMember: Record Customer;
        VarMemberEmail: Text;
        //  SMTPSetup: Record "SMTP Mail Setup";
        Filename: Text;
        VarMailSubject: Text;
        VarMailBody: Text;
        Disbursed: Decimal;
        AmountToDisburse: Decimal;
        EmailSend: Boolean;
        Workflowintegration: Codeunit WorkflowIntegration;
        PChargeAmount: Decimal;
        ObjLoanType: Record "Loan Products Setup";
        VarLoanInsuranceBalAccount: Code[20];
        TotalPcharges: Decimal;
        Bloan: Code[25];
        VarLoanNo: code[25];
        MobileBankingCode: Codeunit "Mobile Banking Code";

    procedure FnDisburseToBankAccount(var LoanApps: Record "Loans Register"; LoanNo: Code[30])
    var
        RunningBalance: Decimal;
    begin
        VarLoanNo := LoanNo;
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := VarLoanNo;
        EFTAmount := 0;
        RTGSAmount := 0;
        MpesaChargeAmount := 0;


        GenSetUp.GET();
        IF LoanApps.GET(VarLoanNo) THEN BEGIN
            VarAmounttoDisburse := LoanApps."Approved Amount";
            if LoanApps."Loan Product Type" = 'DB' then begin

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", VarAmounttoDisburse, FORMAT(LoanApps.Source),
                LoanApps."Loan  No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


                //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
                PCharges.RESET;
                PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                PCharges.SetRange(PCharges."Loan Charge Type", PCharges."Loan Charge Type"::"Sms Fee");
                IF PCharges.FIND('-') THEN BEGIN
                    REPEAT
                        PCharges.TESTFIELD(PCharges."G/L Account");
                        GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                        PChargeAmount := PCharges.Amount * (LoanApps.Installments + 1);
                        //-------------------EARN CHARGE-------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");




                        TotalPCharges := TotalPCharges + PChargeAmount;
                    //----------------END 10% EXCISE--------------------------------------------
                    UNTIL PCharges.NEXT = 0;

                END;

                PCharges.RESET;
                PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                PCharges.SETFILTER(PCharges."Loan Charge Type", '<>%1&<>%2', PCharges."Loan Charge Type"::"Loan Insurance", PCharges."Loan Charge Type"::"Sms Fee");
                IF PCharges.FIND('-') THEN BEGIN
                    REPEAT

                        PCharges.TESTFIELD(PCharges."G/L Account");
                        GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                        PChargeAmount := PCharges.Amount;
                        IF PCharges."Use Perc" = TRUE THEN
                            PChargeAmount := (VarAmounttoDisburse * PCharges.Percentage / 100);//LoanDisbAmount
                                                                                               //-------------------EARN CHARGE-------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


                        TotalPCharges := TotalPCharges + PChargeAmount;
                    //----------------END 10% EXCISE--------------------------------------------
                    UNTIL PCharges.NEXT = 0;
                END;

                IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                    IF LoanType."Charge First Int" = TRUE THEN BEGIN
                        //----------------------Debit Interest Receivable Account a/c-----------------------------------------------------
                        Message('Loan interest charged upfront');
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", Round((LoanApps."Approved Amount" * LoanType."Interest rate" / (1200)), 1, '>'), 'BOSA', LoanApps."Cheque No.",
                        'Interest Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //----------------------Credit Interest Payable Account a/c-----------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Interest Account", LoanApps."Loan Disbursement Date", Round((LoanApps."approved Amount" * LoanType."Interest rate" / (1200)), 1, '>') * -1, 'BOSA', LoanApps."Cheque No.",
                        'Interest Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                    END;
                END;

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", VarAmounttoDisburse * -1, 'BOSA', LoanApps."Batch No.",
                'Deposit Boost By- ' + LoanApps."Loan Product Type" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                // LineNo := LineNo + 10000;
                // SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                // GenJournalLine."Account Type"::"G/L Account", GenSetUp."Deposit Boosting A/C", LoanApps."Loan Disbursement Date", (LoanApps."Deposit Boosting Commision") * -1, 'BOSA', LoanApps."Batch No.",
                // 'Deposit Boost Interest- ' + LoanApps."Loan Product Type" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


            end;

            if LoanApps."Loan Product Type" <> 'DB' then begin

                GenSetUp.GET();
                LoanApps.Reset();
                LoanApps.SetRange("Loan  No.", LoanNo);
                IF LoanApps.Find('-') THEN BEGIN
                    IF (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::"Full/Single disbursement") OR (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::" ") THEN BEGIN

                        VarAmounttoDisburse := LoanApps."Approved Amount";
                        AmountToDisburse := LoanApps."Loan Disbursed Amount";
                    END ELSE BEGIN
                        VarAmounttoDisburse := LoanApps."Amount to Disburse on Trunch 1";
                        AmountToDisburse := LoanApps."Amount to Disburse on Trunch 1";
                        IF VarAmounttoDisburse <= 0 THEN
                            ERROR('You have specified Disbursement Mode as Trunch/Multiple Disbursement, Amount to Disburse on Trunch 1 must be greater than zero.')
                    END;
                    If LoanApps."Loan Product Type" = 'DB' then begin
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", VarAmounttoDisburse, FORMAT(LoanApps.Source),
                        LoanApps."Cheque No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


                        //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                        PCharges.SetRange(PCharges."Loan Charge Type", PCharges."Loan Charge Type"::"Sms Fee");
                        IF PCharges.FIND('-') THEN BEGIN
                            REPEAT
                                PCharges.TESTFIELD(PCharges."G/L Account");
                                GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                                PChargeAmount := PCharges.Amount * (LoanApps.Installments + 1);
                                //-------------------EARN CHARGE-------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Cheque No.",
                                PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                                TotalPCharges := TotalPCharges + PChargeAmount;
                                RunningBalance := RunningBalance + VarAmounttoDisburse - TotalPcharges;
                            //----------------END 10% EXCISE--------------------------------------------
                            UNTIL PCharges.NEXT = 0;
                        END;
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                        PCharges.SETFILTER(PCharges."Loan Charge Type", '<>%1&<>%2', PCharges."Loan Charge Type"::"Loan Insurance", PCharges."Loan Charge Type"::"Sms Fee");
                        IF PCharges.FIND('-') THEN BEGIN
                            REPEAT

                                PCharges.TESTFIELD(PCharges."G/L Account");
                                GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                                PChargeAmount := PCharges.Amount;
                                IF PCharges."Use Perc" = TRUE THEN
                                    PChargeAmount := Round((VarAmounttoDisburse * PCharges.Percentage / 100), 1, '>');//LoanDisbAmount
                                                                                                                      //-------------------EARN CHARGE-------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Cheque No.",
                                PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                                TotalPCharges := TotalPCharges + PChargeAmount;
                                RunningBalance := RunningBalance - TotalPcharges;
                            //----------------END 10% EXCISE--------------------------------------------
                            UNTIL PCharges.NEXT = 0;
                        END;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", (LoanApps."Loan Disbursed Amount") * -1, 'BOSA', LoanApps."Cheque No.",
                        'Deposit Boost - ' + LoanApps."Loan Product Type" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                    end;

                    if LoanApps."Loan Product Type" <> 'DB' then begin

                        LoanApps.posted := false;
                        LoanApps.CALCFIELDS(LoanApps."Loan Offset Amount", LoanApps."Offset iNTEREST");
                        TCharges := 0;
                        TopUpComm := 0;
                        TotalTopupComm := LoanApps."Loan Offset Amount";

                        //IF (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::"Full/Single disbursement") OR (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::" ") THEN BEGIN
                        //VarAmounttoDisburse := LoanApps."Approved Amount";
                        //share capital

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Share Capital",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Share Capital Contrib" * -1, FORMAT(LoanApps.Source),
                        LoanApps."Loan  No.", 'Share Capital from- ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //programmed deposits
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Programmed Deposits",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Programmed Deposit Contrib" * -1, FORMAT(LoanApps.Source),
                        LoanApps."Cheque No.", 'Programmed deposits from- ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //deposit contribution
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Deposit Contrib" * -1, FORMAT(LoanApps.Source),
                        LoanApps."Cheque No.", 'Deposit contribution from- ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", VarAmounttoDisburse, FORMAT(LoanApps.Source),
                        LoanApps."Cheque No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //--------------------------------(Debit Member Loan Account)---------------------------------------------

                        RunningBalance := RunningBalance + VarAmounttoDisburse - LoanApps."Share Capital Contrib" - LoanApps."Deposit Contrib" - LoanApps."Programmed Deposit Contrib";
                        //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                        PCharges.SetRange(PCharges."Loan Charge Type", PCharges."Loan Charge Type"::"Sms Fee");
                        IF PCharges.FIND('-') THEN BEGIN
                            REPEAT
                                PCharges.TESTFIELD(PCharges."G/L Account");
                                GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                                PChargeAmount := PCharges.Amount * (LoanApps.Installments + 1);
                                //-------------------EARN CHARGE-------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Cheque No.",
                                PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");




                                TotalPCharges := TotalPCharges + PChargeAmount;//
                                RunningBalance := RunningBalance - TotalPcharges;
                            //----------------END 10% EXCISE--------------------------------------------
                            UNTIL PCharges.NEXT = 0;
                        END;
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                        PCharges.SETFILTER(PCharges."Loan Charge Type", '<>%1&<>%2', PCharges."Loan Charge Type"::"Loan Insurance", PCharges."Loan Charge Type"::"Sms Fee");
                        IF PCharges.FIND('-') THEN BEGIN
                            REPEAT

                                PCharges.TESTFIELD(PCharges."G/L Account");
                                PChargeAmount := PCharges.Amount;
                                IF PCharges."Use Perc" = TRUE THEN
                                    PChargeAmount := Round((VarAmounttoDisburse * PCharges.Percentage / 100), 1, '>');//LoanDisbAmount
                                                                                                                      //-------------------EARN CHARGE-------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Cheque No.",
                                PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


                                //------------------10% EXCISE DUTY----------------------------------------
                                // IF SFactory.FnChargeExcise(PCharges.Code) THEN BEGIN
                                //     //-------------------Earn--------------------------------- 
                                //     LineNo := LineNo + 10000;
                                //     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                //     GenJournalLine."Account Type"::"G/L Account", GenSetUp."Excise Duty Account", LoanApps."Loan Disbursement Date", (PChargeAmount * -1) * 0, 'BOSA', LoanApps."Loan  No.",
                                //     PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                                // END;

                                TotalPCharges := TotalPCharges + PChargeAmount;
                                RunningBalance := RunningBalance - TotalPcharges;
                            //----------------END 10% EXCISE--------------------------------------------
                            UNTIL PCharges.NEXT = 0;
                        END;

                        if LoanApps."Mode Of Disbursement" = LoanApps."Mode Of Disbursement"::EFT then begin
                            EFTAmount := GenSetUp."Loan Trasfer Fee-EFT";
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", GenSetUp."Loan Trasfer Fee A/C-EFT", LoanApps."Loan Disbursement Date", EFTAmount * -1, 'BOSA', LoanApps."Cheque No.",
                            'EFT Charge' + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                            RunningBalance := RunningBalance - EFTAmount;
                        end;
                        if LoanApps."Mode Of Disbursement" = LoanApps."Mode Of Disbursement"::RTGS then begin
                            RTGSAmount := GenSetUp."Loan Trasfer Fee-RTGS";
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", GenSetUp."Loan Trasfer Fee A/C-RTGS", LoanApps."Loan Disbursement Date", RTGSAmount * -1, 'BOSA', LoanApps."Cheque No.",
                            'RTGS Charge' + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                            RunningBalance := RunningBalance - RTGSAmount;
                        end;
                        if LoanApps."Mode Of Disbursement" = LoanApps."Mode Of Disbursement"::Mpesa then begin
                            if LoanApps."Approved Amount" <= 10000 then begin
                                MpesaChargeAmount := GenSetUp."M-Pesa Charge(0-10K)";


                            end else begin
                                MpesaChargeAmount := GenSetUp."M-Pesa Charge(>10K)";
                            end;


                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", GenSetUp."Mpesa A/c", LoanApps."Loan Disbursement Date", MpesaChargeAmount * -1, 'BOSA', LoanApps."Cheque No.",
                            'Mpesa Charge' + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                            RunningBalance := RunningBalance - MpesaChargeAmount;
                        end;
                        //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------     

                        LoanTopUp.RESET;
                        LoanTopUp.SETRANGE(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                        LoanTopUp.SetRange("Client Code", LoanApps."Client Code");
                        IF LoanTopUp.FindSet() THEN BEGIN
                            REPEAT

                                //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                                //------------------------------------Principal---------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", ROUND(LoanTopUp."Principle Top Up", 0.01, '>') * -1, 'BOSA', LoanTopUp."Loan Top Up",
                                'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");
                                //------------------------------------Outstanding Interest----------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", ROUND(LoanTopUp."Interest Top Up", 0.01, '>') * -1, 'BOSA', LoanTopUp."Loan Top Up",
                                'Interest Paid- ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");

                                //------------------------------------Outstanding Penalty----------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Penalty Paid",
                                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", ROUND(LoanTopUp."Penalty Charged", 0.01, '>') * -1, 'BOSA', LoanTopUp."Loan Top Up",
                                'Penalty Paid- ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");
                                //-------------------------------------Levy--------------------------
                                LineNo := LineNo + 10000;
                                IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::"G/L Account", LoanType."Top Up Commision Account", LoanApps."Loan Disbursement Date", ROUND(LoanTopUp.Commision, 0.01, '>') * -1, 'BOSA', LoanTopUp."Loan Top Up",
                                    'Interest on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");

                                END;

                                IF ObjLoans.GET(LoanTopUp."Loan Top Up") THEN BEGIN
                                    IF ObjLoanType.GET(ObjLoans."Loan Product Type") THEN BEGIN
                                        VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                                    END;
                                END;

                                RunningBalance := RunningBalance - ROUND(LoanTopUp.Commision, 0.01, '>') - ROUND(LoanTopUp."Interest Top Up", 0.01, '>') - ROUND(LoanTopUp."Principle Top Up", 0.01, '>') - ROUND(LoanTopUp."Penalty Charged", 0.01, '>');
                                //------------------------------Credit Excise Duty Account-----------------------------------------------

                                if LoanApps."Loan Disbursed Amount" <> 0 then
                                    RunningBalance := RunningBalance
                                else
                                    RunningBalance := LoanApps."Loan Disbursed Amount";
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", GenSetUp."Excise Duty Account", LoanApps."Loan Disbursement Date", Round((LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)), 1, '>') * -1, 'BOSA', LoanApps."Cheque No.",
                                'Excise Duty_Interest on Bridging', LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                                RunningBalance := RunningBalance - Round((LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)), 1, '>');

                            UNTIL LoanTopUp.NEXT = 0;
                        END;
                        //END;

                        //-----------------------------------------Accrue insurance on Disburesment--------------------------------------------------------------------------------------------

                        IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                            IF LoanType."Accrue Total Insurance&Interes" = TRUE THEN BEGIN


                                PCharges.RESET;
                                PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                                PCharges.SETRANGE(PCharges."Loan Charge Type", PCharges."Loan Charge Type"::"Loan Insurance");
                                IF PCharges.FIND('-') THEN BEGIN
                                    PCharges.TESTFIELD(PCharges."G/L Account");
                                    GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                                    PChargeAmount := PCharges.Amount;
                                    IF PCharges."Use Perc" = TRUE THEN
                                        PChargeAmount := Round((LoanApps."Approved Amount" * PCharges.Percentage / 100), 1, '>');
                                    //----------------------Debit insurance Receivable Account a/c-----------------------------------------------------


                                    //----------------------Credit Insurance Payable Account a/c-----------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Insurance Accounts", LoanApps."Loan Disbursement Date", (PChargeAmount * LoanType."No of Installment") * -1, 'BOSA', LoanApps."Cheque No.",
                                    'Insurance Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                                END;
                            END;
                        END;

                        //accrue Interest

                        IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                            IF LoanType."Charge First Int" = TRUE THEN BEGIN
                                //----------------------Debit Interest Receivable Account a/c-----------------------------------------------------

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
                                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", Round((LoanApps."Approved Amount" * LoanType."Interest rate" / (1200)), 1, '>'), 'BOSA', LoanApps."Cheque No.",
                                'Interest Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                                //----------------------Credit Interest Payable Account a/c-----------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Interest Account", LoanApps."Loan Disbursement Date", Round((LoanApps."approved Amount" * LoanType."Interest rate" / (1200)), 1, '>') * -1, 'BOSA', LoanApps."Cheque No.",
                                'Interest Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                            END;
                        END;

                        if LoanApps.CRBQuerryCharge > 0 then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", '801052', LoanApps."Loan Disbursement Date", LoanApps.CRBQuerryCharge * -1, 'BOSA', LoanApps."Cheque No.",
                           'CRB Charge ' + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                            RunningBalance := RunningBalance - LoanApps.CRBQuerryCharge;

                        end;

                        //-----------------------------------------5. BOOST DEPOSITS COMMISSION / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
                        //IF LoanApps."Deposit Boosting" > 0 THEN BEGIN
                        if LoanApps."Loan Product Type" <> 'DB' then begin

                            GenSetUp.GET();
                            //------------------------------Credit Income G/L-----------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                            GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Deposit Boosting" * -1, 'BOSA', LoanApps."Cheque No.",
                            'Deposits Booster', LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


                            GenSetUp.GET();
                            //------------------------------Credit Excise Duty Account-----------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",

                            GenJournalLine."Account Type"::"G/L Account", GenSetUp."Deposit Boosting A/C", LoanApps."Loan Disbursement Date", LoanApps."Deposit Boosting Commision" * -1, 'BOSA', LoanApps."Cheque No.",
                            'Deposit Boosting Commision', LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                            GenSetUp.GET();
                            RunningBalance := RunningBalance - LoanApps."Deposit Boosting" - LoanApps."Deposit Boosting Commision";
                        END;


                        //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"Bank Account", LoanApps."Paying Bank Account No", LoanApps."Loan Disbursement Date", (RunningBalance) * -1, 'BOSA', LoanApps."Cheque No.",
                        'Loan Disbursement - ' + LoanApps."Loan Product Type" + ' - ' + LoanApps."Client Name", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //----------------------------------(Credit Member Bank Account)------------------------------------------------




                        // IF ObjLoans.GET(VarLoanNo) THEN BEGIN
                        //     ObjLoans."Net Payment to FOSA" := ObjLoans."Approved Amount";
                        //     ObjLoans."Processed Payment" := TRUE;
                        //     ObjLoans.MODIFY;
                        // END;
                    END;
                end;


            end;
        end;
    end;

    procedure FnDisburseToCurrentAccount(var LoanApps: Record "Loans Register"; var VarLoanNo: code[30])
    begin
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := VarLoanNo;

        GenSetUp.GET();
        IF LoanApps.GET(VarLoanNo) THEN BEGIN

            //share capital
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Share Capital",
            GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps.ShareCapitalToDeduct * -1, FORMAT(LoanApps.Source),
            LoanApps."Loan  No.", 'Share Capital from - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

            LoanApps.CALCFIELDS(LoanApps."Loan Offset Amount", LoanApps."Offset iNTEREST");
            TCharges := 0;
            TopUpComm := 0;
            TotalTopupComm := LoanApps."Loan Offset Amount";
            IF (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::"Full/Single disbursement") OR (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::" ") THEN BEGIN
                VarAmounttoDisburse := LoanApps."Approved Amount"
            END ELSE BEGIN
                VarAmounttoDisburse := LoanApps."Amount to Disburse on Trunch 1";
                IF VarAmounttoDisburse <= 0 THEN
                    ERROR('You have specified Disbursement Mode as Tranche/Multiple Disbursement, Amount to Disburse on Tranche 1 must be greater than zero.')
            END;

            //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
            GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", VarAmounttoDisburse, FORMAT(LoanApps.Source), LoanApps."Loan  No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
            //--------------------------------(Debit Member Loan Account)---------------------------------------------

            //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::Vendor, LoanApps."Account No", LoanApps."Loan Disbursement Date", VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
            //----------------------------------(Credit Member Fosa Account)------------------------------------------------

            //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
            PCharges.RESET;
            PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
            PCharges.SETFILTER(PCharges."Loan Charge Type", '<>%1', PCharges."Loan Charge Type"::"Loan Insurance");
            IF PCharges.FIND('-') THEN BEGIN
                REPEAT
                    PCharges.TESTFIELD(PCharges."G/L Account");
                    GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                    PChargeAmount := PCharges.Amount;
                    IF PCharges."Use Perc" = TRUE THEN
                        PChargeAmount := (VarAmounttoDisburse * PCharges.Percentage / 100);//LoanDisbAmount
                                                                                           //-------------------EARN CHARGE-------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                    //-------------------RECOVER-----------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, LoanApps."Account No", LoanApps."Loan Disbursement Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                    //------------------10% EXCISE DUTY----------------------------------------
                    IF SFactory.FnChargeExcise(PCharges.Code) THEN BEGIN
                        //-------------------Earn--------------------------------- 
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"G/L Account", GenSetUp."Excise Duty Account", LoanApps."Loan Disbursement Date", (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //-----------------Recover---------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::Vendor, LoanApps."Account No", LoanApps."Loan Disbursement Date", PChargeAmount * 0, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Loan Product Type Name" + ' - Excise(10%)', LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                    END
                //----------------END 10% EXCISE--------------------------------------------
                UNTIL PCharges.NEXT = 0;
            END;


            //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------     
            //IF LoanApps."Loan Offset Amount" > 0 THEN BEGIN
            LoanTopUp.RESET;
            LoanTopUp.SETRANGE(LoanTopUp."Loan No.", LoanApps."Loan  No.");
            IF LoanTopUp.FIND('-') THEN BEGIN
                REPEAT
                    //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                    //------------------------------------Principal---------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                    GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                    'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");
                    //------------------------------------Outstanding Interest----------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                    GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                    'Interest Paid- ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");
                    //-------------------------------------Levy--------------------------
                    LineNo := LineNo + 10000;
                    IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"G/L Account", LoanType."Top Up Commision Account", LoanApps."Loan Disbursement Date", LoanTopUp.Commision * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Interest on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");
                    END;


                    IF ObjLoans.GET(LoanTopUp."Loan Top Up") THEN BEGIN
                        IF ObjLoanType.GET(ObjLoans."Loan Product Type") THEN BEGIN
                            VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                        END;
                    END;



                    //-------------------------------------RECOVER-------------------------------------------------------------------------------------------------------
                    //-------------------------------------Principal-----------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, LoanApps."Account No", LoanApps."Loan Disbursement Date", LoanTopUp."Principle Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                    'Loan Offset  - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");
                    //-------------------------------------Outstanding Interest-------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, LoanApps."Account No", LoanApps."Loan Disbursement Date", LoanTopUp."Interest Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                    'Interest Paid on topup - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");

                    //-------------------------------------Insurance For the Year-------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, LoanApps."Account No", LoanApps."Loan Disbursement Date", LoanTopUp."Loan Insurance: Current Year", 'BOSA', LoanTopUp."Loan Top Up",
                    'Insurance on Loan Clearance - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");
                    //--------------------------------------Levies--------------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::Vendor, LoanApps."Account No", LoanApps."Loan Disbursement Date", LoanTopUp.Commision, 'BOSA', LoanTopUp."Loan Top Up",
                        'Interest on Bridging - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");
                    END;

                    //------------------------------Credit Excise Duty Account-----------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", GenSetUp."Excise Duty Account", LoanApps."Loan Disbursement Date", (LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
                    'Excise Duty_Interest on Bridging', BLoan, GenJournalLine."Application Source"::" ");

                    //----------------------Debit FOSA A/C Excise Duty on Bridging Fee-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::Vendor, LoanApps."Account No", LoanApps."Loan Disbursement Date", (LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', BLoan,
                    'Excise Duty_Interest on Bridging', BLoan, GenJournalLine."Application Source"::" ");
                UNTIL LoanTopUp.NEXT = 0;
            END;


            //-----------------------------------------Accrue Interest Disburesment--------------------------------------------------------------------------------------------
            IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                IF LoanType."Accrue Total Insurance&Interes" = TRUE THEN BEGIN

                    //----------------------Debit interest Receivable Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
                    GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", (LoanApps."Approved Amount" * (LoanType."Interest rate" / 100)) * LoanType."No of Installment", 'BOSA', BLoan,
                    'Interest Due' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                    //----------------------Credit interest Income Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Interest Account", LoanApps."Loan Disbursement Date", ((LoanApps."Approved Amount" * (LoanType."Interest rate" / 100)) * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                    'Interest Due' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                END;
            END;


            //-----------------------------------------Accrue insurance on Disburesment--------------------------------------------------------------------------------------------

            IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                IF LoanType."Accrue Total Insurance&Interes" = TRUE THEN BEGIN


                    PCharges.RESET;
                    PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                    PCharges.SETRANGE(PCharges."Loan Charge Type", PCharges."Loan Charge Type"::"Loan Insurance");
                    IF PCharges.FIND('-') THEN BEGIN
                        PCharges.TESTFIELD(PCharges."G/L Account");
                        GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                        PChargeAmount := PCharges.Amount;
                        IF PCharges."Use Perc" = TRUE THEN
                            PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);


                        //----------------------Credit Insurance Payable Account a/c-----------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Insurance Accounts", LoanApps."Loan Disbursement Date", (PChargeAmount * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                        'Insurance Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                    END;
                END;
            END;



            //-----------------------------------------5. BOOST DEPOSITS COMMISSION / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
            IF LoanApps."Share Boosting Comission" > 0 THEN BEGIN

                //----------------------Debit FOSA a/c-----------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, LoanApps."Account No", LoanApps."Loan Disbursement Date", LoanApps."Share Boosting Comission", 'BOSA', BLoan,
                'Deposits Boosting Fee', BLoan, GenJournalLine."Application Source"::" ");

                GenSetUp.GET();
                //------------------------------Credit Income G/L-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", GenSetUp."Boosting Fees Account", LoanApps."Loan Disbursement Date", LoanApps."Share Boosting Comission" * -1, 'BOSA', BLoan,
                'Deposits Boosting Fee', BLoan, GenJournalLine."Application Source"::" ");

                //----------------------Debit FOSA A/C Excise Duty on Boosting Fee-----------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::Vendor, LoanApps."Account No", LoanApps."Loan Disbursement Date", (LoanApps."Share Boosting Comission" * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', BLoan,
                'Excise Duty_Boosting Fee', BLoan, GenJournalLine."Application Source"::" ");

                GenSetUp.GET();
                //------------------------------Credit Excise Duty Account-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account", GenSetUp."Excise Duty Account", LoanApps."Loan Disbursement Date", (LoanApps."Share Boosting Comission" * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
                'Excise Duty_Boosting Fee', BLoan, GenJournalLine."Application Source"::" ");


            END;


            IF ObjLoans.GET(VarLoanNo) THEN BEGIN
                ObjLoans."Net Payment to FOSA" := ObjLoans."Approved Amount";
                ObjLoans."Processed Payment" := TRUE;
                ObjLoans.MODIFY;
            END;
        END;
    end;

    procedure FnSendDisburesmentSMS(LoanNo: Code[20]; AccountNo: Code[20])
    var
        Message: Text;
        AU: Codeunit "AU Paybill Automations";
        LoanRepayment: Decimal;
        LoanAmount: Decimal;
        ApprovedAmount: Decimal;
        Instalment: Decimal;
    begin

        GenSetUp.Get;
        compinfo.Get;
        LoanAmount := 0;
        ApprovedAmount := 0;
        Instalment := 0;
        LoanApp.Reset();
        LoanApp.SetRange("Loan  No.", LoanNo);
        if LoanApp.FindFirst() then begin
            LoanRepayment := LoanApp.Repayment;
            LoanAmount := LoanApp."Approved Amount";
            Instalment := LoanApp.Installments;
        end;
        //loan Product
        Cust.Reset;
        Cust.SetRange(Cust."No.", AccountNo);
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";

            if Cust."Mobile Phone No" <> '' then
                SMSMessage.Insert;
            Message := '';
            Message := 'Dear ' + Format(AU.SplitString(Cust.Name, '')) + ' ' + 'Thank you for patronizing our loan products! ' + 'Your loan of Kes.' + Format(LoanAmount) + '-' + 'has been Posted.' + 'Funds will be disbursed within 7 days.';
            SmsManagement.SendSmsResponse(Cust."Mobile Phone No", Message);

        end;
    end;

    procedure FnSendDisburesmentEmail(LoanNo: Code[20])

    var
        LoanRec: Record "Loans Register";
        SMTPMail: Codeunit "Email Message";
        SMTPSetup: Codeunit Email;
        FileName: Text[1000];
        Attachment: Text[2000];
        CompanyInfo: Record "Company Information";
        Email: Text[1000];
        Recipients: list of [Text];
        EmailTextBuilder: TextBuilder;
        FormattedBody: Text;
        DearCandidateLbl: Label '<p>Dear %1,</p></br>';
        KindRegardsLbl: Label '<p>Kind Regards</p><br> %2 <br>';
        NewBody: Text;
        EmailBody: Text;
        ClientName: Text;
        Subject: Label 'Loan Disbursment';
    begin
        //SMTPSetup.Get();
        ClientName := '';
        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Loan  No.", LoanNo);
        if LoanRec.Find('-') then begin
            if Cust.Get(LoanRec."Client Code") then begin
                Email := LowerCase(Cust."E-Mail (Personal)");
                ClientName := Cust.Name;
            end;
            if Email = '' then begin
                Message('Email Address Missing for Loan Application number' + '-' + LoanRec."Loan  No.");
            end;

            if Email <> '' then begin
                EmailBody := '<p>Your loan of <Strong>%3</Strong> has been disbursed.</p>';
                EmailTextBuilder.Clear();
                EmailTextBuilder.Append(DearCandidateLbl);
                EmailTextBuilder.Append(EmailBody);
                EmailTextBuilder.Append(KindRegardsLbl);
                NewBody := EmailTextBuilder.ToText();
                FormattedBody := StrSubstNo(NewBody, ClientName, CompanyInfo.Name, LoanRec."Approved Amount");


                SMTPMail.create(Email, Subject, FormattedBody, true);

            end;
        end;
    end;

    procedure FnDisburseToDisbursmentAccount(var LoanApps: Record "Loans Register"; LoanNo: Code[30])
    var
        RunningBalance: Decimal;
    begin
        VarLoanNo := LoanNo;
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := VarLoanNo;
        EFTAmount := 0;
        RTGSAmount := 0;
        MpesaChargeAmount := 0;


        GenSetUp.GET();
        IF LoanApps.GET(VarLoanNo) THEN BEGIN
            VarAmounttoDisburse := LoanApps."Approved Amount";
            if LoanApps."Loan Product Type" = 'DB' then begin
                //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
                PCharges.RESET;
                PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                PCharges.SetRange(PCharges."Loan Charge Type", PCharges."Loan Charge Type"::"Sms Fee");
                IF PCharges.FIND('-') THEN BEGIN
                    REPEAT
                        PCharges.TESTFIELD(PCharges."G/L Account");
                        GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                        PChargeAmount := PCharges.Amount * (LoanApps.Installments + 1);
                        //-------------------EARN CHARGE-------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");




                        TotalPCharges := TotalPCharges + PChargeAmount;
                    //----------------END 10% EXCISE--------------------------------------------
                    UNTIL PCharges.NEXT = 0;

                END;

                PCharges.RESET;
                PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                PCharges.SETFILTER(PCharges."Loan Charge Type", '<>%1&<>%2', PCharges."Loan Charge Type"::"Loan Insurance", PCharges."Loan Charge Type"::"Sms Fee");
                IF PCharges.FIND('-') THEN BEGIN
                    REPEAT

                        PCharges.TESTFIELD(PCharges."G/L Account");
                        GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                        PChargeAmount := PCharges.Amount;
                        IF PCharges."Use Perc" = TRUE THEN
                            PChargeAmount := (VarAmounttoDisburse * PCharges.Percentage / 100);

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


                        TotalPCharges := TotalPCharges + PChargeAmount;
                    //----------------END 10% EXCISE--------------------------------------------
                    UNTIL PCharges.NEXT = 0;
                END;

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", VarAmounttoDisburse * -1, 'BOSA', LoanApps."Batch No.",
                'Deposit Boost By- ' + LoanApps."Loan Product Type" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", (VarAmounttoDisburse + PChargeAmount), FORMAT(LoanApps.Source),
                LoanApps."Loan  No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


                IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                    IF LoanType."Charge First Int" = TRUE THEN BEGIN
                        //----------------------Debit Interest Receivable Account a/c-----------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", Round((LoanApps."Approved Amount" * LoanType."Interest rate" / (1200)), 1, '>'), 'BOSA', LoanApps."Cheque No.",
                        'Interest Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //----------------------Credit Interest Payable Account a/c-----------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Interest Account", LoanApps."Loan Disbursement Date", Round((LoanApps."approved Amount" * LoanType."Interest rate" / (1200)), 1, '>') * -1, 'BOSA', LoanApps."Cheque No.",
                        'Interest Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                    END;
                END;
            end;

            if LoanApps."Loan Product Type" <> 'DB' then begin

                GenSetUp.GET();
                LoanApps.Reset();
                LoanApps.SetRange("Loan  No.", LoanNo);
                IF LoanApps.Find('-') THEN BEGIN
                    IF (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::"Full/Single disbursement") OR (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::" ") THEN BEGIN

                        VarAmounttoDisburse := LoanApps."Approved Amount";
                        AmountToDisburse := LoanApps."Loan Disbursed Amount";
                    END ELSE BEGIN
                        VarAmounttoDisburse := LoanApps."Amount to Disburse on Trunch 1";
                        AmountToDisburse := LoanApps."Amount to Disburse on Trunch 1";
                        IF VarAmounttoDisburse <= 0 THEN
                            ERROR('You have specified Disbursement Mode as Trunch/Multiple Disbursement, Amount to Disburse on Trunch 1 must be greater than zero.')
                    END;
                    If LoanApps."Loan Product Type" = 'DB' then begin
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", VarAmounttoDisburse, FORMAT(LoanApps.Source),
                        LoanApps."Cheque No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


                        //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                        PCharges.SetRange(PCharges."Loan Charge Type", PCharges."Loan Charge Type"::"Sms Fee");
                        IF PCharges.FIND('-') THEN BEGIN
                            REPEAT
                                PCharges.TESTFIELD(PCharges."G/L Account");
                                GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                                PChargeAmount := PCharges.Amount * (LoanApps.Installments + 1);
                                //-------------------EARN CHARGE-------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Cheque No.",
                                PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                                TotalPCharges := TotalPCharges + PChargeAmount;
                                RunningBalance := RunningBalance + VarAmounttoDisburse - TotalPcharges;
                            //----------------END 10% EXCISE--------------------------------------------
                            UNTIL PCharges.NEXT = 0;
                        END;
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                        PCharges.SETFILTER(PCharges."Loan Charge Type", '<>%1&<>%2', PCharges."Loan Charge Type"::"Loan Insurance", PCharges."Loan Charge Type"::"Sms Fee");
                        IF PCharges.FIND('-') THEN BEGIN
                            REPEAT

                                PCharges.TESTFIELD(PCharges."G/L Account");
                                GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                                PChargeAmount := PCharges.Amount;
                                IF PCharges."Use Perc" = TRUE THEN
                                    PChargeAmount := Round((VarAmounttoDisburse * PCharges.Percentage / 100), 1, '>');//LoanDisbAmount
                                                                                                                      //-------------------EARN CHARGE-------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Cheque No.",
                                PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                                TotalPCharges := TotalPCharges + PChargeAmount;
                                RunningBalance := RunningBalance - TotalPcharges;
                            //----------------END 10% EXCISE--------------------------------------------
                            UNTIL PCharges.NEXT = 0;
                        END;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", (LoanApps."Loan Disbursed Amount") * -1, 'BOSA', LoanApps."Cheque No.",
                        'Deposit Boost - ' + LoanApps."Loan Product Type" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                    end;

                    if LoanApps."Loan Product Type" <> 'DB' then begin

                        LoanApps.posted := false;
                        LoanApps.CALCFIELDS(LoanApps."Loan Offset Amount", LoanApps."Offset iNTEREST");
                        TCharges := 0;
                        TopUpComm := 0;
                        TotalTopupComm := LoanApps."Loan Offset Amount";

                        //IF (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::"Full/Single disbursement") OR (LoanApps."Disburesment Type" = LoanApps."Disburesment Type"::" ") THEN BEGIN
                        //VarAmounttoDisburse := LoanApps."Approved Amount";
                        //share capital

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Share Capital",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Share Capital Contrib" * -1, FORMAT(LoanApps.Source),
                        LoanApps."Loan  No.", 'Share Capital from- ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //programmed deposits
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Programmed Deposits",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Programmed Deposit Contrib" * -1, FORMAT(LoanApps.Source),
                        LoanApps."Cheque No.", 'Programmed deposits from- ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //deposit contribution
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Deposit Contrib" * -1, FORMAT(LoanApps.Source),
                        LoanApps."Cheque No.", 'Deposit contribution from- ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Loan,
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", VarAmounttoDisburse, FORMAT(LoanApps.Source),
                        LoanApps."Cheque No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //--------------------------------(Debit Member Loan Account)---------------------------------------------
                        //deposit contribution
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Benevolent Fund",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Benevolent Fund Contrib" * -1, FORMAT(LoanApps.Source),
                        LoanApps."Cheque No.", 'Benevolent Fund contribution from- ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


                        RunningBalance := RunningBalance + VarAmounttoDisburse - LoanApps."Share Capital Contrib" - LoanApps."Deposit Contrib" - LoanApps."Programmed Deposit Contrib" - LoanApps."Benevolent Fund Contrib";
                        //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                        PCharges.SetRange(PCharges."Loan Charge Type", PCharges."Loan Charge Type"::"Sms Fee");
                        IF PCharges.FIND('-') THEN BEGIN
                            REPEAT
                                PCharges.TESTFIELD(PCharges."G/L Account");
                                GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                                PChargeAmount := PCharges.Amount * (LoanApps.Installments + 1);
                                //-------------------EARN CHARGE-------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Cheque No.",
                                PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");




                                TotalPCharges := TotalPCharges + PChargeAmount;//
                                RunningBalance := RunningBalance - TotalPcharges;
                            //----------------END 10% EXCISE--------------------------------------------
                            UNTIL PCharges.NEXT = 0;
                        END;
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                        PCharges.SETFILTER(PCharges."Loan Charge Type", '<>%1&<>%2', PCharges."Loan Charge Type"::"Loan Insurance", PCharges."Loan Charge Type"::"Sms Fee");
                        IF PCharges.FIND('-') THEN BEGIN
                            REPEAT

                                PCharges.TESTFIELD(PCharges."G/L Account");
                                PChargeAmount := PCharges.Amount;
                                IF PCharges."Use Perc" = TRUE THEN
                                    PChargeAmount := Round((VarAmounttoDisburse * PCharges.Percentage / 100), 1, '>');//LoanDisbAmount
                                                                                                                      //-------------------EARN CHARGE-------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Cheque No.",
                                PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


                                //------------------10% EXCISE DUTY----------------------------------------
                                // IF SFactory.FnChargeExcise(PCharges.Code) THEN BEGIN
                                //     //-------------------Earn--------------------------------- 
                                //     LineNo := LineNo + 10000;
                                //     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                //     GenJournalLine."Account Type"::"G/L Account", GenSetUp."Excise Duty Account", LoanApps."Loan Disbursement Date", (PChargeAmount * -1) * 0, 'BOSA', LoanApps."Loan  No.",
                                //     PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                                // END;

                                TotalPCharges := TotalPCharges + PChargeAmount;
                                RunningBalance := RunningBalance - TotalPcharges;
                            //----------------END 10% EXCISE--------------------------------------------
                            UNTIL PCharges.NEXT = 0;
                        END;

                        if LoanApps."Mode Of Disbursement" = LoanApps."Mode Of Disbursement"::EFT then begin
                            EFTAmount := GenSetUp."Loan Trasfer Fee-EFT";
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", GenSetUp."Loan Trasfer Fee A/C-EFT", LoanApps."Loan Disbursement Date", EFTAmount * -1, 'BOSA', LoanApps."Cheque No.",
                            'EFT Charge' + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                            RunningBalance := RunningBalance - EFTAmount;
                        end;
                        if LoanApps."Mode Of Disbursement" = LoanApps."Mode Of Disbursement"::RTGS then begin
                            RTGSAmount := GenSetUp."Loan Trasfer Fee-RTGS";
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", GenSetUp."Loan Trasfer Fee A/C-RTGS", LoanApps."Loan Disbursement Date", RTGSAmount * -1, 'BOSA', LoanApps."Cheque No.",
                            'RTGS Charge' + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                            RunningBalance := RunningBalance - RTGSAmount;
                        end;
                        if LoanApps."Mode Of Disbursement" = LoanApps."Mode Of Disbursement"::Mpesa then begin
                            if LoanApps."Approved Amount" <= 10000 then begin
                                MpesaChargeAmount := GenSetUp."M-Pesa Charge(0-10K)";


                            end else begin
                                MpesaChargeAmount := GenSetUp."M-Pesa Charge(>10K)";
                            end;


                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", GenSetUp."Mpesa A/c", LoanApps."Loan Disbursement Date", MpesaChargeAmount * -1, 'BOSA', LoanApps."Cheque No.",
                            'Mpesa Charge' + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                            RunningBalance := RunningBalance - MpesaChargeAmount;
                        end;
                        //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------     

                        LoanTopUp.RESET;
                        LoanTopUp.SETRANGE(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                        LoanTopUp.SetRange("Client Code", LoanApps."Client Code");
                        IF LoanTopUp.FindSet() THEN BEGIN
                            REPEAT

                                //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                                //------------------------------------Principal---------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", ROUND(LoanTopUp."Principle Top Up", 0.01, '>') * -1, 'BOSA', LoanTopUp."Loan Top Up",
                                'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");
                                //------------------------------------Outstanding Interest----------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", ROUND(LoanTopUp."Interest Top Up", 0.01, '>') * -1, 'BOSA', LoanTopUp."Loan Top Up",
                                'Interest Paid- ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");

                                //------------------------------------Outstanding Penalty----------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Penalty Paid",
                                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", ROUND(LoanTopUp."Penalty Charged", 0.01, '>') * -1, 'BOSA', LoanTopUp."Loan Top Up",
                                'Penalty Paid- ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");
                                //-------------------------------------Levy--------------------------
                                LineNo := LineNo + 10000;
                                IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::"G/L Account", LoanType."Top Up Commision Account", LoanApps."Loan Disbursement Date", ROUND(LoanTopUp.Commision, 0.01, '>') * -1, 'BOSA', LoanTopUp."Loan Top Up",
                                    'Interest on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."Application Source"::" ");

                                END;

                                IF ObjLoans.GET(LoanTopUp."Loan Top Up") THEN BEGIN
                                    IF ObjLoanType.GET(ObjLoans."Loan Product Type") THEN BEGIN
                                        VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                                    END;
                                END;

                                RunningBalance := RunningBalance - ROUND(LoanTopUp.Commision, 0.01, '>') - ROUND(LoanTopUp."Interest Top Up", 0.01, '>') - ROUND(LoanTopUp."Principle Top Up", 0.01, '>') - ROUND(LoanTopUp."Penalty Charged", 0.01, '>');
                                //------------------------------Credit Excise Duty Account-----------------------------------------------

                                if LoanApps."Loan Disbursed Amount" <> 0 then
                                    RunningBalance := RunningBalance
                                else
                                    RunningBalance := LoanApps."Loan Disbursed Amount";
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", GenSetUp."Excise Duty Account", LoanApps."Loan Disbursement Date", Round((LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)), 1, '>') * -1, 'BOSA', LoanApps."Cheque No.",
                                'Excise Duty_Interest on Bridging', LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                                RunningBalance := RunningBalance - Round((LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)), 1, '>');

                            UNTIL LoanTopUp.NEXT = 0;
                        END;
                        //END;

                        //-----------------------------------------Accrue insurance on Disburesment--------------------------------------------------------------------------------------------

                        IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                            IF LoanType."Accrue Total Insurance&Interes" = TRUE THEN BEGIN


                                PCharges.RESET;
                                PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                                PCharges.SETRANGE(PCharges."Loan Charge Type", PCharges."Loan Charge Type"::"Loan Insurance");
                                IF PCharges.FIND('-') THEN BEGIN
                                    PCharges.TESTFIELD(PCharges."G/L Account");
                                    GenSetUp.TESTFIELD(GenSetUp."Excise Duty Account");
                                    PChargeAmount := PCharges.Amount;
                                    IF PCharges."Use Perc" = TRUE THEN
                                        PChargeAmount := Round((LoanApps."Approved Amount" * PCharges.Percentage / 100), 1, '>');
                                    //----------------------Debit insurance Receivable Account a/c-----------------------------------------------------


                                    //----------------------Credit Insurance Payable Account a/c-----------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Insurance Accounts", LoanApps."Loan Disbursement Date", (PChargeAmount * LoanType."No of Installment") * -1, 'BOSA', LoanApps."Cheque No.",
                                    'Insurance Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                                END;
                            END;
                        END;

                        //accrue Interest

                        IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                            IF LoanType."Charge First Int" = TRUE THEN BEGIN
                                //----------------------Debit Interest Receivable Account a/c-----------------------------------------------------

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
                                GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", Round((LoanApps."Approved Amount" * LoanType."Interest rate" / (1200)), 1, '>'), 'BOSA', LoanApps."Cheque No.",
                                'Interest Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                                //----------------------Credit Interest Payable Account a/c-----------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Interest Account", LoanApps."Loan Disbursement Date", Round((LoanApps."approved Amount" * LoanType."Interest rate" / (1200)), 1, '>') * -1, 'BOSA', LoanApps."Cheque No.",
                                'Interest Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                            END;
                        END;

                        if LoanApps.CRBQuerryCharge > 0 then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", '801052', LoanApps."Loan Disbursement Date", LoanApps.CRBQuerryCharge * -1, 'BOSA', LoanApps."Cheque No.",
                           'CRB Charge ' + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                            RunningBalance := RunningBalance - LoanApps.CRBQuerryCharge;

                        end;

                        //-----------------------------------------5. BOOST DEPOSITS COMMISSION / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
                        IF LoanApps."Deposit Boosting" > 0 THEN BEGIN


                            GenSetUp.GET();
                            //------------------------------Credit Income G/L-----------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                            GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Deposit Boosting" * -1, 'BOSA', LoanApps."Cheque No.",
                            'Deposits Booster', LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");


                            GenSetUp.GET();
                            //------------------------------Credit Excise Duty Account-----------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account", GenSetUp."Deposit Boosting A/C", LoanApps."Loan Disbursement Date", LoanApps."Deposit Boosting Commision" * -1, 'BOSA', LoanApps."Cheque No.",
                            'Deposit Boosting Commision', LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");

                            GenSetUp.GET();
                            RunningBalance := RunningBalance - LoanApps."Deposit Boosting" - LoanApps."Deposit Boosting Commision";
                        END;


                        //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Disbursment Account",
                        GenJournalLine."Account Type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", (RunningBalance) * -1, 'BOSA', LoanApps."Cheque No.",
                        'Loan Disbursement - ' + LoanApps."Loan Product Type" + ' - ' + LoanApps."Client Name", LoanApps."Loan  No.", GenJournalLine."Application Source"::" ");
                        //----------------------------------(Credit Member Bank Account)------------------------------------------------




                        // IF ObjLoans.GET(VarLoanNo) THEN BEGIN
                        //     ObjLoans."Net Payment to FOSA" := ObjLoans."Approved Amount";
                        //     ObjLoans."Processed Payment" := TRUE;
                        //     ObjLoans.MODIFY;
                        // END;
                    END;
                end;


            end;
        end;
    end;

    procedure ClearJournalBatch()
    var
        GenBatches: Record "Gen. Journal Batch";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
        if GenJournalLine.Find('-') then begin
            GenJournalLine.DeleteAll
        end;


        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'PAYMENTS');
        GenBatches.SetRange(GenBatches.Name, 'LOANS');
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'PAYMENTS';
            GenBatches.Name := 'LOANS';
            GenBatches.Description := 'LOANS';
            GenBatches.Insert;
        end;
    end;

}




