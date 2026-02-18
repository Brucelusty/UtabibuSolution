//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172153 "Posted Staff Claims"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Staff Claims Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = DateEditable;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No/Name';
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = "Currency CodeEditable";
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic;
                    Caption = 'Claim Description';
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
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Net Amount LCY"; Rec."Total Net Amount LCY")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                    Editable = "Payment Release DateEditable";
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = "Pay ModeEditable";
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque/EFT No.';
                    Editable = "Cheque No.Editable";
                }
            }
            part(PVLines; "Posted Staff Claim Lines")
            {
                SubPageLink = No = field("No.");
            }
            systempart(Control1000000004; MyNotes)
            {
            }
            systempart(Control1000000003; Links)
            {
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
                action("Print/Preview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        /*RESET;
                        SETFILTER("No.","No.");
                        Report.run(172935,TRUE,TRUE,Rec);
                        RESET;*/

                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        Report.run(172507, true, true, Rec);
                        Rec.Reset;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
        CurrPageUpdate;
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
        TravReqHeader.SetRange(TravReqHeader.Status, Rec.Status::Pending);
        /*
            IF TravReqHeader.COUNT>0 THEN
              BEGIN
               ERROR('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
              END;
              */
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
        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
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
        PayLine: Record "Staff Claim Lines";
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
        BudgetControl: Codeunit "Budgetary Control";
        TravReqHeader: Record "Staff Claims Header";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
     
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
        StatusEditable: Boolean;


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


    procedure PostImprest()
    begin

        if Temp.Get(UserId) then begin
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.DeleteAll;
        end;

        //CREDIT BANK
        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" :=Rec."Payment Release Date";
        GenJnlLine."Document No." :=Rec."No.";
        GenJnlLine."External Document No." :=Rec."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No." :=Rec."Paying Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := Rec.Purpose;
        Rec.CalcFields("Total Net Amount");
        GenJnlLine."Credit Amount" :=Rec."Total Net Amount";
        GenJnlLine.Validate(GenJnlLine."Credit Amount");
        //Added for Currency Codes
        GenJnlLine."Currency Code" :=Rec."Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine."Currency Factor" :=Rec."Currency Factor";
        GenJnlLine.Validate("Currency Factor");
        GenJnlLine."Shortcut Dimension 1 Code" :=Rec."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" :=Rec."Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;



        //DEBIT RESPECTIVE G/L ACCOUNT(S)
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, Rec."No.");
        if PayLine.Find('-') then begin
            repeat
                LineNo := LineNo + 1000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Posting Date" :=Rec."Payment Release Date";
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Invoice;
                GenJnlLine."Document No." :=Rec."No.";
                GenJnlLine."External Document No." :=Rec."Cheque No.";
                GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                GenJnlLine."Account No." := PayLine."Account No:";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine.Description := Rec.Purpose;
                GenJnlLine."Debit Amount" := PayLine.Amount;
                GenJnlLine.Validate(GenJnlLine."Debit Amount");
                //Added for Currency Codes
                GenJnlLine."Currency Code" :=Rec."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" :=Rec."Currency Factor";
                GenJnlLine.Validate("Currency Factor");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;

            until PayLine.Next = 0
        end;


        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        //Adjust Gen Jnl Exchange Rate Rounding Balances
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust Gen Jnl Exchange Rate Rounding Balances

        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);

        //Post:= FALSE;
        //Post:=JournlPosted.PostedSuccessfully();
        //IF Post THEN BEGIN
        Rec.Posted := true;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Status := Rec.Status::Posted;
        Rec.Modify;
        //END;
    end;


    procedure CheckImprestRequiredItems()
    begin

        Rec.TestField("Payment Release Date");
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Account No.");
        Rec.TestField("Account Type", Rec."account type"::Customer);

        if Rec.Posted then begin
            Error('The Document has already been posted');
        end;

        Rec.TestField(Status, Rec.Status::Approved);

        /*Check if the user has selected all the relevant fields*/

        Temp.Get(UserId);
        JTemplate := Temp."Claim Template";
        JBatch := Temp."Claim  Batch";

        if JTemplate = '' then begin
            Error('Ensure the Staff Claims Template is set up in Cash Office Setup');
        end;

        if JBatch = '' then begin
            Error('Ensure the Staff Claims Batch is set up in the Cash Office Setup')
        end;

        if not LinesExists then
            Error('There are no Lines created for this Document');

    end;


    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Approved then begin
            "Payment Release DateEditable" := false;
            "Paying Bank AccountEditable" := false;
            "Pay ModeEditable" := false;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            "Cheque No.Editable" := false;
            //CurrPage.UpdateControls();
        end else begin
            "Payment Release DateEditable" := true;
            "Paying Bank AccountEditable" := true;
            "Pay ModeEditable" := true;
            "Cheque No.Editable" := true;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            //CurrPage.UpdateControls();
        end;

        if Rec.Status = Rec.Status::Pending then begin
            GlobalDimension1CodeEditable := true;
            ShortcutDimension2CodeEditable := true;
            //CurrForm.Payee.EDITABLE:=TRUE;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            DateEditable := true;
            //CurrForm."Account No.".EDITABLE:=TRUE;
            "Currency CodeEditable" := true;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrPage.UpdateControls();
        end else begin
            GlobalDimension1CodeEditable := false;
            ShortcutDimension2CodeEditable := false;
            //CurrForm.Payee.EDITABLE:=FALSE;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            //CurrForm."Account No.".EDITABLE:=FALSE;
            "Currency CodeEditable" := false;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            //CurrPage.UpdateControls();
        end
    end;


    procedure LinesExists(): Boolean
    var
        PayLines: Record "Staff Claim Lines";
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
        PayLines: Record "Staff Claim Lines";
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


    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.Update;
    end;


    procedure CheckIfIsAboveCashLimit()
    var
        CashOfficeSetup: Record "Cash Office Setup";
    begin
        //if above cash limit then pay mode must be cheque
        if Rec."Pay Mode" <> Rec."pay mode"::Cash then exit;
        Rec.CalcFields("Total Net Amount");
        CashOfficeSetup.Get;
        if Rec."Total Net Amount" >= CashOfficeSetup."Minimum Cheque Creation Amount" then
            Error('The specified amount %1 should be created as a cheque.', Rec."Total Net Amount");
    end;


    procedure RecordLinkCheck(StaffClaimsHeader: Record "Staff Claims Header") RecordLnkExist: Boolean
    var
        objRecordLnk: Record "Record Link";
        TableCaption: RecordID;
        objRecord_Link: RecordRef;
    begin
        objRecord_Link.GetTable(StaffClaimsHeader);
        TableCaption := objRecord_Link.RecordId;
        objRecordLnk.Reset;
        objRecordLnk.SetRange(objRecordLnk."Record ID", TableCaption);
        if objRecordLnk.Find('-') then exit(true) else exit(false);
    end;
}




