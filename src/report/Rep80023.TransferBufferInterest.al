report 80023 "TransferBufferInterest"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            RequestFilterFields = "Loan  No.", "Loan Product Type", "Employer Code", "Client Code", "Outstanding Balance";
            column(Client_Code; "Client Code")
            {

            }
            trigger OnPreDataItem()
            var
                GenBatch: Record 232;
            begin

                GenBatch.Reset();
                GenBatch.SetRange("Journal Template Name", 'GENERAL');
                GenBatch.SetRange(Name, 'INTDUE');
                if GenBatch.FindFirst() = false then begin
                    GenBatch.Name := 'INTDUE';
                    GenBatch."Journal Template Name" := 'GENERAL';
                    GenBatch.Description := 'INTDUE';
                    GenBatch.Insert(true);
                end;
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Batch Name", 'INTDUE');
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                if GenJournalLine.Find('-') then begin
                    GenJournalLine.DeleteAll();
                end;

            end;

            trigger OnAfterGetRecord()
            var
                GenBatch: Record 232;
            begin


                InterestAmount := 0;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan  No.", "Loans Register"."Loan  No.");
                //LoansRegister.SetRange(Posted, true);

                //LoansRegister.SetFilter("Loan Product Type", '<>%1', 'HARAKA');
                LoansRegister.SetAutoCalcFields("Interest Charged");
                if LoansRegister.Find('-') then begin


                    if LoansRegister."Interest Charged" > 0 then begin
                        if LoansRegister."Interest Charged" > 0 then begin
                            InterestAmount := LoansRegister."Interest Charged";

                        end else
                            InterestAmount := 0;
                        LineNo := LineNo + 10000;
                        AuFactory.FnCreateGnlJournalLine('GENERAL', 'INTDUE', DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::"Interest Due",
                        GenJournalLine."Account Type"::Customer, LoansRegister."Client Code", PostingDate, (InterestAmount), FORMAT(LoansRegister.Source), LoansRegister."Loan  No.",
                        'Interest Charged', LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ");
                        //credit income account
                        if LoanType.Get("Loan Product Type") then
                            Message('%1', LoanType."Loan Interest Account");
                        LineNo := LineNo + 10000;
                        AuFactory.FnCreateGnlJournalLine('GENERAL', 'INTDUE', DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::" ",
                       GenJournalLine."Account Type"::"G/L Account", LoanType."Loan Interest Account", PostingDate, (((InterestAmount)) * -1), FORMAT(LoansRegister.Source), LoansRegister."Loan  No.",
                       'Interest Charged', LoansRegister."Loan  No.", GenJournalLine."Application Source"::" ");


                    end;
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
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = Basic;
                }
                field(DOCUMENT_NO; DOCUMENT_NO)
                {
                    ApplicationArea = Basic;
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
            LayoutFile = 'mylayout.rdl';
        }
    }

    var
        myInt: Integer;
        PostingDate: Date;
        LoansRegister: Record "Loans Register";
        AuFactory: Codeunit "Au Factory";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        DOCUMENT_NO: Code[100];
        generline: Record "Gen. Journal Line";
        InterestAmount: Decimal;

        LoanType: Record "Loan Products Setup";


}