report 50015 "Post Dividends"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Dividends Register"; "Dividends Register")
        {
            column(Member_No; "Member No")
            {

            }
            trigger OnAfterGetRecord()
            begin


                Counter := Counter + 1;
                IF (Counter >= NoOfProgress) OR (Time - TimeProgress > 1000) THEN begin
                    NoOfProgressed := NoOfProgressed + Counter;
                    ProgreeCheck := Round(NoOfProgressed / NoOfRec * 10000, 1);

                    Progress.Update(1, "Dividends Register"."Member No" + '::' + "Dividends Register"."Member Name");
                    //Progress.Update(1, ProgreeCheck);
                    Counter := 0;
                    TimeProgress := Time;
                end;

                BATCH_TEMPLATE := 'General';
                BATCH_NAME := 'Dividend';
                DOCUMENT_NO := "Dividends Register"."Document No";
                DOCUMENT_NOII := 'Prog Int' + Format(Date2DMY(PostingDate, 3));
                ObjGensetup.Get();
                if ProcessDiv then begin
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                    GenJournalLine."account type"::Customer, "Dividends Register"."Member No", PostingDate, "Dividends Register"."Gross Dividends" * -1, 'BOSA', '',
                    'Gross Dividend- ' + Format(PostingDate), '', AppSource::" ");
                    //--------------------------------(CREDIT MEMBER DIVIDEND A/C_Gross Dividend+Interest on Deposits)---------------------------------------------															
                    //------------------------------------1.1 DEBIT DIVIVIDEND PAYABLE GL A/C-----------------------------------------------------------------------															
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjGensetup."Dividend Payable Account", PostingDate, "Dividends Register"."Gross Dividends", 'BOSA', '',
                    'Gross Dividend- ' + Format(PostingDate), '', AppSource::" ");
                    //----------------------------------(Debit Dividend Payable GL A/C)----------------------------------------------------------------------------															
                    //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_GROSS WITHHOLDING TAX-------------------------------------------------------															
                    if "Dividends Register"."Witholding Tax" <> 0 then begin
                        LineNo := LineNo + 10000;
                        AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                        GenJournalLine."account type"::Customer, "Dividends Register"."Member No", PostingDate, "Dividends Register"."Dividend Withholding Tax", 'BOSA', '',
                        'Witholding Tax on Dividend- ' + Format(PostingDate), '', AppSource::" ");
                        //--------------------------------(Debit Member Dividend A/C_Gross Witholding Tax)-------------------------------------------------------------															
                        //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", ObjGensetup."WithHolding Tax Account", PostingDate, "Dividends Register"."Dividend Withholding Tax" * -1, 'BOSA', '',
                        'Witholding Tax on Dividend- ' + Format(PostingDate), '', AppSource::" ");
                    end;
                    //IOD
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest on Deposits",
                    GenJournalLine."account type"::Customer, "Dividends Register"."Member No", PostingDate, "Dividends Register"."Gross Interest On Deposit" * -1, 'BOSA', '',
                    'Interest on Deposits- ' + Format(PostingDate), '', AppSource::" ");
                    //--------------------------------(CREDIT MEMBER DIVIDEND A/C_Gross Dividend+Interest on Deposits)---------------------------------------------															
                    //------------------------------------1.1 DEBIT DIVIVIDEND PAYABLE GL A/C-----------------------------------------------------------------------															
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjGensetup."IOD Account", PostingDate, "Dividends Register"."Gross Interest On Deposit", 'BOSA', '',
                    'Interest on Deposits- ' + Format(PostingDate), '', AppSource::" ");
                    //----------------------------------(Debit Dividend Payable GL A/C)----------------------------------------------------------------------------															
                    //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_GROSS WITHHOLDING TAX-------------------------------------------------------															
                    if "Dividends Register"."Witholding Tax" <> 0 then begin
                        LineNo := LineNo + 10000;
                        AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest on Deposits",
                        GenJournalLine."account type"::Customer, "Dividends Register"."Member No", PostingDate, "Dividends Register"."IOD withholding Tax", 'BOSA', '',
                        'Witholding Tax on IOD- ' + Format(PostingDate), '', AppSource::" ");
                        //--------------------------------(Debit Member Dividend A/C_Gross Witholding Tax)-------------------------------------------------------------															
                        //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------															
                        LineNo := LineNo + 10000;
                        AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", ObjGensetup."WithHolding Tax Account", PostingDate, "Dividends Register"."IOD withholding Tax" * -1, 'BOSA', '',
                        'Witholding Tax on IOD- ' + Format(PostingDate), '', AppSource::" ");
                    end;
                end;

                if ProcessOtherInt then begin
                    //IOD
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NOII, LineNo, GenJournalLine."transaction type"::"Interest on Programmed Deposits",
                    GenJournalLine."account type"::Customer, "Dividends Register"."Member No", PostingDate, "Dividends Register"."Gross Interest On Chama Saving" * -1, 'BOSA', '',
                    'Interest on Programmed depo- ' + Format(PostingDate), '', AppSource::" ");
                    //--------------------------------(CREDIT MEMBER DIVIDEND A/C_Gross Dividend+Interest on Deposits)---------------------------------------------															
                    //------------------------------------1.1 DEBIT DIVIVIDEND PAYABLE GL A/C-----------------------------------------------------------------------															
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NOII, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", '903040', PostingDate, "Dividends Register"."Gross Interest On Chama Saving", 'BOSA', '',
                    'Interest on Programmed depo- ' + Format(PostingDate), '', AppSource::" ");
                    //----------------------------------(Debit Dividend Payable GL A/C)----------------------------------------------------------------------------															
                    //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_GROSS WITHHOLDING TAX-------------------------------------------------------															
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NOII, LineNo, GenJournalLine."transaction type"::"Interest on Programmed Deposits",
                    GenJournalLine."account type"::Customer, "Dividends Register"."Member No", PostingDate, "Dividends Register"."Chama withholding Tax", 'BOSA', '',
                    'Witholding Tax on Programmed- ' + Format(PostingDate), '', AppSource::" ");
                    //--------------------------------(Debit Member Dividend A/C_Gross Witholding Tax)-------------------------------------------------------------															
                    //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------															
                    LineNo := LineNo + 10000;
                    AuFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NOII, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjGensetup."WithHolding Tax Account", PostingDate, "Dividends Register"."Chama withholding Tax" * -1, 'BOSA', '',
                    'Witholding Tax on programmed- ' + Format(PostingDate), '', AppSource::" ");

                end;



            end;

            trigger OnPreDataItem()
            begin
                GetBatchs.Reset();
                GetBatchs.SetRange(GetBatchs."Journal Template Name", 'General');
                GetBatchs.SetRange(GetBatchs.Name, 'Dividend');
                if GetBatchs.Find('-') = false then begin
                    GetBatchs.Init();
                    GetBatchs."Journal Template Name" := 'General';
                    GetBatchs.Name := 'Dividend';
                    GetBatchs.Insert();
                end;
                GenJournalLine.Reset();
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'General');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'Dividend');
                if GenJournalLine.Find('-') = true then begin
                    GenJournalLine.DeleteAll();
                end;
                Progress.Open(ProgressMsg);
                NoOfRec := "Dividends Register".Count;
                NoOfProgress := NoOfRec DIV 100;
                Counter := 0;
                NoOfProgressed := 0;
                TimeProgress := Time;
            end;


            trigger OnPostDataItem()
            begin
                begin

                    // Do some processing
                    // for Counter := 1 to 100 do begin
                    //     Progress.Update(1, Counter);// Update the field in the dialog.
                    //     Sleep(50);
                    // end;
                    Progress.CLOSE();
                    Message(SuccessMessage, BATCH_TEMPLATE, BATCH_NAME);
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
                    field(PostingDate; PostingDate) { ApplicationArea = ALL; }
                    field(ProcessDiv; ProcessDiv) { ApplicationArea = all; }
                    field(ProcessOtherInt; ProcessOtherInt) { ApplicationArea = all; }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/mylayout15.rdl';
        }
    }

    var
        Progress: Dialog;
        Counter: Integer;
        ProgressMsg: Label 'Processing......@1######################\';

        SuccessMessage: Label 'Dividend has been successfully transferred to %1 Journal %2 Batch. ';

        GetBatchs: Record "Gen. Journal Batch";

        AuFactory: Codeunit "Au Factory";

        GenJournalLine: Record "Gen. Journal Line";

        LineNo: Integer;
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[50];
        DOCUMENT_NOII: Code[50];
        PostingDate: Date;
        ObjGensetup: Record "Sacco General Set-Up";
        AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        NoOfRec: Integer;
        NoOfProgressed: Integer;
        ProcessDiv: Boolean;
        ProcessOtherInt: Boolean;
        NoOfProgress: Integer;

        TimeProgress: Time;

        ProgreeCheck: Decimal;


}