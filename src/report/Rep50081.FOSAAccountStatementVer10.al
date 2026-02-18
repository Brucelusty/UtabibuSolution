report 50081 "FOSAAccountStatement Ver.1.0"
{
    // version BOSA ManagementV1.0(Surestep Systems)

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/FOSAAccountStatementVer.1.2.rdlc';
    Caption = 'Account Statement';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.") WHERE("Creditor Type" = CONST("FOSA Account"));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Global Dimension 2 Filter", "Date Filter";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
           
            column(CompanyInfo_Pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo__Address_2_; CompanyInfo."Address 2")
            {
            }
            column(STRSUBSTNO_Text000_VendDateFilter_; StrSubstNo(Text000, VendDateFilter))
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Vendor__Account_Type_; Vendor."Account Type")
            {
            }
            column(BOSA_Account_No; "BOSA Account No")
            {
            }
            column(Company_Code; "Employer Code")
            {
            }
            column(CompanyNamee; CompanyNamee)
            {
            }
            column(Vendor_Vendor__Staff_No_; Vendor."Personal No.")
            {
            }
            column(StartBalanceLCY__1; StartBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(VendBalanceLCY__1; VendBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY__1_Control29; StartBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___1; ("Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY___StartBalAdjLCY____Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___1; (StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
            {
                AutoFormatType = 1;
            }
            column(Vendor__Uncleared_Cheques_; "Uncleared Cheques")
            {
            }
            column(DataItem1102760019; ((StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1) - "Uncleared Cheques" - MinBal)
            {
            }
            column(Account_StatementCaption; Account_StatementCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(VendBalanceLCY__1_Control40Caption; VendBalanceLCY__1_Control40CaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry_DescriptionCaption; "Vendor Ledger Entry".FieldCaption(Description))
            {
            }
            column(Vendor_Ledger_Entry__Document_No__Caption; "Vendor Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(Vendor_Ledger_Entry__Posting_Date_Caption; "Vendor Ledger Entry".FieldCaption("Posting Date"))
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Account_TypeCaption; Account_TypeCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Debit_Amount_Caption; "Vendor Ledger Entry".FieldCaption("Debit Amount"))
            {
            }
            column(Vendor_Ledger_Entry__Credit_Amount_Caption; "Vendor Ledger Entry".FieldCaption("Credit Amount"))
            {
            }
            column(Vendor_Ledger_Entry__External_Document_No__Caption; "Vendor Ledger Entry".FieldCaption("External Document No."))
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Adj__of_Opening_BalanceCaption; Adj__of_Opening_BalanceCaptionLbl)
            {
            }
            column(Total_BalanceCaption; Total_BalanceCaptionLbl)
            {
            }
            column(Total_Balance_Before_PeriodCaption; Total_Balance_Before_PeriodCaptionLbl)
            {
            }
            column(Vendor__Uncleared_Cheques_Caption; FieldCaption("Uncleared Cheques"))
            {
            }
            column(Available_BalanceCaption; Available_BalanceCaptionLbl)
            {
            }
            column(Vendor_Date_Filter; "Date Filter")
            {
            }
            column(Vendor_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Vendor_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                "Date Filter" = FIELD("Date Filter");
                DataItemTableView = SORTING("Vendor No.", "Posting Date") where(Reversed = filter(false));

                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY_____1; (StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)") * -1)
                {
                    AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Vendor_Ledger_Entry_Description; Description)
                {
                }
                column(VendAmount__1; VendAmount * -1)
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VendBalanceLCY__1_Control40; VendBalanceLCY * -1)
                {
                    AutoFormatType = 1;
                }
                column(VendCurrencyCode; VendCurrencyCode)
                {
                }
                column(Vendor_Ledger_Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(Vendor_Ledger_Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(Debit; Debit)
                {
                }
                column(Credit; Credit)
                {
                }
                column(Vendor_Ledger_Entry__External_Document_No__; "External Document No.")
                {
                }
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY_____1_Control53; (StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)") * -1)
                {
                    AutoFormatType = 1;
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
                {
                }
                column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                {
                }
                column(Vendor_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Vendor_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Vendor_Ledger_Entry_Date_Filter; "Date Filter")
                {
                }
                column(TotalDebits; TotalDebits)
                {
                }
                column(TotalCredits; TotalCredits)
                {
                }
                column(Totals; Totals)
                {
                }
                column(PostedBy; "Vendor Ledger Entry"."User ID")
                {
                }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date") WHERE("Entry Type" = CONST("Correction of Remaining Amount"));

                    trigger OnAfterGetRecord()
                    begin
                        Correction := Correction + "Amount (LCY)";
                        VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetFilter("Posting Date", VendDateFilter);
                    end;
                }
                dataitem("Detailed Vendor Ledg. Entry2"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date") WHERE("Entry Type" = CONST("Appln. Rounding"));

                    trigger OnAfterGetRecord()
                    begin
                        ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                        VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetFilter("Posting Date", VendDateFilter);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TotalDebits := 0;
                    TotalCredits := 0;


                    CalcFields(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");

                    VendLedgEntryExists := true;
                    if PrintAmountsInLCY then begin
                        VendAmount := "Amount (LCY)";
                        VendRemainAmount := "Remaining Amt. (LCY)";
                        VendCurrencyCode := '';
                    end else begin
                        VendAmount := Amount;
                        VendRemainAmount := "Remaining Amount";
                        VendCurrencyCode := "Currency Code";
                    end;
                    VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    if ("Document Type" = "Document Type"::Payment) or ("Document Type" = "Document Type"::Refund) then
                        VendEntryDueDate := 0D
                    else
                        VendEntryDueDate := "Due Date";
                    TotalDebits := "Vendor Ledger Entry"."Debit Amount";
                    //FinaleDebits:=FinaleDebits+TotalDebits;
                    Vendor.Get("Vendor Ledger Entry"."Vendor No.");
                    Totals := Vendor."Balance (LCY)";
                    //MESSAGE('Balance is %1',Totals);


                    Debit := 0;
                    Credit := 0;

                    Debit := "Vendor Ledger Entry"."Debit Amount";
                    Credit := "Vendor Ledger Entry"."Credit Amount";



                    if "Vendor Ledger Entry"."Debit Amount" < 0 then begin
                        Credit := Abs("Vendor Ledger Entry"."Debit Amount");
                        Debit := 0;
                    end;

                    if "Vendor Ledger Entry"."Credit Amount" < 0 then begin
                        Debit := Abs("Vendor Ledger Entry"."Credit Amount");
                        Credit := 0;
                    end;

                    /*
                    IF "Vendor Ledger Entry"."Credit Amount">0 THEN BEGIN
                      Debit:=ABS("Vendor Ledger Entry"."Credit Amount");
                      END ELSE BEGIN
                        Credit:="Vendor Ledger Entry"."Credit Amount";
                        END;*/

                end;

                trigger OnPreDataItem()
                begin
                    VendLedgEntryExists := false;
                    //CurrReport.CreateTotals(VendAmount, "Amount (LCY)");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                trigger OnAfterGetRecord()
                begin
                    if not VendLedgEntryExists and ((StartBalanceLCY = 0) or ExcludeBalanceOnly) then begin
                        StartBalanceLCY := 0;
                        CurrReport.Skip;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*DOCUMENT_NO := 'SCHARGE'+FORMAT(TIME);
                IF CONFIRM('Do you want to charge Statement Fee?',FALSE)=TRUE THEN
                //  EXIT
                // ELSE
                  BEGIN
                    //MESSAGE('Charge for Member %1',DOCUMENT_NO);
                    Charges.RESET();
                    Charges.SETRANGE(Charges.Code,'STATEMENT_CHARGES');
                    IF Charges.FIND('-') THEN
                      BEGIN
                        StmtCharge := Charges."Charge Amount";
                        ChargesGL := Charges."GL Account";
                        IF StmtCharge > 0 THEN
                          IF vend.GET("No.") THEN
                          BEGIN
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor,vend."No.",PDate,StmtCharge,'FOSA',DOCUMENT_NO,
                            'FOSA Statement Charge','');
                
                        //-------------PAY----------------------------
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account",ChargesGL,PDate,StmtCharge*-1,'FOSA',DOCUMENT_NO,
                            'FOSA Statement Charge','');
                          END;
                      END;
                  END;*/

















                //Totals:=0;
                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                if VendDateFilter <> '' then begin
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change (LCY)");
                        StartBalanceLCY := -"Net Change (LCY)";
                    end;
                    SetFilter("Date Filter", VendDateFilter);
                    CalcFields("Net Change (LCY)");
                    StartBalAdjLCY := -"Net Change (LCY)";
                    VendorLedgerEntry.SetCurrentKey("Vendor No.", "Posting Date");
                    VendorLedgerEntry.SetRange("Vendor No.", Vendor."No.");
                    VendorLedgerEntry.SetFilter("Posting Date", VendDateFilter);
                    if VendorLedgerEntry.Find('-') then
                        repeat
                            VendorLedgerEntry.SetFilter("Date Filter", VendDateFilter);
                            VendorLedgerEntry.CalcFields("Amount (LCY)");
                            StartBalAdjLCY := StartBalAdjLCY - VendorLedgerEntry."Amount (LCY)";
                            "Detailed Vendor Ledg. Entry".SetCurrentKey("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Vendor Ledg. Entry".SetRange("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
                            "Detailed Vendor Ledg. Entry".SetFilter("Entry Type", '%1|%2',
                              "Detailed Vendor Ledg. Entry"."Entry Type"::"Correction of Remaining Amount",
                              "Detailed Vendor Ledg. Entry"."Entry Type"::"Appln. Rounding");
                            "Detailed Vendor Ledg. Entry".SetFilter("Posting Date", VendDateFilter);
                            if "Detailed Vendor Ledg. Entry".Find('-') then
                                repeat
                                    StartBalAdjLCY := StartBalAdjLCY - "Detailed Vendor Ledg. Entry"."Amount (LCY)";
                                until "Detailed Vendor Ledg. Entry".Next = 0;
                            "Detailed Vendor Ledg. Entry".Reset;
                        until VendorLedgerEntry.Next = 0;
                end;
                CurrReport.PrintOnlyIfDetail := ExcludeBalanceOnly or (StartBalanceLCY = 0);
                VendBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                MinBal := 0;
                if AccType.Get(Vendor."Account Type") then
                    MinBal := AccType."Minimum Balance";


                Employer.Reset;
                Employer.SetRange(Employer.Code, "Employer Code");
                if Employer.Find('-') then begin
                    CompanyNamee := Employer.Description;
                end;

            end;

            trigger OnPostDataItem()
            begin

            end;

            trigger OnPreDataItem()
            begin







                // CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                // CurrReport.CreateTotals("Vendor Ledger Entry"."Amount (LCY)", StartBalanceLCY, Correction, ApplicationRounding);

                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
                Company.Get();
                Company.CalcFields(Company.Picture);

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Reset;
        CompanyInfo.CalcFields(CompanyInfo.Picture);

        VendFilter := Vendor.GetFilters;
        VendDateFilter := Vendor.GetFilter("Date Filter");

        with "Vendor Ledger Entry" do
            if PrintAmountsInLCY then begin
                AmountCaption := FieldCaption("Amount (LCY)");
                RemainingAmtCaption := FieldCaption("Remaining Amt. (LCY)");
            end else begin
                AmountCaption := FieldCaption(Amount);
                RemainingAmtCaption := FieldCaption("Remaining Amount");
            end;
    end;

    var
        Text000: Label 'Period: %1';
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendFilter: Text[250];
        VendDateFilter: Text[30];
        VendAmount: Decimal;
        VendRemainAmount: Decimal;
        VendBalanceLCY: Decimal;
        VendEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        ExcludeBalanceOnly: Boolean;
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        VendLedgEntryExists: Boolean;
        AmountCaption: Text[30];
        RemainingAmtCaption: Text[30];
        VendCurrencyCode: Code[10];
        CompanyInfo: Record "Company Information";
        AccType: Record "Account Types-Saving Products";
        MinBal: Decimal;
        Account_StatementCaptionLbl: Label 'Account Statement';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        VendBalanceLCY__1_Control40CaptionLbl: Label 'Balance (LCY)';
        Account_No_CaptionLbl: Label 'Account No.';
        NamesCaptionLbl: Label 'Names';
        Account_TypeCaptionLbl: Label 'Account Type';
        Staff_No_CaptionLbl: Label 'Staff No.';
        Adj__of_Opening_BalanceCaptionLbl: Label 'Adj. of Opening Balance';
        Total_BalanceCaptionLbl: Label 'Total Balance';
        Total_Balance_Before_PeriodCaptionLbl: Label 'Total Balance Before Period';
        Available_BalanceCaptionLbl: Label 'Available Balance';
        ContinuedCaptionLbl: Label 'Continued';
        ContinuedCaption_Control46Lbl: Label 'Continued';
        UsersID: Record User;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        Totals: Decimal;
        CompanyNamee: Code[50];
        Cust: Record Customer;
        Employer: Record "Sacco Employers";
        Company: Record "Company Information";
        Debit: Decimal;
        Credit: Decimal;
        StmtCharge: Decimal;
        Charges: Record Charges;
        ChargesGL: Code[20];
        LineNo: Integer;
        SFactory: Codeunit "Au Factory";
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[50];
        DOCUMENT_NO: Code[50];
        PDate: Date;
        vend: Record Vendor;
}

