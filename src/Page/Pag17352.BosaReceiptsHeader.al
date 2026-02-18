Page 17352 "Bosa Receipts Header"
{

    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Receipts Processing Header";
    SourceTableView = where(Posted = const(false));

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
            part("Bosa receipt lines"; "Bosa receipt lines")
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
                Caption = 'Import Receipts';
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Import Checkoff Receipts";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Checkoff Receipts")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Checkoff Receipts';
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Loan CutOff Date");

                    ReceiptsProcessingLines.Reset;
                    ReceiptsProcessingLines.SetRange(ReceiptsProcessingLines."Receipt Header No", Rec.No);
                    //ReceiptsProcessingLines.SetRange(ReceiptsProcessingLines."Employer Code",rec."Employer Code");
                    if ReceiptsProcessingLines.FindFirst then
                        Report.Run(50034, true, false, ReceiptsProcessingLines);


                    Cust.Reset;
                    Cust.SetRange(Cust."No.", ReceiptsProcessingLines."Member No");
                    if Cust.Find('-') then begin

                        ReceiptsProcessingLines."Member Found" := true;
                        ReceiptsProcessingLines.Modify;

                    end;

                end;
            }
            action("Update Variance")
            {
                ApplicationArea = Basic;
                Caption = 'Update Variance';
                Image = ValidateEmailLoggingSetup;
                Promoted = true;

                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Loan CutOff Date");

                    ReceiptsProcessingLines.Reset;
                    ReceiptsProcessingLines.SetRange(ReceiptsProcessingLines."Receipt Header No", Rec.No);
                    if ReceiptsProcessingLines.FindFirst then begin
                        Report.Run(50041, true, false, ReceiptsProcessingLines);
                    end;



                end;
            }
            action("Update Loans Interest Due")
            {
                ApplicationArea = Basic;
                Image = UpdateShipment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    ReceiptsProcessingLines.Reset;
                    ReceiptsProcessingLines.SetRange(ReceiptsProcessingLines."Receipt Header No", Rec.No);
                    if ReceiptsProcessingLines.FindFirst then
                        Report.Run(50042, true, false, ReceiptsProcessingLines);
                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Post check off")
            {
                ApplicationArea = Basic;
                Caption = 'Post check off';
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Rec.Posted = true then
                        Error('This Check Off has already been posted');
                    if Rec."Account No" = '' then
                        Error('You must specify the Account No.');
                    if Rec."Document No" = '' then
                        Error('You must specify the Document No.');
                    if Rec."Posting date" = 0D then
                        Error('You must specify the Posting date.');


                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then
                        repeat
                            RcptBufLines.TestField("Member Found", true);
                            if (RcptBufLines."Trans Type" <> 'DEPOSITS') and (RcptBufLines."Trans Type" <> 'BENFUND') and (RcptBufLines."Trans Type" <> 'SAVINGS') and (RcptBufLines."Trans Type" <> 'REGISTRATION') and (RcptBufLines."Trans Type" <> 'SHARE CAPITAL') then
                                RcptBufLines.TestField("Loan Found", true);
                        until RcptBufLines.Next = 0;

                    Datefilter := '..' + Format(Rec."Loan CutOff Date");

                    PDate := Rec."Posting date";
                    DocNo := Rec."Document No";

                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    GenBatches.SetRange(GenBatches.Name, 'CHECK OFF');
                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'GENERAL';
                        GenBatches.Name := 'CHECK OFF';
                        GenBatches.Description := 'CHECK OFF';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                    end;
                    //Delete journal
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                    Gnljnline.SetRange("Journal Batch Name", 'CHECK OFF');
                    Gnljnline.DeleteAll;
                    //End of deletion

                    RunBal := 0;
                    Rec.CalcFields("Scheduled Amount");

                    if Rec."Scheduled Amount" <> Rec.Amount then begin
                        Error('Scheduled Amount Is Not Equal To Cheque Amount');
                    end;

                    // MWMBER NOT FOUND
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat
                            if (RcptBufLines."Trans Type" = 'DEPOSITS') or (RcptBufLines."Trans Type" = 'BENFUND') or (RcptBufLines."Trans Type" = 'SAVINGS') or (RcptBufLines."Trans Type" = 'REGFEE') or (RcptBufLines."Trans Type" = 'SHARE CAPITAL') then begin

                                LineN := LineN + 10000;
                                Gnljnline.Init;
                                Gnljnline."Journal Template Name" := 'GENERAL';
                                Gnljnline."Journal Batch Name" := 'CHECK OFF';
                                Gnljnline."Line No." := LineN;
                                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                                Gnljnline."Account No." := RcptBufLines."Member No";
                                Gnljnline.Validate(Gnljnline."Account No.");
                                Gnljnline."Document No." := Rec.No;//"Document No";
                                Gnljnline."Posting Date" := Rec."Posting date";
                                Gnljnline.Description := RcptBufLines."Trans Type" + '-' + Rec.Remarks;
                                Gnljnline.Amount := RcptBufLines.Amount * -1;
                                if RcptBufLines."Trans Type" = 'DEPOSITS' then begin
                                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution"
                                end else
                                    if RcptBufLines."Trans Type" = 'BENFUND' then begin
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Benevolent Fund"
                                    end else
                                        if RcptBufLines."Trans Type" = 'SAVINGS' then begin
                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Programmed Deposits"
                                        end else
                                            if RcptBufLines."Trans Type" = 'SHARE CAPITAL' then begin
                                                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Share Capital"
                                            end else
                                                if RcptBufLines."Trans Type" = 'REGFEE' then begin
                                                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Registration Fee";
                                                end;
                                Gnljnline."Loan No" := RcptBufLines."Loan No";
                                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                                Gnljnline."Shortcut Dimension 2 Code" := 'Nairobi';
                                Gnljnline.Validate(Gnljnline.Amount);
                                if Gnljnline.Amount <> 0 then
                                    Gnljnline.Insert;

                            end;
                        until RcptBufLines.Next = 0;
                    end;

                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat
                            if RcptBufLines."Trans Type" = 'UNALLOCATED' then begin

                                LineN := LineN + 1;
                                Gnljnline.Init;
                                Gnljnline."Journal Template Name" := 'GENERAL';
                                Gnljnline."Journal Batch Name" := 'CHECK OFF';
                                Gnljnline."Line No." := LineN;
                                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                                Gnljnline."Account No." := RcptBufLines."Member No";
                                Gnljnline.Validate(Gnljnline."Account No.");
                                Gnljnline."Document No." := Rec.No;//"Document No";
                                Gnljnline."Posting Date" := Rec."Posting date";
                                Gnljnline.Description := RcptBufLines."Trans Type" + '-' + Rec.Remarks;
                                Gnljnline.Amount := -RcptBufLines.Amount;
                                //Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Unallocated Funds";
                                // Gnljnline."Loan No":=RcptBufLines."Loan No";
                                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                                Gnljnline."Shortcut Dimension 2 Code" := 'Nairobi';
                                Gnljnline.Validate(Gnljnline.Amount);
                                if Gnljnline.Amount <> 0 then
                                    Gnljnline.Insert;
                            end;
                        until RcptBufLines.Next = 0;
                    end;

                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    RcptBufLines.SetFilter(RcptBufLines."Loan No", '<>%1', '');
                    if RcptBufLines.FindSet then begin
                        repeat

                            RunnBal := 0;
                            RunnBal := RcptBufLines.Amount;
                            if RcptBufLines."Interest Due to Be Paid" <> 0 then begin
                                Varrunningbal := RunnBal;
                            end;
                            if RcptBufLines."Interest Due to Be Paid" > RcptBufLines.Amount then begin
                                Varrunningbal := RcptBufLines.Amount;
                            end else
                                Varrunningbal := RcptBufLines."Interest Due to Be Paid";

                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'CHECK OFF';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                            Gnljnline."Account No." := RcptBufLines."Member No";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := Rec.No;//"Document No";
                            Gnljnline."Posting Date" := Rec."Posting date";
                            Gnljnline.Description := RcptBufLines."Trans Type" + '-' + Rec.Remarks;
                            Gnljnline.Amount := -Varrunningbal;
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                            Gnljnline."Loan No" := RcptBufLines."Loan No";
                            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                            Gnljnline."Shortcut Dimension 2 Code" := 'Nairobi';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;
                            RunnBal := RunnBal - Varrunningbal;
                            ////...............................................................................PRI
                            if RcptBufLines.Outbalance > 0 then begin

                                OUTBAL := RcptBufLines.Outbalance;
                            end;
                            if OUTBAL < RunnBal then
                                Varrunningbal := OUTBAL
                            else
                                Varrunningbal := RunnBal;
                            ///DEFAULT

                            //END OF DEFAULT
                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'CHECK OFF';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                            Gnljnline."Account No." := RcptBufLines."Member No";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := Rec.No;//"Document No";
                            Gnljnline."Posting Date" := Rec."Posting date";
                            Gnljnline.Description := RcptBufLines."Trans Type" + '-' + Rec.Remarks;
                            Gnljnline.Amount := -Varrunningbal;
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::Repayment;
                            Gnljnline."Loan No" := RcptBufLines."Loan No";
                            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                            Gnljnline."Shortcut Dimension 2 Code" := 'Nairobi';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;
                            RunnBal := RunnBal - Varrunningbal;

                            ///MESSAGE ('LASTWERTYU ON IS AMNT IS %1',RunnBal);
                            if RunnBal > 0 then
                                LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'CHECK OFF';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                            Gnljnline."Account No." := RcptBufLines."Member No";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := Rec.No;//"Document No";
                            Gnljnline."Posting Date" := Rec."Posting date";
                            Gnljnline.Description := RcptBufLines."Trans Type" + '-' + Rec.Remarks;
                            Gnljnline.Amount := -RunnBal;
                            //Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::Repayment;
                            Gnljnline."Loan No" := RcptBufLines."Loan No";
                            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                            Gnljnline."Shortcut Dimension 2 Code" := 'Nairobi';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;
                        // END;
                        until RcptBufLines.Next = 0;
                    end;

                    LineN += 1000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := 'CHECK OFF';
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Rec."Account Type";
                    Gnljnline."Account No." := Rec."Account No";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := rec.No;//"Document No";
                    Gnljnline."Posting Date" := rec."Posting date";
                    Gnljnline.Description := rec.Remarks;
                    Gnljnline.Amount := Rec.Amount;
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    Gnljnline."Shortcut Dimension 2 Code" := 'Nairobi';
                    Gnljnline.Validate(Gnljnline.Amount);
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;

                    Message('CheckOff Successfully Generated');
                    /*
                    Posted:=True;
                    MODIFY;
                     */

                end;
            }
            action("Checkoff Posted Summary")
            {
                ApplicationArea = Basic;
                Image = PrintForm;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Recp: Record "Receipts Processing Header";
                begin
                    Recp.Reset;
                    Recp.SetRange(No, Rec.No);
                    if Recp.FindFirst then
                        Report.Run(51516054, true, false, Recp);

                end;
            }
            action("Checkoff List Report_Ported ")
            {
                ApplicationArea = Basic;
                Image = PrintForm;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Recp: Record "Receipts Processing Header";
                begin
                    Recp.Reset;
                    Recp.SetRange(No, Rec.No);
                    if Recp.FindFirst then
                        Report.Run(51516055, true, false, Recp);

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
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Receipts Processing Lines";
        LineNo: Integer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Receipts Processing Header";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "Receipts Processing Lines";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        // Genstup: Record pa;
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Receipts Processing Lines";
        Loans: Record "Loans Register";
        RunnBal: Decimal;
        Varrunningbal: Decimal;
        OUTBAL: Decimal;
}

