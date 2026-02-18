
Report 50051 "FOA DEFAULTED"
{
    RDLCLayout = './Layouts/FOA DEFAULTED.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where("Loan Product Type" = filter(= 'INSTANT'), Posted = const(true), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan  No.", "Loan Product Type", "Date filter";
            column(ReportForNavId_4645; 4645) { }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(UserId; UserId)
            {
            }
            column(Loans__Loan__No__; "Loan  No.")
            {
            }
            column(Loans__Loan_Product_Type_; "Loan Product Type")
            {
            }
            column(Loans__Client_Code_; "Client Code")
            {
            }
            column(Loans__Client_Name_; "Client Name")
            {
                AutoCalcField = true;
                IncludeCaption = false;
            }
            column(Loans__Outstanding_Balance_; "Outstanding Balance")
            {
            }
            column(Loans__Schedule_Repayments_; "Schedule Repayments")
            {
            }
            column(Loans__Loan_Repayment_; "Loan Repayment")
            {
            }
            column(Schedule_Repayments___Loan_Repayment_; "Schedule Repayments" + "Loan Repayment")
            {
            }
            column(LoansCaption; LoansCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loans__Loan_Product_Type_Caption; FieldCaption("Loan Product Type"))
            {
            }
            column(Loans__Client_Code_Caption; FieldCaption("Client Code"))
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Loans__Outstanding_Balance_Caption; FieldCaption("Outstanding Balance"))
            {
            }
            column(Loans__Schedule_Repayments_Caption; FieldCaption("Schedule Repayments"))
            {
            }
            column(Loans__Loan_Repayment_Caption; FieldCaption("Loan Repayment"))
            {
            }
            column(VarienceCaption; VarienceCaptionLbl)
            {
            }
            trigger OnPreDataItem();
            begin
                Gnljnline.Reset;
                Gnljnline.SetRange(Gnljnline."Journal Template Name", 'GENERAL');
                Gnljnline.SetRange(Gnljnline."Journal Batch Name", 'OverDue');
                if Gnljnline.Find('-') then
                    Gnljnline.DeleteAll;
                CurrDate := PDate;
            end;

            trigger OnAfterGetRecord();
            begin
                TotaliNterest := 0;
                PenaltyDue := 0;
                Repayment1.Reset;
                Repayment1.SetRange(Repayment1."Loan No.", "Loan  No.");
                Repayment1.SetRange(Repayment1."Member No.", "Client Code");
                if Repayment1.Find('-') then begin
                    repeat
                        TotaliNterest := TotaliNterest + Repayment1."Monthly Interest";
                    until Repayment1.Next = 0;

                end;
                CurrDate := PDate;
                if "Loans Register"."Issued Date" = 0D then
                    CurrReport.Skip;
                Months2 := Date2dmy("Loans Register"."Issued Date", 2);
                Months1 := Date2dmy(CurrDate, 2);
                Months := ROUND((CurrDate - "Loans Register"."Issued Date") / 31, 1.0, '>');
                if "Loans Register"."Expected Date of Completion" = 0D then
                    CurrReport.Skip;

                if Months > 9 then begin
                    "Loans Register".CalcFields("Loans Register"."Outstanding Balance", "Loans Register"."Outstanding Interest", "Loans Register"."Interest Paid", "Current Penalty Due");
                    if "Loans Register"."Outstanding Balance" > 0 then begin


                        LoanNo := '';


                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Client Code", "Loans Register"."Client Code");
                        LoansR.SetRange(LoansR."Loan  No.", "Loans Register"."Loan  No.");
                        LoansR.SetFilter(LoansR."Loan Product Type", '%1', 'INSTANT');

                        if LoansR.Find('-') then begin
                            repeat
                                LoanNo := NoSeriesManagement.GetNextNo('DEFAULT', Today, true);
                                Loans.Init;
                                Loans."Loan  No." := LoanNo;
                                Loans.Source := Loans.Source::BOSA;
                                Loans."Client Code" := "Loans Register"."Client Code";
                                Loans."Client Name" := "Loans Register"."Client Name";
                                Loans."Staff No" := "Loans Register"."Staff No";
                                Loans."Loan Product Type" := 'OVERDUE-INSTANT';
                                Loans."Issued Date" := PDate;
                                Loans."Application Date" := CurrDate;
                                if LoanType.Get('OVERDUE-INSTANT') then begin
                                    Loans.Installments := LoanType."Default Installements";
                                    Loans.Interest := LoanType."Interest rate";
                                end;

                                Loans."Requested Amount" := "Loans Register"."Requested Amount";
                                Loans."Approved Amount" := "Loans Register"."Approved Amount";
                                Loans."Loan Status" := Loans."loan status"::Approved;
                                Loans."Issued Date" := CurrDate;
                                Loans."Loan Disbursement Date" := CurrDate;
                                Loans."Repayment Frequency" := Loans."Repayment Frequency"::Monthly;
                                Loans."Repayment Start Date" := CurrDate;
                                Loans."Batch No." := "Loans Register"."Batch No.";
                                Loans."BOSA No" := "Loans Register"."Client Code";
                                Loans."Recovered Loan" := "Loans Register"."Loan  No.";
                                Loans.Insert(true);
                                //================================================Insert Guarantors
                                //================================================End Insert Guarantors
                                Loans.Reset;
                                Loans.SetRange(Loans."Client Code", "Loans Register"."Client Code");
                                Loans.SetRange(Loans."Loan Product Type", 'OVERDUE-INSTANT');
                                Loans.SetRange(Loans.Posted, false);
                                Loans.SetAutoCalcFields("Current Penalty Due");
                                if Loans.Find('-') then begin
                                    if Loans."Current Penalty Due" > 0 then begin
                                        PenaltyDue := Loans."Current Penalty Due";
                                    end else begin
                                        PenaltyDue := 0;
                                    end;


                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'OverDue';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := 'OverDue';
                                    GenJournalLine."Posting Date" := CurrDate;
                                    GenJournalLine."External Document No." := LoansR."Loan  No.";
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                    GenJournalLine."Account No." := LoansR."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'Principle Amount';
                                    GenJournalLine.Amount := ("Outstanding Balance");
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                                    GenJournalLine."Loan No" := Loans."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := LoansR."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoansR."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'OverDue';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := 'OverDue';
                                    GenJournalLine."Posting Date" := CurrDate;
                                    GenJournalLine."External Document No." := LoansR."Loan  No.";
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                    GenJournalLine."Account No." := LoansR."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'Outstanding Interest';
                                    GenJournalLine.Amount := "Outstanding Interest" + "Current Penalty Due";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                                    GenJournalLine."Loan No" := Loans."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := LoansR."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoansR."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    ObjLoansGuarantors.Reset;
                                    ObjLoansGuarantors.SetRange(ObjLoansGuarantors."Loan No", LoansR."Loan  No.");
                                    if ObjLoansGuarantors.Find('-') then begin
                                        repeat
                                            bal := ObjLoansGuarantors."Loan Balance";
                                            share := ObjLoansGuarantors.Shares;
                                            mno := ObjLoansGuarantors."Member No";
                                            name := ObjLoansGuarantors.Name;
                                            SelfG := ObjLoansGuarantors."Self Guarantee";
                                            AmontG := ObjLoansGuarantors."Amont Guaranteed";
                                            GuarantorshipLiability := ObjLoansGuarantors."Total Loans Guaranteed";
                                            //freeShare :=ObjLoansGuarantors."Shares Recovery";
                                            LineNo := LineNo + 10000;
                                            ObjLoansGuarantor.Init;
                                            ObjLoansGuarantor."Loan No" := Loans."Loan  No.";
                                            ObjLoansGuarantor."Member No" := ObjLoansGuarantors."Member No";
                                            ObjLoansGuarantor.Name := name;
                                            ObjLoansGuarantor."Loan Balance" := bal;
                                            ObjLoansGuarantor.Shares := share;
                                            ObjLoansGuarantor."Self Guarantee" := SelfG;
                                            ObjLoansGuarantor."Amont Guaranteed" := AmontG;
                                            ObjLoansGuarantor."Total Loans Guaranteed" := GuarantorshipLiability;
                                            //ObjLoansGuarantor."Shares Recovery" :=freeShare;
                                            if ObjLoansGuarantor."Member No" <> '' then
                                                if not ObjLoansGuarantor.Insert(true) then
                                                    ObjLoansGuarantor.Modify(true);
                                        until ObjLoansGuarantors.Next = 0;
                                    end;
                                    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                    Loans.Posted := true;
                                    Loans.Modify;
                                    //Off Set BOSA Loans
                                    //Principle
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'OverDue';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := 'OverDue';
                                    GenJournalLine."Posting Date" := CurrDate;
                                    GenJournalLine."External Document No." := Loans."Loan  No.";
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                    GenJournalLine."Account No." := LoansR."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'Defaulted INSTANT loan: ' + Loans."Loan  No.";
                                    GenJournalLine.Amount := -("Outstanding Balance");
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                    GenJournalLine."Loan No" := LoansR."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := LoansR."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoansR."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                    //Interest
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'OverDue';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := 'OverDue';
                                    GenJournalLine."Posting Date" := CurrDate;
                                    GenJournalLine."External Document No." := Loans."Loan  No.";
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                    GenJournalLine."Account No." := LoansR."Client Code";
                                    //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'Cleared by INSTANT loan: ' + Loans."Loan  No.";
                                    GenJournalLine.Amount := -("Outstanding Interest");
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                    GenJournalLine."Loan No" := LoansR."Loan  No.";
                                    //message('new l %1',LoansR."Loan  No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := LoansR."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoansR."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;


                                    //pay penalty
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'OverDue';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := 'OverDue';
                                    GenJournalLine."Posting Date" := CurrDate;
                                    GenJournalLine."External Document No." := Loans."Loan  No.";
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                    GenJournalLine."Account No." := LoansR."Client Code";
                                    GenJournalLine.Description := 'Cleared by INSTANT loan: ' + Loans."Loan  No.";
                                    GenJournalLine.Amount := -("Current Penalty Due");
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Penalty Paid";
                                    GenJournalLine."Loan No" := LoansR."Loan  No.";
                                    //message('new l %1',LoansR."Loan  No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := LoansR."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoansR."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                    LoansR.Advice := true;
                                    LoansR.Modify;
                                end;
                            until LoansR.Next = 0;
                        end;
                    end;
                    "Loans Register".Defaulted := true;
                    "Loans Register".Defaulter := true;
                    "Loans Register".DefaulterInfo := 'INSTANT NON PAYMENTS';
                    "Loans Register"."Loans Category" := "Loans Register"."loans category"::Loss;
                end;


            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field("Doc No"; DocNo)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; PDate)
                {
                    ApplicationArea = Basic;
                }

            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin


    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

    end;

    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        LoanType: Record "Loan Products Setup";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        LoansCaptionLbl: label 'OverDue';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        VarienceCaptionLbl: label 'Varience';
        CurrDate: Date;
        Months: Integer;
        DateFilt: Date;
        Repayment1: Record "Loan Repayment Schedule";
        TotaliNterest: Decimal;
        Months1: Decimal;
        Months2: Decimal;
        Loans: Record "Loans Register";
        LoansR: Record "Loans Register";
        PenaltyDue: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        InterestDue: Decimal;
        ObjLoansGuarantors: Record "Loans Guarantee Details";
        bal: Decimal;
        share: Decimal;
        mno: Code[10];
        name: Text;
        ObjLoansGuarantor: Record "Loans Guarantee Details";
        SelfG: Boolean;
        AmontG: Decimal;
        GuarantorshipLiability: Decimal;
        freeShare: Decimal;
        LoanNo: Code[20];

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var



    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
