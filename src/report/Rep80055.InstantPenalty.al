report 80055 "Instant Penalty"
{

    RDLCLayout = './Layouts/Generate Penalties1.rdlc';
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
                OutstandingInterestFirst3Months: Decimal;
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

                // Calculate fields for outstanding balance and interest
                "Loans Register".CalcFields("Outstanding Balance", "Outstanding Interest", "Interest Paid");
                "Loans Register".SetFilter("Issued Date", '..%1', PDate);

                if "Loans Register"."Outstanding Interest" > 0 then begin
                    if "Loans Register"."Outstanding Balance" > 0 then begin
                        // Calculate the date 3 months from issuance
                        VARDATE := CalcDate('3M', "Loans Register"."Issued Date");

                        // Calculate outstanding interest for the first 3 months
                        OutstandingInterestFirst3Months := 0;
                        Repayment1.Reset;
                        Repayment1.SetRange(Repayment1."Loan No.", "Loan  No.");
                        Repayment1.SetRange(Repayment1."Member No.", "Client Code");
                        Repayment1.SetFilter(Repayment1."Repayment Date", '..%1', VARDATE);
                        if Repayment1.FindSet then begin
                            repeat
                                OutstandingInterestFirst3Months += Repayment1."Monthly Interest";
                            until Repayment1.Next = 0;
                        end;

                        // Calculate interest paid within the first 3 months
                        DateFilter := '..' + Format(VARDATE);
                        DetailedLedger.Reset;
                        DetailedLedger.SetRange(DetailedLedger."Transaction Type", DetailedLedger."Transaction Type"::"Interest Paid");
                        DetailedLedger.SetRange(DetailedLedger."Loan No", "Loans Register"."Loan  No.");
                        DetailedLedger.SetRange(DetailedLedger."Customer No.", "Loans Register"."Client Code");
                        DetailedLedger.SetFilter(DetailedLedger."Posting Date", DateFilter);
                        if DetailedLedger.FindSet then begin
                            DetailedLedger.CalcSums("Credit Amount");
                            INTERESTPAID := DetailedLedger."Credit Amount";
                        end;

                        // Calculate principal paid within the first 3 months
                        DetailedLedger.Reset;
                        DetailedLedger.SetRange(DetailedLedger."Transaction Type", DetailedLedger."Transaction Type"::Repayment);
                        DetailedLedger.SetRange(DetailedLedger."Loan No", "Loans Register"."Loan  No.");
                        DetailedLedger.SetRange(DetailedLedger."Customer No.", "Loans Register"."Client Code");
                        DetailedLedger.SetFilter(DetailedLedger."Posting Date", DateFilter);
                        if DetailedLedger.FindSet then begin
                            DetailedLedger.CalcSums("Credit Amount");
                            principlePaid := DetailedLedger."Credit Amount";
                        end;
                        ToatlPaidAmount := principlePaid + INTERESTPAID;

                        // Check if 10% of the outstanding interest for the first 3 months has been paid
                        InterestCharged := OutstandingInterestFirst3Months * 0.1;
                        if ToatlPaidAmount >= InterestCharged then
                            CurrReport.Skip();

                        // Check if the current date is at least 3 months from issuance (around 91 days)
                        CompletionDate := CalcDate('3M', "Loans Register"."Issued Date");
                        if PDate < CompletionDate then
                            CurrReport.Skip();

                        // Calculate months elapsed
                        Months := PDate - "Loans Register"."Issued Date";

                        if "Loans Register".Extended = false then begin
                            // Check if approximately 3 months (90-92 days) have passed
                            if (Months >= 90) and (Months <= 92) then begin
                                DetailedLedger.Reset;
                                DetailedLedger.SetRange(DetailedLedger."Transaction Type", DetailedLedger."Transaction Type"::"Penalty Charged");
                                DetailedLedger.SetRange(DetailedLedger."Loan No", "Loans Register"."Loan  No.");
                                DetailedLedger.SetRange(DetailedLedger."Customer No.", "Loans Register"."Client Code");
                                if not DetailedLedger.Find('-') then begin
                                    LoanType.Get("Loans Register"."Loan Product Type");
                                    if LoanType.Code = 'INSTANT' then begin
                                        DocNo := 'Pen ' + "Loans Register"."Loan  No.";
                                        LineNo := LineNo + 10000;
                                        Gnljnline.Init;
                                        Gnljnline."Journal Template Name" := 'GENERAL';
                                        Gnljnline."Journal Batch Name" := 'PENALTY';
                                        Gnljnline."Line No." := LineNo;
                                        Gnljnline."Account Type" := Gnljnline."Account Type"::Customer;
                                        Gnljnline."Account No." := "Loans Register"."Client Code";
                                        Gnljnline."Transaction Type" := Gnljnline."Transaction Type"::"Penalty Charged";
                                        Gnljnline.Validate(Gnljnline."Account No.");
                                        Gnljnline."Document No." := DocNo;
                                        Gnljnline."Posting Date" := PDate;
                                        Gnljnline.Description := 'Late Payment Penalty-INSTANT';

                                        // Penalty = 15% of (Approved Amount + Outstanding Interest for first 3 months)
                                        Gnljnline.Amount := ROUND((("Loans Register"."Approved Amount" + OutstandingInterestFirst3Months) * 0.15), 0.05, '>');

                                        Gnljnline.Validate(Gnljnline.Amount);
                                        Gnljnline."Bal. Account Type" := Gnljnline."Bal. Account Type"::"G/L Account";
                                        Gnljnline."Bal. Account No." := LoanType."Penalty Paid Account";
                                        Gnljnline.Validate(Gnljnline."Bal. Account No.");
                                        Gnljnline."Loan No" := "Loans Register"."Loan  No.";
                                        if Gnljnline.Amount <> 0 then
                                            Gnljnline.Insert;
                                        "Loans Register"."FOA Penalty Charged" := true;
                                        "Loans Register"."FOA Penalty Date" := PDate;
                                        "Loans Register"."Extended Reason" := "Loans Register"."Extended Reason"::"Non-payment";
                                        "Loans Register"."Extension Description" := 'Late Payment Penalty-INSTANT';
                                        "Loans Register".Modify;
                                    end;
                                end;
                            end;
                        end;

                        // Handle second penalty at 181 days
                        if (Months >= 180) and (Months <= 182) then begin
                            DetailedLedger.Reset;
                            DetailedLedger.SetRange(DetailedLedger."Transaction Type", DetailedLedger."Transaction Type"::"Penalty Charged");
                            DetailedLedger.SetRange(DetailedLedger."Loan No", "Loans Register"."Loan  No.");
                            DetailedLedger.SetRange(DetailedLedger."Customer No.", "Loans Register"."Client Code");
                            if DetailedLedger.Find('-') then begin
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
                                Gnljnline."Account Type" := Gnljnline."Account Type"::Customer;
                                Gnljnline."Account No." := "Loans Register"."Client Code";
                                Gnljnline."Transaction Type" := Gnljnline."Transaction Type"::"Penalty Charged";
                                Gnljnline.Validate(Gnljnline."Account No.");
                                Gnljnline."Document No." := DocNo;
                                Gnljnline."Posting Date" := PDate;
                                Gnljnline.Description := 'Late Payment Penalty-INSTANT';

                                // Penalty = 15% of (Approved Amount + Outstanding Interest for first 3 months)
                                Gnljnline.Amount := ROUND((("Loans Register"."Approved Amount" + OutstandingInterestFirst3Months) * 0.15), 0.05, '>');

                                Gnljnline.Validate(Gnljnline.Amount);
                                Gnljnline."Bal. Account Type" := Gnljnline."Bal. Account Type"::"G/L Account";
                                Gnljnline."Bal. Account No." := LoanType."Penalty Paid Account";
                                Gnljnline.Validate(Gnljnline."Bal. Account No.");
                                Gnljnline."Loan No" := "Loans Register"."Loan  No.";
                                if Gnljnline.Amount <> 0 then
                                    Gnljnline.Insert;
                                "Loans Register"."FOA Penalty Charged" := true;
                                "Loans Register"."FOA Penalty Date" := PDate;
                                "Loans Register"."Extended Reason" := "Loans Register"."Extended Reason"::"Non-payment";
                                "Loans Register"."Extension Description" := 'Late Payment Penalty-INSTANT';
                                "Loans Register".Modify;
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
        Repayment1: Record "Loan Repayment Schedule";
        TotaliNterest: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        InterestDue: Decimal;
        DetailedLedger: Record "Detailed Cust. Ledg. Entry";
        InterestDueP: Decimal;
        OutBal: Decimal;
        VarInt: Integer;
        VARDATE: Date;
        DateFilter: Text;
        INTERESTPAID: Decimal;
        TenPercent: Decimal;
        InteretP: Decimal;
        CheckAmount: Decimal;
        CompletionDate: Date;
}