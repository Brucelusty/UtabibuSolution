//************************************************************************
codeunit 50074 "PostCustomerExtension"
{
    trigger OnRun()
    begin

    end;



    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false, false)]
    procedure ModifyReceivablesAccount(var GenJournalLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        TransactionTypestable: record "Transaction Types Table";
        LoanApp: Record "Loans Register";
        LoanTypes: record "Loan Products Setup";
        CustPostingGroupBuffer: record "Customer Posting Group";
        LoanAccount: Code[2020];
        utapesacredit: Codeunit MobilePosting;
        creditlogs: Record "Credit limit logs";
        Members: rECORD Customer;
        previousAMT: Decimal;

    begin
        if cust.Get(GenJournalLine."Account No.") then begin
            if cust.ISNormalMember then begin
                // GenJournalLine.ISNormalMember := true;
                // GenJournalLine.Modify(true);
                if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                    Error('Cannot post with missing transaction type.');
                TransactionTypestable.reset;
                TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                if TransactionTypestable.Find('-') then begin
                    GenJournalLine."Posting Group" := TransactionTypestable."Posting Group Code";
                    GenJournalLine.Modify();
                end else
                    Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
            end;
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::Repayment) then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions');

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                //Credit limit for utapesa update
                if LoanApp."Loan Product Type" = 'UTAPESA' THEN BEGIN
                    LoanApp.CalcFields("Outstanding Balance");
                    IF LoanApp."Outstanding Balance" + GenJournalLine.Amount <= 0 then begin
                        IF (Date2DMY(LoanApp."Loan Disbursement Date", 2) = Date2DMY(Today, 2)) AND (Date2DMY(LoanApp."Loan Disbursement Date", 3) = Date2DMY(Today, 3)) THEN BEGIN

                            Members.GET(LoanApp."Client Code");
                            Members.CalcFields("Current Shares");
                            creditlogs.Reset();
                            creditlogs.SetRange("Member No", Members."No.");
                            creditlogs.SetCurrentKey(EntryNo);
                            creditlogs.Ascending(true);

                            if creditlogs.FindLast() then begin
                                previousAMT := creditlogs."Previous limit";
                                if (previousAMT >= 5000) and (previousAMT <= 11000) then
                                    previousAMT += 2000 else
                                    if (previousAMT > 11000) and (previousAMT <= 20000) then
                                        previousAMT += 3000 else
                                        if (previousAMT > 20000) and (previousAMT <= 32000) then
                                            previousAMT += 4000 else
                                            if (previousAMT > 32000) and (previousAMT <= 50000) then previousAMT += 5000;
                                utapesacredit.updateUtapesacreditlimit(Members."No.", true, GenJournalLine.Amount * -1, LoanApp."Approved Amount", previousAMT, creditlogs."Previous limit", LoanApp."Loan  No.", false);
                            end else begin
                                previousAMT := LoanApp."Approved Amount";
                                if (previousAMT >= 5000) and (previousAMT <= 11000) then
                                    previousAMT += 2000 else
                                    if (previousAMT > 11000) and (previousAMT <= 20000) then
                                        previousAMT += 3000 else
                                        if (previousAMT > 20000) and (previousAMT <= 32000) then
                                            previousAMT += 4000 else
                                            if (previousAMT > 32000) and (previousAMT <= 50000) then previousAMT += 5000;
                                utapesacredit.updateUtapesacreditlimit(Members."No.", true, GenJournalLine.Amount * -1, LoanApp."Approved Amount", previousAMT, 0, LoanApp."Loan  No.", false);
                            end;
                        END


                    end

                END;

                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Loan Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Loan Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();

                        end;

                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
                end;
            end;
        end;


        // if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Due") then begin
        //     if GenJournalLine."Loan No" = '' then
        //         Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

        //     LoanApp.Reset;
        //     LoanApp.SetCurrentkey(LoanApp."Loan  No.");
        //     LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
        //     if LoanApp.Find('-') then begin
        //         if LoanTypes.Get(LoanApp."Loan Product Type") then begin
        //             LoanTypes.TestField(LoanTypes."Receivable Interest Account");
        //             if cust.get(GenJournalLine."Account No.") then
        //                 if Cust.ISNormalMember = true then
        //                     if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
        //                         Error('Cannot post with missing transaction type.');
        //             TransactionTypestable.reset;
        //             TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
        //             if TransactionTypestable.Find('-') then begin
        //                 CustPostingGroupBuffer.Reset();
        //                 CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
        //                 if CustPostingGroupBuffer.FindFirst() then begin
        //                     CustPostingGroupBuffer."Receivables Account" := LoanTypes."Loan Interest Account";
        //                     CustPostingGroupBuffer.Modify();
        //                     GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
        //                     GenJournalLine.Modify();
        //                 end;
        //             end else
        //                 Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

        //         end;
        //     end;
        // end;

        //Penalty
        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Penalty Charged") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Penalty Charged Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Penalty Charged Account";

                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;

                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Penalty Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Penalty Charged Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Penalty Charged Account";

                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;

                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;
        end;
        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Due") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Receivable Interest Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Receivable Interest Account";

                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;

                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;
        end;
        //end Due

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Receivable Interest Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Receivable Interest Account";

                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;

                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::Loan) then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Loan Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Loan Account";

                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;

                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;
        end;
        // if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::Loan) then begin
        //     if GenJournalLine."Loan No" = '' then
        //         Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");
        //     //Message('firsst%1', Cust.ISNormalMember);
        //     LoanApp.Reset;
        //     LoanApp.SetCurrentkey(LoanApp."Loan  No.");
        //     LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
        //     if LoanApp.Find('-') then begin
        //         //Message('kweli%1', LoanApp."Loan Product Type");
        //         if LoanTypes.Get(LoanApp."Loan Product Type") then begin
        //             LoanTypes.TestField(LoanTypes."Loan Account");
        //             if cust.get(GenJournalLine."Account No.") then
        //                 if Cust.ISNormalMember = true then
        //                     Message('kabisa%1-%2', LoanTypes.Code, LoanTypes."Loan Account");
        //             if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
        //                 Error('Cannot post with missing transaction type.');
        //             TransactionTypestable.reset;
        //             TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
        //             if TransactionTypestable.Find('-') then begin
        //                 Message('home %1-%2-%3', TransactionTypestable."Transaction Type", LoanTypes."Loan Account", LoanTypes.Code);
        //                 CustPostingGroupBuffer.Reset();
        //                 CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
        //                 if CustPostingGroupBuffer.FindFirst() then begin
        //                     CustPostingGroupBuffer."Receivables Account" := LoanTypes."Loan Account";
        //                     CustPostingGroupBuffer.Modify(true);
        //                     GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
        //                     GenJournalLine.Modify(true);
        //                 end;
        //             end else
        //                 Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
        //         end;
        //     end;

        // end;

        // if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::) then begin
        //     if GenJournalLine."Loan No" = '' then
        //         Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

        //     LoanApp.Reset;
        //     LoanApp.SetCurrentkey(LoanApp."Loan  No.");
        //     LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
        //     if LoanApp.Find('-') then begin
        //         if LoanTypes.Get(LoanApp."Loan Product Type") then begin
        //             LoanTypes.TestField(LoanTypes."Loan Insurance Accounts");
        //             if cust.get(GenJournalLine."Account No.") then
        //                 if Cust.ISNormalMember = true then
        //                     if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
        //                         Error('Cannot post with missing transaction type.');
        //             TransactionTypestable.reset;
        //             TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
        //             if TransactionTypestable.Find('-') then begin
        //                 CustPostingGroupBuffer.Reset();
        //                 CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
        //                 if CustPostingGroupBuffer.FindFirst() then begin
        //                     CustPostingGroupBuffer."Receivables Account" := LoanTypes."Receivable Insurance Accounts";
        //                     CustPostingGroupBuffer.Modify();
        //                     GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
        //                     GenJournalLine.Modify();
        //                 end;
        //             end else
        //                 Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

        //         end;
        //     end;

        // end;

        //     if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Insurance Paid") then begin
        //         if GenJournalLine."Loan No" = '' then
        //             Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

        //         LoanApp.Reset;
        //         LoanApp.SetCurrentkey(LoanApp."Loan  No.");
        //         LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
        //         if LoanApp.Find('-') then begin
        //             if LoanTypes.Get(LoanApp."Loan Product Type") then begin
        //                 LoanTypes.TestField(LoanTypes."Loan Insurance Accounts");
        //                 if cust.get(GenJournalLine."Account No.") then
        //                     if Cust.ISNormalMember = true then
        //                         if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
        //                             Error('Cannot post with missing transaction type.');
        //                 TransactionTypestable.reset;
        //                 TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
        //                 if TransactionTypestable.Find('-') then begin
        //                     CustPostingGroupBuffer.Reset();
        //                     CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
        //                     if CustPostingGroupBuffer.FindFirst() then begin
        //                         CustPostingGroupBuffer."Receivables Account" := LoanTypes."Receivable Insurance Accounts";
        //                         CustPostingGroupBuffer.Modify();
        //                         GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
        //                         GenJournalLine.Modify();
        //                     end;
        //                 end else
        //                     Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

        //             end;
        //         end;

        //     end;



        //     if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Penalty Charged") then begin
        //         if GenJournalLine."Loan No" = '' then
        //             Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

        //         LoanApp.Reset;
        //         LoanApp.SetCurrentkey(LoanApp."Loan  No.");
        //         LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
        //         if LoanApp.Find('-') then begin
        //             if LoanTypes.Get(LoanApp."Loan Product Type") then begin
        //                 LoanTypes.TestField(LoanTypes."Penalty Paid Account");
        //                 if cust.get(GenJournalLine."Account No.") then
        //                     if Cust.ISNormalMember = true then
        //                         if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
        //                             Error('Cannot post with missing transaction type.');
        //                 TransactionTypestable.reset;
        //                 TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
        //                 if TransactionTypestable.Find('-') then begin
        //                     CustPostingGroupBuffer.Reset();
        //                     CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
        //                     if CustPostingGroupBuffer.FindFirst() then begin
        //                         CustPostingGroupBuffer."Receivables Account" := LoanTypes."Penalty Charged Account";
        //                         CustPostingGroupBuffer.Modify();
        //                         GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
        //                         GenJournalLine.Modify();
        //                     end;
        //                 end else
        //                     Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

        //             end;
        //         end;

        //     end;

        //     if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Penalty Paid") then begin
        //         if GenJournalLine."Loan No" = '' then
        //             Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

        //         LoanApp.Reset;
        //         LoanApp.SetCurrentkey(LoanApp."Loan  No.");
        //         LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
        //         if LoanApp.Find('-') then begin
        //             if LoanTypes.Get(LoanApp."Loan Product Type") then begin
        //                 LoanTypes.TestField(LoanTypes."Penalty Charged Account");
        //                 if cust.get(GenJournalLine."Account No.") then
        //                     if Cust.ISNormalMember = true then
        //                         if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
        //                             Error('Cannot post with missing transaction type.');
        //                 TransactionTypestable.reset;
        //                 TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
        //                 if TransactionTypestable.Find('-') then begin
        //                     CustPostingGroupBuffer.Reset();
        //                     CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
        //                     if CustPostingGroupBuffer.FindFirst() then begin
        //                         CustPostingGroupBuffer."Receivables Account" := LoanTypes."Penalty Charged Account";
        //                         CustPostingGroupBuffer.Modify();
        //                         GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
        //                         GenJournalLine.Modify();
        //                     end;
        //                 end else
        //                     Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

        //             end;
        //         end;

        //     end;


    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    procedure InsertCustomTransactionFields(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        cust: Record Customer;
    begin

        CustLedgerEntry."Transaction Type" := GenJournalLine."Transaction Type";
        CustLedgerEntry."Loan No" := GenJournalLine."Loan No";
        CustLedgerEntry."Loan Type" := GenJournalLine."Loan Product Type";
        CustLedgerEntry."Recoverd Loan" := GenJournalLine."Recoverd Loan";
        CustLedgerEntry."Recovery Transaction Type" := GenJournalLine."Recovery Transaction Type";
        CustLedgerEntry."Transaction Date" := WorkDate();
        CustLedgerEntry."Application Source" := GenJournalLine."Application Source";
        CustLedgerEntry."Created On" := CurrentDateTime;
        CustLedgerEntry.CalcFields(Amount);
        CustLedgerEntry."Transaction Amount" := GenJournalLine.Amount;
    end;

    [EventSubscriber(ObjectType::codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]
    procedure InsertCustomfieldstodetailedcustledgerentry2(GenJournalLine: Record "Gen. Journal Line"; var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin

        DtldCustLedgEntry."Transaction Type" := GenJournalLine."Transaction Type";
        DtldCustLedgEntry."Loan No" := GenJournalLine."Loan No";
        DtldCustLedgEntry."Loan Type" := GenJournalLine."Loan Product Type";
        DtldCustLedgEntry."Recoverd Loan" := GenJournalLine."Recoverd Loan";
        DtldCustLedgEntry."Recovery Transaction Type" := GenJournalLine."Recovery Transaction Type";
        DtldCustLedgEntry."Transaction Date" := WorkDate();
        DtldCustLedgEntry."Application Source" := GenJournalLine."Application Source";
        DtldCustLedgEntry."Created On" := CurrentDateTime;
        DtldCustLedgEntry.Description := GenJournalLine.Description;
        // DtldCustLedgEntry.Insert(true);
        // Message('%1-%2-%3', DtldCustLedgEntry."Transaction Type", DtldCustLedgEntry."Loan No", DtldCustLedgEntry."Transaction Date");

    end;

    [EventSubscriber(ObjectType::Table, 179, 'OnAfterReverseEntries', '', false, false)]
    procedure modifyreversedCustLedger(Number: Integer)
    var
        Custledger: Record "Cust. Ledger Entry";
        CustledgeentPage: page "Customer Ledger Entries";
        ReversalEntry: Record "Reversal Entry";
        DetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        Custledger.reset;
        if Custledger.Findlast then begin
            Custledger.CalcFields(Amount);
            if Custledger.Reversed then
                Custledger."Transaction Amount" := Custledger.amount;
            //Custledger.Modify();
        end;
        Custledger.Reset();
        //Custledger.SetRange(Custledger."Entry No.", DetailedCustLedgerEntry."Cust. Ledger Entry No.");
        Custledger.SetRange(Reversed, true);
        if Custledger.FindSet(true) then begin
            repeat
                //Message('here');
                DetailedCustLedgerEntry.Reset();
                DetailedCustLedgerEntry.SetRange(DetailedCustLedgerEntry."Cust. Ledger Entry No.", Custledger."Entry No.");
                if DetailedCustLedgerEntry.FindSet() then begin
                    DetailedCustLedgerEntry.Reversed := true;
                    DetailedCustLedgerEntry."Reversal Date" := Today;
                    //DetailedCustLedgerEntry.Modify(true);
                    //Message('here2');
                end;
            until Custledger.Next = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInitBankAccLedgEntry', '', false, false)]
    procedure OnBeforeInitBankAccLedgEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Bank Account Ledger Entry", 'OnAfterCopyFromGenJnlLine', '', false, false)]
    procedure OnAfterCopyFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin

    end;
}


