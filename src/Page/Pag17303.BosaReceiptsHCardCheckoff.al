Page 17303 "Bosa Receipts H Card-Checkoff"
{

    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "ReceiptsProcessing_H-Checkoff";
    SourceTableView = where(Posted = const(false));
    PromotedActionCategories = 'New,Process,Report,Validate,Post,Import';


    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; Rec."Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Bosa receipt lines"; "Bosa Receipt line-Checkoff")
            {
                SubPageLink = "Receipt Header No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<XMLport Import receipts>")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Import Receipts';
                RunObject = XMLport "Import Checkoff Block";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Receipts")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Receipts';
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = Report "Check of Distribution";

                trigger OnAction()
                var

                    DetLedg: Record "Detailed Cust. Ledg. Entry";
                begin

                    DetLedg.RESET;
                    DetLedg.SETRANGE(DetLedg."Document No.", Rec.No);
                    IF DetLedg.FIND('-') = TRUE THEN
                        ERROR('Sorry,You have already posted this Document. Validation not Allowed.');
                    ReceiptLine.RESET;
                    ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No", Rec.No);
                    IF ReceiptLine.FINDSET() THEN BEGIN
                        REPEAT
                            ReceiptLine."Member No" := '';
                            ReceiptLine.Name := '';
                            ReceiptLine."ID No." := '';
                            ReceiptLine."Employer Code" := '';
                            ReceiptLine."Member Found" := false;

                            ReceiptLine.MODIFY;
                        UNTIL ReceiptLine.NEXT = 0;
                    END;

                    ReceiptLine.RESET;
                    ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No", Rec.No);
                    IF ReceiptLine.FIND('-') THEN BEGIN
                        REPEAT
                            Memb.RESET;
                            Memb.SETRANGE(Memb."Payroll No", ReceiptLine."Staff/Payroll No");
                            Memb.SETRANGE(Memb."Employer Code",ReceiptLine."Employer Code");
                            IF Memb.FIND('-') THEN BEGIN
                                ReceiptLine."Employer Code" := Memb."Employer Code";
                                ReceiptLine."Member No" := Memb."No.";
                                ReceiptLine.Name := Memb.Name;
                                ReceiptLine."ID No." := Memb."ID No.";
                                ReceiptLine."Member Found" := true;
                                ReceiptLine.MODIFY;
                            END;
                        UNTIL ReceiptLine.NEXT = 0;
                    END;
                    MESSAGE('Validation was successfully completed');

                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Post check off")
            {
                ApplicationArea = Basic;
                Caption = 'Post check off';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin

                    genstup.Get();
                    if Rec.Posted = true then
                        Error('This Check Off has already been posted');
                    if Rec."Account No" = '' then
                        Error('You must specify the Account No.');
                    if Rec."Document No" = '' then
                        Error('You must specify the Document No.');
                    if Rec."Posting date" = 0D then
                        Error('You must specify the Posting date.');
                    Datefilter := '..' + Format(Rec."Loan CutOff Date");



                    PDate := Rec."Posting date";
                    DocNo := Rec."Document No";
                    // GenBatches.Reset;
                    // GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    // GenBatches.SetRange(GenBatches.Name, CheckoffBatch);
                    // if GenBatches.Find('-') = false then begin
                    //     GenBatches.Init;
                    //     GenBatches."Journal Template Name" := 'GENERAL';
                    //     GenBatches.Name := CheckoffBatch;
                    //     GenBatches.Description := 'CHECK OFF PROCESS';
                    //     GenBatches.Validate(GenBatches."Journal Template Name");
                    //     GenBatches.Validate(GenBatches.Name);
                    //     GenBatches.Insert;
                    // end;



                    //Delete journal
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                    Gnljnline.SetRange("Journal Batch Name", CheckoffBatch);
                    Gnljnline.DeleteAll;
                    //End of deletion





                    RunBal := 0;
                    Rec.CalcFields("Scheduled Amount");


                    genstup.Get();

                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat

                            RunBal := 0;
                            RunBal := RcptBufLines.Amount;

                            if RunBal > 0 then begin

                                GetBatch();
                                RunBal := RegistrationFee(RcptBufLines, RunBal);
                                RunBal := RecoverInterest(RcptBufLines, RunBal);
                                RunBal := LoanRepayment(RcptBufLines, RunBal);
                                RunBal := ShareCapital(RcptBufLines, RunBal);
                                RunBal := PostmemberDeposit(RcptBufLines, RunBal);
                                RunBal := PostExcessAmount(RcptBufLines, RunBal);
                            end;

                        until RcptBufLines.Next = 0;
                    end;


                    PostCustomerInfor();


                    Rec."Posted By" := UserId;
                    Rec.Modify;

                    Message('CheckOff Successfully Generated');


                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Posting date" := Today;
        Rec."Date Entered" := Today;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        CheckoffBatch: Label 'Checkoff';
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "ReceiptsProcessing_L-Checkoff";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "ReceiptsProcessing_H-Checkoff";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "ReceiptsProcessing_L-Checkoff";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        RegistrationAmount: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "ReceiptsProcessing_L-Checkoff";
        LoanMonthlyRepayment: Record "Loan Repayment Schedule";
        RegistrationFeePaid: Decimal;
        RunBal2: Decimal;
        GeneralBactch: Record 232;


    procedure RegistrationFee(RcptBufLines: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    begin
        RegistrationAmount := 0;
        RegistrationFeePaid := 0;
        Cust.Reset;
        Cust.SetRange(Cust."No.", RcptBufLines."Member No");
        if Cust.Find('-') then begin
            repeat
                Cust.CalcFields(Cust."Registration Fee Paid");
                RegistrationFeePaid := Cust."Registration Fee Paid";
                if RegistrationFeePaid = 0 then begin
                    genstup.Get();
                    if Cust."Registration Date" <> 0D then begin
                        if (Cust.MemberCategory = Cust.MemberCategory::Member) and (Cust."Account Category" = Cust."Account Category"::Individual) then
                            RegistrationAmount := genstup."BOSA Registration Fee Amount" - RegistrationFeePaid
                        else
                            RegistrationAmount := genstup."Staff Registration Fee Amount" - RegistrationFeePaid;

                        LineN := LineN + 10000;
                        Gnljnline.Init;
                        Gnljnline."Journal Template Name" := 'GENERAL';
                        Gnljnline."Journal Batch Name" := CheckoffBatch;
                        Gnljnline."Line No." := LineN;
                        Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                        Gnljnline."Account No." := RcptBufLines."Member No";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No." := Rec."Document No";
                        Gnljnline."Posting Date" := Rec."Posting date";
                        Gnljnline.Description := 'Registration Fee ' + Rec.Remarks;
                        Gnljnline.Amount := RegistrationAmount * -1;
                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Registration Fee";
                        Gnljnline."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        Gnljnline."Shortcut Dimension 2 Code" := Cust."Global Dimension 2 Code";
                        Gnljnline.Validate(Gnljnline.Amount);
                        if Gnljnline.Amount <> 0 then
                            Gnljnline.Insert;
                        RunningBalance := RunningBalance - (RegistrationAmount);

                    end;
                end;
            until Cust.Next = 0;
        end;
        exit(RunningBalance);
    end;

    procedure LoanRepayment(RcptBufLines: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    begin

        if RunningBalance > 0 then
            TotalRepay := 0;



        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
        //LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
        LoanApp.SetRange(LoanApp."Client Code", RcptBufLines."Member No");
        LoanApp.SetFilter(LoanApp."Issued Date", Datefilter);
        if LoanApp.Find('-') then begin
            repeat
                if RunningBalance > 0 then begin
                    LRepayment := 0;
                    LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");

                    if LoanApp."Outstanding Balance" > 0 then begin
                        LType := LoanApp."Loan Product Type";

                        LoanMonthlyRepayment.Reset();
                        LoanMonthlyRepayment.SetRange("Loan No.", LoanApp."Loan  No.");
                        LoanMonthlyRepayment.SetFilter("Repayment Date", Datefilter);
                        if LoanMonthlyRepayment.FindLast() then begin
                            LRepayment := LoanMonthlyRepayment."Principal Repayment";
                        end;

                        if LRepayment > LoanApp."Outstanding Balance" then
                            LRepayment := LoanApp."Outstanding Balance";
                        if LRepayment = 0 then begin
                            RcptBufLines."No Repayment" := true;
                            RcptBufLines.Modify;
                        end;

                        //IF LoanApp."Issued Date"<= PDate THEN BEGIN>NIC
                        //if LoanApp."Issued Date" < Rec."Loan CutOff Date" then begin
                        if LRepayment > 0 then begin
                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := CheckoffBatch;
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No." := LoanApp."Client Code";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := Rec."Document No";
                            Gnljnline."Posting Date" := Rec."Posting date";
                            Gnljnline.Description := 'Repayment ' + Rec.Remarks;

                            if RunningBalance > 0 then begin

                                if RunningBalance > LRepayment then
                                    Gnljnline.Amount := LRepayment * -1
                                else
                                    Gnljnline.Amount := RunningBalance * -1;
                            end;

                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::Repayment;
                            Gnljnline."Loan No" := LoanApp."Loan  No.";
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;

                            RunningBalance := RunningBalance - (abs(Gnljnline.Amount));
                            //end;

                        end;
                    end;
                end;

            until LoanApp.Next = 0;
        end;

        exit(RunningBalance);

    end;

    procedure ShareCapital(RcptBufLines: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    begin
        genstup.Get();

        Cust.Reset;
        Cust.SetRange(Cust."Payroll No", RcptBufLines."Staff/Payroll No");
        Cust.SetRange(Cust."Employer Code", RcptBufLines."Employer Code");
        if Cust.Find('-') then begin
            Cust.CalcFields(Cust."Shares Retained");
            if Cust."Shares Retained" < genstup."Retained Shares" then begin

                SHARESCAP := genstup."Retained Shares";


                DIFF := SHARESCAP - Cust."Shares Retained";
                if DIFF > 250 then begin
                    DIFF := 250;
                end else begin
                    DIFF := SHARESCAP - Cust."Shares Retained";
                end;
                if (Cust.Status = Cust.Status::Active) or
                   (Cust.Status = Cust.Status::Dormant) or
                   (Cust.Status = Cust.Status::Deceased) then begin

                    if RunBal > 0 then begin
                        ShRec := Cust."Monthly Contribution";

                        if RunBal > ShRec then
                            ShRec := ShRec
                        else
                            ShRec := RunBal;

                        LineN := LineN + 10000;

                        Gnljnline.Init;
                        Gnljnline."Journal Template Name" := 'GENERAL';
                        Gnljnline."Journal Batch Name" := CheckoffBatch;
                        Gnljnline."Line No." := LineN;
                        Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                        Gnljnline."Account No." := RcptBufLines."Member No";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No." := Rec."Document No";
                        Gnljnline."Posting Date" := Rec."Posting date";
                        Gnljnline.Description := 'Share Capital ' + Rec.Remarks;
                        if RunBal > DIFF then begin
                            Gnljnline.Amount := DIFF * -1;
                        end else begin
                            Gnljnline.Amount := RunBal * -1;
                        end;
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Share Capital";
                        if Gnljnline.Amount <> 0 then
                            Gnljnline.Insert;
                        RunningBalance := RunningBalance - Abs(Gnljnline.Amount);
                    end;
                end;
            end;
        end;
        exit(RunningBalance);
    end;

    procedure PostExcessAmount(RcptBufLines: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    begin
        //++++++++++++Excess to Deposit Contribution++++++++++++++++//
        if RunBal > 0 then begin
            LineN := LineN + 10000;

            Gnljnline.Init;
            Gnljnline."Journal Template Name" := 'GENERAL';
            Gnljnline."Journal Batch Name" := CheckoffBatch;
            Gnljnline."Line No." := LineN;
            Gnljnline."Account Type" := Gnljnline."account type"::Customer;
            Gnljnline."Account No." := RcptBufLines."Member No";
            Gnljnline.Validate(Gnljnline."Account No.");
            Gnljnline."Document No." := Rec."Document No";
            Gnljnline."Posting Date" := Rec."Posting date";
            Gnljnline.Description := Rec.Remarks;
            Gnljnline.Amount := RunBal * -1;
            Gnljnline.Validate(Gnljnline.Amount);
            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
            if Gnljnline.Amount <> 0 then
                Gnljnline.Insert;
            RunningBalance := RunningBalance - Abs(Gnljnline.Amount);
        end;
        exit(RunningBalance);
    end;

    procedure PostmemberDeposit(RcptBufLines: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    begin
        if RunningBalance > 0 then
            Cust.Reset;
        Cust.SetRange(Cust."Payroll No", RcptBufLines."Staff/Payroll No");
        //Cust.SetRange(Cust."Employer Code", RcptBufLines."Employer Code");
        if Cust.Find('-') then begin
            if (Cust.Status = Cust.Status::Active) or
               (Cust.Status = Cust.Status::Dormant) or
               (Cust.Status = Cust.Status::Deceased) then begin

                if RunBal > 0 then begin
                    ShRec := Cust."Monthly Contribution";

                    if RunBal > ShRec then
                        ShRec := ShRec
                    else
                        ShRec := RunBal;
                    Message('home ');
                    LineN := LineN + 10000;

                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := CheckoffBatch;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                    Gnljnline."Account No." := RcptBufLines."Member No";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := 'Deposit Contribution' + Rec.Remarks;
                    if RunBal > ShRec then begin
                        Gnljnline.Amount := ShRec * -1;
                    end else begin
                        Gnljnline.Amount := RunBal * -1;
                    end;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    RunningBalance := RunningBalance - Abs(Gnljnline.Amount);
                end;
            end;
        end;
        exit(RunningBalance);
    end;

    procedure PostCustomerInfor()
    begin

        Rec.CalcFields("Scheduled Amount");

        LineN := LineN + 100;
        Gnljnline.Init;
        Gnljnline."Journal Template Name" := 'GENERAL';
        Gnljnline."Journal Batch Name" := CheckoffBatch;
        Gnljnline."Line No." := LineN;
        Gnljnline."Account Type" := Rec."Account Type";
        Gnljnline."Account No." := Rec."Account No";
        Gnljnline.Validate(Gnljnline."Account No.");
        Gnljnline."Document No." := Rec."Document No";
        Gnljnline."Posting Date" := Rec."Posting date";
        Gnljnline.Description := 'CHECKOFF ' + Rec.Remarks;
        Gnljnline.Amount := Rec."Scheduled Amount";
        Gnljnline.Validate(Gnljnline.Amount);
        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
        if Gnljnline.Amount <> 0 then
            Gnljnline.Insert;
    end;

    procedure RecoverInterest(RcptBufLines: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    begin
        if RunningBalance > 0 then
            Interest := 0;
        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
        //LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
        LoanApp.SetRange(LoanApp."Client Code", RcptBufLines."Member No");
        LoanApp.SetFilter(LoanApp."Issued Date", Datefilter);
        if LoanApp.Find('-') then begin
            repeat
                LoanApp.CalcFields(LoanApp."Outstanding Interest");

                if LoanApp."Outstanding Interest" > 0 then begin

                    if RunBal > 0 then begin


                        Interest := LoanApp."Outstanding Interest";

                        if Interest > 0 then begin


                            //if LoanApp."Issued Date" < Rec."Loan CutOff Date" then begin

                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := CheckoffBatch;
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No." := LoanApp."Client Code";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := Rec."Document No";
                            Gnljnline."Posting Date" := Rec."Posting date";
                            Gnljnline.Description := 'Interest Paid ' + Rec.Remarks;
                            if RunBal > Interest then
                                Gnljnline.Amount := -1 * Interest
                            else
                                Gnljnline.Amount := -1 * RunBal;
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                            Gnljnline."Loan No" := LoanApp."Loan  No.";
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;
                            RunningBalance := RunningBalance - Abs(Gnljnline.Amount);
                            // end;

                        end;
                    end;
                end;
            until LoanApp.Next = 0;
        end;

        exit(RunningBalance)
    end;

    procedure GetBatch()
    var
        myInt: Integer;
    begin
        GenBatches.Reset();
        GenBatches.SetRange("Journal Template Name", 'GENERAL');
        GenBatches.SetRange(Name, CheckoffBatch);
        if GenBatches.FindFirst() then begin
            GenBatches."Journal Template Name" := 'GENERAL';
            GenBatches.Name := CheckoffBatch;
            GenBatches.Description := CheckoffBatch;
            GenBatches.Insert(true);
        end;
    end;
}




