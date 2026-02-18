codeunit 131067 "Utapesa Loan Recovery"
{
    trigger OnRun()
    begin
        //RecoverUtapesaLoan();
        UtapesaReminder();
        InstantReminder();
        DailyUtapesaDefaultReminder()
    end;

    var
        LoansR: Record "Loans Register";
        IssuedDate: Integer;
        TodayI: Integer;
        LineNo: Integer;
        ExpectedDayOfCompletion: Date;
        TodayRef: Integer;
        SmsManagement: Codeunit "Sms Management";
        ReminderDate: Date;
        ReminderDateRef: Integer;
        AUFactory: Codeunit "Au Factory";
        BATCH_TEMPLATE: Label 'GENERAL';
        BATCH_NAME: Label 'UTAPESA';
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Customer: Record Customer;
        RecoveryMessage: Text;
        ReminderMessage: text;
        Date90: Date;
        Day183: Date;
        Day173: Date;
        Date87: Date;
        Date83: Date;

    procedure RecoverUtapesaLoan(LoanNo: Code[20]; ClientCode: Code[20])
    var
        Interest: Decimal;
        LoanType: Record "Loan Products Setup";
        DetailedLed: Record "Detailed Cust. Ledg. Entry";
        nextIntDate: Date;
    begin

        IssuedDate := 0;
        TodayI := 0;
        Interest := 0;
        RecoveryMessage := '';
        LoansR.Reset();
        LoansR.SetFilter("Outstanding Balance", '>%1', 0);
        LoansR.SetAutoCalcFields("Outstanding Balance");
        LoansR.SetFilter("Loan Product Type", '%1', 'UTAPESA');
        LoansR.SetFilter("Date filter", '..%1', Today);
        LoansR.SetRange("Loan  No.", LoanNo);
        if LoansR.Find('-') then begin
            if LoansR."Issued Date" >= Today then exit;
            if LoansR."Expected Date of Completion" > Today then exit;
            IssuedDate := Date2DMY(LoansR."Issued Date", 1);
            TodayI := Date2DMY(Today, 1);
            DetailedLed.Reset();
            DetailedLed.SetRange("Loan No", LoansR."Loan  No.");
            DetailedLed.SetFilter("Transaction Type", '%1', DetailedLed."Transaction Type"::"Interest Due");
            DetailedLed.SetFilter("Posting Date", '%1..%2', CalcDate('-CM', Today), Today);
            if DetailedLed.Find('-') = false then begin


                //08/01/2026        //10/01/2026              //09/01/2026
                if (CalcDate('1M', CalcDate('1D', LoansR."Issued Date")) = Today) or (CalcDate('2M', CalcDate('1D', LoansR."Issued Date")) = Today) then begin
                    if LoanType.Get(LoansR."Loan Product Type") then begin
                        Interest := Round(LoansR."Outstanding Balance" * LoanType."Interest rate" / 100);
                        LineNo := LineNo + 10000;
                        AUFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, LoansR."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Interest Due",
                        GenJournalLine."Account Type"::Customer, LoansR."Client Code", Today, 'Interest Charged - ' + LoansR."Loan Product Type" + ' - ' + LoansR."Loan  No.", GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Interest Account",
                        Interest, 'Bosa', LoansR."Loan  No.");

                        // //Credit loan
                        // LineNo := LineNo + 10000;
                        // AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoansR."Loan  No.", LineNo, GenJournalLine."Transaction Type"::Repayment,
                        // GenJournalLine."Account Type"::Customer, LoansR."Client Code", Today, (LoansR."Outstanding Balance") * -1, 'BOSA', LoansR."Cheque No.",
                        // 'Utapesa Recovery - ' + LoansR."Loan Product Type" + ' - ' + LoansR."Loan  No.", LoansR."Loan  No.", GenJournalLine."Application Source"::" ");
                        // //debit Deposits
                        // LineNo := LineNo + 10000;
                        // AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoansR."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                        // GenJournalLine."Account Type"::Customer, LoansR."Client Code", Today, (LoansR."Outstanding Balance"), 'BOSA', LoansR."Cheque No.",
                        // 'Utapesa Recovery - ' + LoansR."Loan Product Type" + ' - ' + LoansR."Loan  No.", LoansR."Loan  No.", GenJournalLine."Application Source"::" ");
                        // GenJournalLine.Reset;
                        // GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        // GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        // if GenJournalLine.Find('-') then begin
                        //     repeat
                        //       GLPosting.Run(GenJournalLine);
                        //     until GenJournalLine.Next = 0;

                        // end;
                        RecoveryMessage := 'Your utapesa loan of KES ' + Format(LoansR."Outstanding Balance") + ' has been marked as defaulted, note that you have been barred from accessing all Sacco products until you clear your defaulter status.';
                        // RecoveryMessage := 'Your utapesa loan of KES ' + Format(LoansR."Outstanding Balance") + ' has been applied interest at a rate of %1.' + Format(LoanType."Interest rate");
                    end;
                end;
                if CalcDate('3M', LoansR."Issued Date") = Today then begin
                    LoansR."Loans Category" := LoansR."Loans Category"::Loss;
                    LoansR."Loans Category-SASRA" := LoansR."Loans Category-SASRA"::Loss;
                    LoansR.Modify();
                    Customer.Reset();
                    Customer.SetRange("No.", LoansR."Client Code");
                    if Customer.Find('-') then begin
                        SmsManagement.SendSmsResponse(Customer."Mobile Phone No", RecoveryMessage);
                        Customer.BlackListed := Customer.BlackListed::Yes;

                        Customer.Modify(true);
                    end;
                end;


            end;
        end;

    end;

    procedure UtapesaReminder()
    begin
        ExpectedDayOfCompletion := 0D;
        ReminderDate := 0D;
        ReminderDateRef := 0;
        ReminderMessage := '';
        LoansR.Reset();
        LoansR.SetFilter("Outstanding Balance", '>%1', 0);
        LoansR.SetAutoCalcFields("Outstanding Balance");
        LoansR.SetFilter("Loan Product Type", '%1', 'UTAPESA');
        LoansR.SetFilter("Date filter", '..%1', Today);
        if LoansR.Find('-') then begin
            repeat
                if LoansR."Issued Date" >= Today then exit;
                ExpectedDayOfCompletion := CalcDate('30D', LoansR."Issued Date");
                ReminderDate := CalcDate('-6D', ExpectedDayOfCompletion);
                ReminderDateRef := Date2DMY(ReminderDate, 1);
                TodayRef := Date2DMY(Today, 1);
                if ReminderDateRef = TodayRef then begin
                    ReminderMessage := 'You are reminded that your Utapesa loan is due in 7 days.';
                    Customer.Reset();
                    Customer.SetRange("No.", LoansR."Client Code");
                    if Customer.Find('-') then begin
                        SmsManagement.SendSmsResponse(Customer."Mobile Phone No", ReminderMessage);

                    end;
                end;
                if LoansR."Issued Date" >= Today then exit;
                ExpectedDayOfCompletion := CalcDate('30D', LoansR."Issued Date");
                ReminderDate := CalcDate('-1D', ExpectedDayOfCompletion);
                ReminderDateRef := Date2DMY(ReminderDate, 1);
                TodayRef := Date2DMY(Today, 1);
                if ReminderDateRef = TodayRef then begin
                    ReminderMessage := 'You are reminded that your Utapesa loan is due tomorrow. Repay now to avoid recovery';
                    Customer.Reset();
                    Customer.SetRange("No.", LoansR."Client Code");
                    if Customer.Find('-') then begin
                        SmsManagement.SendSmsResponse(Customer."Mobile Phone No", ReminderMessage);

                    end;
                end;
            until LoansR.Next() = 0;
        end;
    end;

    procedure DailyUtapesaDefaultReminder()
    begin
        ExpectedDayOfCompletion := 0D;
        ReminderMessage := '';
        LoansR.Reset();
        LoansR.SetFilter("Outstanding Balance", '>%1', 0);
        LoansR.SetAutoCalcFields("Outstanding Balance");
        LoansR.SetFilter("Loan Product Type", '%1', 'UTAPESA');
        LoansR.SetFilter("Date filter", '..%1', Today);
        if LoansR.Find('-') then begin
            repeat
                if LoansR."Issued Date" >= Today then exit;
                ExpectedDayOfCompletion := CalcDate('30D', LoansR."Issued Date");
                if ExpectedDayOfCompletion < Today then begin
                    ReminderMessage := 'Dear' + Format(LoansR."Client Name") + 'Your UTAPESA loan ' + Format(LoansR."Outstanding Balance") + ' was due on ' + Format(LoansR."Expected Date of Completion") + ', update your accounts to avoid inconvniences.';
                    Customer.Reset();
                    Customer.SetRange("No.", LoansR."Client Code");
                    if Customer.Find('-') then begin
                        SmsManagement.SendSmsResponse(Customer."Mobile Phone No", ReminderMessage);
                    end;
                end;
            until LoansR.Next() = 0;
        end;
    end;

    procedure InstantReminder()
    var
        Day60: Integer;
        day90: Integer;
    begin
        ExpectedDayOfCompletion := 0D;
        ReminderDate := 0D;
        ReminderDateRef := 0;
        ReminderMessage := '';
        LoansR.Reset();
        LoansR.SetFilter("Outstanding Balance", '>%1', 0);
        LoansR.SetAutoCalcFields("Outstanding Balance");
        LoansR.SetFilter("Loan Product Type", '%1', 'INSTANT');
        LoansR.SetFilter("Date filter", '..%1', Today);
        if LoansR.Find('-') then begin
            repeat
                if LoansR."Issued Date" >= Today then exit;
                ExpectedDayOfCompletion := CalcDate('30D', LoansR."Loan Disbursement Date");
                ReminderDate := CalcDate('-6D', ExpectedDayOfCompletion);
                Day60 := Date2DMY(CalcDate('54D', LoansR."Loan Disbursement Date"), 1);
                day90 := Date2DMY(CalcDate('84D', LoansR."Loan Disbursement Date"), 1);
                Date90 := CalcDate('83D', LoansR."Loan Disbursement Date");
                Date87 := CalcDate('87D', LoansR."Loan Disbursement Date");
                Date83 := CalcDate('90D', LoansR."Loan Disbursement Date");
                Day173 := CalcDate('176D', LoansR."Loan Disbursement Date");
                Day183 := CalcDate('183D', LoansR."Loan Disbursement Date");
                ReminderDateRef := Date2DMY(ReminderDate, 1);

                TodayRef := Date2DMY(Today, 1);
                if (Date90 = Today) then begin
                    ReminderMessage := 'You are reminded that your Instant Loan is due in 7 days.' + Format(LoansR."Expected Date of Completion");
                    Customer.Reset();
                    Customer.SetRange("No.", LoansR."Client Code");
                    if Customer.Find('-') then begin
                        SmsManagement.SendSmsResponse(Customer."Mobile Phone No", ReminderMessage);

                    end;
                end;
                if (Date87 = Today) then begin
                    ReminderMessage := 'You are reminded that your Instant Loan is due in 3 days. Kindly repay on time to avoid Penalties.' + Format(LoansR."Expected Date of Completion");
                    Customer.Reset();
                    Customer.SetRange("No.", LoansR."Client Code");
                    if Customer.Find('-') then begin
                        SmsManagement.SendSmsResponse(Customer."Mobile Phone No", ReminderMessage);
                    end;
                End;
                if (Date83 = Today) then begin
                    ReminderMessage := 'You are reminded that your Instant Loan is due today. Repay now to avoid 15% Penalty on Outstanding balance.' + Format(LoansR."Expected Date of Completion");
                    Customer.Reset();
                    Customer.SetRange("No.", LoansR."Client Code");
                    if Customer.Find('-') then begin
                        SmsManagement.SendSmsResponse(Customer."Mobile Phone No", ReminderMessage);
                    end;
                End;
                if (Day173 = Today) then begin
                    ReminderMessage := 'You are reminded that your Instant Loan is due in 7 days.';
                    Customer.Reset();
                    Customer.SetRange("No.", LoansR."Client Code");
                    if Customer.Find('-') then begin
                        SmsManagement.SendSmsResponse(Customer."Mobile Phone No", ReminderMessage);

                    end;
                end;
                if (Day183 = Today) then begin
                    ReminderMessage := 'You are reminded that your Instant Loan is due Today. Kindly repay on time to avoid Penalties.';
                    Customer.Reset();
                    Customer.SetRange("No.", LoansR."Client Code");
                    if Customer.Find('-') then begin
                        SmsManagement.SendSmsResponse(Customer."Mobile Phone No", ReminderMessage);
                    end;
                End;
            until LoansR.Next() = 0;
        end;
    end;

}
