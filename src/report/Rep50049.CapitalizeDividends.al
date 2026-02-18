report 50049 "Capitalize Dividends"
{
    ApplicationArea = All;
    Caption = 'Capitalize Dividends';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0));
            column(Name; Name)
            {
            }
            column(No; "No.")
            {
            }
            column(Interest_On_Deposits; "Interest On Deposits")
            { }
            column(Outstanding_Balance; "Outstanding Balance") { }
            trigger OnAfterGetRecord()
            begin
                // if RecoverFromIOD then begin
                //     Customer.CalcFields("Interest On Deposits");
                //     Runbal := Customer."Interest On Deposits";
                //     Runbal := FnRecoverDividendLoan("No.", Runbal);
                //     Runbal := FnRecoverInstantLoanInterest("No.", Runbal);
                //     Runbal := FnRecoverInstantLoan("No.", Runbal);
                //     FnRecoverLoansinArrears("No.", Runbal);
                // end;
                if RecoverDiv then begin
                    Customer.CalcFields("Dividend Amount");
                    Runbal := Customer."Dividend Amount";
                    // Runbal := FnRecoverDividendLoanFromDiv("No.", Runbal);
                    // Runbal := FnRecoverInstantLoanInterestFromDiv("No.", Runbal);
                    // Runbal := FnRecoverInstantLoanFromDiv("No.", Runbal);
                    FnRecoverLoansinArrearsFromDiv("No.", Runbal);
                end;
            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset();
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') = true then begin
                    GenJournalLine.DeleteAll();
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = Basic;
                    }
                    field(RecoverFromIOD; RecoverFromIOD)
                    {

                    }
                    field(RecoverDiv; RecoverDiv)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        RecoverDiv: Boolean;
        RecoverFromIOD: Boolean;
        SFactory: Codeunit "Au Factory";
        BATCH_NAME: Label 'DEFAULT';
        BATCH_TEMPLATE: Label 'GENERAL';
        DOCUMENT_NO: Label 'Div 2024';
        ObjGensetup: Record "Sacco General Set-Up";
        AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        PostingDate: Date;
        Runbal: Decimal;

    local procedure FnRecoverLoansinArrears(MemberNo: Code[30]; RunningBal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        VarAmountinArrears: Decimal;
        ObjMember: Record Customer;//
        VarRuningBal: Decimal;
        VarAmountRecovered: Decimal;
    begin
        if RunningBal > 0 then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            //ObjLoans.SetFilter("Loan Product Type", '<>%1&<>%2', 'INSTANT', 'DEFAULTER');
            ObjLoans.SetFilter("Date filter", '..%1', CalcDate('-CM-1D', Today));
            if ObjLoans.FindSet then begin
                repeat
                    if (ObjLoans."Loan Product Type" <> 'DEFAULTER') and (ObjLoans."Loan Product Type" <> 'INSTANT')
                    and (ObjLoans."Loan Product Type" <> 'OVERDUE-INSTANT') and (ObjLoans."Loan Product Type" <> 'DIVIDEND') THEN begin
                        VarAmountinArrears := 0;
                        VarAmountinArrears := SFactory.FnGetLoanAmountinArrears(ObjLoans."Loan  No.");
                        if ObjLoans."Repayment Start Date" >= Today then begin
                            VarAmountinArrears := 0;
                        end;
                        // ObjMember.Reset;
                        // ObjMember.SetRange(ObjMember."No.", MemberNo);
                        // if ObjMember.FindSet then begin
                        //     ObjMember.CalcFields(ObjMember."Interest On Deposits");
                        //     VarRuningBal := ObjMember."Interest On Deposits";
                        // end;
                        VarRuningBal := RunningBal;
                        if VarAmountinArrears > 0 then begin
                            if VarRuningBal >= VarAmountinArrears then begin
                                VarAmountRecovered := VarAmountinArrears
                            end
                            else
                                VarAmountRecovered := VarRuningBal;
                            //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_LOAN IN ARREARS-------------------------------------------------------															
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest on Deposits", GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered, 'BOSA', ObjLoans."Loan  No.", 'Loan in Arrears Recovered- ' + Format(ObjLoans."Loan  No."), ObjLoans."Loan  No.", AppSource::" ");
                            //--------------------------------(Debit Member Dividend A/C_Loan In Arrears)-------------------------------------------------------------															
                            //------------------------------------2.1. CREDIT MEMBER LOAN IN AREARS-----------------------------------------------------------------------															
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered * -1, 'BOSA', ObjLoans."Loan  No.", 'Loan In Arrears Recovered From Dividend- ' + Format(PostingDate), ObjLoans."Loan  No.", AppSource::" ");
                            //----------------------------------(Credit Member Loan In Arrears)-----------------------------------------------------------------------------															
                            RunningBal := RunningBal - VarAmountRecovered;
                        end;
                    END;
                until ObjLoans.Next = 0;
            end;
            exit(RunningBal);
        end;
    end;

    local procedure FnRecoverLoansinArrearsFromDiv(MemberNo: Code[30]; RunningBal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        VarAmountinArrears: Decimal;
        ObjMember: Record Customer;//
        VarRuningBal: Decimal;
        VarAmountRecovered: Decimal;
    begin
        if RunningBal > 0 then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            ObjLoans.SetFilter("Loan Product Type", '%1', 'UTAPESA');
            ObjLoans.SetFilter("Date filter", '..%1', CalcDate('-CM-1D', Today));
            if ObjLoans.FindSet then begin
                repeat
                    if (ObjLoans."Loan Product Type" <> 'DEFAULTER') and (ObjLoans."Loan Product Type" <> 'INSTANT')
                    and (ObjLoans."Loan Product Type" <> 'OVERDUE-INSTANT') and (ObjLoans."Loan Product Type" <> 'DIVIDEND') THEN begin
                        VarAmountinArrears := 0;
                        //VarAmountinArrears := SFactory.FnGetLoanAmountinArrears(ObjLoans."Loan  No.");
                        if ObjLoans."Repayment Start Date" >= Today then begin
                            VarAmountinArrears := 0;
                        end;
                        ObjLoans.CalcFields("Outstanding Balance");
                        VarAmountinArrears := ObjLoans."Outstanding Balance";
                        // ObjMember.Reset;
                        // ObjMember.SetRange(ObjMember."No.", MemberNo);
                        // if ObjMember.FindSet then begin
                        //     ObjMember.CalcFields(ObjMember."Interest On Deposits");
                        //     VarRuningBal := ObjMember."Interest On Deposits";
                        // end;
                        VarRuningBal := RunningBal;
                        if VarAmountinArrears > 0 then begin
                            if VarRuningBal >= VarAmountinArrears then begin
                                VarAmountRecovered := VarAmountinArrears
                            end
                            else
                                VarAmountRecovered := VarRuningBal;
                            //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_LOAN IN ARREARS-------------------------------------------------------															
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend, GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered, 'BOSA', ObjLoans."Loan  No.", 'Loan in Arrears Recovered- ' + Format(ObjLoans."Loan  No."), ObjLoans."Loan  No.", AppSource::" ");
                            //--------------------------------(Debit Member Dividend A/C_Loan In Arrears)-------------------------------------------------------------															
                            //------------------------------------2.1. CREDIT MEMBER LOAN IN AREARS-----------------------------------------------------------------------															
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered * -1, 'BOSA', ObjLoans."Loan  No.", 'Loan In Arrears Recovered From Dividend- ' + Format(PostingDate), ObjLoans."Loan  No.", AppSource::" ");
                            //----------------------------------(Credit Member Loan In Arrears)-----------------------------------------------------------------------------															
                            RunningBal := RunningBal - VarAmountRecovered;
                        end;
                    END;
                until ObjLoans.Next = 0;
            end;
            exit(RunningBal);
        end;
    end;


    local procedure FnRecoverInstantLoan(MemberNo: Code[30]; RunningBal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        VarAmountinArrears: Decimal;
        ObjMember: Record Customer;//
        VarRuningBal: Decimal;
        VarAmountRecovered: Decimal;
    begin
        if RunningBal > 0 then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            ObjLoans.SetFilter("Loan Product Type", '%1', 'OVERDUE-INSTANT');
            ObjLoans.SetAutoCalcFields("Outstanding Balance");
            if ObjLoans.FindSet then begin
                repeat
                    VarAmountinArrears := 0;
                    VarAmountinArrears := ObjLoans."Outstanding Balance";
                    // ObjMember.Reset;
                    // ObjMember.SetRange(ObjMember."No.", MemberNo);
                    // if ObjMember.FindSet then begin
                    //     ObjMember.CalcFields(ObjMember."Interest On Deposits");
                    //     VarRuningBal := ObjMember."Interest On Deposits";
                    // end;
                    VarRuningBal := RunningBal;
                    if VarAmountinArrears > 0 then begin
                        if VarRuningBal >= VarAmountinArrears then begin
                            VarAmountRecovered := VarAmountinArrears
                        end
                        else
                            VarAmountRecovered := VarRuningBal;
                        //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_LOAN IN ARREARS-------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest on Deposits", GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered, 'BOSA', ObjLoans."Loan  No.", 'Loan in Arrears Recovered- ' + Format(ObjLoans."Loan  No."), ObjLoans."Loan  No.", AppSource::" ");
                        //--------------------------------(Debit Member Dividend A/C_Loan In Arrears)-------------------------------------------------------------															
                        //------------------------------------2.1. CREDIT MEMBER LOAN IN AREARS-----------------------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered * -1, 'BOSA', ObjLoans."Loan  No.", 'Loan In Arrears Recovered From Dividend- ' + Format(PostingDate), ObjLoans."Loan  No.", AppSource::" ");
                        //----------------------------------(Credit Member Loan In Arrears)-----------------------------------------------------------------------------															
                        RunningBal := RunningBal - VarAmountRecovered;
                    end;
                until ObjLoans.Next = 0;
            end;
            exit(RunningBal);
        end;
    end;

    local procedure FnRecoverInstantLoanInterest(MemberNo: Code[30]; RunningBal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        VarAmountinArrears: Decimal;
        ObjMember: Record Customer;//
        VarRuningBal: Decimal;
        VarAmountRecovered: Decimal;
    begin
        if RunningBal > 0 then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            ObjLoans.SetFilter("Loan Product Type", '%1', 'OVERDUE-INSTANT');
            ObjLoans.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest");
            if ObjLoans.FindSet then begin
                repeat
                    VarAmountinArrears := 0;
                    VarAmountinArrears := ObjLoans."Outstanding Interest";
                    // ObjMember.Reset;
                    // ObjMember.SetRange(ObjMember."No.", MemberNo);
                    // if ObjMember.FindSet then begin
                    //     ObjMember.CalcFields(ObjMember."Interest On Deposits");
                    //     VarRuningBal := ObjMember."Interest On Deposits";
                    // end;
                    VarRuningBal := RunningBal;
                    if VarAmountinArrears > 0 then begin
                        if VarRuningBal >= VarAmountinArrears then begin
                            VarAmountRecovered := VarAmountinArrears
                        end
                        else
                            VarAmountRecovered := VarRuningBal;
                        //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_LOAN IN ARREARS-------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest on Deposits", GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered, 'BOSA', ObjLoans."Loan  No.", 'Loan in Arrears Recovered- ' + Format(ObjLoans."Loan  No."), ObjLoans."Loan  No.", AppSource::" ");
                        //--------------------------------(Debit Member Dividend A/C_Loan In Arrears)-------------------------------------------------------------															
                        //------------------------------------2.1. CREDIT MEMBER LOAN IN AREARS-----------------------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered * -1, 'BOSA', ObjLoans."Loan  No.", 'Loan In Arrears Recovered From Dividend- ' + Format(PostingDate), ObjLoans."Loan  No.", AppSource::" ");
                        //----------------------------------(Credit Member Loan In Arrears)-----------------------------------------------------------------------------															
                        RunningBal := RunningBal - VarAmountRecovered;
                    end;
                until ObjLoans.Next = 0;
            end;
            exit(RunningBal);
        end;
    end;

    local procedure FnRecoverInstantLoanFromDiv(MemberNo: Code[30]; RunningBal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        VarAmountinArrears: Decimal;
        ObjMember: Record Customer;//
        VarRuningBal: Decimal;
        VarAmountRecovered: Decimal;
    begin
        if RunningBal > 0 then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            ObjLoans.SetFilter("Loan Product Type", '%1', 'OVERDUE-INSTANT');
            ObjLoans.SetAutoCalcFields("Outstanding Balance");
            if ObjLoans.FindSet then begin
                repeat
                    VarAmountinArrears := 0;
                    VarAmountinArrears := ObjLoans."Outstanding Balance";
                    // ObjMember.Reset;
                    // ObjMember.SetRange(ObjMember."No.", MemberNo);
                    // if ObjMember.FindSet then begin
                    //     ObjMember.CalcFields(ObjMember."Interest On Deposits");
                    //     VarRuningBal := ObjMember."Interest On Deposits";
                    // end;
                    VarRuningBal := RunningBal;
                    if VarAmountinArrears > 0 then begin
                        if VarRuningBal >= VarAmountinArrears then begin
                            VarAmountRecovered := VarAmountinArrears
                        end
                        else
                            VarAmountRecovered := VarRuningBal;
                        //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_LOAN IN ARREARS-------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend, GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered, 'BOSA', ObjLoans."Loan  No.", 'Loan in Arrears Recovered- ' + Format(ObjLoans."Loan  No."), ObjLoans."Loan  No.", AppSource::" ");
                        //--------------------------------(Debit Member Dividend A/C_Loan In Arrears)-------------------------------------------------------------															
                        //------------------------------------2.1. CREDIT MEMBER LOAN IN AREARS-----------------------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered * -1, 'BOSA', ObjLoans."Loan  No.", 'Loan In Arrears Recovered From Dividend- ' + Format(PostingDate), ObjLoans."Loan  No.", AppSource::" ");
                        //----------------------------------(Credit Member Loan In Arrears)-----------------------------------------------------------------------------															
                        RunningBal := RunningBal - VarAmountRecovered;
                    end;
                until ObjLoans.Next = 0;
            end;
            exit(RunningBal);
        end;
    end;

    local procedure FnRecoverInstantLoanInterestFromDiv(MemberNo: Code[30]; RunningBal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        VarAmountinArrears: Decimal;
        ObjMember: Record Customer;//
        VarRuningBal: Decimal;
        VarAmountRecovered: Decimal;
    begin
        if RunningBal > 0 then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            ObjLoans.SetFilter("Loan Product Type", '%1', 'OVERDUE-INSTANT');
            ObjLoans.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest");
            if ObjLoans.FindSet then begin
                repeat
                    VarAmountinArrears := 0;
                    VarAmountinArrears := ObjLoans."Outstanding Interest";
                    // ObjMember.Reset;
                    // ObjMember.SetRange(ObjMember."No.", MemberNo);
                    // if ObjMember.FindSet then begin
                    //     ObjMember.CalcFields(ObjMember."Interest On Deposits");
                    //     VarRuningBal := ObjMember."Interest On Deposits";
                    // end;
                    VarRuningBal := RunningBal;
                    if VarAmountinArrears > 0 then begin
                        if VarRuningBal >= VarAmountinArrears then begin
                            VarAmountRecovered := VarAmountinArrears
                        end
                        else
                            VarAmountRecovered := VarRuningBal;
                        //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_LOAN IN ARREARS-------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend, GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered, 'BOSA', ObjLoans."Loan  No.", 'Loan in Arrears Recovered- ' + Format(ObjLoans."Loan  No."), ObjLoans."Loan  No.", AppSource::" ");
                        //--------------------------------(Debit Member Dividend A/C_Loan In Arrears)-------------------------------------------------------------															
                        //------------------------------------2.1. CREDIT MEMBER LOAN IN AREARS-----------------------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered * -1, 'BOSA', ObjLoans."Loan  No.", 'Loan In Arrears Recovered From Dividend- ' + Format(PostingDate), ObjLoans."Loan  No.", AppSource::" ");
                        //----------------------------------(Credit Member Loan In Arrears)-----------------------------------------------------------------------------															
                        RunningBal := RunningBal - VarAmountRecovered;
                    end;
                until ObjLoans.Next = 0;
            end;
            exit(RunningBal);
        end;
    end;



    local procedure FnRecoverDividendLoan(MemberNo: Code[30]; RunningBal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        VarAmountinArrears: Decimal;
        ObjMember: Record Customer;//
        VarRuningBal: Decimal;
        VarAmountRecovered: Decimal;
    begin
        if RunningBal > 0 then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            ObjLoans.SetFilter("Loan Product Type", '%1', 'DIVIDEND');
            ObjLoans.SetAutoCalcFields("Outstanding Balance");
            if ObjLoans.FindSet then begin
                repeat
                    VarAmountinArrears := 0;
                    VarAmountinArrears := ObjLoans."Outstanding Balance";
                    // ObjMember.Reset;
                    // ObjMember.SetRange(ObjMember."No.", MemberNo);
                    // if ObjMember.FindSet then begin
                    //     ObjMember.CalcFields(ObjMember."Interest On Deposits");
                    //     VarRuningBal := ObjMember."Interest On Deposits";
                    // end;
                    VarRuningBal := RunningBal;
                    if VarAmountinArrears > 0 then begin
                        if VarRuningBal >= VarAmountinArrears then begin
                            VarAmountRecovered := VarAmountinArrears
                        end
                        else
                            VarAmountRecovered := VarRuningBal;
                        //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_LOAN IN ARREARS-------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest on Deposits", GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered, 'BOSA', ObjLoans."Loan  No.", 'Loan in Arrears Recovered- ' + Format(ObjLoans."Loan  No."), ObjLoans."Loan  No.", AppSource::" ");
                        //--------------------------------(Debit Member Dividend A/C_Loan In Arrears)-------------------------------------------------------------															
                        //------------------------------------2.1. CREDIT MEMBER LOAN IN AREARS-----------------------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered * -1, 'BOSA', ObjLoans."Loan  No.", 'Loan In Arrears Recovered From Dividend- ' + Format(PostingDate), ObjLoans."Loan  No.", AppSource::" ");
                        //----------------------------------(Credit Member Loan In Arrears)-----------------------------------------------------------------------------															
                        RunningBal := RunningBal - VarAmountRecovered;
                    end;
                until ObjLoans.Next = 0;
            end;
            exit(RunningBal);
        end;
    end;

    local procedure FnRecoverDividendLoanFromDiv(MemberNo: Code[30]; RunningBal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        VarAmountinArrears: Decimal;
        ObjMember: Record Customer;//
        VarRuningBal: Decimal;
        VarAmountRecovered: Decimal;
    begin
        if RunningBal > 0 then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            ObjLoans.SetFilter("Loan Product Type", '%1', 'DIVIDEND');
            ObjLoans.SetAutoCalcFields("Outstanding Balance");
            if ObjLoans.FindSet then begin
                repeat
                    VarAmountinArrears := 0;
                    VarAmountinArrears := ObjLoans."Outstanding Balance";
                    // ObjMember.Reset;
                    // ObjMember.SetRange(ObjMember."No.", MemberNo);
                    // if ObjMember.FindSet then begin
                    //     ObjMember.CalcFields(ObjMember."Interest On Deposits");
                    //     VarRuningBal := ObjMember."Interest On Deposits";
                    // end;
                    VarRuningBal := RunningBal;
                    if VarAmountinArrears > 0 then begin
                        if VarRuningBal >= VarAmountinArrears then begin
                            VarAmountRecovered := VarAmountinArrears
                        end
                        else
                            VarAmountRecovered := VarRuningBal;
                        //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_LOAN IN ARREARS-------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend, GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered, 'BOSA', ObjLoans."Loan  No.", 'Loan in Arrears Recovered- ' + Format(ObjLoans."Loan  No."), ObjLoans."Loan  No.", AppSource::" ");
                        //--------------------------------(Debit Member Dividend A/C_Loan In Arrears)-------------------------------------------------------------															
                        //------------------------------------2.1. CREDIT MEMBER LOAN IN AREARS-----------------------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Repayment, GenJournalLine."account type"::Customer, MemberNo, PostingDate, VarAmountRecovered * -1, 'BOSA', ObjLoans."Loan  No.", 'Loan In Arrears Recovered From Dividend- ' + Format(PostingDate), ObjLoans."Loan  No.", AppSource::" ");
                        //----------------------------------(Credit Member Loan In Arrears)-----------------------------------------------------------------------------															
                        RunningBal := RunningBal - VarAmountRecovered;
                    end;
                until ObjLoans.Next = 0;
            end;
            exit(RunningBal);
        end;
    end;

}
