report 50075 "EOD Reconcilliation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/EOD Reconcilliation Report.rdlc';

    dataset
    {
        dataitem("Treasury Transactions";"Treasury Transactions")
        {
            RequestFilterFields = "To Account","From Account","Transaction Date";
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;CompanyName)
            {
            }
            column(Company_Name;Company.Name)
            {
            }
            column(Company_Address;Company.Address)
            {
            }
            column(Company_Address_2;Company."Address 2")
            {
            }
            column(Company_Phone_No;Company."Phone No.")
            {
            }
            column(Company_Fax_No;Company."Fax No.")
            {
            }
            column(Company_Picture;Company.Picture)
            {
            }
            column(Company_Email;Company."E-Mail")
            {
            }
           
            column(USERID;UserId)
            {
            }
            column(No_TreasuryTransactions;"Treasury Transactions".No)
            {
            }
            column(TransactionDate;Format("Treasury Transactions"."Transaction Date"))
            {
            }
            column(TransactionType_TreasuryTransactions;"Treasury Transactions"."Transaction Type")
            {
            }
            column(ToAccountName_TreasuryTransactions;"Treasury Transactions"."To Account Name")
            {
            }
            column(ExcessAmount;"Treasury Transactions"."Excess Amount")
            {
            }
            column(ShortageAmount;"Treasury Transactions"."Shortage Amount")
            {
            }
            column(TreasuryCoinage;"Treasury Transactions"."Total Cash on Treasury Coinage")
            {
            }
            column(SourceAccountBalance;"Treasury Transactions"."Source Account Balance")
            {
            }
            column(TInterTeller;TInterTeller)
            {
            }
            column(TCashDeposit;TCashDeposit)
            {
            }
            column(TCashWithdrawals;TCashWithdrawal)
            {
            }
            column(CashTransWith;CashTransWith)
            {
            }
            column(TellerReceiptAmount;TellerReceiptAmount)
            {
            }
            column(TissuetoTeller;TissuetoTeller)
            {
            }
            column(TotalReceipts;TotalReceipts)
            {
            }
            column(TotalAmountReceived;TotalAmountReceived)
            {
            }
            column(TotalPayment;TotalPayment)
            {
            }
            column(ActualCashAtHand_TreasuryTransactions;"Treasury Transactions"."Actual Cash At Hand")
            {
            }
            column(FromAccountName_TreasuryTransactions;"Treasury Transactions"."From Account Name")
            {
            }
            column(FromAccount_TreasuryTransactions;"Treasury Transactions"."From Account")
            {
            }
            column(ToAccount_TreasuryTransactions;"Treasury Transactions"."To Account")
            {
            }
            column(Description_TreasuryTransactions;"Treasury Transactions".Description)
            {
            }
            column(Amount_TreasuryTransactions;"Treasury Transactions".Amount)
            {
            }
            column(Posted_TreasuryTransactions;"Treasury Transactions".Posted)
            {
            }
            column(DatePosted_TreasuryTransactions;"Treasury Transactions"."Date Posted")
            {
            }
            column(TimePosted_TreasuryTransactions;"Treasury Transactions"."Time Posted")
            {
            }
            column(PostedBy_TreasuryTransactions;"Treasury Transactions"."Posted By")
            {
            }
            column(NoSeries_TreasuryTransactions;"Treasury Transactions"."No. Series")
            {
            }
            column(TransactionTime_TreasuryTransactions;"Treasury Transactions"."Transaction Time")
            {
            }
            column(CoinageAmount_TreasuryTransactions;"Treasury Transactions"."Coinage Amount")
            {
            }
            column(CurrencyCode_TreasuryTransactions;"Treasury Transactions"."Currency Code")
            {
            }
            column(Issued_TreasuryTransactions;"Treasury Transactions".Issued)
            {
            }
            column(DateIssued_TreasuryTransactions;"Treasury Transactions"."Date Issued")
            {
            }
            column(TimeIssued_TreasuryTransactions;"Treasury Transactions"."Time Issued")
            {
            }
            column(IssueReceived_TreasuryTransactions;"Treasury Transactions"."Issue Received")
            {
            }
            column(DateReceived_TreasuryTransactions;"Treasury Transactions"."Date Received")
            {
            }
            column(TimeReceived_TreasuryTransactions;"Treasury Transactions"."Time Received")
            {
            }
            column(IssuedBy_TreasuryTransactions;"Treasury Transactions"."Issued By")
            {
            }
            column(ReceivedBy_TreasuryTransactions;"Treasury Transactions"."Received By")
            {
            }
            column(Received_TreasuryTransactions;"Treasury Transactions".Received)
            {
            }
            column(RequestNo_TreasuryTransactions;"Treasury Transactions"."Request No")
            {
            }
            column(BankNo_TreasuryTransactions;"Treasury Transactions"."Bank No")
            {
            }
            column(DenominationTotal_TreasuryTransactions;"Treasury Transactions"."Denomination Total")
            {
            }
            column(ExternalDocumentNo_TreasuryTransactions;"Treasury Transactions"."External Document No.")
            {
            }
            column(ChequeNo_TreasuryTransactions;"Treasury Transactions"."Cheque No.")
            {
            }
            column(TransactingBranch_TreasuryTransactions;"Treasury Transactions"."Transacting Branch")
            {
            }
            column(Approved_TreasuryTransactions;"Treasury Transactions".Approved)
            {
            }
            column(EndofDayTransTime_TreasuryTransactions;"Treasury Transactions"."End of Day Trans Time")
            {
            }
            column(EndofDay_TreasuryTransactions;"Treasury Transactions"."End of Day")
            {
            }
            column(LastTransaction_TreasuryTransactions;"Treasury Transactions"."Last Transaction")
            {
            }
            column(TotalCashonTreasuryCoinage;"Treasury Transactions"."Total Cash on Treasury Coinage")
            {
            }
            column(TillTreasuryBalance_TreasuryTransactions;"Treasury Transactions"."Till/Treasury Balance")
            {
            }
            column(ExcessShortageAmount_TreasuryTransactions;"Treasury Transactions"."Excess/Shortage Amount")
            {
            }
            column(ExcessAmount_TreasuryTransactions;"Treasury Transactions"."Excess Amount")
            {
            }
            column(ShortageAmount_TreasuryTransactions;"Treasury Transactions"."Shortage Amount")
            {
            }
            dataitem("Treasury Coinage";"Treasury Coinage")
            {
                DataItemLink = No=FIELD(No);
                DataItemTableView = SORTING(Value) ORDER(Descending);
                column(No_TreasuryCoinage;"Treasury Coinage".No)
                {
                }
                column(Code_TreasuryCoinage;"Treasury Coinage".Code)
                {
                }
                column(Description_TreasuryCoinage;"Treasury Coinage".Description)
                {
                }
                column(Type_TreasuryCoinage;"Treasury Coinage".Type)
                {
                }
                column(Value_TreasuryCoinage;"Treasury Coinage".Value)
                {
                }
                column(Quantity_TreasuryCoinage;"Treasury Coinage".Quantity)
                {
                }
                column(TotalAmount_TreasuryCoinage;"Treasury Coinage"."Total Amount")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                //TInterTeller:=0;
                issuetoTeller:=0;
                InterTeller:=0;


                TreasuryTrans.Reset;
                //TreasuryTrans.SETRANGE(TreasuryTrans.No,"Treasury Transactions".No);
                TreasuryTrans.SetRange(TreasuryTrans."From Account","From Account");
                TreasuryTrans.SetRange(TreasuryTrans."Date Posted","Treasury Transactions"."Transaction Date");
                TreasuryTrans.SetRange(TreasuryTrans."Transaction Type",TreasuryTrans."Transaction Type"::"Inter Teller Transfers");
                if TreasuryTrans.Find('-') then begin
                repeat
                InterTeller:=TreasuryTrans.Amount;
                TInterTeller:=TInterTeller+InterTeller;

                until TreasuryTrans.Next=0;
                end;

                 TreasuryTrans.Reset;
                //TreasuryTrans.SETRANGE(TreasuryTrans."Posted By","Posted By");
                TreasuryTrans.SetRange(TreasuryTrans."From Account","To Account");
                //TreasuryTrans.SETRANGE(TreasuryTrans."Date Posted","Treasury Transactions"."Date Posted");
                TreasuryTrans.SetRange(TreasuryTrans."Date Posted","Treasury Transactions"."Transaction Date");
                TreasuryTrans.SetRange(TreasuryTrans."Transaction Type",TreasuryTrans."Transaction Type"::"Issue To Teller");
                if TreasuryTrans.Find('-') then begin
                repeat
                issuetoTeller:=TreasuryTrans.Amount;
                TissuetoTeller:=TissuetoTeller+issuetoTeller;

                until TreasuryTrans.Next=0;
                end;


                TCashDeposit:=0;


                CashDep.Reset;
                //CashDep.SETRANGE(CashDep.Cashier,"Treasury Transactions"."Issued By");
                CashDep.SetRange(CashDep."Bank Account","From Teller");
                CashDep.SetRange(CashDep."Date Posted","Transaction Date");
                //TreasuryTrans.SETRANGE(TreasuryTrans."Date Posted","Treasury Transactions"."Transaction Date");
                CashDep.SetRange(CashDep.Type,'Cash Deposit');
                if CashDep.Find('-') then begin
                repeat
                //CashDeposit:=CashDep.Amount;
                TCashDeposit:=TCashDeposit+CashDep.Amount;
                until CashDep.Next=0;
                end;


                CashTransWith:=0;

                CashWith.Reset;
                CashWith.SetRange(CashWith."Bank Account","From Account");
                CashWith.SetRange(CashWith."Date Posted","Transaction Date");
                CashWith.SetRange(CashWith.Type,'Withdrawal');
                if CashWith.FindSet then begin
                  repeat
                    CashTransWith:=CashTransWith+CashWith.Amount;
                  until  CashWith.Next=0;
                end;

                TellerReceiptAmount:=0;

                TellerReceipts.Reset;
                TellerReceipts.SetRange(TellerReceipts."Bank Account","From Account");
                TellerReceipts.SetRange(TellerReceipts."Date Posted","Transaction Date");
                TellerReceipts.SetRange(TellerReceipts.Type,'Member Receipt');
                if TellerReceipts.FindSet then begin
                  repeat
                  TellerReceiptAmount:=TellerReceiptAmount+TellerReceipts.Amount;
                  until TellerReceipts.Next=0;
                  end;

                FReceiptAm:=0;

                Receipts.Reset;
                Receipts.SetRange(Receipts."Posted By","Posted By");
                Receipts.SetRange(Receipts."Date Posted","Date Posted");
                if Receipts.Find('-') then begin
                repeat
                FReceiptAm:=Receipts."Amount Received";
                TFReceiptAm:=TFReceiptAm+FReceiptAm;
                until Receipts.Next=0;
                end;



                BReceiptAm:=0;
                BosaReceipts.Reset;
                BosaReceipts.SetRange(BosaReceipts."Employer No.","From Account");
                BosaReceipts.SetRange(BosaReceipts."Transaction Date","Treasury Transactions"."Transaction Date");
                if BosaReceipts.Find('-') then begin
                repeat
                BReceiptAm:=BosaReceipts.Amount;
                TBReceiptAm:=TBReceiptAm+BReceiptAm;
                until BosaReceipts.Next=0;
                end;
                TotalReceipts:=TFReceiptAm+TBReceiptAm;
                //MESSAGE('TotalReceipts is %1',TotalReceipts);


                TotalAmountReceived:=TotalReceipts+TCashDeposit+TissuetoTeller+TellerReceiptAmount;


                TotalPayment:=TCashWithdrawal
            end;

            trigger OnPreDataItem()
            begin
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

    var
        TreasuryTrans: Record "Treasury Transactions";
        TInterTeller: Decimal;
        CashDep: Record Transactions;
        TCashDeposit: Decimal;
        TCashWithdrawal: Decimal;
        TissuetoTeller: Decimal;
        issuetoTeller: Decimal;
        InterTeller: Decimal;
        CashDeposit: Decimal;
        CashWithdrawal: Decimal;
        Receipts: Record "Receipt Header";
        BosaReceipts: Record "Receipts & Payments";
        FReceiptAm: Decimal;
        TFReceiptAm: Decimal;
        BReceiptAm: Decimal;
        TBReceiptAm: Decimal;
        TotalReceipts: Decimal;
        TotalAmountReceived: Decimal;
        TotalPayment: Decimal;
        Company: Record "Company Information";
        CashWith: Record Transactions;
        CashTransWith: Decimal;
        TellerReceipts: Record Transactions;
        TellerReceiptAmount: Decimal;
}

