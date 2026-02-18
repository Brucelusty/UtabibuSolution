//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17201 "Teller & Treasury Trans Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Treasury Transactions";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Enabled = VarTreasuryTransTypeEditable;

                    trigger OnValidate()
                    begin
                        ExcessShortageVisible := false;

                        if Rec."Transaction Type" = Rec."transaction type"::"End of Day Return to Treasury" then begin
                            ExcessShortageVisible := true;
                        end;

                        FnshowTreasuryCustodiantab();
                    end;
                }
                field("From Account"; Rec."From Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'From';
                    Editable = VarFromEditable;
                }
                field("From Account User"; Rec."From Account User")
                {
                    ApplicationArea = Basic;
                    Caption = 'User';
                    Editable = false;
                }
                field("Source Account Balance"; Rec."Source Account Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("To Account"; Rec."To Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'To';
                    Editable = VarToEditable;
                }
                field("To Account User"; Rec."To Account User")
                {
                    ApplicationArea = Basic;
                    Caption = 'User.';
                    Editable = false;
                }
                field("Destination Account Balance"; Rec."Destination Account Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = VarAmountEditable;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque/Document No.';
                    Visible = false;
                    Editable = VarDocumentNoEditable;
                }
                field(Issued; Rec.Issued)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Issued"; Rec."Date Issued")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Issued"; Rec."Time Issued")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Issued By"; Rec."Issued By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Time Received"; Rec."Time Received")
                {
                    ApplicationArea = Basic;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                group("Treasury/IntraDayIssue")
                {
                    Caption = 'Custodian Issue Details';
                    Visible = VarTreasuryIntrDayIssueVisible;
                    field("Custodian 1 Confirm Issue"; Rec."Custodian 1 Confirm Issue")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 1 Confirmed Issue';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 1 Name_Issue"; Rec."Custodian 1 Name_Issue")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 1 Name';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 2 Confirm Issue"; Rec."Custodian 2 Confirm Issue")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 2 Confirmed Issue';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 2 Name_Issue"; Rec."Custodian 2 Name_Issue")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 2 Name';
                        Editable = false;
                        Importance = Additional;
                    }
                }
                group("Treasury/IntraDayReceipt")
                {
                    Caption = 'Custodian Receipt Details';
                    Visible = VarTreasuryIntrDayReceiptVisible;
                    field("Custodian 1 Confirm Receipt"; Rec."Custodian 1 Confirm Receipt")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 1 Confirmed Receipt';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 1 Name_Receipt"; Rec."Custodian 1 Name_Receipt")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 1 Name';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 2 Confirm Receipt"; Rec."Custodian 2 Confirm Receipt")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 2 Confirmed Receipt';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 2 Name_Receipt"; Rec."Custodian 2 Name_Receipt")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 2 Name';
                        Editable = false;
                        Importance = Additional;
                    }
                }
                group(DepositSlip)
                {
                    Caption = 'Excess/Shortage';
                    Visible = ExcessShortageVisible;
                    field("Actual Teller Till Balance"; Rec."Actual Teller Till Balance")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Teller Till Balance';
                        Editable = false;
                    }
                    field("Actual Cash At Hand"; Rec."Actual Cash At Hand")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Excess Amount"; Rec."Excess Amount")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Shortage Amount"; Rec."Shortage Amount")
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
            part(Control1102755000; "Treasury Coinage")
            {
                SubPageLink = No = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CustodianConfirmIssue)
            {
                ApplicationArea = Basic;
                Caption = 'Custodian Confirm Issue';
                Image = IssueFinanceCharge;
                Promoted = true;
                PromotedCategory = Process;
                Visible = VarTreasuryIntrDayIssueVisible;

                trigger OnAction()
                begin

                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::Treasury);
                    if ObjCustodians.Find('-') = true then begin


                        Rec."Custodian 2 Confirm Receipt" := true;
                        Rec."Custodian 2 Name_Receipt" := UserId;
                        Rec.Modify(true);



                        // else
                        //     if (Rec."Custodian 2 Name_Issue" = '') and (Rec."Custodian 1 Name_Issue" <> UserId) then begin
                        //         Rec."Custodian 2 Confirm Issue" := true;
                        //         Rec."Custodian 2 Name_Issue" := UserId;
                        //         Rec.Modify(true);
                        //     end;
                        //Message('tested %1 - %2', Rec."Custodian 1 Confirm Issue", Rec."Custodian 2 Confirm Issue");
                    end;

                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::Treasury);
                    if ObjCustodians.Find('-') = false then begin
                        Error('You are not authorized to Issue  %1  Transaction', Rec."Transaction Type");
                    end;
                    Message('Custodian Issue Confirmed. You can Proceed to Issue..');
                end;
            }
            action(CustodianConfirmReceipt)
            {
                ApplicationArea = Basic;
                Caption = 'Custodian Confirm Receipt';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Process;
                Visible = VarTreasuryIntrDayReceiptVisible;

                trigger OnAction()
                begin
                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::Treasury);
                    if ObjCustodians.Find('-') = true then begin
                        if (Rec."Custodian 1 Name_Receipt" = '') and (Rec."Custodian 2 Name_Receipt" <> UserId) then begin
                            Rec."Custodian 1 Confirm Receipt" := true;
                            Rec."Custodian 1 Name_Receipt" := UserId
                        end;
                        // else
                        //     if (Rec."Custodian 2 Name_Receipt" = '') and (Rec."Custodian 1 Name_Receipt" <> UserId) then begin
                        //         Rec."Custodian 2 Confirm Receipt" := true;
                        //         Rec."Custodian 2 Name_Receipt" := UserId
                        //     end;
                    end;
                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::Treasury);
                    if ObjCustodians.Find('-') = false then begin
                        Error('You are not authorized to Receive  %1 Transactions', Rec."Transaction Type");
                    end;
                end;
            }
            action("Issue/Return")
            {
                ApplicationArea = Basic;
                Caption = 'Issue/Return';
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //--------------------Confirm Both Custodians has Confirmed Issue----------------------------------
                    // if (Rec."Transaction Type" = Rec."transaction type"::"Issue To Teller") or (Rec."Transaction Type" = Rec."transaction type"::"Treasury to Intra-Day") or
                    //   (Rec."Transaction Type" = Rec."transaction type"::"Intra-Day to Teller") or (Rec."Transaction Type" = Rec."transaction type"::"Issue From Bank")
                    //   or (Rec."Transaction Type" = Rec."transaction type"::"Return To Bank") or (Rec."Transaction Type" = Rec."transaction type"::"Branch Treasury Transactions") or
                    //   (Rec."Transaction Type" = Rec."transaction type"::"Intra-Day to Treasury") then begin
                    //     if (Rec."Custodian 1 Confirm Issue" <> true) then begin  //or (Rec."Custodian 2 Confirm Issue" <> true)
                    //         Error('Both Custodians have to Confirm issue before you can do %1 ', Rec."Transaction Type");
                    //     end;
                    // end;
                    //--------------------End Confirm Both Custodians has Confirmed Issue----------------------------------





                    Rec.TestField(Amount);
                    Rec.TestField("From Account");
                    Rec.TestField("To Account");
                    Rec.Testfield(Status, Rec.Status::Approved);
                    if (Rec."Transaction Type" = Rec."transaction type"::"Issue To Teller") or
                    (Rec."Transaction Type" = Rec."transaction type"::"Return To Treasury") or
                    (Rec."Transaction Type" = Rec."transaction type"::"Inter Teller Transfers") or
                    (Rec."Transaction Type" = Rec."transaction type"::"End of Day Return to Treasury") or
                    (Rec."Transaction Type" = Rec."transaction type"::"Intra-Day to Treasury")
                     // (Rec."Transaction Type" = Rec."transaction type"::"Intra-Day to Teller") or
                     // (Rec."Transaction Type" = Rec."transaction type"::"Teller to Intra-Day") or
                     // (Rec."Transaction Type" = Rec."transaction type"::"Treasury to Intra-Day")
                     then begin
                        if Rec.Issued = Rec.Issued::Yes then
                            Error('The money has already been issued.');

                        TellerTill.Reset;
                        TellerTill.SetRange(TellerTill."No.", Rec."From Account");
                        if TellerTill.Find('-') then begin
                            if UpperCase(UserId) <> TellerTill.CashierID then
                                Error('You do not have permission to transact on this teller till/Account.');
                        end;





                        Banks.Reset;
                        Banks.SetRange(Banks."No.", Rec."From Account");
                        if Banks.Find('-') then begin
                            Banks.CalcFields(Banks."Balance (LCY)");
                            BankBal := Banks."Balance (LCY)";
                            if Rec.Amount > BankBal then begin
                                Error('You cannot issue more than the Till balance.')
                            end;
                        end;

                        if Confirm('Are you sure you want to make this issue?', false) = true then begin
                            Rec.Issued := Rec.Issued::Yes;
                            Rec."Date Issued" := Today;
                            Rec."Time Issued" := Time;
                            Rec."Issued By" := UpperCase(UserId);
                            Rec.Modify;
                        end;


                        Message('Money successfully issued/Returned.');
                    end else begin
                        if Rec."Transaction Type" = Rec."transaction type"::"Return To Bank" then begin
                            Rec.TestField(Amount);
                            Rec.TestField("From Account");
                            Rec.TestField("To Account");


                            Banks.Reset;
                            Banks.SetRange(Banks."No.", Rec."From Account");
                            if Banks.Find('-') then begin
                                Banks.CalcFields("Balance (LCY)");
                                if Rec.Amount > Banks."Balance (LCY)" then
                                    Error('You cannot receive more than balance in ' + Rec."From Account")
                            end;

                            if Confirm('Are you sure you want to make this return?', false) = false then
                                exit;

                            UserSetup.Reset();
                            UserSetup.SetRange("User ID", UserId);
                            if UserSetup.Find('-') then begin
                                Dimension2 := UserSetup."Branch Code";
                                Dimension1 := 'FOSA';
                            end;
                            //Delete any items present
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                            GenJournalLine.DeleteAll;

                            if DefaultBatch.Get('GENERAL', 'FTRANS') = false then begin
                                DefaultBatch.Init;
                                DefaultBatch."Journal Template Name" := 'GENERAL';
                                DefaultBatch.Name := 'FTRANS';
                                DefaultBatch.Insert;
                            end;


                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := Rec.No;
                            GenJournalLine."External Document No." := Rec."Cheque No.";
                            GenJournalLine."Line No." := 10000;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                            GenJournalLine."Account No." := Rec."From Account";
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Currency Code" := Rec."Currency Code";
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := -Rec.Amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                            GenJournalLine."Bal. Account No." := Rec."To Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine.ValidateShortcutDimCode(1, Dimension1);
                            GenJournalLine.ValidateShortcutDimCode(2, Dimension2);
                            GenJournalLine.Description := Rec.Description;
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);



                            //GenJournalLine.RESET;
                            //GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name",'GENERAL');
                            //GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name",'FTRANS');
                            //IF GenJournalLine.FIND('-') = FALSE THEN BEGIN
                            Rec.Posted := true;
                            Rec."Date Posted" := Today;
                            Rec."Time Posted" := Time;
                            Rec."Posted By" := UpperCase(UserId);

                            Rec.Received := Rec.Received::Yes;
                            Rec."Date Received" := Today;
                            Rec."Time Received" := Time;
                            Rec."Received By" := UpperCase(UserId);
                            Rec.Modify;

                            //END;


                        end else
                            Message('Only applicable for teller, treasury & Bank Issues/Returns.');

                    end;
                    CurrPage.Close();
                end;
            }
            action(Receive)
            {
                ApplicationArea = Basic;
                Caption = 'Receive';
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //----------------Confirm Receipt from Both Custodians-----------------------------------------
                    if (Rec."Transaction Type" = Rec."transaction type"::"Return To Treasury") or
                      (Rec."Transaction Type" = Rec."transaction type"::"Intra-Day to Treasury") or (Rec."Transaction Type" = Rec."transaction type"::"Branch Treasury Transactions")
                    //   or (Rec."Transaction Type" = Rec."transaction type"::"Treasury to Intra-Day")
                      then begin
                        // if (Rec."Custodian 1 Confirm Receipt" <> true) or (Rec."Custodian 2 Confirm Receipt" <> true) then begin
                        //     Error('Both Custodians have to Confirm receipt before you can do %1 ', Rec."Transaction Type");
                        // end;
                    end;
                    //----------------End Confirm Receipt from Both Custodians-----------------------------------------



                    Rec.TestField(Amount);
                    Rec.TestField("From Account");
                    Rec.TestField("To Account");

                    if Rec."Transaction Type" = Rec."transaction type"::"Issue From Bank" then
                        Rec.TestField("Cheque No.");

                    CurrentTellerAmount := 0;
                    if Rec.Posted = true then
                        Error('The transaction has already been received and posted.');

                    ObjGLTransactions.Reset;
                    ObjGLTransactions.SetRange("Document No.", Rec.No);
                    if ObjGLTransactions.Find('-') then
                        Error('The transaction has already been received and posted.');


                    // if Rec."Transaction Type" = Rec."transaction type"::"Inter Teller Transfers" then begin
                    //     if Rec.Approved = false then
                    //         Error('Inter Teller Transfers must be approved.');
                    // end;

                    //IF ("Transaction Type"="Transaction Type"::"Return To Treasury") THEN
                    //ERROR('The issue has not yet been made and therefore you cannot continue with this transaction.');

                    if (Rec."Transaction Type" = Rec."transaction type"::"Issue To Teller") or
                    (Rec."Transaction Type" = Rec."transaction type"::"Branch Treasury Transactions") or
                    (Rec."Transaction Type" = Rec."transaction type"::"Inter Teller Transfers")
                then begin
                        if Rec.Issued = Rec.Issued::No then
                            Error('The issue has not yet been made and therefore you cannot continue with this transaction.');

                        TellerTill.Reset;
                        TellerTill.SetRange(TellerTill."No.", Rec."From Account");
                        if TellerTill.Find('-') then begin
                            TellerTill.CalcFields(Balance);
                            if Rec.Amount > TellerTill.Balance then
                                Error('The Issuing Account does not have sufficient balance to issue this amount');
                        end;


                        TellerTill.Reset;
                        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
                        TellerTill.SetRange(TellerTill."No.", Rec."To Account");
                        if TellerTill.Find('-') then begin
                            if UpperCase(UserId) <> TellerTill.CashierID then
                                Error('You do not have permission to transact on this teller till/Account.');

                            TellerTill.CalcFields(TellerTill.Balance);
                            CurrentTellerAmount := TellerTill.Balance;
                            if CurrentTellerAmount + Rec.Amount > TellerTill."Maximum Teller Withholding" then
                                Error('The transaction will result in the teller having a balance more than the maximum allowable therefor terminated.');
                            //MESSAGE('CONTINUE TRANSACTION');
                        end;
                    end;



                    if Confirm('Are you sure you want to make this receipt?', false) = true then begin
                        //EXIT;

                        //Delete any items present
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        if DefaultBatch.Get('GENERAL', 'FTRANS') = false then begin
                            DefaultBatch.Init;
                            DefaultBatch."Journal Template Name" := 'GENERAL';
                            DefaultBatch.Name := 'FTRANS';
                            DefaultBatch.Insert;
                        end;
                        UserSetup.Reset();
                        UserSetup.SetRange("User ID", UserId);
                        if UserSetup.Find('-') then begin
                            Dimension2 := UserSetup."Branch Code";
                            Dimension1 := 'FOSA';
                        end;
                       

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := Rec.No;
                        GenJournalLine."Line No." := 10000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No." := Rec."From Account";
                        GenJournalLine."External Document No." := Rec."Cheque No.";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Currency Code" := Rec."Currency Code";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := -Rec.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                        GenJournalLine."Bal. Account No." := Rec."To Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine.Description := Rec.Description;
                        GenJournalLine.Validate("Shortcut Dimension 1 Code", Dimension1);
                        GenJournalLine.Validate("Shortcut Dimension 2 Code", Dimension2);
                        GenJournalLine.Validate("Shortcut Dimension 1 Code");
                        GenJournalLine.Validate("Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;

                        //Post New

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;
                        //Post


                        Rec.Posted := true;
                        Rec."Date Posted" := Today;
                        Rec."Time Posted" := Time;
                        Rec."Posted By" := UpperCase(UserId);

                        Rec.Received := Rec.Received::Yes;
                        Rec."Date Received" := Today;
                        Rec."Time Received" := Time;
                        Rec."Received By" := UpperCase(UserId);
                        Rec.Modify;

                    end;
                    CurrPage.close;
                end;
            }
            action("EOD Report")
            {
                ApplicationArea = Basic;
                Caption = 'End Of Day Report';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Trans.Reset;
                    Trans.SetRange(Trans.No, Rec.No);
                    //Trans.SETRANGE(Trans."Date Posted","Date Posted");
                    if Trans.Find('-') then
                        Report.run(50075, true, true, Trans)
                end;
            }
            action(SENDMAIL)
            {
                ApplicationArea = Basic;
                Caption = 'SENDMAIL';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin


                    //SENDMAIL;
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("From Account");
                    Rec.TestField("To Account");
                    Rec.TestField(Amount);

                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Inter Teller Approval");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to approve inter teller transactions.');

                    Rec.Approved := true;
                    Message('Transaction Approved');
                    Rec.Modify;
                end;
            }
            action("Update Excess/Shortage")
            {
                ApplicationArea = Basic;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //FnGetCoinageAmount(No);
                    //FnGetActualAccountBalance();

                    Rec."Shortage Amount" := 0;
                    Rec."Excess Amount" := 0;

                    ExcessShortage := Rec."Actual Cash At Hand" - Rec."Total Cash on Treasury Coinage";
                    if ExcessShortage < 0 then begin
                        Rec."Excess Amount" := ExcessShortage
                    end else
                        Rec."Shortage Amount" := ExcessShortage;


                end;
            }
            group(Approvals)
            {
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::TreasuryTransactions;
                        ApprovalEntries.SetRecordFilters(Database::"Treasury Transactions", DocumentType, Rec.No);
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        Workflowintegration: Codeunit WorkflowIntegration;
                    begin

                        if Workflowintegration.CheckTTransactionsApprovalsWorkflowEnabled(Rec) then
                            Workflowintegration.OnSendTTransactionsForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin

                        //IF Approvalmgt.CancelFOSASTOApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."No.", Rec."From Account");
        TellerTill.CalcFields(TellerTill.Balance);
        if TellerTill.Find('-') then begin
            TellerTill.CalcFields(TellerTill.Balance);
            Rec."Source Account Balance" := TellerTill.Balance;
            Rec.Modify;
        end;

        if TellerTill.Get(Rec."From Account") then begin
            TellerTill.CalcFields(TellerTill.Balance);
            Rec."Actual Teller Till Balance" := TellerTill.Balance
        end;

        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."No.", Rec."To Account");
        TellerTill.CalcFields(TellerTill.Balance);
        if TellerTill.Find('-') then begin
            TellerTill.CalcFields(TellerTill.Balance);
            Rec."Destination Account Balance" := TellerTill.Balance;
            Rec.Validate("Destination Account Balance");
            Rec.Modify;
        end;
        FnGetExcessshortageAmount();
    end;

    trigger OnAfterGetRecord()
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        EnableSendForApprovalBanksOnly := true;

        if (Rec."Transaction Type" <> Rec."transaction type"::"Issue From Bank") or (Rec."Transaction Type" <> Rec."transaction type"::"Return To Bank") then begin
            EnableSendForApprovalBanksOnly := false;
        end;

        VarTreasuryTransTypeEditable := true;
        VarAmountEditable := true;
        VarDocumentNoEditable := true;
        VarFromEditable := true;
        VarToEditable := true;

        if Rec.Issued = Rec.Issued::Yes then begin
            VarTreasuryTransTypeEditable := false;
            VarAmountEditable := false;
            VarDocumentNoEditable := false;
            VarFromEditable := false;
            VarToEditable := false;
        end;

        FnshowTreasuryCustodiantab();
    end;

    trigger OnOpenPage()
    begin


        ExcessShortageVisible := false;

        if Rec."Transaction Type" = Rec."transaction type"::"End of Day Return to Treasury" then begin
            ExcessShortageVisible := true;
        end;

        if Rec.Posted = true then
            CurrPage.Editable := false;

        TellerTill.Reset;
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        TellerTill.CalcFields(TellerTill.Balance);
        if TellerTill.FindSet then begin
            //IF "Transaction Type"="Transaction Type"::"End of Day Return to Treasury" THEN BEGIN
            Rec.Amount := TellerTill.Balance;
            Rec."From Account" := TellerTill."No.";
            Rec."From Account User" := TellerTill.CashierID;
            //VALIDATE("From Account");
            //END;
        end;

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        EnableSendForApprovalBanksOnly := true;

        if (Rec."Transaction Type" <> Rec."transaction type"::"Issue From Bank") or (Rec."Transaction Type" <> Rec."transaction type"::"Return To Bank") then begin
            EnableSendForApprovalBanksOnly := false;
        end;


        VarTreasuryTransTypeEditable := true;
        VarAmountEditable := true;
        VarDocumentNoEditable := true;
        VarFromEditable := true;
        VarToEditable := true;

        if Rec.Issued = Rec.Issued::Yes then begin
            VarTreasuryTransTypeEditable := false;
            VarAmountEditable := false;
            VarDocumentNoEditable := false;
            VarFromEditable := false;
            VarToEditable := false;
        end;


        FnshowTreasuryCustodiantab();
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        Banks: Record "Bank Account";
        BankBal: Decimal;
        TotalBal: Decimal;
        DenominationsRec: Record Denominations;
        TillNo: Code[20];
        Trans: Record "Treasury Transactions";
        UsersID: Record User;
        StatusPermissions: Record "Status Change Permision";
        "Gen-Setup": Record "Sacco General Set-Up";
        SendToAddress: Text[30];
        BankAccount: Record "Bank Account";
        MailContent: Text[150];
        SenderName: Code[20];
        TreauryTrans: Record "Treasury Transactions";
        Coinage: Record "Treasury Coinage";
        ObjCoinage: Record "Treasury Coinage";
        TotalTCoinage: Decimal;
        ActualTillBalance: Decimal;
        ExcessShortage: Decimal;

        Dimension1: Code[200];
        Dimension2: Code[200];
        "Excess/Shortage": Integer;
        ExcessShortageVisible: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions;
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EnableSendForApprovalBanksOnly: Boolean;
        VarTreasuryTransTypeEditable: Boolean;
        VarFromEditable: Boolean;
        VarToEditable: Boolean;
        VarAmountEditable: Boolean;
        VarDocumentNoEditable: Boolean;
        VarTreasuryIntrDayIssueVisible: Boolean;
        VarTreasuryIntrDayReceiptVisible: Boolean;
        ObjCustodians: Record "Safe Custody Custodians";
        ObjGLTransactions: Record "G/L Entry";
        UserSetup: Record "User Setup";

    local procedure FnGetExcessshortageAmount()
    var
        VarExcessShortage: Decimal;
    begin
        VarExcessShortage := 0;

        Rec.CalcFields("Actual Cash At Hand");

        VarExcessShortage := Rec."Actual Teller Till Balance" - Rec."Actual Cash At Hand";

        if VarExcessShortage > 0 then begin
            Rec."Shortage Amount" := VarExcessShortage
        end;

        if VarExcessShortage < 0 then begin
            Rec."Excess Amount" := VarExcessShortage * -1
        end;
        if VarExcessShortage = 0 then begin
            Rec."Shortage Amount" := 0;
            Rec."Excess Amount" := 0;
        end;
    end;

    local procedure FnshowTreasuryCustodiantab()
    begin
        VarTreasuryIntrDayIssueVisible := false;

        if (Rec."Transaction Type" = Rec."transaction type"::"Issue To Teller") or
           (Rec."Transaction Type" = Rec."transaction type"::"Issue From Bank")
          or (Rec."Transaction Type" = Rec."transaction type"::"Return To Bank") or (Rec."Transaction Type" = Rec."transaction type"::"Branch Treasury Transactions") or
          (Rec."Transaction Type" = Rec."transaction type"::"Intra-Day to Treasury") then begin
            VarTreasuryIntrDayIssueVisible := true;
        end;

        VarTreasuryIntrDayReceiptVisible := false;

        if (Rec."Transaction Type" = Rec."transaction type"::"Return To Treasury") or
          (Rec."Transaction Type" = Rec."transaction type"::"Intra-Day to Treasury") or (Rec."Transaction Type" = Rec."transaction type"::"Branch Treasury Transactions")

          then begin
            VarTreasuryIntrDayReceiptVisible := true;
        end;
    end;


}




