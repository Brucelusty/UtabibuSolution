codeunit 131015 "AU Paybill Automations"
{
    trigger OnRun()
    begin
        //FunctionChoice();
    end;

    var
        myInt: Integer;
        OutstadningBal: Decimal;
        LoanProductCode: Code[60];
        Message: Text;
        Difference: Decimal;
        sharecapitalFee: Decimal;

    Procedure FnInsertPaybillTransactions(TransID: Code[40]; TransactionType: Code[40]; TransAmount: Decimal; BusinessShortCode: code[40]; BillRefNumber: Code[40]; InvoiceNumber: code[40]; OrgAccountBalance: Decimal; ThirdPartyTransID: Code[40]; MSIDN: Code[40]; FirstName: Text[150]; MiddleName: Text[150]; LastName: Text[150]; Status: Option "Failed","Posted"; Keyword: code[40])
    var
        PaybillTransactions: Record "Paybill Transactions";
    begin

        PaybillTransactions.Init();
        PaybillTransactions.TransID := TransID;
        PaybillTransactions.TransactionType := TransactionType;
        PaybillTransactions.TransTime := CurrentDateTime;
        PaybillTransactions.TransAmount := TransAmount;
        PaybillTransactions.BusinessShortCode := BusinessShortCode;
        PaybillTransactions.BillRefNumber := BillRefNumber;
        PaybillTransactions.InvoiceNumber := InvoiceNumber;
        PaybillTransactions.OrgAccountBalance := OrgAccountBalance;
        PaybillTransactions.ThirdPartyTransID := ThirdPartyTransID;
        PaybillTransactions.MSIDN := MSIDN;
        PaybillTransactions.FirstName := FirstName;
        PaybillTransactions.MiddleName := MiddleName;
        PaybillTransactions.LastName := LastName;
        PaybillTransactions.Status := PaybillTransactions.Status::Failed;
        PaybillTransactions.Keyword := Keyword;
        PaybillTransactions.Insert;
        Commit();
        // FunctionChoice(TransID)

    end;

    procedure FunctionChoice(DocumentNo: code[200])
    var
        PaybillTransactions: Record "Paybill Transactions";
        DetailedLed: Record "Detailed Cust. Ledg. Entry";
    begin

        PaybillTransactions.SetRange(PaybillTransactions.Status, PaybillTransactions.Status::Failed);
        PaybillTransactions.SetRange(PaybillTransactions.TransID, DocumentNo);
        if PaybillTransactions.FindFirst() then begin
            repeat
                DetailedLed.Reset();
                DetailedLed.SetRange("Document No.", PaybillTransactions.TransID);
                if DetailedLed.FindFirst() then begin
                    PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                    PaybillTransactions.Modify(true);
                end;
            until PaybillTransactions.Next() = 0;
        end;
        PaybillTransactions.Reset();
        PaybillTransactions.SetRange(PaybillTransactions.Status, PaybillTransactions.Status::Failed);
        PaybillTransactions.SetRange(PaybillTransactions.TransID, DocumentNo);
        if PaybillTransactions.FindFirst() then begin
            repeat
                FnPostPaybillTransaction(PaybillTransactions.TransID);
            // Cust.Reset();
            // Cust.SetRange("ID No.", PaybillTransactions.BillRefNumber);
            // if Cust.FindFirst() then begin

            //     ///FnPostPaybillTransactionT(PaybillTransactions.TransID);
            // end
            // else begin
            //     FnPostPaybillTransaction(PaybillTransactions.TransID);
            // end;

            until PaybillTransactions.Next() = 0;
        end;
    end;

    procedure FnpostPaybilltransactions()
    var
        PaybillTransactions: Record "Paybill Transactions";
    begin


        PaybillTransactions.Reset();
        PaybillTransactions.SetRange(Attempted, false);
        PaybillTransactions.SetRange(Status, PaybillTransactions.Status::Failed);
        if PaybillTransactions.FindSet() then begin
            repeat
                PaybillTransactions.Attempted := true;
                PaybillTransactions.Modify(true);
                commit;
                FunctionChoice(PaybillTransactions.TransID);
            until PaybillTransactions.Next() = 0;
        end;
    end;

    Procedure FnPostPaybillTransaction(DocumentNo: code[200])
    var
        PaybillTransactions: Record "Paybill Transactions";
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
        Mobiletrancode: Codeunit "Mobile Banking Code";
    begin

        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'PAYBILL';
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
        PaybillTransactions.SetRange(TransID, DocumentNo);
        if PaybillTransactions.FindFirst() then begin
            repeat
                DetailedLed.Reset();
                DetailedLed.SetRange("Document No.", PaybillTransactions.TransID);
                if DetailedLed.FindFirst() then begin
                    PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                    PaybillTransactions.Modify(true);
                end;
            until PaybillTransactions.Next() = 0;
        end;
        //end checking
        PaybillTransactions.SetRange(PaybillTransactions.Status, PaybillTransactions.Status::Failed);
        PaybillTransactions.SetRange(TransID, DocumentNo);
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
                DOCUMENT_NO := PaybillTransactions.TransID;

                FirstStr := '';
                SecondStr := '';
                OutstadningBal := 0;
                OutstandingLoan := 0;
                CommaRemoved := '';
                LoanProductCode := '';
                ExpectedDateofCompletion := 0D;
                ParentStr := Format(PaybillTransactions.BillRefNumber);
                FirstStr := CopyStr(ParentStr, 1, 3);
                SecondStr := CopyStr(ParentStr, 4, 100);

                PaybillTransactions.TransType := FirstStr;
                PaybillTransactions.IDNo := SecondStr;
                PaybillTransactions.Modify();


                DetailedLed.Reset();
                DetailedLed.SetRange("Document No.", PaybillTransactions.TransID);
                if DetailedLed.FindFirst() then begin
                    PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                    PaybillTransactions.Modify(true);
                    Error('error document already posted %1', PaybillTransactions.TransID);
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
                    RunBal := PaybillTransactions.TransAmount;
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
                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", DT2Date(PaybillTransactions.TransTime), PenaltyDue * -1, 'BOSA', DOCUMENT_NO,
                       DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Penalty Paid"), loansR."Loan  No.");
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
                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", DT2Date(PaybillTransactions.TransTime), IntAmount * -1, 'BOSA', DOCUMENT_NO,
                       DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"), loansR."Loan  No.");
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
                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", DT2Date(PaybillTransactions.TransTime), LoanDeduction * -1, 'BOSA', DOCUMENT_NO,
                        DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::Repayment), loansR."Loan  No.");

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
                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", DT2Date(PaybillTransactions.TransTime), RunBal * -1, 'BOSA', DOCUMENT_NO,
                        DOCUMENT_NO + ' Paybill ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution"), loansR."Loan  No.");

                    end;

                    //Balancing Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BANK0008', DT2Date(PaybillTransactions.TransTime), PaybillTransactions.TransAmount, 'BOSA', DOCUMENT_NO,
                     'Paybill Transactions -Mobile App ' + ' ' + PaybillTransactions.TransID + '-' + LoansR."Client Name", '');


                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'PAYBILL');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;


                    Customer.Reset();
                    Customer.SetRange(Customer."No.", LoansR."Client Code");
                    if Customer.FindFirst() = true then begin

                        Message := 'Dear ' + SplitString(Customer.Name, ' ') + ',' + ' your repayment ' + LoanProductCode + ' of Ksh ' + Format(PaybillTransactions.TransAmount) + ' has been received at Utabibu Sacco on ' + Format(DT2Date(PaybillTransactions.TransTime)) + '.' + '. Your loan balance is ksh ' + CommaRemoved + MepaM + '.';
                        Mobiletrancode.SMSMessage(PaybillTransactions.BillRefNumber, Customer.Name, Customer."Mobile Phone No.", Message);
                        SmsCodeunit.SendSmsResponse(Customer."Mobile Phone No.", Message);

                    end;
                    PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                    PaybillTransactions.Modify();
                end;
            until PaybillTransactions.Next() = 0;
        end;

        //end Loan Posting


        PaybillTransactions.SetRange(PaybillTransactions.Status, PaybillTransactions.Status::Failed);
        PaybillTransactions.SetRange(TransID, DocumentNo);
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
                ParentStr := Format(PaybillTransactions.BillRefNumber);
                FirstStr := CopyStr(ParentStr, 1, 3);
                SecondStr := CopyStr(ParentStr, 4, 100);
                DOCUMENT_NO := PaybillTransactions.TransID;
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
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransTime), PaybillTransactions.TransAmount * -1, 'BOSA', DOCUMENT_NO,
                             'Paybill Deposit Contribution' + ' ' + PaybillTransactions.TransID, '');

                        end;
                        //benfund
                        if FirstStr = 'RSK' then begin
                            //Message('home%1-%2', FirstStr, SecondStr);
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Benevolent Fund",
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransTime), PaybillTransactions.TransAmount * -1, 'BOSA', DOCUMENT_NO,
                             'Paybill Benovalent Contribution' + ' ' + PaybillTransactions.TransID, '');

                        end;

                        if FirstStr = 'SHA' then begin
                            // SaccoGenSetup.Get();
                            // if (AvailableShes + PaybillTransactions.TransAmount) > SaccoGenSetup."Retained Shares" then begin
                            //     //Difference := (AvailableShes + PaybillTransactions.TransAmount) - SaccoGenSetup."Retained Shares";
                            //     sharecapitalFee := PaybillTransactions.TransAmount;
                            // end;
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Share Capital",
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransTime), (PaybillTransactions.TransAmount - sharecapitalFee) * -1, 'BOSA', DOCUMENT_NO,
                             'Paybill Share Capital Contribution' + ' ' + PaybillTransactions.TransID, '');

                            //commision
                            // LineNo := LineNo + 10000;
                            // SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type":: " ",
                            // GenJournalLine."Account Type"::"G/L Account", '803040', DT2Date(PaybillTransactions.TransTime), sharecapitalFee * -1, 'BOSA', DOCUMENT_NO,
                            //  'Commission On Share Capital Contribution' + ' ' + PaybillTransactions.TransID, '');

                        end;
                        if FirstStr = 'PGD' then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Programmed Deposits",
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransTime), PaybillTransactions.TransAmount * -1, 'BOSA', DOCUMENT_NO,
                             'Paybill Programmed Deposit Contribution' + ' ' + PaybillTransactions.TransID, '');

                        end;



                        //Balancing Account
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::"Bank Account", 'BANK0008', DT2Date(PaybillTransactions.TransTime), PaybillTransactions.TransAmount, 'BOSA', DOCUMENT_NO,
                         'Paybill Transactions ' + ' ' + PaybillTransactions.TransID + '-' + Customer.Name, '');



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


                            Message := 'Dear ' + SplitString(Customer.Name, ' ') + ',' + ' Deposit of amount of Ksh ' + Format(PaybillTransactions.TransAmount) + ' has been received at Utabibu Sacco on ' + Format(DT2Date(PaybillTransactions.TransTime)) + '.' + ' Your deposit balance is ksh ' + Format(Customer."Current Shares" + PaybillTransactions.TransAmount);
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

                            Message := 'Dear ' + SplitString(Customer.Name, ' ') + ',' + ' Share Capital amount of Ksh ' + Format(PaybillTransactions.TransAmount) + ' has been received at Utabibu Sacco on ' + Format(DT2Date(PaybillTransactions.TransTime)) + '.' + ' Your share capital balance is ksh ' + Format(Customer."Shares Retained" + PaybillTransactions.TransAmount);
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

                            Message := 'Dear ' + SplitString(Customer.Name, ' ') + ',' + ' Programmed deposits  of amount Ksh ' + Format(PaybillTransactions.TransAmount) + ' has been received at Utabibu Sacco on ' + Format(DT2Date(PaybillTransactions.TransTime)) + '.' + ' Your Programmed Deposit balance is ksh ' + Format(Customer."Programmed Deposits" + PaybillTransactions.TransAmount);
                            SmsCodeunit.SendSmsResponse(MobilePhoneNo, Message);

                        end;

                        PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                        PaybillTransactions.Modify();

                    end;

                end;


            until PaybillTransactions.Next() = 0;
        end;

    end;

    Procedure FnPostPaybillTransactionT(DocumentNo: code[200])
    var
        PaybillTransactions: Record "Paybill Transactions";
        Customer: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";
        SFactory: Codeunit "AU FactoryMobile";
        RunBal: Decimal;
        LoansR: Record "Loans Register";
        IntAmount: Decimal;
        PenaltyDue: Decimal;
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
    begin

        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'PAYBILL';
        ScheduleLoanbalance := 0;
        LoanBalance := 0;
        PenaltyDue := 0;
        SharecapitalBalance := 0;
        ShareCapitalDeduction := 0;
        AmountToDeduct := 0;
        AmountToDeductLoan := 0;
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

        PaybillTransactions.SetRange(PaybillTransactions.Status, PaybillTransactions.Status::Failed);
        PaybillTransactions.SetRange(PaybillTransactions.TransID, DocumentNo);
        if PaybillTransactions.Find('-') then begin
            repeat
                DOCUMENT_NO := PaybillTransactions.TransID;

                FirstStr := '';
                SecondStr := '';
                ParentStr := Format(PaybillTransactions.BillRefNumber);
                FirstStr := CopyStr(ParentStr, 1, 3);
                SecondStr := CopyStr(ParentStr, 5, 100);

                PaybillTransactions.TransType := FirstStr;
                PaybillTransactions.IDNo := SecondStr;
                PaybillTransactions.Modify();

                Customer.Reset();
                Customer.SetRange(Customer."ID No.", PaybillTransactions.BillRefNumber);
                if Customer.FindFirst() = true then begin
                    GenSetup.Get();
                    Customer.CalcFields("Shares Retained", "Registration Fee Paid");
                    SharecapitalAvailable := Customer."Shares Retained";
                    RunBal := PaybillTransactions.TransAmount;
                    if Customer.MemberCategory = Customer.MemberCategory::Member then begin

                        ExpectedRegistration := GenSetup."BOSA Registration Fee Amount" - Abs(Customer."Registration Fee Paid");
                    end else begin
                        ExpectedRegistration := GenSetup."Staff Registration Fee Amount" - Abs(Customer."Registration Fee Paid");
                    end;
                    if Customer."Account Category" = Customer."Account Category"::Individual then begin
                        ExpectedRegistration := ExpectedRegistration
                    end else begin
                        ExpectedRegistration := GenSetup."Staff Registration Fee Amount" - Abs(Customer."Registration Fee Paid");
                    end;
                    AmountToDeduct := 0;
                    //Message('ok %1', ExpectedRegistration);
                    if ExpectedRegistration > 0 then begin
                        AmountToDeduct := ExpectedRegistration - Abs(Customer."Registration Fee Paid");


                        if RunBal > AmountToDeduct then begin
                            AmountToDeduct := AmountToDeduct
                        end else begin
                            AmountToDeduct := RunBal;
                        end;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Registration Fee",
                        GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransTime), AmountToDeduct * -1, 'BOSA', DOCUMENT_NO,
                         'Paybill Registration Fee' + ' ' + PaybillTransactions.TransID, '');
                        RunBal := RunBal - AmountToDeduct;
                    end;



                    LoansR.reset;
                    LoansR.setrange(LoansR."Client Code", Customer."No.");
                    LoansR.SetAutoCalcFields(LoansR."Outstanding Balance");
                    LoansR.SetFilter(LoansR."Outstanding Balance", '>%1', 0);//here
                    if LoansR.FindFirst() then begin
                        LoanBalance := LoansR."Outstanding Balance";
                        LoanRepayment.Reset();
                        LoanRepayment.SetRange("Loan No.", LoansR."Loan  No.");
                        LoanRepayment.SetFilter("Repayment Date", '..%1', DT2Date(PaybillTransactions.TransTime));
                        if LoanRepayment.FindLast() then begin
                            ScheduleLoanbalance := LoanRepayment."Loan Balance";
                        end;
                        LoanArrears := LoanBalance - ScheduleLoanbalance;
                        if LoanArrears > 0 then begin
                            if RunBal > LoanArrears then
                                AmountToDeduct := Round(LoanArrears, 0.01, '=')
                            else
                                AmountToDeduct := Round(RunBal, 0.01, '=');
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransTime), AmountToDeduct * -1, 'BOSA', DOCUMENT_NO,
                           DOCUMENT_NO + ' Paybill Loan Arrears recovered' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"), loansR."Loan  No.");
                            RunBal := RunBal - AmountToDeduct;
                        end;

                        LoansR.CalcFields(LoansR."Outstanding Interest", "Current Penalty Due");
                        //penalty
                        if LoansR."Current Penalty Due" > 0 then begin
                            PenaltyDue := 0;
                            if RunBal > LoansR."Current Penalty Due" then
                                PenaltyDue := Round(LoansR."Current Penalty Due", 0.01)
                            else
                                PenaltyDue := Round(RunBal, 0.01, '=');
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Penalty Paid",
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransTime), PenaltyDue * -1, 'BOSA', DOCUMENT_NO,
                           DOCUMENT_NO + ' Paybill Interest Payment ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Penalty Paid"), loansR."Loan  No.");
                            RunBal := RunBal - PenaltyDue;
                        end;

                        //end penalty
                        if LoansR."Outstanding Interest" > 0 then begin
                            IntAmount := 0;
                            if RunBal > LoansR."Outstanding Interest" then
                                IntAmount := Round(LoansR."Outstanding Interest", 0.01)
                            else
                                IntAmount := Round(RunBal, 0.01, '=');
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransTime), IntAmount * -1, 'BOSA', DOCUMENT_NO,
                           DOCUMENT_NO + ' Paybill Interest Payment ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"), loansR."Loan  No.");
                            RunBal := RunBal - IntAmount;
                        end;
                        if RunBal > 0 then begin
                            LoanRepayment.Reset();
                            LoanRepayment.SetRange("Loan No.", LoansR."Loan  No.");
                            LoanRepayment.SetFilter("Repayment Date", '..%1', DT2Date(PaybillTransactions.TransTime));
                            if LoanRepayment.FindLast() then begin
                                PrincipleLoan := Round(LoanRepayment."Principal Repayment", 0.01);
                            end;
                            if RunBal > PrincipleLoan then
                                AmountToDeductLoan := Round(PrincipleLoan, 0.01, '=')
                            ELSE
                                AmountToDeductLoan := Round(RunBal, 0.01, '=');
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                            GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransTime), AmountToDeductLoan * -1, 'BOSA', DOCUMENT_NO,
                            DOCUMENT_NO + ' Paybill Loan Repayment ' + loansR."Loan  No." + ' ' + FORMAT(GenJournalLine."Transaction Type"::Repayment), loansR."Loan  No.");
                            RunBal := RunBal - AmountToDeductLoan;
                            // end;
                        end;



                        //end;
                    end;
                    if RunBal > 0 then begin
                        SaccoGenSetup.Get();
                        MinimumSharecapital := SaccoGenSetup."Retained Shares";
                        SharecapitalBalance := MinimumSharecapital - SharecapitalAvailable;
                        if RunBal > Round(SharecapitalBalance, 0.01, '=')
                        then
                            ShareCapitalDeduction := Round(SharecapitalBalance, 0.01, '=')
                        else
                            ShareCapitalDeduction := Round(RunBal, 0.01, '=');
                        if ShareCapitalDeduction < 0 then ShareCapitalDeduction := 0;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Share Capital",
                        GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransTime), ShareCapitalDeduction * -1, 'BOSA', DOCUMENT_NO,
                         'Paybill Share Capital Contribution' + ' ' + PaybillTransactions.TransID, '');
                        RunBal := RunBal - ShareCapitalDeduction;
                    end;

                    if RunBal > 0 then begin
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                        GenJournalLine."Account Type"::Customer, Customer."No.", DT2Date(PaybillTransactions.TransTime), RunBal * -1, 'BOSA', DOCUMENT_NO,
                         'Paybill Deposit Contribution' + ' ' + PaybillTransactions.TransID, '');
                    end;


                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLinePaybill(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                    GenJournalLine."Account Type"::"Bank Account", 'BANK0008', DT2Date(PaybillTransactions.TransTime), PaybillTransactions.TransAmount, 'BOSA', DOCUMENT_NO,
                     'Paybill  Contribution -Paybill' + ' ' + PaybillTransactions.TransID + '-' + Customer.Name, '');


                    // BAL := 0;
                    // GenJournalLine.RESET;
                    // GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                    // GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'PAYBILL');
                    // IF GenJournalLine.FINDSET THEN BEGIN
                    //     REPEAT
                    //         BAL := BAL + GenJournalLine."Amount (LCY)";
                    //     UNTIL GenJournalLine.NEXT = 0;
                    // END;
                    ///Message('ba%1', BAL);


                    // IF (BAL < 0) AND (BAL > -1) THEN BEGIN
                    //     GenJournalLine.RESET;
                    //     GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                    //     GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'PAYBILL');
                    //     GenJournalLine.SETFILTER("Amount (LCY)", '<%1', 0);
                    //     IF GenJournalLine.FINDFIRST THEN BEGIN
                    //         GenJournalLine.VALIDATE("Amount (LCY)", GenJournalLine."Amount (LCY)" + ABS(BAL));
                    //         GenJournalLine.MODIFY(TRUE);
                    //     END;
                    //     GenJournalLine.RESET;
                    //     GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                    //     GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'PAYBILL');
                    //     GenJournalLine.SETFILTER(GenJournalLine.Amount, '<%1', 0);
                    //     IF GenJournalLine.FINDFIRST THEN BEGIN
                    //         GenJournalLine.VALIDATE(Amount, GenJournalLine.Amount + ABS(BAL));
                    //         GenJournalLine.MODIFY(TRUE);
                    //     END;
                    // END;

                    // IF (BAL > 0) AND (BAL < 1) THEN BEGIN
                    //     GenJournalLine.RESET;
                    //     GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                    //     GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'PAYBILL');
                    //     GenJournalLine.SETFILTER("Amount (LCY)", '<%1', 0);
                    //     IF GenJournalLine.FINDFIRST THEN BEGIN
                    //         GenJournalLine.VALIDATE("Amount (LCY)", GenJournalLine."Amount (LCY)" - BAL);
                    //         GenJournalLine.MODIFY(TRUE);
                    //     END;
                    //     GenJournalLine.RESET;
                    //     GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                    //     GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'PAYBILL');
                    //     GenJournalLine.SETFILTER(Amount, '<%1', 0);
                    //     IF GenJournalLine.FINDFIRST THEN BEGIN
                    //         GenJournalLine.VALIDATE(Amount, GenJournalLine.Amount - BAL);
                    //         GenJournalLine.MODIFY(TRUE);
                    //     END;
                    // END;
                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'PAYBILL');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;
                    PaybillTransactions.Status := PaybillTransactions.Status::Posted;
                    PaybillTransactions.Modify();
                    MobilePhoneNo := '';

                    MobilePhoneNo2 := Format(Customer."Mobile Phone No");
                    Firstpart := CopyStr(MobilePhoneNo2, 1, 1);
                    MobileRest := CopyStr(MobilePhoneNo2, 2, 200);
                    if Firstpart = '0' then
                        MobilePhoneNo := MobileExt + MobileRest
                    else
                        MobilePhoneNo := Customer."Mobile Phone No";
                    Sms := 'Dear ' + SplitString(Customer.Name, ' ') + ' amount of KES ' + Format(PaybillTransactions.TransAmount) + ' has been received at Utabibu sacco. ';
                    SmsCodeunit.SendSmsResponse(MobilePhoneNo, Sms);
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

    var

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
        GenJournalLine: Record 232;
        SharecapitalAvailable: Decimal;
        GenSetup: Record "Sacco General Set-Up";
        ExpectedRegistration: Decimal;
        Firstpart: Text;
        MobileExt: Label '254';
        MobilePhoneNo: Code[200];
        MobileRest: Text[250];
        MobilePhoneNo2: Text[200];

}

