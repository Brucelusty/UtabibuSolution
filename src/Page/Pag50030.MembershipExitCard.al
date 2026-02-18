Page 50030 "Membership Exit Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Exist";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    //Editable = MNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = Basic;
                    //Editable = ClosingDateEditable;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Date';
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closure Type"; Rec."Closure Type")
                {
                    ApplicationArea = Basic;

                }
                field("Total Loan"; Rec."Total Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Loan BOSA';
                    Editable = false;
                }
                field("Total Interest"; Rec."Total Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due BOSA';
                    Editable = false;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field
                ("Member Liability2"; Rec."Member Liability2")
                {
                    Caption = 'Member Liability';
                    Editable = true;
                }
                field("Share Capital ded"; Rec."Share Capital ded")
                {

                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Charge Withdrawal"; Rec."Charge Withdrawal")
                {

                }
                field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Paying Bank"; Rec."Paying Bank")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field(Payee; rec.Payee)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Credit Comments"; Rec."Credit Comments")
                {
                    MultiLine = true;
                    Visible = False;
                    // ShowMandatory = true;
                }
                field("Finance Comments"; Rec."Finance Comments")
                {

                    MultiLine = true;
                    Visible = False;
                    // ShowMandatory = true;
                }




            }
            group("Share Capital Transfer Details")
            {
                Caption = 'Share Capital Transfer Details';
                Visible = ShareCapitalTransferVisible;
                field("Share Capital Transfer Fee"; Rec."Share Capital Transfer Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Share Capital Sell"; "Share Capital Sell")
            {
                SubPageLink = "Document No" = field("No."),
                              "Selling Member No" = field("Member No."),
                              "Selling Member Name" = field("Member Name");
                Visible = ShareCapSellPageVisible;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        GentBatches: Record 232;
                    begin
                        rec.TestField(Posted, false);

                        if Confirm('Are you absolutely sure you want to recover the loans from member deposit') = false then
                            exit;

                        WithdrawalFee := 0;
                        TransferFee := 0;
                        RunningBal := 0;
                        PayableAmount := 0;
                        WithdrawableCharge := 0;
                        WatotoCharge := 0;
                        TotalChequeCharge := 0;
                        AmountBal := 0;

                        //-----------------------------------------Assign Standard variables-------------------------------------------------------------
                        DActivity := cust."Global Dimension 1 Code";
                        DBranch := cust."Global Dimension 2 Code";
                        TemplateName := 'GENERAL';
                        BatchName := 'CLOSURE';

                        Doc_No := rec."No.";
                        GentBatches.Reset();
                        GentBatches.SetRange(Name, BatchName);
                        GentBatches.SetRange("Journal Template Name", TemplateName);
                        if GentBatches.FindFirst() = false then begin
                            GentBatches.Name := BatchName;
                            GentBatches.Description := BatchName;
                            GentBatches."Journal Template Name" := TemplateName;
                            GentBatches.Insert(true);
                        end;
                        Gnljnline.Reset;
                        Gnljnline.SetRange("Journal Template Name", TemplateName);
                        Gnljnline.SetRange("Journal Batch Name", BatchName);
                        if Gnljnline.FindFirst() then begin
                            Gnljnline.DeleteAll;
                        end;

                        if cust.Get(rec."Member No.") then begin
                            // if rec."Net Payable to the Member" < 0 then Error('The net payable ');



                            IF cust.GET(Rec."Member No.") THEN BEGIN
                                IF (rec."Closure Type" = rec."Closure Type"::"Member Exit-Defaulter") THEN BEGIN

                                    IF (Rec."Member Deposits" - (Rec."Total Loan" + Rec."Total Interest")) < 0 THEN


                                        //Delete journal line
                                    Gnljnline.RESET;
                                    Gnljnline.SETRANGE("Journal Template Name", 'GENERAL');
                                    Gnljnline.SETRANGE("Journal Batch Name", 'ClOSURE');
                                    Gnljnline.DELETEALL;
                                    //End of deletion


                                    Totalrecovered := 0;
                                    TotalInsuarance := 0;

                                    DActivity := cust."Global Dimension 1 Code";
                                    DBranch := cust."Global Dimension 2 Code";
                                    cust.CALCFIELDS(cust."Outstanding Balance", "Accrued Interest", "Current Shares", cust."Outstanding Interest");

                                    cust.CALCFIELDS(cust."Outstanding Balance", cust."Outstanding Interest", "FOSA Outstanding Balance", "Accrued Interest", cust."Current Shares");
                                    TotalOustanding := cust."Outstanding Balance" + cust."Outstanding Interest";

                                    AmountBal := cust."Current Shares";
                                    RunBal := cust."Current Shares";
                                    Generalsetup.GET();

                                    IF RunBal > 0 THEN BEGIN
                                        "Remaining Amount" := cust."Closing Deposit Balance";

                                        LoansR.RESET;
                                        LoansR.SETRANGE(LoansR."Client Code", rEC."Member No.");
                                        LoansR.SETRANGE(LoansR.Source, LoansR.Source::BOSA);
                                        IF LoansR.FIND('-') THEN BEGIN
                                            REPEAT
                                                LoansR.CALCFIELDS(LoansR."Outstanding Balance", LoansR."Outstanding Interest");
                                                TotalInsuarance := TotalInsuarance + LoansR."Loans Insurance";
                                            UNTIL LoansR.NEXT = 0;
                                        END;
                                    END;

                                    // -------------------------------Recover Defaulter Loan Principle Balance-------------------------------------------
                                    LoansR.RESET;
                                    LoansR.SETCURRENTKEY(LoansR."Issued Date");
                                    LoansR.ASCENDING(TRUE);
                                    LoansR.SETRANGE(LoansR."Client Code", Rec."Member No.");
                                    LoansR.SETRANGE(LoansR.Source, LoansR.Source::BOSA);
                                    // LoansR.SETFILTER(LoansR."Loan Product Type", 'DEFAULTER');
                                    IF LoansR.FIND('-') THEN BEGIN

                                        REPEAT

                                            "AMOUNTTO BE RECOVERED" := 0;
                                            LoansR.CALCFIELDS(LoansR."Outstanding Balance", LoansR."Outstanding Interest");

                                            IF (LoansR."Outstanding Interest" > 0) THEN BEGIN
                                                PrincipleDeduct := 0;
                                                PrincipleDeduct := LoansR."Outstanding Interest";
                                                IF RunBal > PrincipleDeduct THEN
                                                    LoanAmount := PrincipleDeduct
                                                ELSE
                                                    LoanAmount := RunBal;
                                                //Defaulter Loan Recovery

                                                LineNo := LineNo + 10000;
                                                AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                                GenJournalLine."Account Type"::Customer, LoansR."Client Code", rec."Posting Date", LoanAmount * -1, DActivity,
                                                LoansR."Loan  No.", 'Interest Cleared by deposits: ' + rec."No." + '-' + LoansR."Loan  No.", LoansR."Loan  No.", GenJournalLine."Application Source"::" ");

                                                //interest deduction balancing Line

                                                LineNo := LineNo + 10000;
                                                AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                                GenJournalLine."Account Type"::Customer, LoansR."Client Code", rec."Posting Date", LoanAmount, DActivity,
                                                LoansR."Loan  No.", 'Interest Cleared by deposits: ' + rec."No." + '-' + LoansR."Loan  No.", LoansR."Loan  No.", GenJournalLine."Application Source"::" ");

                                                RunBal := RunBal - LoanAmount;
                                                TotalDed := TotalDed + LoanAmount;
                                            END;
                                        UNTIL LoansR.NEXT = 0;
                                    END;

                                    cust."Closing Deposit Balance" := (cust."Closing Deposit Balance");
                                    AmountBal := AmountBal - GenJournalLine.Amount;
                                    DepositRef := DepositRef + GenJournalLine.Amount;
                                    //END;
                                    // ------------------------------- End Defaulter Recover Loan Principle Balance-------------------------------------------
                                    IF RunBal > 0 THEN BEGIN
                                        //Capitalize Interest to Loans
                                        "Remaining Amount" := cust."Closing Deposit Balance";

                                        LoansR.RESET;
                                        LoansR.SETCURRENTKEY(LoansR."Issued Date");
                                        LoansR.ASCENDING(TRUE);
                                        LoansR.SETRANGE(LoansR."Client Code", Rec."Member No.");
                                        LoansR.SETRANGE(LoansR.Source, LoansR.Source::BOSA);
                                        IF LoansR.FIND('-') THEN BEGIN
                                            REPEAT
                                                //IF LoansR."Loan Product Type"<>'FOA|SHYLOCK' THEN BEGIN
                                                LoansR.CALCFIELDS(LoansR."Outstanding Balance", LoansR."Outstanding Interest", LoansR."Penalty Charged");
                                                IF LoansR."Penalty Charged" > 0 THEN BEGIN
                                                    AmountToDeduct := 0;
                                                    AmountToDeduct := LoansR."Penalty Charged" + LoansR."Penalty Paid";
                                                    //MESSAGE(FORMAT(AmountToDeduct));
                                                    "AMOUNTTO BE RECOVERED" := 0;
                                                    IF RunBal > AmountToDeduct THEN
                                                        OutBal := AmountToDeduct
                                                    ELSE
                                                        OutBal := RunBal;

                                                    LineNo := LineNo + 10000;
                                                    AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Penalty Paid",
                                                    GenJournalLine."Account Type"::Customer, LoansR."Client Code", rec."Posting Date", OutBal * -1, DActivity,
                                                    LoansR."Loan  No.", 'Penalty Recovery:  ' + rec."No." + '-' + LoansR."Loan  No.", LoansR."Loan  No.", GenJournalLine."Application Source"::" ");

                                                    //interest deduction balancing Line

                                                    LineNo := LineNo + 10000;
                                                    AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                                    GenJournalLine."Account Type"::Customer, LoansR."Client Code", rec."Posting Date", OutBal, DActivity,
                                                    LoansR."Loan  No.", 'Penalty Cleared by deposits: ' + rec."No." + '-' + LoansR."Loan  No.", LoansR."Loan  No.", GenJournalLine."Application Source"::" ");

                                                    AmountBal := AmountBal - GenJournalLine.Amount;
                                                    DepositRef := DepositRef + GenJournalLine.Amount;
                                                    RunBal := RunBal - OutBal;
                                                    TotalDed := TotalDed + OutBal;
                                                    //END;
                                                END;
                                            UNTIL LoansR.NEXT = 0;
                                        END;
                                    END;

                                    // -------------------------------  Recover Loan penalty Balance-------------------------------------------
                                    //--------------------------------Interest Recovery -------------------------------------------------------
                                    IF RunBal > 0 THEN BEGIN
                                        //Capitalize Interest to Loans
                                        "Remaining Amount" := cust."Closing Deposit Balance";

                                        LoansR.RESET;
                                        LoansR.SETCURRENTKEY(LoansR."Issued Date");
                                        LoansR.ASCENDING(TRUE);
                                        LoansR.SETRANGE(LoansR."Client Code", Rec."Member No.");
                                        LoansR.SETRANGE(LoansR.Source, LoansR.Source::BOSA);
                                        IF LoansR.FIND('-') THEN BEGIN
                                            REPEAT

                                                LoansR.CALCFIELDS(LoansR."Outstanding Balance", LoansR."Outstanding Interest");
                                                IF LoansR."Outstanding Balance" > 0 THEN BEGIN
                                                    AmountToDeduct := 0;
                                                    AmountToDeduct := LoansR."Outstanding Balance";
                                                    "AMOUNTTO BE RECOVERED" := 0;
                                                    IF RunBal > AmountToDeduct THEN
                                                        OutBal := AmountToDeduct
                                                    ELSE
                                                        OutBal := RunBal;

                                                    LineNo := LineNo + 10000;
                                                    AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::Repayment,
                                                    GenJournalLine."Account Type"::Customer, LoansR."Client Code", rec."Posting Date", OutBal * -1, DActivity,
                                                    LoansR."Loan  No.", 'Loan Cleared by deposits:  ' + rec."No." + '-' + LoansR."Loan  No.", LoansR."Loan  No.", GenJournalLine."Application Source"::" ");

                                                    //interest deduction balancing Line

                                                    LineNo := LineNo + 10000;
                                                    AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                                    GenJournalLine."Account Type"::Customer, LoansR."Client Code", rec."Posting Date", OutBal, DActivity,
                                                    LoansR."Loan  No.", 'Loan Cleared by deposits:  ' + rec."No." + '-' + LoansR."Loan  No.", LoansR."Loan  No.", GenJournalLine."Application Source"::" ");

                                                    AmountBal := AmountBal - GenJournalLine.Amount;
                                                    DepositRef := DepositRef + GenJournalLine.Amount;
                                                    RunBal := RunBal - OutBal;
                                                    TotalDed := TotalDed + OutBal;
                                                    //END;
                                                END;
                                            UNTIL LoansR.NEXT = 0;
                                        END;
                                    END;
                                    //-------------------------------- End Interest Recovery -------------------------------------------------------




                                    // -------------------------------Recover Other Loan Principle Balance-------------------------------------------
                                    IF RunBal > 0 THEN BEGIN
                                        IF RunBal > Rec."Total Loan" THEN BEGIN

                                            LoansR.RESET;
                                            LoansR.SETCURRENTKEY(LoansR."Issued Date");
                                            LoansR.ASCENDING(TRUE);
                                            LoansR.SETRANGE(LoansR."Client Code", Rec."Member No.");
                                            LoansR.SETRANGE(LoansR.Source, LoansR.Source::BOSA);
                                            //LoansR.SETFILTER(LoansR."Loan Product Type", '<>%1','DEFAULTER');
                                            IF LoansR.FIND('-') THEN BEGIN
                                                //IF LoansR."Loan Product Type"='DEFAULTER' THEN BEGIN

                                                REPEAT

                                                    "AMOUNTTO BE RECOVERED" := 0;
                                                    LoansR.CALCFIELDS(LoansR."Outstanding Balance", LoansR."Outstanding Interest");

                                                    //IF (LoansR."Outstanding Balance" <> 0) THEN
                                                    IF (LoansR."Outstanding Balance" <> 0) then //AND (LoansR."Loan Product Type" <> 'DEFAULTER') THEN
                                                    //MESSAGE('Outstanding Bal %1 and Runbal %2',LoansR."Outstanding Balance",Runbal);
                                                    BEGIN
                                                        IF (RunBal > 0) THEN BEGIN
                                                            PrincipleDeduct := 0;
                                                            PrincipleDeduct := LoansR."Outstanding Balance";
                                                            IF RunBal > PrincipleDeduct THEN
                                                                LoanAmount := PrincipleDeduct
                                                            ELSE
                                                                LoanAmount := RunBal;
                                                            //Defaulter Loan Recovery

                                                            LineNo := LineNo + 10000;
                                                            AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::Repayment,
                                                            GenJournalLine."Account Type"::Customer, LoansR."Client Code", rec."Posting Date", LoanAmount * -1, DActivity,
                                                            LoansR."Loan  No.", 'Other Loan Cleared by deposits:  ' + rec."No." + '-' + LoansR."Loan  No.", LoansR."Loan  No.", GenJournalLine."Application Source"::" ");


                                                            LineNo := LineNo + 10000;
                                                            AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                                            GenJournalLine."Account Type"::Customer, LoansR."Client Code", rec."Posting Date", LoanAmount * -1, DActivity,
                                                            LoansR."Loan  No.", 'Other Loan Cleared by deposits:  ' + rec."No." + '-' + LoansR."Loan  No.", LoansR."Loan  No.", GenJournalLine."Application Source"::" ");

                                                            RunBal := RunBal - LoanAmount;
                                                            TotalDed := TotalDed + LoanAmount;
                                                        END;
                                                    END;
                                                UNTIL LoansR.NEXT = 0;
                                            END;

                                            cust."Closing Deposit Balance" := (cust."Closing Deposit Balance");
                                            AmountBal := AmountBal - GenJournalLine.Amount;
                                            DepositRef := DepositRef + GenJournalLine.Amount;
                                        END ELSE

                                                                //-------------------------------------- Priority Recoveries---------------------------------------------------
                                                                BEGIN

                                            counts := 0;
                                            TransCount := 1;

                                            Lproducts.RESET;
                                            Lproducts.SETRANGE(Lproducts.Code);
                                            //LProducts.SETFILTER(LProducts.Source,'%1',LProducts.Source::BOSA);
                                            IF Lproducts.FIND('-') THEN BEGIN
                                                REPEAT
                                                BEGIN
                                                    counts := counts + 1;
                                                    TransCode := Lproducts.Code;
                                                END;

                                                LoansR.RESET;
                                                LoansR.SETCURRENTKEY(LoansR."Issued Date");
                                                LoansR.ASCENDING(TRUE);
                                                LoansR.SETRANGE(LoansR."Client Code", Rec."Member No.");
                                                LoansR.SETRANGE(LoansR.Source, LoansR.Source::BOSA);
                                                LoansR.SETRANGE(LoansR."Loan Product Type", TransCode);
                                                //LoansR.SETFILTER(LoansR."Loan Product Type", '<>%1','DEFAULTER');
                                                IF LoansR.FIND('-') THEN BEGIN
                                                    //IF LoansR."Loan Product Type"='DEFAULTER' THEN BEGIN

                                                    REPEAT

                                                        "AMOUNTTO BE RECOVERED" := 0;
                                                        LoansR.CALCFIELDS(LoansR."Outstanding Balance", LoansR."Outstanding Interest");

                                                        IF (LoansR."Outstanding Balance" <> 0) Then //AND (LoansR."Loan Product Type" <> 'DEFAULTER') THEN
                                                        //MESSAGE('Outstanding Bal %1 and Runbal %2',LoansR."Outstanding Balance",Runbal);
                                                        BEGIN
                                                            IF (RunBal > 0) THEN BEGIN
                                                                PrincipleDeduct := 0;
                                                                PrincipleDeduct := LoansR."Outstanding Balance";
                                                                IF RunBal > PrincipleDeduct THEN
                                                                    LoanAmount := PrincipleDeduct
                                                                ELSE
                                                                    //     LoanAmount := RunBal;
                                                                    // //Defaulter Loan Recovery
                                                                    // LineNo := LineNo + 10000;
                                                                    // AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::Repayment,
                                                                    // GenJournalLine."Account Type"::Customer, LoansR."Client Code", rec."Posting Date", LoanAmount * -1, DActivity,
                                                                    // LoansR."Loan  No.", 'Cleared by deposits:  ' + rec."No." + '-' + LoansR."Loan  No.", LoansR."Loan  No.", GenJournalLine."Application Source"::" ");

                                                                    // LineNo := LineNo + 10000;
                                                                    // AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                                                    // GenJournalLine."Account Type"::Customer, LoansR."Client Code", rec."Posting Date", LoanAmount * -1, DActivity,
                                                                    // LoansR."Loan  No.", 'Cleared by deposits:  ' + rec."No." + '-' + LoansR."Loan  No.", '', GenJournalLine."Application Source"::" ");

                                                                    // RunBal := RunBal - LoanAmount;
                                                                    TotalDed := TotalDed + LoanAmount;
                                                            END;
                                                        END;
                                                    UNTIL LoansR.NEXT = 0;
                                                END;

                                                cust."Closing Deposit Balance" := (cust."Closing Deposit Balance");
                                                AmountBal := AmountBal - GenJournalLine.Amount;
                                                DepositRef := DepositRef + GenJournalLine.Amount;
                                                UNTIL Lproducts.NEXT = 0;
                                            END;
                                        END;
                                        //-------------------------------------- Priority Recoveries---------------------------------------------------

                                    END;
                                    //-------------------------------Remaining Amount to Deposit-------------------------------
                                    // IF RunBal > 0 THEN BEGIN
                                    //     LineNo := LineNo + 10000;
                                    //     AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                    //                GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Posting Date", "RunBal", DActivity, rec."No.", 'Account Rec(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");

                                    //     LineNo := LineNo + 10000;
                                    //     AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Share Capital",
                                    //            GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Posting Date", RunBal * -1, DActivity, rec."No.", 'Account Rec(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");
                                    // end;
                                END;

                                // exit;
                                // GenJournalLine.Reset();
                                // GenJournalLine.setrange("Journal Batch Name", BatchName);
                                // GenJournalLine.setrange("Journal Template Name", TemplateName);
                                // if GenJournalLine.findfirst() then begin
                                //     Codeunit.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
                                // end;
                                // rec."Closing Date" := Today;
                                // rec.Posted := true;
                                // Message('Closure Posted Successfully.');


                            END;
                            //-----------------------------------------Assign Standard variables-------------------------------------------------------------
                            DActivity := cust."Global Dimension 1 Code";
                            DBranch := cust."Global Dimension 2 Code";
                            TemplateName := 'GENERAL';
                            BatchName := 'CLOSURE';
                            Doc_No := rec."No.";
                            GentBatches.Reset();
                            GentBatches.SetRange(Name, BatchName);
                            GentBatches.SetRange("Journal Template Name", TemplateName);
                            if GentBatches.FindFirst() = false then begin
                                GentBatches.Name := BatchName;
                                GentBatches.Description := BatchName;
                                GentBatches."Journal Template Name" := TemplateName;
                                GentBatches.Insert(true);
                            end;

                            Generalsetup.Get();
                            ChequeCharge := Generalsetup."Loan Trasfer Fee-Cheque";
                            ChequeChargeGL := Generalsetup."Mpesa A/c";


                            if rec."Sell Share Capital" then begin
                                TransferFee := Generalsetup."Share Capital Transfer Fee";
                                TransferGL := Generalsetup."Share Capital Transfer Fee Acc";
                            end;
                            Rec.TestField(Rec.Status, Rec.Status::Approved);

                            //------------------------------------------Assign Standard variables-----------------------------------------------------------------

                            //------------------------------------------Delete Journal Lines----------------------------------------------------------------------

                            //------------------------------------------Post Transaction---------------------------------------------------------------------------
                            if (rec."Closure Type" = rec."Closure Type"::"Member Exit - Normal") then begin
                                RunningBal := rec."Member Deposits" + rec.Dependand1 + rec.dependand2 + rec.dependand3 + rec.PrdOverdeduction;
                                RunningBal := FnPostSavingsCharge(RunningBal);

                                FnDebitMemberDepositsAndShareCapital(rec."Member Deposits", rec."Share Capital to Sell", Rec.Dependand1);
                                RunningBal := FnRecoverBOSAInterest(RunningBal);
                                RunningBal := FnRecoverBOSALoanPrinciple(RunningBal);
                                //RunningBal := FnRecoverBOSAPenalty(RunningBal);

                                //RunningBal:=FnRecoverFOSALoanPrinciple(RunningBal);
                                //RunningBal := FnRecoverFOSAInterest(RunningBal);
                                RunningBal := FnPostChequeCharge(RunningBal);

                                if (rec."Mode Of Disbursement" = Rec."Mode Of Disbursement"::"M-Pesa") then
                                    TotalChequeCharge := Generalsetup."M-Pesa Charge(0-10K)";

                                PayableAmount := rec."Member Deposits" + rec.Dependand1 + rec.dependand2 + rec.dependand3 + rec.PrdOverdeduction - (Rec."Share Capital ded" + rec."Total Loan" + Rec."Total Interest" + Rec."Member Liability2" + WithdrawableCharge + TotalChequeCharge + Rec."Total Penalty");
                                if PayableAmount < 0 then Error('Net pay is less than zero payable amount %1', PayableAmount);
                                if PayableAmount < 0 then
                                    PayableAmount := 0
                                else
                                    PayableAmount := PayableAmount;
                                FnTransferToCurrentAccount(PayableAmount);




                                //----------------------------------------Post Transaction----------------------------------------------------------------------------
                            end else
                                if (rec."Closure Type" = rec."Closure Type"::"Member Exit - Deceased") then begin
                                    RunningBal := rec."Member Deposits";
                                    FnDebitMemberDepositsAndShareCapital(rec."Member Deposits", rec."Share Capital to Sell", rec.Dependand1);
                                    PayableAmount := rec."Member Deposits" + rec.Dependand1 + rec.dependand2 + rec.dependand3 + rec.PrdOverdeduction - (TotalChequeCharge + WithdrawableCharge);
                                    FnTransferToCurrentAccount(RunningBal);
                                end else

                                    //CHANGE ACCOUNT STATUS

                                    if (rec."Closure Type" = rec."Closure Type"::"Member Exit - Deceased") then begin
                                        cust.Reset;
                                        cust.SetRange(cust."No.", rec."Member No.");
                                        if cust.Find('-') then begin
                                            cust.Status := cust.Status::Deceased;
                                            cust."Closing Date" := Today;
                                            //cust.Blocked := cust.Blocked::All;
                                            cust.Modify;
                                        end;

                                    end;

                            cust.Reset;
                            cust.SetRange(cust."No.", rec."Member No.");
                            if cust.Find('-') then begin
                                cust.Status := cust.Status::Exited;
                                cust."Closing Date" := Today;
                                cust."Withdrawal Date" := Today;
                                //cust.Blocked := cust.Blocked::All;
                                cust.Modify;
                            end;

                           // exit;

                            GenJournalLine.Reset();
                            GenJournalLine.setrange("Journal Batch Name", BatchName);
                            GenJournalLine.setrange("Journal Template Name", TemplateName);
                            if GenJournalLine.findfirst() then begin
                                Codeunit.Run(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
                            end;
                        END;

                        rec."Closing Date" := Today;
                        rec.Posted := true;
                        Message('Closure Posted Successfully.');

                        CurrPage.Close();
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin
                        // Rec.TESTFIELD("Finance Comments");
                        // Rec.TestField("Credit Comments");
                        IF Rec.Status <> Rec.Status::Open THEN
                            ERROR(text001);

                        if ApprovalsMgmt.CheckMWithdrawalApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendMWithdrawalForApproval(Rec);

                        //Change Status To Awaiting Withdrawing


                        GenSetUp.Get();

                        if Generalsetup."Send Membership Withdrawal SMS" = true then begin
                            FnSendWithdrawalApplicationSMS();
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        if ApprovalMgt.IsMWithdrawalApprovalsWorkflowEnabled(Rec) then
                            ApprovalMgt.OnCancelMWithdrawalApprovalRequest(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        RecI: RecordId;
                    begin
                        RecI := Rec.RecordId;
                        ApprovalsMgmt.OpenApprovalEntriesPage(RecI);
                    end;
                }
                action("Account Rec Slip")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        cust.Reset;
                        cust.SetRange(cust."No.", rec."Member No.");
                        if cust.Find('-') then
                            Report.Run(80008, true, false, cust);//172474
                    end;
                }

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        Recid: RecordId;
    begin
        UpdateControl();
        Recid := Rec.RecordId;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Recid);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Recid);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        if rec."Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;
        //"Mode Of Disbursement":="Mode Of Disbursement"::Vendor;
        //MODIFY;
        UpdateControl();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    trigger OnOpenPage()
    begin
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        PostingDateEditable := false;
        if rec."Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;
        rec."Mode Of Disbursement" := rec."mode of disbursement"::"Bank Account";
        UpdateControl();
    end;

    var
        Text001: label 'Not Approved';
        cust: Record Customer;
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        MNoEditable: Boolean;
        ClosingDateEditable: Boolean;
        RecTypeEditable: Boolean;
        PostingDateEditable: Boolean;
        TotalFOSALoan: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[30];
        DBranch: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        "Remaining Amount": Decimal;
        LoansR: Record "Loans Register";
        "AMOUNTTO BE RECOVERED": Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        RecR: Record "Membership Exist";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        PTEN: Text;
        Customer: Record Customer;
        GenSetUp: Record "Sacco General Set-Up";
        compinfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ShareCapitalTransferVisible: Boolean;
        ShareCapSellPageVisible: Boolean;
        ObjShareCapSell: Record "Share Capital Sell";
        AUFactory: Codeunit "Au Factory";
        JVTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        JVAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        TemplateName: Code[20];
        BatchName: Code[20];
        JVBalAccounttype: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        JVBalAccountNo: Code[20];
        TransferFee: Decimal;
        WithdrawalFee: Decimal;
        TransferGL: Code[20];
        WithFeeGL: Code[20];
        ExciseGL: Code[20];
        RunningBal: Decimal;
        AmountBal: Decimal;
        LoanAmount: Decimal;
        TotalDed: Decimal;
        OutBal: Decimal;
        DepositRef: Decimal;
        AmountToDeduct: Decimal;
        counts: Integer;
        TransCount: Integer;
        TransCode: Code[30];
        PrincipleDeduct: Decimal;
        RunBal: Decimal;
        EnabledApprovalWorkflowsExist: Boolean;
        Lproducts: Record "Loan Products Setup";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        OpenApprovalEntriesExist: Boolean;
        // MWithdrawalGraduatedCharges: Record "MWithdrawal Graduated Charges";
        MemberRegister: Record Customer;
        ChequeCharge: Decimal;
        ChequeChargeGL: Code[10];
        PayableAmount: Decimal;
        WatotoCharge: Decimal;
        WithdrawableCharge: Decimal;
        PayWatoto: Decimal;
        PayHSS: Decimal;
        TotalChequeCharge: Decimal;


    procedure UpdateControl()
    begin
        if rec.Status = rec.Status::Open then begin
            MNoEditable := true;
            ClosingDateEditable := false;
            RecTypeEditable := true;
            PostingDateEditable := false;
        end;

        if rec.Status = rec.Status::Pending then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            RecTypeEditable := false;
            PostingDateEditable := false;
        end;

        if rec.Status = rec.Status::Rejected then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            RecTypeEditable := false;
            PostingDateEditable := false;
        end;

        if rec.Status = rec.Status::Approved then begin
            MNoEditable := false;
            ClosingDateEditable := true;
            RecTypeEditable := false;
            PostingDateEditable := true;
        end;
    end;


    procedure FnSendWithdrawalApplicationSMS()
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := rec."No.";
        SMSMessage."Document No" := rec."No.";
        SMSMessage."Account No" := rec."Member No.";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBERSHIPWITH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Membership Withdrawal Application has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        cust.Reset;
        cust.SetRange(cust."No.", rec."Member No.");
        if cust.Find('-') then begin
            SMSMessage."Telephone No" := cust."Mobile Phone No";
        end;
        if cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FNPostShareCapTransfer()
    begin

        JVTransactionType := Jvtransactiontype::"Share Capital";
        JVAccountType := Jvaccounttype::Member;
        TemplateName := 'GENERAL';
        BatchName := 'CLOSURE';


        //Credit Buyer Account

        ObjShareCapSell.Reset;
        ObjShareCapSell.SetRange(ObjShareCapSell."Document No", rec."No.");
        if ObjShareCapSell.FindSet then begin
            repeat
                LineNo := LineNo + 10000;
                AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, rec."No.", LineNo, GenJournalLine."transaction type"::"Share Capital",
                GenJournalLine."account type"::Vendor, ObjShareCapSell."Buyer Share Capital Account", WorkDate,
                (ObjShareCapSell.Amount * -1), 'BOSA', rec."No.", 'Share Capital Purchase From ' + Format(ObjShareCapSell."Selling Member No"), '', GenJournalLine."application source"::" ");
            // VarBuyerMemberNos := VarBuyerMemberNos + ObjShareCapSell."Buyer Member No" + ', ';
            until ObjShareCapSell.Next = 0;
        end;

        LineNo := LineNo + 10000;
        //=========================================================================================================Debit Seller Account
        rec.CalcFields("Share Capital to Sell");
        AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, rec."No.", LineNo, GenJournalLine."transaction type"::"Share Capital",
        GenJournalLine."account type"::Vendor, rec."Seller Share Capital Account", WorkDate,
            (rec."Share Capital to Sell"), 'BOSA', rec."No.", 'Share Capital Sell to ' + ObjShareCapSell."Buyer Share Capital Account", '', GenJournalLine."application source"::" ");


        LineNo := LineNo + 10000;
        //Post Transfer Fee
        Generalsetup.Get();
        JVBalAccounttype := Jvbalaccounttype::"G/L Account";
        JVBalAccountNo := Generalsetup."Share Capital Transfer Fee Acc";
        JVTransactionType := Jvtransactiontype::"Deposit Contribution";

        AUFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, rec."No.", LineNo, JVTransactionType, JVAccountType, rec."Member No.", rec."Closing Date"
        , 'Transfer Fee_' + Format(rec."No."), JVBalAccounttype, JVBalAccountNo, (rec."Share Capital Transfer Fee"), 'BOSA', '');

        LineNo := LineNo + 10000;
        //Post Transfer Fee Excise Duty
        Generalsetup.Get();
        JVBalAccounttype := Jvbalaccounttype::"G/L Account";
        JVBalAccountNo := Generalsetup."Excise Duty Account";
        JVTransactionType := Jvtransactiontype::"Deposit Contribution";

        AUFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, rec."No.", LineNo, JVTransactionType, JVAccountType, rec."Member No.", rec."Closing Date"
        , 'Transfer Fee Excise_' + Format(rec."No."), JVBalAccounttype, JVBalAccountNo, (rec."Share Capital Transfer Fee" * (Generalsetup."Excise Duty(%)" / 100)), 'BOSA', '');

        //AUFactory.FnPostGnlJournalLine(TemplateName,BatchName);tr
    end;


    local procedure FnRecoverBOSAInterest(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        interestBuffer: Record "Interest Buffer Table";
        IterestFromBuffer: Decimal;
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            IterestFromBuffer := 0;
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", rec."Member No.");
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Interest");
                    if ObjLoans."Outstanding Interest" > 0 then begin
                        AmountToDeduct := ObjLoans."Outstanding Interest";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal

                        else
                            AmountToDeduct := AmountToDeduct;
                        LineNo := LineNo + 10000;
                        AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", rec."Posting Date", AmountToDeduct * -1, DActivity,
                        ObjLoans."Loan  No.", 'Loan Interest Recovered(With): ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."application source"::" ");
                        Bal := Bal - AmountToDeduct;
                    end;
                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnRecoverFOSAInterest(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", rec."FOSA Account No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::FOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Outstanding Interest");
                    if ObjLoans."Outstanding Interest" > 0 then begin
                        AmountToDeduct := ObjLoans."Outstanding Interest";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal
                        else
                            AmountToDeduct := AmountToDeduct;
                        //----------------------------------Debit FOSA-------------------------------------------
                        // LineNo := LineNo + 10000;
                        // AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                        // GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", AmountToDeduct, DActivity,
                        // ObjLoans."Loan  No.", 'Repay Interest(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        // //------------------------------------End--------------------------------------------------
                        // //----------------------------------Credit Loan--------------------------------------------
                        // LineNo := LineNo + 10000;
                        // AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        // GenJournalLine."account type"::Investor, ObjLoans."Client Code", "Posting Date", AmountToDeduct * -1, DActivity,
                        // ObjLoans."Loan  No.", 'Interest Recovered(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        // //------------------------------------End--------------------------------------------------
                        // Bal := Bal - AmountToDeduct;
                    end;

                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnRecoverBOSALoanPrinciple(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", rec."Member No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::BOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        AmountToDeduct := ObjLoans."Outstanding Balance";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal
                        else
                            AmountToDeduct := AmountToDeduct;
                        //----------------------------------------Credit Loans-----------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::Repayment,
                                                  GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", rec."Posting Date", AmountToDeduct * -1, DActivity,
                                                  ObjLoans."Loan  No.", 'Loan Clearance by Transferred(With): ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Application Source"::" ");
                        //------------------------------------------End--------------------------------------------------------------------------------------
                        Bal := Bal - AmountToDeduct;
                        //FnUpdateDatasheetMain(ObjLoans."Loan  No.");
                    end;
                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnRecoverFOSALoanPrinciple(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", rec."Member No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::FOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        AmountToDeduct := ObjLoans."Outstanding Balance";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal
                        else
                            AmountToDeduct := AmountToDeduct;
                        //-------------------------------------Debit FOSA---------------------------------------------------------------------------------
                        // LineNo := LineNo + 10000;
                        // AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                        //                           GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", AmountToDeduct, DActivity,
                        //                           ObjLoans."Loan  No.", 'Repay Loan(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        // //-----------------------------------------End---------------------------------------------------------------------------------------
                        // //---------------------------------------Credit Loan----------------------------------------------------------------------------------
                        // LineNo := LineNo + 10000;
                        // AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::Repayment,
                        //                           GenJournalLine."account type"::Investor, ObjLoans."Client Code", "Posting Date", AmountToDeduct * -1, DActivity,
                        //                           ObjLoans."Loan  No.", 'Offset by Transferred(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        // //----------------------------------------End----------------------------------------------------------------------------------------
                        // Bal := Bal - AmountToDeduct;
                    end;
                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnDebitMemberDepositsAndShareCapital(DepositContributions: Decimal; RefundableShareCapital: Decimal; Programmeddeposits: Decimal)
    var
        AmountToTransfer: Decimal;
        AccountNo: Code[20];
    begin
        LineNo := LineNo + 10000;
        AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                   GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Posting Date", (rec."Member Deposits" - Rec."Member Liability2"), DActivity, rec."No.", 'Account Rec(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");


        LineNo := LineNo + 10000;
        AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Programmed Deposits",
               GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Posting Date", rec."Dependand1", DActivity, rec."No.", 'Account Rec(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");


        LineNo := LineNo + 10000;
        AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Share Capital",
               GenJournalLine."Account Type"::Customer, rec."Member No.", rec."Posting Date", rec."Share Capital ded" * -1, DActivity, rec."No.", 'Account Rec(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");

    END;

    local procedure FnTransferToCurrentAccount(TotalTransferredAmount: Decimal)
    begin

        LineNo := LineNo + 10000;
        AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Disbursment Account",
                   GenJournalLine."account type"::Customer, rec."Member No.", rec."Posting Date", (TotalTransferredAmount) * -1, DActivity, rec."Cheque No.", 'Account Rec(With): ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");
    end;

    local procedure FnPostExciseDuty(Bal: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        // if ("Posting Date" < "Expected Posting Date") then
        //     AmountToDeduct := "Ten WIthdrawal";
        // LineNo := LineNo + 10000;
        // AUFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
        // GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", 'Early withdrawal Charge' + "Member No.",
        // GenJournalLine."bal. account type"::"G/L Account", WithFeeGL, AmountToDeduct, DActivity, '');

        // LineNo := LineNo + 10000;
        // AUFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
        // GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", 'Excise(20%): ' + "Member No.",
        // GenJournalLine."bal. account type"::"G/L Account", Generalsetup."Excise Duty Account", AmountToDeduct * 0.2, DActivity, '');
        //------------------------------------End--------------------------------------------------

        // exit(Bal);

    end;

    local procedure FnPostChequeCharge(Bal: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        if (Bal > 0) then begin
            if (rec."Mode Of Disbursement" = Rec."Mode Of Disbursement"::"M-Pesa") then
                TotalChequeCharge := Generalsetup."M-Pesa Charge(0-10K)";
            LineNo := LineNo + 10000;
            AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."bal. account type"::"G/L Account", Generalsetup."Mpesa A/c", rec."Posting Date", TotalChequeCharge * -1, DActivity, rec."No.", 'Mpesa Transfer Fee: ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");

        end;



        exit(Bal);
    end;

    local procedure FnPostSavingsCharge(Bal: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        FWithdrawal: Decimal;
    begin

        if (Bal > 0) then begin

            WithdrawableCharge := Rec."Withdrawal Fee";
            PayHSS := 0;

            LineNo := LineNo + 10000;
            AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."bal. account type"::"G/L Account", Generalsetup."Withdrawal Fee Account", rec."Posting Date", Rec."Withdrawal Fee" * -1, DActivity, rec."No.", 'Withdrawal Fee: ' + rec."Member No.", '', GenJournalLine."Application Source"::" ");

        end;



        exit(Bal);

    end;

    local procedure FnRecoverBOSAPenalty(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";

        AmountToDeduct: Decimal;
    begin

        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", rec."Member No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::BOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    RunBal := Bal;
                    //IF LoansR."Loan Product Type"<>'FOA|SHYLOCK' THEN BEGIN
                    ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance", ObjLoans."Outstanding Interest", ObjLoans."Penalty Charged", ObjLoans."Current Penalty Due");
                    IF ObjLoans."Current Penalty Due" > 0 THEN BEGIN
                        AmountToDeduct := 0;
                        AmountToDeduct := ObjLoans."Current Penalty Due" + ObjLoans."Penalty Paid";
                        // Message('%1-%2', RunBal, AmountToDeduct);
                        IF RunBal > AmountToDeduct THEN
                            OutBal := AmountToDeduct
                        ELSE
                            OutBal := RunBal;

                        LineNo := LineNo + 10000;
                        AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Penalty Paid",
                        GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", rec."Posting Date", OutBal * -1, DActivity,
                        ObjLoans."Loan  No.", 'Penalty Recovery:  ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Application Source"::" ");

                        //interest deduction balancing Line

                        // LineNo := LineNo + 10000;
                        // AUFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                        // GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", rec."Posting Date", OutBal, DActivity,
                        // ObjLoans."Loan  No.", 'Penalty Cleared by deposits: ' + rec."No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Application Source"::" ");

                        AmountBal := AmountBal - GenJournalLine.Amount;
                        DepositRef := DepositRef + GenJournalLine.Amount;
                        RunBal := RunBal - OutBal;
                        TotalDed := TotalDed + OutBal;
                        //END;
                    END;
                UNTIL ObjLoans.NEXT = 0;
            END;
        end;
        exit(Bal);

    end;
}

