//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50057 "Loan Recovery Header"
{
    PageType = Card;
    SourceTable = "Loan Recovery Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    // Editable = MemberNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposits';
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Total Outstanding Loans"; Rec."Total Outstanding Loans")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Total principal repayment"; Rec."Total principal repayment")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Style = Unfavorable;
                    StyleExpr = true;
                    Visible = false;
                }


                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Date';
                    Editable = true;
                }
                field("Loan to Attach"; Rec."Loan to Attach")
                {
                    ApplicationArea = Basic;
                    //Editable = LoantoAttachEditable;
                }
                field("Loan Liabilities"; Rec."Loan Liabilities")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Balance';
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Interest Repayment"; Rec."Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Repayment';
                    Editable = true;
                    Enabled = false;
                    HideValue = true;
                    Visible = false;

                }
                field("Principal Repayment"; Rec."Principal Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Principal Repayment';
                    Editable = true;
                    Enabled = false;
                    HideValue = true;
                    Visible = false;

                }

                field("Total Interest Due Recovered"; Rec."Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Style = StrongAccent;
                    StyleExpr = true;

                }
                field("Total Interest Due Recovered2"; Rec."Penalty Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Style = StrongAccent;
                    StyleExpr = true;

                }
                field("Total Thirdparty Loans"; Rec."Total Thirdparty Loans")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Mobile Loan"; Rec."Mobile Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Deposits Aportioned"; Rec."Deposits Aportioned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                    ToolTip = '(Outstanding Balance/Total Loans Outstanding Balance)*(Deposits-(Total Accrued Interest+Thirdparty Loans+Mobile Loan))';
                }
                field("Loan Distributed to Guarantors"; Rec."Loan Distributed to Guarantors")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("FOSA Account No"; Rec."FOSA Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Recovery Difference"; Rec."Recovery Difference")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recovery Difference';
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Recovery Type"; Rec."Recovery Type")
                {
                    ApplicationArea = Basic;
                    //Editable = RecoveryTypeEditable;
                }
                field("Guarantor Allocation Type"; Rec."Guarantor Allocation Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Liability Allocation Type';
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Activity Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    //Editable = Global1Editable;
                    //  OptionCaption = 'Activity';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Created';
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loans Generated"; Rec."Loans Generated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("<c>"; "Loan Recovery Details")
            {
                Editable = GuarantorLoansDetailsEdit;
                Enabled = true;
                SubPageLink = "Document No" = field("Document No"),
                              "Member No" = field("Member No");
                Visible = true;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Post Transaction")
                {
                    ApplicationArea = Basic;
                    Enabled = EnableCreateMember;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        LineNo: Integer;
                        TotalLoanRecovered: Decimal;
                        AuFactory: Codeunit "Au Factory";
                        BAL: Decimal;
                    begin

                        if ((Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Pending)) then
                            Error('You cannot post a document which is not approved');

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'RECOVERIES';
                        DOCUMENT_NO := Rec."Document No";
                        EXTERNAL_DOC_NO := Rec."Loan to Attach";
                        Datefilter := '..' + Format(Rec."Loan Disbursement Date");

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;

                        GenBatch.Reset;
                        GenBatch.SetRange(GenBatch."Journal Template Name", 'GENERAL');
                        GenBatch.SetRange(GenBatch.Name, 'RECOVERIES');
                        if GenBatch.Find('-') = false then begin
                            GenBatch.Init;
                            GenBatch."Journal Template Name" := 'GENERAL';
                            GenBatch.Name := 'RECOVERIES';
                            GenBatch.Description := DOCUMENT_NO;
                            GenBatch.Insert;
                        end;


                        if Rec."Recovery Type" = Rec."recovery type"::"Recover From Loanee Deposits" then begin
                            LineNo := 0;
                            RunBal := Rec."Current Shares";
                            if RunBal > 0 then
                                FnRunRecoverFromLoaneesDeposits(RunBal);
                        end;


                        if Rec."Recovery Type" = Rec."recovery type"::"Attach Defaulted Loans to Guarantors" then begin
                            LineNo := 0;

                            FnGenerateDefaulterLoans();
                        end;


                        if Rec."Recovery Type" = Rec."recovery type"::"Recover From Guarantors Deposits" then begin
                            FnRunRecoverFromGuarantorsDeposits(Rec."Document No", Rec."Loan to Attach", Rec."Member No", Today);
                        end;

                        BAL := 0;
                        GenJournalLine.RESET;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                        IF GenJournalLine.FINDSET THEN BEGIN
                            REPEAT
                                BAL := BAL + GenJournalLine.Amount;
                            UNTIL GenJournalLine.NEXT = 0;
                        END;

                        IF (BAL < 0) AND (BAL > -1) THEN BEGIN
                            GenJournalLine.RESET;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                            GenJournalLine.SETFILTER(Amount, '<%1', 0);
                            IF GenJournalLine.FINDFIRST THEN BEGIN
                                GenJournalLine.VALIDATE(Amount, GenJournalLine.Amount + ABS(BAL));
                                GenJournalLine.MODIFY(TRUE);
                            END;
                        END;

                        IF (BAL > 0) AND (BAL < 1) THEN BEGIN
                            GenJournalLine.RESET;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                            GenJournalLine.SETFILTER(Amount, '<%1', 0);
                            IF GenJournalLine.FINDFIRST THEN BEGIN
                                GenJournalLine.VALIDATE(Amount, GenJournalLine.Amount - BAL);
                                GenJournalLine.MODIFY(TRUE);
                            END;
                        END;
                        COMMIT;

                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'RECOVERIES');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;

                        ObjGuarantorRec.Reset;
                        ObjGuarantorRec.SetRange("Loan No", Rec."Loan No");
                        if ObjGuarantorRec.Find('-') then begin
                            Rec."Loans Generated" := Rec.Posted;
                            Rec.Posted := true;
                            Rec."Loans Generated" := Rec.Posted;
                            Rec."Posting Date" := Today;
                            Rec.Modify;
                        end;
                        //mark as defaulter
                        Cust.Reset();
                        Cust.SetRange("No.", Rec."Member No");
                        if Cust.Find('-') then begin
                            Cust."Loan Status" := Cust."Loan Status"::Defaulter;
                            Cust.Modify(true);
                        end;

                        CurrPage.Close;
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
                    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then
                            Error(text001);
                        //TestField("Global Dimension 1 Code");
                        //TestField("Global Dimension 2 Code");
                        if WKFLWIntegr.CheckGuarantorRecoveryApprovalsWorkflowEnabled(Rec) then
                            WKFLWIntegr.OnSendGuarantorRecoveryForApproval(Rec);
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
                    //ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Approved) then
                            Error(text001);

                        if WKFLWIntegr.CheckGuarantorRecoveryApprovalsWorkflowEnabled(Rec) then
                            WKFLWIntegr.OnCancelGuarantorRecoveryApprovalRequest(Rec);
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
                    //ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::GuarantorRecovery;

                        //ApprovalEntries.Setfilters(Database::"Loan Recovery Header", DocumentType, "Document No");
                        // ApprovalEntries.Run;
                    end;
                }
                action("Load Guarantors")
                {
                    ApplicationArea = Basic;
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        LoanDetails: Record "Loan Member Loans";
                        GCount: Integer;
                    begin

                        // IF ((Status=Status::Pending) OR (Posted=TRUE)) THEN
                        //      ERROR('You cannot Load Guarantors  a document which is not approved');

                        if (Rec."Recovery Type" = Rec."recovery type"::"Attach Defaulted Loans to Guarantors") or (Rec."Recovery Type" = Rec."recovery type"::"Recover From Guarantors Deposits") then begin
                            LoanDetails.Reset;
                            LoanDetails.SetRange(LoanDetails."Loan No.", Rec."Loan to Attach");
                            if LoanDetails.Find('-') then
                                LoanDetails.DeleteAll;

                            LoanGuarantors.Reset;
                            LoanGuarantors.SetRange(LoanGuarantors."Loan No", Rec."Loan to Attach");
                            LoanGuarantors.SetRange(Substituted, false);
                            if LoanGuarantors.FindSet then begin
                                repeat
                                    LoanDetails.Init;
                                    LoanDetails."Document No" := Rec."Document No";
                                    LoanDetails."Member No" := Rec."Member No";
                                    LoanDetails."Member Name" := LoanGuarantors.Name;
                                    LoanDetails."Guarantor Number" := LoanGuarantors."Member No";
                                    LoanDetails."Loan No." := LoanGuarantors."Loan No";
                                    LoanDetails."Amont Guaranteed" := LoanGuarantors."Amont Guaranteed";
                                    LoanDetails."Guarantors Current Shares" := LoanGuarantors."Deposits variance";
                                    LoanDetails."Guarantors Free Shares" := (LoanGuarantors."Deposits variance" - LoanGuarantors."Total Committed Shares");
                                    LoanDetails.Insert;
                                    if ObjCust.Get(LoanGuarantors."Member No") then begin
                                        ObjCust.CalcFields(ObjCust."Current Shares");
                                        LoanDetails."Amont Guaranteed" := ObjCust."Current Shares";
                                        LoanDetails.Modify;
                                    end;

                                until LoanGuarantors.Next = 0;
                            end;
                        end;
                        if (Rec."Recovery Type" = Rec."recovery type"::"Attach Defaulted Loans to Guarantors") then begin

                            LoanDetails.Reset;
                            LoanDetails.SetRange(LoanDetails."Loan No.", Rec."Loan to Attach");
                            if LoanDetails.Find('-') then
                                LoanDetails.DeleteAll;

                            LoanGuarantors.Reset;
                            LoanGuarantors.SetRange(LoanGuarantors."Loan No", Rec."Loan to Attach");
                            LoanGuarantors.SetRange(Substituted, false);
                            if LoanGuarantors.FindSet then begin
                                GCount := LoanGuarantors.Count;
                                repeat
                                    //LoanGuarantors.Totals
                                    LoanDetails.Init;
                                    LoanGuarantors.CalcFields(LoanGuarantors."Outstanding Balance", LoanGuarantors."Total Loans Guaranteed");
                                    LoanDetails."Document No" := Rec."Document No";
                                    LoanDetails."Member No" := Rec."Member No";
                                    LoanDetails."Member Name" := LoanGuarantors.Name;
                                    LoanDetails."Loan Type" := 'DEFAULT';
                                    if LoanType.Get(LoanDetails."Loan Type") then begin
                                        LoanDetails."Loan Instalments" := LoanType."No of Installment";
                                        LoanDetails."Interest Rate" := LoanType."Interest rate";
                                    end;
                                    LoanDetails."Approved Loan Amount" := LoanGuarantors."Amont Guaranteed";
                                    LoanDetails."Guarantor Number" := LoanGuarantors."Member No";
                                    LoanDetails."Loan No." := LoanGuarantors."Loan No";
                                    LoanDetails."Amont Guaranteed" := LoanGuarantors."Amont Guaranteed";
                                    LoanDetails."Outstanding Balance" := LoanGuarantors."Outstanding Balance";
                                    //LoanDetails."Outstanding Balance":=LoanGuarantors."Outstanding Balance";
                                    LoanDetails."Outstanding Interest" := FnGetInterestForLoanToAttach();
                                    if LoanDetails."Amont Guaranteed" > 0 then begin


                                        //LoanDetails."Defaulter Loan":= (ROUND(FnGetDefaultorLoanAmount("Loan Liabilities",LoanGuarantors."Amont Guaranteed",LoanGuarantors."Total Loans Guaranteed",GCount),0.05, '>'));// > LoanDetails."Amont Guaranteed" THEN
                                        // ;
                                        // LoanDetails."Defaulter Loan":=(LoanGuarantors."Outstanding Balance"-"Current Shares");"Loan Distributed to Guarantors"
                                        LoanDetails."Defaulter Loan" := (Rec."Loan Distributed to Guarantors" / GCount);

                                        LoanDetails."Defaulter Loan" := ROUND(LoanDetails."Defaulter Loan", 0.05, '>');
                                        //(ROUND(OutstandingBalance/(GuarantorCount),0.05,'>'));
                                        LoanDetails.Insert;
                                        LoanDetails."Defaulter Loan No" := ObjLoansRec."Loan  No.";
                                        LoanDetails.Modify;
                                        // end;
                                    end
                                until LoanGuarantors.Next = 0;
                            end;
                        end;
                    end;
                }
                action("Apportion Liability")
                {
                    ApplicationArea = Basic;
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //===============Load Guarantors Check=====================================
                        ObjLoanGuarantors.Reset;
                        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                        if ObjLoanGuarantors.Find('-') = false then begin
                            Error('Ensure you Load Loan Guarantors');
                        end;
                        //===============End Load Guarantors Check====================================

                        //==============Get Equal Liability Amount=====================================
                        ObjLoanGuarantors.Reset;
                        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                        if ObjLoanGuarantors.FindSet then begin
                            repeat
                                VarGuarantorCount := ObjLoanGuarantors.Count;
                                VarTotalGuarantorAmount := VarTotalGuarantorAmount + ObjLoanGuarantors."Amont Guaranteed";
                                //ObjLoanGuarantors."Equal Liability Amount":="Loan Liabilities"/VarGuarantorCount;
                                // ObjLoanGuarantors."Equal Liability Amount":=/VarGuarantorCount;
                                ObjLoanGuarantors."Guarantor Amount Apportioned" := Rec."Loan Distributed to Guarantors" / VarGuarantorCount;
                                // if ObjCust.Get(ObjLoanGuarantors."Guarantor Number") then begin
                                //     ObjCust.CalcFields(ObjCust."Current Shares");
                                //     ObjLoanGuarantors."Current Member Deposits" := ObjCust."Current Shares";
                                // end;
                                ObjLoanGuarantors.Modify;
                            until ObjLoanGuarantors.Next = 0;
                        end;
                        //=============End Get Equal Liability Amount==================================

                        // ObjLoanGuarantors.Reset;
                        // ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                        // if ObjLoanGuarantors.FindSet then begin
                        //     repeat
                        // if ObjLoanGuarantors."Current Member Deposits" <= ObjLoanGuarantors."Equal Liability Amount" then begin
                        //  ObjLoanGuarantors."Guarantor Amount Apportioned" := ObjLoanGuarantors."Current Member Deposits";
                        // VarTotalApprotionLess := VarTotalApprotionLess + ObjLoanGuarantors."Current Member Deposits";
                        // VarTotalApprotionLessCount := VarTotalApprotionLessCount + 1;
                        // ObjLoanGuarantors.Modify;
                        // end;
                        //     until ObjLoanGuarantors.Next = 0;
                        // end;


                        ObjLoanGuarantors.Reset;
                        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                        if ObjLoanGuarantors.FindSet then begin
                            repeat
                                VarTotalApprotionGreater := (Rec."Loan Distributed to Guarantors" - VarTotalApprotionLess) / (VarGuarantorCount - VarTotalApprotionLessCount);
                                if ObjLoanGuarantors."Current Member Deposits" > ObjLoanGuarantors."Equal Liability Amount" then begin
                                    if ObjLoanGuarantors."Current Member Deposits" <= VarTotalApprotionGreater then begin
                                        ObjLoanGuarantors."Guarantor Amount Apportioned" := ObjLoanGuarantors."Current Member Deposits"
                                    end else
                                        ObjLoanGuarantors."Guarantor Amount Apportioned" := VarTotalApprotionGreater;
                                    ObjLoanGuarantors.Modify;
                                end;
                            until ObjLoanGuarantors.Next = 0;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
        UpdateControls();
        EnableCreateMember := false;
        //OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        //CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Rec.Status::Approved) then
            EnableCreateMember := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created By" := UserId;
        Rec."Application Date" := Today;
    end;

    trigger OnOpenPage()
    begin
        //UpdateControls();
    end;

    var
        ObjGLEntry: Record "G/L Entry";
        Attached: Boolean;
        LoanBalanceAfterDeposit: Decimal;
        PayOffDetails: Record "Loans PayOff Details";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        LoansRec: Record "Loans Register";
        TotalRecovered: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        GLoanDetails: Record "Loan Member Loans";
        TotalOustanding: Decimal;
        ClosingDepositBalance: Decimal;
        RemainingAmount: Decimal;
        AMOUNTTOBERECOVERED: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        intRecoverNw: Decimal;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PDate: Date;
        Interest: Decimal;
        TextDateFormula2: Text[30];
        TextDateFormula1: Text[30];
        WKFLWIntegr: Codeunit WorkflowIntegration;
        DateFormula2: DateFormula;
        DateFormula1: DateFormula;
        Lbal: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        Hesabu: Integer;
        "Loan&int": Decimal;
        TotDed: Decimal;
        Available: Decimal;
        Distributed: Decimal;
        WINDOW: Dialog;
        PostingCode: Codeunit "Gen. Jnl.-Post Line";
        SHARES: Decimal;
        TOTALLOANS: Decimal;
        LineN: Integer;
        instlnclr: Decimal;
        appotbal: Decimal;
        PRODATA: Decimal;
        LOANAMOUNT2: Decimal;
        TOTALLOANSB: Decimal;
        NETSHARES: Decimal;
        Tinst: Decimal;
        Finst: Decimal;
        Floans: Decimal;
        GrAmount: Decimal;
        TGrAmount: Decimal;
        FGrAmount: Decimal;
        LOANBAL: Decimal;
        Serie: Integer;
        DLN: Code[10];
        "LN Doc": Code[20];
        INTBAL: Decimal;
        COMM: Decimal;
        loanTypes: Record "Loan Products Setup";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication;
        MemberNoEditable: Boolean;
        RecoveryTypeEditable: Boolean;
        Global1Editable: Boolean;
        Global2Editable: Boolean;
        LoantoAttachEditable: Boolean;
        GuarantorLoansDetailsEdit: Boolean;
        TotalRecoverable: Decimal;
        LoanGuarantors: Record "Loans Guarantee Details";
        AmounttoRecover: Decimal;
        BaltoRecover: Decimal;
        InstRecoveredAmount: Decimal;
        X: Decimal;
        ObjGuarantorML: Record "Loan Member Loans";
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RunBal: Decimal;
        TotalSharesUsed: Decimal;
        i: Integer;
        GenJnlBatch: Record "Gen. Journal Batch";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        LoanGuar: Record "Loans Guarantee Details";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
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
        LoansR: Record "Loans Register";
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
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
        GrossPay: Decimal;
        Nettakehome: Decimal;
        TotalDeductions: Decimal;
        UtilizableAmount: Decimal;
        NetUtilizable: Decimal;
        Deductions: Decimal;
        Benov: Decimal;
        TAXABLEPAY: Record "PAYE Brackets Credit";
        PAYE: Decimal;
        PAYESUM: Decimal;
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        Taxrelief: Decimal;
        OTrelief: Decimal;
        Chargeable: Decimal;
        PartPay: Record "Loan Partial Disburesments";
        PartPayTotal: Decimal;
        AmountPayable: Decimal;
        RepaySched: Record "Loan Repayment Schedule";
        LoanReferee1NameEditable: Boolean;
        LoanReferee2NameEditable: Boolean;
        LoanReferee1MobileEditable: Boolean;
        LoanReferee2MobileEditable: Boolean;
        LoanReferee1AddressEditable: Boolean;
        LoanReferee2AddressEditable: Boolean;
        LoanReferee1PhyAddressEditable: Boolean;
        LoanReferee2PhyAddressEditable: Boolean;
        LoanReferee1RelationEditable: Boolean;
        LoanReferee2RelationEditable: Boolean;
        LoanPurposeEditable: Boolean;
        WitnessEditable: Boolean;
        compinfo: Record "Company Information";
        LoanRepa: Record "Loan Repayment Schedule";
        ObjGuarantorRec: Record "Loan Recovery Header";
        Text0001: label 'Please consider recovering from the Loanee Shares Before Attaching to Guarantors';
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[40];
        SFactory: Codeunit "Au Factory";
        DLoan: Code[20];
        Datefilter: Text;
        LoanDetails: Record "Loan Member Loans";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        RecoveryTransType: Option Normal,"Guarantor Recoverd","Guarantor Paid";
        ObjLoansRec: Record "Loans Register";
        ObjNoSeries: Record "No. Series Line";
        ObjSaccoNoSeries: Record "Sacco No. Series";
        LastNoUsed: Code[20];
        ObjLoanType: Record "Loan Products Setup";
        VarAmounttoDeduct: Integer;
        ObjCust: Record Customer;
        ObjLoanGuarantors: Record "Loan Member Loans";
        VarTotalGuarantorAmount: Decimal;
        VarGuarantorCount: Integer;
        VarTotalApprotionLess: Decimal;
        VarTotalApprotionGreater: Decimal;
        VarTotalApprotionLessCount: Integer;
        intRecover: Decimal;
        intpenalty: Decimal;
        LONS: Decimal;
        InterestBAL: Decimal;
        penaltybal: Decimal;
        Loanba: Decimal;
        SmsManagement: Codeunit "Sms Management";


    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            RecoveryTypeEditable := true;
            LoantoAttachEditable := true;
            Global1Editable := true;
            Global2Editable := true;
            GuarantorLoansDetailsEdit := true;
        end;
        if Rec.Status = Rec.Status::Pending then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := true;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := true;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := true;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := true;
        end
    end;

    local procedure FnGetDefaultorLoanAmount(OutstandingBalance: Decimal; GuaranteedAmount: Decimal; TotalGuaranteedAmount: Decimal; GuarantorCount: Integer): Decimal
    begin
        if Rec."Guarantor Allocation Type" = Rec."guarantor allocation type"::"Equally Liable" then begin

            exit(ROUND(OutstandingBalance / (GuarantorCount), 0.05, '>'));
            // MESSAGE('guar %1',GuarantorCount);
        end else
            exit(ROUND(GuaranteedAmount / TotalGuaranteedAmount * (Rec."Loan Liabilities"), 0.05, '>'));
    end;


    procedure FnPostRepaymentJournal(TDefaulterLoan: Decimal)
    var
        ObjLoanDetails: Record "Loan Member Loans";
    begin
        if LoansRec.Get(Rec."Loan to Attach") then begin
            LineNo := LineNo + 10000;

            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
            GenJournalLine."Account Type"::Customer, LoansRec."Client Code", Rec."Loan Disbursement Date", TDefaulterLoan * -1, Format(LoanApps.Source), EXTERNAL_DOC_NO,
            'Defaulted Loan Recovered-' + Rec."Loan to Attach", LoanApp."Loan  No.", 0);//Maximum No of Parameters(13) Exceeded

        end;
    end;

    local procedure FnGetInterestForLoanToAttach(): Decimal
    var
        ObjLoansRegisterLocal: Record "Loans Register";
    begin
        ObjLoansRegisterLocal.Reset;
        ObjLoansRegisterLocal.SetRange(ObjLoansRegisterLocal."Loan  No.", Rec."Loan to Attach");
        if ObjLoansRegisterLocal.Find('-') then begin
            ObjLoansRegisterLocal.CalcFields(ObjLoansRegisterLocal."Outstanding Interest");
            exit(ObjLoansRegisterLocal."Outstanding Interest");
        end;
    end;

    local procedure FnRunInterest(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange("BOSA No", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        AmountToDeduct := 0;
                        AmountToDeduct := FnCalculateTotalInterestDue(LoanApp);
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Rec."Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                        Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.", 0);
                        RunningBalance := RunningBalance - AmountToDeduct;
                    end;
                until LoanApp.Next = 0;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Total Interest Due Recovered", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);
            end;
        end;
    end;

    local procedure FnRunPrinciple(RunningBalance: Decimal)
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
    begin


        begin
            if LoanApp."Outstanding Balance" > Rec."Current Shares" then begin
                Rec."Deposits Aportioned" := Rec."Current Shares";
            end;
            if LoansRec.Get(Rec."Loan to Attach") then begin
                //---------------------PAY-------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                GenJournalLine."Account Type"::Customer, LoansRec."Client Code", Rec."Loan Disbursement Date", Rec."Deposits Aportioned" * -1, Format(LoansRec.Source), EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::Repayment), LoanApp."Loan  No.", 0);
                //--------------------RECOVER-----------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Deposits Aportioned", Format(LoansRec.Source), EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoansRec."Loan Product Type", LoanApps."Loan  No.", 0);
            end;
        end;
    end;

    local procedure FnLoansGenerated()
    begin
    end;

    local procedure FnDefaulterLoansDisbursement(ObjLoanDetails: Record "Loan Member Loans"; LineNo: Integer): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, '16');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LBATCH', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            LoansRec.Insert;

            if LoansRec.Get(LoansRec."Loan  No.") then begin
                LoansRec."Client Code" := ObjLoanDetails."Guarantor Number";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := '16';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails."Interest Rate";
                LoansRec."Loan Status" := LoansRec."loan status"::Disbursed;
                LoansRec."Application Date" := Rec."Loan Disbursement Date";
                LoansRec."Issued Date" := Rec."Loan Disbursement Date";
                LoansRec."Loan Disbursement Date" := Rec."Loan Disbursement Date";
                LoansRec."Expected Date of Completion" := Rec."Expected Date of Completion";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::EFT;
                LoansRec."Repayment Start Date" := Rec."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := Format(LoanApps.Source);
                LoansRec."Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                LoansRec.Source := LoansRec.Source::BOSA;
                LoansRec."Approval Status" := LoansRec."approval status"::Approved;
                LoansRec.Repayment := ObjLoanDetails."Approved Loan Amount";
                LoansRec."Requested Amount" := 0;
                LoansRec."Approved Amount" := ObjLoanDetails."Approved Loan Amount";
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::EFT;
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;

    local procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    begin
        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", LoansRec."Loan  No.");
        LoansR.SetFilter(LoansR."Approved Amount", '>%1', 0);
        LoansR.SetFilter(LoansR.Posted, '=%1', true);
        if LoansR.Find('-') then begin
            if ((LoansR."Loan Product Type" = '16') and (LoansR."Issued Date" <> 0D) and (LoansR."Repayment Start Date" <> 0D)) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansR."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansR."Approved Amount";
                InterestRate := LoansR.Interest;
                RepayPeriod := LoansR.Installments;
                InitialInstal := LoansR.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansR."Approved Amount";
                RunDate := Rec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        //LoansRec.TESTFIELD(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        //LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;

    local procedure FnRecoverMobileLoanPrincipal(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        varLRepayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."BOSA No", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.Find('-') then begin
                //---------------------PAY-------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Rec."Loan Disbursement Date", Rec."Mobile Loan" * -1, 'FOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::Repayment), LoanApp."Loan  No.", 0);
                //--------------------RECOVER-----------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Mobile Loan", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);
            end;
        end;
    end;

    local procedure FnRunPrincipleThirdparty(RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            varLRepayment := LoanApp."Outstanding Balance";
                            if varLRepayment > 0 then begin
                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                Message('bal %1', AmountToDeduct);
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                                GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Rec."Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                Format(GenJournalLine."transaction type"::Repayment), LoanApp."Loan  No.", 0);
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;

                until LoanApp.Next = 0;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Total Thirdparty Loans", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnGenerateDefaulterLoans()
    var
        DLoanAmount: Decimal;
        LoansRegister: record "Loans Register";
        TotAmtG: decimal;
        Gur: record "Loans Guarantee Details";
        LoansG: record "Loans Guarantee Details";
        TotalToPostToLoan: decimal;
        AmountToPostAsGuarantorLoan: decimal;
        AmountAll: decimal;
        NewLoanNo: code[500];
        PostedOn: date;
        AuFactory: Codeunit "Au Factory";
        RemPeriod: Integer;
        TheDateToday: date;
        ObjLoansGuarantor: record "Loans Guarantee Details";
        CUNoSeriesManagement: codeunit NoSeriesManagement;
        LoanProductSetup: Record "Loan Products Setup";
        Interest2: decimal;
        LoanGurantorDetail: Record "Loan Member Loans";
    begin
        PostedOn := today;
        LoansRegister.RESET;
        LoansRegister.SETRANGE("Client Code", Rec."Member No");
        LoansRegister.SETFILTER("Outstanding Balance", '>0');
        LoansRegister.SetRange("Loan  No.", Rec."Loan to Attach");
        //LoansRegister.SETFILTER("Loan Product Type",'<>%1','D306');
        LoansRegister.SETAUTOCALCFIELDS("Outstanding Interest", "Outstanding Balance", "Current Penalty Due");
        IF LoansRegister.FINDSET THEN BEGIN
            REPEAT
                WITH LoansRegister DO BEGIN
                    InterestBAL := 0;
                    Loanba := 0;
                    penaltybal := 0;
                    InterestBAL := ROUND(LoansRegister."Outstanding Interest");
                    Loanba := Round(LoansRegister."Outstanding Balance");
                    penaltybal := round(LoansRegister."Current Penalty Due");
                    //Message('%1|%2|%3',Loanba,InterestBAL,(InterestBAL+Loanba));
                    IF "Outstanding Interest" < 0 THEN "Outstanding Interest" := 0;
                    IF "Outstanding Balance" > "Outstanding Interest" THEN BEGIN

                        "Outstanding Interest" := 0;
                        "Outstanding Balance" := "Outstanding Balance";//- ("Total Allocated To Loan"-"Outstanding Interest");
                    END ELSE begin
                        "Outstanding Interest" := "Outstanding Interest";
                    end;
                    //- "Total Allocated To Loan";
                    // MESSAGE('%1|%2, %3',"Outstanding Interest","Outstanding Balance","Total Allocated To Loan");


                    if LoanProductSetup.Get('DEFAULTER') then begin
                        RemPeriod := LoanProductSetup."No of Installment";
                        Interest2 := LoanProductSetup."Interest rate";//rkk
                    end;

                    Gur.RESET;
                    Gur.SETRANGE("Loan No", "Loan  No.");
                    Gur.SETRANGE(Substituted, FALSE);
                    Gur.SETRANGE("Self Guarantee", FALSE);
                    Gur.SETFILTER("Amont Guaranteed", '>0');
                    IF Gur.FINDFIRST THEN BEGIN
                        Gur.CALCSUMS("Amont Guaranteed");
                        TotAmtG := Gur."Amont Guaranteed";
                    END;

                    TotalToPostToLoan := 0;
                    // LoansG.RESET;
                    // LoansG.SETRANGE("Loan No", "Loan  No.");
                    // LoansG.SETRANGE(Substituted, FALSE);
                    // LoansG.SETRANGE("Self Guarantee", FALSE);
                    // LoansG.SETFILTER("Amont Guaranteed", '>0');
                    // IF LoansG.FINDSET THEN

                    LoanGurantorDetail.Reset();
                    LoanGurantorDetail.SetRange(LoanGurantorDetail."Document No", Rec."Document No");
                    if LoanGurantorDetail.Find('-') then begin
                        REPEAT
                            Cust.RESET;
                            Cust.SETRANGE(Cust."No.", LoanGurantorDetail."Guarantor Number");
                            Cust.SetFilter(Status, '%1|%2', Cust.Status::Active, Cust.Status::Dormant);
                            IF Cust.FIND('-') THEN
                                ObjLoanGuarantors.Reset;
                            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                            ObjLoansGuarantor.SetRange("Member No", LoansG."Member No");
                            if ObjLoanGuarantors.FindSet then begin
                                AmountToPostAsGuarantorLoan := ObjLoanGuarantors."Guarantor Amount Apportioned";
                                AmountAll += ObjLoanGuarantors."Guarantor Amount Apportioned";
                            end;


                            //add to other defaulted Loan 
                            LoansRegister.Reset();
                            //LoansRegister.SetRange("Default loan Attached", Rec."Loan to Attach");
                            LoansRegister.SetRange("Loan Product Type", 'DEFAULTER');
                            LoansRegister.SetRange("Client Code", LoanGurantorDetail."Guarantor Number");
                            if LoansRegister.Find('-') then begin
                                LoansRegister."Default loan Attached" := Rec."Loan to Attach";
                                LoansRegister."Approved Amount" := LoansRegister."Approved Amount" + LoanGurantorDetail."Guarantor Amount Apportioned";
                                LoansRegister.Modify(true);
                            end;

                            //end defaulted loan


                            //AmountToPostAsGuarantorLoan := ROUND((LoansG."Amont Guaranteed" / TotAmtG) * (("Outstanding Interest" + "Outstanding Balance")), 0.01, '=');
                            AmountAll += AmountToPostAsGuarantorLoan;

                            // MESSAGE('%1|%2', AmountToPostAsGuarantorLoan, AmountAll);
                            LoansRegister.Reset();
                            LoansRegister.SetRange("Default loan Attached", Rec."Loan to Attach");
                            LoansRegister.SetRange("Client Code", LoanGurantorDetail."Guarantor Number");
                            if not LoansRegister.Find('-') then begin


                                NewLoanNo := CUNoSeriesManagement.GetNextNo('DLN', 0D, TRUE);
                                LoansRec.INIT;
                                LoansRec."Loan  No." := NewLoanNo;//loan no
                                LoansRec."Client Code" := LoanGurantorDetail."Guarantor Number";
                                LoansRec."Loan Product Type" := 'DEFAULTER';
                                LoansRec."Loan Product Type Name" := 'Defaulted Loan';
                                LoansRec."Loan Status" := LoansRec."Loan Status"::Disbursed;
                                Cust.RESET;
                                Cust.SETRANGE(Cust."No.", LoanGurantorDetail."Guarantor Number");
                                IF Cust.FIND('-') THEN BEGIN
                                    LoansRec."Client Name" := Cust.Name;
                                    LoansRec."Employer Code" := Cust."Employer Code";
                                    LoansRec."Employer Name" := Cust."Employer Name";
                                    LoansRec."Staff No" := Cust."Payroll No";
                                END;
                                LoansRec."Application Date" := PostedOn;
                                LoansRec."Issued Date" := TODAY;
                                LoansRec."Loan Disbursement Date" := TODAY;
                                TheDateToday := CALCDATE('-CM', TODAY);
                                GenSetUp.GET;
                                IF (TODAY < CALCDATE(GenSetUp."Days for Checkoff", TheDateToday)) THEN BEGIN
                                    LoansRec."Repayment Start Date" := CALCDATE('CM', TODAY);
                                END ELSE BEGIN
                                    LoansRec."Repayment Start Date" := CALCDATE('CM', CALCDATE('CM+1M', TODAY));
                                END;
                                LoansRec."Expected Date of Completion" := CALCDATE('CM', CALCDATE('CM+' + FORMAT(RemPeriod) + 'M', TODAY));

                                LoansRec.Installments := RemPeriod;

                                LoansRec.Interest := Interest2;

                                LoansRec."Requested Amount" := LoanGurantorDetail."Guarantor Amount Apportioned";
                                LoansRec."Approved Amount" := LoanGurantorDetail."Guarantor Amount Apportioned";
                                // LoansRec."Requested Amount" := AmountToPostAsGuarantorLoan;
                                // LoansRec."Approved Amount" := AmountToPostAsGuarantorLoan;
                                LoansRec."Mode of Disbursement" := LoansRec."Mode of Disbursement"::" ";
                                LoansRec.Posted := TRUE;
                                LoansRec."Advice Date" := TODAY;
                                LoansRec.Source := LoansRec.Source::BOSA;
                                LoansRec."Branch Code" := 'NAIROBI';
                                LoansRec."Recovery Mode" := LoansRec."Recovery Mode"::Checkoff;
                                LoansRec."Repayment Method" := LoansRec."Repayment Method"::"Reducing Balance";
                                LoansRec."Repayment Frequency" := LoansRec."Repayment Frequency"::Monthly;
                                LoansRec."Approval Status" := LoansRec."Approval Status"::Approved;
                                LoansRec."Original Loanee" := Rec."Member No";
                                LoansRec."Disbursed By" := UserId;
                                LoansRec."Original Loan" := LoansG."Loan No";
                                LoansRec."Interest Due" := FnGetInterestForLoanToAttach();
                                LoansRec."Defaulter Loan" := TRUE;
                                LoansRec."Default loan Attached" := Rec."Loan to Attach";
                                LoansRec.INSERT;

                                //============================================================Insert Guarantor
                                Cust.RESET;
                                Cust.SETRANGE(Cust."No.", LoansRec."Client Code");
                                IF Cust.FIND('-') THEN BEGIN
                                    ObjLoansGuarantor.INIT;
                                    ObjLoansGuarantor."Loan No" := LoansRec."Loan  No.";

                                    ObjLoansGuarantor."Member No" := Cust."No.";
                                    ObjLoansGuarantor.Name := Cust.Name;
                                    ObjLoansGuarantor."Amont Guaranteed" := LoansRec."Approved Amount";
                                    ObjLoansGuarantor."Employer Code" := Cust."Employer Code";
                                    ObjLoansGuarantor."Employer Name" := Cust."Employer Name";
                                    ObjLoansGuarantor."Loanees  No" := Cust."No.";
                                    ObjLoansGuarantor."Loanees  Name" := Cust.Name;
                                    ObjLoansGuarantor."Self Guarantee" := TRUE;
                                    ObjLoansGuarantor."Staff/Payroll No." := Cust."Payroll No";
                                    ObjLoansGuarantor.INSERT;
                                END;
                            end;
                            //============================================================End Insert Guarantor
                            AuFactory.FnGenerateLoanRepaymentSchedule(LoansRec."Loan  No.");
                            //FnGenerateRepaymentSchedule(LoansRec."Loan  No.");
                            ObjLoansRec.Reset();
                            ObjLoansRec.SetRange("Default loan Attached", Rec."Loan to Attach");
                            ObjLoansRec.SetRange("Client Code", LoanGurantorDetail."Guarantor Number");
                            if ObjLoansRec.Find('-') then begin

                                //  Message(Format(ObjLoansRec."Loan  No."));
                                LoansRec.Reset();
                                LoansRec.SetRange(LoansRec."Loan  No.", ObjLoansRec."Loan  No.");
                                //LoansRec.SetRange("Client Code", LoanGurantorDetail."Guarantor Number");
                                IF LoansRec.Find('-') then
                                    Message(Format(LoansRec."Loan  No."));
                                //LoansRec.VALIDATE(ObjLoansRec."Approved Amount");
                                LineN := LineN + 10000;
                                GenJournalLine.INIT;
                                GenJournalLine."Line No." := LineN;
                                GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
                                GenJournalLine."Journal Batch Name" := BATCH_NAME;
                                GenJournalLine."Document No." := DOCUMENT_NO;
                                GenJournalLine."External Document No." := Rec."Loan to Attach";
                                GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Loan;
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                                GenJournalLine."Account No." := LoanGurantorDetail."Guarantor Number";
                                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := PostedOn;
                                GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                GenJournalLine.Description := 'Defaulted Loan' + ' ' + Rec."Member Name" + ' ' + LoansG."Loan No";
                                GenJournalLine.Amount := LoanGurantorDetail."Guarantor Amount Apportioned";
                                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                GenJournalLine."Loan No" := LoansRec."Loan  No.";
                                IF GenJournalLine.Amount <> 0 THEN
                                    GenJournalLine.INSERT;
                                TotalToPostToLoan += GenJournalLine.Amount;

                            end;


                        /// Message('amount apportioned %1', LoanGurantorDetail."Guarantor Amount Apportioned");
                        UNTIL LoanGurantorDetail.NEXT = 0;
                    end;

                    ObjLoansRec.Reset();
                    ObjLoansRec.SetRange(ObjLoansRec."Loan  No.", Rec."Loan to Attach");
                    //ObjLoansRec.SetRange("Client Code", LoanGurantorDetail."Guarantor Number");
                    if ObjLoansRec.Find('-') then begin
                        LineN := LineN + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Line No." := LineN;
                        GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
                        GenJournalLine."Journal Batch Name" := BATCH_NAME;
                        GenJournalLine."Document No." := DOCUMENT_NO;
                        GenJournalLine."External Document No." := ObjLoansRec."Loan  No.";
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Repayment;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                        GenJournalLine."Account No." := ObjLoansRec."Client Code";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := PostedOn;
                        GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                        GenJournalLine.Description := 'Defaulted Loan Attached';
                        GenJournalLine.Amount := -ROUND(Loanba);
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Loan No" := ObjLoansRec."Loan  No.";
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;




                        //interest
                        LineN := LineN + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Line No." := LineN;
                        GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
                        GenJournalLine."Journal Batch Name" := BATCH_NAME;
                        GenJournalLine."Document No." := DOCUMENT_NO;
                        GenJournalLine."External Document No." := ObjLoansRec."Loan  No.";
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                        GenJournalLine."Account No." := ObjLoansRec."Client Code";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := PostedOn;
                        GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                        GenJournalLine.Description := 'Defaulted Loan Attached';
                        GenJournalLine.Amount := -ROUND(InterestBAL);
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Loan No" := ObjLoansRec."Loan  No.";
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;


                        //penalty
                        LineN := LineN + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Line No." := LineN;
                        GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
                        GenJournalLine."Journal Batch Name" := BATCH_NAME;
                        GenJournalLine."Document No." := DOCUMENT_NO;
                        GenJournalLine."External Document No." := ObjLoansRec."Loan  No.";
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Penalty Paid";
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                        GenJournalLine."Account No." := ObjLoansRec."Client Code";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := PostedOn;
                        GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                        GenJournalLine.Description := 'Defaulted Loan Attached';
                        GenJournalLine.Amount := -ROUND(penaltybal);

                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Loan No" := ObjLoansRec."Loan  No.";
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;

                    end;
                    CustomerRecord.Reset();
                    CustomerRecord.Setrange("No.", ObjLoanGuarantors."Member No");
                    if CustomerRecord.find('-') then begin
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
                        SMSMessage."Document No" := Rec."Loan to Attach";
                        SMSMessage."Account No" := Rec."Member No";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'Recovery';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Dear member, you have been attached Kes ' + Format(ObjLoanGuarantors."Guarantor Amount Apportioned") + ' for' + Format(LoanApp."Loan Product Type Name") + ' Recovery mode checkoff that is in default from' + ObjLoanGuarantors."Member Name" + ' effective' + Format(LoansRec."Posting Date");

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Member No");
                        if Cust.Find('-') then begin
                            SMSMessage."Telephone No" := Cust."Mobile Phone No";
                        end;
                        if Cust."Mobile Phone No" <> '' then
                            SMSMessage.Insert;
                    end;
                end;
            until LoansRegister.next = 0;

            if CustomerRecord.Get(Rec."Member No") then begin
                SmsManagement.SendSmsResponse(CustomerRecord."Mobile Phone No", 'Dear member, you have been attached Kes ' + Format(ObjLoanGuarantors."Guarantor Amount Apportioned") + ' for' + Format(LoanApp."Loan Product Type Name") + ' Recovery mode checkoff that is in default by' + Format(ObjLoanGuarantors."Member No") + '' + Format(LoansRec."Posting Date"))
            end;
        end;

    end;



    local procedure FnCalculateTotalInterestDue(Loans: Record "Loans Register") InterestDue: Decimal
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
    begin
        ObjRepaymentSchedule.Reset;
        ObjRepaymentSchedule.SetRange("Loan No.", Loans."Loan  No.");
        ObjRepaymentSchedule.SetFilter("Repayment Date", '<=%1', Rec."Loan Disbursement Date");
        if ObjRepaymentSchedule.Find('-') then
            "Loan Age" := ObjRepaymentSchedule.Count;
        Loans.CalcFields("Outstanding Balance", "Interest Paid");

        InterestDue := (Loans."Outstanding Balance") * (Loans.Interest / 1200);
        InterestDue := InterestDue * 3;
        if InterestDue <= 0 then
            exit(0);

        exit(InterestDue);
    end;

    // local procedure FnRunRecoverFromLoaneesDeposits(RunningBalance: Decimal)
    // var
    //     AmountToDeduct: Decimal;
    // begin
    //     if RunningBalance > 0 then begin
    //         LoanApp.Reset;
    //         LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
    //         LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Attach");
    //         LoanApp.SetRange("BOSA No", Rec."Member No");
    //         LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
    //         if LoanApp.Find('-') then begin
    //             repeat
    //                 LoanApp.CalcFields(LoanApp."Outstanding Interest", LoanApp."Outstanding Balance", LoanApp."Interest Charged", LoanApp."Current Penalty Due");
    //                 if RunningBalance > 0 then begin
    //                     LoanBalanceAfterDeposit := 0;
    //                     AmountToDeduct := 0;
    //                     intRecover := 0;
    //                     intpenalty := 0;
    //                     InterestBAL := 0;

    //                     if LoanApp."Outstanding Interest" > 0 then begin
    //                         if LoanApp."Outstanding Interest" < RunningBalance then begin
    //                             intRecover := LoanApp."Outstanding Interest";

    //                         end
    //                         else begin
    //                             intRecover := RunningBalance;

    //                         end;
    //                         RunningBalance := RunningBalance - intRecover;

    //                         if LoanApp."Outstanding Balance" > 0 then begin
    //                             if LoanApp."Outstanding Balance" < RunningBalance then begin
    //                                 AmountToDeduct := LoanApp."Outstanding Balance"
    //                             end
    //                             else begin
    //                                 AmountToDeduct := RunningBalance;
    //                             End;
    //                             RunningBalance := RunningBalance - AmountToDeduct;



    //                             intpenalty := LoanApp."Current Penalty Due";
    //                             if intpenalty > RunningBalance then begin
    //                                 intpenalty := RunningBalance
    //                             end else begin
    //                                 intpenalty := intpenalty;
    //                             end;
    //                         end;
    //                         //interest
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
    //                         GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Rec."Loan Disbursement Date", intRecover * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
    //                         'Interest  Recovered From Deposits', LoanApp."Loan  No.", 0);

    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
    //                         GenJournalLine."account type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", intRecover, 'BOSA', EXTERNAL_DOC_NO,
    //                         'Interest Recovered From Deposits' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);



    //                         //"Principal Repayment"
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
    //                         GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Rec."Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
    //                         'Repayment Recovered From Deposits', LoanApp."Loan  No.", 0);

    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
    //                         GenJournalLine."Account Type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", AmountToDeduct * 1, 'BOSA', EXTERNAL_DOC_NO,
    //                         'Repayment Recovered From Deposits' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);


    //                         //penalty
    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Penalty Paid",
    //                         GenJournalLine."Account Type"::Customer, LoanApp."Client Code", Rec."Loan Disbursement Date", intpenalty * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
    //                         'Penalty  Recovered From Deposits', LoanApp."Loan  No.", 0);

    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
    //                         GenJournalLine."account type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", intpenalty, 'BOSA', EXTERNAL_DOC_NO,
    //                         'Penalty Recovered From Deposits' + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", 0);

    //                         CustomerRecord.Reset();
    //                         CustomerRecord.Setrange("No.", LoanGuar."Member No");
    //                         if CustomerRecord.find('-') then begin
    //                             SMSMessage.Reset;
    //                             if SMSMessage.Find('+') then begin
    //                                 iEntryNo := SMSMessage."Entry No";
    //                                 iEntryNo := iEntryNo + 1;
    //                             end
    //                             else begin
    //                                 iEntryNo := 1;
    //                             end;


    //                             SMSMessage.Init;
    //                             SMSMessage."Entry No" := iEntryNo;
    //                             SMSMessage."Document No" := Rec."Loan to Attach";
    //                             SMSMessage."Account No" := Rec."Member No";
    //                             SMSMessage."Date Entered" := Today;
    //                             SMSMessage."Time Entered" := Time;
    //                             SMSMessage.Source := 'Recovery';
    //                             SMSMessage."Entered By" := UserId;
    //                             SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
    //                             SMSMessage."SMS Message" := 'Dear Member,your Loan of product type ' + ' ' + LoanApp."Loan Product Type" + ' of KES. ' + Format(LoanApp."Outstanding Balance") + 'Has been recevered from your deposits.' + ',' + ' ' + 'Call,' + ' ' + compinfo."Phone No." + ',if in dispute .' + ' ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
    //                             Cust.Reset;
    //                             Cust.SetRange(Cust."No.", Rec."Member No");
    //                             if Cust.Find('-') then begin
    //                                 SMSMessage."Telephone No" := Cust."Mobile Phone No";
    //                             end;
    //                             if Cust."Mobile Phone No" <> '' then
    //                                 SMSMessage.Insert;
    //                         end
    //                     end;
    //                 end;

    //             until LoanApp.Next = 0;


    //         end;
    //     end;
    //     Message('Transaction Posted Successfully');
    // end;

    local procedure FnRunRecoverFromLoaneesDeposits(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        intRecover: Decimal;
        intPenalty: Decimal;
    begin
        if RunningBalance <= 0 then
            exit;

        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
        LoanApp.SetRange("Loan  No.", Rec."Loan to Attach");
        LoanApp.SetRange("BOSA No", Rec."Member No");
        LoanApp.SetFilter("Date filter", Datefilter);

        if not LoanApp.Find('-') then
            exit;

        repeat
            LoanApp.CalcFields("Outstanding Interest", "Outstanding Balance", "Current Penalty Due");

            intRecover := 0;
            AmountToDeduct := 0;
            intPenalty := 0;

            // RECOVER INTEREST 

            if RunningBalance > 0 then begin
                if LoanApp."Outstanding Interest" > 0 then begin
                    if LoanApp."Outstanding Interest" < RunningBalance then
                        intRecover := LoanApp."Outstanding Interest"
                    else
                        intRecover := RunningBalance;

                    RunningBalance := RunningBalance - intRecover;

                    // Journal – Interest Paid
                    LineNo += 10000;
                    SFactory.FnCreateGnlJournalLine(
                        BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                        GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."Account Type"::Customer,
                        LoanApp."Client Code",
                        Rec."Loan Disbursement Date",
                        intRecover * -1,
                        Format(LoanApp.Source),
                        EXTERNAL_DOC_NO,
                        'Interest Recovered From Deposits',
                        LoanApp."Loan  No.",
                        0
                    );

                    // Journal – Deposit Contribution (Interest)
                    LineNo += 10000;
                    SFactory.FnCreateGnlJournalLine(
                        BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                        GenJournalLine."transaction type"::"Deposit Contribution",
                        GenJournalLine."Account Type"::Customer,
                        Rec."Member No",
                        Rec."Loan Disbursement Date",
                        intRecover,
                        'BOSA',
                        EXTERNAL_DOC_NO,
                        'Interest Recovered From Deposits - ' + LoanApp."Loan Product Type",
                        LoanApp."Loan  No.",
                        0
                    );
                end;
            end;
            ////principal
            if RunningBalance > 0 then begin
                if LoanApp."Outstanding Balance" > 0 then begin
                    if LoanApp."Outstanding Balance" < RunningBalance then
                        AmountToDeduct := LoanApp."Outstanding Balance"
                    else
                        AmountToDeduct := RunningBalance;

                    RunningBalance := RunningBalance - AmountToDeduct;

                    // Journal – Principal Repayment
                    LineNo += 10000;
                    SFactory.FnCreateGnlJournalLine(
                        BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                        GenJournalLine."transaction type"::Repayment,
                        GenJournalLine."Account Type"::Customer,
                        LoanApp."Client Code",
                        Rec."Loan Disbursement Date",
                        AmountToDeduct * -1,
                        Format(LoanApp.Source),
                        EXTERNAL_DOC_NO,
                        'Principal Recovered From Deposits',
                        LoanApp."Loan  No.",
                        0
                    );

                    // Journal – Deposit Contribution (Principal)
                    LineNo += 10000;
                    SFactory.FnCreateGnlJournalLine(
                        BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                        GenJournalLine."transaction type"::"Deposit Contribution",
                        GenJournalLine."Account Type"::Customer,
                        Rec."Member No",
                        Rec."Loan Disbursement Date",
                        AmountToDeduct,
                        'BOSA',
                        EXTERNAL_DOC_NO,
                        'Principal Recovered From Deposits - ' + LoanApp."Loan Product Type",
                        LoanApp."Loan  No.",
                        0
                    );
                end;
            end;



            if RunningBalance > 0 then begin
                if LoanApp."Current Penalty Due" > 0 then begin
                    if LoanApp."Current Penalty Due" < RunningBalance then
                        intPenalty := LoanApp."Current Penalty Due"
                    else
                        intPenalty := RunningBalance;

                    RunningBalance := RunningBalance - intPenalty;

                    // Journal – Penalty Paid
                    LineNo += 10000;
                    SFactory.FnCreateGnlJournalLine(
                        BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                        GenJournalLine."transaction type"::"Penalty Paid",
                        GenJournalLine."Account Type"::Customer,
                        LoanApp."Client Code",
                        Rec."Loan Disbursement Date",
                        intPenalty * -1,
                        Format(LoanApp.Source),
                        EXTERNAL_DOC_NO,
                        'Penalty Recovered From Deposits',
                        LoanApp."Loan  No.",
                        0
                    );


                    LineNo += 10000;
                    SFactory.FnCreateGnlJournalLine(
                        BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                        GenJournalLine."transaction type"::"Deposit Contribution",
                        GenJournalLine."Account Type"::Customer,
                        Rec."Member No",
                        Rec."Loan Disbursement Date",
                        intPenalty,
                        'BOSA',
                        EXTERNAL_DOC_NO,
                        'Penalty Recovered From Deposits - ' + LoanApp."Loan Product Type",
                        LoanApp."Loan  No.",
                        0
                    );
                end;
            end;


            if (intRecover > 0) or (AmountToDeduct > 0) or (intPenalty > 0) then begin
                LoanApp."Outstanding Interest" -= intRecover;
                LoanApp."Outstanding Balance" -= AmountToDeduct;
                LoanApp."Current Penalty Due" -= intPenalty;
                LoanApp.Modify();

                // === Send SMS ===
                // SendRecoverySMS(LoanApp, Rec."Member No");
                SendRecoverySMS(
                LoanApp,
               LoanApp."Client Code",
                  LoanApp."Mobile Phone No",
         'Dear Member, your loan' + Format(LoanApp."Loan Product Type Name") + ' has been recovered. Thank you.'
         );
            end;

        until LoanApp.Next = 0;

        Message('Transaction Posted Successfully');
    end;

    local procedure FnRunRecoverFromGuarantorsDeposits(VarDocumentNo: Code[20]; VarLoanNo: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date)
    begin
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange("Document No", VarDocumentNo);
        if ObjLoanGuarantors.FindSet then begin
            repeat
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, ObjLoanGuarantors."Guarantor Number", VarPostingDate, ObjLoanGuarantors."Guarantor Amount Apportioned", 'BOSA', EXTERNAL_DOC_NO,
                'Defaulted Loan Recovered' + '-' + VarMemberNo + '-' + VarLoanNo, LoanApp."Loan  No.", 0);

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                GenJournalLine."Account Type"::Customer, VarMemberNo, VarPostingDate, ObjLoanGuarantors."Guarantor Amount Apportioned" * -1, 'BOSA', EXTERNAL_DOC_NO,
                'Repayment Recovered From Guarantor Deposits_' + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

                CustomerRecord.Reset();
                CustomerRecord.Setrange("No.", ObjLoanGuarantors."Member No");
                if CustomerRecord.find('-') then begin
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

                    SMSMessage."Document No" := Rec."Loan to Attach";
                    SMSMessage."Account No" := Rec."Member No";
                    SMSMessage."Date Entered" := Today;
                    SMSMessage."Time Entered" := Time;
                    SMSMessage.Source := 'Recovery';
                    SMSMessage."Entered By" := UserId;
                    SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                    SMSMessage."SMS Message" := 'Dear Member,Loan of product type ' + ' ' + LoanApp."Loan Product Type" + ' Amount of KES. ' + Format(ObjLoanGuarantors."Guarantor Amount Apportioned") + 'You had guaranteed ' + ObjLoanGuarantors."Member No"
                     + ' as been recovered from your deposits.' + ',' + ' ' + 'Call,' + ' ' + compinfo."Phone No." + ',if in dispute .' + ' ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", Rec."Member No");
                    if Cust.Find('-') then begin
                        SMSMessage."Telephone No" := Cust."Mobile Phone No";
                    end;
                    if Cust."Mobile Phone No" <> '' then
                        SMSMessage.Insert;
                end
            until ObjLoanGuarantors.Next = 0;
        end;
    end;

    local procedure FnRunPostMemberDepositstoLSA(VarDocumentNo: Code[30]; VarPostingDate: Date; VarLoanNo: Code[30])
    var
        GuarantorName: Text[100];
        VarAmounttoRecover: Decimal;
    begin
        if ObjCust.Get(Rec."Member No") then begin
            ObjCust.CalcFields(ObjCust."Current Shares");
            if ObjCust."Current Shares" < LoanApp."Outstanding Balance" then
                Error('The Deposits Recovered Amount specified is more than the Available Member Deposits');

            //--------------------------------(Credit LSA Account)-------------------------------------------------------------------------------
            /* LineNo:=LineNo+10000;
             SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
             GenJournalLine."Account Type"::Vendor,"Settlement Account",VarPostingDate, LoanApp."Outstanding Balance"*-1,'BOSA',EXTERNAL_DOC_NO,
             'Loan Recovered: '+"Member Name"+' - '+VarLoanNo,VarLoanNo,GenJournalLine."Recovery Transaction Type"::"Guarantor Recoverd",VarLoanNo);*/

            //--------------------------------(Debit Guarantor Account)-------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Vendor, ObjCust."Deposits Account No", VarPostingDate, LoanApp."Outstanding Balance", 'BOSA', EXTERNAL_DOC_NO,
            'Loan Recovered: ' + Rec."Member Name" + ' - ' + VarLoanNo, VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

        end;

    end;

    local procedure FnAttachToGuarantorLoans()
    var
        DLoanAmount: Decimal;
    begin
        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Loan No", LoanApp."Loan  No.");
        if LoanGuar.Find('-') then begin
            LoanGuar.Reset;
            LoanGuar.SetRange(LoanGuar."Loan No", LoanApp."Loan  No.");
            repeat
                TGrAmount := TGrAmount + GrAmount;
                GrAmount := LoanGuar."Amont Guaranteed";
                FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
            until LoanGuar.Next = 0;
        end;

        //Defaulter loan clear
        LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Interest Due");
        Lbal := ROUND(LoanApp."Outstanding Balance", 1, '=');
        if LoanApp."Interest Due" > 0 then begin
            INTBAL := ROUND(LoanApp."Interest Due", 1, '=');
            COMM := ROUND((LoanApp."Interest Due" * 0.5), 1, '=');
            LoanApp."Attached Amount" := Lbal;
            LoanApp.PenaltyAttached := COMM;
            LoanApp.InDueAttached := INTBAL;
            Rec.Modify;
        end;

        Attached := true;
        //MESSAGE('BALANCE %1',Lbal);
        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'general';
        GenJournalLine."Journal Batch Name" := 'LNAttach';
        GenJournalLine."Document No." := LoanApp."Loan  No.";
        GenJournalLine."External Document No." := LoanApp."Loan  No.";
        GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := Rec."FOSA Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine.Description := 'Def Loan' + Rec."FOSA Account No";
        GenJournalLine.Amount := -Lbal;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Loan No" := LoanApp."Loan  No.";
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        "LN Doc" := LoanApp."Loan  No.";
        // int due
        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'General';
        GenJournalLine."Journal Batch Name" := 'LNAttach';
        GenJournalLine."Document No." := LoanApp."Loan  No.";
        GenJournalLine."External Document No." := LoanApp."Loan  No.";
        GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
        // GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := Rec."FOSA Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Description := 'Defaulted Loan int' + ' ';
        GenJournalLine.Amount := -INTBAL;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Loan No" := LoanApp."Loan  No.";
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        //commisision

        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'general';
        GenJournalLine."Journal Batch Name" := 'LNAttach';
        GenJournalLine."Document No." := LoanApp."Loan  No.";
        GenJournalLine."External Document No." := LoanApp."Loan  No.";
        GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
        GenJournalLine."Account No." := '100002';
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine.Description := 'Penalty' + ' ';
        GenJournalLine.Amount := -COMM;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Loan No" := LoanApp."Loan  No.";
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;




        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Loan No", LoanApp."Loan  No.");
        if LoanGuar.Find('-') then begin
            LoanGuar.Reset;
            LoanGuar.SetRange(LoanGuar."Loan No", LoanApp."Loan  No.");
            DLN := 'DLN';
            repeat
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Client Code", LoanGuar."Member No");
                LoanApp.SetRange(LoanApp."Loan Product Type", '16');
                if LoanApp.Find('-') then begin
                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    if LoanApp."Outstanding Balance" = 0 then
                        LoanApp.DeleteAll;
                end;

                GenSetUp.Get();
                GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                GenSetUp.Modify;
                DLN := 'DLN' + Format(GenSetUp."Defaulter LN");
                TGrAmount := TGrAmount + GrAmount;
                GrAmount := LoanGuar."Amont Guaranteed";
                //MESSAGE('guarnteed Amount %1',FGrAmount);

                ////Insert Journal Lines
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'general';
                GenJournalLine."Journal Batch Name" := 'LNAttach';
                GenJournalLine."Document No." := "LN Doc";
                GenJournalLine."External Document No." := "LN Doc";
                GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                GenJournalLine."Account No." := LoanGuar."Member No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                GenJournalLine.Description := 'Defaulted Loan' + ' ';
                GenJournalLine.Amount := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Loan No" := DLN;
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                if loanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanApp.Init;
                    LoanApp."Loan  No." := DLN;
                    LoanApp."Client Code" := LoanGuar."Member No";
                    LoanApp."Loan Product Type" := '16';
                    LoanApp."Loan Status" := LoanApp."loan status"::Disbursed;
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", LoanGuar."Member No");
                    if Cust.Find('-') then begin
                        LoanApp."Client Name" := Cust.Name;
                    end;
                    LoanApp."Application Date" := Today;
                    LoanApp."Issued Date" := Today;
                    LoanApp.Installments := loanTypes."No of Installment";
                    LoanApp.Repayment := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM)) / loanTypes."No of Installment";
                    LoanApp."Requested Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                    LoanApp."Approved Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                    LoanApp.Posted := true;
                    LoanApp."Advice Date" := Today;
                    LoanApp.Insert;
                    //MESSAGE('guarnteed Amount %1',"Loans Register"."Requested Amount");
                end;
            until LoanGuar.Next = 0;
        end;
        LoanApp.Posted := true;
        LoanApp."Attachement Date" := Today;
        Rec.Modify;
    end;

    local procedure SendRecoverySMS(LoanApp: Record "Loans Register"; MemberNo: Code[20]; phone: Text[20]; message: Text[250])
    var
        SMSMessage: Record "SMS Messages";
        Cust: Record Customer;
        //GenSetUp: Record "General Setup";
        CompInfo: Record "Company Information";
        NextEntry: Integer;
        SmsMessages: Codeunit "Sms Management";
    begin
        CompInfo.Get();
        GenSetUp.Get();

        Cust.Reset();
        Cust.SetRange("No.", MemberNo);
        if not Cust.FindFirst() then
            exit;

        SMSMessage.Reset();
        if SMSMessage.FindLast() then
            NextEntry := SMSMessage."Entry No" + 1
        else
            NextEntry := 1;

        SMSMessage.Init();
        SMSMessage."Entry No" := NextEntry;
        SMSMessage."Document No" := LoanApp."Loan  No.";
        SMSMessage."Account No" := MemberNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'Recovery';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."Sent to server"::No;
        SMSMessage."SMS Message" := message;
        SMSMessage."Telephone No" := phone;
        SMSMessage."SMS Message" :=
            'Dear Member, your loan (' + LoanApp."Loan Product Type" +
            ') of KES ' + Format(RunBal) +
            ' has been recovered from your deposits. Call ' +
             CompInfo."Phone No." + ' for assistance. - ' +
            CompInfo.Name;
        SMSMessage."SMS Message" := message;

        SMSMessage."Telephone No" := Cust."Mobile Phone No";

        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert();
        SmsMessages.SendSmsResponse(phone, message);
        ;
    end;

}




