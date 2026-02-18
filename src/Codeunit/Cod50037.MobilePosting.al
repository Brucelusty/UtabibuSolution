//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50037 "MobilePosting"
{

    trigger OnRun()
    begin
        //MESSAGE(RegisteredMemberDetails('733942007'));
        //MESSAGE(OutstandingLoansUSSD('254720401314'));
        //MESSAGE(AccountBalanceUSSD('+254723214181','25195455'));
        //MESSAGE(LoanGuarantors('LB13352'));\
        //MESSAGE(SurePESARegistration);
        //MESSAGE(Accounts('733942007',''));
        //MESSAGE(AccountBalance('VS0735', ''));
        //MESSAGE(Guaranteefreeshares('733942007'));
        //MESSAGE(RegisteredMemberDetails('733942007'));
        //MESSAGE(FORMAT(AccountBalanceDec('MN09108',2)));
        //MESSAGE(PaybillSwitch());
        //SMSMessage('555','BSE000756','733942007','iAM GUARLABLE');
        //MESSAGE(OutstandingLoanName('733942007'));
        //MESSAGE(UpdateSurePESARegistration('BES000004'));
        //MESSAGE(LoanGusarantorsUSSD('LB15205','733942007','27897'));
        //MESSAGE(FundsTransferBOSA('BES000615','Share Capital','56466',304));
        //MESSAGE(MiniStatement('733942007', '3942007'));
        //MESSAGE(HolidayAcc('733942007'));
        //MESSAGE(PayBillToAcc('SDWTYRES','lMNSW345','BES000615','733942007',1s00,'MNBBB'));
        //MESSAGE(InsertTransaction('MSQDSDS601','LN0','LN01595','Ngosa','733942007',5000,7000));
        //MESSAGE(GetMpesaDisbursment());
        //fnProcessNotification();
        //MESSAGE(PostNormalLoan('11001201201155','005276',5000,1));
        //FnsentSMS();
        //MESSAGE('%1',LoanBalances('733942007','',''));
        //SendSchedulesms();
        //MESSAGE(PostMPESATrans('OIL7QJWPCD','06747001',4000,TODAY,'4'));
        //FNRegisteredmembers;
    end;

    var
        Vendor: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        accBalance: Decimal;
        minimunCount: Integer;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        amount: Decimal;
        Loans: Integer;
        LoansRegister: Record "Loans Register";
        LoanProductsSetup: Record "Loan Products Setup";
        Members: Record Customer;
        dateExpression: Text[20];
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        dashboardDataFilter: Date;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        MemberLedgerEntry: Record "Member Ledger Entry";
        LoansTable: Record "Loans Register";
        SurePESAApplications: Record "Mobile Applications";
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;
        SmsManagement: Codeunit "Sms Management";
        UtapesaMessage: Text;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        SurePESATrans: Record "Mobile Banking Transactions";//"Mobile Banking Transactions"
        GenLedgerSetup: Record "General Ledger Setup";
        Charges: Record "Charges";
        MobileCharges: Decimal;
        MobileChargesACC: Text[20];
        SurePESACommACC: Code[20];
        SurePESACharge: Decimal;
        ExcDuty: Decimal;
        TempBalance: Decimal;
        BOSATransSchedule: Record "Loan Repayment Schedule";
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        msg: Text[1000];
        accountName1: Text[40];
        accountName2: Text[40];
        fosaAcc: Text[30];
        LoanGuaranteeDetails: Record "Loans Guarantee Details";
        bosaNo: Text[20];
        RanNo: Text[20];
        PaybillTrans: Record "Mobile MPESA Trans";
        PaybillRecon: Code[10];
        Rschedule: Record "Loan Repayment Schedule";
        ChargeAmount: Decimal;
        glamount: Decimal;
        LoanProducttype: Record "Loan Products Setup";
        varLoan: Text[500];
        CoopbankTran: Record "Meetings Schedule";
        loanamt: Decimal;
        description: Code[100];
        hlamount: Decimal;
        commision: Decimal;
        Mstatus: Code[10];
        SaccoGenSetup: Record "Sacco General Set-Up";
        MpesaAccount: Code[50];
        MpesaDisbus: Record "Mobile Loans";
        MPESACharge: Decimal;
        TariffDetails: Record "Cheque Transaction Codes";
        GenSetUp: Record "Sacco General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VarReceivableAccount: Code[20];
        SFactory: Codeunit "Reversal-Post(Silent)";
        ObjIprsLogs: Record "BOSA Accounts No Buffer";
        LoanRepay: Record "Loan Repayment Schedule";
        Mrowcount: Integer;
        CloudPESACharge: Decimal;
        TotalCharges: Decimal;
        CloudPESATrans: Record "Mobile Banking Transactions";
        CloudPESACommACC: Code[50];
        MPESARecon: Code[50];
        ExxcDuty: label '40415';
        appdesc: Text;


    procedure AccountBalance(Acc: Code[30]; DocNumber: Code[20]) Bal: Text[500]
    begin

        Members.Reset;
        Members.SetRange(Members."No.", Acc);
        //Members.SETRANGE(Members."Account Type",'M-WALLET');
        if Members.Find('-') then begin
            Members.CalcFields(Members."Balance (LCY)");
            Bal := Format(Members."Balance (LCY)");
        end;
    end;


    procedure MiniStatement(Phone: Code[50]; refno: Code[50]) MiniStmt: Text
    begin
        minimunCount := 1;
        Members.Reset;
        Members.SetRange(Members."No.", FnGetMemberNo(Phone));
        if Members.Find('-') then begin
            Members.CalcFields(Members."Balance (LCY)");
            //Members.CALCFIELDS(Members.Balance);
            MemberLedgerEntry.Reset;
            MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
            MemberLedgerEntry.Ascending(false);
            MemberLedgerEntry.SetFilter(MemberLedgerEntry.Description, '<>%1', '*Charges*');
            MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
            //VendorLedgEntry.SETFILTER(VendorLedgEntry.Description,'<>*Excise duty*');
            MemberLedgerEntry.SetRange(MemberLedgerEntry.Reversed, false);
            if MemberLedgerEntry.FindSet then begin
                MiniStmt := '';
                repeat
                    MemberLedgerEntry.CalcFields(MemberLedgerEntry.Amount);
                    amount := MemberLedgerEntry.Amount;
                    if amount < 1 then
                        amount := amount * -1;
                    MiniStmt := MiniStmt + Format(MemberLedgerEntry."Posting Date") + ':::' + CopyStr(MemberLedgerEntry.Description, 1, 25) + ':::' +
                    Format(amount) + '::::';
                    minimunCount := minimunCount + 1;
                    if minimunCount > 5 then
                        exit
                  until MemberLedgerEntry.Next = 0;
            end;
        end;
    end;


    procedure MiniStatementAPP(Account: Text[20]; SessionID: Text[20]; Phone: Code[20]; MaxNumberOfRows: Integer; AccountType: Code[20]; DateFrom: Date; DateTo: Date) Status: Text
    var
        BosaNUMBER: Code[30];
        AccounType: Code[10];
        msgcount: Text[1000];
    begin

        Members.Reset;
        Members.SetRange(Members."Mobile Phone No", Phone);
        if Members.Find('-') then begin

            if Vendor."Account Type" = 'ORDINARY' then begin
                Status := 'SUCCESS';//GenericCharges(Members."No.",DocNumber,'CPSTMT','Mini Statement',SurePESATrans."Transaction Type"::Ministatement);
            end
            else begin
                BosaNUMBER := Members."No.";
                Status := 'SUCCESS';//GenericCharges(BosaNUMBER,DocNumber,'CPSTMT','Mini Statement',SurePESATrans."Transaction Type"::Ministatement);
            end;
            if (Status = 'REFEXISTS') or (Status = 'INSUFFICIENT') or (Status = 'ACCNOTFOUND') then begin
                Status := '<Response>';
                Status += '<Status>ERROR</Status>';
                Status += '<StatusDescription>An error occured please try again later</StatusDescription>';
                Status += '<Reference>' + SessionID + '</Reference>';
                Status += '</Response>';
            end
            else begin
                minimunCount := 0;
                if AccountType = 'ACCOUNTS' then begin
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                    MemberLedgerEntry.Ascending(false);
                    //MemberLedgerEntry.SETFILTER(MemberLedgerEntry.Description,'<>%1','*Charges*');
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Account);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry.Reversed, false);
                    MemberLedgerEntry.SetFilter(MemberLedgerEntry."Date Filter", Format(DateFrom) + '..' + Format(DateTo));
                    Mrowcount := MemberLedgerEntry.Count;
                    if MemberLedgerEntry.FindSet then begin
                        Status := '<Response>';
                        repeat
                            MemberLedgerEntry.CalcFields(MemberLedgerEntry.Amount);
                            amount := MemberLedgerEntry.Amount;
                            if amount < 1 then
                                amount := amount * -1;
                            if MemberLedgerEntry."Debit Amount" = 0 then
                                AccounType := 'C';
                            if MemberLedgerEntry."Credit Amount" = 0 then
                                AccounType := 'D';

                            msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';


                            Status += '<Transaction>';
                            Status += '<Date>' + Format(MemberLedgerEntry."Posting Date") + '</Date>';
                            Status += '<Desc>' + MemberLedgerEntry.Description + '</Desc>';
                            Status += '<Amount>' + Format(MemberLedgerEntry.Amount * -1) + '</Amount>';
                            Status += '<Reference>' + Format(MemberLedgerEntry."Entry No.") + '</Reference>';
                            Status += '<RunningBalance>' + Format(FnGetaccountbal(Account) - amount) + '</RunningBalance>';
                            Status += '</Transaction>';

                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end
                            else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                Status += '</Response>';
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                Status += '</Response>';
                                exit;
                            end;
                        until MemberLedgerEntry.Next = 0;
                        Status += '</Response>';
                    end;

                end;
                if AccountType = 'ACCOUNTS' then begin
                    minimunCount := 0;
                    msg := '';
                    Status := '<Response>';
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                    MemberLedgerEntry.Ascending(false);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Account);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Deposit Contribution");
                    MemberLedgerEntry.SetFilter(MemberLedgerEntry."Date Filter", Format(DateFrom) + '..' + Format(DateTo));
                    Mrowcount := MemberLedgerEntry.Count;
                    if MemberLedgerEntry.Find('-') then begin

                        repeat
                            amount := MemberLedgerEntry.Amount;
                            msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';
                            Status += '<Transaction>';
                            Status += '<Date>' + Format(MemberLedgerEntry."Posting Date") + '</Date>';
                            Status += '<Desc>' + MemberLedgerEntry.Description + '</Desc>';
                            Status += '<Amount>' + Format(MemberLedgerEntry.Amount * -1) + '</Amount>';
                            Status += '<Reference>' + Format(MemberLedgerEntry."Entry No.") + '</Reference>';
                            Status += '<RunningBalance>' + Format(FnGetaccountbal(Account) - amount) + '</RunningBalance>';
                            Status += '</Transaction>';
                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end
                            else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                Status += '</Response>';
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                Status += '</Response>';
                                exit;
                            end;

                        until MemberLedgerEntry.Next = 0;
                        //SMSMessage(SessionID,Members."No.",Phone,COPYSTR(msg,1,250));
                    end;
                    Status += '</Response>';
                end;
                if AccountType = 'LOANS' then begin
                    Status := '<Response>';
                    minimunCount := 0;
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                    MemberLedgerEntry.Ascending(false);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", Account);
                    MemberLedgerEntry.SetFilter(MemberLedgerEntry."Date Filter", Format(DateFrom) + '..' + Format(DateTo));
                    Mrowcount := MemberLedgerEntry.Count;
                    if MemberLedgerEntry.Find('-') then begin
                        repeat

                            LoansRegister.Reset;
                            LoansRegister.Get(Account);
                            LoansRegister.SetRange(LoansRegister."Date filter", 0D, MemberLedgerEntry."Posting Date");
                            LoansRegister.CalcFields(LoansRegister."Outstanding Interest", LoansRegister."Outstanding Balance");
                            amount := MemberLedgerEntry.Amount;
                            msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';
                            Status += '<Transaction>';
                            Status += '<Date>' + Format(MemberLedgerEntry."Posting Date") + '</Date>';
                            Status += '<Desc>' + MemberLedgerEntry.Description + '</Desc>';
                            Status += '<Amount>' + Format(MemberLedgerEntry.Amount * -1) + '</Amount>';
                            Status += '<Reference>' + Format(MemberLedgerEntry."Entry No.") + '</Reference>';
                            Status += '<Balance>' + Format(LoansRegister."Outstanding Interest" + LoansRegister."Outstanding Balance") + '</Balance>';
                            Status += '</Transaction>';
                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end
                            else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                Status += '</Response>';
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                Status += '</Response>';
                                exit;
                            end;

                        until MemberLedgerEntry.Next = 0;
                    end;
                    Status += '</Response>';
                end;


            end;
        end;
    end;


    procedure MiniStatementUSSD(Account: Text[20]; SessionID: Text[20]; Phone: Code[20]; MaxNumberOfRows: Integer; AccountType: Code[20]) Status: Code[20]
    var
        BosaNUMBER: Code[30];
        AccounType: Code[10];
        msgcount: Text[1000];
    begin

        Members.Reset;
        Members.SetRange(Members."No.", FnGetMemberNo(Phone));
        if Members.Find('-') then begin
            if Members.Blocked = Members.Blocked::" " then begin
                Status := 'True';//GenericCharges(Members."No.",DocNumber,'CPSTMT','Mini Statement',SurePESATrans."Transaction Type"::Ministatement);
            end
            else begin
                Status := 'True';//GenericCharges(BosaNUMBER,DocNumber,'CPSTMT','Mini Statement',SurePESATrans."Transaction Type"::Ministatement);
            end;
            if (Status = 'REFEXISTS') or (Status = 'INSUFFICIENT') or (Status = 'ACCNOTFOUND') then begin
                Status := Status;
            end
            else begin
                minimunCount := 0;
                if AccountType = 'FOSA' then begin
                    Members.Reset;
                    Members.SetRange(Members."No.", Members."No.");
                    // Members.SETRANGE(Members."Account Type",'M-WALLET');
                    if Members.Find('-') then begin
                    end;
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                    MemberLedgerEntry.Ascending(false);
                    //MemberLedgerEntry.SETFILTER(MemberLedgerEntry.Description,'<>%1','*Charges*');
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                    MemberLedgerEntry.SetRange(MemberLedgerEntry.Reversed, false);
                    Mrowcount := MemberLedgerEntry.Count;
                    if MemberLedgerEntry.FindSet then begin
                        Status := '';
                        repeat
                            MemberLedgerEntry.CalcFields(MemberLedgerEntry.Amount);
                            amount := MemberLedgerEntry.Amount;
                            if amount < 1 then
                                amount := amount * -1;
                            if MemberLedgerEntry."Debit Amount" = 0 then
                                AccounType := 'C';
                            if MemberLedgerEntry."Credit Amount" = 0 then
                                AccounType := 'D';

                            msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';
                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end
                            else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;
                        until MemberLedgerEntry.Next = 0;
                    end;

                end;
                if AccountType = '1' then begin
                    minimunCount := 0;
                    msg := '';
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                    MemberLedgerEntry.Ascending(false);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Account);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry.Reversed, false);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Deposit Contribution");
                    Mrowcount := MemberLedgerEntry.Count;
                    if MemberLedgerEntry.Find('-') then begin
                        repeat
                            amount := MemberLedgerEntry.Amount;
                            msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';
                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end
                            else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;

                        until MemberLedgerEntry.Next = 0;
                        //SMSMessage(SessionID,Members."No.",Phone,COPYSTR(msg,1,250));
                    end;
                end;
                if AccountType = '2' then begin
                    minimunCount := 0;
                    msg := '';
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                    MemberLedgerEntry.Ascending(false);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Account);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry.Reversed, false);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Share Capital");
                    Mrowcount := MemberLedgerEntry.Count;
                    if MemberLedgerEntry.Find('-') then begin
                        repeat
                            amount := MemberLedgerEntry.Amount;
                            msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';
                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end
                            else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;

                        until MemberLedgerEntry.Next = 0;
                        //SMSMessage(SessionID,Members."No.",Phone,COPYSTR(msg,1,250));
                    end;
                end;


                if AccountType = '3' then begin
                    minimunCount := 0;
                    msg := '';
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                    MemberLedgerEntry.Ascending(false);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Account);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Silver Savings");
                    MemberLedgerEntry.SetRange(MemberLedgerEntry.Reversed, false);
                    Mrowcount := MemberLedgerEntry.Count;
                    if MemberLedgerEntry.Find('-') then begin
                        repeat
                            amount := MemberLedgerEntry.Amount;
                            msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';
                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end
                            else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;

                        until MemberLedgerEntry.Next = 0;
                        //SMSMessage(SessionID,Members."No.",Phone,COPYSTR(msg,1,250));
                    end;
                end;
                if AccountType = '4' then begin
                    minimunCount := 0;
                    msg := '';
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                    MemberLedgerEntry.Ascending(false);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Account);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::Dividend);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry.Reversed, false);
                    Mrowcount := MemberLedgerEntry.Count;
                    if MemberLedgerEntry.Find('-') then begin
                        repeat
                            amount := MemberLedgerEntry.Amount;
                            msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';
                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end
                            else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;

                        until MemberLedgerEntry.Next = 0;
                        //SMSMessage(SessionID,Members."No.",Phone,COPYSTR(msg,1,250));
                    end;
                end;
                if AccountType = 'LOAN' then begin
                    minimunCount := 0;
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
                    MemberLedgerEntry.Ascending(false);
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", Account);
                    Mrowcount := MemberLedgerEntry.Count;
                    if MemberLedgerEntry.Find('-') then begin
                        repeat
                            amount := MemberLedgerEntry.Amount;
                            msgcount := msg + Format(MemberLedgerEntry."Posting Date") + ': ' + MemberLedgerEntry.Description + ': KES ' + Format(amount) + ', ';

                            if StrLen(msgcount) <= 250 then begin
                                msg := msgcount;
                            end
                            else begin
                                minimunCount := MaxNumberOfRows;
                            end;
                            minimunCount := minimunCount + 1;
                            if (Mrowcount <= MaxNumberOfRows) and (minimunCount = Mrowcount) then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;
                            if minimunCount > MaxNumberOfRows then begin
                                SMSMessage(SessionID, Members."No.", Phone, CopyStr(msg, 1, 250), '');
                                exit;
                            end;

                        until MemberLedgerEntry.Next = 0;
                    end;
                end;
                if msg = '' then begin
                    SMSMessage(SessionID, Members."No.", Phone, CopyStr('You have not done any transactions', 1, 250), '');
                end;


            end;
        end;
    end;


    procedure LoanProducts() LoanTypes: Text[150]
    begin
        begin
            LoanProductsSetup.Reset;
            LoanProductsSetup.SetRange(LoanProductsSetup.Source, LoanProductsSetup.Source::FOSA);
            if LoanProductsSetup.Find('-') then begin
                repeat
                    LoanTypes := LoanTypes + ':::' + LoanProductsSetup."Product Description";
                until LoanProductsSetup.Next = 0;
            end
        end
    end;


    procedure BOSAAccount(Phone: Text[20]) bosaAcc: Text[20]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."Phone No.", Phone);
            if Members.Find('-') then begin
                bosaAcc := Members."No.";
            end;
        end
    end;


    procedure MemberAccountNumbers(phone: Text[20]) accounts: Text[250]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                // BEGIN
                accounts := '';
                repeat
                    accounts := accounts + '::::' + Members."No.";
                until Members.Next = 0;
            end
            else begin
                accounts := accounts + '::::' + 'NA';
            end
        end;
    end;


    procedure RegisteredMemberDetails(Phone: Text[20]) reginfo: Text[250]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(Phone));
            if Members.Find('-') then begin
                reginfo := Members."No." + ':::' + Members.Name + ':::' + Format(Members."ID No.") + ':::' + Format(Members."Phone No.") + ':::' + Members."E-Mail";
            end
            else begin
                reginfo := '';
            end
        end;
    end;


    procedure DetailedStatement(Phone: Text[20]; lastEntry: Integer) detailedstatement: Text[1023]
    begin
        begin
            dateExpression := '<CD-1M>'; // Current date less 3 months
            dashboardDataFilter := CalcDate(dateExpression, Today);

            Members.Reset;
            Members.SetRange(Members."Phone No.", Phone);
            detailedstatement := '';
            if Members.FindSet then
                repeat
                    minimunCount := 1;
                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");

                    if AccountTypes.FindSet then
                        repeat
                            DetailedVendorLedgerEntry.Reset;
                            DetailedVendorLedgerEntry.SetRange(DetailedVendorLedgerEntry."Vendor No.", Members."No.");
                            DetailedVendorLedgerEntry.SetFilter(DetailedVendorLedgerEntry."Entry No.", '>%1', lastEntry);
                            DetailedVendorLedgerEntry.SetFilter(DetailedVendorLedgerEntry."Posting Date", '>%1', dashboardDataFilter);

                            if DetailedVendorLedgerEntry.FindSet then
                                repeat

                                    MemberLedgerEntry.Reset;
                                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Entry No.", DetailedVendorLedgerEntry."Vendor Ledger Entry No.");

                                    if MemberLedgerEntry.FindSet then begin
                                        if detailedstatement = ''
                                        then begin
                                            detailedstatement := Format(DetailedVendorLedgerEntry."Entry No.") + ':::' +
                                            Format(AccountTypes.Description) + ':::' +
                                            Format(DetailedVendorLedgerEntry."Posting Date") + ':::' +
                                            Format((DetailedVendorLedgerEntry."Posting Date"), 0, '<Month Text>') + ':::' +
                                            Format(Date2dmy((DetailedVendorLedgerEntry."Posting Date"), 3)) + ':::' +
                                            Format((DetailedVendorLedgerEntry."Credit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                            Format((DetailedVendorLedgerEntry."Debit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                            Format((DetailedVendorLedgerEntry.Amount), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                            Format(DetailedVendorLedgerEntry."Journal Batch Name") + ':::' +
                                            Format(DetailedVendorLedgerEntry."Initial Entry Global Dim. 1") + ':::' +
                                            Format(MemberLedgerEntry.Description);
                                        end
                                        else
                                            repeat
                                                detailedstatement := detailedstatement + '::::' +
                                                Format(DetailedVendorLedgerEntry."Entry No.") + ':::' +
                                                Format(AccountTypes.Description) + ':::' +
                                                Format(DetailedVendorLedgerEntry."Posting Date") + ':::' +
                                                Format((DetailedVendorLedgerEntry."Posting Date"), 0, '<Month Text>') + ':::' +
                                                Format(Date2dmy((DetailedVendorLedgerEntry."Posting Date"), 3)) + ':::' +
                                                Format((DetailedVendorLedgerEntry."Credit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                                Format((DetailedVendorLedgerEntry."Debit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                                Format((DetailedVendorLedgerEntry.Amount), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                                Format(DetailedVendorLedgerEntry."Journal Batch Name") + ':::' +
                                                Format(DetailedVendorLedgerEntry."Initial Entry Global Dim. 1") + ':::' +
                                                Format(MemberLedgerEntry.Description);

                                                if minimunCount > 20 then
                                                    exit
                                            until MemberLedgerEntry.Next = 0;
                                    end;
                                until DetailedVendorLedgerEntry.Next = 0;
                        until AccountTypes.Next = 0;
                until Members.Next = 0;
        end;
    end;


    procedure MemberAccountNames(phone: Text[20]) accounts: Text[250]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            Members.SetRange(Members.Status, Members.Status::Active);
            if Members.Find('-') then begin
                accounts := '';
                repeat
                    accounts := accounts + '::::Mobile Wallet';
                until Members.Next = 0;
            end
            else begin
                accounts := '';
            end
        end;
    end;


    procedure LoanBalances(phone: Text[20]; DocNo: Code[100]) loanbalances: Text
    begin
        begin
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                LoansTable.Reset;
                LoansTable.SetRange(LoansTable."Client Code", Members."No.");
                if LoansTable.Find('-') then begin
                    repeat
                        LoansTable.CalcFields(LoansTable."Outstanding Balance", LoansTable."Outstanding Interest", LoansTable."Interest to be paid", LoansTable."Interest Paid");
                        if (LoansTable."Outstanding Balance" > 0) then
                            loanbalances := loanbalances + '::::' + LoansTable."Loan  No." + ':::' + Format(LoansTable."Loan Product Type Name") + ':::' +
                             Format(LoansTable."Outstanding Balance" + LoansTable."Outstanding Interest");
                    until LoansTable.Next = 0;
                    //MESSAGE('Loan Balance %1',loanbalances);

                end;
            end;
        end;
    end;


    procedure LoanBalancesUSSD(phone: Text[20]; DocNo: Code[100]; apptype: Code[50]) loanbalances: Text
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                loanbalances := '';
                LoansTable.Reset;
                LoansTable.SetRange(LoansTable."Client Code", Members."No.");
                if LoansTable.Find('-') then begin
                    repeat
                        LoansTable.CalcFields(LoansTable."Outstanding Balance", LoansTable."Outstanding Interest", LoansTable."Interest to be paid", LoansTable."Interest Paid");
                        if (LoansTable."Outstanding Balance" > 0) then begin
                            loanbalances := loanbalances + LoansTable."Loan  No." + ':' + Format(LoansTable."Loan Product Type Name") + ': Ksh. ' +
                             Format(LoansTable."Outstanding Balance" + LoansTable."Outstanding Interest") + ',';
                        end;
                    until LoansTable.Next = 0;
                    //MESSAGE('Loan Balance %1',loanbalances);
                    loanbalances := CopyStr(loanbalances, 1, StrLen(loanbalances) - 1);
                    SMSMessage(DocNo, Members."No.", Members."Mobile Phone No", loanbalances, '');
                end;

                if loanbalances = '' then begin
                    msg := 'You do not have outstanding loans';
                    SMSMessage(DocNo, Members."No.", Members."Mobile Phone No", msg, '');
                end;
            end;
        end;
        loanbalances := 'TRUE';
    end;


    procedure MemberAccounts(phone: Text[20]) accounts: Text[250]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            Members.SetRange(Members.Status, Members.Status::Active);
            Members.SetRange(Members.Blocked, Members.Blocked::" ");
            if Members.Find('-') then begin
                accounts := accounts + '::::' + Members."No." + ':::Deposit Contribution:::1';
                accounts := accounts + '::::' + Members."No." + ':::Share Capital:::2';
                accounts := accounts + '::::' + Members."No." + ':::Holiday Savings:::3';
                accounts := accounts + '::::' + Members."No." + ':::Dividend:::4';
            end
            else begin
                accounts := '';
            end
        end;
    end;


    procedure SurePESARegistration() memberdetails: Text[1000]
    begin
        begin
            SurePESAApplications.Reset;
            SurePESAApplications.SetRange(SurePESAApplications.SentToServer, false);
            SurePESAApplications.SetRange(SurePESAApplications."PIN Requested", true);
            if SurePESAApplications.FindSet then begin
                repeat
                    if SurePESAApplications.Status = SurePESAApplications.Status::Approved then begin
                        Mstatus := '0';
                    end else begin
                        Mstatus := '1';
                    end;
                    memberdetails := memberdetails + SurePESAApplications."Account No" + ':::' + SurePESAApplications.Telephone + ':::' + SurePESAApplications."ID No" + ':::' + Mstatus + '::::';

                until SurePESAApplications.Next = 0;
            end
            else begin
                memberdetails := '';
            end
        end;
    end;


    procedure UpdateSurePESARegistration(accountNo: Text[30]) result: Text[10]
    begin
        begin
            SurePESAApplications.Reset;
            SurePESAApplications.SetRange(SurePESAApplications.SentToServer, false);
            SurePESAApplications.SetRange(SurePESAApplications."Account No", accountNo);
            if SurePESAApplications.Find('-') then begin
                SurePESAApplications.SentToServer := true;
                SurePESAApplications."PIN Requested" := false;
                SurePESAApplications.Modify;
                result := 'Modified';
            end
            else begin
                result := 'Failed';
            end
        end;
    end;


    procedure FundsTransferFOSA(accFrom: Text[20]; accTo: Text[20]; DocNumber: Text[30]; amount: Decimal; memberNO: Text) result: Text[30]
    var
        objvendor: Record Vendor;
        objvendor2: Record Vendor;
    begin

        SurePESATrans.RESET;
        SurePESATrans.SETRANGE(SurePESATrans."Account No", DocNumber);
        IF SurePESATrans.FIND('-') THEN BEGIN
            result := 'REFEXISTS';
        END
        ELSE BEGIN

            GenLedgerSetup.RESET;
            GenLedgerSetup.GET;
            //GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile banking Charge");
            //GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Comm Account");
            //GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");

            Charges.RESET;
            Charges.SETRANGE(Charges.Code, GenLedgerSetup."Mobile banking Charge");
            IF Charges.FIND('-') THEN BEGIN
                Charges.TESTFIELD(Charges."GL Account");
                MobileCharges := Charges."Charge Amount";
                MobileChargesACC := Charges."GL Account";
            END;
            MobileCharges := 10;
            MobileChargesACC := '30630';

            SurePESACommACC := '30630';// GenLedgerSetup."Mobile Comm Account";
            SurePESACharge := 10;// GenLedgerSetup."Mobile Charge";

            ExcDuty := (10 / 100) * MobileCharges;

            objvendor.RESET;
            objvendor.SETRANGE(objvendor."No.", accFrom);
            //objvendor.SetRange(objvendor."Account Type", accFrom);
            IF objvendor.FIND('-') THEN BEGIN
                objvendor.CALCFIELDS(objvendor."Balance (LCY)");
                TempBalance := objvendor."Balance (LCY)" - (objvendor."ATM Transactions" + objvendor."Uncleared Cheques" + objvendor."EFT Transactions");

                objvendor2.RESET;
                objvendor2.SETRANGE(objvendor2."No.", accTo);
                // objvendor2.SetRange(objvendor2."Account Type", accTo);
                IF objvendor2.FIND('-') THEN BEGIN
                    IF (TempBalance > amount + MobileCharges + SurePESACharge) THEN BEGIN
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                        GenJournalLine.SETRANGE("Journal Batch Name", 'MOBILETRAN');
                        GenJournalLine.DELETEALL;
                        //end of deletion

                        GenBatches.RESET;
                        GenBatches.SETRANGE(GenBatches."Journal Template Name", 'GENERAL');
                        GenBatches.SETRANGE(GenBatches.Name, 'MOBILETRAN');

                        IF GenBatches.FIND('-') = FALSE THEN BEGIN
                            GenBatches.INIT;
                            GenBatches."Journal Template Name" := 'GENERAL';
                            GenBatches.Name := 'MOBILETRAN';
                            GenBatches.Description := 'SUREPESA Tranfers';
                            GenBatches.VALIDATE(GenBatches."Journal Template Name");
                            GenBatches.VALIDATE(GenBatches.Name);
                            GenBatches.INSERT;
                        END;

                        //DR ACC 1
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                        GenJournalLine."Account No." := objvendor."No.";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;

                        GenJournalLine."External Document No." := objvendor."No.";
                        GenJournalLine."Posting Date" := TODAY;
                        GenJournalLine.Description := 'Mobile Transfer to ' + accTo;
                        GenJournalLine.Amount := amount;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;

                        //Dr Transfer Charges
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                        GenJournalLine."Account No." := objvendor."No.";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := objvendor."No.";
                        GenJournalLine."Posting Date" := TODAY;
                        GenJournalLine.Description := 'Mobile Transfer Charges';
                        GenJournalLine.Amount := (MobileCharges - ExcDuty) + SurePESACharge;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;


                        //DR Excise Duty
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                        GenJournalLine."Account No." := objvendor."No.";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := objvendor."No.";
                        GenJournalLine."Posting Date" := TODAY;
                        GenJournalLine.Description := 'Excise duty-Mobile Transfer';
                        GenJournalLine.Amount := ExcDuty;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;

                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                        GenJournalLine."Account No." := MobileChargesACC;
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := TODAY;
                        GenJournalLine.Description := 'Excise duty-Mobile Transfer';
                        GenJournalLine.Amount := ExcDuty * -1;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;

                        //CR Mobile Transactions Acc
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                        GenJournalLine."Account No." := MobileChargesACC;
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := TODAY;
                        GenJournalLine.Description := 'Mobile Transfer Charges';
                        GenJournalLine.Amount := (MobileCharges - ExcDuty) * -1;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;

                        //CR Commission
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                        GenJournalLine."Account No." := SurePESACommACC;
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := TODAY;
                        GenJournalLine.Description := 'Mobile Transfer Charges';
                        GenJournalLine.Amount := -SurePESACharge;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;

                        //CR ACC2
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                        GenJournalLine."Account No." := objvendor2."No.";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := objvendor2."No.";
                        GenJournalLine."Posting Date" := TODAY;
                        GenJournalLine.Description := 'Mobile Transfer from ' + accFrom + '-' + objvendor."No.";
                        GenJournalLine.Amount := -amount;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;

                        //Post
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                        GenJournalLine.SETRANGE("Journal Batch Name", 'MOBILETRAN');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                            REPEAT
                                GLPosting.RUN(GenJournalLine);
                            UNTIL GenJournalLine.NEXT = 0;
                        END;


                        SurePESATrans.INIT;
                        SurePESATrans."Document No" := DocNumber;
                        SurePESATrans.Description := 'Mobile Transfer';
                        SurePESATrans."Document Date" := TODAY;
                        SurePESATrans."Account No" := objvendor."No.";
                        SurePESATrans."Account 2" := objvendor2."No.";
                        SurePESATrans.Amount := amount;
                        SurePESATrans.Posted := TRUE;
                        SurePESATrans."Posting Date" := TODAY;
                        SurePESATrans.Comments := 'Success';
                        SurePESATrans.Client := objvendor."No.";
                        SurePESATrans."Transaction Type" := SurePESATrans."Transaction Type"::"Transfer to Fosa";
                        SurePESATrans."Transaction Time" := TIME;
                        SurePESATrans.INSERT;
                        result := 'TRUE';

                        msg := 'You have transfered KES ' + FORMAT(amount) + ' from Account ' + objvendor."Account Type" + ' to ' + objvendor2."Account Type" +
                         ' .Thank you for using Utabibu sacco Mobile.';
                        SMSMessage(DocNumber, accFrom, objvendor."Mobile Phone No", msg, '');
                    END
                    ELSE BEGIN
                        result := 'INSUFFICIENT';
                        msg := 'You have insufficient funds in your savings Account to use this service.' +
                       ' .Thank you for using Utabibu sacco Mobile.';
                        SMSMessage(DocNumber, accFrom, Members."Phone No.", msg, '');
                    END;
                END
                ELSE BEGIN
                    result := 'ACC2INEXISTENT';
                    msg := 'Your request has failed because the recipent account does not exist.' +
                   ' .Thank you for using Utabibu Sacco Mobile.';
                    SMSMessage(DocNumber, accFrom, Members."Phone No.", msg, '');
                END;
            END
            ELSE BEGIN
                result := 'ACCINEXISTENT';
                result := 'INSUFFICIENT';
                msg := 'Your request has failed because the recipent account does not exist.' +
                ' .Thank you for using Utabibu Sacco Mobile.';
                SMSMessage(DocNumber, accFrom, Members."Phone No.", msg, '');
            END;
        END;
    END;


    procedure FundsTransferBOSA(accFrom: Text[20]; accTo: Text[20]; DocNumber: Text[30]; amount: Decimal; memberNo: Text) result: Text[30]
    var
        objvendor: Record Vendor;
        objvendor2: Record Vendor;
    begin

        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", DocNumber);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end
        else begin

            objvendor.RESET;
            objvendor.SETRANGE(objvendor."No.", accFrom);
            // objvendor.SetRange(objvendor."Account Type", accFrom);
            IF objvendor.FIND('-') THEN BEGIN
                objvendor.CALCFIELDS(objvendor."Balance (LCY)");
                TempBalance := objvendor."Balance (LCY)" - (objvendor."ATM Transactions" + objvendor."Uncleared Cheques" + objvendor."EFT Transactions");
                if TempBalance > amount then begin
                    if (accTo = 'Share capital') or (accTo = 'Deposit Contribution') or (accTo = 'Benevolent Fund') or (accTo = 'Insurance Fund')
                      then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                        GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init;
                            GenBatches."Journal Template Name" := 'GENERAL';
                            GenBatches.Name := 'MOBILETRAN';
                            GenBatches.Description := 'SUREPESA Tranfers';
                            GenBatches.Validate(GenBatches."Journal Template Name");
                            GenBatches.Validate(GenBatches.Name);
                            GenBatches.Insert;
                        end;

                        //DR ACC 1
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := objvendor."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := objvendor."No.";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer';
                        GenJournalLine.Amount := amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        //CR ACC2
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        GenJournalLine."Account No." := objvendor."BOSA Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := 'SUREPESA';
                        GenJournalLine."Posting Date" := Today;
                        if accTo = 'Deposit Contribution' then begin
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                        end;
                        if accTo = 'Share capital' then begin
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                        end;
                        if accTo = 'Registration Fee' then begin
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
                            GenJournalLine.Description := 'Mobile Transfer from ' + accFrom;
                        end;
                        // GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine.Amount := -amount;
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                            repeat
                                GLPosting.Run(GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;

                        SurePESATrans.Init;
                        SurePESATrans."Document No" := DocNumber;
                        SurePESATrans.Description := 'Mobile Transfer';
                        SurePESATrans."Document Date" := Today;
                        SurePESATrans."Account No" := objvendor."No.";
                        SurePESATrans."Account 2" := accTo;
                        SurePESATrans.Amount := amount;
                        SurePESATrans.Posted := true;
                        SurePESATrans."Posting Date" := Today;
                        SurePESATrans.Comments := 'Success';
                        SurePESATrans.Client := Members."No.";
                        SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Transfer to Fosa";
                        SurePESATrans."Transaction Time" := Time;
                        SurePESATrans.Insert;
                        result := 'TRUE';

                        msg := 'You have transfered KES ' + Format(amount) + ' from Account ' + accFrom + ' to ' + accTo +
                         ' .Thank you for Utabibu sacco Mobile.';
                        SMSMessage(DocNumber, accFrom, objvendor."Mobile Phone No", msg, '');
                    end
                    else begin
                        result := 'ACC2INEXISTENT';
                        msg := 'Your request has failed because the recipent account does not exist.' +
                       '. Thank you for using Utabibu Sacco Mobile.';
                        SMSMessage(DocNumber, accFrom, Members."Phone No.", msg, '');
                    end;
                end else begin
                    result := 'INSUFFICIENT';
                    msg := 'You have insufficient funds in your savings Account to use this service.' +
                   '. Thank you for using Utabibu sacco Mobile.';
                    SMSMessage(DocNumber, accFrom, objvendor."Mobile Phone No", msg, '');
                end;

            end;

        end

    end;


    procedure WSSAccount(phone: Text[20]) accounts: Text[250]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            Members.SetRange(Members.Status, Members.Status::Active);
            if Members.Find('-') then begin

                accounts := accounts + '::::' + Members."No." + ':::Deposit Contribution:::1';
                accounts := accounts + '::::' + Members."No." + ':::Share Capital:::2';
                accounts := accounts + '::::' + Members."No." + ':::Withdrawable deposits:::3';
                accounts := accounts + '::::' + Members."No." + ':::Invetstment Contribution:::4';
                accounts := accounts + '::::' + Members."No." + ':::Benevolent Fund:::5';
                accounts := accounts + '::::' + Members."No." + ':::Kisiko welfare:::6';

                Members.Reset;
                Members.SetRange(Members."No.", Members."No.");
                //Members.SETRANGE(Members."Account Type",'M-WALLET');
                if Members.Find('-') then begin
                    accounts := accounts + Members."No." + ':::M-WALLET:::4::::';
                end;



            end
            else begin
                accounts := '';
            end
        end;
    end;


    procedure SMSMessagetest(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[250]; addition: Text[250])
    begin
        iEntryNo := 0;
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'TESTAUTO';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        //SMSMessages."Additional sms":=addition;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;


    procedure SMSMessage(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[250]; addition: Text[250])
    begin
        iEntryNo := 0;
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'MOBILETRAN';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        ///SMSMessages."Additional sms":=addition;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;


    procedure LoanRepayment(accFrom: Text[20]; loanNo: Text[20]; DocNumber: Text[30]; amount: Decimal) result: Text[30]
    var
        objvendor: Record Vendor;
    begin

        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", DocNumber);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end
        else begin

            objvendor.Reset;
            objvendor.SetRange(objvendor."No.", accFrom);
            if objvendor.Find('-') then begin

                /*GenLedgerSetup.RESET;
                GenLedgerSetup.GET;
                GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charges");
                GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Comm Account");
                GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");

                Charges.RESET;
                Charges.SETRANGE(Charges.Code,GenLedgerSetup."Mobile Charges");
                IF Charges.FIND('-') THEN BEGIN
                  Charges.TESTFIELD(Charges."GL Account");
                  MobileCharges:=Charges."Charge Amount";
                  MobileChargesACC:=Charges."GL Account";
                END;

                  SurePESACommACC:=  GenLedgerSetup."Mobile Comm Account";
                  SurePESACharge:=GenLedgerSetup."Mobile Charge";

                  ExcDuty:=(10/100)*MobileCharges;
                  */
                objvendor.Reset;
                objvendor.SetRange(objvendor."No.", accFrom);
                if objvendor.Find('-') then begin
                    objvendor.CalcFields(objvendor."Balance (LCY)");
                    TempBalance := objvendor."Balance (LCY)" - (objvendor."ATM Transactions" + objvendor."Uncleared Cheques" + objvendor."EFT Transactions");

                    LoansRegister.Reset;
                    LoansRegister.SetRange(LoansRegister."Loan  No.", loanNo);
                    // LoansRegister.SetRange(LoansRegister."Client Code", objvendor."BOSA Account No");
                    if LoansRegister.Find('+') then begin
                        LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Outstanding Interest");
                        if (TempBalance > amount + MobileCharges + SurePESACharge) then begin
                            if LoansRegister."Outstanding Balance" > 0 then begin
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                                GenJournalLine.DeleteAll;
                                //end of deletion

                                GenBatches.Reset;
                                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                                GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                                if GenBatches.Find('-') = false then begin
                                    GenBatches.Init;
                                    GenBatches."Journal Template Name" := 'GENERAL';
                                    GenBatches.Name := 'MOBILETRAN';
                                    GenBatches.Description := 'Mobile Loan Repayment';
                                    GenBatches.Validate(GenBatches."Journal Template Name");
                                    GenBatches.Validate(GenBatches.Name);
                                    GenBatches.Insert;
                                end;

                                //DR ACC 1
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := accFrom;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := DocNumber;
                                GenJournalLine."External Document No." := accFrom;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Mobile Loan Repayment';
                                GenJournalLine.Amount := amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                /* //Dr Transfer Charges
                                         LineNo:=LineNo+10000;
                                         GenJournalLine.INIT;
                                         GenJournalLine."Journal Template Name":='GENERAL';
                                         GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                         GenJournalLine."Line No.":=LineNo;
                                         GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                                         GenJournalLine."Account No.":=accFrom;
                                         GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                         GenJournalLine."Document No.":=DocNumber;
                                         GenJournalLine."External Document No.":=accFrom;
                                         GenJournalLine."Posting Date":=TODAY;
                                         GenJournalLine.Description:='Mobile Charges';
                                         GenJournalLine.Amount:=(MobileCharges-ExcDuty) + SurePESACharge ;
                                         GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                         IF GenJournalLine.Amount<>0 THEN
                                         GenJournalLine.INSERT;


                                 //DR Excise Duty
                                         LineNo:=LineNo+10000;
                                         GenJournalLine.INIT;
                                         GenJournalLine."Journal Template Name":='GENERAL';
                                         GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                         GenJournalLine."Line No.":=LineNo;
                                         GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                                         GenJournalLine."Account No.":=accFrom;
                                         GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                         GenJournalLine."Document No.":=DocNumber;
                                         GenJournalLine."External Document No.":=accFrom;
                                         GenJournalLine."Posting Date":=TODAY;
                                         GenJournalLine.Description:='Excise duty-Mobile Charges';
                                         GenJournalLine.Amount:=ExcDuty;
                                         GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                         IF GenJournalLine.Amount<>0 THEN
                                         GenJournalLine.INSERT;

                                         LineNo:=LineNo+10000;
                                         GenJournalLine.INIT;
                                         GenJournalLine."Journal Template Name":='GENERAL';
                                         GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                         GenJournalLine."Line No.":=LineNo;
                                         GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                                         GenJournalLine."Account No.":=FORMAT('200-000-3016');
                                         GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                         GenJournalLine."Document No.":=DocNumber;
                                         GenJournalLine."External Document No.":=MobileChargesACC;
                                         GenJournalLine."Posting Date":=TODAY;
                                         GenJournalLine.Description:='Excise duty-Mobile Charges';
                                         GenJournalLine.Amount:=ExcDuty*-1;
                                         GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                         IF GenJournalLine.Amount<>0 THEN
                                         GenJournalLine.INSERT;

                                 //CR Mobile Transactions Acc
                                         LineNo:=LineNo+10000;
                                         GenJournalLine.INIT;
                                         GenJournalLine."Journal Template Name":='GENERAL';
                                         GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                         GenJournalLine."Line No.":=LineNo;
                                         GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                                         GenJournalLine."Account No.":=MobileChargesACC;
                                         GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                         GenJournalLine."Document No.":=DocNumber;
                                         GenJournalLine."External Document No.":=MobileChargesACC;
                                         GenJournalLine."Posting Date":=TODAY;
                                         GenJournalLine.Description:='Mobile Charges';
                                         GenJournalLine.Amount:=(MobileCharges-ExcDuty)*-1;
                                         GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                         IF GenJournalLine.Amount<>0 THEN
                                         GenJournalLine.INSERT;

                                 //CR Commission
                                         LineNo:=LineNo+10000;
                                         GenJournalLine.INIT;
                                         GenJournalLine."Journal Template Name":='GENERAL';
                                         GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                         GenJournalLine."Line No.":=LineNo;
                                         GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                                         GenJournalLine."Account No.":=SurePESACommACC;
                                         GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                         GenJournalLine."Document No.":=DocNumber;
                                         GenJournalLine."External Document No.":=MobileChargesACC;
                                         GenJournalLine."Posting Date":=TODAY;
                                         GenJournalLine.Description:='Mobile Charges';
                                         GenJournalLine.Amount:=-SurePESACharge;
                                         GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                         IF GenJournalLine.Amount<>0 THEN
                                         GenJournalLine.INSERT;*/

                                if LoansRegister."Outstanding Interest" > 0 then begin
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                    GenJournalLine."Account No." := LoansRegister."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := DocNumber;
                                    GenJournalLine."External Document No." := '';
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Loan Interest Payment';
                                end;

                                if amount > LoansRegister."Outstanding Interest" then
                                    GenJournalLine.Amount := -LoansRegister."Outstanding Interest"
                                else
                                    GenJournalLine.Amount := -amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";

                                // if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                //     GenJournalLine."Shortcut Dimension 1 Code" := objvendor."Global Dimension 1 Code";
                                //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                // end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                amount := amount + GenJournalLine.Amount;

                                if amount > 0 then begin
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                    GenJournalLine."Account No." := LoansRegister."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := DocNumber;
                                    GenJournalLine."External Document No." := '';
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Loan repayment';
                                    GenJournalLine.Amount := -amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Repayment;
                                    // if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    //     GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    // end;
                                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;


                                //Post
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                                if GenJournalLine.Find('-') then begin
                                    repeat
                                        GLPosting.Run(GenJournalLine);
                                    until GenJournalLine.Next = 0;
                                end;
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                                GenJournalLine.DeleteAll;

                                SurePESATrans.Init;
                                SurePESATrans."Document No" := DocNumber;
                                SurePESATrans.Description := 'Mobile Transfer';
                                SurePESATrans."Document Date" := Today;
                                SurePESATrans."Account No" := accFrom;
                                SurePESATrans."Account 2" := loanNo;
                                SurePESATrans.Amount := amount;
                                SurePESATrans.Posted := true;
                                SurePESATrans."Posting Date" := Today;
                                SurePESATrans.Comments := 'Success';
                                SurePESATrans.Client := Members."No.";
                                SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Transfer to Fosa";
                                SurePESATrans."Transaction Time" := Time;
                                SurePESATrans.Insert;
                                result := 'TRUE';

                                msg := 'You have transfered KES ' + Format(amount) + ' from Account ' + Members.Name + ' to ' + loanNo +
                                 '. Thank you for using Utabibu sacco Mobile.';
                                SMSMessage(DocNumber, accFrom, objvendor."Phone No.", msg, '');
                            end;
                        end
                        else begin
                            result := 'INSUFFICIENT';
                            msg := 'You have insufficient funds in your savings Account to use this service.' +
                           '. Thank you for using Utabibu sacco Mobile.';
                            SMSMessage(DocNumber, accFrom, Members."Phone No.", msg, '');
                        end;
                    end
                    else begin
                        result := 'ACC2INEXISTENT';
                        msg := 'Your request has failed because you do not have any outstanding balance.' +
                       '. Thank you for using Vision Sacco Mobile.';
                        SMSMessage(DocNumber, accFrom, Members."Phone No.", msg, '');
                    end;
                end
                else begin
                    result := 'ACCINEXISTENT';
                    msg := 'Your request has failed.Please make sure you are registered for mobile banking.' +
                    '. Thank you for using Vision Sacco Mobile.';
                    SMSMessage(DocNumber, accFrom, Members."Phone No.", msg, '');
                end;
            end
            else begin
                result := 'MEMBERINEXISTENT';
                msg := 'Your request has failed because the recipent account does not exist.' +
                '. Thank you for using Vision Sacco Mobile.';
                SMSMessage(DocNumber, accFrom, Members."Phone No.", msg, '');
            end;
        end

    end;


    procedure OutstandingLoans(phone: Text[20]) loannos: Text[200]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                LoansTable.Reset;
                LoansTable.SetRange(LoansTable."Client Code", Members."No.");
                if LoansTable.Find('-') then begin
                    repeat
                        LoansTable.CalcFields(LoansTable."Outstanding Balance");
                        if (LoansTable."Outstanding Balance" > 0) then
                            loannos := loannos + ':::' + LoansTable."Loan  No.";
                    until LoansTable.Next = 0;
                end;
            end
        end;
    end;


    procedure LoanGuarantors(loanNo: Text[20]) guarantors: Text
    begin
        begin
            LoanGuaranteeDetails.Reset;
            LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Loan No", loanNo);
            if LoanGuaranteeDetails.Find('-') then begin
                repeat
                    guarantors := guarantors + '::::' + LoanGuaranteeDetails.Name + ':::' + Format(LoanGuaranteeDetails."Amont Guaranteed");
                until LoanGuaranteeDetails.Next = 0;
            end;
        end;
    end;


    procedure LoansGuaranteed(phone: Text[20]) guarantors: Text[1000]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin

                LoanGuaranteeDetails.Reset;
                LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Member No", Members."No.");
                //LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Loan Balance",'>%1',0);
                if LoanGuaranteeDetails.Find('-') then begin
                    repeat
                        guarantors := guarantors + '::::' + LoanGuaranteeDetails."Loan No" + ':::' + Format(LoanGuaranteeDetails."Amont Guaranteed");
                    until LoanGuaranteeDetails.Next = 0;
                end;
            end;
        end;
    end;


    procedure ClientCodes(loanNo: Text[20]) codes: Text[20]
    begin
        begin
            LoansTable.Reset;
            LoansTable.SetRange(LoansTable."Loan  No.", loanNo);
            if LoansTable.Find('-') then begin
                codes := LoansTable."Client Code";
            end;
        end
    end;


    procedure ClientNames(ccode: Text[20]) names: Text[100]
    begin
        begin
            LoansTable.Reset;
            LoansTable.SetRange(LoansTable."Client Code", ccode);
            if LoansTable.Find('-') then begin
                Members.Reset;
                Members.SetRange(Members."No.", ccode);
                if Members.Find('-') then begin
                    names := Members.Name;
                end;
            end;
        end
    end;


    procedure ChargesGuarantorInfo(Phone: Text[20]; DocNumber: Text[20]) result: Text[250]
    begin
        begin
            SurePESATrans.Reset;
            SurePESATrans.SetRange(SurePESATrans."Document No", DocNumber);
            if SurePESATrans.Find('-') then begin
                result := 'REFEXISTS';
            end
            else begin
                result := '';
                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
                GenLedgerSetup.TestField(GenLedgerSetup."MOBILE Comm Account");
                GenLedgerSetup.TestField(GenLedgerSetup."Mobile banking Charge");

                Charges.Reset;
                Charges.SetRange(Charges.Code, GenLedgerSetup."Mobile banking Charge");
                if Charges.Find('-') then begin
                    Charges.TestField(Charges."GL Account");
                    MobileChargesACC := Charges."GL Account";
                end;

                SurePESACommACC := GenLedgerSetup."MOBILE Comm Account";
                SurePESACharge := Charges."Charge Amount";

                Members.Reset;
                Members.SetRange(Members."Phone No.", Phone);
                if Members.Find('-') then begin
                    Members.CalcFields(Members."Balance (LCY)");
                    //TempBalance:=Members."Balance (LCY)"-(Members."ATM Transactions"+Members."Uncleared Cheques"+Members."EFT Transactions");
                    fosaAcc := Members."No.";

                    if (TempBalance > SurePESACharge) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                        GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init;
                            GenBatches."Journal Template Name" := 'GENERAL';
                            GenBatches.Name := 'MOBILETRAN';
                            GenBatches.Description := 'Loan Guarantors Info';
                            GenBatches.Validate(GenBatches."Journal Template Name");
                            GenBatches.Validate(GenBatches.Name);
                            GenBatches.Insert;
                        end;

                        //Dr Mobile Charges
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                        GenJournalLine."Account No." := fosaAcc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := fosaAcc;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Loan Guarantors Info Charges';
                        GenJournalLine.Amount := SurePESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR Commission
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                        GenJournalLine."Account No." := SurePESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Loan Guarantors Info Charges';
                        GenJournalLine.Amount := -SurePESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                            repeat
                                GLPosting.Run(GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                        GenJournalLine.DeleteAll;

                        SurePESATrans.Init;
                        SurePESATrans."Document No" := DocNumber;
                        SurePESATrans.Description := 'Loan Guarantors Info';
                        SurePESATrans."Document Date" := Today;
                        SurePESATrans."Account No" := Members."No.";
                        SurePESATrans.Amount := amount;
                        SurePESATrans.Posted := true;
                        SurePESATrans."Posting Date" := Today;
                        SurePESATrans.Status := SurePESATrans.Status::Completed;
                        SurePESATrans.Comments := 'Success';
                        SurePESATrans.Client := Members."No.";
                        SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::Ministatement;
                        SurePESATrans."Transaction Time" := Time;
                        SurePESATrans.Insert;
                        result := 'TRUE';
                    end
                    else begin
                        result := 'INSUFFICIENT';
                    end;
                end
                else begin
                    result := 'ACCNOTFOUND';
                end;
            end;
        end;
    end;


    procedure RegisteredMemberDetailsUSSD(Phone: Text[20]; docNo: Text[30]) reginfo: Text[250]
    begin
        begin
            RanNo := Format(Random(10000));
            Members.Reset;
            Members.SetRange(Members."Mobile Phone No", Phone);
            if Members.Find('-') then begin
                reginfo := 'Member No: ' + Members."No." + ',  Name: ' + Members.Name + ',  ID No: ' + Format(Members."ID No.") + ',  Payroll No: ' + Members."Payroll/Staff No2" + ',  Email :' + Members."E-Mail";
                SMSMessage(RanNo + Members."No.", Members."No.", Phone, reginfo, '');
            end
            else begin
                reginfo := '';
            end
        end;
    end;


    procedure LoansGuaranteedUSSD(phone: Text[20]; docNo: Text[30]) guarantors: Text[1000]
    var
        Ran2: Text[20];
        newtext: Text[500];
    begin
        begin
            RanNo := Format(Random(10000));
            Ran2 := Format(Random(10000));
            Members.Reset;
            Members.SetRange(Members."Mobile Phone No", phone);
            if Members.Find('-') then begin
            end;
            LoanGuaranteeDetails.Reset;
            LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Member No", Members."No.");
            //LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Loan Balance",'>%1',0);
            if LoanGuaranteeDetails.Find('-') then begin
                repeat
                    guarantors := guarantors + LoanGuaranteeDetails."Loanees  Name" + '-(' + Format(LoanGuaranteeDetails."Amont Guaranteed") + '), ';
                until LoanGuaranteeDetails.Next = 0;
                newtext := guarantors;
                if StrLen(guarantors) > 220 then begin
                    guarantors := CopyStr(guarantors, 1, 220);
                    SMSMessage(RanNo + Members."No.", Members."No.", phone, 'LOANS GUARANTEED  ' + CopyStr(guarantors, 1, 220), '');
                    SMSMessage(Ran2 + Members."No.", Members."No.", phone, CopyStr(newtext, 221, StrLen(newtext)), '');
                end
                else begin
                    SMSMessage(RanNo + Members."No.", Members."No.", phone, 'LOANS GUARANTEED  ' + guarantors, '');
                end;
                guarantors := CopyStr(guarantors, 1, StrLen(guarantors) - 2);
            end;
        end;
    end;


    procedure LoanGuarantorsUSSD(loanNo: Text[20]; Phone: Text[20]; docNo: Text[30]) guarantors: Text[1000]
    var
        loantype: Text[30];
    begin
        begin
            LoansTable.Reset;
            LoansTable.SetRange(LoansTable."Loan  No.", loanNo);
            if LoansTable.Find('-') then begin
                loantype := LoansTable."Loan Product Type";
            end;

            RanNo := Format(Random(10000));
            LoanGuaranteeDetails.Reset;
            LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Loan No", loanNo);
            if LoanGuaranteeDetails.Find('-') then begin
                repeat
                    guarantors := guarantors + '::' + LoanGuaranteeDetails.Name + '(' + Format(LoanGuaranteeDetails."Amont Guaranteed") + ')';
                until LoanGuaranteeDetails.Next = 0;
                SMSMessage(RanNo + loanNo, Members."No.", Phone, 'GUARANTORS' + '(' + loantype + ')' + guarantors, '');
            end;
        end;
    end;


    procedure AccountBalanceUSSD(Phone: Code[30]; DocNumber: Code[20]) Bal: Text[50]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."Mobile Phone No", Phone);
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Share Capital");
                if MemberLedgerEntry.Find('-') then
                    repeat
                        amount := amount + MemberLedgerEntry.Amount;
                        Bal := Format(amount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
            end;
            SMSMessage(DocNumber, Members."No.", Phone, ' Your Account balance is Kshs: ' + Bal + ' Thank you for using Vision Sacco Mobile', '');
        end;
    end;


    procedure Accounts(phone: Text[20]; docNo: Text[30]) accounts: Text[1000]
    var
        sharecap: Text[50];
        deposit: Text[50];
        holiday: Text[50];
        property: Text[50];
        junior: Text[50];
        benevolent: Text[50];
    begin
        begin
            sharecap := ShareCapital(phone);
            if sharecap <> 'NULL' then begin
                sharecap := 'Share Capital= KES ' + sharecap;
                accounts := accounts + sharecap + ' , ';
            end;

            deposit := DepositContribution(phone);
            if deposit <> 'NULL' then begin
                deposit := 'Deposit Contribution= KES ' + deposit + ' ';
                accounts := accounts + deposit;
            end;

            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                Members.CalcFields(Members."Dividend Amount");
                //Members.CALCFIELDS(Members."Holiday Savings");
                //  Members.CALCFIELDS(Members."Kisiko Welfare");
                // Members.CALCFIELDS(Members."Withdrawable Savings");

                /*IF Members."Holiday Savings">0 THEN
                    accounts:=accounts+ ', Holiday Funds Ksh. ' + FORMAT(Members."Holiday Savings")
                ELSE
                  accounts:=accounts+ ', Holiday Funds Ksh. 0';*/

                if Members."Dividend Amount" > 0 then
                    accounts := accounts + ', Dividend Ksh. ' + Format(Members."Dividend Amount")
                else
                    accounts := accounts + ', Dividend Ksh. 0';


            end;


            // accounts:=COPYSTR(accounts, 1, STRLEN(accounts));
            SMSMessage(docNo, Members."No.", phone, 'Saving balance: ' + accounts, '');
            accounts := 'true';
        end;

    end;


    procedure FgetAccountstoDisplayApp(phone: Text[20]; docNo: Text[30]) accounts: Text
    var
        sharecap: Text[50];
        deposit: Text[50];
        holiday: Text[50];
        property: Text[50];
        junior: Text[50];
        benevolent: Text[50];
    begin
        begin
            sharecap := ShareCapital(phone);
            if sharecap <> 'NULL' then begin
                sharecap := 'Share Capital= KES ' + sharecap;
                accounts := accounts + sharecap + ' , ';
            end;

            deposit := DepositContribution(phone);
            if deposit <> 'NULL' then begin
                deposit := 'Deposit Contribution= KES ' + deposit + ' , ';
                accounts := accounts + deposit;
            end;


            accounts := CopyStr(accounts, 1, StrLen(accounts) - 3);
            SMSMessage(docNo, Members."No.", phone, 'Saving balance: ' + accounts, '');
            accounts := 'true';
        end;
    end;


    procedure BenevolentFund(phone: Text[20]) bal: Text[1000]
    var
        bvamount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Benevolent Fund");
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        bvamount := bvamount + MemberLedgerEntry.Amount;
                        bal := Format(bvamount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    bal := 'NULL';
                end;
            end;
        end;
    end;


    procedure DepositContribution(phone: Text[20]) bal: Text[250]
    var
        dcmount: Decimal;
    begin
        begin
            bal := '0';
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                Members.CalcFields(Members."Current Shares");
                bal := Format(Members."Current Shares");
            end;
        end;
    end;


    procedure ShareCapital(phone: Text[20]) bal: Text[1000]
    var
        samount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                Members.CalcFields(Members."Shares Retained");

                bal := Format(Members."Shares Retained");
            end else begin
                bal := '0';
            end;

        end;
    end;


    procedure SharesRetained(phone: Text[20]) bal: Text[1000]
    var
        samount: Decimal;
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Members."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Share Capital");
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        samount := samount + MemberLedgerEntry.Amount;
                        bal := Format(samount);
                    until MemberLedgerEntry.Next = 0;
                end
                else begin
                    bal := 'NULL';
                end;
            end;
        end;
    end;


    procedure CurrentShares(phone: Text[20]) bal: Text[1000]
    begin
        begin
            bal := '0';
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                Members.CalcFields(Members."Current Shares");

                bal := Format(Members."Current Shares");
            end;
        end;
    end;


    procedure OutstandingLoanName(phone: Text[20]) loannos: Text[200]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                LoansTable.Reset;
                LoansTable.SetRange(LoansTable."Client Code", Members."No.");
                if LoansTable.Find('-') then begin
                    repeat
                        LoansTable.CalcFields(LoansTable."Outstanding Balance", LoansTable."Interest Due", LoansTable."Interest to be paid", LoansTable."Interest Paid");
                        if (LoansTable."Outstanding Balance" > 0) then
                            loannos := loannos + ':::' + LoansTable."Loan  No.";
                    until LoansTable.Next = 0;
                end;
            end
        end;
    end;


    procedure MemberName(memNo: Text[20]) name: Text[200]
    begin
        begin
            Members.Reset;
            Members.SetRange(Members."No.", memNo);
            if Members.Find('-') then begin
                name := Members.Name;
            end
        end;
    end;


    procedure InsertTransaction("Document No": Code[30]; Keyword: Code[30]; "Account No": Code[30]; "Account Name": Text[100]; Telephone: Code[20]; Amount: Decimal; "Sacco Bal": Decimal; TransactionDate: Date) Result: Code[20]
    begin
        begin
            begin
                PaybillTrans.Init;
                PaybillTrans."Document No" := "Document No";
                PaybillTrans."Key Word" := Keyword;
                PaybillTrans."Account No" := CopyStr("Account No", 1, 20);
                PaybillTrans."Account Name" := "Account Name";
                PaybillTrans."Transaction Date" := Today;
                PaybillTrans."Transaction Time" := time;
                PaybillTrans.Description := 'PayBill Deposit';
                PaybillTrans.Telephone := Telephone;
                PaybillTrans.Amount := Amount;
                PaybillTrans."Paybill Acc Balance" := "Sacco Bal";
                PaybillTrans.Posted := false;
                PaybillTrans.Insert;
            end;
            PaybillTrans.Reset;
            PaybillTrans.SetRange(PaybillTrans."Document No", "Document No");
            if PaybillTrans.Find('-') then begin
                Result := 'TRUE';
            end
            else begin
                Result := 'FALSE';
                //  msg:='Dear ' +PaybillTrans."Account Name"+' ACC: '+PaybillTrans."Account No"+' has not been credited with KES.'+ FORMAT(Amount) +'because of wrong account format. Thank you for using Vision Sacco Mobile';
                // SMSMessage("Document No",PaybillTrans."Account No",'+'+PaybillTrans.Telephone,msg,'');
            end;
        end;
    end;


    procedure PaybillSwitch(receiptno: Text) Result: Code[20]
    var
        objvendor: Record Vendor;
    begin
        begin

            PaybillTrans.Reset;
            PaybillTrans.SetRange(PaybillTrans.Posted, false);
            PaybillTrans.SetRange("Document No", receiptno);
            PaybillTrans.SetRange(PaybillTrans."Needs Manual Posting", false);
            if PaybillTrans.Find('-') then begin

                objvendor.Reset();
                objvendor.SetRange(objvendor."Account Type", PaybillTrans."Account No");
                objvendor.SetRange(objvendor."Mobile Phone No", PaybillTrans.Telephone);
                if objvendor.Find('-') then begin
                    Result := PayBillToAcc('PAYBILL', PaybillTrans."Document No", objvendor."No.", objvendor."No.", PaybillTrans.Amount, PaybillTrans."Account No");

                end else begin
                    LoansRegister.Reset;
                    LoansRegister.SetRange(LoansRegister."Loan  No.", CopyStr(PaybillTrans."Account No", 1, 20));
                    if LoansRegister.Find('-') then begin
                        Result := PayBillToLoan('PAYBILL', PaybillTrans."Document No", PaybillTrans."Account No", PaybillTrans."Account No", PaybillTrans.Amount, 'ADVANCE');
                    end else begin
                        case PaybillTrans."Key Word" of

                            'DEP':
                                Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", PaybillTrans."Account No", PaybillTrans."Account No", PaybillTrans.Amount, PaybillTrans."Key Word", 'PayBill to Deposit Contribution');
                            'SHA':
                                Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", PaybillTrans."Account No", PaybillTrans."Account No", PaybillTrans.Amount, PaybillTrans."Key Word", 'PayBill to Share Capital');
                            'INV':
                                Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", CopyStr(PaybillTrans."Account No", 1, 20), CopyStr(PaybillTrans."Account No", 1, 20), PaybillTrans.Amount, PaybillTrans."Key Word", 'PayBill to Insurance');
                            'BEN':
                                Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", CopyStr(PaybillTrans."Account No", 1, 20), CopyStr(PaybillTrans."Account No", 1, 20), PaybillTrans.Amount, PaybillTrans."Key Word", 'PayBill to Insurance');
                            'WIT':
                                Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", CopyStr(PaybillTrans."Account No", 1, 20), CopyStr(PaybillTrans."Account No", 1, 20), PaybillTrans.Amount, PaybillTrans."Key Word", 'PayBill to Insurance');
                            'KIS':
                                Result := PayBillToBOSA('PAYBILL', PaybillTrans."Document No", CopyStr(PaybillTrans."Account No", 1, 20), CopyStr(PaybillTrans."Account No", 1, 20), PaybillTrans.Amount, PaybillTrans."Key Word", 'PayBill to Insurance');

                            else
                                PaybillTrans."Transaction Date" := Today;
                                PaybillTrans."Needs Manual Posting" := true;
                                PaybillTrans.Description := 'Failed';
                                PaybillTrans.Modify;
                        end;
                    end;
                end;
                if Result = '' then begin
                    PaybillTrans."Transaction Date" := Today;
                    PaybillTrans."Needs Manual Posting" := true;
                    PaybillTrans.Description := 'Failed';
                    PaybillTrans.Modify;
                end;
            end;
        end;
    end;

    local procedure PayBillToAcc(batch: Code[20]; docNo: Code[20]; accNo: Code[20]; memberNo: Code[20]; Amount: Decimal; accountType: Code[10]) res: Code[10]
    var
        objvendor: Record Vendor;
    begin
        begin
            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            //GenLedgerSetup.TestField(GenLedgerSetup."Mobile Comm Account");
            //GenLedgerSetup.TestField(GenLedgerSetup."Paybill Acc");
            PaybillRecon := 'BNK003';// GenLedgerSetup."Paybill Acc";

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", batch);
            GenJournalLine.DeleteAll;
            //end of deletion

            GenBatches.Reset;
            GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
            GenBatches.SetRange(GenBatches.Name, batch);

            if GenBatches.Find('-') = false then begin
                GenBatches.Init;
                GenBatches."Journal Template Name" := 'GENERAL';
                GenBatches.Name := batch;
                GenBatches.Description := 'Paybill Deposit';
                GenBatches.Validate(GenBatches."Journal Template Name");
                GenBatches.Validate(GenBatches.Name);
                GenBatches.Insert;
            end;//General Jnr Batches

            objvendor.Reset;
            objvendor.SetRange(objvendor."No.", accNo);
            if objvendor.Find('-') then begin
                /*  Members.RESET;
                  Members.SETRANGE(Members."No.", accNo);
                  Members.SETRANGE(Members."Account Type", accountType);
                    IF Members.FINDFIRST THEN BEGIN
                    */
                //Dr MPESA PAybill ACC
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := PaybillRecon;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := docNo;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Paybill Deposit';
                GenJournalLine.Amount := Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                //CR Excise Duty


                //Cr Customer
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := objvendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := docNo;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Paybill Deposit';
                GenJournalLine.Amount := -1 * Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", batch);
                if GenJournalLine.Find('-') then begin
                    repeat
                        GLPosting.Run(GenJournalLine);
                    until GenJournalLine.Next = 0;
                    PaybillTrans.Posted := true;
                    PaybillTrans."Transaction Date" := Today;
                    PaybillTrans.Description := 'Posted';
                    PaybillTrans.Modify;
                    res := 'TRUE';
                end
                else begin
                    PaybillTrans."Transaction Date" := Today;
                    PaybillTrans."Needs Manual Posting" := true;
                    PaybillTrans.Description := 'Failed';
                    PaybillTrans.Modify;
                    res := 'FALSE';
                end;
                //END;//Members
            end;//Member


        end;

    end;

    local procedure PayBillToBOSA(batch: Code[20]; docNo: Code[20]; accNo: Code[100]; memberNo: Code[100]; amount: Decimal; type: Code[100]; descr: Text[100]) res: Code[10]
    var
        InsuranceAmount: Decimal;
        MToday: Integer;
        MPayDate: Integer;
        MInsuranceBal: Decimal;
        TempBalance: Decimal;
    begin
        begin

            SaccoGenSetup.Reset;
            SaccoGenSetup.Get;
            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            //GenLedgerSetup.TestField(GenLedgerSetup."Paybill Acc");

            //SaccoGenSetup.TESTFIELD(SaccoGenSetup."Paybill Acc");
            PaybillRecon := 'BNK001';// GenLedgerSetup."Paybill Acc";

            ExcDuty := (10 / 100) * SurePESACharge;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name", batch);
            GenJournalLine.DeleteAll;

            //end of deletion

            GenBatches.Reset;
            GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
            GenBatches.SetRange(GenBatches.Name, batch);

            if GenBatches.Find('-') = false then begin
                GenBatches.Init;
                GenBatches."Journal Template Name" := 'GENERAL';
                GenBatches.Name := batch;
                GenBatches.Description := descr;
                GenBatches.Validate(GenBatches."Journal Template Name");
                GenBatches.Validate(GenBatches.Name);
                GenBatches.Insert;
            end;//General Jnr Batches

            Members.Reset;
            Members.SetRange(Members."No.", FnGetMemberNo(PaybillTrans.Telephone));
            if Members.Find('-') then begin
                // Members.CALCFIELDS(Members."Insurance Fund");

                MInsuranceBal := 0;//(MToday-MPayDate)*100;

                //Dr MPESA PAybill ACC
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := PaybillRecon;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := docNo;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Paybill from ' + PaybillTrans.Telephone + ' - ' + PaybillTrans."Account No";
                GenJournalLine.Amount := amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


                if amount > 0 then begin
                    //Cr Customer
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := batch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                    GenJournalLine."Account No." := Members."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := docNo;
                    GenJournalLine."Posting Date" := Today;
                    case PaybillTrans."Key Word" of
                        'DEP':
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                    end;
                    case PaybillTrans."Key Word" of
                        'SHA':
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    end;

                    /* CASE PaybillTrans."Key Word" OF 'HOL':
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Holiday Savings";
                     END;*/

                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    //  GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine.Description := 'Paybill from - ' + PaybillTrans.Telephone;
                    GenJournalLine.Amount := (amount - SurePESACharge - ExcDuty) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                end;

                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", batch);
                if GenJournalLine.Find('-') then begin
                    repeat
                        GLPosting.Run(GenJournalLine);
                    until GenJournalLine.Next = 0;
                    PaybillTrans.Posted := true;
                    PaybillTrans."Date Posted" := Today;
                    PaybillTrans.Description := 'Posted';
                    PaybillTrans.Modify;
                    res := 'TRUE';

                    if PaybillTrans."Key Word" = 'DEP' then begin
                        Members.CalcFields(Members."Current Shares");
                        TempBalance := Members."Current Shares";
                    end;
                    if PaybillTrans."Key Word" = 'SHARE' then begin
                        Members.CalcFields(Members."Shares Retained");
                        TempBalance := Members."Shares Retained";
                    end;

                    /*IF PaybillTrans."Key Word"='HOL' THEN BEGIN
                    Members.CALCFIELDS(Members."Holiday Savings");
                    TempBalance:=Members."Holiday Savings";
                    END;*/


                    msg := 'Dear ' + Members.Name + ' your: ' + PaybillTrans."Account No" + ' has been credited with Ksh' + Format(amount) + '. Your new balance is ' +
                    'Ksh. ' + Format(TempBalance) + '. Thank you for using Our Mobile Services';
                    SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');
                end
                else begin

                    PaybillTrans."Date Posted" := Today;
                    PaybillTrans."Needs Manual Posting" := true;
                    PaybillTrans.Description := 'Failed';
                    PaybillTrans.Modify;
                    res := 'FALSE';
                end;

                //  END;//Members
            end;//Member




        end;

    end;

    local procedure LoanRepaymentSchedule(varLoanNo: Integer; varPrincipalRepayment: Integer; varInterestRepayment: Integer; varTotalRepayment: Integer)
    begin
    end;


    procedure Guaranteefreeshares(phone: Text[20]) shares: Text[500]
    var
        LoanGuard: Record "Loans Guarantee Details";
        GenSetup: Record "Sacco General Set-Up";
        FreeShares: Decimal;
    begin
        begin
            GenSetup.Get();
            FreeShares := 0;
            glamount := 0;
            Members.Reset;
            Members.SetRange(Members."Mobile Phone No", phone);
            if Members.Find('-') then begin
                Members.CalcFields("Current Shares");
                LoanGuard.Reset;
                LoanGuard.SetRange(LoanGuard."Member No", Members."No.");
                LoanGuard.SetRange(LoanGuard.Substituted, false);
                if LoanGuard.Find('-') then begin
                    repeat
                        glamount := glamount + LoanGuard."Amont Guaranteed";
                    //MESSAGE('Member No %1 Account no %2',Members."No.",glamount);
                    until LoanGuard.Next = 0;
                end;
                //FreeShares:=(Members."Current Shares"*GenSetup."Free Share Multiplier")-glamount;
                shares := Format(FreeShares, 0, '<Precision,2:2><Integer><Decimals>');
            end;
        end;
    end;


    procedure Loancalculator(Loansetup: Text[500]) calcdetails: Text
    var
        Loanproducts: Text[500];
    begin
        begin
            LoanProducttype.Reset;
            //LoanProducttype.GET();
            LoanProducttype.SetFilter(LoanProducttype."Max. Loan Amount", '<>%1', 0);
            if LoanProducttype.Find('-') then begin
                //  LoanProducttype.CALCFIELDS(LoanProducttype."Interest rate",LoanProducttype."Max. Loan Amount",LoanProducttype."Min. Loan Amount");

                repeat

                    calcdetails := calcdetails + '::::' + Format(LoanProducttype."Product Description") + ':::' + Format(LoanProducttype."Interest rate") + ':::' + Format(LoanProducttype."No of Installment") + ':::' + Format(LoanProducttype."Max. Loan Amount")
                    + ':::' + Format(LoanProducttype."Repayment Method");
                until LoanProducttype.Next = 0;
                //MESSAGE('Loan Balance %1',loanbalances);
                // calcdetails:=varLoan;

            end;
        end;
    end;


    procedure OutstandingLoansUSSD(phone: Code[20]) loanbalances: Text[1024]
    begin
        begin
            Members.SetRange(Members."No.", FnGetMemberNo(phone));
            if Members.Find('-') then begin
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Client Code", Members."No.");
                if LoansRegister.Find('-') then begin
                    repeat
                        LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Outstanding Interest", LoansRegister."Interest to be paid", LoansRegister."Interest Paid");
                        if (LoansRegister."Outstanding Balance" > 0) then
                            loanbalances := loanbalances + '::::' + LoansRegister."Loan  No." + ':::' + LoansRegister."Loan Product Type Name" + ':::' +
                             Format(LoansRegister."Outstanding Balance") + ':::' +
                              Format(LoansRegister."Outstanding Interest");
                    until LoansRegister.Next = 0;
                end;
                //  LoansRegister.SETRANGE(LoansRegister."Client Code",Members."No.");

            end;
        end;
    end;


    procedure InsertCoopTran(memberno: Code[250]; totalamt: Decimal; addinfo: Code[250]; accNo: Code[250]; accName: Code[250]; InstCode: Code[250]; instName: Code[250]; refernceCode: Code[250]; messageID: Code[250]) resut: Code[50]
    var
        batch: Code[20];
        docNo: Code[50];
        SharesAmount: Decimal;
        DepositAmount: Decimal;
        RegfeeAmount: Decimal;
        InsuranceAmount: Decimal;
        SaccoGenSetUp: Record "Sacco General Set-Up";
        OutstInsuranceAmount: Decimal;
        Totalshares: Decimal;
        TotalRegFee: Decimal;
        RemainedShares: Decimal;
        RemainedRegistration: Decimal;
        LastPaydate: Date;
        PayDateDiff: Date;
        MPayDate: Decimal;
        MToday: Decimal;
        MInsuranceBal: Decimal;
    begin
        /*CoopbankTran.RESET;
         IF CoopbankTran.FIND('+') THEN BEGIN
            iEntryNo:=CoopbankTran.TranID;
            iEntryNo:=iEntryNo+1;
            END
            ELSE BEGIN
            iEntryNo:=1;
            END;
            amount:=totalamt;
            CoopbankTran.INIT;
            CoopbankTran."Reference Code":=refernceCode;
            CoopbankTran."Account Name":=instName;
            CoopbankTran."Account No":=accNo;
            CoopbankTran."Additional info":=addinfo;
            CoopbankTran.Currency:=CoopbankTran.Currency::KES;
            CoopbankTran.TranID:=iEntryNo;
            CoopbankTran."Member No":=memberno;
            CoopbankTran."Transaction Date":=TODAY;
            CoopbankTran."Total Amount":=totalamt;
            CoopbankTran."Institution Code":=InstCode;
            CoopbankTran."Institution Name":='­MOJA SACCO';
            CoopbankTran.MessageID:=messageID;
            CoopbankTran."Bank Reference code":=messageID;
            CoopbankTran."Transaction Time":=CURRENTDATETIME;
            CoopbankTran.Comments:='LIVE';
            CoopbankTran.INSERT;
        */

    end;

    local procedure PayBillToLoan(batch: Code[20]; docNo: Code[20]; accNo: Code[20]; memberNo: Code[20]; amount: Decimal; type: Code[30]) res: Code[10]
    var
        InterestAmount: Decimal;
        InsuranceAmount: Decimal;
        MToday: Integer;
        MPayDate: Integer;
        MInsuranceBal: Decimal;
    begin
        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;


        // GenLedgerSetup.TestField(GenLedgerSetup."Paybill Acc");
        PaybillRecon := 'BNK001';// GenLedgerSetup."Paybill Acc";
        loanamt := amount;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", batch);
        GenJournalLine.DeleteAll;
        //end of deletion

        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
        GenBatches.SetRange(GenBatches.Name, batch);

        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'GENERAL';
            GenBatches.Name := batch;
            GenBatches.Description := 'Paybill Loan Repayment';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
        end;//General Jnr Batches


        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Loan  No.", PaybillTrans."Account No");
        // LoansRegister.SETRANGE(LoansRegister."Client Code",memberNo);

        if LoansRegister.Find('-') then begin
            Members.Reset;
            Members.SetRange(Members."No.", LoansRegister."Client Code");
            if Members.Find('-') then begin

                LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Outstanding Interest");
                if LoansRegister."Outstanding Balance" > 0 then begin

                    //Dr MPESA PAybill ACC
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := batch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := PaybillRecon;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := docNo;
                    GenJournalLine."Source No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Paybill Loan Repayment';
                    GenJournalLine.Amount := amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    if amount > 0 then begin
                        if LoansRegister."Outstanding Interest" > 0 then begin
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := batch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            GenJournalLine."Account No." := LoansRegister."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := docNo;
                            GenJournalLine."External Document No." := docNo;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Loan Interest Payment';
                            if amount > LoansRegister."Outstanding Interest" then
                                InterestAmount := -LoansRegister."Outstanding Interest"
                            else
                                InterestAmount := -amount;
                            GenJournalLine.Amount := InterestAmount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                            if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                            end;

                            /*  GenSetUp.RESET;
                              GenSetUp.GET;
                              LoanProductsSetup.RESET;

                              IF LoanProductsSetup.GET(LoansRegister."Loan Product Type") THEN BEGIN
                                  VarReceivableAccount:=LoanProductsSetup."Receivable Interest Account";
                             //------------------------------------1. DEBIT INTEREST RECEIVABLE CONTROL A/C---------------------------------------------------------------------------------------------
                              LineNo:=LineNo+10000;
                              SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::" ",
                              GenJournalLine."Account Type"::"G/L Account",GenSetUp."A/c Interest Receivable",TODAY,InterestAmount,'BOSA',LoansRegister."Loan  No.",
                              'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                              //--------------------------------(Debit Member Loan Account)---------------------------------------------

                              //------------------------------------2. CREDIT MEMBER INTEREST RECEIVABLE A/C---------------------------------------------------------------------------------------------
                              LineNo:=LineNo+10000;
                              SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::"Interest Due",
                              GenJournalLine."Account Type"::"G/L Account",VarReceivableAccount,TODAY,InterestAmount*-1,'BOSA',LoansRegister."Loan  No.",
                              'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                              //----------------------------------(CREDIT MEMBER INTEREST RECEIVABLE A/C-)------------------------------------------------

                              END;
                              */
                            amount := amount + GenJournalLine.Amount;
                        end;
                    end;

                    if amount > 0 then begin
                        if LoansRegister."Outstanding Balance" > 0 then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := batch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            GenJournalLine."Account No." := LoansRegister."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := docNo;
                            GenJournalLine."External Document No." := '';
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Paybill Loan Repayment';

                            if amount >= LoansRegister."Outstanding Balance" then
                                GenJournalLine.Amount := -LoansRegister."Outstanding Balance"
                            else
                                GenJournalLine.Amount := -amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Repayment;
                            if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            end;
                            GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                            if GenJournalLine.Amount <> 0 then begin
                                GenJournalLine.Insert;
                                amount := amount + GenJournalLine.Amount;
                            end;//gen journal
                        end;  //loan balance
                    end;//amount
                        //======================================Deposit contribution
                    if amount > 0 then begin
                        //Cr Customer
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := batch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        GenJournalLine."Account No." := Members."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := docNo;
                        GenJournalLine."External Document No." := docNo;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Description := Format(GenJournalLine."transaction type"::"Deposit Contribution");
                        GenJournalLine.Amount := (amount) * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        amount := amount + GenJournalLine.Amount;
                    end;
                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", batch);
                    if GenJournalLine.Find('-') then begin
                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                        LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Outstanding Interest");
                        msg := 'Dear ' + Members.Name + ' your  ' + LoansRegister."Loan Product Type Name" + ' has been credited with Ksh. ' + Format(loanamt) + ' on ' + Format(PaybillTrans."Transaction Date") + '. Your ' +
                        'new loan balance is Ksh. ' + Format(LoansRegister."Outstanding Balance" + LoansRegister."Outstanding Interest") + '. Thank you for using Our Mobile Services';
                        SMSMessage('PAYBILLTRANS', Members."No.", Members."Mobile Phone No", msg, '');

                        PaybillTrans.Posted := true;
                        PaybillTrans."Date Posted" := Today;
                        PaybillTrans.Description := 'Posted';
                        PaybillTrans.Modify;
                        res := 'TRUE';
                    end
                    else begin
                        PaybillTrans."Date Posted" := Today;
                        PaybillTrans."Needs Manual Posting" := true;
                        PaybillTrans.Description := 'Failed';
                        PaybillTrans.Modify;
                        res := 'FALSE';
                    end;

                end//Outstanding Balance
            end//Loan Register
               // END;//Members
        end;//Member

    end;


    procedure GetTranaccDetails() result: Code[250]
    begin
        /*CoopbankTran.RESET;
        CoopbankTran.SETRANGE(CoopbankTran.posted,FALSE);
        IF CoopbankTran.FIND('-') THEN BEGIN
          result:=CoopbankTran."Reference Code"+':::'+CoopbankTran."Account No";
          END;
          */

    end;


    procedure getAccountDetails(AccountNo: Code[50]) result: Code[250]
    begin
        Members.Reset;
        Members.SetRange(Members."No.", AccountNo);
        if Members.Find('-') then begin

            result := Members.Name;
        end;
    end;


    procedure getAccountNameD(aCCNO: Code[250]) result: Code[1000]
    begin
        Members.Reset;
        Members.SetRange(Members."No.", aCCNO);
        if Members.Find('-') then begin

            result := Members.Name;
        end;
    end;


    procedure GetMessageID(MessageID: Code[50]) Result: Code[50]
    begin
        /*CoopbankTran.RESET;
        CoopbankTran.SETRANGE(CoopbankTran.MessageID,MessageID);
        IF CoopbankTran.FIND('-') THEN BEGIN
          Result:='TRUE';
          END ELSE BEGIN
             Result:='FALSE';
            END;
        */

    end;


    procedure POSTCoopTran() resut: Code[50]
    var
        batch: Code[20];
        docNo: Code[50];
        SharesAmount: Decimal;
        DepositAmount: Decimal;
        RegfeeAmount: Decimal;
        InsuranceAmount: Decimal;
        SaccoGenSetUp: Record "Sacco General Set-Up";
        OutstInsuranceAmount: Decimal;
        Totalshares: Decimal;
        TotalRegFee: Decimal;
        RemainedShares: Decimal;
        RemainedRegistration: Decimal;
        LastPaydate: Date;
        PayDateDiff: Date;
        MPayDate: Decimal;
        MToday: Decimal;
        MInsuranceBal: Decimal;
        DocNoLength: Decimal;
        BankRefCode: Code[100];
        TotalAmount: Decimal;
        TransactionLoanAmt: Decimal;
        TransactionLoanDiff: Decimal;
        RepayedLoanAmt: Decimal;
        DateRegistered: Date;
        MtodayYear: Decimal;
        RegYear: Decimal;
        MtodayDiff: Decimal;
        MRegdate: Decimal;
        LoanRepaymentS: Record "Loan Repayment Schedule";
        PrincipalAmount: Decimal;
        PY: Decimal;
        PM: Decimal;
        PD: Decimal;
        Fulldate: Date;
        LastRepayDate: Date;
        InterestAmount: Decimal;
        YearDiff: Integer;
        MonthCounter: Integer;
        MonthyContribution: Decimal;
        Monthycontributionbal: Decimal;
        LoanPayment: Record "Loan Repayment Schedule";
        Totalprinciple: Decimal;
    begin
        /*CoopbankTran.RESET;
        CoopbankTran.SETRANGE(CoopbankTran.posted,FALSE);
        CoopbankTran.SETRANGE(CoopbankTran."Needs Manual Posting",FALSE);
        IF CoopbankTran.FIND('-') THEN BEGIN
        
            Members.RESET;
            Members.SETRANGE(Members."No.", CoopbankTran."Account No");
            Members.SETFILTER(Members.Blocked,'<>%1', Members.Blocked::" ");
            IF Members.FIND('-') THEN BEGIN
              CoopbankTran."Needs Manual Posting":=TRUE;
              CoopbankTran.MODIFY;
              EXIT;
              END;
        
        
          SaccoGenSetUp.RESET;
          SaccoGenSetUp.GET;
          amount:=CoopbankTran."Total Amount";
          TotalAmount:=CoopbankTran."Total Amount";
          SaccoGenSetUp.TESTFIELD(SaccoGenSetUp."COOP ACC");
          PaybillRecon:=SaccoGenSetUp."COOP ACC";//'100857';
        SaccoGenSetUp.RESET;
        SaccoGenSetUp.GET;
        SaccoGenSetUp.TESTFIELD("Insurance Payable A/c");
        SaccoGenSetUp.TESTFIELD("Retained Shares");
        SaccoGenSetUp.TESTFIELD("Registration Fee");
        
        Totalshares:=SaccoGenSetUp."Retained Shares";
        TotalRegFee:=SaccoGenSetUp."Registration Fee";
        
          batch:='COOPDEPOST';
          docNo:=CoopbankTran."Bank Reference code";
          BankRefCode:=CoopbankTran."Bank Reference code";
        
          DocNoLength:=STRLEN(docNo); //get length of doc number
          IF DocNoLength>20 THEN BEGIN
            docNo:=COPYSTR(BankRefCode,1,12);
        
          END ELSE BEGIN
             docNo:=BankRefCode;
          END;
        
           GenSetUp.RESET;
                GenSetUp.GET;
        
          GenJournalLine.RESET;
          GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
          GenJournalLine.SETRANGE("Journal Batch Name",batch);
          GenJournalLine.DELETEALL;
          //end of deletion
        
          LoanPayment.RESET;
          LoanPayment.DELETEALL;
        
        
          GenBatches.RESET;
          GenBatches.SETRANGE(GenBatches."Journal Template Name",'GENERAL');
          GenBatches.SETRANGE(GenBatches.Name,batch);
        
          IF GenBatches.FIND('-') = FALSE THEN BEGIN
            GenBatches.INIT;
            GenBatches."Journal Template Name":='GENERAL';
            GenBatches.Name:=batch;
            GenBatches.Description:='Coop deposits';
            GenBatches.VALIDATE(GenBatches."Journal Template Name");
            GenBatches.VALIDATE(GenBatches.Name);
            GenBatches.INSERT;
          END;//General Jnr Batches
        
        //========================share capital
        Members.RESET;
        Members.SETRANGE(Members."No.",CoopbankTran."Member No");
          IF Members.FIND('-') THEN BEGIN
              MemberLedgerEntry.RESET;
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Customer No.",Members."No.");
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::"Share Capital");
              MemberLedgerEntry.CALCSUMS(MemberLedgerEntry.Amount);
              SharesAmount:=MemberLedgerEntry.Amount;
           END;
        
        //========================registration
        Members.RESET;
        Members.SETRANGE(Members."No.",CoopbankTran."Member No");
          IF Members.FIND('-') THEN BEGIN
              MemberLedgerEntry.RESET;
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Customer No.",Members."No.");
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::"Registration Fee");
              MemberLedgerEntry.CALCSUMS(MemberLedgerEntry.Amount);
              RegfeeAmount:=MemberLedgerEntry.Amount;
           END;
        
        //========================insurance contribution arrears
        Members.RESET;
        Members.SETRANGE(Members."No.",CoopbankTran."Member No");
          IF Members.FIND('-') THEN BEGIN
             Members.CALCFIELDS(Members."Insurance Fund");
              InsuranceAmount:=Members."Insurance Fund";
             // MInsuranceBal:=Members."Insurance Monthly contribution";
           END;
        
        MInsuranceBal:=0;
        
        Members.RESET;
        Members.SETRANGE(Members."No.",CoopbankTran."Member No");
        IF Members.FIND('-') THEN BEGIN
          DateRegistered:=Members."Registration Date";
        END;
        
        IF DateRegistered <>0D THEN BEGIN
        
        RegYear := DATE2DMY(DateRegistered, 3);
        MRegdate := DATE2DMY(DateRegistered, 2);
        
        
        MtodayYear := DATE2DMY(TODAY, 3);
        MToday := DATE2DMY(TODAY, 2);
        
        IF RegYear=MtodayYear THEN BEGIN
        
          // MPayDate:=MToday-MRegdate;
            MPayDate:=(ABS( InsuranceAmount))/100;
          MInsuranceBal:=((MToday-MRegdate)-MPayDate)*100;
          END ELSE BEGIN
        
             MPayDate:=(ABS( InsuranceAmount))/100;
             MInsuranceBal:=(MToday-MPayDate)*100;
        
          END;
        
        END;
        
        //===================minimum monthy contribution
        
        
        Members.RESET;
        Members.SETRANGE(Members."No.",CoopbankTran."Member No");
          IF Members.FIND('-') THEN BEGIN
        
            Monthycontributionbal:=0;
        
             MonthyContribution:=Members."Monthly Contribution";
            IF MonthyContribution=0 THEN BEGIN
              MonthyContribution:=GenSetUp."Min. Contribution";
            END;
        
              MemberLedgerEntry.RESET;
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Customer No.",Members."No.");
              MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::"Deposit Contribution");
              MemberLedgerEntry.SETFILTER(MemberLedgerEntry."Posting Date", FORMAT(CALCDATE('CM + 1D - 1M',TODAY))+'..'+FORMAT(CALCDATE('CM',TODAY)));
              MemberLedgerEntry.CALCSUMS(MemberLedgerEntry."Credit Amount");
              Monthycontributionbal:=MonthyContribution- ABS(MemberLedgerEntry."Credit Amount");
           END;
        
        
        
        IF (RegfeeAmount*-1)>=TotalRegFee THEN BEGIN
          RemainedRegistration:=0;
        END ELSE BEGIN
          RemainedRegistration:=0;//TotalRegFee-(RegfeeAmount*-1);
        
        END;
        
        
        
        IF (SharesAmount*-1)>=Totalshares THEN BEGIN
          RemainedShares:=0;
        END ELSE BEGIN
          RemainedShares:=Totalshares-(SharesAmount*-1);
        END;
        Members.LOCKTABLE;
            Members.RESET;
            Members.SETRANGE(Members."No.", CoopbankTran."Account No");
            Members.SETRANGE(Members.Blocked, Members.Blocked::" ");
            IF Members.FIND('-') THEN BEGIN
        
        //================================================================Dr COOP settlement ACC
                LineNo:=LineNo+10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."Account Type"::"Bank Account";
                GenJournalLine."Account No.":=PaybillRecon;
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                 GenJournalLine."Source No.":=Members."No.";
                GenJournalLine."Posting Date":=TODAY;
                GenJournalLine.Description:='Coop Deposits' ;
                GenJournalLine.Amount:=amount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount<>0 THEN
                GenJournalLine.INSERT;
        
        //===================================Registration fees
        IF amount>0 THEN BEGIN
              //Cr Customer
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Registration Fee";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=FORMAT(GenJournalLine."Transaction Type"::"Registration Fee");
                      IF amount >= RemainedRegistration THEN
                      GenJournalLine.Amount:=-RemainedRegistration
                      ELSE
                      GenJournalLine.Amount:=-amount;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                      amount:=amount+GenJournalLine.Amount;
          END;
        
        //===================================Share Capital
        IF RemainedShares>0 THEN BEGIN
        IF amount>0 THEN BEGIN
              //Cr Customer
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=FORMAT(GenJournalLine."Transaction Type"::"Share Capital");
                      IF amount >= RemainedShares THEN
                      GenJournalLine.Amount:=-RemainedShares
                      ELSE
                      GenJournalLine.Amount:=-amount;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                      amount:=amount+GenJournalLine.Amount;
          END;
        END;
        
        
        //================================insurance
        IF MInsuranceBal>0 THEN BEGIN
        IF amount>0 THEN BEGIN
              //Cr Customer
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Insurance Contribution";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=FORMAT(GenJournalLine."Transaction Type"::"Insurance Contribution");
                      IF amount > MInsuranceBal THEN
                      GenJournalLine.Amount:=-MInsuranceBal
                      ELSE
                      GenJournalLine.Amount:=-amount;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                      amount:=amount+GenJournalLine.Amount;
          END;
        END;
        
        
        //================================check minimum contribution monthly
        IF Monthycontributionbal>0 THEN BEGIN
        IF amount>0 THEN BEGIN
              //Cr Customer
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution");
                      IF amount >= Monthycontributionbal THEN
                      GenJournalLine.Amount:=-Monthycontributionbal
                      ELSE
                      GenJournalLine.Amount:=-amount;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                      amount:=amount+GenJournalLine.Amount;
          END;
        END;
        
        //===============================================================check any outstanding loan
        
                LoansRegister.RESET;
                LoansRegister.SETRANGE(LoansRegister."Client Code",Members."No.");
                IF LoansRegister.FIND('-') THEN BEGIN
        
               REPEAT
                 PrincipalAmount:=0;
                 TransactionLoanDiff:=0;
                  LoansRegister.CALCFIELDS(LoansRegister."Outstanding Interest",LoansRegister."Outstanding Balance");
               IF  (LoansRegister."Outstanding Balance">0)  THEN BEGIN
        
                LoanRepaymentS.RESET;
                LoanRepaymentS.SETRANGE(LoanRepaymentS."Loan No.",LoansRegister."Loan  No.");
                IF LoanRepaymentS.FIND('-') THEN BEGIN
                  REPEAT
        
                       Fulldate:= DMY2DATE(DATE2DMY(20110528D,1),DATE2DMY(TODAY,2),DATE2DMY(TODAY,3));
                       LastRepayDate:= DMY2DATE(DATE2DMY(20110528D,1),DATE2DMY(LoanRepaymentS."Repayment Date",2),DATE2DMY(LoanRepaymentS."Repayment Date",3));
        
                     IF Fulldate>=LastRepayDate THEN BEGIN
                       PrincipalAmount:= PrincipalAmount+LoanRepaymentS."Principal Repayment";
                       END;
                     //  EXIT
                   UNTIL LoanRepaymentS.NEXT=0;
                END;
        
        
                MemberLedgerEntry.RESET;
                MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Loan No",LoansRegister."Loan  No.");
                MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."Transaction Type"::Repayment);
                MemberLedgerEntry.CALCSUMS(MemberLedgerEntry."Credit Amount (LCY)");
                TransactionLoanAmt:=MemberLedgerEntry."Credit Amount (LCY)";
        
                MESSAGE(FORMAT(TransactionLoanAmt));
                 MESSAGE(FORMAT(PrincipalAmount));
        
                TransactionLoanDiff:=PrincipalAmount-TransactionLoanAmt;
        
                IF TransactionLoanDiff>0 THEN BEGIN
                  RepayedLoanAmt:=TransactionLoanDiff;
                  END ELSE BEGIN
                   RepayedLoanAmt:=0;
                END;
        
          //==========================interest
        
                IF LoansRegister."Outstanding Interest">0 THEN BEGIN
        
                 IF amount>0 THEN BEGIN
                LineNo:=LineNo+10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                GenJournalLine."Account No.":=LoansRegister."Client Code";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                GenJournalLine."Posting Date":=TODAY;
                GenJournalLine.Description:='Loan Interest Payment';
        
                IF amount > LoansRegister."Outstanding Interest" THEN
                 InterestAmount:=-LoansRegister."Outstanding Interest"
                ELSE
                InterestAmount:=-amount;
        
                GenJournalLine.Amount:=InterestAmount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
        
                IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
                GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                END;
                GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                IF GenJournalLine.Amount<>0 THEN
                GenJournalLine.INSERT;
                amount:=amount+GenJournalLine.Amount;
        
        
                LoanProductsSetup.RESET;
        
                IF LoanProductsSetup.GET(LoansRegister."Loan Product Type") THEN BEGIN
                    VarReceivableAccount:=LoanProductsSetup."Receivable Interest Account";
               //------------------------------------1. DEBIT INTEREST RECEIVABLE CONTROL A/C---------------------------------------------------------------------------------------------
                LineNo:=LineNo+10000;
                SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::" ",
                GenJournalLine."Account Type"::"G/L Account",GenSetUp."A/c Interest Receivable",TODAY,InterestAmount*-1,'BOSA',LoansRegister."Loan  No.",
                'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                //--------------------------------(Debit Member Loan Account)---------------------------------------------
        
                //------------------------------------2. CREDIT MEMBER INTEREST RECEIVABLE A/C---------------------------------------------------------------------------------------------
                LineNo:=LineNo+10000;
                SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::"Interest Due",
                GenJournalLine."Account Type"::"G/L Account",VarReceivableAccount,TODAY,InterestAmount,'BOSA',LoansRegister."Loan  No.",
                'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                //----------------------------------(CREDIT MEMBER INTEREST RECEIVABLE A/C-)------------------------------------------------
        
        
                END;//loan product type
                END;// amount
                END;// outstanding interest
        
        //==========================principal
        IF LoansRegister."Outstanding Balance">0 THEN BEGIN
        
                IF amount>0 THEN BEGIN
        
                LineNo:=LineNo+10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                GenJournalLine."Account No.":=LoansRegister."Client Code";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                GenJournalLine."Posting Date":=TODAY;
                GenJournalLine.Description:='Loan Repayment';
                 IF amount >= RepayedLoanAmt THEN BEGIN
                GenJournalLine.Amount:=-RepayedLoanAmt;
                   Totalprinciple:=RepayedLoanAmt;
                 END ELSE BEGIN
                  GenJournalLine.Amount:=-amount;
                  Totalprinciple:=-amount;
                 END;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
                IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
                GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                END;
                GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                IF GenJournalLine.Amount<>0 THEN BEGIN
                GenJournalLine.INSERT;
                amount:=amount+ GenJournalLine.Amount;
        
                END;
                 LoanPayment.RESET;
                 IF LoanPayment.FIND('+') THEN BEGIN
                iEntryNo:=LoanPayment."Entry no";
                iEntryNo:=iEntryNo+1;
                END
                ELSE BEGIN
                iEntryNo:=1;
                END;
                LoanPayment.INIT;
                LoanPayment."Entry no":=iEntryNo;
                LoanPayment.Member:=Members."No.";
                LoanPayment."Loan No":=LoansRegister."Loan  No.";
                LoanPayment."Outstanding bal":=LoansRegister."Outstanding Balance";
                LoanPayment.OutPaid:=Totalprinciple;
                LoanPayment."Remaining bal":=ABS(LoansRegister."Outstanding Balance")-ABS(Totalprinciple);
                LoanPayment.INSERT;
                END;
            END;
        
        END;
        UNTIL LoansRegister.NEXT=0;
        END;
        
        
        //===============================================================pay all loans outstanding
        
                LoanPayment.RESET;
                LoanPayment.SETASCENDING(LoanPayment."Entry no", TRUE);
                LoanPayment.SETRANGE(LoanPayment.Member,Members."No.");
                IF LoanPayment.FIND('-') THEN BEGIN
        
               REPEAT
                //  LoansRegister.CALCFIELDS(LoansRegister."Outstanding Interest",LoansRegister."Outstanding Balance");
               IF  (LoanPayment."Remaining bal">0)  THEN BEGIN
        
                IF amount>0 THEN BEGIN
                LineNo:=LineNo+10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                GenJournalLine."Account No.":=Members."No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                GenJournalLine."Posting Date":=TODAY;
                GenJournalLine.Description:='Loan Repayment';
                 IF amount >= LoanPayment."Remaining bal" THEN
                GenJournalLine.Amount:=-LoanPayment."Remaining bal"
                ELSE
                GenJournalLine.Amount:=-amount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
                IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
                GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                END;
                GenJournalLine."Loan No":=LoanPayment."Loan No";
                IF GenJournalLine.Amount<>0 THEN BEGIN
                GenJournalLine.INSERT;
                amount:=amount+ GenJournalLine.Amount;
                END;
                END;
                END;
                UNTIL LoansRegister.NEXT=0;
        END;
        
        
        
        
        
        //======================================Deposit contribution
        IF amount>0 THEN BEGIN
              //Cr Customer
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=TODAY;
                      GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution");
                      GenJournalLine.Amount:=(amount)*-1;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                      amount:=amount+GenJournalLine.Amount;
          END;
        
        
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                    GenJournalLine.SETRANGE("Journal Batch Name",batch);
                    IF GenJournalLine.FIND('-') THEN BEGIN
                    REPEAT
                     GLPosting.RUN(GenJournalLine);
                    UNTIL GenJournalLine.NEXT = 0;
                      msg:='Dear ' +SplitString(Members.Name,' ')+', your deposit of Ksh. '+ FORMAT(TotalAmount) +' at '+FORMAT(CURRENTDATETIME)+' Reference No. '+docNo+
                      ' from Coop Bank have been credited to your account. Check your online statement for more details';
                      SMSMessage(batch,Members."No.",Members."Phone No.",msg,'');
                      CoopbankTran."Bank Reference code":=docNo;
                      CoopbankTran.posted:=TRUE;
                      CoopbankTran."Date Posted":=TODAY;
                      CoopbankTran.MODIFY;
                      resut:='TRUE';
        
                    END
                    ELSE BEGIN
                      CoopbankTran."Date Posted":=TODAY;
                      CoopbankTran."Needs Manual Posting":=TRUE;
                      CoopbankTran.MODIFY;
                     resut:='FALSE';
                    END;
        
        
        END;
        END;
        */

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

    local procedure FnsentSMS()
    var
        SharesAmount: Decimal;
        Totalshares: Decimal;
        RemainedShares: Decimal;
    begin
        Members.Reset;
        Members.SetRange(Members."Certificate No", '');
        if Members.Find('-') then begin
            repeat
                if (Members.Status = Members.Status::Active) or (Members.Status = Members.Status::Dormant) then begin
                    if Members."Mobile Phone No" <> '' then begin
                        msg := 'Dear ' + SplitString(Members.Name, ' ') + ', Our online payment service Digipesa App and USSD *850# and Web-portal are now up and running well . We apologize for the inconvience caused.';
                        SMSMessage('BULKSMS', Members."No.", Members."Mobile Phone No", CopyStr(msg, 1, 250), CopyStr(msg, 251, 500));
                    end;
                end;
            until Members.Next = 0;
            Message('DONE');
        end;
        //========================share capital
    end;


    procedure AdvanceEligibility(account: Text[50]; period: Integer; VAR Qualfiedamount: Decimal) Res: Text
    var
        StoDedAmount: Decimal;
        STO: Record "Standing Orders";
        FOSALoanRepayAmount: Decimal;
        CumulativeNet: Decimal;
        LastSalaryDate: Date;
        FirstSalaryDate: Date;
        AvarageNetPay: Decimal;
        AdvQualificationAmount: Decimal;
        CumulativeNet2: Decimal;
        finalAmount: Decimal;
        interestAMT: Decimal;
        MaxLoanAmt: Decimal;
        LastPaydate: Date;
        MPayDate: Decimal;
        MToday: Decimal;
        DateRegistered: Date;
        MtodayYear: Decimal;
        RegYear: Decimal;
        MtodayDiff: Decimal;
        MRegdate: Decimal;
        ComittedShares: Decimal;
        LoanGuarantors: Record "Loans Guarantee Details";
        FreeShares: Decimal;
        TotalAmount: Decimal;
        TransactionLoanAmt: Decimal;
        TransactionLoanDiff: Decimal;
        RepayedLoanAmt: Decimal;
        LoanRepaymentS: Record "Loan Repayment Schedule";
        Fulldate: Date;
        LastRepayDate: Date;
        PrincipalAmount: Decimal;
        OutsandingLoans: Decimal;
        OustandingInterest: Decimal;
        previousAMT: Decimal;
        creditlogs: Record "Credit limit logs";
    begin

        amount := 0;
        //=================================================must be member for 6 months
        Members.Reset;
        Members.SetRange(Members."No.", account);
        if Members.FindFirst() then begin
            DateRegistered := Members."Registration Date";
            Members.CalcFields("Current Shares");
            Members.CalcFields("Shares Retained");


            if Members.BlackListed = Members.BlackListed::Yes then begin
                Res := '{"success":false,';
                Res += '"description":"Your Account is in Default due to defaulted utapesa loan",';
                Res += '"amount":0}';
                Qualfiedamount := 0;
                exit;
            end;

            if Members.Status <> Members.Status::Active then begin
                Res := '{"success":false,';
                Res += '"description":"Your Account is not active kindly contact the sacco for more information",';
                Res += '"amount":0}';
                Qualfiedamount := 0;
                exit;
            end;

            if Members."Loan Status" <> Members."Loan Status"::Active then begin
                Res := '{"success":false,';
                Res += '"description":"Your Account is not active",';
                Res += '"amount":0}';
                exit;
            end;

            if Members."Current Shares" < 2000 then begin
                Res := '{"success":false,';
                Res += '"description":"Your deposits is less that Ksh. 2,000",';
                Res += '"amount":0}';
                Qualfiedamount := 0;
                exit;
            end;

            // if Members."Shares Retained" < 15000 then begin
            //     Res := '{"success":false,';
            //     Res += '"description":"You need to have share capital of above Kshs: 15,000 to access utapesa loan,';
            //     Res += '"amount":0}';
            //     exit;
            // end;
            // Members.CalcFields(Members."Dormant Date")

            if DateRegistered <> 0D then begin
                MtodayYear := Date2dmy(Today, 3);
                RegYear := Date2dmy(DateRegistered, 3);
                MRegdate := Date2dmy(DateRegistered, 2);

                MToday := Date2dmy(Today, 2) + MRegdate;

                if CalcDate('1M', DateRegistered) > Today then begin
                    amount := 1;
                    //Res := '1::::Your do not Qualify for this loan because you should be a member for last 3 Months::::False';
                    Res := '{"success":false,';
                    Res += '"description":"You do not Qualify for this loan because you should be a member for last 1 Months",';
                    Res += '"amount":0}';
                    Qualfiedamount := 0;
                    exit;
                end;
            end;



            if amount <> 1 then begin
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Client Code", Members."No.");
                LoansRegister.SetRange(LoansRegister.Posted, true);

                if LoansRegister.Find('-') then begin
                    repeat
                        LoansRegister.CalcFields(LoansRegister."Outstanding Balance");
                        if (LoansRegister."Outstanding Balance" > 0) then begin

                            // =================================== Check if member has an outstanding ELOAN

                            if (LoansRegister."Loan Product Type" = 'UTAPESA') then begin
                                amount := 2;
                                //Res := '2::::You do not Qualify for this loan because You have an outstanding M-JPESA Loan::::False';
                                Res := '{"success":false,';
                                Res += '"description":"You do not Qualify for this loan because You have an outstanding UTAPESA Loan",';
                                Res += '"amount":0}';
                                Qualfiedamount := 0;
                                EXIT
                            end;
                            if (LoansRegister."Loans Category" <> LoansRegister."Loans Category"::Perfoming) AND (LoansRegister."Loans Category" <> LoansRegister."Loans Category"::Watch) then begin
                                Res := '{"success":false,';
                                Res += '"description":"You do not qualify for this loan because you have nonpw",';
                                Res += '"amount":0}';
                                Qualfiedamount := 0;
                                exit;
                            end;
                            /*    if LoansRegister."Amount in Arrears" > 0 then begin
                                  Res := '{"success":false,';
                                  Res += '"description":"You do not qualify for this loan because you have outstanding loan arraes",';
                                  Res += '"amount":0}';
                                  exit;
                              end; */

                        end;

                    until LoansRegister.Next = 0;
                end;
                MpesaDisbus.Reset;
                MpesaDisbus.SetCurrentkey(MpesaDisbus."Entry No");
                MpesaDisbus.Ascending(false);
                MpesaDisbus.SetRange(MpesaDisbus."Member No", account);
                MpesaDisbus.SetFilter("Loan type", '%1', 'UTAPESA');
                MpesaDisbus.SetFilter("Document Date", '..' + Format(20250801D));
                if MpesaDisbus.FindFirst() then begin
                    previousAMT := MpesaDisbus."Loan Amount";
                end;


                //=============================================Get penalty
                MpesaDisbus.Reset;
                MpesaDisbus.SetCurrentkey(MpesaDisbus."Entry No");
                MpesaDisbus.Ascending(false);
                MpesaDisbus.SetRange(MpesaDisbus."Member No", account);
                if MpesaDisbus.Find('-') then begin
                    minimunCount := MpesaDisbus.Count;
                    if MpesaDisbus."Penalty Date" <> 0D then begin
                        if (Today <= CalcDate('1Y', MpesaDisbus."Penalty Date")) then begin
                            amount := 4;
                            //Res := '4::::You do not Qualify for this loan because You have an been penalized for late Repayment::::False';
                            Res := '{"success":false,';
                            Res += '"description":"You do not Qualify for this loan because You have an been penalized for late Repayment",';
                            Res += '"amount":0}';
                            Qualfiedamount := 0;
                            exit;

                        end;
                    end;
                end;
                minimunCount := minimunCount + 1;



                if amount <> 2 then begin
                    if amount <> 3 then begin

                        Members.CalcFields(Members."Current Shares", Members."Outstanding Interest", Members."Current Loan", Members."Outstanding Balance");
                        amount := Members."Current Shares";

                        /*  OutsandingLoans := Members."Outstanding Balance" + Members."Current Loan";
                         OustandingInterest := Members."Outstanding Interest";

                         if OustandingInterest > 0 then begin
                             //Res := '0::::You do not qualify for this loan because you have outstanding loan arraes ::::False';
                             Res := '{"status":false,';
                             Res += '"description":"You do not qualify for this loan because you have outstanding loan arraes",';
                             Res += '"amount":0}';
                             exit;
                         end; */

                        //Get limit
                        creditlogs.Reset();
                        creditlogs.SetRange("Member No", Members."No.");
                        creditlogs.SetCurrentKey("Current limit");
                        creditlogs.Ascending(true);

                        if creditlogs.FindLast() then begin

                            if previousAMT > 0 then begin

                                if (previousAMT >= 5000) and (previousAMT <= 110000) then
                                    previousAMT += 2000 else
                                    if (previousAMT > 11000) and (previousAMT <= 20000) then
                                        previousAMT += 3000 else
                                        if (previousAMT > 20000) and (previousAMT <= 32000) then
                                            previousAMT += 4000 else
                                            if (previousAMT > 32000) and (previousAMT <= 50000) then previousAMT += 5000;
                                updateUtapesacreditlimit(Members."No.", false, 0, 0, previousAMT, 0, '', previousAMT < creditlogs."Current limit");
                            end;
                            previousAMT := creditlogs."Current limit";

                        end else begin
                            updateUtapesacreditlimit(Members."No.", false, 0, 0, previousAMT + 5000, 0, '', false);
                        end;





                        //20,000         10,0000
                        if previousAMT > FreeShares then
                            FreeShares := previousAMT;

                        //  40,000        20,000
                        if amount > FreeShares then
                            amount := FreeShares;



                        //==================================================Get maximum loan amount
                        LoanProductsSetup.Reset;
                        LoanProductsSetup.SetRange(LoanProductsSetup.Code, 'UTAPESA');
                        if LoanProductsSetup.Find('-') then begin
                            interestAMT := LoanProductsSetup."Interest rate";
                            MaxLoanAmt := LoanProductsSetup."Max. Loan Amount";
                        end;

                        if amount > MaxLoanAmt then
                            amount := MaxLoanAmt;



                    end;



                    if amount > 0 then begin


                        if previousAMT = 0 then begin
                            if Members."Current Shares" >= 1000 then begin
                                if amount >= 5000 then amount := 5000;
                                if Members."Current Shares" <= 5000 then amount := Members."Current Shares";
                                Res := '{"success":true,';
                                Res += '"description":"You Qualify upto ' + Format(amount) + ' at 7% Interest for period of 1 Month",';
                                Res += '"amount":' + DelChr(Format(amount), '=', ',') + '}';
                                Qualfiedamount := amount;
                                exit;
                            end else begin
                                Res := '{"success":true,';
                                Res += '"description":"You do not qualify for this loan kindly topup your deposits to above Kshs 1000 to access this loan",';
                                Res += '"amount":' + DelChr(Format(0), '=', ',') + '}';
                                Qualfiedamount := 0;
                                exit;
                            end;

                        end;
                        // Res := Format(amount) + '::::You Qualify upto ' + Format(amount) + ' at 10% Interest::::True';
                        Res := '{"success":true,';
                        Res += '"description":"You Qualify upto ' + Format(amount) + ' at 7% Interest for period of 1 Month",';
                        Res += '"amount":' + DelChr(Format(amount), '=', ',') + '}';
                        Qualfiedamount := amount;
                        exit;
                    end else begin
                        //  Res := '0::::Your do not qualify for this loan because you dont have free shares::::False';
                        Qualfiedamount := 0;
                        Res := '{"success":false,';
                        Res += '"description":"You do not qualify for this loan, kindly contact sacco for more info",';
                        Res += '"amount":0}';
                        exit;
                    end;
                end;
            end;

        end;
    end;

    procedure updateUtapesacreditlimit(MemberNo: code[50]; SendNotification: Boolean; amountpaid: Decimal; loanamount: Decimal; currentlimit: Decimal; previosLimit: Decimal; loanNo: code[10]; overrideLog: Boolean)
    var
        creditLogs: Record "Credit limit logs";
        creditLogs2: Record "Credit limit logs";
        loanproduct: code[50];

    begin


        // Check credibility 


        loanproduct := 'UTAPESA';

        Members.get(MemberNo);
        Members.CalcFields("Current Shares");
        creditLogs.Reset();
        creditLogs.SetRange("Member No", MemberNo);
        creditLogs.SetCurrentKey(EntryNo);
        creditLogs.Ascending(true);
        if creditLogs.FindLast() then begin
            if overrideLog = false then begin

                if (Date2DMY(creditLogs."Date logged", 2) = Date2DMY(Today, 2)) and (Date2DMY(creditLogs."Date logged", 3) = Date2DMY(Today, 3)) then exit;
                creditLogs."Current limit" := currentlimit;
                creditLogs.Modify();
            end else begin
                if (Date2DMY(creditLogs."Date logged", 2) = Date2DMY(Today, 2)) and (Date2DMY(creditLogs."Date logged", 3) = Date2DMY(Today, 3)) then exit;
                creditLogs."Date logged" := today;
                creditLogs."Current limit" := currentlimit;
                creditLogs.Modify();
            end;

        end;
        if Members."Current Shares" < currentlimit then currentlimit := members."Current Shares";

        if creditLogs2.FindLast() then
            creditLogs.EntryNo := creditLogs2.EntryNo + 1
        else
            creditLogs.EntryNo := 1;
        creditLogs."Member No" := MemberNo;
        creditLogs."Amount paid" := amountpaid;
        creditLogs."Loan amoount" := loanamount;
        creditLogs."Loan no" := loanNo;
        creditLogs."Loan product type" := loanproduct;
        creditLogs."Date logged" := Today;
        creditLogs."Current limit" := currentlimit;
        creditLogs."Previous limit" := previosLimit;
        creditLogs."Norification sent" := SendNotification;
        creditLogs.Insert(true);
        if SendNotification then begin
            if currentlimit > previosLimit then
                SMSMessage('Credit' + Format(creditLogs.EntryNo), '', Members."Mobile Phone No", 'Dear' + Members.Name + ', thank you for repaying your Utapesa loan on time. Great news—your Utapesa loan limit has been increased! Dial *720# to check your new limit and borrow again. Utabibu Sacco', '');
            //  if currentlimit < previosLimit then
            //    SMSMessage('Credit' + Format(creditLogs.EntryNo), '', Members."Mobile Phone No", 'Your credit limit has recuded for utapesa to upto if you have any disputes kindly contact the credit centre Utabibu sacco' + Format(currentlimit), '');

        end;




    end;



    procedure calculateDividends(MemberNo: code[30]) totalDividends: Decimal
    var
        customer: Record Customer;
        count: Integer;
        startdate: date;
        enddate: Date;
        setup: Record "Sacco General Set-Up";
        EndOfYear: Date;

    begin
        setup.Get();
        for count := 1 to 11 do begin
            begin
                customer.Reset();
                customer.SetRange("No.", MemberNo);
                //customer.SetFilter("Date Filter", Format(CalcDate(FORMAT(count) + 'M', setup."Dividend processing start date")) + '..' + Format(CalcDate(FORMAT(count) + 'M', setup."Dividend processing end date")));
                customer.SetFilter("Date Filter", '..' + Format(CalcDate(FORMAT(count) + 'M', setup."Dividend processing start date")));
                if customer.find('-') then begin
                    customer.CalcFields("Current Shares", "Shares Retained", "FOSA Shares");
                    // Interest on deposits
                    totalDividends += (setup."Interest on Deposits (%)" / 100 / 12) * ((round(customer."Current Shares", 0.01, '<')));
                    // totalDividends += (setup."Dividend (%)" / 100 / 12) * ((round(customer."Shares Retained", 0.01, '<')));

                end;

            end;
        end;
        if (totalDividends > 0) then begin
            EndOfYear := CalcDate('<CY>', setup."Dividend processing start date");
            customer.reset;
            customer.get(MemberNo);
            customer.SetFilter("Date Filter", Format(setup."Dividend processing start date") + '..' + Format(EndOfYear));
            customer.CalcFields("Shares Retained");
            totalDividends += (setup."Dividend (%)" / 100) * ((round(customer."Shares Retained", 0.01, '<')));
            totalDividends -= totalDividends * (setup."Withholding Tax (%) on dividends" / 100);
        end;

    end;



    procedure AdvanceEligibilitydIVIDEND(account: Text[50]; period: Integer; var AmountQua: decimal) Res: Text
    var
        StoDedAmount: Decimal;
        STO: Record "Standing Orders";
        FOSALoanRepayAmount: Decimal;
        CumulativeNet: Decimal;
        LastSalaryDate: Date;
        FirstSalaryDate: Date;
        AvarageNetPay: Decimal;
        AdvQualificationAmount: Decimal;
        CumulativeNet2: Decimal;
        finalAmount: Decimal;
        interestAMT: Decimal;
        MaxLoanAmt: Decimal;
        LastPaydate: Date;
        MPayDate: Decimal;
        MToday: Decimal;
        DateRegistered: Date;
        MtodayYear: Decimal;
        RegYear: Decimal;
        MtodayDiff: Decimal;
        MRegdate: Decimal;
        ComittedShares: Decimal;
        LoanGuarantors: Record "Loans Guarantee Details";
        FreeShares: Decimal;
        TotalAmount: Decimal;
        TransactionLoanAmt: Decimal;
        TransactionLoanDiff: Decimal;
        RepayedLoanAmt: Decimal;
        LoanRepaymentS: Record "Loan Repayment Schedule";
        Fulldate: Date;
        LastRepayDate: Date;
        PrincipalAmount: Decimal;
        OutsandingLoans: Decimal;
        OustandingInterest: Decimal;
        previousAMT: Decimal;
        totalMpesaCharge: decimal;
        TotalOut: decimal;
    begin

        amount := 0;
        totalMpesaCharge := 100;
        AmountQua := 0;
        //=================================================must be member for 6 months
        Members.Reset;
        Members.SetRange(Members."No.", account);
        if Members.FindFirst() then begin
            DateRegistered := Members."Registration Date";
            Members.CalcFields("Current Shares");
        end;

        if Members.BlackListed = Members.BlackListed::Yes then begin
            Res := '{"success":false,';
            Res += '"description":"Your Account is in Default",';
            Res += '"amount":0}';
            exit;
        end;

        if Members.Status <> Members.Status::Active then begin
            Res := '{"success":false,';
            Res += '"description":"Your Account is not active",';
            Res += '"amount":0}';
            exit;
        end;

        if Members."Loan Status" <> Members."Loan Status"::Active then begin
            Res := '{"success":false,';
            Res += '"description":"Your Account is not active",';
            Res += '"amount":0}';
            exit;
        end;

        if Members."Current Shares" < 2000 then begin
            Res := '{"success":false,';
            Res += '"description":"Your deposits is less that Ksh. 2,000",';
            Res += '"amount":0}';
            exit;
        end;


        // Members.CalcFields(Members."Dormant Date")

        if DateRegistered <> 0D then begin
            MtodayYear := Date2dmy(Today, 3);
            RegYear := Date2dmy(DateRegistered, 3);
            MRegdate := Date2dmy(DateRegistered, 2);

            MToday := Date2dmy(Today, 2) + MRegdate;

            if CalcDate('3M', DateRegistered) > Today then begin
                //amount := 1;
                //Res := '1::::Your do not Qualify for this loan because you should be a member for last 3 Months::::False';
                Res := '{"success":false,';
                Res += '"description":"You do not Qualify for this loan because you should be a member for last 3 Months",';
                Res += '"amount":0}';
            end;
        end;

        LoanProductsSetup.RESET;
        LoanProductsSetup.SetFilter(LoanProductsSetup.Code, '%1', 'DIVIDEND');
        LoanProductsSetup.SetRange("Availabe Mobile Loan", false);
        IF LoanProductsSetup.FIND('-') THEN BEGIN
            Res := '{"status":false,';
            Res += '"description":"The loan product is not enabled for mobile banking",';
            Res += '"amount":0}';
            exit;
        end;//addition
        TotalOut := 0;
        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Loan Product Type", 'DIVIDEND');
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
        if LoansRegister.Find('-') then begin
            repeat
                LoansRegister.CalcFields(LoansRegister."Outstanding Balance");
                if LoansRegister."Outstanding Balance" > 0 then begin
                    TotalOut := TotalOut + LoansRegister."Outstanding Balance";
                end;
            until LoansRegister.Next() = 0;
            // if TotalOut > 3000000 then begin
            //     Res := '{"status":false,';
            //     Res += '"description":"You",';
            //     Res += '"amount":0}';
            //     exit;
            // end;
        end;


        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Client Code", Members."No.");
        LoansRegister.SetRange(LoansRegister.Posted, true);

        if LoansRegister.Find('-') then begin
            repeat
                LoansRegister.CalcFields(LoansRegister."Outstanding Balance");
                if (LoansRegister."Outstanding Balance" > 0) then begin

                    // =================================== Check if member has an outstanding ELOAN

                    if (LoansRegister."Loan Product Type" = 'DIVIDEND') then begin
                        amount := 2;
                        //Res := '2::::You do not Qualify for this loan because You have an outstanding M-JPESA Loan::::False';
                        Res := '{"success":false,';
                        Res += '"description":"You do not Qualify for this loan because You have an outstanding Dividend Loan",';
                        Res += '"amount":0}';
                        EXIT
                    end;
                    /*   if LoansRegister."Loans Category" <> LoansRegister."Loans Category"::Perfoming then begin
                          Res := '{"success":false,';
                          Res += '"description":"You do not qualify for this loan because you have outstanding loan arraes",';
                          Res += '"amount":0}';
                          exit;
                      end;
                      if LoansRegister."Amount in Arrears" > 0 then begin
                          Res := '{"success":false,';
                          Res += '"description":"You do not qualify for this loan because you have outstanding loan arraes",';
                          Res += '"amount":0}';
                          exit;
                      end; */

                end;

            until LoansRegister.Next = 0;
        end;
        MpesaDisbus.Reset;
        MpesaDisbus.SetCurrentkey(MpesaDisbus."Entry No");
        MpesaDisbus.Ascending(false);
        MpesaDisbus.SetRange(MpesaDisbus."Member No", account);
        if MpesaDisbus.FindFirst() then begin
            previousAMT := MpesaDisbus."Loan Amount";
        end;

        //=============================================Get penalty
        MpesaDisbus.Reset;
        MpesaDisbus.SetCurrentkey(MpesaDisbus."Entry No");
        MpesaDisbus.Ascending(false);
        MpesaDisbus.SetRange(MpesaDisbus."Member No", account);
        if MpesaDisbus.Find('-') then begin
            minimunCount := MpesaDisbus.Count;
            if MpesaDisbus."Penalty Date" <> 0D then begin
                if (Today <= CalcDate('1Y', MpesaDisbus."Penalty Date")) then begin
                    amount := 4;
                    //Res := '4::::You do not Qualify for this loan because You have an been penalized for late Repayment::::False';
                    Res := '{"success":false,';
                    Res += '"description":"You do not Qualify for this loan because You have an been penalized for late Repayment",';
                    Res += '"amount":0}';
                    exit;
                end;
            end;
        end;
        minimunCount := minimunCount + 1;

        if amount <> 2 then begin
            if amount <> 3 then begin
                Members.CalcFields("Dividend Amount");
                Members.CalcFields(Members."Current Shares", Members."Outstanding Interest", Members."Current Loan", Members."Outstanding Balance");
                amount := Round(calculateDividends(Members."No.") * 0.5, 1, '='); //Members."Current Shares";

                /*  OutsandingLoans := Members."Outstanding Balance" + Members."Current Loan";
                 OustandingInterest := Members."Outstanding Interest";

                 if OustandingInterest > 0 then begin
                     //Res := '0::::You do not qualify for this loan because you have outstanding loan arraes ::::False';
                     Res := '{"status":false,';
                     Res += '"description":"You do not qualify for this loan because you have outstanding loan arraes",';
                     Res += '"amount":0}';
                     exit;
                 end; */

                // FreeShares := GetCharge(minimunCount, 'MOBILIMIT');
                // if previousAMT > FreeShares then
                //     FreeShares := previousAMT;

                // if amount > FreeShares then
                //     amount := FreeShares;

                //==================================================Get maximum loan amount
                LoanProductsSetup.Reset;
                LoanProductsSetup.SetRange(LoanProductsSetup.Code, 'DIVIDEND');
                if LoanProductsSetup.Find('-') then begin
                    interestAMT := LoanProductsSetup."Interest rate";
                    MaxLoanAmt := LoanProductsSetup."Max. Loan Amount";
                end;

                if amount > MaxLoanAmt then
                    amount := MaxLoanAmt;
            end;

            if amount > 0 then begin
                // Res := Format(amount) + '::::You Qualify upto ' + Format(amount) + ' at 10% Interest::::True';
                Res := '{"success":true,';
                Res += '"description":"You Qualify upto ' + Format(amount) + ' at 5% Interest for period of 1 Month",';
                Res += '"amount":' + DelChr(Format(amount), '=', ',') + '}';
                AmountQua := amount;
            end else begin
                //  Res := '0::::Your do not qualify for this loan because you dont have free shares::::False';
                Res := '{"success":false,';
                Res += '"description":"You do not qualify for this loan, kindly contact sacco for more info",';
                Res += '"amount":0}';
            end;
        end;


    end;


    procedure PostNormalLoan(docNo: Code[20]; AccountNo: Code[50]; amount: Decimal; Period: Decimal; var InterestAmount: decimal) result: Code[30]
    var
        LoanAcc: Code[30];
        InterestAcc: Code[30];
        AmountToCredit: Decimal;
        loanNo: Text[20];
        advSMS: Decimal;
        advFee: Decimal;
        advApp: Decimal;
        advSMSAcc: Code[20];
        advFEEAcc: Code[20];
        advAppAcc: Code[20];
        advSMSDesc: Text[100];
        advFeeDesc: Text[100];
        advAppDesc: Text[100];
        LoanProdCharges: Record "Loan Product Charges";
        SaccoNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanRepSchedule: Record "Loan Repayment Schedule";
        loanType: Code[50];
        InsuranceAcc: Code[10];
        ObjLoanPurpose: Record "Loans Purpose";
        SaccoNo: Record "No. Series";
        AmountDispursed: Decimal;
    begin
        loanType := 'UTAPESA';
        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", docNo);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
            exit(result);
        end
        else begin
            GenSetUp.Reset;
            GenSetUp.Get();
            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;

            Members.Reset;
            Members.Get(AccountNo);
            LoanProductsSetup.Reset;
            LoanProductsSetup.SetRange(LoanProductsSetup.Code, loanType);
            if LoanProductsSetup.FindFirst() then begin
                LoanAcc := LoanProductsSetup."Loan Account";
                InterestAcc := LoanProductsSetup."Loan Interest Account";
                InsuranceAcc := LoanProductsSetup."Loan Insurance Accounts";
            end;
            //loan charges
            LoanProdCharges.Reset;
            LoanProdCharges.SetRange(LoanProdCharges."Product Code", loanType);
            LoanProdCharges.SetRange(LoanProdCharges.Code, loanType);
            if LoanProdCharges.FindFirst() then begin
                advApp := LoanProdCharges.Amount;
                advAppAcc := LoanProdCharges."G/L Account";
                advAppDesc := LoanProdCharges.Description;
            end;
            //sms charge
            LoanProdCharges.Reset;
            LoanProdCharges.SetRange(LoanProdCharges."Product Code", loanType);
            LoanProdCharges.SetRange(LoanProdCharges.Code, 'SMS');
            if LoanProdCharges.FindFirst() then begin
                advSMS := (LoanProdCharges.Amount);
                advSMSAcc := LoanProdCharges."G/L Account";
                advSMSDesc := LoanProdCharges.Description;
            end;

            //INSURANCE charge
            LoanProdCharges.Reset;
            LoanProdCharges.SetRange(LoanProdCharges."Product Code", loanType);
            LoanProdCharges.SetRange(LoanProdCharges.Code, 'LPF');
            if LoanProdCharges.FindFirst() then begin
                advSMS := LoanProdCharges.Amount;
                advSMSAcc := LoanProdCharges."G/L Account";
                advSMSDesc := LoanProdCharges.Description;
            end;
            //loan proccessing fee
            LoanProdCharges.Reset;
            LoanProdCharges.SetRange(LoanProdCharges."Product Code", loanType);
            LoanProdCharges.SetRange(LoanProdCharges.Code, 'LPROCESSING');
            if LoanProdCharges.FindFirst() then begin
                advFee := (LoanProdCharges.Amount / 100) * amount;
                advFEEAcc := LoanProdCharges."G/L Account";
                advFeeDesc := LoanProdCharges.Description;
            end;
            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            //GenLedgerSetup.TestField("MPESA Recon Acc");

            MpesaAccount := 'BANK0010';// GenLedgerSetup."MPESA Recon Acc";
            MPESACharge := GetCharge(amount, 'MPESA');

            MobileCharges := GetCharge(amount, 'M-WALLET');

            SurePESACharge := 0;//GenLedgerSetup."Mobile Charge";
            SurePESACommACC := '';// GenLedgerSetup."Mobile Comm Account";
            InterestAmount := (LoanProductsSetup."Interest rate" / 100) * amount;
            AmountToCredit := amount + InterestAmount + MPESACharge;
            TotalCharges := MPESACharge + MobileCharges;
            AmountDispursed := amount;
            InterestAmount := ROUND(InterestAmount, 1, '>');
            Members.Reset;
            Members.SetRange(Members."No.", AccountNo);
            if Members.Find('-') then begin

                //*******Create Loan *********//
                SaccoNoSeries.Reset;
                SaccoNoSeries.Get;
                SaccoNoSeries.TestField(SaccoNoSeries."BOSA Loans Nos");
                //NoSeriesMgt.InitSeries(SaccoNoSeries."BOSA Loans Nos", LoansRegister."No. Series", 0D, LoansRegister."Loan  No.", LoansRegister."No. Series");
                loanNo := NoSeriesMgt.GetNextNo(SaccoNoSeries."BOSA Loans Nos", 0D, true);

                LoansRegister.Init;
                LoansRegister."Approved Amount" := amount;
                LoansRegister.Interest := LoanProductsSetup."Interest rate";
                LoansRegister."Instalment Period" := LoanProductsSetup."Instalment Period";
                LoansRegister.Repayment := amount + InterestAmount + TotalCharges;
                LoansRegister."Expected Date of Completion" := CalcDate('1M', Today);
                LoansRegister.Posted := true;
                Members.CalcFields(Members."Current Shares", Members."Outstanding Balance", Members."Current Loan");
                LoansRegister."Shares Balance" := Members."Current Shares";
                LoansRegister."Amount Disbursed" := amount;
                LoansRegister.Savings := Members."Current Shares";
                LoansRegister."Interest Paid" := 0;
                LoansRegister."Issued Date" := Today;
                LoansRegister.Source := LoanProductsSetup.Source;
                LoansRegister."Loan Disbursed Amount" := amount;
                LoansRegister."Scheduled Principal to Date" := AmountDispursed;
                LoansRegister."Current Interest Paid" := 0;
                LoansRegister."Loan Disbursement Date" := Today;
                LoansRegister."Client Code" := Members."No.";
                LoansRegister."Client Name" := Members.Name;
                LoansRegister."Outstanding Balance to Date" := AmountDispursed;
                LoansRegister."Existing Loan" := Members."Outstanding Balance";
                //LoansRegister."Staff No":=Members."Payroll/Staff No";
                LoansRegister.Gender := Members.Gender;
                LoansRegister."BOSA No" := Members."No.";
                // LoansRegister."Branch Code":=Members."Global Dimension 2 Code";
                LoansRegister."Requested Amount" := amount;
                LoansRegister."ID NO" := Members."ID No.";
                if LoansRegister."Branch Code" = '' then
                    LoansRegister."Branch Code" := Members."Global Dimension 2 Code";
                LoansRegister."Loan  No." := loanNo;
                LoansRegister."No. Series" := SaccoNoSeries."BOSA Loans Nos";
                LoansRegister."Doc No Used" := docNo;
                LoansRegister."Loan Interest Repayment" := InterestAmount;
                LoansRegister."Loan Principle Repayment" := AmountDispursed;
                LoansRegister."Loan Repayment" := amount + InterestAmount;
                LoansRegister."Employer Code" := Members."Employer Code";
                LoansRegister."Approval Status" := LoansRegister."approval status"::Approved;
                LoansRegister."Account No" := Members."No.";
                LoansRegister."Application Date" := Today;
                LoansRegister."Loan Product Type" := LoanProductsSetup.Code;
                LoansRegister."Loan Product Type Name" := LoanProductsSetup."Product Description";
                LoansRegister."Loan Disbursement Date" := Today;
                LoansRegister."Repayment Start Date" := Today;
                LoansRegister."Recovery Mode" := LoansRegister."recovery mode"::Cash;
                LoansRegister."Disburesment Type" := LoansRegister."disburesment type"::"Full/Single disbursement";
                LoansRegister."Requested Amount" := amount;
                LoansRegister."Approved Amount" := AmountDispursed;
                LoansRegister.Installments := 1;
                LoansRegister."Loan Amount" := AmountDispursed;
                LoansRegister."Issued Date" := Today;
                LoansRegister."Outstanding Balance" := 0;//Update
                LoansRegister."Repayment Frequency" := LoansRegister."repayment frequency"::Monthly;
                LoansRegister."Mode of Disbursement" := LoansRegister."mode of disbursement"::"Bank Transfer";
                LoansRegister.Insert(true);

                // InterestAmount:=0;

                //**********Process Loan*******************//

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILELOAN');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'MOBILELOAN');
                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'MOBILELOAN';
                    GenBatches.Description := 'Normal Loan';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;



                //Post Loan
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Loan  No.", loanNo);
                if LoansRegister.Find('-') then begin

                    //Dr loan Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                    GenJournalLine."Account No." := Members."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Loan Disbursement to-' + LoansRegister."Client Name";
                    GenJournalLine.Amount := AmountDispursed;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Cr Interest Eloan
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                    GenJournalLine."Account No." := Members."No.";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Interest charged on ' + LoansRegister."Loan  No.";
                    GenJournalLine.Amount := ROUND(InterestAmount, 1, '>');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                    if GenJournalLine.Amount <> 0 then
                        // GenJournalLine.Insert;

                        //Cr Interest Eloan
                        LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    if LoanProductsSetup.Get(LoansRegister."Loan Product Type") then begin
                        GenJournalLine."Account No." := LoanProductsSetup."Receivable Interest Account";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := docNo + ' ' + 'Interest charged';
                    GenJournalLine.Amount := ROUND(InterestAmount, 1, '>') * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);

                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                    if GenJournalLine.Amount <> 0 then
                        // GenJournalLine.Insert;

                        //Cr MPESA ACC
                        LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := 'BANK0010';
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := loanNo;
                    GenJournalLine."Source No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'loan Disbursement to-' + LoansRegister."Client Name";
                    GenJournalLine.Amount := (AmountDispursed - InterestAmount) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //ChargeAmount
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := 'BANK0010';
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := loanNo;
                    GenJournalLine."Source No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Transaction Charge-' + Members."Mobile Phone No" + ' -' + loanNo;
                    GenJournalLine.Amount := (TotalCharges) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Charge Balancimg
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := '803055';
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := loanNo;
                    GenJournalLine."Source No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Transaction Charge-' + Members."Mobile Phone No" + ' -' + loanNo;
                    GenJournalLine.Amount := (TotalCharges);
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //pay interest....
                    if InterestAmount > 0 then begin
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        if LoanProductsSetup.Get(LoansRegister."Loan Product Type") then begin
                            GenJournalLine."Account No." := LoanProductsSetup."Loan Interest Account";
                        end;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := docNo;
                        GenJournalLine."External Document No." := docNo;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := ' UPfront Loan Interest Payment';
                        GenJournalLine.Amount := InterestAmount * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                        if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                            GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                            GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                        end;
                    END;



                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MOBILELOAN');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;

                        //***************Update Loan Status************//
                        LoansRegister."Loan Status" := LoansRegister."loan status"::Disbursed;
                        LoansRegister."Amount Disbursed" := AmountToCredit;
                        LoansRegister.Posted := true;
                        LoansRegister."Interest Upfront Amount" := InterestAmount;
                        LoansRegister."Outstanding Balance" := amount;
                        LoansRegister.Modify;

                        //=====================insert to Mpesa mobile disbursment
                        MpesaDisbus.Reset;
                        MpesaDisbus.SetRange(MpesaDisbus."Document No", docNo);
                        if MpesaDisbus.Find('-') = false then begin

                            MpesaDisbus."Account No" := Members."No.";
                            MpesaDisbus."Document Date" := Today;
                            MpesaDisbus."Loan Amount" := (AmountDispursed);
                            MpesaDisbus."Document No" := docNo;
                            MpesaDisbus."Batch No" := 'MOBILE';
                            MpesaDisbus."Date Entered" := Today;
                            MpesaDisbus."Time Entered" := Time;
                            MpesaDisbus."Entered By" := UserId;
                            MpesaDisbus."Member No" := Members."No.";
                            MpesaDisbus."Telephone No" := Members."Mobile Phone No";
                            MpesaDisbus."Corporate No" := '';
                            MpesaDisbus."Delivery Center" := 'MPESA';
                            MpesaDisbus."Loan No" := loanNo;
                            MpesaDisbus."Customer Name" := Members.Name;
                            MpesaDisbus.Status := MpesaDisbus.Status::Completed;
                            MpesaDisbus.Purpose := 'Emergency';
                            MpesaDisbus.Insert;

                        end;


                    end;


                    SurePESATrans.Init;
                    SurePESATrans."Document No" := docNo;
                    SurePESATrans.Description := 'Mobile Loan';
                    SurePESATrans."Document Date" := Today;
                    SurePESATrans."Account No" := Members."No.";
                    SurePESATrans.Amount := amount;
                    SurePESATrans."Account Name" := Members.Name;
                    SurePESATrans.Status := SurePESATrans.Status::Completed;
                    SurePESATrans.Posted := true;
                    SurePESATrans."Posting Date" := Today;
                    SurePESATrans.Comments := 'Success';
                    SurePESATrans.Client := Members."No.";
                    SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Loan Application";
                    SurePESATrans."Transaction Time" := Time;
                    SurePESATrans.Insert;
                    result := 'TRUE';
                    msg := 'Dear ' + SplitString(Members.Name, ' ') + ', Your UTAPESA No ' + loanNo + ' of Ksh ' + Format((AmountDispursed)) + ' has been approved and disbursed to your MPESA  Transfer Charges ' + Format(InterestAmount)
                    + '. Your loan of KShs ' + Format(AmountDispursed)
                    + ' is due on ' + Format(CalcDate('+1M', Today));

                    UtapesaMessage := ' Your Utapesa loan application of KES ' + format(AmountDispursed) + 'is successful. Please make payment on or before ' + Format(CalcDate('30D', Today)) + ' to avoid penalties.';
                    SmsManagement.SendSmsResponse(Members."Mobile Phone No", UtapesaMessage);
                    SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');
                end;//Loans Register
                    //END
            end
            else begin
                result := 'ACCINEXISTENT';
                SurePESATrans.Init;
                SurePESATrans."Document No" := docNo;
                SurePESATrans.Description := 'Mobile Loan';
                SurePESATrans."Document Date" := Today;
                SurePESATrans."Account No" := Members."No.";
                SurePESATrans.Amount := amount;
                SurePESATrans.Status := SurePESATrans.Status::Completed;
                SurePESATrans.Posted := true;
                SurePESATrans."Posting Date" := Today;
                SurePESATrans.Comments := 'Failed.Invalid Account';
                SurePESATrans.Client := Members."No.";
                SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Loan Application";
                SurePESATrans."Transaction Time" := Time;
                SurePESATrans.Insert;
            end;
        end;

    end;



    procedure PostDividendLoan(docNo: Code[20]; AccountNo: Code[50]; amount: Decimal; Period: Decimal; var InterestAmount: decimal) result: Code[30]
    var
        LoanAcc: Code[30];
        InterestAcc: Code[30];
        AmountToCredit: Decimal;
        loanNo: Text[20];
        advSMS: Decimal;
        advFee: Decimal;
        advApp: Decimal;
        advSMSAcc: Code[20];
        advFEEAcc: Code[20];
        advAppAcc: Code[20];
        advSMSDesc: Text[100];
        advFeeDesc: Text[100];
        advAppDesc: Text[100];
        LoanProdCharges: Record "Loan Product Charges";
        SaccoNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanRepSchedule: Record "Loan Repayment Schedule";
        loanType: Code[50];
        InsuranceAcc: Code[10];
        ObjLoanPurpose: Record "Loans Purpose";
        SaccoNo: Record "No. Series";
        AmountDispursed: Decimal;
        totalMpesaCharge: Decimal;
    begin
        loanType := 'DIVIDEND';
        totalMpesaCharge := 0;
        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", docNo);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
            exit(result);
        end
        else begin
            GenSetUp.Reset;
            GenSetUp.Get();
            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;

            Members.Reset;
            Members.Get(AccountNo);
            LoanProductsSetup.Reset;
            LoanProductsSetup.SetRange(LoanProductsSetup.Code, loanType);
            if LoanProductsSetup.FindFirst() then begin
                LoanAcc := LoanProductsSetup."Loan Account";
                InterestAcc := LoanProductsSetup."Loan Interest Account";
                InsuranceAcc := LoanProductsSetup."Loan Insurance Accounts";
            end;
            LoanProductsSetup.RESET;
            LoanProductsSetup.SetFilter(LoanProductsSetup.Code, '%1', 'DIVIDEND');
            LoanProductsSetup.SetRange("Availabe Mobile Loan", false);
            IF LoanProductsSetup.FIND('-') THEN BEGIN
                exit;
            end;//addition
            //loan charges
            LoanProdCharges.Reset;
            LoanProdCharges.SetRange(LoanProdCharges."Product Code", loanType);
            LoanProdCharges.SetRange(LoanProdCharges.Code, loanType);
            if LoanProdCharges.FindFirst() then begin
                advApp := LoanProdCharges.Amount;
                advAppAcc := LoanProdCharges."G/L Account";
                advAppDesc := LoanProdCharges.Description;
            end;
            //sms charge
            LoanProdCharges.Reset;
            LoanProdCharges.SetRange(LoanProdCharges."Product Code", loanType);
            LoanProdCharges.SetRange(LoanProdCharges.Code, 'SMS');
            if LoanProdCharges.FindFirst() then begin
                advSMS := (LoanProdCharges.Amount);
                advSMSAcc := LoanProdCharges."G/L Account";
                advSMSDesc := LoanProdCharges.Description;
            end;

            //INSURANCE charge
            LoanProdCharges.Reset;
            LoanProdCharges.SetRange(LoanProdCharges."Product Code", loanType);
            LoanProdCharges.SetRange(LoanProdCharges.Code, 'LPF');
            if LoanProdCharges.FindFirst() then begin
                advSMS := LoanProdCharges.Amount;
                advSMSAcc := LoanProdCharges."G/L Account";
                advSMSDesc := LoanProdCharges.Description;
            end;
            //loan proccessing fee
            LoanProdCharges.Reset;
            LoanProdCharges.SetRange(LoanProdCharges."Product Code", loanType);
            LoanProdCharges.SetRange(LoanProdCharges.Code, 'LPROCESSING');
            if LoanProdCharges.FindFirst() then begin
                advFee := (LoanProdCharges.Amount / 100) * amount;
                advFEEAcc := LoanProdCharges."G/L Account";
                advFeeDesc := LoanProdCharges.Description;
            end;
            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            //GenLedgerSetup.TestField("MPESA Recon Acc");

            MpesaAccount := 'BANK0010';// GenLedgerSetup."MPESA Recon Acc";
            MPESACharge := 0;// GetCharge(amount, 'MPESA');

            MobileCharges := GetCharge(amount, 'M-WALLET');

            SurePESACharge := 0;//GenLedgerSetup."Mobile Charge";
            SurePESACommACC := '';// GenLedgerSetup."Mobile Comm Account";
            InterestAmount := (LoanProductsSetup."Interest rate" / 100) * amount;
            AmountToCredit := amount + InterestAmount + MPESACharge;
            TotalCharges := MPESACharge + MobileCharges;
            AmountDispursed := amount;
            InterestAmount := ROUND(InterestAmount, 1, '>');
            Members.Reset;
            Members.SetRange(Members."No.", AccountNo);
            if Members.Find('-') then begin

                //*******Create Loan *********//
                SaccoNoSeries.GET;
                SaccoNoSeries.TESTFIELD(SaccoNoSeries."BOSA Loans Nos");
                loanNo := NoSeriesMgt.GetNextNo(SaccoNoSeries."BOSA Loans Nos", 0D, TRUE);

                LoansRegister.Init;
                LoansRegister."Approved Amount" := amount;
                LoansRegister.Interest := LoanProductsSetup."Interest rate";
                LoansRegister."Instalment Period" := LoanProductsSetup."Instalment Period";
                LoansRegister.Repayment := amount + InterestAmount + TotalCharges;
                LoansRegister."Expected Date of Completion" := CalcDate('1M', Today);
                LoansRegister.Posted := true;
                Members.CalcFields(Members."Current Shares", Members."Outstanding Balance", Members."Current Loan");
                LoansRegister."Shares Balance" := Members."Current Shares";
                LoansRegister."Amount Disbursed" := amount;
                LoansRegister.Savings := Members."Current Shares";
                LoansRegister."Interest Paid" := 0;
                LoansRegister."Issued Date" := Today;
                LoansRegister.Source := LoanProductsSetup.Source;
                LoansRegister."Loan Disbursed Amount" := amount;
                LoansRegister."Scheduled Principal to Date" := AmountDispursed;
                LoansRegister."Current Interest Paid" := 0;
                LoansRegister."Loan Disbursement Date" := Today;
                LoansRegister."Client Code" := Members."No.";
                LoansRegister."Client Name" := Members.Name;
                LoansRegister."Outstanding Balance to Date" := AmountDispursed;
                LoansRegister."Existing Loan" := Members."Outstanding Balance";
                //LoansRegister."Staff No":=Members."Payroll/Staff No";
                LoansRegister.Gender := Members.Gender;
                LoansRegister."BOSA No" := Members."No.";
                // LoansRegister."Branch Code":=Members."Global Dimension 2 Code";
                LoansRegister."Requested Amount" := amount;
                LoansRegister."ID NO" := Members."ID No.";
                if LoansRegister."Branch Code" = '' then
                    LoansRegister."Branch Code" := Members."Global Dimension 2 Code";
                LoansRegister."Loan  No." := loanNo;
                LoansRegister."No. Series" := SaccoNoSeries."BOSA Loans Nos";
                LoansRegister."Doc No Used" := docNo;
                LoansRegister."Loan Interest Repayment" := InterestAmount;
                LoansRegister."Loan Principle Repayment" := AmountDispursed;
                LoansRegister."Loan Repayment" := amount;
                LoansRegister."Employer Code" := Members."Employer Code";
                LoansRegister."Approval Status" := LoansRegister."approval status"::Approved;
                LoansRegister."Account No" := Members."No.";
                LoansRegister."Application Date" := Today;
                LoansRegister."Loan Product Type" := LoanProductsSetup.Code;
                LoansRegister."Loan Product Type Name" := LoanProductsSetup."Product Description";
                LoansRegister."Loan Disbursement Date" := Today;
                LoansRegister."Repayment Start Date" := Today;
                LoansRegister."Recovery Mode" := LoansRegister."recovery mode"::Cash;
                LoansRegister."Disburesment Type" := LoansRegister."disburesment type"::"Full/Single disbursement";
                LoansRegister."Requested Amount" := amount;
                LoansRegister."Approved Amount" := AmountDispursed;
                LoansRegister.Installments := 1;
                LoansRegister."Loan Amount" := AmountDispursed;
                LoansRegister."Issued Date" := Today;
                LoansRegister."Outstanding Balance" := 0;//Update
                LoansRegister."Repayment Frequency" := LoansRegister."repayment frequency"::Monthly;
                LoansRegister."Mode of Disbursement" := LoansRegister."mode of disbursement"::"Bank Transfer";
                LoansRegister.Insert(true);

                // InterestAmount:=0;

                //**********Process Loan*******************//

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILELOAN');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'MOBILELOAN');
                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'MOBILELOAN';
                    GenBatches.Description := 'Normal Loan';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;



                //Post Loan
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Loan  No.", loanNo);
                if LoansRegister.Find('-') then begin

                    //Dr loan Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                    GenJournalLine."Account No." := Members."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Loan Disbursement to-' + LoansRegister."Client Name";
                    GenJournalLine.Amount := AmountDispursed;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Cr Interest Eloan
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                    GenJournalLine."Account No." := Members."No.";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Interest charged on ' + LoansRegister."Loan  No.";
                    GenJournalLine.Amount := ROUND(InterestAmount, 1, '>');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                    if GenJournalLine.Amount <> 0 then
                        // GenJournalLine.Insert;

                        //Cr Interest Eloan
                        LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    if LoanProductsSetup.Get(LoansRegister."Loan Product Type") then begin
                        GenJournalLine."Account No." := LoanProductsSetup."Receivable Interest Account";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := docNo + ' ' + 'Interest charged';
                    GenJournalLine.Amount := ROUND(InterestAmount, 1, '>') * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);

                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                    if GenJournalLine.Amount <> 0 then
                        // GenJournalLine.Insert;

                        //Cr MPESA ACC
                        LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := 'BANK0010';
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := loanNo;
                    GenJournalLine."Source No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'loan Disbursement to-' + LoansRegister."Client Name";
                    GenJournalLine.Amount := (AmountDispursed - InterestAmount - totalMpesaCharge) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //ChargeAmount
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := 'BANK0010';
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := loanNo;
                    GenJournalLine."Source No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Transaction Charge-' + Members."Mobile Phone No" + ' -' + loanNo;
                    GenJournalLine.Amount := (TotalCharges) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Charge Balancimg
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := '803055';
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := loanNo;
                    GenJournalLine."Source No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Transaction Charge-' + Members."Mobile Phone No" + ' -' + loanNo;
                    GenJournalLine.Amount := (TotalCharges);
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //pay interest....
                    if InterestAmount > 0 then begin
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        if LoanProductsSetup.Get(LoansRegister."Loan Product Type") then begin
                            GenJournalLine."Account No." := LoanProductsSetup."Loan Interest Account";
                        end;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := docNo;
                        GenJournalLine."External Document No." := docNo;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := ' UPfront Loan Interest Payment';
                        GenJournalLine.Amount := InterestAmount * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                        if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                            GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                            GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                        end;
                    END;

                    if totalMpesaCharge > 0 then begin
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        if LoanProductsSetup.Get(LoansRegister."Loan Product Type") then begin
                            GenJournalLine."Account No." := '803055';
                        end;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := docNo;
                        GenJournalLine."External Document No." := docNo;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Dividend loan mpesa charge';
                        GenJournalLine.Amount := totalMpesaCharge * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                        if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                            GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                            GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                        end;
                    END;



                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MOBILELOAN');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;

                        //***************Update Loan Status************//
                        LoansRegister."Loan Status" := LoansRegister."loan status"::Disbursed;
                        LoansRegister."Amount Disbursed" := AmountToCredit;
                        LoansRegister.Posted := true;
                        LoansRegister."Interest Upfront Amount" := InterestAmount;
                        LoansRegister."Outstanding Balance" := amount;
                        LoansRegister.Modify;

                        //=====================insert to Mpesa mobile disbursment
                        MpesaDisbus.Reset;
                        MpesaDisbus.SetRange(MpesaDisbus."Document No", docNo);
                        if MpesaDisbus.Find('-') = false then begin

                            MpesaDisbus."Account No" := Members."No.";
                            MpesaDisbus."Document Date" := Today;
                            MpesaDisbus."Loan Amount" := (AmountDispursed - InterestAmount - totalMpesaCharge);
                            MpesaDisbus."Document No" := docNo;
                            MpesaDisbus."Batch No" := 'MOBILE';
                            MpesaDisbus."Date Entered" := Today;
                            MpesaDisbus."Time Entered" := Time;
                            MpesaDisbus."Entered By" := UserId;
                            MpesaDisbus."Member No" := Members."No.";
                            MpesaDisbus."Telephone No" := Members."Mobile Phone No";
                            MpesaDisbus."Corporate No" := '';
                            MpesaDisbus."Delivery Center" := 'MPESA';
                            MpesaDisbus."Loan No" := loanNo;
                            MpesaDisbus."Customer Name" := Members.Name;
                            MpesaDisbus.Status := MpesaDisbus.Status::Completed;
                            MpesaDisbus.Purpose := 'Emergency';
                            MpesaDisbus.Insert;

                        end;


                    end;


                    SurePESATrans.Init;
                    SurePESATrans."Document No" := docNo;
                    SurePESATrans.Description := 'Dividend advance Loan';
                    SurePESATrans."Document Date" := Today;
                    SurePESATrans."Account No" := Members."No.";
                    SurePESATrans.Amount := AmountDispursed - InterestAmount - totalMpesaCharge;
                    SurePESATrans."Account Name" := Members.Name;
                    SurePESATrans.Status := SurePESATrans.Status::Completed;
                    SurePESATrans.Posted := true;
                    SurePESATrans."Posting Date" := Today;
                    SurePESATrans.Comments := 'Success';
                    SurePESATrans.Client := Members."No.";
                    SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Loan Application";
                    SurePESATrans."Transaction Time" := Time;
                    SurePESATrans.Insert;
                    result := 'TRUE';
                    msg := 'Dear ' + SplitString(Members.Name, ' ') + ', Your DIVIDEND loan No ' + loanNo + ' of Ksh ' + Format((AmountDispursed)) + ' has been approved and disbursed to your MPESA  Transfer Charges ' + Format(InterestAmount)
                    + '. Your loan of KShs ' + Format(AmountDispursed)
                    + ' is due on ' + Format(CalcDate('+1M', Today));

                    UtapesaMessage := ' Your Dividend Advance Loan application of KES ' + format(AmountDispursed) + 'is successful. The amount will be recovered during dividend posting after AGM.';
                    SmsManagement.SendSmsResponse(Members."Mobile Phone No", UtapesaMessage);
                    SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');
                end;//Loans Register
                    //END
            end
            else begin
                result := 'ACCINEXISTENT';
                SurePESATrans.Init;
                SurePESATrans."Document No" := docNo;
                SurePESATrans.Description := 'Mobile Loan';
                SurePESATrans."Document Date" := Today;
                SurePESATrans."Account No" := Members."No.";
                SurePESATrans.Amount := amount;
                SurePESATrans.Status := SurePESATrans.Status::Completed;
                SurePESATrans.Posted := true;
                SurePESATrans."Posting Date" := Today;
                SurePESATrans.Comments := 'Failed.Invalid Account';
                SurePESATrans.Client := Members."No.";
                SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Loan Application";
                SurePESATrans."Transaction Time" := Time;
                SurePESATrans.Insert;
            end;
        end;

    end;


    procedure GetMpesaDisbursment() result: Text
    begin
        MpesaDisbus.Reset;
        MpesaDisbus.SetRange(MpesaDisbus."Sent To Server", MpesaDisbus."sent to server"::No);
        MpesaDisbus.SetRange(MpesaDisbus.Status, MpesaDisbus.Status::Pending);
        if MpesaDisbus.Find('-') then begin
            result := MpesaDisbus."Document No" + ':::' + MpesaDisbus."Telephone No" + ':::' + Format(MpesaDisbus."Loan Amount") + ':::' + MpesaDisbus."Account No" + ':::' + MpesaDisbus."Customer Name";
        end;
    end;


    procedure UpdateMpesaDisbursment(ImprestNo: Code[30]; MpesaNo: Code[30]; Phone: Code[30]; ResultCode: Code[10]; Comments: Text) result: Code[10]
    var
        BankLedger: Record "Bank Account Ledger Entry";
    begin
        MpesaDisbus.Reset;
        MpesaDisbus.SetRange(MpesaDisbus."Document No", ImprestNo);
        //Mkahawa.SETRANGE(Mkahawa."Telephone No",Phone);
        if MpesaDisbus.Find('-') then begin
            if ResultCode = '0' then begin
                MpesaDisbus."Sent To Server" := MpesaDisbus."sent to server"::Yes;
                MpesaDisbus.Status := MpesaDisbus.Status::Completed;
                BankLedger.Reset;
                BankLedger.SetRange(BankLedger."External Document No.", ImprestNo);
                // BankLedger.SETRANGE(
                if BankLedger.Find('-') then begin
                    BankLedger."External Document No." := MpesaNo;
                    BankLedger.Modify;
                end;
            end else begin
                MpesaDisbus."Sent To Server" := MpesaDisbus."sent to server"::Yes;
                MpesaDisbus.Status := MpesaDisbus.Status::Failed;
            end;
            MpesaDisbus.Comments := Comments;
            MpesaDisbus."Date Sent To Server" := Today;
            MpesaDisbus."Time Sent To Server" := Time;
            MpesaDisbus."MPESA Doc No." := MpesaNo;
            MpesaDisbus.Modify;
            result := 'TRUE';
        end;
    end;


    procedure UpdateMpesaPending(Doc: Code[50])
    begin
        MpesaDisbus.Reset;
        MpesaDisbus.SetRange(MpesaDisbus."Document No", Doc);
        MpesaDisbus.SetRange(MpesaDisbus."Sent To Server", MpesaDisbus."sent to server"::No);
        MpesaDisbus.SetRange(MpesaDisbus.Status, MpesaDisbus.Status::Pending);
        if MpesaDisbus.Find('-') then begin
            MpesaDisbus.Status := MpesaDisbus.Status::Waiting;
            MpesaDisbus.Modify;
        end;
    end;


    procedure fnProcessNotification()
    var
        VarIssuedDate: Date;
        VarExpectedCompletion: Date;
        batch: Code[50];
        SaccoNoSeries: Record "Sacco No. Series";
        docNo: Code[50];
        NotificationDate: Date;
        EloanAmt: Decimal;
        ObjMember: Record "Members Register";
        varMemberNo: Code[50];
        InterestAmount: Decimal;
        StartDate: Date;
        EndDate: Date;
    begin
        GenSetUp.Reset;
        GenSetUp.Get;
        LoanProductsSetup.Reset;
        LoanProductsSetup.SetRange(LoanProductsSetup.Code, 'UTAPESA');
        if LoanProductsSetup.FindFirst() then begin

        end;
        LoansRegister.Reset;
        //LoansRegister.SETRANGE(LoansRegister."Client Code",'006595');
        LoansRegister.SetRange(LoansRegister."Loan Product Type", 'UTAPESA');
        LoansRegister.SetRange(LoansRegister.Posted, true);
        if LoansRegister.Find('-') then begin
            //............


            repeat
                LoansRegister.CalcFields("Outstanding Balance", "Outstanding Interest");

                if LoansRegister."Outstanding Balance" > 0 then begin

                    VarIssuedDate := LoansRegister."Application Date";

                    Members.Reset;
                    Members.SetRange(Members."No.", LoansRegister."Client Code");
                    if Members.Find('-') then begin

                        if Today >= CalcDate('1W', VarIssuedDate) then begin //SEND SMS 2ND WEEK
                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."Ist Notification", false);
                            if MpesaDisbus.Find('-') then begin
                                msg := 'Dear ' + SplitString(Members.Name, ' ') + ', Your ' + LoansRegister."Loan Product Type Name" + ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance" + LoansRegister."Outstanding Interest") + ' is due on '
                                + Format(LoansRegister."Expected Date of Completion");//,0,'<Day> <MonthText> <Year>');

                                SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');
                                MpesaDisbus."Ist Notification" := true;
                                MpesaDisbus.Modify;
                            end;
                        end;

                        //MESSAGE('%1',TODAY);//CALCDATE('4W',20181009D));
                        if Today >= CalcDate('2W', VarIssuedDate) then begin //SEND SMS 4TH WEEK

                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."2nd Notification", false);
                            if MpesaDisbus.Find('-') then begin
                                msg := 'Dear ' + SplitString(Members.Name, ' ') + ', Your ' + LoansRegister."Loan Product Type Name" + ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance" + LoansRegister."Outstanding Interest") + ' is due on '
                                + Format(LoansRegister."Expected Date of Completion") + ' kindly pay the amount or it will be deducted from deposits with 10% penalty';
                                SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');
                                MpesaDisbus."2nd Notification" := true;
                                MpesaDisbus.Modify;
                            end;
                        end;


                        if Today >= CalcDate('5W', VarIssuedDate) then begin // recover from deposit

                            docNo := 'REC-' + LoansRegister."Loan  No.";
                            MpesaDisbus.Reset;
                            MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                            MpesaDisbus.SetRange(MpesaDisbus."Document No", LoansRegister."Doc No Used");
                            MpesaDisbus.SetRange(MpesaDisbus."3rd Notification", false);
                            if MpesaDisbus.Find('-') then begin

                                batch := 'MOBILELOAN';
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", batch);
                                GenJournalLine.DeleteAll;
                                //end of deletion

                                GenBatches.Reset;
                                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                                GenBatches.SetRange(GenBatches.Name, batch);

                                if GenBatches.Find('-') = false then begin
                                    GenBatches.Init;
                                    GenBatches."Journal Template Name" := 'GENERAL';
                                    GenBatches.Name := batch;
                                    GenBatches.Description := 'mobile recovery';
                                    GenBatches.Validate(GenBatches."Journal Template Name");
                                    GenBatches.Validate(GenBatches.Name);
                                    GenBatches.Insert;
                                end;//General Jnr Batches

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := Members."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description := Format(GenJournalLine."transaction type"::"Deposit Contribution") + ' Loan Recovery';
                                GenJournalLine.Amount := (LoansRegister."Outstanding Balance" + LoansRegister."Outstanding Interest" + (0.1 * LoansRegister."Outstanding Balance"));
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoansRegister."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Loan Interest Payment';
                                GenJournalLine.Amount := -LoansRegister."Outstanding Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    /* GenJournalLine.INSERT;
                                     GenSetUp.RESET;
                                     GenSetUp.GET;
                                     LoanProductsSetup.RESET;

                                     IF LoanProductsSetup.GET(LoansRegister."Loan Product Type") THEN BEGIN
                                         VarReceivableAccount:=LoanProductsSetup."Receivable Interest Account";
                                    //------------------------------------1. DEBIT INTEREST RECEIVABLE CONTROL A/C---------------------------------------------------------------------------------------------
                                     LineNo:=LineNo+10000;
                                     SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::" ",
                                     GenJournalLine."Account Type"::"G/L Account",GenSetUp."A/c Interest Receivable",TODAY,LoansRegister."Outstanding Interest",'BOSA',LoansRegister."Loan  No.",
                                     'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                                     //--------------------------------(Debit Member Loan Account)---------------------------------------------

                                     //------------------------------------2. CREDIT MEMBER INTEREST RECEIVABLE A/C---------------------------------------------------------------------------------------------
                                     LineNo:=LineNo+10000;
                                     SFactory.FnCreateGnlJournalLine('GENERAL',batch,docNo,LineNo,GenJournalLine."Transaction Type"::"Interest Due",
                                     GenJournalLine."Account Type"::"G/L Account",VarReceivableAccount,TODAY,LoansRegister."Outstanding Interest"*-1,'BOSA',LoansRegister."Loan  No.",
                                     'Interest Paid- '+'-'+LoansRegister."Loan  No.",LoansRegister."Loan  No.");
                                     //----------------------------------(CREDIT MEMBER INTEREST RECEIVABLE A/C-)------------------------------------------------

                                     END;
                                     */
                    LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoansRegister."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := docNo;
                                GenJournalLine."External Document No." := docNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Loan Repayment';
                                GenJournalLine.Amount := -LoansRegister."Outstanding Balance";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Repayment;
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                /*LineNo:=LineNo+10000;
                                GenJournalLine.INIT;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":=batch;
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                                GenJournalLine."Account No.":=LoansRegister."Client Code";
                                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=docNo;
                                GenJournalLine."External Document No.":=docNo;
                                GenJournalLine."Posting Date":=TODAY;
                                GenJournalLine.Description:='Loan penalty';
                                GenJournalLine.Amount:=-(0.1* LoansRegister."Outstanding Balance");
                                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::pe
                                IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
                                GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                END;
                                GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                                IF GenJournalLine.Amount<>0 THEN
                                GenJournalLine.INSERT;
                                */

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", batch);
                                if GenJournalLine.Find('-') then begin
                                    repeat
                                        GLPosting.Run(GenJournalLine);
                                    until GenJournalLine.Next = 0;


                                    MpesaDisbus."Penalty Date" := Today;
                                    MpesaDisbus."3rd Notification" := true;
                                    MpesaDisbus.Modify;

                                    msg := 'Dear ' + SplitString(Members.Name, ' ') + ', Your ' + LoansRegister."Loan Product Type Name" + ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance")
                                    + ' has been recovered from Deposits ';
                                    SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');
                                end;
                            end;
                        end;   // recover from deposit

                        StartDate := DMY2Date(15, 1, 2026);
                        EndDate := DMY2Date(21, 1, 2026);
                        if (VarIssuedDate >= StartDate) and (VarIssuedDate <= EndDate) then begin // recover from deposit
                            exit;

                            if LoansRegister."Loan Product Type" = 'DIVIDEND5900' then begin
                                LoanProductsSetup.RESET;
                                LoanProductsSetup.SetFilter(LoanProductsSetup.Code, '%1', 'DIVIDEND');
                                LoanProductsSetup.SetRange("Availabe Mobile Loan", false);
                                IF LoanProductsSetup.FIND('-') THEN BEGIN
                                    exit;
                                end;//addition


                                docNo := 'INT' + LoansRegister."Doc No Used";
                                MpesaDisbus.Reset;
                                MpesaDisbus.SetRange(MpesaDisbus."Member No", Members."No.");
                                MpesaDisbus.SetRange(MpesaDisbus."Document No", LoansRegister."Doc No Used");
                                MpesaDisbus.SetRange(MpesaDisbus."Interest Charged", false);
                                if MpesaDisbus.Find('-') then begin
                                    InterestAmount := (LoanProductsSetup."Interest rate" / 100) * LoansRegister."Requested Amount";
                                    batch := 'MOBILELOAN';
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                    GenJournalLine.SetRange("Journal Batch Name", batch);
                                    GenJournalLine.DeleteAll;
                                    //end of deletion

                                    GenBatches.Reset;
                                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                                    GenBatches.SetRange(GenBatches.Name, batch);

                                    if GenBatches.Find('-') = false then begin
                                        GenBatches.Init;
                                        GenBatches."Journal Template Name" := 'GENERAL';
                                        GenBatches.Name := batch;
                                        GenBatches.Description := 'mobile loan charged';
                                        GenBatches.Validate(GenBatches."Journal Template Name");
                                        GenBatches.Validate(GenBatches.Name);
                                        GenBatches.Insert;
                                    end;//General Jnr Batches

                                    //Cr Interest Eloan
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := batch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                    GenJournalLine."Account No." := Members."No.";
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := docNo;
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Interest charged on ' + LoansRegister."Loan  No.";
                                    GenJournalLine.Amount := ROUND(InterestAmount, 1, '>');
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                    end;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                    if GenJournalLine.Amount <> 0 then
                                        // GenJournalLine.Insert;

                                        //Cr Interest Eloan
                                        LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := batch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                    if LoanProductsSetup.Get(LoansRegister."Loan Product Type") then begin
                                        GenJournalLine."Account No." := LoanProductsSetup."Receivable Interest Account";
                                    end;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := docNo;
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := docNo + ' ' + 'Interest charged';
                                    GenJournalLine.Amount := ROUND(InterestAmount, 1, '>') * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);

                                    if LoansRegister.Source = LoansRegister.Source::BOSA then begin
                                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
                                    end;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                    GenJournalLine.SetRange("Journal Batch Name", batch);
                                    if GenJournalLine.Find('-') then begin
                                        repeat
                                            GLPosting.Run(GenJournalLine);
                                        until GenJournalLine.Next = 0;


                                        //MpesaDisbus."Penalty Date" := Today;
                                        MpesaDisbus."Interest Charged" := true;
                                        MpesaDisbus.Modify;

                                        msg := 'Dear ' + SplitString(Members.Name, ' ') + ', Your ' + LoansRegister."Loan Product Type Name" + ' of amount Ksh. ' + Format(LoansRegister."Outstanding Balance")
                                        + ' has been recovered from Deposits ';
                                        // SMSMessagewithTime(LoansRegister."Doc No Used", LoansRegister."Client Code", Members."Mobile Phone No", msg, '');
                                    end;
                                end;
                            end;
                        end;   // recover from deposit

                    end;

                end;

            until LoansRegister.Next = 0;
        end;
        //==================================send e loan notification  to members
        /*        ObjMember.RESET;
             //   Members.SETFILTER(Members."No.",'<>%1','');
                ObjMember.SETRANGE(ObjMember.Status,ObjMember.Status::Active);
                //ObjMember.SETFILTER(ObjMember."E loan Notification Date",'>=%1', ObjMember.Blocked::" ");
                IF ObjMember.FINDSET THEN BEGIN
                  REPEAT
                  varMemberNo:=ObjMember."No.";
                  EloanAmt:=0;
                  NotificationDate:=ObjMember."E loan Notification Date";
                  EloanAmt:=AdvanceEligibility(varMemberNo);
                  IF NotificationDate=0D THEN BEGIN
                    IF (EloanAmt>6) THEN BEGIN
                      msg:='Dear '+SplitString(ObjMember.Name,' ')+',Do you know you qualify for ELOAN  of Ksh. '+FORMAT(EloanAmt)
                       +' Dial *850# or use Digipesa app to apply now. ';
                        SMSMessagewithTime(ObjMember."No.",ObjMember."No.",ObjMember."Mobile Phone No",msg,'');
                      ObjMember."E loan Notification Date":=CALCDATE('1M',TODAY);
                      ObjMember.MODIFY;
                    END;
                    END ELSE IF (NotificationDate<>0D) THEN BEGIN
                      IF (TODAY>=NotificationDate) THEN BEGIN
                         IF (EloanAmt>6) THEN BEGIN
                           msg:='Dear '+SplitString(ObjMember.Name,' ')+',Do you know you qualify for ELOAN  of Ksh. '+FORMAT(EloanAmt)
                         +' Dial *850# or use Digipesa app to apply now. ';
                          SMSMessagewithTime(ObjMember."No.",ObjMember."No.",ObjMember."Mobile Phone No",msg,'');
                            ObjMember."E loan Notification Date":=CALCDATE('1M',TODAY);
                            ObjMember.MODIFY;
                        END;

                     END;
                    END;
                   UNTIL ObjMember.NEXT=0;
                 END;
      BEGIN
      SendSchedulesms();
      END;
      */

    end;

    procedure GetCharge(amount: Decimal; "Code": Code[50]) charge: Decimal

    var
        TariffDetails: Record "Tariff Details";
    begin
        TariffDetails.RESET;
        TariffDetails.SETRANGE(TariffDetails.Code, Code);
        TariffDetails.SETFILTER(TariffDetails."Lower Limit", '<=%1', amount);
        TariffDetails.SETFILTER(TariffDetails."Upper Limit", '>=%1', amount);
        IF TariffDetails.FIND('-') THEN BEGIN
            charge := TariffDetails."Charge Amount";
        END
    end;

    local procedure PostJournals(batch: Code[50]) result: Boolean
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", batch);
        if GenJournalLine.Find('-') then begin
            repeat
                GLPosting.Run(GenJournalLine);
            until GenJournalLine.Next = 0;

            result := true;

        end;
    end;

    local procedure SendSchedulesms()
    var
        PrincipalAmount: Decimal;
        TransactionLoanDiff: Decimal;
        LoanRepaymentS: Record "Loan Repayment Schedule";
        Fulldate: Date;
        LastRepayDate: Date;
        TransactionLoanAmt: Decimal;
        RepayedLoanAmt: Decimal;
        LoanSMSNotice: Record "Loans Register";
        loanNotificationDate: Date;
        amtsecondnotice: Decimal;
        amtcompare: Decimal;
        memb: Record "Members Register";
        Loanbal: Decimal;
        repayamt: Decimal;
        amtloan: Decimal;
    begin
        //===============================================================loans
        /*LoansRegister.RESET;
        LoansRegister.SETRANGE(LoansRegister.Posted,TRUE);
        LoansRegister.SETFILTER(LoansRegister."Loan Product Type",'<>%1','ELOAN');
        LoansRegister.CALCFIELDS(LoansRegister."Outstanding Interest",LoansRegister."Outstanding Balance");
        LoansRegister.SETFILTER(LoansRegister."Outstanding Balance", '>%1',0);
        IF LoansRegister.FIND('-') THEN BEGIN
           REPEAT
         PrincipalAmount:=0;
         TransactionLoanDiff:=0;
          LoansRegister.CALCFIELDS(LoansRegister."Outstanding Interest",LoansRegister."Outstanding Balance");

        LoanSMSNotice.RESET;
        LoanSMSNotice.SETRANGE(LoanSMSNotice."Loan No",LoansRegister."Loan  No.");
        IF LoanSMSNotice.FIND('-') =FALSE THEN BEGIN
          LoanSMSNotice.RESET;
         IF LoanSMSNotice.FIND('+') THEN BEGIN
        iEntryNo:=LoanSMSNotice."Entry No";
        iEntryNo:=iEntryNo+1;
        END
        ELSE BEGIN
        iEntryNo:=1;
        END;
          LoanSMSNotice.INIT;
          LoanSMSNotice."Entry No":=iEntryNo;
          LoanSMSNotice."Loan No":=LoansRegister."Loan  No.";
          LoanSMSNotice.INSERT;
         END;

        LoanSMSNotice.RESET;
        LoanSMSNotice.SETRANGE(LoanSMSNotice."Loan No",LoansRegister."Loan  No.");
         IF LoanSMSNotice.FIND('-')  THEN BEGIN

// ============ifNot has arreas
        loanNotificationDate:=TODAY;
        TransactionLoanDiff:=LoansRegister."Outstanding Balance"+LoansRegister."Outstanding Interest";

          Members.RESET;
          Members.GET(LoansRegister."Client Code");
        IF TransactionLoanDiff>0 THEN BEGIN

//========== send if due date is today
          LoanRepay.RESET;
          LoanRepay.SETRANGE(LoanRepay."Loan No.",LoansRegister."Loan  No.");
          LoanRepay.SETRANGE(LoanRepay."Repayment Date",TODAY);
          IF LoanRepay.FIND('-') THEN BEGIN

               IF (LoanSMSNotice."SMS Due Date today"=0D) OR (LoanSMSNotice."SMS Due Date today"=TODAY) THEN BEGIN
                  LoanSMSNotice."SMS Due Date today":=CALCDATE('1M',TODAY);
                  LoanSMSNotice.MODIFY;
                  IF (TransactionLoanDiff<=LoanRepay."Monthly Repayment") THEN
                    amtloan:=TransactionLoanDiff
                  ELSE
                    amtloan:=LoanRepay."Monthly Repayment";
                   msg:='Dear '+SplitString(Members.Name,' ')+', Your monthly loan repayment for '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '
                   +FORMAT(amtloan,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
                   +' is due today'+' kindly make the repayment to avoid attracting extra penalties';
                  SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Mobile Phone No",msg,'');

         END;
      END;

//========== send if due date is  7 Day
        LoanRepay.RESET;
        LoanRepay.SETRANGE(LoanRepay."Loan No.",LoansRegister."Loan  No.");
        LoanRepay.SETRANGE(LoanRepay."Repayment Date",CALCDATE('7D',TODAY));
        IF LoanRepay.FIND('-') THEN BEGIN

             IF (LoanSMSNotice."SMS 7 Day"=0D) OR (LoanSMSNotice."SMS 7 Day"=CALCDATE('7D',TODAY)) THEN BEGIN
                LoanSMSNotice."SMS 7 Day":=CALCDATE('1M',CALCDATE('7D',TODAY));
                LoanSMSNotice.MODIFY;

                IF (TransactionLoanDiff<=LoanRepay."Monthly Repayment") THEN
                    amtloan:=TransactionLoanDiff
                  ELSE
                    amtloan:=LoanRepay."Monthly Repayment";
                 msg:='Dear '+SplitString(Members.Name,' ')+', Your monthly loan repayment for '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '
                 +FORMAT(amtloan,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
                 +' is due within next 7 days'
                +' kindly make the repayment to avoid attracting extra penalties';
                SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Mobile Phone No",msg,'');

       END;
        END;
        //MESSAGE(LoansRegister."Loan  No.");
        LoanRepay.RESET;
        LoanRepay.SETRANGE( LoanRepay."Loan No.",LoansRegister."Loan  No.");
        LoanRepay.SETFILTER(LoanRepay."Repayment Date", '..'+FORMAT(CALCDATE('CM+1D-2M', TODAY)));
        LoanRepay.CALCSUMS(LoanRepay."Monthly Repayment");
        loanamt:=LoanRepay."Monthly Repayment"/4;
        amtsecondnotice:=FnGetOutstandingBal(LoansRegister."Loan  No.")/4;
        repayamt:=LoansRegister.Repayment*4;
        Loanbal:=loanamt-amtsecondnotice;
        IF (Loanbal>repayamt) THEN BEGIN

          IF (LoanSMSNotice."Notice SMS 1"=0D) OR (LoanSMSNotice."Notice SMS 1"<=TODAY) THEN BEGIN
            LoanSMSNotice."Notice SMS 1":=CALCDATE('1M',TODAY);
            LoanSMSNotice.MODIFY;


            msg:='Dear '+SplitString(Members.Name,' ')+', Your loan repayment for '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
            +' is due on Arrears for 4 Months';
            SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Mobile Phone No",msg,'');

              LoanGuaranteeDetails.RESET;
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Loan No",LoanSMSNotice."Loan No");
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Self Guarantee",FALSE);
              IF LoanGuaranteeDetails.FIND('-') THEN BEGIN
                REPEAT
                  memb.RESET;
                  memb.SETRANGE(memb."No.",LoanGuaranteeDetails."Member No");
                  IF memb.FIND('-') THEN BEGIN
                     msg:='Dear '+SplitString(memb.Name,' ')+',Your Guarantee '+ Members.Name +' has defaulted loan amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
                +' for 4 Months';
                SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",memb."Mobile Phone No",msg,'');
                  END;
                UNTIL LoanGuaranteeDetails.NEXT =0;

              END;
            END;

          END;

// Second Notice
        LoanRepay.RESET;
        LoanRepay.SETRANGE( LoanRepay."Loan No.",LoansRegister."Loan  No.");
        LoanRepay.SETFILTER(LoanRepay."Repayment Date",'..'+FORMAT(CALCDATE('CM+1D-2M', TODAY)));//FORMAT(CALCDATE('CM+1D-3M', TODAY))+'..'+FORMAT(CALCDATE('CM',TODAY)));
        LoanRepay.CALCSUMS(LoanRepay."Monthly Repayment");
        loanamt:=LoanRepay."Monthly Repayment"/5;
        amtsecondnotice:=FnGetOutstandingBal(LoansRegister."Loan  No.")/5;
        repayamt:=LoansRegister.Repayment*5;
        Loanbal:=loanamt-amtsecondnotice;
        IF (Loanbal>repayamt) THEN BEGIN

          IF (LoanSMSNotice."Notice SMS 2"=0D) OR (LoanSMSNotice."Notice SMS 2"<=TODAY) THEN BEGIN
            LoanSMSNotice."Notice SMS 2":=CALCDATE('1M',TODAY);
            LoanSMSNotice.MODIFY;
            msg:='Dear '+SplitString(Members.Name,' ')+', Your loan repayment for '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
            +' is due on Arrears for 5 Months';
            SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Mobile Phone No",msg,'');

              LoanGuaranteeDetails.RESET;
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Loan No",LoanSMSNotice."Loan No");
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Self Guarantee",FALSE);
              IF LoanGuaranteeDetails.FIND('-') THEN BEGIN
                REPEAT
                  memb.RESET;
                  memb.SETRANGE(memb."No.",LoanGuaranteeDetails."Member No");
                  IF memb.FIND('-') THEN BEGIN
                     msg:='Dear '+SplitString(memb.Name,' ')+', Your Guarantee '+ Members.Name +' has defaulted loan amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
                +' for period of 5 Months';
                SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",memb."Mobile Phone No",msg,'');
                  END;
                UNTIL LoanGuaranteeDetails.NEXT =0;

              END;
            END;

          END;

// Third Notice
        LoanRepay.RESET;
        LoanRepay.SETRANGE( LoanRepay."Loan No.",LoansRegister."Loan  No.");
        LoanRepay.SETFILTER(LoanRepay."Repayment Date",'..'+FORMAT(CALCDATE('CM+1D-2M', TODAY)));
        LoanRepay.CALCSUMS(LoanRepay."Monthly Repayment",LoanRepay."Monthly Interest");
         loanamt:=LoanRepay."Monthly Repayment"/6;
        amtsecondnotice:=FnGetOutstandingBal(LoansRegister."Loan  No.")/6;

        repayamt:=LoansRegister.Repayment*6;
        Loanbal:=loanamt-amtsecondnotice;
        IF (Loanbal>repayamt) THEN BEGIN

          IF (LoanSMSNotice."Notice SMS 3"=0D) OR (LoanSMSNotice."Notice SMS 3"<=TODAY) THEN BEGIN
            LoanSMSNotice."Notice SMS 3":=CALCDATE('1M',TODAY);
            LoanSMSNotice.MODIFY;
            msg:='Dear '+SplitString(Members.Name,' ')+', Your loan repayment for '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
            +' is due on Arrears for 6 Months';
            SMSMessage(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Mobile Phone No",msg,'');

              LoanGuaranteeDetails.RESET;
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Loan No",LoanSMSNotice."Loan No");
              LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Self Guarantee",FALSE);
              IF LoanGuaranteeDetails.FIND('-') THEN BEGIN
                REPEAT
                  memb.RESET;
                  memb.SETRANGE(memb."No.",LoanGuaranteeDetails."Member No");
                  IF memb.FIND('-') THEN BEGIN
                     msg:='Dear '+SplitString(memb.Name,' ')+', Your Guarantee '+ Members.Name +' has defaulted loan amount Ksh. '+FORMAT(TransactionLoanDiff,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
                +' for period of 6 Months';
                SMSMessagewithTime(LoansRegister."Doc No Used",LoansRegister."Client Code",memb."Mobile Phone No",msg,'');
                  END;
                UNTIL LoanGuaranteeDetails.NEXT =0;

              END;
            END;

          END;


          END ELSE BEGIN

          END;
        END;





      //  END;//LOAN NOTICE TBL
        //END;



        UNTIL LoansRegister.NEXT=0;
END;
*/

    end;


    procedure FnGetOutstandingBal(LoanNo: Code[50]) amout: Decimal
    begin
        amout := 0;
        MemberLedgerEntry.Reset;
        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoanNo);
        // MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '=%1|=%2', MemberLedgerEntry."transaction type"::"Interest Paid", MemberLedgerEntry."Transaction Type"::Repayment);
        MemberLedgerEntry.CalcSums(MemberLedgerEntry."Credit Amount (LCY)");
        amout := MemberLedgerEntry."Credit Amount (LCY)";
    end;


    procedure SMSMessagewithTime(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[250]; addition: Text[250])
    begin
        iEntryNo := 0;
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'MOBILETRAN';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        //  SMSMessages."Additional sms":=addition;
        SMSMessages."Telephone No" := phone;
        // SMSMessages.ScheduleTime:=CREATEDATETIME(TODAY,070000T);
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;

    local procedure FnGetaccountbal(account: Code[50]) accbal: Decimal
    begin
        Members.Reset;
        Members.SetRange(Members."No.", account);
        //  Members.SETRANGE(Members."Subscribed for SMS", TRUE);
        if Members.Find('-') then begin

            // REPEAT
            Members.CalcFields(Members."Balance (LCY)");
            //Members.CALCFIELDS(Members."ATM Transactions");
            //Members.CALCFIELDS(Members."Uncleared Cheques");
            //Members.CALCFIELDS(Members."EFT Transactions");
            //Members.CALCFIELDS(Members."Mobile Transactions");
            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
            if AccountTypes.Find('-') then begin
                miniBalance := AccountTypes."Minimum Balance";
            end;//fosa balances is returning zero// this function is for shortcode. yes this is what is returning zerof for fosa blances
            accBalance := Members."Balance (LCY)" + miniBalance;//-(Members."ATM Transactions"+Members."Uncleared Cheques"+Members."EFT Transactions"+Members."Mobile Transactions"+miniBalance);
            accbal := accBalance;
        end;
    end;


    procedure AccountBalanceDec(Acc: Code[30]; amt: Decimal) Bal: Decimal
    begin
        begin
            Bal := 0;
            Members.Reset;
            Members.SetRange(Members."No.", Acc);
            Members.SetRange(Members.Blocked, Members.Blocked::" ");
            if Members.Find('-') then begin

                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");
                GenLedgerSetup.TestField(GenLedgerSetup."Mobile Comm Account");
                GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");

                /*Charges.RESET;
                Charges.SETRANGE(Charges.Code,GenLedgerSetup."Mobile Charge");
                IF Charges.FIND('-') THEN BEGIN
                  Charges.TESTFIELD(Charges."GL Account");
                  */

                //  END;
                MPESACharge := GetCharge(amt, 'MPESA');
                CloudPESACharge := GetCharge(amt, 'VENDWD');
                MobileCharges := GetCharge(amt, 'SACCOWD');
                if amt = 3 then begin
                    MobileCharges := GetCharge(amount, 'DIVIDEND');
                end;

                ExcDuty := (20 / 100) * (MobileCharges + CloudPESACharge);
                TotalCharges := CloudPESACharge + MobileCharges + ExcDuty + MPESACharge;
                Bal := Bal - TotalCharges;
            end else begin
                Members.Reset;
                Members.SetRange(Members."No.", Acc);
                //Members.SETRANGE(Members."Account Type",'M-WALLET');
                if Members.Find('-') then begin
                    Members.CalcFields("Balance (LCY)");
                    GenLedgerSetup.Reset;
                    GenLedgerSetup.Get;
                    GenLedgerSetup.TestField(GenLedgerSetup."Mobile Comm Account");
                    GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
                    Bal := Members."Balance (LCY)";
                    MPESACharge := GetCharge(amt, 'MPESA');
                    CloudPESACharge := GetCharge(amt, 'VENDWD');
                    MobileCharges := GetCharge(amt, 'M-WALLET');

                    ExcDuty := 0;//(20/100)*(MobileCharges+CloudPESACharge);
                    TotalCharges := CloudPESACharge + MobileCharges + ExcDuty + MPESACharge;
                    Bal := Bal - TotalCharges;
                end;
            end;
        end;

    end;


    procedure PostMPESATransToFOSA(docNo: Text[20]; telephoneNo: Text[20]; amount: Decimal; transactionDate: Date; AppType: Code[100]) result: Text[30]
    var
        objvendor: Record Vendor;
    begin

        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", docNo);
        if CloudPESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end
        else begin

            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");
            //GenLedgerSetup.TestField(GenLedgerSetup."MPESA Recon Acc");
            //GenLedgerSetup.TestField(GenLedgerSetup."Mobile Comm Account");
            /* // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");

              Charges.RESET;
              Charges.SETRANGE(Charges.Code,GenLedgerSetup."Mobile Charge");
              IF Charges.FIND('-') THEN BEGIN
                Charges.TESTFIELD(Charges."GL Account");


              END;
              */
            MPESACharge := GetCharge(amount, 'MPESA');
            CloudPESACharge := GetCharge(amount, 'VENDWD');
            MobileCharges := GetCharge(amount, 'M-WALLET');

            CloudPESACommACC := '400-100-227';// GenLedgerSetup."Mobile Comm Account";
            MPESARecon := 'BNK002';// GenLedgerSetup."MPESA Recon Acc";
            MobileChargesACC := '400-100-227';//Charges."GL Account";

            ExcDuty := 0;//(20/100)*(MobileCharges);
            TotalCharges := CloudPESACharge + MobileCharges + ExcDuty + MPESACharge;
            objvendor.Reset;
            objvendor.SetRange(objvendor."No.", telephoneNo);
            //Members.SETRANGE(Members."Account Type", 'M-WALLET');

            if objvendor.Find('-') then begin
                objvendor.CalcFields(objvendor."Balance (LCY)");
                //Members.CALCFIELDS(Members."ATM Transactions");
                //Members.CALCFIELDS(Members."Uncleared Cheques");
                // Members.CALCFIELDS(Members."EFT Transactions");
                // Members.CALCFIELDS(Members."Mobile Transactions");
                TempBalance := objvendor."Balance (LCY)";
                if (TempBalance > 0) then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                    GenJournalLine.DeleteAll;
                    //end of deletion
                    //c
                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    GenBatches.SetRange(GenBatches.Name, 'MPESAWITHD');

                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'GENERAL';
                        GenBatches.Name := 'MPESAWITHD';
                        GenBatches.Description := 'MPESA Withdrawal';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                    end;

                    //DR Customer Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := objvendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := objvendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'MPESA withdrawal to ' + objvendor."Mobile Phone No";
                    GenJournalLine.Amount := amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := objvendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := objvendor."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'MPESA withdrawal charges ' + objvendor."Mobile Phone No";
                    GenJournalLine.Amount := TotalCharges;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Cr MPESA ACC
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := MPESARecon;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Members."No.";
                    GenJournalLine."Source No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'M-WALLET MPESA withdrawal ' + objvendor."No." + '-' + objvendor.Name;
                    GenJournalLine.Amount := (amount + TotalCharges) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                        GenJournalLine.DeleteAll;

                        msg := 'You have withdrawn KES ' + Format(amount) + ' from Account ' + objvendor.Name +
                      ' .Thank you for using Shofco Sacco Mobile.';

                        CloudPESATrans.Init;
                        CloudPESATrans."Document No" := docNo;
                        CloudPESATrans.Description := 'MPESA Withdrawal - ' + Members.Name;
                        CloudPESATrans."Document Date" := Today;
                        CloudPESATrans."Account No" := Members."No.";
                        TotalCharges := ExcDuty + MobileCharges + CloudPESACharge;
                        CloudPESATrans.Charge := TotalCharges;
                        CloudPESATrans."Account Name" := Members.Name;
                        CloudPESATrans."Telephone Number" := telephoneNo;
                        //CloudPESATrans."SMS Message" := msg;
                        CloudPESATrans.Amount := amount;
                        CloudPESATrans.Status := CloudPESATrans.Status::Completed;
                        CloudPESATrans.Posted := true;
                        CloudPESATrans."Posting Date" := Today;
                        CloudPESATrans.Comments := 'Success';
                        CloudPESATrans.Client := Members."No.";
                        CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Withdrawal;
                        CloudPESATrans."Transaction Time" := Time;
                        CloudPESATrans.Insert;
                        result := 'TRUE';

                        SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');
                    end;

                end
                else begin
                    result := 'INSUFFICIENT';
                    /* msg:='You have insufficient funds in your savings Account to use this service.'+
                    ' .Thank you for using KENCREAM Sacco Mobile.';
                    SMSMessage(docNo,Members."No.",Members."Phone No.",msg);*/
                    CloudPESATrans.Init;
                    CloudPESATrans."Document No" := docNo;
                    CloudPESATrans.Description := 'MPESA Withdrawal';
                    CloudPESATrans."Document Date" := Today;
                    CloudPESATrans."Account No" := Members."No.";
                    //CloudPESATrans."Account No2" := MPESARecon;
                    TotalCharges := ExcDuty + MobileCharges + CloudPESACharge;
                    CloudPESATrans.Charge := TotalCharges;
                    CloudPESATrans."Account Name" := Members.Name;
                    CloudPESATrans."Telephone Number" := telephoneNo;
                    CloudPESATrans.Amount := amount;
                    CloudPESATrans.Status := CloudPESATrans.Status::Failed;
                    CloudPESATrans.Posted := false;
                    CloudPESATrans."Posting Date" := Today;
                    CloudPESATrans.Comments := 'Failed,Insufficient Funds';
                    CloudPESATrans.Client := Members."No.";
                    CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Withdrawal;
                    CloudPESATrans."Transaction Time" := Time;
                    CloudPESATrans.Insert;
                end;
            end
            else begin
                result := 'ACCINEXISTENT';
                /* msg:='Your request has failed because account does not exist.'+
                 ' .Thank you for using KENCREAM Sacco Mobile.';
                 SMSMessage(docNo,Members."No.",Members."Phone No.",msg);*/
                CloudPESATrans.Init;
                CloudPESATrans."Document No" := docNo;
                CloudPESATrans.Description := 'MPESA Withdrawal';
                CloudPESATrans."Document Date" := Today;
                CloudPESATrans."Account No" := '';
                //CloudPESATrans."Account No2" := MPESARecon;
                CloudPESATrans.Amount := amount;
                CloudPESATrans.Posted := false;
                CloudPESATrans."Posting Date" := Today;
                CloudPESATrans.Comments := 'Failed,Invalid Account';
                CloudPESATrans.Client := '';
                CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Withdrawal;
                CloudPESATrans."Transaction Time" := Time;
                CloudPESATrans.Insert;
            end;
        end;

    end;


    procedure PostMPESATrans(docNo: Text[20]; telephoneNo: Text[20]; amount: Decimal; transactionDate: Date; AppType: Code[100]) result: Text[30]
    var
        objvendor: Record Vendor;
    begin

        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", docNo);
        CloudPESATrans.SetRange(CloudPESATrans.Posted, true);
        if CloudPESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end
        else begin

            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");
            // GenLedgerSetup.TestField(GenLedgerSetup."MPESA Recon Acc");
            // GenLedgerSetup.TestField(GenLedgerSetup."Mobile Comm Account");
            /* // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");

              Charges.RESET;
              Charges.SETRANGE(Charges.Code,GenLedgerSetup."Mobile Charge");
              IF Charges.FIND('-') THEN BEGIN
                Charges.TESTFIELD(Charges."GL Account");


              END;
              */
            objvendor.Reset;
            objvendor.SetRange(objvendor."No.", telephoneNo);
            if objvendor.Find('-') then begin
                result := PostMPESATransToFOSA(docNo, telephoneNo, amount, transactionDate, AppType);
                exit;
            end;
            if AppType = '4' then begin
                result := PostMPESATransToFOSA(docNo, telephoneNo, amount, transactionDate, AppType);
                exit
            end;
            MPESACharge := GetCharge(amount, 'MPESA');
            CloudPESACharge := GetCharge(amount, 'VENDWD');
            MobileCharges := GetCharge(amount, 'SACCOWD');
            if AppType = '3' then begin
                MobileCharges := GetCharge(amount, 'DIVIDEND');
            end;


            CloudPESACommACC := GenLedgerSetup."Mobile Comm Account";
            MPESARecon := GenLedgerSetup."MPESA Recon Acc";
            MobileChargesACC := '32009';//Charges."GL Account";

            ExcDuty := 0;//(20/100)*(MobileCharges);
            TotalCharges := CloudPESACharge + MobileCharges + ExcDuty + MPESACharge;
            Members.Reset;
            Members.SetRange(Members."No.", telephoneNo);
            Members.SetRange(Members.Blocked, Members.Blocked::" ");
            if Members.Find('-') then begin
                TempBalance := 0;
                if AppType = '1' then begin
                    //    Members.CALCFIELDS(Members."Watoto Savings");
                    TempBalance := 0;//Members."Watoto Savings";
                end;

                if (TempBalance > amount) then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                    GenJournalLine.DeleteAll;
                    //end of deletion

                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    GenBatches.SetRange(GenBatches.Name, 'MPESAWITHD');

                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'GENERAL';
                        GenBatches.Name := 'MPESAWITHD';
                        GenBatches.Description := 'MPESA Withdrawal';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                    end;

                    //DR Customer Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := Members."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := docNo;
                    GenJournalLine."Posting Date" := Today;

                    if AppType = '3' then
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Dividend;

                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Description := Format(GenJournalLine."Transaction Type") + ' Withdrawal to MPESA';
                    GenJournalLine.Amount := amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Cr Bank a/c
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := MPESARecon;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;

                    if AppType = '3' then
                        appdesc := Format(GenJournalLine."transaction type"::Dividend);

                    GenJournalLine.Description := appdesc + ' MPESA Withdrawal-' + Members."No.";
                    GenJournalLine.Amount := (amount) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Cr Bank a/c CHARGES
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := MPESARecon;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := Members."No.";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'MPESA Withdrawal Charges-' + Members."No." + '' + Members.Name;
                    GenJournalLine.Amount := (MPESACharge) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Dr Withdrawal Charges

                    //CR Surestep Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := CloudPESACommACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Mobile Withdrawal Charges';
                    GenJournalLine.Amount := -CloudPESACharge;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //CR Mobile Transactions Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := MobileChargesACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Mobile Withdrawal Charges';
                    GenJournalLine.Amount := MobileCharges * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Surestep Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := CloudPESACommACC;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := MobileChargesACC;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Mobile Withdrawal Charges';
                    GenJournalLine.Amount := -CloudPESACharge;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //CR Excise Duty
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := Format(ExxcDuty);
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := docNo;
                    GenJournalLine."External Document No." := docNo;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Excise duty';
                    GenJournalLine.Amount := ExcDuty * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                        GenJournalLine.DeleteAll;
                        msg := 'You have withdrawn KES ' + Format(amount) + ' from Account ' + Members.Name +
                      ' .Thank you for using Vision Sacco Mobile.';

                        CloudPESATrans.Init;
                        CloudPESATrans."Document No" := docNo;
                        CloudPESATrans.Description := 'MPESA Withdrawal - ' + Members.Name;
                        CloudPESATrans."Document Date" := Today;
                        CloudPESATrans."Account No" := Members."No.";
                        TotalCharges := ExcDuty + MobileCharges + CloudPESACharge;
                        CloudPESATrans.Charge := TotalCharges;
                        CloudPESATrans."Account Name" := Members.Name;
                        CloudPESATrans."Telephone Number" := telephoneNo;
                        CloudPESATrans.Amount := amount;
                        CloudPESATrans.Status := CloudPESATrans.Status::Completed;
                        CloudPESATrans.Posted := true;
                        CloudPESATrans."Posting Date" := Today;
                        CloudPESATrans.Comments := 'Success';
                        CloudPESATrans.Client := Members."No.";
                        CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Withdrawal;
                        CloudPESATrans."Transaction Time" := Time;
                        CloudPESATrans.Insert;
                        result := 'TRUE';

                        SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');
                    end;
                end
                else begin
                    result := 'INSUFFICIENT';
                    /* msg:='You have insufficient funds in your savings Account to use this service.'+
                    ' .Thank you for using KENCREAM Sacco Mobile.';
                    SMSMessage(docNo,Members."No.",Members."Phone No.",msg);*/
                    CloudPESATrans.Init;
                    CloudPESATrans."Document No" := docNo;
                    CloudPESATrans.Description := 'MPESA Withdrawal';
                    CloudPESATrans."Document Date" := Today;
                    CloudPESATrans."Account No" := Members."No.";
                    TotalCharges := ExcDuty + MobileCharges + CloudPESACharge;
                    CloudPESATrans.Charge := TotalCharges;
                    CloudPESATrans."Account Name" := Members.Name;
                    CloudPESATrans."Telephone Number" := telephoneNo;
                    CloudPESATrans.Amount := amount;
                    CloudPESATrans.Status := CloudPESATrans.Status::Failed;
                    CloudPESATrans.Posted := false;
                    CloudPESATrans."Posting Date" := Today;
                    CloudPESATrans.Comments := 'Failed,Insufficient Funds';
                    CloudPESATrans.Client := Members."No.";
                    CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Withdrawal;
                    CloudPESATrans."Transaction Time" := Time;
                    CloudPESATrans.Insert;
                end;
            end
            else begin
                result := 'ACCINEXISTENT';
                /* msg:='Your request has failed because account does not exist.'+
                 ' .Thank you for using KENCREAM Sacco Mobile.';
                 SMSMessage(docNo,Members."No.",Members."Phone No.",msg);*/
                CloudPESATrans.Init;
                CloudPESATrans."Document No" := docNo;
                CloudPESATrans.Description := 'MPESA Withdrawal';
                CloudPESATrans."Document Date" := Today;
                CloudPESATrans."Account No" := '';
                CloudPESATrans.Amount := amount;
                CloudPESATrans.Posted := false;
                CloudPESATrans."Posting Date" := Today;
                CloudPESATrans.Comments := 'Failed,Invalid Account';
                CloudPESATrans.Client := '';
                CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Withdrawal;
                CloudPESATrans."Transaction Time" := Time;
                CloudPESATrans.Insert;
            end;
        end;

    end;

    local procedure FnGetMemberNo(phoneNo: Code[100]) Acount: Code[100]
    begin
        Members.Reset;
        Members.SetRange(Members."Mobile Phone No", phoneNo);
        if Members.Find('-') then begin
            Acount := Members."No.";
            exit;
        end;
        Members.Reset;
        Members.SetRange(Members."Phone No.", phoneNo);
        if Members.Find('-') then begin
            Acount := Members."No.";
            exit;
        end;

        Members.Reset;
        Members.SetRange(Members."Mobile Phone No", '+254' + CopyStr(phoneNo, 4, 15));
        if Members.Find('-') then begin
            Acount := Members."No.";
            exit;
        end;
        Members.Reset;
        Members.SetRange(Members."Phone No.", '0' + CopyStr(phoneNo, 4, 15));
        if Members.Find('-') then begin
            Acount := Members."No.";
            exit;
        end;
    end;


    procedure PostAccountBalFOSA(docNo: Text[20]; telephoneNo: Text[20]; amount: Decimal; transactionDate: Date; AppType: Code[100]; accountNo: Code[30]) result: Text[30]
    begin

        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", docNo);
        if CloudPESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end
        else begin

            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");
            // GenLedgerSetup.TESTFIELD(GenLedgerSetup."MPESA Settl Acc");
            // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Comm Account");
            /* // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Mobile Charge");

              Charges.RESET;
              Charges.SETRANGE(Charges.Code,GenLedgerSetup."Mobile Charge");
              IF Charges.FIND('-') THEN BEGIN
                Charges.TESTFIELD(Charges."GL Account");


              END;
              */

            MPESACharge := GetCharge(amount, 'MPESA');
            CloudPESACharge := GetCharge(amount, 'VENDWD');
            MobileCharges := GetCharge(amount, 'SACCOWD');

            // CloudPESACommACC:=  GenLedgerSetup."Mobile Comm Account";
            // MPESARecon:=GenLedgerSetup."MPESA Settl Acc";
            MobileChargesACC := '32009';//Charges."GL Account";

            ExcDuty := 0;//(20/100)*(MobileCharges);
            TotalCharges := CloudPESACharge + MobileCharges + ExcDuty + MPESACharge;
            Members.Reset;
            Members.SetRange(Members."No.", accountNo);
            Members.SetRange(Members.Blocked, Members.Blocked::" ");
            if Members.Find('-') then begin
                TempBalance := 0;
                if AppType = '1' then begin
                    Members.CalcFields(Members."Current Shares");
                    TempBalance := Members."Current Shares";
                    msg := 'Dear ' + SplitString(Members.Name, ' ') + ' Your Savings A/C Balance is Ksh.' + Format(TempBalance)
                                 + ' .Thank you for using Vision Sacco Mobile.';
                    SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');
                end;
                if AppType = '2' then begin
                    Members.CalcFields(Members."Shares Retained");
                    TempBalance := Members."Shares Retained";
                    msg := 'Dear ' + SplitString(Members.Name, ' ') + ' Your Shares A/C Balance is Ksh.' + Format(TempBalance)
                               + ' .Thank you for using Vision Sacco Mobile.';
                    SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');
                end;
                if AppType = '3' then begin
                    Members.CalcFields(Members."Silver Savings");
                    TempBalance := Members."Silver Savings";

                    msg := 'Dear ' + SplitString(Members.Name, ' ') + ' Your Silver Savings A/C Balance is Ksh.' + Format(TempBalance)
                              + ' .Thank you for using Vision Sacco Mobile.';
                    SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');
                end;
                if AppType = '4' then begin
                    Members.CalcFields(Members."Dividend Amount");
                    TempBalance := Members."Dividend Amount";

                    msg := 'Dear ' + SplitString(Members.Name, ' ') + ' Your Dividend A/C Balance is Ksh.' + Format(TempBalance)
                              + ' .Thank you for using Vision Sacco Mobile.';
                    SMSMessage(docNo, Members."No.", Members."Mobile Phone No", msg, '');
                end;




                result := 'TRUE';
                CloudPESATrans.Init;
                CloudPESATrans."Document No" := docNo;
                CloudPESATrans.Description := ' ' + Members.Name;
                CloudPESATrans."Document Date" := Today;
                CloudPESATrans."Account No" := Members."No.";
                TotalCharges := 0;
                CloudPESATrans.Charge := TotalCharges;
                CloudPESATrans."Account Name" := Members.Name;
                CloudPESATrans."Telephone Number" := telephoneNo;
                CloudPESATrans.Amount := amount;
                CloudPESATrans.Status := CloudPESATrans.Status::Completed;
                CloudPESATrans.Posted := true;
                CloudPESATrans."Posting Date" := Today;
                CloudPESATrans.Comments := 'Success';
                CloudPESATrans.Client := Members."No.";
                CloudPESATrans."Transaction Type" := CloudPESATrans."transaction type"::Balance;
                CloudPESATrans."Transaction Time" := Time;
                CloudPESATrans.Insert;

            end;

        end;

    end;

    local procedure FNRegisteredmembers()
    var
        SaccoNoSeries: Record "Sacco No. Series";
        Newdoc: Code[50];
    begin

        Members.Reset;
        Members.SetRange(Members.Status, Members.Status::Active);
        Members.SetRange(Members.Blocked, Members.Blocked::" ");
        if Members.Find('-') then begin
            repeat
                if Members."ID No." <> '' then begin

                    if Members."Mobile Phone No" <> '' then begin

                        SurePESAApplications.Reset;
                        //  SurePESAApplications.SETRANGE(SurePESAApplications."Account No",Members."No.");
                        if SurePESAApplications.Find('+') then begin
                            Newdoc := IncStr(SurePESAApplications."No.")
                        end;
                        SurePESAApplications.Reset;
                        SurePESAApplications.SetRange(SurePESAApplications."Account No", Members."No.");
                        if SurePESAApplications.Find('-') = false then begin


                            SurePESAApplications.Init;
                            SurePESAApplications."No." := Newdoc;
                            SurePESAApplications."ID No" := Members."ID No.";
                            SurePESAApplications."Account Name" := Members.Name;
                            SurePESAApplications."Account No" := Members."No.";
                            SurePESAApplications.Telephone := Members."Mobile Phone No";
                            SurePESAApplications.Status := SurePESAApplications.Status::Approved;
                            SurePESAApplications."Created By" := UserId;
                            SurePESAApplications."Date Applied" := Today;
                            SurePESAApplications."Time Applied" := Time;
                            SurePESAApplications.Insert;


                        end;

                    end;
                end;


            until Members.Next = 0;
            Message('DONE');

        end;
    end;
}




