codeunit 131062 "Au Standing Order"

{

    trigger OnRun()
    var

    begin
        GenJournalLine2();
        StandingOrder.reset;
        StandingOrder.SetRange(StandingOrder.Status, StandingOrder.Status::Approved);
        StandingOrder.SetRange(StandingOrder."Is Active", true);
        StandingOrder.SetRange("Next Run Date", Today);
        // StandingOrder.SetRange("No.", StandingOrder."No.");
        StandingOrder.SetRange(StandingOrder."Standing Order Dedution Type", StandingOrder."Standing Order Dedution Type"::"Date Based");
        IF StandingOrder.FindFirst() then begin
            repeat

                AvailableBal := FnRunGetAccountAvailableBalanceWithoutFreeze(StandingOrder."BOSA Account No.", Today);

                if AvailableBal >= StandingOrder.Amount then begin
                    RunningBalance := StandingOrder.Amount;



                    DOCUMENT_NO := StandingOrder."No.";
                    RunningBalance := FnBosaStandingOrderTransaction(StandingOrder, RunningBalance);
                    ObjVendor.Reset();
                    ObjVendor.SetRange("No.", StandingOrder."Source Account No.");
                    if ObjVendor.Find('-') then begin
                        if ObjVendor."Mobile Phone No" <> '' then begin
                            SmsCodeunit.SendSmsResponse(ObjVendor."Mobile Phone No", 'Your STO of Ksh ' + Format(StandingOrder.Amount) + ' has been effected. Thank you.');
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."account type"::Vendor, StandingOrder."Source Account No.", today, 10,
                            'FOSA', StandingOrder."Source Account No.", Format(StandingOrder."Source Account No.") + ' Sms Fee on STO ' + format(today) + StandingOrder."Source Account No.", '', GenJournalLine."application source"::" ", StandingOrder."Source Account No.");

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."account type"::"G/L Account", '31204', today, -10,
                            'FOSA', StandingOrder."Source Account No.", Format(StandingOrder."Source Account No.") + ' Sms Fee on STO ' + format(today) + StandingOrder."Source Account No.", '', GenJournalLine."application source"::" ", StandingOrder."Source Account No.");
                        end;
                    end;

                    //--------------------------------End Post to the Respective Destination Account-----------------------------------------------------------															

                    FnPostStandingOrderFee_Succesful(StandingOrder);//---------Post Standing Order Fee-------------------------------------------------------------------															
                    VarNextRetryDate := CalcDate(StandingOrder.Frequency, StandingOrder."Next Run Date");
                    StandingOrder.Effected := true;
                    StandingOrder."Auto Process" := true;
                    StandingOrder."Next Run Date" := CalcDate(StandingOrder.Frequency, StandingOrder."Next Run Date");
                    StandingOrder."Next Attempt Date" := VarNextRetryDate;
                    StandingOrder."End of Tolerance Date" := CalcDate(StandingOrder."No of Tolerance Days", StandingOrder."Next Run Date");
                    StandingOrder.Modify;
                    VarDedStatus := Vardedstatus::Successfull;
                    FnUpdateStandingOrderRegister(StandingOrder);
                end;
                if AvailableBal < StandingOrder.Amount then begin
                    ObjVendor.Reset();
                    ObjVendor.SetRange("No.", StandingOrder."Source Account No.");
                    if ObjVendor.Find('-') then begin
                        if ObjVendor."Mobile Phone No" <> '' then begin
                            SmsCodeunit.SendSmsResponse(ObjVendor."Mobile Phone No", 'Your STO of Ksh ' + Format(StandingOrder.Amount) + ' has not been fully effected due to insufficient balance.Kindly topup to complete the transaction.');
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."account type"::Vendor, StandingOrder."Source Account No.", today, 10,
                            'FOSA', StandingOrder."Source Account No.", Format(StandingOrder."Source Account No.") + ' Sms Fee on STO ' + format(today) + StandingOrder."Source Account No.", '', GenJournalLine."application source"::" ", StandingOrder."Source Account No.");

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."account type"::"G/L Account", '31204', today, -10,
                            'FOSA', StandingOrder."Source Account No.", Format(StandingOrder."Source Account No.") + ' Sms Fee on STO ' + format(today) + StandingOrder."Source Account No.", '', GenJournalLine."application source"::" ", StandingOrder."Source Account No.");
                        end;
                    end;
                end;
                //End Post When Account Available is > than Standing Order Amount==========================================================================	

                if StandingOrder."Execute Condition" = StandingOrder."execute condition"::"If no Funds Retry Standing Order" then begin

                    //-----Update Next Attempt Date------------------------------------------------------------------------------------------------------------															
                    if AvailableBal < StandingOrder.Amount then begin
                        StandingOrder."Next Attempt Date" := CalcDate('1D', StandingOrder."Next Attempt Date");
                        StandingOrder.Modify;
                    end;
                    //-----End Update Next Attempt Date-----------------------------------------------------------------------------------------------------------															

                    //----Finalize for Failed Standing Order------------------------------------------------------------------------------------------------------															
                    if (AvailableBal < StandingOrder.Amount) and (StandingOrder."Next Attempt Date" = StandingOrder."End of Tolerance Date") then begin
                        FnPostStandingOrderFee_Failed(StandingOrder);

                        StandingOrder.Unsuccessfull := true;
                        StandingOrder."Auto Process" := true;
                        StandingOrder."Next Run Date" := CalcDate(StandingOrder.Frequency, StandingOrder."Next Run Date");
                        StandingOrder."Next Attempt Date" := CalcDate(StandingOrder.Frequency, StandingOrder."Next Run Date");
                        StandingOrder.Modify;
                        VarDedStatus := Vardedstatus::Failed;
                        FnUpdateStandingOrderRegister(StandingOrder);
                    end;
                    //----End Finalize for Failed Standing Order------------------------------------------------------------------------------------------------------															
                end;


            until StandingOrder.Next() = 0;
            GenJournalLine.Reset();
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
            end
        end;


    end;


    local procedure FnBosaStandingOrderTransaction(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
        RemainBal: Decimal;
        InterestBal: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjReceiptTransactions.Reset;
            ObjReceiptTransactions.SetRange("Document No", ObjRcptBuffer."No.");
            if ObjReceiptTransactions.Find('-') then begin
                //ObjReceiptTransactions.CALCFIELDS("Interest Amount");
                repeat
                    DOCUMENT_NO := ObjReceiptTransactions."Document No";
                    if ObjReceiptTransactions."Account Type" = ObjReceiptTransactions."Account Type"::Customer then begin
                        if (ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."Transaction Type"::Repayment) or (ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."Transaction Type"::"Interest Paid") then begin
                            //-------------RECOVER principal-----------------------
                            if LoanApp.Get(ObjReceiptTransactions."Loan No.") then begin
                                if LoanApp."Recovery Mode" = LoanApp."Recovery Mode"::Salary then begin
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                    GenJournalLine."account type"::Customer, ObjReceiptTransactions."Account No", today, (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount") * -1,
                                    'BOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.");

                                    //-------------PAY Principal----------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Standing Order Account",
                                    GenJournalLine."account type"::Customer, ObjRcptBuffer."BOSA Account No.", today,
                                    ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount", 'BOSA', ObjRcptBuffer."No.",
                                    Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.");

                                    RunningBalance := RunningBalance - (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount");
                                end;


                                if LoanApp."Recovery Mode" <> LoanApp."Recovery Mode"::Salary then begin
                                    RemainBal := 0;
                                    InterestBal := 0;
                                    RemainBal := ObjReceiptTransactions.Amount;
                                    LoanApp.CalcFields(LoanApp."Outstanding Interest");
                                    if RemainBal > LoanApp."Outstanding Interest" then
                                        InterestBal := LoanApp."Outstanding Interest"
                                    else
                                        InterestBal := RemainBal;


                                    //-------------RECOVER Interest-----------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                    GenJournalLine."account type"::Customer, ObjReceiptTransactions."Account No", today, InterestBal * -1,
                                    'BOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::"Interest Paid") + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.");

                                    //-------------PAY Interest----------------------------

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Standing Order Account",
                                    GenJournalLine."account type"::Customer, ObjRcptBuffer."BOSA Account No.", today,
                                    InterestBal, 'BOSA', ObjRcptBuffer."No.",
                                    Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.");
                                    RemainBal := RemainBal - InterestBal;
                                    RunningBalance := RunningBalance - LoanApp."Outstanding Interest";

                                    if RemainBal > 0 then begin
                                        //-------------PAY Principal----------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment,
                                        GenJournalLine."account type"::Customer, ObjReceiptTransactions."Account No", today, (RemainBal) * -1,
                                        'BOSA', ObjRcptBuffer."No.", Format(GenJournalLine."Transaction Type"::Repayment) + ' STO Recovery ' + ObjRcptBuffer."No.", ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.");


                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Standing Order Account",
                                        GenJournalLine."account type"::Customer, ObjRcptBuffer."BOSA Account No.", today,
                                        RemainBal, 'BOSA', ObjRcptBuffer."No.",
                                        Format(GenJournalLine."Transaction Type"::Repayment) + '-' + ObjReceiptTransactions."Loan Product Name" + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.");

                                        RunningBalance := RunningBalance - (RemainBal);

                                    end;
                                end;
                            end;

                        end
                        else begin
                            //-------------RECOVER BOSA NONLoan Transactions-----------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                            GenJournalLine."account type"::Customer, ObjReceiptTransactions."Account No", today, ObjReceiptTransactions.Amount * -1,
                            'BOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.");

                            //-------------PAY BOSA NONLoan Transaction----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::"Standing Order Account",
                            GenJournalLine."account type"::Customer, ObjRcptBuffer."BOSA Account No.", today, ObjReceiptTransactions.Amount,
                            'BOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.");

                            RunningBalance := RunningBalance - ObjReceiptTransactions.Amount;

                        end;
                    end else begin
                        if ObjReceiptTransactions."Account Type" = ObjReceiptTransactions."Account Type"::Vendor then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                            GenJournalLine."account type"::Vendor, ObjReceiptTransactions."Account No", today, ObjReceiptTransactions.Amount * -1,
                            'BOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.");

                            //-------------PAY BOSA NONLoan Transaction----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineSal(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", today, ObjReceiptTransactions.Amount,
                            'BOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type") + ' STO Recovery ' + ObjRcptBuffer."No.", '', GenJournalLine."application source"::" ", ObjRcptBuffer."BOSA Account No.");

                            RunningBalance := RunningBalance - ObjReceiptTransactions.Amount;
                        end;

                    end;

                until ObjReceiptTransactions.Next = 0;
            end;

            exit(RunningBalance);
        end;
    end;

    procedure FnRunGetAccountAvailableBalanceWithoutFreeze(VarAccountNo: Code[30]; VarBalanceDate: Date) AvailableBal: Decimal
    var
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarDateFilter: Text;
        Customer: Record Customer;
    begin
        VarDateFilter := '..' + Format(VarBalanceDate);

        Customer.Reset();
        Customer.SetRange("No.", VarAccountNo);
        Customer.SetFilter("Date Filter", VarDateFilter);
        Customer.SetAutoCalcFields("Standing Order Acount");
        if Customer.FindSet() then begin
            AvailableBal := Customer."Standing Order Acount";
        end;

        // ObjVendors.Reset;
        // ObjVendors.SetRange(ObjVendors."No.", VarAccountNo);
        // ObjVendors.SetFilter(ObjVendors."Date Filter", VarDateFilter);
        // if ObjVendors.Find('-') then begin
        //     ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Cheque Discounted", ObjVendors."Uncleared Cheques", ObjVendors."EFT Transactions",
        //                             ObjVendors."ATM Transactions", ObjVendors."Mobile Transactions", ObjVendors."Cheque Discounted Amount");
        //     AvailableBal := ((ObjVendors.Balance + ObjVendors."Cheque Discounted") - ObjVendors."Uncleared Cheques" + ObjVendors."Over Draft Limit Amount" -
        //                   ObjVendors."ATM Transactions" - ObjVendors."EFT Transactions" - ObjVendors."Mobile Transactions");

        //     ObjAccTypes.Reset;
        //     ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
        //     if ObjAccTypes.Find('-') then
        //         AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
        // end;

        exit(AvailableBal);
    end;

    local procedure FnUpdateStandingOrderRegister("Standing Orders": Record "Standing Orders")
    begin
        ObjStoRegister.Init;
        ObjStoRegister."Register No." := '';
        ObjStoRegister.Validate(ObjStoRegister."Register No.");
        ObjStoRegister."Standing Order No." := "Standing Orders"."No.";
        ObjStoRegister."Source Account No." := "Standing Orders"."Source Account No.";
        ObjStoRegister."Staff/Payroll No." := "Standing Orders"."Staff/Payroll No.";
        ObjStoRegister.Date := Today;
        ObjStoRegister."Account Name" := "Standing Orders"."Account Name";
        ObjStoRegister."Destination Account Type" := "Standing Orders"."Destination Account Type";
        ObjStoRegister."Destination Account No." := "Standing Orders"."Destination Account No.";
        ObjStoRegister."Destination Account Name" := "Standing Orders"."Destination Account Name";
        ObjStoRegister."BOSA Account No." := "Standing Orders"."BOSA Account No.";
        ObjStoRegister."Effective/Start Date" := "Standing Orders"."Effective/Start Date";
        ObjStoRegister."End Date" := "Standing Orders"."End Date";
        ObjStoRegister.Duration := "Standing Orders".Duration;
        ObjStoRegister.Frequency := "Standing Orders".Frequency;
        ObjStoRegister."Don't Allow Partial Deduction" := "Standing Orders"."Don't Allow Partial Deduction";
        ObjStoRegister."Deduction Status" := VarDedStatus;
        ObjStoRegister.Remarks := "Standing Orders"."Standing Order Description";
        ObjStoRegister.Amount := "Standing Orders".Amount;
        ObjStoRegister."Amount Deducted" := VarAmountDed;
        if "Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::"Member Account" then
            ObjStoRegister.EFT := true;
        ObjStoRegister.Insert(true);
    end;


    local procedure FnPostStandingOrderFee_Succesful("Standing Orders": Record "Standing Orders")
    var
        ObjGensetup: Record "Sacco General Set-Up";
        ObjFosaCharges: Record Charges;
        VarStoFeeSuccess: Decimal;
        VarStoFeeFailed: Decimal;
        VarStoFeeAccount: Code[30];
    begin
        ObjGensetup.Get();

        ObjFosaCharges.Reset;
        ObjFosaCharges.SetRange(ObjFosaCharges."Charge Type", ObjCharges."charge type"::"Standing Order Fee");
        if ObjFosaCharges.FindSet then begin
            if ObjFosaCharges."Use Percentage" = true then begin
                VarStoFeeSuccess := "Standing Orders".Amount * (ObjFosaCharges."Percentage of Amount" / 10)
            end else
                VarStoFeeSuccess := ObjFosaCharges."Charge Amount";
            VarStoFeeAccount := ObjFosaCharges."GL Account";
        end;

        //------------------------------------1. DEBIT FOSA  A/C STO Charge---------------------------------------------------------------------------------------------															
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, "Standing Orders"."Source Account No.", Today, "Standing Orders"."Standing Order Description", GenJournalLine."bal. account type"::"G/L Account",
        VarStoFeeAccount, VarStoFeeSuccess, 'FOSA', '');
        //--------------------------------(Debit FOSA Account STO Charge)-------------------------------------------------------------------------------															

        //------------------------------------2. DEBIT FOSA  A/C Tax---------------------------------------------------------------------------------------------															
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, "Standing Orders"."Source Account No.", Today, "Standing Orders"."Standing Order Description", GenJournalLine."bal. account type"::"G/L Account",
        ObjGensetup."Excise Duty Account", VarStoFeeSuccess * (ObjGensetup."Excise Duty(%)" / 100), 'FOSA', '');
        //--------------------------------(Debit FOSA Account STO Charge Tax)-------------------------------------------------------------------------------															
    end;

    local procedure FnPostStandingOrderFee_Failed("Standing Orders": Record "Standing Orders")
    var
        ObjGensetup: Record "Sacco General Set-Up";
        ObjFosaCharges: Record Charges;
        VarStoFeeSuccess: Decimal;
        VarStoFeeFailed: Decimal;
        VarStoFeeAccount: Code[30];
    begin
        ObjGensetup.Get();

        ObjFosaCharges.Reset;
        ObjFosaCharges.SetRange(ObjFosaCharges."Charge Type", ObjCharges."charge type"::"Failed Standing Order Fee");
        if ObjFosaCharges.FindSet then begin
            if ObjFosaCharges."Use Percentage" = true then begin
                VarStoFeeSuccess := "Standing Orders".Amount * (ObjFosaCharges."Percentage of Amount" / 10)
            end else
                VarStoFeeSuccess := ObjFosaCharges."Charge Amount";
            VarStoFeeAccount := ObjFosaCharges."GL Account";
        end;

        //------------------------------------1. DEBIT FOSA  A/C STO Charge---------------------------------------------------------------------------------------------															
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, "Standing Orders"."Source Account No.", Today, 'Failed Standing Order Fee', GenJournalLine."bal. account type"::"G/L Account",
        VarStoFeeAccount, VarStoFeeSuccess, 'FOSA', '');
        //--------------------------------(Debit FOSA Account STO Charge)-------------------------------------------------------------------------------															

        //------------------------------------2. DEBIT FOSA  A/C Tax---------------------------------------------------------------------------------------------															
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, "Standing Orders"."Source Account No.", Today, 'Tax: Failed Standing Order Fee', GenJournalLine."bal. account type"::"G/L Account",
        ObjGensetup."Excise Duty Account", VarStoFeeSuccess * (ObjGensetup."Excise Duty(%)" / 100), 'FOSA', '');
        //--------------------------------(Debit FOSA Account STO Charge Tax)-------------------------------------------------------------------------------															
    end;

    procedure GenJournalLine2()
    begin
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

    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        GenBatches: Record "Gen. Journal Batch";
        ObjAccount: Record Vendor;
        StandingOrder: Record "Standing Orders";
        StandingOrder22: Record "Standing Orders";
        ObjAccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        ObjStoRegister: Record "Standing Order Register";
        VarAmountDed: Decimal;
        VarDedStatus: Option Successfull,"Partial Deduction",Failed;
        ObjCharges: Record Charges;
        LineNo: Integer;
        DActivity: Code[20];
        DBranch: Code[20];
        VarStoAmount: Decimal;
        ObjReceiptAllocations: Record "Receipt Allocation";
        VarStoRunBal: Decimal;
        VarReceiptAmount: Decimal;
        ObjLoans: Record "Loans Register";
        VarDocNo: Code[20];
        VarInsCont: Decimal;
        VarActualSto: Decimal;
        RunningBalance: Decimal;
        VarAccountS: Record Vendor;
        DActivity3: Code[20];
        DBranch3: Code[20];
        VarAccountTypeS: Record "Account Types-Saving Products";
        VarStandingOrderFee: Decimal;
        VarGenSetup: Record "Sacco General Set-Up";
        SFactory: Codeunit "Au Factory";
        BATCH_TEMPLATE: Label 'GENERAL';
        BATCH_NAME: Label 'STO';
        DOCUMENT_NO: Code[30];
        VarNextRetryDate: Date;
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";

        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];

        ExciseDutyP: Decimal;
        Members: Record Customer;
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record Customer;
        salarybuffer: Record "Salary Processing Lines";
        SalHeader: Record "Salary Processing Headerr";
        Sto: Record "Standing Orders";
        ELoanBuffer: Record "E-Loan Salary Buffer";
        ObjVendor: Record Vendor;
        MembLedg: Record "Cust. Ledger Entry";

        ActionEnabled: Boolean;
        ObjVendorLedger: Record "Vendor Ledger Entry";
        ObjGenSetup: Record "Sacco General Set-Up";
        Charges: Record Charges;
        SalProcessingFee: Decimal;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        DedStatus: Option Successfull,"Partial Deduction",Failed;

        ObjLoanProducts: Record "Loan Products Setup";
        Window: Dialog;
        SmsCodeunit: Codeunit "Sms Management";
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        EXTERNAL_DOC_NO: Code[40];
        SMSCODE: Code[30];
        VarAvailableBal: Decimal;
        VarCreditDescription: Text[250];
        VarMemberName: Text;
        ObjSalaryProcessingLines: Record "Salary Processing Lines";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure,SweepingInstructions,ChequeBookApplication,LoanTrunchDisbursement,InwardChequeClearing,InValidPaybillTransactions,InternalPV,SalaryProcessing;
        EnableProcessing: Boolean;
        workflowintegration: Codeunit WorkflowIntegration;
}
