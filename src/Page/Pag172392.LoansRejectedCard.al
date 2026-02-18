//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172392 "Loans Rejected Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Loans Register";
    SourceTableView = where("Loan Status" = const(Rejected));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No.";Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Staff No";Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No';
                    Editable = false;
                }
                field("Client Code";Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member';
                    Editable = MNoEditable;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name";Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID NO";Rec."ID NO")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Deposits";Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = LProdTypeEditable;
                }
                field("Loan Product Type Name";Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Name';
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Product Currency Code";Rec."Product Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = true;
                    Visible = false;
                }
                field("Requested Amount";Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Boost this Loan";Rec."Boost this Loan")
                {
                    ApplicationArea = Basic;
                    Editable = AppliedAmountEditable;
                }
                field("Boosted Amount";Rec."Boosted Amount")
                {
                    ApplicationArea = Basic;
                    Editable = AppliedAmountEditable;
                }
                field("Recommended Amount";Rec."Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                group("Tranch Details")
                {
                    Caption = 'Tranch Details';
                    field("Amount to Disburse on Tranch 1";Rec."Amount to Disburse on Trunch 1")
                    {
                        ApplicationArea = Basic;
                    }
                    field("No of Tranch Disbursment";Rec."No of Tranch Disbursment")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Loan Purpose";Rec."Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("Loan Purpose Description";Rec."Loan Purpose Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Repayment Method";Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = RepaymentEditable;
                }
                field("Approved Repayment";Rec."Approved Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Member House Group";Rec."Member House Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member House Group Name";Rec."Member House Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Status";Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = LoanStatusEditable;

                    trigger OnValidate()
                    begin
                        //UpdateControl();
                    end;
                }
                field("Batch No.";Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Credit Officer II";Rec."Credit Officer II")
                {
                    ApplicationArea = Basic;
                    Caption = 'Credit Officer';
                }
                field("Loan Centre";Rec."Loan Centre")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured By";Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Offset Amount";Rec."Loan Offset Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bridged Amount';
                }
                field("Repayment Frequency";Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                }
                field("Mode of Disbursement";Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Disbursement Date";Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    AssistEdit = true;
                    Importance = Promoted;
                    NotBlank = true;
                    ShowMandatory = true;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Cheque No.";Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Cheque No.") > 6 then
                            Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }
                field("Repayment Start Date";Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Date of Completion";Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External EFT";Rec."External EFT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approval Status";Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("partially Bridged";Rec."partially Bridged")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Total Offset Commission";Rec."Total Offset Commission")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Disburesment Type";Rec."Disburesment Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Stages";Rec."Loan Stages")
                {
                    ApplicationArea = Basic;
                }
                part(Control29; "Loan Application Stages")
                {
                    Caption = 'Loan Stages';
                    SubPageLink = "Loan No" = field("Loan  No.");
                }
            }
            group(Control28)
            {
                Caption = 'Salary Details';
                group("Monthly Income Details")
                {
                    field("Salary Total Income";Rec."Salary Total Income")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Monthly Income';
                    }
                }
                group("Monthly Expenses Detailss")
                {
                    field("SExpenses Rent";Rec."SExpenses Rent")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Rent';
                    }
                    field("SExpenses Transport";Rec."SExpenses Transport")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Transport';
                    }
                    field("SExpenses Education";Rec."SExpenses Education")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Education';
                    }
                    field("SExpenses Food";Rec."SExpenses Food")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Food';
                    }
                    field("SExpenses Utilities";Rec."SExpenses Utilities")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Utilities';
                    }
                    field("SExpenses Others";Rec."SExpenses Others")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Others';
                    }
                }
                field("Salary Net Utilizable";Rec."Salary Net Utilizable")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Statement Details")
            {
                Caption = 'Statement Details';
                field("Bank Statement Avarage Credits";Rec."Bank Statement Avarage Credits")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Statement Avarage Debits";Rec."Bank Statement Avarage Debits")
                {
                    ApplicationArea = Basic;
                }
                group("Monthly Expenses Details")
                {
                    Caption = 'Monthly Expenses Details';
                    field("BSExpenses Rent";Rec."BSExpenses Rent")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Rent';
                    }
                    field("BSExpenses Transport";Rec."BSExpenses Transport")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Transport';
                    }
                    field("BSExpenses Education";Rec."BSExpenses Education")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Education';
                    }
                    field("BSExpenses Food";Rec."BSExpenses Food")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Food';
                    }
                    field("BSExpenses Utilities";Rec."BSExpenses Utilities")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Utilities';
                    }
                    field("BSExpenses Others";Rec."BSExpenses Others")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Others';
                    }
                }
                field("Bank Statement Net Income";Rec."Bank Statement Net Income")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Rejection Details")
            {
                Visible = RejectionVisible;
                field("Rejection  Remark";Rec."Rejection  Remark")
                {
                    ApplicationArea = Basic;
                }
                field("Rejected By";Rec."Rejected By")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Rejection";Rec."Date of Rejection")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rejection Date';
                }
            }
            part(Control2; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                Editable = false;
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                action("Mark As Posted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark As Posted';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.Posted := true;
                        Rec.Modify;
                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.","Loan  No.");
                        IF LoanApp.FIND('-') THEN BEGIN
                        REPORT.RUN(,TRUE,FALSE,LoanApp);
                        END;
                        END;
                        */

                    end;
                }
                separator(Action1102760046)
                {
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        //IF Posted=TRUE THEN
                        //ERROR('Loan has been posted, Can only preview schedule');

                        if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                            Evaluate(InPeriod, '1D')
                        else
                            if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                                Evaluate(InPeriod, '1W')
                            else
                                if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                                    Evaluate(InPeriod, '1M')
                                else
                                    if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                                        Evaluate(InPeriod, '1Q');


                        QCounter := 0;
                        QCounter := 3;
                        //EVALUATE(InPeriod,'1D');
                        GrPrinciple := Rec."Grace Period - Principle (M)";
                        GrInterest := Rec."Grace Period - Interest (M)";
                        InitialGraceInt := Rec."Grace Period - Interest (M)";

                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", Rec."Loan  No.");
                        if LoansR.Find('-') then begin

                            Rec.TestField("Loan Disbursement Date");
                            Rec.TestField("Repayment Start Date");

                            RSchedule.Reset;
                            RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan  No.");
                            RSchedule.DeleteAll;

                            LoanAmount := LoansR."Approved Amount";
                            InterestRate := LoansR.Interest;
                            RepayPeriod := LoansR.Installments;
                            InitialInstal := LoansR.Installments + Rec."Grace Period - Principle (M)";
                            LBalance := LoansR."Approved Amount";
                            RunDate := Rec."Repayment Start Date";//"Loan Disbursement Date";
                                                              //RunDate:=CALCDATE('-1W',RunDate);
                            InstalNo := 0;
                            //EVALUATE(RepayInterval,'1W');
                            //EVALUATE(RepayInterval,InPeriod);

                            //Repayment Frequency
                            if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                                RunDate := CalcDate('-1D', RunDate)
                            else
                                if Rec."Repayment Frequency" =Rec. "repayment frequency"::Weekly then
                                    RunDate := CalcDate('-1W', RunDate)
                                else
                                    if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                                        RunDate := CalcDate('-1M', RunDate)
                                    else
                                        if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                                            RunDate := CalcDate('-1Q', RunDate);
                            //Repayment Frequency


                            repeat
                                InstalNo := InstalNo + 1;
                                //RunDate:=CALCDATE("Instalment Period",RunDate);
                                //RunDate:=CALCDATE('1W',RunDate);


                                //Repayment Frequency
                                if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                                    RunDate := CalcDate('1D', RunDate)
                                else
                                    if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                                        RunDate := CalcDate('1W', RunDate)
                                    else
                                        if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                                            RunDate := CalcDate('1M', RunDate)
                                        else
                                            if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                                                RunDate := CalcDate('1Q', RunDate);
                                //Repayment Frequency

                                //kma
                                if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin
                                    Rec.TestField(Interest);
                                    Rec.TestField(Installments);
                                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.05, '>');
                                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                                    LPrincipal := TotalMRepay - LInterest;
                                end;

                                if Rec."Repayment Method" = Rec."repayment method"::"Straight Line" then begin
                                    Rec.TestField(Interest);
                                    Rec.TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 0.05, '>');
                                    //Grace Period Interest
                                    LInterest := ROUND((LInterest * InitialInstal) / (InitialInstal - InitialGraceInt), 0.05, '>');
                                end;

                                if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                                    Rec.TestField(Interest);
                                    Rec.TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                                end;

                                if Rec."Repayment Method" = Rec."repayment method"::Constants then begin
                                    Rec.TestField(Repayment);
                                    if LBalance <Rec. Repayment then
                                        LPrincipal := LBalance
                                    else
                                        LPrincipal := Rec.Repayment;
                                    LInterest := Rec.Interest;
                                end;
                                //kma



                                //Grace Period
                                if GrPrinciple > 0 then begin
                                    LPrincipal := 0
                                end else begin
                                    //IF "Instalment Period" <> InPeriod THEN
                                    LBalance := LBalance - LPrincipal;

                                end;

                                if GrInterest > 0 then
                                    LInterest := 0;

                                GrPrinciple := GrPrinciple - 1;
                                GrInterest := GrInterest - 1;
                                //Grace Period
                                /*
                               //Q Principle
                               IF "Instalment Period" = InPeriod THEN BEGIN
                               //ADDED
                               IF GrPrinciple <> 0 THEN
                               GrPrinciple:=GrPrinciple-1;
                               IF QCounter = 1 THEN BEGIN
                               QCounter:=3;
                               LPrincipal:=QPrinciple+LPrincipal;
                               IF LPrincipal > LBalance THEN
                               LPrincipal:=LBalance;
                               LBalance:=LBalance-LPrincipal;
                               QPrinciple:=0;
                               END ELSE BEGIN
                               QCounter:=QCounter - 1;
                               QPrinciple:=QPrinciple+LPrincipal;
                               //IF QPrinciple > LBalance THEN
                               //QPrinciple:=LBalance;
                               LPrincipal:=0;
                               END

                               END;
                               //Q Principle
                                */

                                Evaluate(RepayCode, Format(InstalNo));
                                /*
                               WhichDay:=DATE2DWY(RunDate,1);
                               IF WhichDay=6 THEN
                                RunDate:=RunDate+2
                               ELSE IF WhichDay=7 THEN
                                RunDate:=RunDate+1;
                               */
                                //MESSAGE('which day is %1',WhichDay);



                                RSchedule.Init;
                                RSchedule."Repayment Code" := RepayCode;
                                RSchedule."Loan No." :=Rec."Loan  No.";
                                RSchedule."Loan Amount" := LoanAmount;
                                RSchedule."Instalment No" := InstalNo;
                                RSchedule."Repayment Date" := RunDate;
                                RSchedule."Member No." :=Rec."Client Code";
                                RSchedule."Loan Category" :=Rec."Loan Product Type";
                                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                                RSchedule."Monthly Interest" := LInterest;
                                RSchedule."Principal Repayment" := LPrincipal;
                                RSchedule.Insert;
                                //WhichDay:=(DATE2DMY,RSchedule."Repayment Date",1);
                                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                            //MESSAGE('which day is %1',WhichDay);
                            //BEEP(2,10000);
                            until LBalance < 1

                        end;

                        Commit;
                        /*
                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.","Loan  No.");
                        IF LoanApp.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,LoanApp);
                        */

                    end;
                }
                separator(Action1102760048)
                {
                }
                action("Loans Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Top Up';
                    // RunObject = Page "HR Job Requirements";
                    // RunPageLink = "Job ID"=field("Loan  No."),
                    //               "No of Posts"=field("Client Code");
                    Visible = false;
                }
                separator(Action1102760039)
                {
                }
                separator(Action1102755021)
                {
                }
                action(Action1102760062)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark As Posted';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to mark this loan as posted?') = true then begin
                            Rec.Posted := true;
                            Rec.Modify;
                        end;
                    end;
                }
                action("Post Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Posted = true then
                            Error('Loan already posted.');


                        Rec."Loan Disbursement Date" := Today;
                        Rec.TestField("Loan Disbursement Date");
                        Rec."Posting Date" :=Rec."Loan Disbursement Date";


                        if Confirm('Are you sure you want to post this loan?', true) = false then
                            exit;

                        /*//PRORATED DAYS
                        EndMonth:=CALCDATE('-1D',CALCDATE('1M',DMY2DATE(1,DATE2DMY("Posting Date",2),DATE2DMY("Posting Date",3))));
                        RemainingDays:=(EndMonth-"Posting Date")+1;
                        TMonthDays:=DATE2DMY(EndMonth,1);
                        //PRORATED DAYS
                        
                        */
                        if Rec."Mode of Disbursement" = Rec."mode of disbursement"::"FOSA Account" then begin

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                            GenJournalLine.DeleteAll;


                            GenSetUp.Get();

                            DActivity := 'BOSA';
                            DBranch := '';//PKKS'NAIROBI';
                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Loan  No.", Rec."Loan  No.");
                            LoanApps.SetRange(LoanApps."System Created", false);
                            LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                            if LoanApps.Find('-') then begin
                                repeat
                                    LoanApps.CalcFields(LoanApps."Special Loan Amount");
                                    DActivity := '';
                                    DBranch := '';
                                    if Vend.Get(LoanApps."Client Code") then begin
                                        DActivity := Vend."Global Dimension 1 Code";
                                        DBranch := Vend."Global Dimension 2 Code";
                                    end;

                                    LoanDisbAmount := LoanApps."Approved Amount";

                                    if (LoanApps."Special Loan Amount" > 0) and (LoanApps."Bridging Loan Posted" = false) then
                                        Error('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");

                                    TCharges := 0;
                                    TopUpComm := 0;
                                    TotalTopupComm := 0;


                                    if LoanApps."Loan Status" <> LoanApps."loan status"::Disbursed then
                                        Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");

                                    if LoanApps.Posted = true then
                                        Error('Loan has already been posted. - ' + LoanApps."Loan  No.");


                                    LoanApps.CalcFields(LoanApps."Loan Offset Amount");


                                    RunningDate :=Rec."Posting Date";


                                    //Generate and post Approved Loan Amount
                                    if not GenBatch.Get('PAYMENTS', 'LOANS') then begin
                                        GenBatch.Init;
                                        GenBatch."Journal Template Name" := 'PAYMENTS';
                                        GenBatch.Name := 'LOANS';
                                        GenBatch.Insert;
                                    end;

                                    PCharges.Reset;
                                    PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                                    if PCharges.Find('-') then begin
                                        repeat
                                            PCharges.TestField(PCharges."G/L Account");

                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Account No." := PCharges."G/L Account";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Document No." :=Rec."Loan  No.";
                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                            GenJournalLine."Posting Date" :=Rec."Posting Date";
                                            GenJournalLine.Description := PCharges.Description;
                                            if PCharges."Use Perc" = true then begin
                                                GenJournalLine.Amount := (LoanDisbAmount * PCharges.Percentage / 100) * -1;
                                            end else begin
                                                GenJournalLine.Amount := PCharges.Amount * -1;

                                            end;


                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            //Don't top up charges on principle
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                                            GenJournalLine."Bal. Account No." := LoanApps."Account No";
                                            //Don't top up charges on principle
                                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;

                                            TCharges := TCharges + (GenJournalLine.Amount * -1);


                                        until PCharges.Next = 0;
                                    end;




                                    //Don't top up charges on principle
                                    TCharges := 0;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                    GenJournalLine."Account No." :=Rec."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." :=Rec."Loan  No.";
                                    GenJournalLine."External Document No." :=Rec."ID NO";
                                    GenJournalLine."Posting Date" :=Rec."Posting Date";
                                    GenJournalLine.Description := 'Principal Amount';
                                    GenJournalLine.Amount := LoanDisbAmount + TCharges;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;




                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                        if LoanApps."Loan Offset Amount" > 0 then begin
                                            LoanTopUp.Reset;
                                            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                                            if LoanTopUp.Find('-') then begin
                                                repeat
                                                    //Principle
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." :=Rec."Loan  No.";
                                                    GenJournalLine."Posting Date" :=Rec."Posting Date";
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                                    GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                    //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                    //Principle
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." :=Rec."Loan  No.";
                                                    GenJournalLine."Posting Date" :=Rec."Posting Date";
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                    GenJournalLine."Account No." := LoanApps."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                                    GenJournalLine.Amount := LoanTopUp."Principle Top Up";
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                    //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;


                                                    //Interest (Reversed if top up)
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                                        GenJournalLine."Account No." := LoanApps."Client Code";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                                        GenJournalLine."Document No." :=Rec."Loan  No.";
                                                        GenJournalLine."Posting Date" :=Rec."Posting Date";
                                                        GenJournalLine.Description := 'Interest paid ' + LoanApps."Loan  No.";
                                                        GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                        // GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;


                                                    end;
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                                        GenJournalLine."Document No." :=Rec."Loan  No.";
                                                        GenJournalLine."Posting Date" :=Rec."Posting Date";
                                                        GenJournalLine.Description := 'Interest paid ' + LoanApps."Loan  No.";
                                                        GenJournalLine.Amount := LoanTopUp."Interest Top Up";
                                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                        GenJournalLine."Account No." := LoanApps."Account No";
                                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                        // GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;


                                                    end;

                                                    //Commision
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        if LoanType."Top Up Commision" > 0 then begin
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                            GenJournalLine."Account No." := LoanApps."Account No";

                                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                            GenJournalLine."Bal. Account No." := LoanType."Top Up Commision Account";
                                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                                            GenJournalLine."Document No." :=Rec."Loan  No.";
                                                            GenJournalLine."Posting Date" :=Rec."Posting Date";
                                                            GenJournalLine.Description := 'Commision on Loan Top Up';
                                                            TopUpComm := (LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision" / 100);
                                                            TotalTopupComm := TotalTopupComm + TopUpComm;
                                                            GenJournalLine.Amount := TopUpComm * -1;
                                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;

                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;

                                                        end;
                                                    end;
                                                until LoanTopUp.Next = 0;
                                            end;
                                        end;
                                    end;

                                    BatchTopUpAmount := BatchTopUpAmount + LoanApps."Loan Offset Amount";
                                    BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
                                until LoanApps.Next = 0;
                            end;

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." :=Rec."Loan  No.";
                            GenJournalLine."External Document No." :=Rec."ID NO";
                            GenJournalLine."Posting Date" :=Rec."Posting Date";
                            GenJournalLine.Description := 'Principal Amount';
                            GenJournalLine.Amount := (LoanApps."Approved Amount") * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;



                        if Rec."Mode of Disbursement" = Rec."mode of disbursement"::Mpesa then begin

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                            GenJournalLine.DeleteAll;


                            GenSetUp.Get();

                            DActivity := 'BOSA';
                            DBranch := '';//PKKS'NAIROBI';
                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Loan  No.", Rec."Loan  No.");
                            LoanApps.SetRange(LoanApps."System Created", false);
                            LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                            if LoanApps.Find('-') then begin
                                repeat
                                    LoanApps.CalcFields(LoanApps."Special Loan Amount");



                                    DActivity := '';
                                    DBranch := '';
                                    if Vend.Get(LoanApps."Client Code") then begin
                                        DActivity := Vend."Global Dimension 1 Code";
                                        DBranch := Vend."Global Dimension 2 Code";
                                    end;



                                    LoanDisbAmount := LoanApps."Approved Amount";

                                    if (LoanApps."Special Loan Amount" > 0) and (LoanApps."Bridging Loan Posted" = false) then
                                        Error('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");

                                    TCharges := 0;
                                    TopUpComm := 0;
                                    TotalTopupComm := 0;


                                    if LoanApps."Loan Status" <> LoanApps."loan status"::Disbursed then
                                        Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");

                                    if LoanApps.Posted = true then
                                        Error('Loan has already been posted. - ' + LoanApps."Loan  No.");


                                    LoanApps.CalcFields(LoanApps."Loan Offset Amount");


                                    RunningDate :=Rec."Posting Date";


                                    //Generate and post Approved Loan Amount
                                    if not GenBatch.Get('PAYMENTS', 'LOANS') then begin
                                        GenBatch.Init;
                                        GenBatch."Journal Template Name" := 'PAYMENTS';
                                        GenBatch.Name := 'LOANS';
                                        GenBatch.Insert;
                                    end;

                                    PCharges.Reset;
                                    PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                                    if PCharges.Find('-') then begin
                                        repeat
                                            PCharges.TestField(PCharges."G/L Account");

                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Account No." := PCharges."G/L Account";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Document No." :=Rec."Loan  No.";
                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                            GenJournalLine."Posting Date" :=Rec."Posting Date";
                                            GenJournalLine.Description := PCharges.Description;
                                            if PCharges."Use Perc" = true then begin
                                                GenJournalLine.Amount := (LoanDisbAmount * PCharges.Percentage / 100) * -1;
                                            end else begin
                                                GenJournalLine.Amount := PCharges.Amount * -1;

                                            end;


                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            //Don't top up charges on principle
                                            //Don't top up charges on principle
                                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;

                                            TCharges := TCharges + (GenJournalLine.Amount * -1);


                                        until PCharges.Next = 0;
                                    end;




                                    //Don't top up charges on principle
                                    TCharges := 0;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                    GenJournalLine."Account No." :=Rec."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." :=Rec."Loan  No.";
                                    GenJournalLine."External Document No." :=Rec."ID NO";
                                    GenJournalLine."Posting Date" :=Rec."Posting Date";
                                    GenJournalLine.Description := 'Principal Amount';
                                    GenJournalLine.Amount := LoanDisbAmount + TCharges;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;




                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                        if LoanApps."Loan Offset Amount" > 0 then begin
                                            LoanTopUp.Reset;
                                            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                                            if LoanTopUp.Find('-') then begin
                                                repeat
                                                    //Principle
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." :=Rec."Loan  No.";
                                                    GenJournalLine."Posting Date" :=Rec."Posting Date";
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                                    GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                    //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;


                                                    //Interest (Reversed if top up)
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                                        GenJournalLine."Account No." := LoanApps."Client Code";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                                        GenJournalLine."Document No." :=Rec."Loan  No.";
                                                        GenJournalLine."Posting Date" :=Rec."Posting Date";
                                                        GenJournalLine.Description := 'Interestpaid ' + LoanApps."Loan  No.";
                                                        GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                                        //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                                        //GenJournalLine."Bal. Account No.":=LoanType."Receivable Interest Account";
                                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                        // GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;


                                                    end;

                                                    //Commision
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        if LoanType."Top Up Commision" > 0 then begin
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                            GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                                            GenJournalLine."Document No." :=Rec."Loan  No.";
                                                            GenJournalLine."Posting Date" :=Rec."Posting Date";
                                                            GenJournalLine.Description := 'Commision on Loan Top Up';
                                                            TopUpComm := (LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision" / 100);
                                                            TotalTopupComm := TotalTopupComm + TopUpComm;
                                                            GenJournalLine.Amount := TopUpComm * -1;
                                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                            //GenJournalLine."Bal. Account No.":=LoanApps."Account No";

                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;

                                                        end;
                                                    end;
                                                until LoanTopUp.Next = 0;
                                            end;
                                        end;
                                    end;

                                    BatchTopUpAmount := BatchTopUpAmount + LoanApps."Loan Offset Amount";
                                    BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
                                until LoanApps.Next = 0;
                            end;

                            LineNo := LineNo + 10000;
                            /*Disbursement.RESET;
                            Disbursement.SETRANGE(Disbursement."Loan Number","Loan  No.");
                            Disbursement.SETRANGE(Disbursement."Disbursement Date","Loan Disbursement Date");
                            IF Disbursement.FIND('-') THEN BEGIN
                            REPEAT
                            Disbursement.Posted:=TRUE;
                            Disbursement.MODIFY;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=Disbursement."Disbursement Account Type";
                            GenJournalLine."Account No.":=Disbursement."Disbursement Account No.";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."External Document No.":="ID NO";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Principal Amount';
                            GenJournalLine.Amount:=((LoanApps."Approved Amount")-(BatchTopUpAmount+BatchTopUpComm+TCharges))*-1;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                            UNTIL Disbursement.NEXT=0;
                            END;*/
                        end;


                        /*
                        //Post New
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PAYMENTS');
                        GenJournalLine.SETRANGE("Journal Batch Name",'LOANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        END;
                        */
                        //Post New

                        Rec.Posted := true;
                        Rec.Modify;



                        Message('Loan posted successfully.');

                        //Post

                        LoanAppPermisions()
                        //CurrForm.EDITABLE:=TRUE;
                        //end;

                    end;
                }
                separator(Action1102755023)
                {
                }
                action("Salary Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Details';
                    RunObject = Page "HR Jobs Factbox";
                    RunPageLink = "Job ID" = field("Client Code");
                    Visible = false;
                }
                action("Loan Securities")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Securities';
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = field("Loan  No.");
                    ShortCutKey = 'Shift+Ctrl+L';
                }
                action(Guarantors)
                {
                    ApplicationArea = Basic;
                    Caption = 'Guarantors';
                    RunObject = Page "HR Employee Kin";
                    RunPageLink = "No." = field("Loan  No.");
                }
                action("ReAppraise Loan Application")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec."Approval Status" = "approval status"::Rejected then begin
                            if Confirm('Are you sure you want to Reappraise this loan?', false) = true then begin

                                ApprovalComment.Reset;
                                ApprovalComment.SetRange(ApprovalComment."Document No.", Rec."Loan  No.");
                                if ApprovalComment.Find('-') then begin
                                    ApprovalComment.Comment := '';
                                    ApprovalComment.Modify;
                                end
                            end;
                            Rec."Loan Status" :=Rec."loan status"::Application;
                            Rec."Approval Status" :=Rec."approval status"::Open;
                            Rec.Modify
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // OnAfterGetCurrRecords;

        RejectionVisible := false;

        if Rec."Intent to Reject" = true then begin
            RejectionVisible := true;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Source := Rec.Source::" ";
        //OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        RejectionVisible := false;

        if Rec."Intent to Reject" = true then begin
            RejectionVisible := true;
        end;
    end;

    var
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
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
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sales & Receivables Setup";
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
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
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
        SMSMessage: Record Customer;
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
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
        ApprovalComment: Record "Approval Comment Line";
        RejectionVisible: Boolean;


    procedure LoanAppPermisions()
    begin

        //CurrForm.EDITABLE:=TRUE;
        /*
        IF "Batch No." <> '' THEN BEGIN
        MovementTracker.RESET;
        MovementTracker.SETCURRENTKEY(MovementTracker."Document No.");
        MovementTracker.SETRANGE(MovementTracker."Document No.","Batch No.");
        IF MovementTracker.FIND('+') THEN BEGIN
        IF (MovementTracker.Station <> 'LOANS OFFICE') AND (MovementTracker.Station <> 'REGISTRY')
           AND (MovementTracker.Station <> 'ELD') AND (MovementTracker.Station <> 'PERSONAL LOANS')
           AND (MovementTracker.Station <> 'KCB - (PERSONAL LOANS)') THEN
        ERROR('You dont have permisions to modify loan applications.')//CurrForm.EDITABLE:=FALSE
        ELSE BEGIN
        ApprovalUsers.RESET;
        ApprovalUsers.SETRANGE(ApprovalUsers."Approval Type",MovementTracker."Approval Type");
        ApprovalUsers.SETRANGE(ApprovalUsers.Stage,MovementTracker.Stage);
        ApprovalUsers.SETRANGE(ApprovalUsers."User ID",USERID);
        IF ApprovalUsers.FIND('-') THEN BEGIN
        CurrForm.EDITABLE:=TRUE;
        END ELSE BEGIN
        ERROR('You dont have permisions to modify a loan application that is out of your desk.')//CurrForm.EDITABLE:=FALSE;
        
        END;
        END;
        END;
        END;
        */

    end;

    local procedure ClientCodeOnAfterValidate()
    begin
        Rec.TestField(Posted, false);
    end;

    local procedure OnAfterGetCurrentRecord()
    begin
        xRec := Rec;


        DiscountingAmount := 0;

        /*
        SpecialComm:=0;
        IF "Special Loan Amount" + "Other Commitments Clearance" > 0 THEN
        SpecialComm:=("Special Loan Amount"+"Other Commitments Clearance")*0.05;
        */

        //Special Commision
        SpecialComm := 0;
        BridgedLoans.Reset;
        BridgedLoans.SetCurrentkey(BridgedLoans."Loan No.");
        BridgedLoans.SetRange(BridgedLoans."Loan No.", Rec."Loan  No.");
        if BridgedLoans.Find('-') then begin
            repeat
                if BridgedLoans.Source = BridgedLoans.Source::FOSA then begin
                    if BridgedLoans."Loan Type" = 'SUPER' then
                        SpecialComm := SpecialComm + (BridgedLoans."Total Off Set" * 0.1)
                    else
                        SpecialComm := SpecialComm + (BridgedLoans."Total Off Set" * 0.1);
                end else begin
                    SpecialComm := SpecialComm + (BridgedLoans."Total Off Set" * 0.1);
                end;
            until BridgedLoans.Next = 0;
        end;



        /*IDNo:='';
        FOSAName:='';
        IF Cust.GET("Client Code") THEN BEGIN
        IDNo:=Cust."ID No.";
        IF Vend.GET("Account No") THEN BEGIN
        FOSAName:=Vend.Name;
        END;
        END; */

        //LoanAppPermisions();

    end;

    local procedure OtherCommitmentsClearanceOnDea()
    begin
        CurrPage.Update := true;
    end;
}




