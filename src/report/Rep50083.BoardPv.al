report 50083 BoardPv
{
    RDLCLayout = 'Layouts/BoardVoucherNew.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Boad Payments Allowance"; "Boad Payments Allowance")
        {
            DataItemTableView = sorting("No");
            RequestFilterFields = "No";
            column(ReportForNavId_6437; 6437) { }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(DOCNAME; DOCNAME)
            {
            }
            column(Payments_Header__No__; "Boad Payments Allowance"."No")
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(StrCopyText; StrCopyText)
            {
            }
            column(Payments_Header__Payments_Header__Date; "Boad Payments Allowance"."Posting Date")
            {
            }
            // column(Payments_Header__Global_Dimension_1_Code_; "Boad Payments Allowance"."Global Dimension 1 Code")
            // {
            // }
            // column(Payments_Header__Shortcut_Dimension_2_Code_; "Boad Payments Allowance"."Global Dimension 2 Code")
            // {
            // }
            column(UserId; UserId)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(TTotal; TTotal)
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(CurrCode_Control1102756010; CurrCode)
            {
            }
            column(CurrCode_Control1102756012; CurrCode)
            {
            }
            column(Approved_; 'Approved')
            {
                AutoFormatType = 1;
            }
            column(Approval_Status_____; 'Approval Status' + ':')
            {
                AutoFormatType = 1;
            }
            column(TIME_PRINTED_____FORMAT_TIME__Control1102755003; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4__Control1102755004; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(USERID_Control1102755012; UserId)
            {
            }
            column(NumberText_1__Control1102755016; NumberText[1])
            {
            }
            column(TTotal_Control1102755034; TTotal)
            {
            }
            column(Bname; "Boad Payments Allowance"."Paying Bank Name")
            {
            }
            column(CurrCode_Control1102755035; CurrCode)
            {
            }
            column(CurrCode_Control1102755037; CurrCode)
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            column(PAYMENT_DETAILSCaption; PAYMENT_DETAILSCaptionLbl)
            {
            }
            column(AMOUNTCaption; AMOUNTCaptionLbl)
            {
            }
            column(NET_AMOUNTCaption; NET_AMOUNTCaptionLbl)
            {
            }
            column(W_TAXCaption; W_TAXCaptionLbl)
            {
            }
            column(Document_No___Caption; Document_No___CaptionLbl)
            {
            }
            column(Currency_Caption; Currency_CaptionLbl)
            {
            }
            column(Payment_To_Caption; Payment_To_CaptionLbl)
            {
            }
            column(Document_Date_Caption; Document_Date_CaptionLbl)
            {
            }
            column(Cheque_No__Caption; Cheque_No__CaptionLbl)
            {
            }

            column(R_CENTERCaption; R_CENTERCaptionLbl)
            {
            }
            column(PROJECTCaption; PROJECTCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Printed_By_Caption; Printed_By_CaptionLbl)
            {
            }
            column(Amount_in_wordsCaption; Amount_in_wordsCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755013; EmptyStringCaption_Control1102755013Lbl)
            {
            }
            column(Amount_in_wordsCaption_Control1102755021; Amount_in_wordsCaption_Control1102755021Lbl)
            {
            }
            column(Printed_By_Caption_Control1102755026; Printed_By_Caption_Control1102755026Lbl)
            {
            }
            column(TotalCaption_Control1102755033; TotalCaption_Control1102755033Lbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(Bank; "Boad Payments Allowance"."Paying Bank")
            {
                IncludeCaption = true;
            }
            column(BankName; "Boad Payments Allowance"."Paying Bank Name")
            {
                IncludeCaption = true;
            }

            column(CreationDocNo_PaymentsHeader; "Boad Payments Allowance"."No")
            {
            }
            column(CreationDoc; CreationDoc)

            {
            }
            column(narrations; "Boad Payments Allowance".Description)
            {
            }


            dataitem("Boarb Payments Lines"; "Boarb Payments Lines")
            {
                DataItemLink = "Document No" = field("No");
                DataItemTableView = sorting("G/L Account", "Document No") order(ascending);
                column(ReportForNavId_3474; 3474) { } // Autogenerated by ForNav - Do not delete															
                column(Payment_Line__Net_Amount__; "Boarb Payments Lines"."Net  Amount")
                {

                }
                column(Payment_Line_Amount; "Boarb Payments Lines"."Paye Amount")
                {
                }
                column(Transaction_Type; "Transaction Type")
                {

                }
                column(Staff_Board; "Staff\Board") { }

                column(AccountNo_PaymentLine; "Boarb Payments Lines"."Board No")
                {
                }
                column(AccountName_PaymentLine; "Boarb Payments Lines".Name)
                {
                }
                column(Payment_remarks; "Boarb Payments Lines"."Payment Descrition")
                {
                }
                column(Payment_Line__Withholding_Tax_Amount_; "Boarb Payments Lines"."Paye Amount")
                {
                }
                column(Payment_Line__VAT_Amount_; "Boarb Payments Lines"."Housing Leavy")
                {
                }

                column(Payment_Line_Line_No_; "Boarb Payments Lines"."G/L Account")
                {
                }
                column(Payment_Line_No; "Boarb Payments Lines"."Document No")
                {
                }

                column(Member_Amount; "Member Amount")

                {
                }
                column(TTotal2; TTotal)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    DimVal.Reset;
                    DimVal.SetRange(DimVal."Dimension Code", 'DEPARTMENT');
                    //  DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                    DimValName := '';
                    if DimVal.FindFirst then begin
                        DimValName := DimVal.Name;
                    end;
                    TTotal := TTotal + "Net  Amount";
                    //IF "Boarb Payments Lines".COUNT>1 THEN CurrReport.SKIP;															
                end;

            }
            dataitem(Total; Integer)
            {
                DataItemTableView = sorting(Number) order(ascending) where(Number = const(1));
                column(ReportForNavId_3476; 3476) { } // Autogenerated by ForNav - Do not delete															
                trigger OnAfterGetRecord();
                begin
                    /*CheckReport.InitTextVariable();															
					CheckReport.FormatNoText(NumberText,TTotal,'');*/

                end;

            }

        }





    }


    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            //:= false;															
        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);
        ;

    end;

    var
        StrCopyText: Text[30];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        DimVal: Record "Dimension Value";
        DimValName: Text[30];
        TTotal: Decimal;
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        STotal: Decimal;
        InvoiceCurrCode: Code[10];
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        DOCNAME: Text[30];
        VATCaptionLbl: label 'VAT';
        PAYMENT_DETAILSCaptionLbl: label 'PAYMENT DETAILS';
        AMOUNTCaptionLbl: label 'AMOUNT';
        NET_AMOUNTCaptionLbl: label 'AMOUNT';
        W_TAXCaptionLbl: label 'W/TAX';
        Document_No___CaptionLbl: label 'Document No. :';
        Currency_CaptionLbl: label 'Currency:';
        Payment_To_CaptionLbl: label 'Payment To:';
        Document_Date_CaptionLbl: label 'Document Date:';
        Cheque_No__CaptionLbl: label 'Cheque No.:';
        R_CENTERCaptionLbl: label 'R.CENTER CODE';
        PROJECTCaptionLbl: label 'PROJECT CODE';
        TotalCaptionLbl: label 'Total';
        Printed_By_CaptionLbl: label 'Printed By:';
        Amount_in_wordsCaptionLbl: label 'Amount in words';
        EmptyStringCaptionLbl: label '================================================================================================================================================================================================';
        EmptyStringCaption_Control1102755013Lbl: label '================================================================================================================================================================================================';
        Amount_in_wordsCaption_Control1102755021Lbl: label 'Amount in words';
        Printed_By_Caption_Control1102755026Lbl: label 'Printed By:';
        TotalCaption_Control1102755033Lbl: label 'Total';
        Signature_CaptionLbl: label 'Signature:';
        Date_CaptionLbl: label 'Date:';
        Name_CaptionLbl: label 'Name:';
        RecipientCaptionLbl: label 'Recipient';
        CompanyInfo: Record "Company Information";
        BudgetLbl: label 'Budget';
        CreationDoc: Boolean;
        DtldVendEntry: Record "Detailed Vendor Ledg. Entry";
        InvNo: Code[20];
        InvAmt: Decimal;
        ApplyEnt: Record "Vendor Ledger Entry";
        VendEnrty: Record "Vendor Ledger Entry";
        CI: Record "Company Information";

    // --> Reports ForNAV Autogenerated code - do not delete or modify															
    //51516125_v6_3_0_2259;															






    // Reports ForNAV Autogenerated code - do not delete or modify -->															
}



