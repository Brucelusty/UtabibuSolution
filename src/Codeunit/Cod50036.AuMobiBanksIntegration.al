codeunit 50036 "AuMobi Banks Integration"
{
    var
        CoopModel: Record "Coop Bank IPN Notifications";
        ObjCoopB2B: Record "Coop Bank B2B Deposits";
        ObjCustomers: Record Customer;
        // ABSABankModel: Record "Absa Bank Transactions";
        ObjCustomer: Record Customer;
        iEntryNo: Integer;

    trigger OnRun()
    begin
    end;

    procedure InsertCoopIPNTransaction(AcctNo: Text; Amount: Decimal; BookedBalance: Decimal; ClearedBalance: Decimal; Currency: Text; CustMemoLine1: Text; CustMemoLine2: Text; CustMemoLine3: Text; EventType: Text;
    ExchangeRate: Text; Narration: Text; PaymentRef: Text; PostingDate: DateTime; TransactionId: Text; TransactionDate: DateTime) Res: Text
    begin
        iEntryNo := 0;
        CoopModel.Reset;
        if CoopModel.Find('+') then begin
            iEntryNo := CoopModel.Entry;
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        CoopModel.Reset();
        CoopModel.SetRange(CoopModel.PaymentRef, PaymentRef);
        if CoopModel.Find('-') = false then begin
            CoopModel.Init();
            CoopModel.Entry := iEntryNo;
            CoopModel.AcctNo := AcctNo;
            CoopModel.Amount := Amount;
            CoopModel.BookedBalance := BookedBalance;
            CoopModel.ClearedBalance := ClearedBalance;
            CoopModel.Currency := Currency;
            CoopModel.CustMemoLine1 := CustMemoLine1;
            CoopModel.CustMemoLine2 := CustMemoLine2;
            CoopModel.CustMemoLine3 := CustMemoLine3;
            CoopModel.EventType := EventType;
            CoopModel.ExchangeRate := ExchangeRate;
            CoopModel.Narration := Narration;
            CoopModel.PaymentRef := PaymentRef;
            CoopModel.PostingDate := PostingDate;
            CoopModel.TransactionDate := TransactionDate;
            CoopModel.TransactionId := TransactionId;
            CoopModel.Insert();
        end;
        Res := '{"MessageCode":"200",';
        Res += '"Message":"Successfully received data"}';

    end;

    procedure InsertCoopNotificationDeposits(ConnectionID: Text; ConnectionPassword: Text; TransactionReferenceCode: Text; TransactionDate: DateTime; InstitutionCode: Text;
    messageID: Text; serviceName: Text; PaymentAmount: Decimal; InstitutionName: Text; DocumentReferenceNumber: Text; AccountNumber: Text; AdditionalInfo: Text;
    BankCode: Text; BranchCode: Text; Currency: Text; TotalAmount: Decimal; PaymentReferenceCode: Text; PaymentCode: Text; PaymentMode: Text; AccountName: Text) Res: Text
    begin
        iEntryNo := 0;
        ObjCoopB2B.Reset;
        if ObjCoopB2B.Find('+') then begin
            iEntryNo := ObjCoopB2B.Entry;
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        ObjCoopB2B.Reset();
        ObjCoopB2B.SetRange(ObjCoopB2B.TransactionReferenceCode, TransactionReferenceCode);
        if ObjCoopB2B.Find('-') = false then begin
            ObjCoopB2B.Init();
            ObjCoopB2B.Entry := iEntryNo;
            ObjCoopB2B.InstitutionCode := InstitutionCode;
            ObjCoopB2B.TransactionReferenceCode := TransactionReferenceCode;
            ObjCoopB2B.TransactionDate := TransactionDate;
            ObjCoopB2B.PaymentAmount := PaymentAmount;
            ObjCoopB2B.InstitutionName := InstitutionName;
            ObjCoopB2B.DocumentReferenceNumber := DocumentReferenceNumber;
            ObjCoopB2B.AccountNumber := AccountNumber;
            ObjCoopB2B.AdditionalInfo := AdditionalInfo;
            ObjCoopB2B.BankCode := BankCode;
            ObjCoopB2B.BranchCode := BranchCode;
            ObjCoopB2B.Currency := Currency;
            ObjCoopB2B.TotalAmount := TotalAmount;
            ObjCoopB2B.PaymentReferenceCode := PaymentReferenceCode;
            ObjCoopB2B.PaymentCode := PaymentCode;
            ObjCoopB2B.PaymentMode := PaymentMode;
            ObjCoopB2B.AccountName := AccountName;
            ObjCoopB2B.Insert();
            Commit();
            FnPostPaybillTransaction(TransactionReferenceCode);
        end;

        ObjCustomers.Reset();
        ObjCustomers.SetRange("No.", TransactionReferenceCode);
        if ObjCustomers.FindFirst() then begin
            Res := '{"header": {';
            Res += '"messageID": "' + messageID + '",';
            Res += '"statusCode": "200",';
            Res += '"statusDescription": "Payment successfully received"';
            Res += '},';
            Res += '"response": {';
            Res += '"TransactionReferenceCode": "' + TransactionReferenceCode + '",';
            Res += '"TransactionDate": "' + FORMAT(CurrentDateTime, 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>.<Minutes,2>') + '", ';
            Res += '"TransactionAmount":' + DelChr(Format(TotalAmount), '=', ',') + ',';
            Res += '"Currency": "", ';
            Res += '"AdditionalInfo": "' + ObjCustomers.Name + '", ';
            Res += '"AccountNumber": "' + ObjCustomers."No." + '", ';
            Res += '"AccountName": "' + ObjCustomers.Name + '",';
            Res += '"InstitutionCode": "' + InstitutionCode + '",';
            Res += '"InstitutionName": "utabibu Sacco "';
            Res += '}}';

        end else begin
            Res := '{"header": {';
            Res += '"messageID": "' + messageID + '",';
            Res += '"statusCode": "200",';
            Res += '"statusDescription": "Payment successfully received"';
            Res += '},';
            Res += '"response": {';
            Res += '"TransactionReferenceCode": "' + TransactionReferenceCode + '",';
            Res += '"TransactionDate": "' + FORMAT(CurrentDateTime, 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>.<Minutes,2>') + '", ';
            Res += '"TransactionAmount":' + DelChr(Format(TotalAmount), '=', ',') + ',';
            Res += '"Currency": "", ';
            Res += '"AdditionalInfo": "' + ObjCustomers.Name + '", ';
            Res += '"AccountNumber": "' + ObjCustomers."No." + '", ';
            Res += '"AccountName": "' + ObjCustomers.Name + '",';
            Res += '"InstitutionCode": "' + InstitutionCode + '",';
            Res += '"InstitutionName": "UTABIBU SACCO "';
            Res += '}}';
        end;
    end;

    procedure InsertCoopValidationDeposits(ConnectionID: Text; ConnectionPassword: Text; TransactionReferenceCode: Text; TransactionDate: DateTime; InstitutionCode: Text;
    messageID: Text; serviceName: Text) Res: Text
    begin
        ObjCustomers.Reset();
        ObjCustomers.SetRange("No.", validateACCOUNT(TransactionReferenceCode));
        if ObjCustomers.FindFirst() then begin
            Res := '{"header": {';
            Res += '"messageID": "' + messageID + '",';
            Res += '"statusCode": "200",';
            Res += '"statusDescription": "Successfully validated member "';
            Res += '},';
            Res += '"response": {';
            Res += '"TransactionReferenceCode": "' + TransactionReferenceCode + '",';
            Res += '"TransactionDate": "' + FORMAT(CurrentDateTime, 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>.<Minutes,2>') + '", ';
            Res += '"TotalAmount": 0.0,';
            Res += '"Currency": "", ';
            Res += '"AdditionalInfo": "' + ObjCustomers.Name + '", ';
            Res += '"AccountNumber": "' + ObjCustomers."No." + '", ';
            Res += '"AccountName": "' + ObjCustomers.Name + '",';
            Res += '"InstitutionCode": "' + InstitutionCode + '",';
            Res += '"InstitutionName": "utabibu Sacco "';
            Res += '}}';

        end else begin
            Res := '{"header": {';
            Res += '"messageID": "' + messageID + '",';
            Res += '"statusCode": "201",';
            Res += '"statusDescription": "Member no not found "';
            Res += '},';
            Res += '"response": {';
            Res += '"TransactionReferenceCode": "' + TransactionReferenceCode + '",';
            Res += '"TransactionDate": "' + FORMAT(CurrentDateTime, 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>.<Minutes,2>') + '", ';
            Res += '"TotalAmount": 0.0,';
            Res += '"Currency": "", ';
            Res += '"AdditionalInfo": "' + ObjCustomers.Name + '", ';
            Res += '"AccountNumber": "' + ObjCustomers."No." + '", ';
            Res += '"AccountName": "' + ObjCustomers.Name + '",';
            Res += '"InstitutionCode": "' + InstitutionCode + '",';
            Res += '"InstitutionName": "utabibu Sacco"';
            Res += '}}';
        end;
    end;

    procedure validateACCOUNT(accont: Code[250]) Res: Text
    var
        varID: Text;
        Vardoc: Text;
    begin
        varID := CopyStr(accont, 4, 100);
        ObjCustomers.Reset();
        ObjCustomers.SetRange("No.", accont);
        if ObjCustomers.FindFirst() then begin
            Res := ObjCustomers."No.";
            exit;
        end;

        ObjCustomers.Reset();
        ObjCustomers.SetRange(ObjCustomers."ID No.", accont);
        if ObjCustomers.FindFirst() then begin
            Res := ObjCustomers."No.";
            exit;
        end;

        ObjCustomers.Reset();
        ObjCustomers.SetRange(ObjCustomers."ID No.", varID);
        if ObjCustomers.FindFirst() then begin
            Res := ObjCustomers."No.";
            exit;
        end;

    end;


    Procedure FnPostPaybillTransaction(DocumentNo: code[200])
    var
        PaybillTransactions: Record "Coop Bank B2B Deposits";
        Customer: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";
        SFactory: Codeunit "AU FactoryMobile";
        RunBal: Decimal;
        LoansR: Record "Loans Register";
        PenaltyDue: Decimal;
        IntAmount: Decimal;
        TotalPaid: Decimal;
        TotalPaidSchedule: Decimal;
        Schedule: Record "Loan Repayment Schedule";
        LoanArrears: Decimal;
        LineNo: Integer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenBatches: Record "Gen. Journal Batch";
        LoanProductType: Record "Loan Products Setup";
        ExpectedDateofCompletion: Date;
        CommaRemoved: Text;
        MepaM: Text[250];
        OutstandingLoan: Decimal;
        DetailedLed: Record "Detailed Cust. Ledg. Entry";
        LoanType: Record "Loan Products Setup";
        LoanDeduction: Decimal;
        SaccoSetup: Record "Sacco General Set-Up";
        Commision: Decimal;
        AvailableShes: Decimal;
        SmsCodeunit: Codeunit "Sms Management";
        FirstStr: text[250];
        Sms: Text[2048];
        SecondStr: text[250];

        ParentStr: text[250];
        Vend: Record Vendor;
        Cust: Record Customer;
        LoanRepayment: Record "Loan Repayment Schedule";
        LoanAreas: Decimal;
        ScheduleLoanbalance: Decimal;
        LoanBalance: Decimal;
        BAL: Decimal;
        AmountToDeduct: Decimal;
        PrincipleLoan: Decimal;
        AmountToDeductLoan: Decimal;
        SaccoGenSetup: Record "Sacco General Set-Up";
        MinimumSharecapital: Decimal;
        SharecapitalBalance: Decimal;
        ShareCapitalDeduction: Decimal;
        SharecapitalAvailable: Decimal;
        GenSetup: Record "Sacco General Set-Up";
        ExpectedRegistration: Decimal;
        Firstpart: Text;
        MobileExt: Label '254';
        MobilePhoneNo: Code[200];
        MobileRest: Text[250];
        MobilePhoneNo2: Text[200];
        myInt: Integer;
        OutstadningBal: Decimal;
        LoanProductCode: Code[60];
        Message: Text;
        Difference: Decimal;
        sharecapitalFee: Decimal;
    begin

        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'COOPDEPO';
        GenBatches.Reset();
        GenBatches.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenBatches.SetRange(Name, BATCH_NAME);
        if GenBatches.FindFirst() = false then begin
            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
            GenBatches.Name := BATCH_NAME;
            GenBatches.Description := BATCH_NAME;
            GenBatches.Insert(true);
        end;


        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.FindSet() then begin
            GenJournalLine.DELETEALL;
        end;

        //check posted transaction not marked posted
        PaybillTransactions.SetRange(PaybillTransactions.Status, PaybillTransactions.Status::Failed);
        PaybillTransactions.SetRange(TransactionReferenceCode, DocumentNo);
        if PaybillTransactions.FindFirst() then begin
            repeat
                DetailedLed.Reset();
                DetailedLed.SetRange("Document No.", PaybillTransactions.TransactionReferenceCode);
                if DetailedLed.FindFirst() then begin
                    PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                    PaybillTransactions.Modify(true);
                end;
            until PaybillTransactions.Next() = 0;
        end;
        //end checking
        PaybillTransactions.SetRange(PaybillTransactions.Status, PaybillTransactions.Status::Failed);
        PaybillTransactions.SetRange(TransactionReferenceCode, DocumentNo);
        if PaybillTransactions.FindFirst() then begin
            repeat
                BATCH_TEMPLATE := 'GENERAL';
                BATCH_NAME := 'COOPDEPO';
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.FindSet() then begin
                    GenJournalLine.DELETEALL;
                end;
                DOCUMENT_NO := PaybillTransactions.TransactionReferenceCode;

                FirstStr := '';
                SecondStr := '';
                OutstadningBal := 0;
                OutstandingLoan := 0;
                CommaRemoved := '';
                LoanProductCode := '';
                ExpectedDateofCompletion := 0D;
                ParentStr := Format(PaybillTransactions.AccountNumber);
                FirstStr := CopyStr(ParentStr, 1, 3);
                SecondStr := CopyStr(ParentStr, 4, 100);

                PaybillTransactions.TransType := FirstStr;
                PaybillTransactions.IDNo := SecondStr;
                PaybillTransactions.Modify();


                DetailedLed.Reset();
                DetailedLed.SetRange("Document No.", PaybillTransactions.TransactionReferenceCode);
                if DetailedLed.FindFirst() then begin
                    PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                    PaybillTransactions.Modify(true);
                    /// Error('error document already posted %1', PaybillTransactions.TransactionReferenceCode);
                end;
                //post Loan
                LoansR.reset;
                LoansR.SetRange("Loan  No.", ParentStr);
                LoansR.SetAutoCalcFields(LoansR."Outstanding Balance", "Outstanding Interest");
                LoansR.SetFilter(LoansR."Outstanding Balance", '>%1', 0);
                if LoansR.FindFirst() then begin
                    if LoansR."Loan Product Type" = 'M-Utabibu' then begin
                        ExpectedDateofCompletion := LoansR."Expected Date of Completion";
                        MepaM := ' due on ' + Format(ExpectedDateofCompletion);
                    end;
                    if LoanType.Get(LoansR."Loan Product Type") then begin
                        LoanProductCode := LoanType."Product Description";
                    end;
                    RunBal := PaybillTransactions.TotalAmount;
                    OutstandingLoan := LoansR."Outstanding Balance" + LoansR."Outstanding Interest";

                    LoansR.CalcFields(LoansR."Outstanding Interest", LoansR."Current Penalty Due");
                    //penalty 
                    PenaltyDue := 0;

                    if LoansR."Current Penalty Due" > 0 then begin
                        PenaltyDue := 0;
                        if RunBal > LoansR."Current Penalty Due" then
                            PenaltyDue := LoansR."Current Penalty Due"
                        else
                            PenaltyDue := RunBal;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Penalty Paid",
                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", DT2Date(PaybillTransactions.TransactionDate), PenaltyDue * -1, 'BOSA', DOCUMENT_NO,
                       DOCUMENT_NO + ' Coop ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Penalty Paid"), loansR."Loan  No.");
                        RunBal := RunBal - PenaltyDue;
                    end;

                    //end penalty
                    if LoansR."Outstanding Interest" > 0 then begin
                        IntAmount := 0;
                        if RunBal > LoansR."Outstanding Interest" then
                            IntAmount := LoansR."Outstanding Interest"
                        else
                            IntAmount := RunBal;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", DT2Date(PaybillTransactions.TransactionDate), IntAmount * -1, 'BOSA', DOCUMENT_NO,
                       DOCUMENT_NO + ' Coop ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"), loansR."Loan  No.");
                        RunBal := RunBal - IntAmount;
                        OutstadningBal := OutstandingLoan - IntAmount;
                        CommaRemoved := FORMAT(OutstadningBal, 0, 1);
                    end;
                    if RunBal > 0 then begin
                        if RunBal > LoansR."Outstanding Balance" then
                            LoanDeduction := LoansR."Outstanding Balance"
                        else
                            LoanDeduction := RunBal;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", DT2Date(PaybillTransactions.TransactionDate), LoanDeduction * -1, 'BOSA', DOCUMENT_NO,
                        DOCUMENT_NO + ' Coop ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::Repayment), loansR."Loan  No.");

                        OutstadningBal := OutstadningBal - LoanDeduction;

                        if OutstadningBal > 0 then begin

                            CommaRemoved := FORMAT(OutstadningBal, 0, 1)

                        end else begin

                            CommaRemoved := '0'
                        end;


                        RunBal := RunBal - LoanDeduction;


                    end;

                    if RunBal > 0 then begin
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", DT2Date(PaybillTransactions.TransactionDate), RunBal * -1, 'BOSA', DOCUMENT_NO,
                        DOCUMENT_NO + ' COOP ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution"), loansR."Loan  No.");

                    end;

                    //Balancing Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BANK0002', DT2Date(PaybillTransactions.TransactionDate), PaybillTransactions.TotalAmount, 'BOSA', DOCUMENT_NO,
                     'Coop ' + ' ' + PaybillTransactions.TransactionReferenceCode + '-' + LoansR."Client Name", '');


                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;


                    Customer.Reset();
                    Customer.SetRange(Customer."No.", LoansR."Client Code");
                    if Customer.FindFirst() = true then begin

                        Message := 'Dear ' + SplitString(Customer.Name, ' ') + ',' + ' your repayment ' + LoanProductCode + ' of Ksh ' + Format(PaybillTransactions.TotalAmount) + ' has been received at Utabibu Sacco on ' + Format(DT2Date(PaybillTransactions.TransactionDate)) + '.' + '. Your loan balance is ksh ' + CommaRemoved + MepaM + '.';
                        // SMSMessage(PaybillTransactions.BillRefNumber, Customer.Name, Customer."Mobile Phone No", Message);
                    end;
                    PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                    PaybillTransactions.Modify();
                end;
            until PaybillTransactions.Next() = 0;
        end;

        //end Loan Posting


        PaybillTransactions.SetRange(PaybillTransactions.Status, PaybillTransactions.Status::Failed);
        PaybillTransactions.SetRange(TransactionReferenceCode, DocumentNo);
        if PaybillTransactions.FindFirst() then begin
            repeat
                BATCH_TEMPLATE := 'GENERAL';
                BATCH_NAME := 'PAYBILL';

                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.FindSet() then begin
                    GenJournalLine.DELETEALL;
                end;
                DOCUMENT_NO := '';
                FirstStr := '';
                SecondStr := '';
                OutstadningBal := 0;
                OutstandingLoan := 0;
                AvailableShes := 0;
                Difference := 0;
                CommaRemoved := '';
                ParentStr := Format(PaybillTransactions.AccountNumber);
                FirstStr := CopyStr(ParentStr, 1, 3);
                SecondStr := CopyStr(ParentStr, 4, 100);
                DOCUMENT_NO := PaybillTransactions.TransactionReferenceCode;
                PaybillTransactions.TransType := FirstStr;
                PaybillTransactions.IDNo := SecondStr;
                PaybillTransactions.Modify();
                if (FirstStr = 'SHA') or (FirstStr = 'PGD') or (FirstStr = 'DEP') or (FirstStr = 'RSK') then begin
                    Customer.Reset();
                    Customer.SetRange(Customer."ID No.", SecondStr);
                    if Customer.FindFirst() then begin
                        Customer.CalcFields("Shares Retained", "Current Shares", "Programmed Deposits");
                        AvailableShes := Customer."Shares Retained";
                        if FirstStr = 'DEP' then begin
                            //Message('home%1-%2', FirstStr, SecondStr);
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransactionDate), PaybillTransactions.TotalAmount * -1, 'BOSA', DOCUMENT_NO,
                             'Coop Deposit Contribution' + ' ' + PaybillTransactions.TransactionReferenceCode, '');

                        end;
                        //benfund
                        if FirstStr = 'RSK' then begin
                            //Message('home%1-%2', FirstStr, SecondStr);
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Benevolent Fund",
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransactionDate), PaybillTransactions.TotalAmount * -1, 'BOSA', DOCUMENT_NO,
                             'Coop Benovalent Contribution' + ' ' + PaybillTransactions.TransactionReferenceCode, '');

                        end;

                        if FirstStr = 'SHA' then begin
                            // SaccoGenSetup.Get();
                            // if (AvailableShes + PaybillTransactions.TransAmount) > SaccoGenSetup."Retained Shares" then begin
                            //     //Difference := (AvailableShes + PaybillTransactions.TransAmount) - SaccoGenSetup."Retained Shares";
                            //     sharecapitalFee := PaybillTransactions.TransAmount;
                            // end;
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Share Capital",
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransactionDate), (PaybillTransactions.TotalAmount - sharecapitalFee) * -1, 'BOSA', DOCUMENT_NO,
                             'Coop Share Capital Contribution' + ' ' + PaybillTransactions.TransactionReferenceCode, '');

                            //commision
                            // LineNo := LineNo + 10000;
                            // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type":: " ",
                            // GenJournalLine."Account Type"::"G/L Account", '803040', DT2Date(PaybillTransactions.TransTime), sharecapitalFee * -1, 'BOSA', DOCUMENT_NO,
                            //  'Commission On Share Capital Contribution' + ' ' + PaybillTransactions.TransID, '');

                        end;
                        if FirstStr = 'PGD' then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Programmed Deposits",
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransactionDate), PaybillTransactions.TotalAmount * -1, 'BOSA', DOCUMENT_NO,
                             'Coop Programmed Deposit Contribution' + ' ' + PaybillTransactions.TransactionReferenceCode, '');

                        end;



                        //Balancing Account
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"Bank Account", 'BANK0002', DT2Date(PaybillTransactions.TransactionDate), PaybillTransactions.TotalAmount, 'BOSA', DOCUMENT_NO,
                         'Coop Transactions ' + ' ' + PaybillTransactions.TransactionReferenceCode + '-' + Customer.Name, '');



                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'PAYBILL');
                        if GenJournalLine.Find('-') then begin

                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;

                        if FirstStr = 'DEP' then begin

                            MobilePhoneNo := '';

                            MobilePhoneNo2 := Format(Customer."Mobile Phone No");
                            Firstpart := CopyStr(MobilePhoneNo2, 1, 1);
                            MobileRest := CopyStr(MobilePhoneNo2, 2, 200);
                            if Firstpart = '0' then
                                MobilePhoneNo := MobileExt + MobileRest
                            else
                                MobilePhoneNo := Customer."Mobile Phone No";


                            Message := 'Dear ' + SplitString(Customer.Name, ' ') + ',' + ' Deposit of amount of Ksh ' + Format(PaybillTransactions.TotalAmount) + ' has been received at Utabibu Sacco on ' + Format(DT2Date(PaybillTransactions.TransactionDate)) + '.' + ' Your deposit balance is ksh ' + Format(Customer."Current Shares" + PaybillTransactions.TotalAmount);
                            SmsCodeunit.SendSmsResponse(MobilePhoneNo, Message);
                            // SMSMessage(PaybillTransactions.BillRefNumber, Customer.Name, Customer."Mobile Phone No", Message);

                        end;
                        if FirstStr = 'SHA' then begin
                            MobilePhoneNo := '';

                            MobilePhoneNo2 := Format(Customer."Mobile Phone No");
                            Firstpart := CopyStr(MobilePhoneNo2, 1, 1);
                            MobileRest := CopyStr(MobilePhoneNo2, 2, 200);
                            if Firstpart = '0' then
                                MobilePhoneNo := MobileExt + MobileRest
                            else
                                MobilePhoneNo := Customer."Mobile Phone No";

                            Message := 'Dear ' + SplitString(Customer.Name, ' ') + ',' + ' Share Capital amount of Ksh ' + Format(PaybillTransactions.TotalAmount) + ' has been received at Utabibu Sacco on ' + Format(DT2Date(PaybillTransactions.TransactionDate)) + '.' + ' Your share capital balance is ksh ' + Format(Customer."Shares Retained" + PaybillTransactions.TotalAmount);
                            SmsCodeunit.SendSmsResponse(MobilePhoneNo, Message);

                        end;
                        if FirstStr = 'PGD' then begin
                            MobilePhoneNo := '';

                            MobilePhoneNo2 := Format(Customer."Mobile Phone No");
                            Firstpart := CopyStr(MobilePhoneNo2, 1, 1);
                            MobileRest := CopyStr(MobilePhoneNo2, 2, 200);
                            if Firstpart = '0' then
                                MobilePhoneNo := MobileExt + MobileRest
                            else
                                MobilePhoneNo := Customer."Mobile Phone No";

                            Message := 'Dear ' + SplitString(Customer.Name, ' ') + ',' + ' Programmed deposits  of amount Ksh ' + Format(PaybillTransactions.TotalAmount) + ' has been received at Utabibu Sacco on ' + Format(DT2Date(PaybillTransactions.TransactionDate)) + '.' + ' Your Programmed Deposit balance is ksh ' + Format(Customer."Programmed Deposits" + PaybillTransactions.TotalAmount);
                            SmsCodeunit.SendSmsResponse(MobilePhoneNo, Message);

                        end;

                        PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                        PaybillTransactions.Modify();

                    end;

                end;


            until PaybillTransactions.Next() = 0;
        end;

    end;

    procedure SplitString(sText: Text; separator: Text) Token: Text
    var
        Pos: Integer;
        Tokenq: Text;
    begin
        Pos := StrPos(sText, separator);
        if Pos > 0 then begin
            Token := CopyStr(sText, 1, Pos - 1);
            if Pos + 1 <= StrLen(sText) then
                sText := CopyStr(sText, Pos + 1)
            else
                sText := '';
        end else begin
            Token := sText;
            sText := '';
        end;
    end;


}
