
Report 80050 "Generate Penalties"
{
    RDLCLayout = './Layouts/Generate Penalties.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where("Loan Product Type" = filter('INSTANT'), "Outstanding Balance" = filter(> 0));
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
                Gnljnline.SetRange(Gnljnline."Journal Batch Name", 'PENALTY');
                if Gnljnline.Find('-') then
                    Gnljnline.DeleteAll;
                CurrDate := PDate;
            end;

            trigger OnAfterGetRecord();
            var
                InterestCharged: Decimal;
                Penalty: Integer;
            begin
                OutBal := 0;
                InterestDueP := 0;
                TotaliNterest := 0;
                INTERESTPAID := 0;
                InterestCharged := 0;
                TenPercent := 0;
                CheckAmount := 0;
                InteretP := 0;
                CompletionDate := 0D;
                ToatlPaidAmount := 0;
                principlePaid := 0;
                if PDate = 0D then PDate := Today;
                Repayment1.Reset;
                "Loans Register".CalcFields("Loans Register"."Outstanding Balance", "Loans Register"."Outstanding Interest", "Loans Register"."Interest Paid");
                "Loans Register".SetFilter("Issued Date", '..%1', PDate);
                if "Loans Register"."Outstanding Interest" > 0 then begin
                    if "Loans Register"."Outstanding Balance" > 0 then begin
                        VARDATE := CalcDate('93D', "Loans Register"."Issued Date");


                        InterestCharged := "Loans Register"."Approved Amount" * 0.1;

                        DateFilter := '..' + Format(VARDATE);
                        DetailedLedger.Reset;
                        DetailedLedger.SetRange(DetailedLedger."Transaction Type", DetailedLedger."transaction type"::"Interest Paid");
                        DetailedLedger.SetRange(DetailedLedger."Loan No", "Loans Register"."Loan  No.");
                        DetailedLedger.SetRange(DetailedLedger."Customer No.", "Loans Register"."Client Code");
                        DetailedLedger.SetFilter(DetailedLedger."Posting Date", DateFilter);
                        if DetailedLedger.FindSet then begin
                            DetailedLedger.CalcSums("Credit Amount");
                            INTERESTPAID := INTERESTPAID + DetailedLedger."Credit Amount";
                        end;
                        DetailedLedger.Reset;
                        DetailedLedger.SetRange(DetailedLedger."Transaction Type", DetailedLedger."transaction type"::Repayment);
                        DetailedLedger.SetRange(DetailedLedger."Loan No", "Loans Register"."Loan  No.");
                        DetailedLedger.SetRange(DetailedLedger."Customer No.", "Loans Register"."Client Code");
                        DetailedLedger.SetFilter(DetailedLedger."Posting Date", DateFilter);
                        if DetailedLedger.FindSet then begin
                            DetailedLedger.CalcSums("Credit Amount");
                            principlePaid := principlePaid + DetailedLedger."Credit Amount";
                        end;
                        ToatlPaidAmount := ToatlPaidAmount + principlePaid + INTERESTPAID;

                        if ToatlPaidAmount >= InterestCharged then CurrReport.Skip();

                        CompletionDate := CalcDate('93D', "Loans Register"."Issued Date");
                        OutBal := ("Loans Register"."Approved Amount" - "Loans Register"."Outstanding Balance");
                        TenPercent := 100 - ("Loans Register"."Outstanding Balance" / "Loans Register"."Approved Amount" * 100);
                        VarInt := ROUND((OutBal / "Loans Register"."Approved Amount") * 100, 1.0, '>');


                        //if CompletionDate > PDate then
                        // CurrReport.Skip();
                        begin
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
                            Months := CurrDate - "Loans Register"."Issued Date";

                            if "Loans Register".Extended = false then begin
                                if Months = 91 then begin
                                    //if Months < 6 then begin
                                    DetailedLedger.Reset;
                                    DetailedLedger.SetRange(DetailedLedger."Transaction Type", DetailedLedger."transaction type"::"Penalty Charged");
                                    DetailedLedger.SetRange(DetailedLedger."Loan No", "Loans Register"."Loan  No.");
                                    DetailedLedger.SetRange(DetailedLedger."Customer No.", "Loans Register"."Client Code");
                                    if DetailedLedger.Find('-') = false then begin

                                        LoanType.Get("Loans Register"."Loan Product Type");
                                        if LoanType.Get("Loans Register"."Loan Product Type") then begin
                                            DocNo := 'Pen ' + "Loans Register"."Loan  No.";
                                            LineNo := LineNo + 10000;
                                            Gnljnline.Init;
                                            Gnljnline."Journal Template Name" := 'GENERAL';
                                            Gnljnline."Journal Batch Name" := 'PENALTY';
                                            Gnljnline."Line No." := LineNo;
                                            Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                                            Gnljnline."Account No." := "Loans Register"."Client Code";
                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Penalty Charged";
                                            Gnljnline.Validate(Gnljnline."Account No.");
                                            Gnljnline."Document No." := DocNo;
                                            Gnljnline."Posting Date" := PDate;
                                            Gnljnline.Description := 'Late Payment Penalty-INSTANT';
                                            InterestDueP := "Loans Register"."Approved Amount" * 0.1;

                                            Gnljnline.Amount := ROUND(("Loans Register"."Outstanding Balance" + InterestDueP) * (LoanType."Penalty Percentage" / 100), 0.05, '>');

                                            Gnljnline.Validate(Gnljnline.Amount);
                                            Gnljnline."Bal. Account Type" := Gnljnline."bal. account type"::"G/L Account";
                                            Gnljnline."Bal. Account No." := LoanType."Penalty Paid Account";
                                            Gnljnline.Validate(Gnljnline."Bal. Account No.");
                                            Gnljnline."Loan No" := "Loans Register"."Loan  No.";
                                            if Gnljnline.Amount <> 0 then
                                                Gnljnline.Insert;
                                            "Loans Register"."FOA Penalty Charged" := true;
                                            "Loans Register"."FOA Penalty Date" := CurrDate;
                                            "Loans Register"."Extended Reason" := "Loans Register"."extended reason"::"Non-payment";
                                            "Loans Register"."Extension Description" := 'Late Payment Penalty-INSTANT';

                                            "Loans Register".Modify;
                                        end;
                                    end;
                                    //end;
                                end;
                            end;
                            if Months = 181 then begin
                                // //if Months < 6 then begin
                                DetailedLedger.Reset;
                                DetailedLedger.SetRange(DetailedLedger."Transaction Type", DetailedLedger."transaction type"::"Penalty Charged");
                                DetailedLedger.SetRange(DetailedLedger."Loan No", "Loans Register"."Loan  No.");
                                DetailedLedger.SetRange(DetailedLedger."Customer No.", "Loans Register"."Client Code");
                                if DetailedLedger.Find('-') = true then begin
                                    Penalty := DetailedLedger.Count;
                                end;
                                if Penalty >= 2 then CurrReport.Skip();
                                LoanType.Get("Loans Register"."Loan Product Type");
                                if LoanType.Code = 'INSTANT' then begin
                                    DocNo := 'Pen ' + "Loans Register"."Loan  No.";
                                    LineNo := LineNo + 10000;
                                    Gnljnline.Init;
                                    Gnljnline."Journal Template Name" := 'GENERAL';
                                    Gnljnline."Journal Batch Name" := 'PENALTY';
                                    Gnljnline."Line No." := LineNo;
                                    Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                                    Gnljnline."Account No." := "Loans Register"."Client Code";
                                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Penalty Charged";
                                    Gnljnline.Validate(Gnljnline."Account No.");
                                    Gnljnline."Document No." := DocNo;
                                    Gnljnline."Posting Date" := PDate;
                                    Gnljnline.Description := 'Late Payment Penalty-INSTANT';
                                    InterestDueP := "Loans Register"."Approved Amount" * 0.1;

                                    Gnljnline.Amount := ROUND(("Loans Register"."Outstanding Balance" + InterestDueP) * (LoanType."Penalty Percentage" / 100), 0.05, '>');

                                    Gnljnline.Validate(Gnljnline.Amount);
                                    Gnljnline."Bal. Account Type" := Gnljnline."bal. account type"::"G/L Account";
                                    Gnljnline."Bal. Account No." := LoanType."Penalty Paid Account";
                                    Gnljnline.Validate(Gnljnline."Bal. Account No.");
                                    Gnljnline."Loan No" := "Loans Register"."Loan  No.";
                                    if Gnljnline.Amount <> 0 then
                                        Gnljnline.Insert;
                                    "Loans Register"."FOA Penalty Charged" := true;
                                    "Loans Register"."FOA Penalty Date" := CurrDate;
                                    "Loans Register"."Extended Reason" := "Loans Register"."extended reason"::"Non-payment";
                                    "Loans Register"."Extension Description" := 'Late Payment Penalty-INSTANT';

                                    "Loans Register".Modify;
                                    //  end;
                                end;
                                //end;
                            end;

                        end;
                    end;
                end;

            end;

            trigger OnPostDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'PENALTY');
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
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
                    Editable = true;
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


    var
        LoanType: Record "Loan Products Setup";
        Gnljnline: Record "Gen. Journal Line";
        ToatlPaidAmount: Decimal;
        LineNo: Integer;
        principlePaid: Decimal;
        DocNo: Code[20];
        PDate: Date;
        LoansCaptionLbl: label 'Loans';
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
        GenJournalLine: Record "Gen. Journal Line";
        InterestDue: Decimal;
        DetailedLedger: Record "Detailed Cust. Ledg. Entry";
        InterestDueP: Decimal;
        OutBal: Decimal;
        VarInt: Integer;
        VARDATE: Date;
        VARIDATE: Integer;
        VARDATEP: Integer;
        DateFilter: Text;
        INTERESTPAID: Decimal;
        TenPercent: Decimal;

        InteretP: Decimal;
        CheckAmount: Decimal;
        CompletionDate: Date;


}
