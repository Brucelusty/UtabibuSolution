//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172069 "Imprest Request"
{
    Caption = 'Travel Imprest Request';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    // ApplicationArea=ALL;

    SourceTable = "Imprest Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = DateEditable;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = GlobalDimension1CodeEditable;
                }
                field("Function Name";Rec."Function Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ShortcutDimension2CodeEditable;
                }
                field("Budget Center Name";Rec."Budget Center Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code";Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ShortcutDimension3CodeEditable;
                    Visible = false;
                }
                field(Dim3; Rec.Dim3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code";Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                    Editable = ShortcutDimension4CodeEditable;
                    Visible = false;
                }
                field(Dim4; Rec.Dim4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No.";Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Requisition; Rec.Requisition)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Currency Code";Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = "Currency CodeEditable";
                    Visible = false;
                }
                field("Paying Account Type";Rec."Paying Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Account";Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Paying Account No';
                }
                field("Bank Name";Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Paying Account Name';
                    Editable = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Caption = 'Requestor ID';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Net Amount";Rec."Total Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Net Amount LCY";Rec."Total Net Amount LCY")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Release Date";Rec."Payment Release Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field("Pay Mode";Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No.";Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque/EFT No.';
                }
            }
            part(PVLines;"Imprest Details")
            {
                SubPageLink = No = field("No.");
            }
            systempart(Control5; Links)
            {
                Visible = true;
            }
            systempart(Control3; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Post Payment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Payment';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CheckImprestRequiredItems(Rec);
                        PostImprest(Rec);
                        /*
                              RESET;
                              SETFILTER("No.","No.");
                              REPORT.RUN(55885,TRUE,TRUE,Rec);
                              RESET;
                         */

                    end;
                }
                separator(Action1102755026)
                {
                }
                action(Approvals)
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
                        DocumentType := Documenttype::ImprestRequisition;
                        ApprovalEntries.SetRecordFilters(Database::"Imprest Header", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Workflowintegration.CheckImprestRequisitionApprovalsWorkflowEnabled(Rec) then
                            Workflowintegration.OnSendImprestRequisitionForApproval(Rec);
                    end;
                }
                action("Canel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action1102755009)
                {
                }
                action("Check Budgetary Availability")
                {
                    ApplicationArea = Basic;
                    Caption = 'Check Budgetary Availability';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        BCSetup: Record "Budgetary Control Setup";
                    begin

                        BCSetup.Get;
                        if not BCSetup.Mandatory then
                            exit;

                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //First Check whether other lines are already committed.
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."document type"::Imprest);
                        Commitments.SetRange(Commitments."Document No.", Rec."No.");
                        if Commitments.Find('-') then begin
                            if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                            Commitments.Reset;
                            Commitments.SetRange(Commitments."Document Type", Commitments."document type"::Imprest);
                            Commitments.SetRange(Commitments."Document No.", Rec."No.");
                            Commitments.DeleteAll;
                        end;

                        //CheckBudgetAvail.CheckImprest(Rec);
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Budget Commitment';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."document type"::Imprest);
                        Commitments.SetRange(Commitments."Document No.", Rec."No.");
                        Commitments.DeleteAll;

                        PayLine.Reset;
                        PayLine.SetRange(PayLine.No, Rec."No.");
                        if PayLine.Find('-') then begin
                            repeat
                                PayLine.Committed := false;
                                PayLine.Modify;
                            until PayLine.Next = 0;
                        end;
                    end;
                }
                separator(Action1102755033)
                {
                }
                action("Print/Preview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print/Preview';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Rec.TestField("Payment Release Date");
                        Rec.TestField("Paying Bank Account");
                        Rec.TestField("Account No.");
                        //TESTFIELD("Cheque No.");
                        Rec.TestField("Account Type", Rec."account type"::Customer);

                        //IF Status<>Status::Posted THEN
                        //ERROR('You can only print after the document is Approved and Posted');
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        Report.run(172129, true, true, Rec);
                        Rec.Reset;
                    end;
                }
                separator(Action1102756006)
                {
                }
                action("Cancel Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: label 'Are you sure you want to Cancel this Document?';
                        Text001: label 'You have selected not to Cancel this Document';
                    begin
                        //TESTFIELD(Status,Status::Approved);
                        if Confirm(Text000, true) then begin
                            //Post Committment Reversals
                            Doc_Type := Doc_type::Imprest;
                            BudgetControl.ReverseEntries(Doc_Type, Rec."No.");
                            Rec.Status := Rec.Status::Rejected;
                            Rec.Modify;
                        end else
                            Error(Text001);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecords;
    end;

    trigger OnInit()
    begin
        "Currency CodeEditable" := true;
        DateEditable := true;
        ShortcutDimension2CodeEditable := true;
        GlobalDimension1CodeEditable := true;
        "Cheque No.Editable" := true;
        "Pay ModeEditable" := true;
        "Paying Bank AccountEditable" := true;
        "Payment Release DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //check if the documenent has been added while another one is still pending
        TravReqHeader.Reset;
        //TravAccHeader.SETRANGE(SaleHeader."Document Type",SaleHeader."Document Type"::"Cash Sale");
        TravReqHeader.SetRange(TravReqHeader.Cashier, UserId);
        TravReqHeader.SetRange(TravReqHeader.Status, Rec.Status::Open);

        if TravReqHeader.Count > 0 then begin
            Error('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
        end;
        //*********************************END ****************************************//


        Rec."Payment Type" := Rec."payment type"::Imprest;
        Rec."Account Type" := Rec."account type"::Customer;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        Rec."Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        Rec.Validate("Global Dimension 1 Code");
        Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        Rec.Validate("Shortcut Dimension 2 Code");
        Rec."Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        Rec.Validate("Shortcut Dimension 3 Code");
        Rec."Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        Rec.Validate("Shortcut Dimension 4 Code");
        //OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FilterGroup(0);
        end;
        UpdateControls;
    end;

    var
        PayLine: Record "Imprest Lines";
        PVUsers: Record "CshMgt PV Steps Users";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Payment Header.";
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Codes";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Funds User Setup";
        LineNo: Integer;
        Temp: Record "Funds User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Payment Header.";
        BankAcc: Record "Bank Account";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record Committment;
        UserMgt: Codeunit "User Setup Management BR";
        JournlPosted: Codeunit "Journal Post Successful";
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
        BudgetControl: Codeunit "Budgetary Control";
        ImprestHdr: Record "Imprest Header";
       
        "Payment Release DateEditable": Boolean;
       
        "Paying Bank AccountEditable": Boolean;
       
        "Pay ModeEditable": Boolean;
       
        "Cheque No.Editable": Boolean;
       
        GlobalDimension1CodeEditable: Boolean;
       
        ShortcutDimension2CodeEditable: Boolean;
       
        ShortcutDimension3CodeEditable: Boolean;
       
        ShortcutDimension4CodeEditable: Boolean;
       
        DateEditable: Boolean;
       
        "Currency CodeEditable": Boolean;
        TravReqHeader: Record "Imprest Header";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication;
        SFactory: Codeunit "Au Factory";
        GenJournalLine: Record "Gen. Journal Line";
        Workflowintegration: Codeunit WorkflowIntegration;


    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCsetup: Record "Budgetary Control Setup";
    begin
        if BCsetup.Get() then begin
            if not BCsetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        Exists := false;
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, Rec."No.");
        PayLine.SetRange(PayLine.Committed, false);
        PayLine.SetRange(PayLine."Budgetary Control A/C", true);
        if PayLine.Find('-') then
            Exists := true;
    end;


    procedure PostImprest(Rec: Record "Imprest Header")
    begin

        if Temp.Get(UserId) then begin
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.DeleteAll;
        end;

        if Rec."Paying Account Type" = Rec."paying account type"::"Bank Account" then begin
            LineNo := LineNo + 1000;
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name" := JTemplate;
            GenJnlLine."Journal Batch Name" := JBatch;
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Source Code" := 'PAYMENTJNL';
            GenJnlLine."Posting Date" := Rec."Payment Release Date";
            GenJnlLine."Document Type" := GenJnlLine."document type"::Invoice;
            GenJnlLine."Document No." := Rec."No.";
            GenJnlLine."External Document No." := Rec."Cheque No.";
            GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
            GenJnlLine."Account No." := Rec."Account No.";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine.Description := 'Imprest: ' + Rec."Account No." + ':' + Rec.Payee;
            Rec.CalcFields("Total Net Amount");
            GenJnlLine.Amount := Rec."Total Net Amount";
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"Bank Account";
            GenJnlLine."Bal. Account No." := Rec."Paying Bank Account";
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            //Added for Currency Codes
            GenJnlLine."Currency Code" := Rec."Currency Code";
            GenJnlLine.Validate("Currency Code");
            GenJnlLine."Currency Factor" := Rec."Currency Factor";
            GenJnlLine.Validate("Currency Factor");
            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

            if GenJnlLine.Amount <> 0 then
                GenJnlLine.Insert;


            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJnlLine);

            Post := false;
            Post := JournlPosted.PostedSuccessfully();
            //IF Post THEN BEGIN


            Rec.Posted := true;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;
            Rec.Modify;
            //END;
            Message('Transaction Posted Succesfully');
        end;



        if Rec."Paying Account Type" = Rec."paying account type"::"FOSA Account" then begin
            //------------------------------------1. DEBIT STAFF DEBTOR A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(JTemplate, JBatch, Rec."No.", LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Customer, Rec."Account No.", Rec."Payment Release Date", Rec."Total Net Amount", Rec."Global Dimension 1 Code", Rec."No.",
            'Imprest: ' + Rec."Account No." + ':' + Rec.Payee, '', GenJnlLine."application source"::" ");
            //--------------------------------(Debit Staff Debtor Account)---------------------------------------------

            //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(JTemplate, JBatch, Rec."No.", LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, Rec."Paying Bank Account", Rec."Payment Release Date", Rec."Total Net Amount" * -1, Rec."Global Dimension 1 Code", Rec."No.",
            'Imprest: ' + Rec."Account No." + ':' + Rec.Payee, '', GenJnlLine."application source"::" ");
            //----------------------------------(Credit Member Fosa Account)------------------------------------------------

            //Posting
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
            Rec.Posted := true;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;
            Rec.Modify;
            Message('Transaction Posted Succesfully');
        end;
    end;


    procedure CheckImprestRequiredItems(Rec: Record "Imprest Header")
    begin

        Rec.TestField("Payment Release Date");
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Account No.");

        Rec.TestField("Account Type", Rec."account type"::Customer);


        /*
      PayLine.RESET;
      PayLine.SETRANGE(PayLine.No,"No.");
      IF PayLine.FIND ('-') THEN BEGIN
      REPEAT
      //IF PayLine."Applies-to ID" =''  THEN ERROR ('Please specify Invoice to be Paid!');
      IF PayLine.PayLine."Due Date"='' THEN ERROR ('Enter Due Date!');
      IF PayLine.PayLine.PayLine."Date Issued" ='' THEN ERROR('Enter Date Issued!');
      IF PayLine.Amount=0 THEN ERROR('Enter Amount!');
      UNTIL PayLine.NEXT=0;
      END;
         */
        if Rec.Posted then begin
            Error('The Document has already been posted');
        end;

        //TESTFIELD(Status,Status::Approved);

        /*Check if the user has selected all the relevant fields*/

        Temp.Get(UserId);
        JTemplate := Temp."Imprest Template";
        JBatch := Temp."Imprest  Batch";

        if JTemplate = '' then begin
            Error('Ensure the Imprest Template is set up in Cash Office Setup');
        end;

        if JBatch = '' then begin
            Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
        end;

        if not LinesExists then
            Error('There are no Lines created for this Document');

    end;


    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Open then begin
            "Payment Release DateEditable" := false;
            "Paying Bank AccountEditable" := false;
            "Pay ModeEditable" := false;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            "Cheque No.Editable" := false;
            CurrPage.Update;
        end else begin
            "Payment Release DateEditable" := true;
            "Paying Bank AccountEditable" := true;
            "Pay ModeEditable" := true;
            "Cheque No.Editable" := true;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            CurrPage.Update;
        end;

        if Rec.Status = Rec.Status::Open then begin
            GlobalDimension1CodeEditable := true;
            ShortcutDimension2CodeEditable := true;
            //CurrForm.Payee.EDITABLE:=TRUE;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            DateEditable := true;
            //CurrForm."Account No.".EDITABLE:=TRUE;
            "Currency CodeEditable" := true;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            CurrPage.Update;
        end else begin
            GlobalDimension1CodeEditable := false;
            ShortcutDimension2CodeEditable := false;
            //CurrForm.Payee.EDITABLE:=FALSE;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            //CurrForm."Account No.".EDITABLE:=FALSE;
            "Currency CodeEditable" := false;
            CurrPage.Update;
        end
    end;


    procedure LinesExists(): Boolean
    var
        PayLines: Record "Imprest Lines";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;


    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Imprest Lines";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."Account No:" = '') or (PayLines.Amount <= 0) then
                    AllKeyFieldsEntered := false;
            until PayLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    local procedure OnAfterGetCurrRecords()
    begin
        xRec := Rec;
        UpdateControls();
    end;
}




