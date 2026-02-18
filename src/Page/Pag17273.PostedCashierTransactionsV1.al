//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17273 "Posted Cashier Transactions V1"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        ShowAccountImages := false;
                        ShowMembershipImages := false;
                        if Rec."Member No" <> '' then begin
                            ShowMembershipImages := true
                        end else
                            ShowAccountImages := true;
                    end;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Rec.Posted = true then
                            Error('You cannot modify an already posted record.');

                        FnRunGetAccountAvailableBalance();

                        Clear(AccP.Image);
                        Clear(AccP.Signature);
                        if AccP.Get(Rec."Account No") then begin
                            /*//Hide Accounts
                            IF AccP.Hide = TRUE THEN BEGIN
                            IF UsersID.GET(USERID) THEN BEGIN
                            IF UsersID."Show Hiden" = FALSE THEN
                            ERROR('You do not have permission to transact on this account.');
                            END;
                            END; */
                            //Hide Accounts
                            //AccP.CALCFIELDS(AccP.Picture,AccP.Signature);
                        end;

                        Rec.CalcFields("Uncleared Cheques");
                        if AccP.Get(Rec."Account No") then begin
                            //Picture:=AccP.Picture;
                            //Signature:=AccP.Signature;

                        end;

                        FnShowFields();

                        VarshowSignatories := false;
                        VarShowAgents := false;

                        ObjAccountSignatories.Reset;
                        ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", Rec."Account No");
                        if ObjAccountSignatories.Find('-') = true then begin
                            VarshowSignatories := true;
                        end;

                        ObjAccountAgent.Reset;
                        ObjAccountAgent.SetRange(ObjAccountAgent."Account No", Rec."Account No");
                        if ObjAccountAgent.FindSet then begin
                            VarShowAgents := true;
                        end;

                        ShowAccountImages := false;
                        ShowMembershipImages := false;
                        if Rec."Member No" <> '' then begin
                            ShowMembershipImages := true
                        end else
                            ShowAccountImages := true;

                    end;
                }
                field("Has Signatories";Rec."Has Signatories")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Signing Instructions";Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Has Special Mandate";Rec."Has Special Mandate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                    Visible = HasSpecialMandateVisible;
                }
                field("Transacting Agent";Rec."Transacting Agent")
                {
                    ApplicationArea = Basic;
                    Visible = TransactingAgentVisible;
                }
                field("Agent Name";Rec."Agent Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transacting Agent Name';
                    Editable = false;
                    Visible = TransactingAgentNameVisible;
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        FChequeVisible := false;
                        if Rec.Posted = true then
                            Error('You cannot modify an already posted record.');
                        FnRunShowReleavantFields;

                        if Rec."Type _Transactions" = Rec."type _transactions"::"Cheque Deposit" then begin
                            FChequeVisible := true;
                        end;
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if ObjAccountType.Get(Rec."Account Type") then begin
                            if (Rec.Amount >= ObjAccountType."Bulk Withdrawal Amount") and (Rec.Type = 'Withdrawal') then begin
                                BulkWithVisible := true;
                            end;
                        end;



                        SuspTransVisible := false;
                        if Rec.Suspicious = true then begin
                            SuspTransVisible := true;
                        end;



                        DeclaretionVisible := false;
                        if Rec."Transaction to Be Declared" = true then begin
                            DeclaretionVisible := true;
                        end;

                        ObjGensetup.Get;

                        if (Rec."Type _Transactions" = Rec."type _transactions"::Withdrawal) or (Rec."Type _Transactions" = Rec."type _transactions"::"Bankers Cheque") then begin
                            VarAccountAvailableBal := SFactory.FnRunGetAccountAvailableBalance(Rec."Account No");

                            VarTransChargeAmount := FnRunGetTransactionAmountCharge;
                            VarTransChargeAmount := VarTransChargeAmount + (VarTransChargeAmount * ObjGensetup."Excise Duty(%)" / 100);
                            if VarAccountAvailableBal < (VarTransChargeAmount + Rec.Amount) then
                                Error('The Account does not have sufficient Balance');
                        end;
                    end;
                }
                field("Transaction Mode New";Rec."Transaction Mode New")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Mode';

                    trigger OnValidate()
                    begin
                        VarReceiptBankEditable := true;
                        if Rec."Transaction Mode New" = Rec."transaction mode new"::Cash then begin
                            VarReceiptBankEditable := false;
                        end;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                group(ODDetails)
                {
                    Visible = ODDetailsVisible;
                    field("Overdraft Limit";Rec."Overdraft Limit")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Overdraft Balance";Rec."Overdraft Balance")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Overdraft Expiry Date";Rec."Overdraft Expiry Date")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(DepositSlip)
                {
                    Visible = DepositSlipVisible;
                    field("Receipt Bank.";Rec."Bank Account")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Receipt Bank';
                        Editable = VarReceiptBankEditable;
                    }
                    field("Document Date";Rec."Document Date")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(BCheque)
                {
                    Caption = '.';
                    Visible = BChequeVisible;
                    field("Bankers Cheque No";Rec."Bankers Cheque No")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Payee; Rec.Payee)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Post Dated";Rec."Post Dated")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            "Transaction DateEditable" := false;
                            if Rec."Post Dated" = true then
                                "Transaction DateEditable" := true
                            else
                                Rec."Transaction Date" := Today;
                        end;
                    }
                    field("Cheque Clearing Bank Code";Rec."Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank_ Code';
                    }
                    field("Cheque Clearing Bank";Rec."Cheque Clearing Bank")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing_Bank';
                        Editable = false;
                    }
                }
                group(ChequeWith)
                {
                    Caption = '.';
                    Visible = ChequeWithOll;
                    field("Cheque NoChq";Rec."Bankers Cheque No")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque No';
                    }
                    field("CheqWith Payee"; Rec.Payee)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Payee';
                    }
                    field("ChequeWith Post Dated";Rec."Post Dated")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Post Dated';

                        trigger OnValidate()
                        begin
                            "Transaction DateEditable" := false;
                            if Rec."Post Dated" = true then
                                "Transaction DateEditable" := true
                            else
                                Rec."Transaction Date" := Today;
                        end;
                    }
                    field("Cheque Clearing Bank Code Cheq";Rec."Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank Code';
                    }
                    field("Cheque Clearing Bank Cheq";Rec."Cheque Clearing Bank")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank';
                        Editable = false;
                    }
                }
                group(BReceipt)
                {
                    Caption = '.';
                    Visible = BReceiptVisible;
                    field("BOSA Account No";Rec."BOSA Account No")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Allocated Amount";Rec."Allocated Amount")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Receipt Bank";Rec."Bank Account")
                    {
                        ApplicationArea = Basic;
                        Editable = VarReceiptBankEditable;
                    }
                    field("<Document Date.>";Rec."Document Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Document Date';
                    }
                    field("Excess Funds Account";Rec."Excess Funds Account")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(FCheque)
                {
                    Caption = '.';
                    Visible = FChequeVisible;
                    field("Cheque Type";Rec."Cheque Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque No";Rec."Cheque No")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            if StrLen(Rec."Cheque No") <> 6 then
                                Error('Cheque No. cannot contain More or less than 6 Characters.');
                        end;
                    }
                    field("Bank Code";Rec."Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Source Bank Code';
                    }
                    field("Bank Name";Rec."Bank Name")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Source Bank Name';
                        Editable = false;
                    }
                    field("Branch Name";Rec."Branch Name")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Source Branch Name';
                        Editable = false;
                    }
                    field("<Cheque Clearing Bank_Code>";Rec."Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank Code';
                    }
                    field("<Cheque_Clearing Bank>";Rec."Cheque Clearing Bank")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank';
                        Editable = false;
                    }
                    field("Expected Maturity Date";Rec."Expected Maturity Date")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field(Status; Rec.Status)
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("172048";Rec."Banking Posted")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Banked';
                        Editable = false;
                    }
                    field("Bank Account";Rec."Bank Account")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Cheque Date";Rec."Cheque Date")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque Deposit Remarks";Rec."Cheque Deposit Remarks")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(ChequeWithdrawal)
                {
                    Caption = '.';
                    Visible = ChequeWithdrawalVisible;
                    field("Cheque TypeWith";Rec."Cheque Type")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Type';
                    }
                    field("Drawer's Account No.";Rec."Drawer's Account No")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Drawer''s Account No.';
                    }
                    field("Drawer's NameWith";Rec."Drawer's Name")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Drawer''s Name';
                        Editable = false;
                    }
                    field("Drawers Cheque No.With";Rec."Drawers Cheque No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Drawers Cheque No.';
                    }
                    field("Cheque DateWith";Rec."Cheque Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Date';
                    }
                    field("Cheque Deposit RemarksWith";Rec."Cheque Deposit Remarks")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Deposit Remarks';
                    }
                    field("Cheque Clearing Bank Code.With";Rec."Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank Code.';
                    }
                }
                group(ChequeTransf)
                {
                    Caption = '.';
                    Visible = ChequeTransfVisible;
                    field("Cheque TypeTR";Rec."Cheque Type")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Type';
                    }
                    field("Drawer's Account No";Rec."Drawer's Account No")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Drawer's Name";Rec."Drawer's Name")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Drawers Cheque No.";Rec."Drawers Cheque No.")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque DateTR";Rec."Cheque Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Date';
                    }
                    field("Cheque Deposit RemarksTR";Rec."Cheque Deposit Remarks")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Deposit Remarks';
                    }
                    field("<Cheque Clearing Bank Code.>";Rec."Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank Code.';
                    }
                }
            }
            group("Bulk Withdrawal Details")
            {
                Caption = 'Bulk Withdrawal Details';
                Visible = BulkWithVisible;
                field("Bulk Withdrawal Appl Done";Rec."Bulk Withdrawal Appl Done")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Application Done';
                    Editable = false;
                }
                field("Bulk Withdrawal Appl Date";Rec."Bulk Withdrawal Appl Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Application Date';
                    Editable = false;
                }
                field("Bulk Withdrawal Appl Amount";Rec."Bulk Withdrawal Appl Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Application Amount';
                    Editable = false;
                }
                field("Bulk Withdrawal Date";Rec."Bulk Withdrawal Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Date';
                    Editable = false;
                }
                field("Bulk Withdrawal Fee";Rec."Bulk Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Fee Charged';
                    Editable = false;
                }
                field("Bulk Withdrawal App Done By";Rec."Bulk Withdrawal App Done By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Application Done By';
                    Editable = false;
                }
            }
            group(BOSAReceiptCheque)
            {
                Caption = '.';
                Visible = BOSAReceiptChequeVisible;
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Additional;
                }
                field("Book Balance";Rec."Book Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Uncleared Cheques";Rec."Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                }
                field(VarAvailableBalance; VarAvailableBalance)
                {
                    ApplicationArea = Basic;
                    Caption = 'Available Balance';
                    Editable = false;
                }
                field("N.A.H Balance";Rec."N.A.H Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("ID No";Rec."ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Transaction Time";Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Authorised; Rec.Authorised)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Suspicious Transaction")
            {
                Caption = 'Suspicious Transaction';
                Visible = SuspTransVisible;
                field(Suspicious; Rec.Suspicious)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Month Credits to Date";Rec."Month Credits to Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly TurnOver Amount";Rec."Monthly TurnOver Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Max Credits+Tolerance";Rec."Monthly Max Credits+Tolerance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthly Maximum  Allowable Credits';
                    Editable = false;
                }
            }
            group("Transaction Declaretion")
            {
                Caption = 'Transaction Declaretion';
                Visible = DeclaretionVisible;
                field("Transaction to Be Declared";Rec."Transaction to Be Declared")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Declaration";Rec."Transaction Declaration")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Deposit Arrears Penalty";"Deposit Arrears Penalty")
            {
                SubPageLink = "Account No." = field("Member No"),
                              Settled = filter(false);
                Visible = VarShowDepositArrearsPage;
            }
            part("Receipt Allocation";"Receipt Allocation-BOSA")
            {
                SubPageLink = "Document No" = field(No);
                Visible = ReceiptAllVisible;
            }
            // part(AccountAgents;Rec."Account Agent List") TODO
            // {
            //     Caption = 'Account Agents';
            //     SubPageLink = "Account No" = field("Account No");
            //     Visible = VarShowAgents;
            // }
            // part(AccountSignatories;Rec."Account Signatories Details")
            // {
            //     Caption = 'Account Signatories';
            //     SubPageLink = "Account No" = field("Account No");
            //     Visible = VarshowSignatories;
            // }
        }
        area(factboxes)
        {
            part(Control8;"Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                ShowFilter = false;
                SubPageLink = "No." = field("Member No");
                Visible = ShowMembershipImages;
            }
            part(Control7;"Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                SubPageLink = "No." = field("Member No");
                Visible = ShowMembershipImages;
            }
            part(Control1000000000;"FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Account No");
            }
            part(Control1000000018;"Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Member No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Account Signatories';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Account Signatories Details";
                    RunPageLink = "Account No" = field("Account No");
                }
                action("Account Agent Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Account Agents';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Account Agent List";
                    RunPageLink = "Account No" = field("Account No");
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'View BOSA Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Members Statistics";
                    //RunPageLink = "No." = field("Member No");
                }
                action("Account Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transacting Account Statement';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        Vend.Reset;
                        Vend.SetRange(Vend."No.",Rec."Account No");
                        if Vend.Find('-') then
                            Report.run(172890, true, false, Vend)
                    end;
                }
                action("Reprint Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reprint Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField(Posted);

                        Trans.Reset;
                        Trans.SetRange(Trans.No, Rec.No);
                        if Trans.Find('-') then begin
                            if Rec."Type _Transactions" = Rec."type _transactions"::"Cash Deposit" then
                                Report.run(172498, true, true, Trans);

                            if Rec."Type _Transactions" = Rec."type _transactions"::Withdrawal then
                                Report.run(172499, true, true, Trans);

                            if Rec."Type _Transactions" = Rec."type _transactions"::"Cheque Deposit" then
                                Report.run(172500, true, true, Trans);

                            if Rec."Type _Transactions" = Rec."type _transactions"::"Batch Deposit" then
                                Report.run(172517, true, true, Trans);

                            if Rec.Type = 'Transfer' then
                                Report.run(172524, true, true, Trans);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetRange(Cashier, UserId);
        FnRunShowReleavantFields;
        FnShowFields;

        ObjPenaltyArrears.Reset;
        ObjPenaltyArrears.SetRange(ObjPenaltyArrears."Account No.",Rec."Member No");
        ObjPenaltyArrears.SetRange(ObjPenaltyArrears.Settled, false);
        if ObjPenaltyArrears.FindSet then begin
            VarHasDepositArrears := true;
        end;
        VarShowDepositArrearsPage := false;

        "Transaction DateEditable" := false;
        if Rec."Post Dated" = true then
            "Transaction DateEditable" := true;


        FChequeVisible := false;
        if Rec."Type _Transactions" = Rec."type _transactions"::"Cheque Deposit" then begin
            FChequeVisible := true;

            ObjBanks.Reset;
            ObjBanks.SetRange(ObjBanks."Cheque Clearing Bank", true);
            if ObjBanks.FindSet then begin
                Rec."Cheque Clearing Bank Code" := ObjBanks."No.";
                Rec."Cheque Clearing Bank" := ObjBanks.Name;
            end;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Posted = true then
            Error('You cannot delete an already posted record.');
    end;

    trigger OnInit()
    begin
        "Transaction DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Clear(Acc.Image);
        Clear(Acc.Signature);

        Rec."Needs Approval" := Rec."needs approval"::No;
        FChequeVisible := false;


        CashierTrans.Reset;
        CashierTrans.SetRange(CashierTrans.Posted, false);
        CashierTrans.SetRange(CashierTrans.Cashier, UserId);
        if CashierTrans.Count > 0 then begin
            if CashierTrans."Account No" = '' then begin
                if Confirm('There are still some Unused Transaction Nos. Continue?', false) = false then begin
                    Error('There are still some Unused Transaction Nos. Please utilise them first');
                end;
            end;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        /*IF xRec.Posted = TRUE THEN BEGIN
        IF Posted = TRUE THEN
        ERROR('You cannot modify an already posted record.');
        END;*/

    end;

    trigger OnOpenPage()
    begin
        FnRunShowReleavantFields;
        FnShowFields;

        FChequeVisible := false;
        if Rec."Type _Transactions" = Rec."type _transactions"::"Cheque Deposit" then begin
            FChequeVisible := true;
        end;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        ObjAccount: Record Vendor;
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        GenLedgerSetup: Record "General Ledger Setup";
        AccountNo: Code[30];
        NewAccount: Boolean;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        IntervalPenalty: Decimal;
        StandingOrders: Record "Standing Orders";
        Charges: Record Charges;
        AccountNotices: Record "Account Notices";
        Cust: Record "Members Register";
        AccountHolders: Record Vendor;
        chqtransactions: Record Transactions;
        Trans: Record Transactions;
        CustAcc: Record "Members Register";
        TransactionsRec: Record Transactions;
        DenominationsRec: Record Denominations;
        TillNo: Code[20];
        FOSASetup: Record "Purchases & Payables Setup";
        Acc: Record Vendor;
        ChequeTypes: Record "Cheque Types";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        ChBank: Code[20];
        DValue: Record "Dimension Value";
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Cheque: Boolean;
        Recover: Boolean;
        GenSetup: Record "Sacco General Set-Up";
        MailContent: Text[150];
        supervisor: Record "Supervisors Approval Levels";
        TEXT1: label 'YOU HAVE A TRANSACTION AWAITING APPROVAL';
        AccP: Record Vendor;
        LoansR: Record "Loans Register";
       
        FChequeVisible: Boolean;
       
        BChequeVisible: Boolean;
       
        BReceiptVisible: Boolean;
       
        BOSAReceiptChequeVisible: Boolean;
       
        "Branch RefferenceVisible": Boolean;
       
        LRefVisible: Boolean;
        ChequeTransfVisible: Boolean;
       
        "Transaction DateEditable": Boolean;
        Excise: Decimal;
        Echarge: Decimal;
        BankLedger: Record "Bank Account Ledger Entry";
        Vend: Record Vendor;
        ChequeBook: Record "Cheques Register";
        BosaSetUp: Record "Sacco General Set-Up";
        CashierTrans: Record Transactions;
        ChequeWithdrawalVisible: Boolean;
        DepositSlipVisible: Boolean;
        OverDraftCharge: Decimal;
        OverDraftChargeAcc: Code[20];
        ChequeWithOll: Boolean;
        ChequeRegister: Record "Cheque Book Register";
        LoanType: Record "Loan Products Setup";
        GraduatedCharge: Record "CWithdrawal Graduated Charges";
        ExciseDuty: Decimal;
        ShareCapDefecit: Decimal;
        HasSpecialMandateVisible: Boolean;
        TransactingAgentVisible: Boolean;
        TransactingAgentNameVisible: Boolean;
        ObjAccountAgents: Record "Account Agent Details";
        ReceiptAllVisible: Boolean;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        SURESTEPFactory: Codeunit "Au Factory";
        ObjTransactions: Record "Receipt Allocation";
        BulkWithVisible: Boolean;
        ObjAccountType: Record "Account Types-Saving Products";
        VarMonthlyInt: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarshowSignatories: Boolean;
        VarShowAgents: Boolean;
        ObjAccountSignatories: Record "FOSA Account Sign. Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjGensetup: Record "Sacco General Set-Up";
        RunBal: Decimal;
        VarAvailableBalance: Decimal;
        ObjTransactionsII: Record Transactions;
        SuspTransVisible: Boolean;
        DeclaretionVisible: Boolean;
        VarOutstandingInterest: Decimal;
        VarOutstandingInsurance: Decimal;
        VarCurrPayOff: Decimal;
        VarTotalLoanDue: Decimal;
        ObjPenaltyArrears: Record "Deposit Arrears Penalty Buffer";
        VarHasDepositArrears: Boolean;
        ObjCust: Record "Members Register";
        VarDepositBal: Decimal;
        VarShowDepositArrearsPage: Boolean;
        VarReceiptBankEditable: Boolean;
        ShowMembershipImages: Boolean;
        ShowAccountImages: Boolean;
        ODDetailsVisible: Boolean;
        ObjAuditGeneralSetup: Record "Audit General Setup";
        ObjTrans: Record Transactions;
        EmailRecepient: Text;
        VarTransChargeAmount: Decimal;
        SFactory: Codeunit "Au Factory";
        VarAccountAvailableBal: Decimal;
        ObjBanks: Record "Bank Account";
        ObjDetailed: Record "Detailed Vendor Ledg. Entry";


    procedure SendEmail()
    begin
        /*
        supervisor.RESET;
        supervisor.SETFILTER(supervisor."Transaction Type",'withdrawal');
        IF supervisor.FIND('-') THEN BEGIN
         // MailContent:=TEXT1;
        REPEAT
        
         genSetup.GET(0);
         SMTPMAIL.NewMessage(genSetup."Sender Address",'Transactions' +''+'');
         SMTPMAIL.SetWorkMode();
         SMTPMAIL.ClearAttachments();
         SMTPMAIL.ClearAllRecipients();
         SMTPMAIL.SetDebugMode();
         SMTPMAIL.SetFromAdress(genSetup."Sender Address");
         SMTPMAIL.SetHost(genSetup."Outgoing Mail Server");
         SMTPMAIL.SetUserID(genSetup."Sender User ID");
         SMTPMAIL.AddLine(MailContent);
         SMTPMAIL.SetToAdress(supervisor."E-mail Address");
         SMTPMAIL.Send;
         UNTIL supervisor.NEXT=0;
        END;
        */

    end;

    local procedure FnShowFields()
    begin
        HasSpecialMandateVisible := false;
        TransactingAgentVisible := false;
        TransactingAgentNameVisible := false;
        ReceiptAllVisible := false;

        ObjAccountAgents.Reset;
        ObjAccountAgents.SetRange(ObjAccountAgents."Account No",Rec."Account No");
        if ObjAccountAgents.FindSet = true then begin
            HasSpecialMandateVisible := true;
            TransactingAgentVisible := true;
            TransactingAgentNameVisible := true;
        end;


        if (Rec."Transaction Type" = 'BATCHDEPOSIT') then begin
            ReceiptAllVisible := true;
        end;
    end;

    local procedure FnRunInsurance(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        /*IF RunningBalance > 0 THEN BEGIN
        LoanApp.RESET;
        LoanApp.SETCURRENTKEY(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
        LoanApp.SETRANGE(LoanApp."Client Code",ObjRcptBuffer."Member No");
        LoanApp.SETFILTER(LoanApp."Date filter",Datefilter);
        IF LoanApp.FIND('-') THEN
          BEGIN
            REPEAT
            LoanApp.CALCFIELDS(LoanApp."Loan Insurance Charged",LoanApp."Loan Insurance Paid");
              VarOutstandingInsurance:=LoanApp."Loan Insurance Charged"-LoanApp."Loan Insurance Paid";
            IF VarOutstandingInsurance>0 THEN
              BEGIN
                    IF  RunningBalance > 0 THEN
                      BEGIN
                        AmountToDeduct:=0;
                        AmountToDeduct:=ROUND(VarOutstandingInsurance,0.05,'>');
                        IF RunningBalance <= AmountToDeduct THEN
                        AmountToDeduct:=RunningBalance;
                        ObjReceiptTransactions.INIT;
                        ObjReceiptTransactions."Document No":=ObjRcptBuffer.No;
                        ObjReceiptTransactions."Member No":=ObjRcptBuffer."Member No";
                        ObjReceiptTransactions."Account Type":=ObjReceiptTransactions."Account Type"::Member;
                        ObjReceiptTransactions."Account No":=ObjRcptBuffer."Member No";
                        ObjReceiptTransactions."Loan No.":=LoanApp."Loan  No.";
                        ObjReceiptTransactions."Transaction Type":=ObjReceiptTransactions."Transaction Type"::"Loan Insurance Paid";
                        ObjReceiptTransactions."Global Dimension 1 Code":='BOSA';
                        ObjReceiptTransactions."Global Dimension 2 Code":=SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                        ObjReceiptTransactions.Amount:=AmountToDeduct;
                        IF ObjReceiptTransactions.Amount >0 THEN
                        ObjReceiptTransactions.INSERT(TRUE);
                        RunningBalance:=RunningBalance-ABS(ObjReceiptTransactions.Amount);
                    END;
                  END;
          UNTIL LoanApp.NEXT = 0;
          END;
          EXIT(RunningBalance);
        END;
        */

    end;

    local procedure FnRunInterest(VarMemberNo: Code[30]; RunningBalance: Decimal; VarDocumentNo: Code[30]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        VarInterestDue: Decimal;
    begin
        if RunningBalance > 0 then begin

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", VarMemberNo);
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    VarTotalLoanDue := SURESTEPFactory.FnRunLoanAmountDuePayroll(LoanApp."Loan  No.");
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            if LoanApp."Current Interest Due" > 0 then begin
                                if RunningBalance > 0 then begin
                                    if RunningBalance > LoanApp."Current Interest Due" then begin
                                        VarInterestDue := LoanApp."Current Interest Due";
                                    end
                                    else
                                        VarInterestDue := RunningBalance;
                                end;

                                ObjReceiptTransactions.Init;
                                ObjReceiptTransactions."Document No" := VarDocumentNo;
                                ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                                ObjReceiptTransactions."Member No" := LoanApp."Client Code";
                                ObjReceiptTransactions."Account No" := VarMemberNo;
                                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Interest Paid";
                                ObjReceiptTransactions."Global Dimension 1 Code" := Format(LoanApp.Source);
                                ObjReceiptTransactions.Amount := ROUND(VarInterestDue, 0.01, '=');
                                ObjReceiptTransactions.Description := Format(ObjReceiptTransactions."Transaction Type") + ' ' + LoanApp."Loan  No.";
                                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(VarMemberNo);
                                if ObjReceiptTransactions.Amount > 0 then
                                    ObjReceiptTransactions.Insert(true);
                                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunLoanInsurance(VarMemberNo: Code[30]; RunningBalance: Decimal; VarDocumentNo: Code[30]): Decimal
    var
        INSAmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        VarInsuranceDue: Decimal;
    begin
        if RunningBalance > 0 then begin

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", VarMemberNo);
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    VarTotalLoanDue := SURESTEPFactory.FnRunLoanAmountDuePayroll(LoanApp."Loan  No.");
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            if LoanApp."Current Interest Due" > 0 then begin
                                if RunningBalance > 0 then begin
                                    if RunningBalance > LoanApp."Current Insurance Due" then begin
                                        VarInsuranceDue := LoanApp."Current Insurance Due";
                                    end
                                    else
                                        VarInsuranceDue := RunningBalance;
                                end;

                                ObjReceiptTransactions.Init;
                                ObjReceiptTransactions."Document No" := VarDocumentNo;
                                ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                                ObjReceiptTransactions."Member No" := LoanApp."Client Code";
                                ObjReceiptTransactions."Account No" := VarMemberNo;
                                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                                //ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Insurance Paid";
                                ObjReceiptTransactions."Global Dimension 1 Code" := Format(LoanApp.Source);
                                ObjReceiptTransactions.Amount := ROUND(VarInsuranceDue, 0.01, '=');
                                ObjReceiptTransactions.Description := Format(ObjReceiptTransactions."Transaction Type") + ' ' + LoanApp."Loan  No.";
                                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(VarMemberNo);
                                if ObjReceiptTransactions.Amount > 0 then
                                    ObjReceiptTransactions.Insert(true);
                                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunLoanPenalty(VarMemberNo: Code[30]; RunningBalance: Decimal; VarDocumentNo: Code[30]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        INSAmountToDeduct: Decimal;
        VarPenaltyDue: Decimal;
    begin

        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", VarMemberNo);
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    VarTotalLoanDue := SURESTEPFactory.FnRunLoanAmountDuePayroll(LoanApp."Loan  No.");
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            if LoanApp."Current Penalty Due" > 0 then begin
                                if RunningBalance > 0 then begin
                                    if RunningBalance > LoanApp."Current Penalty Due" then begin
                                        VarPenaltyDue := LoanApp."Current Penalty Due";
                                    end
                                    else
                                        VarPenaltyDue := RunningBalance;
                                end;

                                ObjReceiptTransactions.Init;
                                ObjReceiptTransactions."Document No" := VarDocumentNo;
                                ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                                ObjReceiptTransactions."Member No" := LoanApp."Client Code";
                                ObjReceiptTransactions."Account No" := VarMemberNo;
                                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                                //ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Penalty Paid";
                                ObjReceiptTransactions."Global Dimension 1 Code" := Format(LoanApp.Source);
                                ObjReceiptTransactions.Amount := ROUND(VarPenaltyDue, 0.01, '=');
                                ObjReceiptTransactions.Description := Format(ObjReceiptTransactions."Transaction Type") + ' ' + LoanApp."Loan  No.";
                                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(VarMemberNo);
                                if ObjReceiptTransactions.Amount > 0 then
                                    ObjReceiptTransactions.Insert(true);
                                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunRecoverDebtCollectorFee(VarMemberNo: Code[30]; RunningBalance: Decimal; VarDocumentNo: Code[30]; VarReceiptAmount: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        INSAmountToDeduct: Decimal;
        VarPenaltyDue: Decimal;
        VarDebtCollectorFee: Decimal;
        VarDebtCollectorDed: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", VarMemberNo);
            LoanApp.SetRange(LoanApp."Loan Under Debt Collection", true);
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    VarTotalLoanDue := SURESTEPFactory.FnRunLoanAmountDuePayroll(LoanApp."Loan  No.");
                    if RunningBalance > 0 then begin
                        VarDebtCollectorFee := ((LoanApp."Loan Debt Collector Interest %" / 100) * VarReceiptAmount);
                        VarDebtCollectorFee := VarDebtCollectorFee + (0.16 * VarDebtCollectorFee);
                        if VarDebtCollectorFee > 0 then begin
                            if VarDebtCollectorFee > 0 then begin
                                if RunningBalance > VarDebtCollectorFee then begin
                                    VarDebtCollectorDed := VarDebtCollectorFee;
                                end
                                else
                                    VarDebtCollectorDed := RunningBalance;
                            end;

                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := VarDocumentNo;
                            ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                            ObjReceiptTransactions."Member No" := LoanApp."Client Code";
                            ObjReceiptTransactions."Account No" := LoanApp."Loan Debt Collector";
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Vendor;
                           // ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"FOSA Account";
                            ObjReceiptTransactions."Global Dimension 1 Code" := Format(LoanApp.Source);
                            ObjReceiptTransactions.Amount := ROUND(VarDebtCollectorDed, 0.01, '=');
                            ObjReceiptTransactions.Description := 'Debt Collection Charge + VAT from ' + LoanApp."Loan  No." + ' ' + LoanApp."Client Name";
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(VarMemberNo);
                            if ObjReceiptTransactions.Amount > 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;

                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(VarMemberNo: Code[30]; RunningBalance: Decimal; VarDocumentNo: Code[30]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        INSAmountToDeduct: Decimal;
    begin

        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", VarMemberNo);
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    VarTotalLoanDue := SURESTEPFactory.FnRunLoanAmountDuePayroll(LoanApp."Loan  No.");
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            if LoanApp."Current Principle Due" > 0 then begin
                                if RunningBalance > 0 then begin
                                    if RunningBalance > LoanApp."Current Principle Due" then begin
                                        varLRepayment := LoanApp."Current Principle Due";
                                    end
                                    else
                                        varLRepayment := RunningBalance;
                                end;

                                ObjReceiptTransactions.Init;
                                ObjReceiptTransactions."Document No" := VarDocumentNo;
                                ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                                ObjReceiptTransactions."Member No" := LoanApp."Client Code";
                                ObjReceiptTransactions."Account No" := VarMemberNo;
                                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::Repayment;
                                ObjReceiptTransactions."Global Dimension 1 Code" := Format(LoanApp.Source);
                                ObjReceiptTransactions.Amount := ROUND(varLRepayment, 0.01, '=');
                                ObjReceiptTransactions.Description := Format(ObjReceiptTransactions."Transaction Type") + ' ' + LoanApp."Loan  No.";
                                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(VarMemberNo);
                                if ObjReceiptTransactions.Amount > 0 then
                                    ObjReceiptTransactions.Insert(true);
                                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunLoanRecovery(VarMemberNo: Code[30]; RunningBalance: Decimal; VarDocumentNo: Code[30]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        INSAmountToDeduct: Decimal;
        ObjAccount: Record Vendor;
    begin

        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", VarMemberNo);
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    VarTotalLoanDue := SURESTEPFactory.FnRunLoanAmountDuePayroll(LoanApp."Loan  No.");
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            if VarTotalLoanDue > 0 then begin
                                if RunningBalance > 0 then begin
                                    if RunningBalance > VarTotalLoanDue then begin
                                        varLRepayment := VarTotalLoanDue;
                                    end
                                    else
                                        varLRepayment := RunningBalance;
                                end;

                                ObjAccount.Reset;
                                ObjAccount.SetRange(ObjAccount."BOSA Account No", Rec."Member No");
                                ObjAccount.SetRange(ObjAccount."Account Type", '507');
                                if ObjAccount.FindSet then begin

                                    ObjReceiptTransactions.Init;
                                    ObjReceiptTransactions."Document No" := VarDocumentNo;
                                    ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                                    ObjReceiptTransactions."Member No" := LoanApp."Client Code";
                                    ObjReceiptTransactions."Account No" := ObjAccount."No.";
                                    ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Vendor;
                                    //ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"FOSA Account";
                                    ObjReceiptTransactions."Global Dimension 1 Code" := Format(LoanApp.Source);
                                    ObjReceiptTransactions.Amount := ROUND(varLRepayment, 0.01, '=');
                                    ObjReceiptTransactions.Description := Format('Loan Repayment') + ' ' + LoanApp."Loan  No.";
                                    ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(VarMemberNo);
                                    if ObjReceiptTransactions.Amount > 0 then
                                        ObjReceiptTransactions.Insert(true);
                                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                                end;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunEntranceFee(VarMemberNo: Code[30]; RunningBalance: Decimal; VarDocumentNo: Code[30]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
        VarRegistrationFeeDiff: Decimal;
        VarTaxOnRegistrationFeeDiff: Decimal;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", VarMemberNo);
            ObjMember.SetFilter(ObjMember."Deposits Account No", '<>%1', '');
            ObjMember.SetFilter(ObjMember."Registration Date", '>%1', 20180102D); //To Ensure deduction is for New Members Only
            if ObjMember.Find('-') then begin
                ObjMember.CalcFields(ObjMember."Registration Fee Paid");
                if Abs(ObjMember."Registration Fee Paid") < GenSetup."BOSA Registration Fee Amount" then begin
                    if ObjMember."Registration Date" <> 0D then begin
                        VarRegistrationFeeDiff := (GenSetup."BOSA Registration Fee Amount" - Abs(ObjMember."Registration Fee Paid"));
                        VarTaxOnRegistrationFeeDiff := (ObjGensetup."Excise Duty(%)" / 100) * VarRegistrationFeeDiff;

                        AmountToDeduct := 0;
                        AmountToDeduct := VarRegistrationFeeDiff + VarTaxOnRegistrationFeeDiff;
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;
                        ObjReceiptTransactions.Init;
                        ObjReceiptTransactions."Document No" := VarDocumentNo;
                        ObjReceiptTransactions."Member No" := VarMemberNo;
                        ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                        ObjReceiptTransactions."Account No" := VarMemberNo;
                        ObjReceiptTransactions.Description := Format(ObjReceiptTransactions."transaction type"::"Registration Fee");
                        ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Registration Fee";
                        ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                        ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(VarMemberNo);
                        ObjReceiptTransactions.Amount := ROUND(AmountToDeduct, 0.01, '=');
                        if ObjReceiptTransactions.Amount <> 0 then
                            ObjReceiptTransactions.Insert(true);

                        //===========================================================================Tax On Registration Fee
                        ObjReceiptTransactions.Init;
                        ObjReceiptTransactions."Document No" := VarDocumentNo;
                        ObjReceiptTransactions."Member No" := VarMemberNo;
                        ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                        ObjReceiptTransactions."Account No" := VarMemberNo;
                        ObjReceiptTransactions.Description := Format(ObjReceiptTransactions."transaction type"::"Registration Fee");
                        ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Registration Fee";
                        ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                        ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(VarMemberNo);
                        ObjReceiptTransactions.Amount := ROUND(AmountToDeduct, 0.01, '=');
                        if ObjReceiptTransactions.Amount <> 0 then
                            ObjReceiptTransactions.Insert(true);
                        RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                    end;
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunShareCapital(VarMemberNo: Code[30]; RunningBalance: Decimal; VarDocNo: Code[30]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", VarMemberNo);
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                //REPEAT Deducted once unless otherwise advised
                ObjMember.CalcFields(ObjMember."Shares Retained");
                if ObjMember."Shares Retained" < GenSetup."Retained Shares" then begin
                    SharesCap := GenSetup."Retained Shares";
                    DIFF := SharesCap - ObjMember."Shares Retained";

                    if DIFF > 1 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := DIFF;
                            if DIFF > 10000 then
                                AmountToDeduct := 10000;
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;

                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := VarDocNo;
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                            ObjReceiptTransactions."Member No" := VarMemberNo;
                            ObjReceiptTransactions."Account No" := VarMemberNo;
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Share Capital";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(VarMemberNo);
                            ObjReceiptTransactions.Amount := ROUND(AmountToDeduct, 0.01, '=');
                            if ObjReceiptTransactions.Amount <> 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                end;
                //UNTIL RcptBufLines.NEXT=0;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunDepositContribution(VarMemberNo: Code[30]; RunningBalance: Decimal; VarDocNo: Code[30]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", VarMemberNo);
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                AmountToDeduct := 0;
                AmountToDeduct := ROUND(ObjMember."Monthly Contribution", 0.05, '>');
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;



                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Document No" := VarDocNo;
                ObjReceiptTransactions."Member No" := ObjMember."No.";
                ObjReceiptTransactions."Account No" := ObjMember."Deposits Account No";
                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Vendor;
                //ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"FOSA Account";
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(VarMemberNo);
                ObjReceiptTransactions.Amount := ROUND(AmountToDeduct, 0.01, '=');
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInsuranceContribution(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
    begin
        GenSetup.Get();
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin
                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."Benevolent Fund Contribution";
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                    ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                    ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                    //ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Insurance Contribution";
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                    ObjReceiptTransactions.Amount := ROUND(AmountToDeduct, 0.01, '=');
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunBenevolentFund(VarMemberNo: Code[30]; RunningBalance: Decimal; VarDocNo: Code[30]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
        ObjDetailedVendorLedger: Record "Detailed Vendor Ledg. Entry";
        VarCurrYear: Integer;
        VarCurrYearBeginDate: Date;
        VarLedgerDateFilter: Text;
        VarBenfundCurrYearCredits: Decimal;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", VarMemberNo);
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin

                    VarCurrYear := Date2dmy(WorkDate, 3);
                    VarCurrYearBeginDate := Dmy2date(1, 1, VarCurrYear);

                    VarLedgerDateFilter := Format(VarCurrYearBeginDate) + '..' + Format(WorkDate);
                    ObjDetailedVendorLedger.Reset;
                    ObjDetailedVendorLedger.SetRange("Vendor No.", ObjMember."Benevolent Fund No");
                    ObjDetailedVendorLedger.SetFilter(ObjDetailedVendorLedger."Posting Date", VarLedgerDateFilter);
                    if ObjDetailedVendorLedger.FindSet then begin
                        ObjDetailedVendorLedger.CalcSums(ObjDetailedVendorLedger."Credit Amount");
                        VarBenfundCurrYearCredits := ObjDetailedVendorLedger."Credit Amount";
                    end;


                    AmountToDeduct := 0;
                    if VarBenfundCurrYearCredits < GenSetup."Benevolent Fund Contribution" then begin
                        AmountToDeduct := GenSetup."Benevolent Fund Contribution" - VarBenfundCurrYearCredits;

                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;

                        ObjReceiptTransactions.Init;
                        ObjReceiptTransactions."Document No" := VarDocNo;
                        ObjReceiptTransactions."Member No" := ObjMember."No.";
                        ObjReceiptTransactions."Account No" := ObjMember."Benevolent Fund No";
                        ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Vendor;
                        ObjReceiptTransactions.Description := 'Benevolent Fund Contribution';
                      //  ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Benevolent Fund";
                        ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                        ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(VarMemberNo);
                        ObjReceiptTransactions.Amount := AmountToDeduct;
                        if ObjReceiptTransactions.Amount <> 0 then
                            ObjReceiptTransactions.Insert(true);
                        RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                    end;
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunUnallocatedAmount(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
        if ObjMember.Find('-') then begin
            begin
                AmountToDeduct := 0;
                AmountToDeduct := RunningBalance;
                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                //ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Unallocated Funds";
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                ObjReceiptTransactions.Amount := ROUND(AmountToDeduct, 0.01, '=');
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
            end;
        end;
    end;

    local procedure FnRunDepositContributionFromExcess(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
        ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
        if ObjMember.Find('-') then begin
            AmountToDeduct := 0;
            AmountToDeduct := RunningBalance + FnReturnAmountToClear('');
            ObjReceiptTransactions.Init;
            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
            ObjReceiptTransactions."Member No" := ObjMember."Deposits Account No";
            ObjReceiptTransactions."Account No" := ObjMember."Deposits Account No";
            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Vendor;
            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Deposit Contribution";
            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
            ObjReceiptTransactions.Amount := AmountToDeduct;
            if ObjReceiptTransactions.Amount <> 0 then
                ObjReceiptTransactions.Insert(true);
        end;
    end;

    local procedure FnReturnAmountToClear(VarAccountNo: Code[30]) AmountReturned: Decimal
    var
        ObjReceiptAllocation: Record "Receipt Allocation";
    begin
        ObjReceiptAllocation.Reset;
        ObjReceiptAllocation.SetRange("Document No", Rec.No);
        ObjReceiptAllocation.SetRange("Account No", VarAccountNo);
        if ObjReceiptAllocation.Find('-') then begin
            AmountReturned := ObjReceiptAllocation.Amount;
            ObjReceiptAllocation.Delete;
        end;
        exit;
    end;

    local procedure FnRunSavingsProductExcess(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record "Members Register";
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin

        AmountToDeduct := 0;
        AmountToDeduct := RunningBalance + FnReturnAmountToClear(Rec."Excess Funds Account");
        ObjReceiptTransactions.Init;
        ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
        ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
        ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Vendor;
        ObjReceiptTransactions."Account No" := ObjRcptBuffer."Excess Funds Account";
        ObjReceiptTransactions.Description := 'Cash Deposit';
        ObjReceiptTransactions.Validate(ObjReceiptTransactions."Account No");
        //ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"FOSA Account";
        ObjReceiptTransactions."Global Dimension 1 Code" := 'FOSA';
        ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
        ObjReceiptTransactions.Amount := AmountToDeduct;
        if ObjReceiptTransactions.Amount <> 0 then
            ObjReceiptTransactions.Insert(true);
    end;

    local procedure FnRunGetAccountAvailableBalance() VarAvailableBalance: Decimal
    var
        ObjAccount: Record Vendor;
        ObjAccountTypes: Record "Account Types-Saving Products";
        VarTotalUnprocessedCheques: Decimal;
        VarUnpostedATMTransactions: Decimal;
        VarChargesOnFixedDeposit: Decimal;
        VarTCharges: Decimal;
        VarMinAccBal: Decimal;
        VarIntervalPenalty: Decimal;
        VarFeeBelowMinBal: Decimal;
    begin
        VarUnpostedATMTransactions := 0;
        VarTCharges := 0;
        VarAvailableBalance := 0;
        VarMinAccBal := 0;
        VarTotalUnprocessedCheques := 0;
        VarIntervalPenalty := 0;


        if ObjAccount.Get(Rec."Account No") then begin
            ObjAccount.CalcFields(ObjAccount.Balance, ObjAccount."Uncleared Cheques", ObjAccount."ATM Transactions");

            ObjAccountTypes.Reset;
            ObjAccountTypes.SetRange(ObjAccountTypes.Code, Rec."Savings Product");
            if ObjAccountTypes.FindSet then begin
                VarMinAccBal := ObjAccountTypes."Minimum Balance";
                VarFeeBelowMinBal := ObjAccountTypes."Fee Below Minimum Balance";


                //-------------------------------------------------------------------------------------------------Withdrawal Interval
                if ObjAccount.Status <> ObjAccount.Status::Deceased then begin
                    if Rec.Type = 'Withdrawal' then begin
                        ObjAccountTypes.Reset;
                        ObjAccountTypes.SetRange(ObjAccountTypes.Code, Rec."Savings Product");
                        if ObjAccount."Last Withdrawal Date" <> 0D then begin
                            if CalcDate(ObjAccountTypes."Withdrawal Interval", ObjAccount."Last Withdrawal Date") > Today then
                                IntervalPenalty := ObjAccountTypes."Withdrawal Penalty";
                        end;
                    end;
                    //---------------------------------------------------------------------------------------------------End Withdrawal Interval

                    //Fixed Deposit
                    VarChargesOnFixedDeposit := 0;
                    if ObjAccountTypes."Fixed Deposit" = true then begin
                        if ObjAccount."Expected Maturity Date" > Today then
                            VarChargesOnFixedDeposit := ObjAccountTypes."Charge Closure Before Maturity";
                    end;

                    VarTotalUnprocessedCheques := ObjAccount."Uncleared Cheques";
                    VarUnpostedATMTransactions := ObjAccount."ATM Transactions";

                    //FD
                    if ObjAccountTypes."Fixed Deposit" = false then begin
                        if ObjAccount.Balance < VarMinAccBal then
                            VarAvailableBalance := ObjAccount.Balance - VarFeeBelowMinBal - VarTCharges - VarMinAccBal - VarTotalUnprocessedCheques - VarUnpostedATMTransactions -
                                              ObjAccount."EFT Transactions" + ObjAccount."Cheque Discounted"// IntervalPenalty -
                        else
                            VarAvailableBalance := ObjAccount.Balance - VarTCharges - VarMinAccBal - VarTotalUnprocessedCheques - VarUnpostedATMTransactions -
                                              ObjAccount."EFT Transactions" + ObjAccount."Cheque Discounted";//IntervalPenalty -
                    end else begin
                        VarAvailableBalance := ObjAccount.Balance - VarTCharges - VarChargesOnFixedDeposit - ObjAccount."ATM Transactions" + ObjAccount."Cheque Discounted";
                    end;
                end;
            end;
        end;

        if Rec."N.A.H Balance" <> 0 then
            VarAvailableBalance := Rec."N.A.H Balance";
        exit(VarAvailableBalance);
    end;

    local procedure FnRunPostChequeDeposit()
    var
        ObjTellerTill: Record "Bank Account";
        ObjChequeTypes: Record "Cheque Types";
        VarClearingCharge: Decimal;
        VarClearingChargeAccount: Code[30];
        ObjTrans: Record Transactions;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "Au Factory";
    begin
        ObjGensetup.Get();
        Rec.TestField(Amount);
        BATCH_TEMPLATE := 'PURCHASES';
        BATCH_NAME := 'FTRANS';
        DOCUMENT_NO := Rec.No;
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;



        //------------------------------------------------------------------------------Check teller transaction limits


        if Rec."Type _Transactions" = Rec."type _transactions"::"Cheque Deposit" then begin

            if ObjChequeTypes.Get(Rec."Cheque Type") then begin
                if ObjChequeTypes."Use %" = true then begin
                    VarClearingCharge := ((ObjChequeTypes."% Of Amount" * 0.01) * Rec.Amount);
                    VarClearingChargeAccount := ObjChequeTypes."Clearing Charges GL Account";
                end else
                    VarClearingCharge := ObjChequeTypes."Clearing Charges";
                VarClearingChargeAccount := ObjChequeTypes."Clearing Charges GL Account";
            end;

            //------------------------------------1. CREDIT MEMBER A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor,Rec."Account No", WorkDate, Rec.Amount * -1, 'FOSA', '',
            'Cheque Deposit #' +Rec."Cheque No" + ' - ' +Rec."Cheque Deposit Remarks", '', GenJournalLine."application source"::" ");
            //--------------------------------(Credit Member Account)---------------------------------------------

            //------------------------------------2. DEBIT TELLER BANK A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"Bank Account",Rec."Cheque Clearing Bank Code", WorkDate, Rec.Amount, 'FOSA', '',
            'Cheque Deposit #' +Rec."Cheque No" + ' - ' +Rec."Cheque Deposit Remarks" + 'Acc. ' +Rec."Account No", '', GenJournalLine."application source"::" ");
            //----------------------------------(Debit Teller Bank Account)------------------------------------------------

            //------------------------------------3. DEBIT MEMBER  A/C  COMM---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor,Rec."Account No", WorkDate, 'Cheque Deposit Charge #' +Rec."Cheque No" + 'Acc. ' +Rec."Account No", GenJournalLine."bal. account type"::"G/L Account",
            VarClearingChargeAccount, VarClearingCharge, 'FOSA', '');
            //--------------------------------------(Debit Member A/C Comm)-------------------------------------------------------------------------------

            //------------------------------------4. DEBIT MEMBER  A/C TAX ON COMM---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor,Rec."Account No", WorkDate, 'Tax: Cheque Deposit Charge #' +Rec."Cheque No" + 'Acc. ' +Rec."Account No", GenJournalLine."bal. account type"::"G/L Account",
            ObjGensetup."Excise Duty Account", VarClearingCharge * (ObjGensetup."Excise Duty(%)" / 100), 'FOSA', '');
            //--------------------------------------(Debit Member A/C Tax On Comm)-------------------------------------------------------------------------------


            //CU posting
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);


            Rec.Posted := true;
            Rec.Authorised := Rec.Authorised::Yes;
            Rec."Supervisor Checked" := true;
            Rec."Needs Approval" := Rec."needs approval"::No;
            Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;
            if ChequeTypes."Clearing  Days" = 0 then begin
                Rec.Status := Rec.Status::Honoured;
                Rec."Date Cleared" := Today;
            end;
           Rec. Modify;
        end;
        Message('Cheque Deposited Successfully.');

        ObjTrans.Reset;
        ObjTrans.SetRange(ObjTrans.No, Rec.No);
        if ObjTrans.Find('-') then begin
            Report.run(172500, false, true, ObjTrans);
        end;

    end;

    local procedure FnRunPostBankersCheque()
    var
        ObjCharges: Record Charges;
        VarBankersChequeComm: Decimal;
        VarBankersChequeCommAcc: Code[30];
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "Au Factory";
        VarAvailableBalance: Decimal;
        VarTaxonBankersChequeFee: Decimal;
        VarSaccoComm: Decimal;
    begin
        ObjGensetup.Get();
        BATCH_TEMPLATE := 'PURCHASES';
        BATCH_NAME := 'FTRANS';
        DOCUMENT_NO := Rec.No;
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        //---------------------------------------------------------------Check withdrawal limits
        VarAvailableBalance := FnRunGetAccountAvailableBalance;
        if Rec."Type _Transactions" = Rec."type _transactions"::"Bankers Cheque" then begin
            if VarAvailableBalance < Rec.Amount then begin
                if Rec.Authorised = Rec.Authorised::Yes then begin
                    Rec.Overdraft := true;
                    Rec.Modify;
                end;
                if Rec.Authorised = Rec.Authorised::No then begin
                    if Rec."Branch Transaction" = false then begin
                        Rec."Authorisation Requirement" := 'Bankers Cheque - Over draft';
                        Rec.Modify;
                        Message('You cannot issue a Bankers cheque more than the available balance unless authorised.');
                        SendEmail;
                        exit;
                    end;
                end;
                if Rec.Authorised = Rec.Authorised::Rejected then
                    Error('Bankers cheque transaction has been rejected and therefore cannot proceed.');
            end;
        end;
        //------------------------------------------------------------------Check withdrawal limits

        //------------------------------------------------------------------Bankers Cheque Commission
        ObjCharges.Reset;
        ObjCharges.SetRange(ObjCharges."Charge Type", ObjCharges."charge type"::"Bankers Cheque Fee");
        if ObjCharges.FindSet then begin
            if ObjCharges."Use Percentage" <> true then begin
                VarBankersChequeComm := ObjCharges."Charge Amount";
                VarBankersChequeCommAcc := ObjCharges."GL Account"
            end else
                VarBankersChequeComm := Rec.Amount * (ObjCharges."Percentage of Amount" / 100);
            VarBankersChequeCommAcc := ObjCharges."GL Account";

            VarSaccoComm := ObjCharges."Sacco Amount";
        end;
        VarTaxonBankersChequeFee := VarBankersChequeComm * (ObjGensetup."Excise Duty(%)" / 100);


        //------------------------------------------------------------------End Bankers Cheque Commission


        //------------------------------------1. DEBIT MEMBER A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor,Rec."Account No", WorkDate, Rec.Amount, 'FOSA',Rec."Bankers Cheque No",
        'Bankers Cheque #' +Rec."Bankers Cheque No" + ' to ' + Rec.Payee, '', GenJournalLine."application source"::" ");
        //--------------------------------(Debit Member Account)---------------------------------------------

        //------------------------------------2. CREDIT TELLER BANK A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"Bank Account",Rec."Cheque Clearing Bank Code", WorkDate, Rec.Amount * -1, 'FOSA',Rec."Bankers Cheque No",
        'Bankers Cheque #' +Rec."Bankers Cheque No" + ' to ' + Rec.Payee + ' from Acc. ' +Rec."Account No", '', GenJournalLine."application source"::" ");
        //----------------------------------(Credit Teller Bank Account)------------------------------------------------

        //------------------------------------3. DEBIT MEMBER  A/C  COMM---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor,Rec."Account No", WorkDate, (VarBankersChequeComm), 'FOSA',Rec."Bankers Cheque No",
        'Bankers Cheque Charge #' +Rec."Bankers Cheque No" + ' Acc. ' +Rec."Account No", '', GenJournalLine."application source"::" ");

        //--------------------------------------(Debit Member A/C Comm)-------------------------------------------------------------------------------

        //------------------------------------4. DEBIT MEMBER  A/C  TAX---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor,Rec."Account No", WorkDate, (VarTaxonBankersChequeFee), 'FOSA',Rec."Bankers Cheque No",
        'Tax: Bankers Cheque Charge #' +Rec."Bankers Cheque No" + ' Acc. ' +Rec."Account No", '', GenJournalLine."application source"::" ");

        //--------------------------------------(Debit Member A/C Tax)-------------------------------------------------------------------------------

        //------------------------------------5. CREDIT BANK  A/C  COMM---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"Bank Account",Rec."Cheque Clearing Bank Code", WorkDate,
        ((VarBankersChequeComm - VarSaccoComm) + ((VarBankersChequeComm - VarSaccoComm) * ObjGensetup."Excise Duty(%)" / 100)) * -1, 'FOSA',Rec."Bankers Cheque No",
        'Bankers Cheque Charge + Tax #' +Rec."Bankers Cheque No" + ' Acc. ' +Rec."Account No", '', GenJournalLine."application source"::" ");
        //--------------------------------------(Credit Bank A/C Comm)-------------------------------------------------------------------------------

        //------------------------------------6. CREDIT SACCO INCOME  A/C  COMM---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"G/L Account", VarBankersChequeCommAcc, WorkDate, (VarSaccoComm) * -1, 'FOSA',Rec."Bankers Cheque No",
        'Bankers Cheque Charge #' +Rec."Bankers Cheque No" + ' Acc. ' +Rec."Account No", '', GenJournalLine."application source"::" ");

        //--------------------------------------(Credit Sacco SACCO Income A/C Comm)-------------------------------------------------------------------------------

        //------------------------------------7. CREDIT TAX  A/C TAX ON COMM---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", WorkDate,
        (VarSaccoComm * (ObjGensetup."Excise Duty(%)" / 100)) * -1, 'FOSA',Rec."Bankers Cheque No",
        'Tax: Bankers Cheque Charge #' +Rec."Bankers Cheque No" + ' Acc. ' +Rec."Account No", '', GenJournalLine."application source"::" ");

        //--------------------------------------(Credit Tax A/C Tax On Comm)-------------------------------------------------------------------------------


        //CU posting
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);



        Rec."Transaction Available Balance" := VarAvailableBalance;
        Rec.Posted := true;
        Rec.Authorised := Rec.Authorised::Yes;
        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Modify;

        Message('Bankers cheque posted successfully.');
    end;

    local procedure FnRunPostCashDeposit()
    var
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "Au Factory";
        VarAvailableBalance: Decimal;
        ObjTransactionsII: Record Transactions;
        VarTillNo: Code[30];
        ObjTellerTill: Record "Bank Account";
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
    begin

        VarTillNo := '';
        ObjTellerTill.Reset;
        ObjTellerTill.SetRange(ObjTellerTill."Account Type", ObjTellerTill."account type"::Cashier);
        ObjTellerTill.SetRange(ObjTellerTill.CashierID, UserId);
        if ObjTellerTill.Find('-') then begin
            VarTillNo := ObjTellerTill."No.";


            if Rec.Amount > ObjTellerTill."Max Deposit Limit" then begin
                if Rec.Authorised = Rec.Authorised::No then begin
                    Rec."Authorisation Requirement" := 'Deposit above teller Limit';
                    Rec."Post Attempted" := true;
                    Rec."Needs Approval" := Rec."needs approval"::Yes;
                    Rec."Supervisor Checked" := false;
                    Rec.Modify;
                    Message('You cannot deposit more than your allowed limit of %1 unless authorised.', ObjTellerTill."Max Deposit Limit");
                    exit;
                end;
                if Rec.Authorised = Rec.Authorised::Rejected then
                    Error('Transaction has been rejected therefore you cannot proceed.');
            end;








            ObjGensetup.Get();
            BATCH_TEMPLATE := 'PURCHASES';
            BATCH_NAME := 'FTRANS';
            DOCUMENT_NO := Rec.No;
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            GenJournalLine.DeleteAll;



            //------------------------------------1. CREDIT MEMBER A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor,Rec."Account No", WorkDate, Rec.Amount * -1, 'FOSA', '',
            Rec."Transaction Type" + '-' + Rec.Description, '', GenJournalLine."application source"::" ");
            //--------------------------------(Credit Member Account)---------------------------------------------

            //------------------------------------2. DEBIT TELLER BANK A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"Bank Account", VarTillNo, WorkDate, Rec.Amount, 'FOSA', '',
            Rec."Transaction Type" + '-' + Rec.Description, '', GenJournalLine."application source"::" ");
            //----------------------------------(Debit Teller Bank Account)------------------------------------------------



            //CU posting
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);



            Rec."Transaction Available Balance" := VarAvailableBalance;
            Rec.Posted := true;
            Rec.Authorised := Rec.Authorised::Yes;
            Rec."Supervisor Checked" := true;
            Rec."Needs Approval" := Rec."needs approval"::No;
            Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;
            Rec.Modify;
            Message('Cash Deposit Posted successfully.');

            ObjTransactionsII.Reset;
            ObjTransactionsII.SetRange(ObjTransactionsII.No, Rec.No);
            if ObjTransactionsII.Find('-') then begin
                Report.run(172498, false, true, ObjTransactionsII);
            end;


            SURESTEPFactory.FnRunAfterCashDepositProcess(Rec."Account No");

            FnRunFlagTransactions;
        end else
            Error('You have not been setup as a Cashier. Transaction can not be Posted');
    end;

    local procedure FnRunPostCashWithdrawal()
    var
        ObjTellerTill: Record "Bank Account";
        VarTillNo: Code[30];
        ObjTransactionCharges: Record "Transaction Charges";
        VarTranChargeAmount: Decimal;
        ObjTransactionsII: Record Transactions;
        ObjGraduatedCharge: Record "CWithdrawal Graduated Charges";
        VarChargeAmount: Decimal;
        VarChargeAccount: Code[30];
        ObjAccount: Record Vendor;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "Au Factory";
        VarAvailableBalance: Decimal;
    begin
        ObjGensetup.Get();
        BATCH_TEMPLATE := 'PURCHASES';
        BATCH_NAME := 'FTRANS';
        DOCUMENT_NO := Rec.No;
        Rec."Post Attempted" := true;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;







        VarTillNo := '';
        VarChargeAmount := 0;
        ObjTellerTill.Reset;
        ObjTellerTill.SetRange(ObjTellerTill."Account Type", ObjTellerTill."account type"::Cashier);
        ObjTellerTill.SetRange(ObjTellerTill.CashierID, UserId);
        if ObjTellerTill.Find('-') then begin
            VarTillNo := ObjTellerTill."No.";
            ObjTellerTill.CalcFields(ObjTellerTill.Balance);
            CurrentTellerAmount := ObjTellerTill.Balance;

            if CurrentTellerAmount - Rec.Amount <= ObjTellerTill."Min. Balance" then
                Message('You need to add more money from the treasury since your balance has gone below the teller replenishing level.');

            if (Rec."Type _Transactions" = Rec."type _transactions"::Withdrawal) or (Rec."Type _Transactions" = Rec."type _transactions"::Encashment) then begin
                if (CurrentTellerAmount - Rec.Amount) < 0 then
                    Error('You do not have enough money to carry out this transaction.');
            end;

            if (TransactionTypes.Type = TransactionTypes.Type::Withdrawal) or (TransactionTypes.Type = TransactionTypes.Type::Encashment) then begin
                if CurrentTellerAmount - Rec.Amount >= ObjTellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
            end else begin
                if CurrentTellerAmount - Rec.Amount >= ObjTellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
            end;

            //----------------------------------------------------------------------------------------------Check teller transaction limits
            if Rec."Type _Transactions" = Rec."type _transactions"::Withdrawal then begin
                if Rec.Amount > ObjTellerTill."Max Withdrawal Limit" then begin
                    if Rec.Authorised = Rec.Authorised::No then begin
                        Rec."Authorisation Requirement" := 'Withdrawal Above teller Limit';
                        Rec.Modify;
                        MailContent := 'The' + ' ' + 'Cashier' + ' ' + Rec.Cashier + ' ' +
                        'cannot withdraw more than allowed ,limit, Maximum limit is' + '' + Format(ObjTellerTill."Max Withdrawal Limit") +
                        'you need to authorise';
                        SendEmail;
                        Message('You cannot withdraw more than your allowed limit of %1 unless authorised.', ObjTellerTill."Max Withdrawal Limit");
                        exit;
                    end;
                    if Rec.Authorised = Rec.Authorised::Rejected then
                        Error('Transaction has been rejected and therefore cannot proceed.');
                end;
            end;

            //---------------------------------------------------------------Prevent teller from Overdrawing Till
            if Rec."Type _Transactions" = Rec."type _transactions"::Withdrawal then begin
                ObjTellerTill.CalcFields(ObjTellerTill.Balance);
                if Rec.Amount > ObjTellerTill.Balance then begin
                    Error('you cannot transact below your Till balance.');
                end;
            end;
            //-----------------------------------------------------------------End Prevent teller from Overdrawing Till

            if VarTillNo = '' then
                Error('Teller account not set-up.');



            //------------------------------------1. DEBIT MEMBER  A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor,Rec."Account No", WorkDate,Rec."Transaction Type" + '-' + Rec.Description, GenJournalLine."bal. account type"::"Bank Account",
            VarTillNo, Rec.Amount, 'FOSA', '');
            //--------------------------------------(Debit Member A/C)-------------------------------------------------------------------------------


            if Rec."Use Graduated Charges" = false then begin
                ObjTransactionCharges.Reset;
                ObjTransactionCharges.SetRange(ObjTransactionCharges."Transaction Type",Rec."Transaction Type");
                if ObjTransactionCharges.Find('-') then begin
                    repeat
                        if ObjTransactionCharges."Use Percentage" <> true then begin
                            VarTranChargeAmount := ObjTransactionCharges."Charge Amount"
                        end else
                            VarTranChargeAmount := Rec.Amount * (ObjTransactionCharges."Percentage of Amount" / 100);

                        //------------------------------------2. DEBIT MEMBER  A/C TRANSACTION CHARGES---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor,Rec."Account No", WorkDate, ObjTransactionCharges.Description, GenJournalLine."bal. account type"::"G/L Account",
                        ObjTransactionCharges."G/L Account", VarTranChargeAmount, 'FOSA', '');
                    //--------------------------------------(Debit Member A/C Transaction Charges)-------------------------------------------------------------------------------

                    until ObjTransactionCharges.Next = 0;
                end;
            end;


            ObjTransactionsII.Reset;
            ObjTransactionsII.SetRange(ObjTransactionsII.No, Rec.No);
            ObjTransactionsII.SetRange(ObjTransactionsII."Use Graduated Charges", true);
            ObjTransactionsII.SetRange(ObjTransactionsII."Bulk Withdrawal Appl Done", false);
            ObjTransactionsII.SetRange(ObjTransactionsII."Normal Transaction Charge", true);
            if ObjTransactionsII.FindSet then begin
                ObjGraduatedCharge.Reset;
                ObjGraduatedCharge.SetRange(ObjGraduatedCharge."Notice Status", ObjGraduatedCharge."notice status"::" ");
                if ObjGraduatedCharge.Find('-') then begin
                    repeat
                        if (Rec.Amount >= ObjGraduatedCharge."Minimum Amount") and (Rec.Amount <= ObjGraduatedCharge."Maximum Amount") then begin
                            if ObjGraduatedCharge."Use Percentage" = true then begin
                                VarChargeAmount := Rec.Amount * (ObjGraduatedCharge."Percentage of Amount" / 100);
                                VarChargeAccount := ObjGraduatedCharge."Charge Account"
                            end else
                                VarChargeAmount := ObjGraduatedCharge.Amount;
                            VarChargeAccount := ObjGraduatedCharge."Charge Account";
                        end;
                    until ObjGraduatedCharge.Next = 0;
                end;
            end;



            ObjTransactionsII.Reset;
            ObjTransactionsII.SetRange(ObjTransactionsII.No, Rec.No);
            ObjTransactionsII.SetRange(ObjTransactionsII."Use Graduated Charges", true);
            ObjTransactionsII.SetRange(ObjTransactionsII."Bulk Withdrawal Appl Done", true);
            if ObjTransactionsII.FindSet then begin
                ObjGraduatedCharge.Reset;
                ObjGraduatedCharge.SetRange(ObjGraduatedCharge."Notice Status", ObjGraduatedCharge."notice status"::"With Notice");
                if ObjGraduatedCharge.Find('-') then begin
                    repeat
                        if (Rec.Amount >= ObjGraduatedCharge."Minimum Amount") and (Rec.Amount <= ObjGraduatedCharge."Maximum Amount") then begin
                            if ObjGraduatedCharge."Use Percentage" = true then begin
                                VarChargeAmount := Rec.Amount * (ObjGraduatedCharge."Percentage of Amount" / 100);
                                VarChargeAccount := ObjGraduatedCharge."Charge Account"
                            end else
                                VarChargeAmount := ObjGraduatedCharge.Amount;
                            VarChargeAccount := ObjGraduatedCharge."Charge Account";
                        end;
                    until ObjGraduatedCharge.Next = 0;
                end;
            end;



            ObjTransactionsII.Reset;
            ObjTransactionsII.SetRange(ObjTransactionsII.No, Rec.No);
            ObjTransactionsII.SetRange(ObjTransactionsII."Use Graduated Charges", true);
            ObjTransactionsII.SetRange(ObjTransactionsII."Bulk Withdrawal Appl Done", false);
            if ObjTransactionsII.FindSet then begin
                ObjGraduatedCharge.Reset;
                ObjGraduatedCharge.SetRange(ObjGraduatedCharge."Notice Status", ObjGraduatedCharge."notice status"::"Without Notice");
                if ObjGraduatedCharge.Find('-') then begin
                    repeat
                        if (Rec.Amount >= ObjGraduatedCharge."Minimum Amount") and (Rec.Amount <= ObjGraduatedCharge."Maximum Amount") then begin
                            if ObjGraduatedCharge."Use Percentage" = true then begin
                                VarChargeAmount := Rec.Amount * (ObjGraduatedCharge."Percentage of Amount" / 100);
                                VarChargeAccount := ObjGraduatedCharge."Charge Account"
                            end else
                                VarChargeAmount := ObjGraduatedCharge.Amount;
                            VarChargeAccount := ObjGraduatedCharge."Charge Account";
                        end;
                    until ObjGraduatedCharge.Next = 0;
                end;
            end;



            //------------------------------------2. DEBIT MEMBER  A/C TRANSACTION CHARGES---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor,Rec."Account No", WorkDate, 'Cash Withdrawal Fee', GenJournalLine."bal. account type"::"G/L Account",
            VarChargeAccount, VarChargeAmount, 'FOSA', '');
            //--------------------------------------(Debit Member A/C Transaction Charges)-------------------------------------------------------------------------------

            //------------------------------------3. DEBIT MEMBER  A/C TAX:TRANSACTION CHARGES---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor,Rec."Account No", WorkDate, 'Tax:Cash Withdrawal Fee', GenJournalLine."bal. account type"::"G/L Account",
            ObjGensetup."Excise Duty Account", VarChargeAmount * (ObjGensetup."Excise Duty(%)" / 100), 'FOSA', '');
            //--------------------------------------(Debit Member A/C Tax:Transaction Charges)-------------------------------------------------------------------------------





            //CU posting
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);


            Rec."Transaction Available Balance" := VarAvailableBalance;
            Rec.Posted := true;
            Rec.Authorised := Rec.Authorised::Yes;
            Rec."Supervisor Checked" := true;
            Rec."Needs Approval" := Rec."needs approval"::No;
            Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;
            Rec.Modify;

            //--------------------------------------------------------------------Clear Bulk Withdrawal Details
            if ObjAccount.Get(Rec."Account No") and (Rec."Transaction Date" = Today) then begin
                ObjAccount."Bulk Withdrawal App Done By" := '';
                ObjAccount."Bulk Withdrawal Appl Amount" := 0;
                ObjAccount."Bulk Withdrawal Appl Date" := 0D;
                ObjAccount."Bulk Withdrawal Appl Done" := false;
                ObjAccount."Bulk Withdrawal Fee" := 0;
                ObjAccount.Modify;
            end;
            //--------------------------------------------------------------------End Clear Bulk Withdrawal Details
            FnRunFlagTransactions;


            ObjTransactionsII.Reset;
            ObjTransactionsII.SetRange(ObjTransactionsII.No, Rec.No);
            if ObjTransactionsII.Find('-') then begin
                Report.run(172499, false, true, ObjTransactionsII);
            end;

        end else
            Error('You have not been setup as a Cashier. Transaction can not be Posted');


    end;

    local procedure FnRunPostBackOfficeTransactions()
    var
        ObjStandingOrder: Record "Standing Orders";
        VarLoanNo: Code[20];
        VarDate: Integer;
        VarCurrMonthEndDate: Date;
        ObjLSchedule: Record "Loan Repayment Schedule";
        VarScheduledLoanBal: Decimal;
        VarDateFilter: Text;
        VarLBal: Decimal;
        VarArrears: Decimal;
        VarMonth: Integer;
        VarYear: Integer;
        VarCurrMonthBeginDate: Date;
        VarScheduleDateFilter: Text;
        VarScheduleRepayDate: Date;
        VarScheduleInterest: Decimal;
        VarScheduleInsurance: Decimal;
        ObjReceiptAllocations: Record "Receipt Allocation";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "Au Factory";
        ObjTransactionsII: Record Transactions;
        VarReceivableTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Loan Penalty Charged","Loan Penalty Paid";
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        VarReceivableAccount: Code[30];
        VarLSABal: Decimal;
        ObjBanks: Record "Bank Account";
        VarReceiptBank: Code[30];
    begin

        ObjGensetup.Get();
        BATCH_TEMPLATE := 'PURCHASES';
        BATCH_NAME := 'FTRANS';
        DOCUMENT_NO := Rec.No;
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks.CashierID, UserId);
        if ObjBanks.FindSet then begin
            VarReceiptBank := ObjBanks."No.";
        end;

        //------------------------------------1. DEBIT RECEIPT BANK  A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"Bank Account", VarReceiptBank, WorkDate,Rec. Amount, 'FOSA', '',
        Rec.Description, '', GenJournalLine."application source"::" ");
        //--------------------------------------(Debit Receipt Bank A/C)-------------------------------------------------------------------------------



        ObjReceiptAllocations.Reset;
        ObjReceiptAllocations.SetRange(ObjReceiptAllocations."Document No", Rec.No);
        //ObjReceiptAllocations.SetFilter(ObjReceiptAllocations."Transaction Type", '<>%1', ObjReceiptAllocations."transaction type"::"FOSA Account");
        if ObjReceiptAllocations.Find('-') then begin
            repeat
                //------------------------------------2. CREDIT DESTINATION  A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptAllocations."Transaction Type",
                ObjReceiptAllocations."Account Type", ObjReceiptAllocations."Member No", WorkDate, ObjReceiptAllocations.Amount * -1, 'BOSA', '',
                ObjReceiptAllocations.Description, ObjReceiptAllocations."Loan No.", GenJournalLine."application source"::" ");
            //--------------------------------(Credit Destination Account)-------------------------------------------------------------------------------
            until ObjReceiptAllocations.Next = 0;
        end;

        //====================================================================================Receivable Entries
        ObjReceiptAllocations.Reset;
        ObjReceiptAllocations.SetRange(ObjReceiptAllocations."Document No", Rec.No);
        //ObjReceiptAllocations.SetFilter(ObjReceiptAllocations."Transaction Type", '<>%1', ObjReceiptAllocations."transaction type"::"FOSA Account");
        ObjReceiptAllocations.SetFilter(ObjReceiptAllocations."Transaction Type", '=%1|%2|%3', ObjReceiptAllocations."transaction type"::"Interest Paid");
        if ObjReceiptAllocations.Find('-') then begin
            repeat
                if ObjReceiptAllocations."Transaction Type" = ObjReceiptAllocations."transaction type"::"Interest Paid" then begin
                    VarReceivableTransactionType := Varreceivabletransactiontype::"Interest Due";

                    if ObjLoans.Get(ObjReceiptAllocations."Loan No.") then begin
                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarReceivableAccount := ObjLoanType."Receivable Interest Account";
                        end;
                    end;

                end ;

                //------------------------------------2. DEBIT RECEIVABLE  A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, VarReceivableTransactionType, GenJournalLine."account type"::None, ObjReceiptAllocations."Member No",
                WorkDate, Format(VarReceivableTransactionType) + ' ' + LoanApp."Loan  No.", GenJournalLine."bal. account type"::"G/L Account", VarReceivableAccount, ObjReceiptAllocations.Amount, 'BOSA', ObjReceiptAllocations."Loan No.")
             //--------------------------------(Debit Receivable Account)-------------------------------------------------------------------------------
             until ObjReceiptAllocations.Next = 0;
        end;
        //====================================================================================End Receivable Entries


        // ObjReceiptAllocations.Reset;
        // ObjReceiptAllocations.SetRange(ObjReceiptAllocations."Document No", Rec.No);
        // ObjReceiptAllocations.SetFilter(ObjReceiptAllocations."Transaction Type", '=%1', ObjReceiptAllocations."transaction type"::"FOSA Account");
        // if ObjReceiptAllocations.Find('-') then begin
        //     repeat
        //         //------------------------------------3. CREDIT DESTINATION  A/C---------------------------------------------------------------------------------------------
        //         LineNo := LineNo + 10000;
        //         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptAllocations."Transaction Type",
        //         ObjReceiptAllocations."Account Type", ObjReceiptAllocations."Account No", WorkDate, ObjReceiptAllocations.Amount * -1, 'BOSA', '',
        //         ObjReceiptAllocations.Description, ObjReceiptAllocations."Loan No.", GenJournalLine."application source"::" ");
        //     //--------------------------------(Credit Destination Account)-------------------------------------------------------------------------------
        //     until ObjReceiptAllocations.Next = 0;
        // end;

        ObjCust.CalcFields(ObjCust."Current Shares");
        ObjCust.Reset;
        ObjCust.SetRange(ObjCust."No.",Rec."Member No");
        if ObjCust.FindSet then begin
            ObjCust.CalcFields(ObjCust."Current Shares");
            VarDepositBal := ObjCust."Current Shares";
        end;

        //============================================================================================Recover Penalty Arrears
        SFactory.FnRunCreateDepositArrearsPenaltyJournals(Rec."Member No", BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, WorkDate, DOCUMENT_NO, VarDepositBal, LineNo);
        //============================================================================================End Recover Penalty Arrears
        //CU posting
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

        Rec.Posted := true;
        Rec.Authorised := Rec.Authorised::Yes;
        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Modify;

        //========================================================================================Run Loan Recovery From LSA
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."BOSA Account No",Rec."Member No");
        ObjAccount.SetRange(ObjAccount."Account Type", '507');
        if ObjAccount.FindSet then begin
            ObjAccount.CalcFields(ObjAccount."Balance (LCY)");
            VarLSABal := ObjAccount."Balance (LCY)";




            ObjReceiptAllocations.Reset;
            ObjReceiptAllocations.SetRange(ObjReceiptAllocations."Document No", Rec.No);
            ObjReceiptAllocations.SetFilter(ObjReceiptAllocations."Loan No.", '<>%1', '');
            if ObjReceiptAllocations.Find('-') then begin
                repeat
                    SFactory.FnCreateLoanRecoveryJournalsAdvance(ObjReceiptAllocations."Loan No.", BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO,Rec."Member No",
                              Rec."Transaction Date", Rec.No, ObjAccount."No.",Rec."Member Name", VarLSABal);
                until ObjReceiptAllocations.Next = 0;
            end;
        end;

        //CU posting
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
        //========================================================================================End Run Loan Recovery LSA

        Message('Transaction Posted Succesfully');
        ObjTransactionsII.Reset;
        ObjTransactionsII.SetRange(ObjTransactionsII.No, Rec.No);
        if ObjTransactionsII.Find('-') then begin
            Report.run(172517, false, true, ObjTransactionsII);
        end;


    end;

    local procedure FnRunSuggestMonthlyContribution()
    begin
        Rec.TestField(Posted, false);
        Rec.TestField(Amount);


        ObjTransactions.Reset;
        ObjTransactions.SetRange(ObjTransactions."Document No", Rec.No);
        if ObjTransactions.Find('-') then
            ObjTransactions.DeleteAll;
        Datefilter := '..' + Format(Rec."Transaction Date");
        RunBal := 0;
        RunBal := Rec.Amount;
        //RunBal:=FnRunEntranceFee("Member No",RunBal,No);
        //RunBal:=FnRunBenevolentFund("Member No",RunBal,No);
        //RunBal:=FnRunRecoverDebtCollectorFee("Member No",RunBal,No,Amount);
        //RunBal:=FnRunLoanPenalty("Member No",RunBal,No);
        //RunBal:=FnRunInterest("Member No",RunBal,No);
        //RunBal:=FnRunLoanInsurance("Member No",RunBal,No);
        //RunBal:=FnRunPrinciple("Member No",RunBal,No);
        RunBal := FnRunLoanRecovery(Rec."Member No", RunBal, Rec.No);
        RunBal := FnRunDepositContribution(Rec."Member No", RunBal, Rec.No);

        if Rec."Excess Funds Account" = '' then begin
            Rec."Excess Funds Account" := FnRunGetExcessFundsAccount(Rec."Member No");
            Rec.Modify;
        end;

        if RunBal > 0 then begin
            if Confirm('Excess Money will allocated to ' + Format(Rec."Excess Funds Account") + '.Do you want to Continue?', true) = false then
                exit;

            FnRunSavingsProductExcess(Rec, RunBal);
        end;

        Rec.CalcFields("Allocated Amount");
       Rec.Modify;
    end;

    local procedure FnRunSendSupiciusTransEmail()
    var
        //SMTPMail: Codeunit "SMTP Mail";
        //SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        ObjAuditGenSetup: Record "Audit General Setup";
        SuspiciousTransMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Suspicious Transaction Notification</p><p style="font-family:Verdana,Arial;font-size:9pt">Member Account No %2  Name  %3  has performed  Transactions exceeding His/Her Accounts Turn Over+Allowance of 50%  of  %4,</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%5</p><p><b>KINGDOM SACCO LTD</b></p>';
        Attachment: Text[100];
        recipient: List of [Text];

    begin
        ObjAuditGenSetup.Get();
        //SMTPSetup.Get();

        if ObjAuditGenSetup."Notification Group Email" <> '' then
            Message(Format(ObjAuditGenSetup."Notification Group Email"));
        begin
            // recipient.Add(ObjAuditGenSetup."Notification Group Email");

            // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", recipient, 'Suspicious Transaction Notification', '', true);
            // SMTPMail.AppendBody(StrSubstNo(SuspiciousTransMessage, 'All',Rec."Account No",Rec."Account Name",Rec."Monthly Max Credits+Tolerance", UserId));
            // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AddAttachment(FileName, Attachment);
            // SMTPMail.Send;
        end;
    end;

    local procedure FnRunGetExcessFundsAccount(VarMemberNo: Code[30]) VarExcessAcount: Code[30]
    begin
        VarExcessAcount := '';

        ObjCust.Reset;
        ObjCust.SetRange(ObjCust."No.", VarMemberNo);
        ObjCust.SetFilter(ObjCust."Deposits Account No", '<>%1', '');
        if ObjCust.FindSet then begin
            VarExcessAcount := ObjCust."Deposits Account No";
            exit(VarExcessAcount);
        end else
            ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."BOSA Account No", VarMemberNo);
        ObjAccount.SetRange(ObjAccount.Status, ObjAccount.Status::Active);
        if ObjAccount.FindSet then begin
            VarExcessAcount := ObjAccount."No.";
        end;
        exit(VarExcessAcount);
    end;

    local procedure FnRunShowReleavantFields()
    begin
        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        "Branch RefferenceVisible" := false;
        LRefVisible := false;
        ChequeTransfVisible := false;
        ChequeWithdrawalVisible := false;
        DepositSlipVisible := false;
        ChequeWithOll := false;
        ODDetailsVisible := false;


        TransactionTypes.Reset;
        TransactionTypes.SetRange(TransactionTypes.Code,Rec."Transaction Type");
        TransactionTypes.SetRange(TransactionTypes."Account Type",Rec."Account Type");
        if TransactionTypes.FindSet then begin

            if TransactionTypes.Type = TransactionTypes.Type::"Cheque Deposit" then begin
                FChequeVisible := true;
            end;

            if TransactionTypes.Type = TransactionTypes.Type::"Bankers Cheque" then begin
                BChequeVisible := true;
            end;

            // if TransactionTypes.Type = TransactionTypes.Type::"Batch Deposit" then begin
            //     BReceiptVisible := true;
            // end;
            TellerTill.Reset;
            TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
            TellerTill.SetRange(TellerTill.CashierID, UserId);
            if TellerTill.Find('-') then begin
                Rec."Bank Account" := TellerTill."No.";
            end;

            if TransactionTypes.Type = TransactionTypes.Type::Transfer then begin
                ChequeTransfVisible := true;
            end;

            if TransactionTypes.Type = TransactionTypes.Type::"Inhouse Cheque Withdrawal" then begin
                ChequeWithdrawalVisible := true;
            end;

            if TransactionTypes.Type = TransactionTypes.Type::"Cheque Withdrawal" then begin
                ChequeWithOll := true;
            end;

            if TransactionTypes.Type = TransactionTypes.Type::"Deposit Slip" then begin
                DepositSlipVisible := true;
            end;

            if TransactionTypes.Type = TransactionTypes.Type::Encashment then
                BReceiptVisible := true;



        end;

        if Rec."Branch Transaction" = true then begin
            "Branch RefferenceVisible" := true;
            LRefVisible := true;
        end;

        if Acc.Get(Rec."Account No") then begin
            if Acc."Account Category" = Acc."account category"::Project then begin
                "Branch RefferenceVisible" := true;
                LRefVisible := true;
            end;



            if ObjAccountType.Get(Rec."Account Type") then begin
                if (Rec.Amount >= ObjAccountType."Bulk Withdrawal Amount") and (Rec.Type = 'Withdrawal') then begin
                    BulkWithVisible := true;
                end;
            end;


            VarshowSignatories := false;
            VarShowAgents := false;

            ObjAccountSignatories.Reset;
            ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No",Rec."Account No");
            if ObjAccountSignatories.Find('-') = true then begin
                VarshowSignatories := true;
            end;

            ObjAccountAgent.Reset;
            ObjAccountAgent.SetRange(ObjAccountAgent."Account No",Rec."Account No");
            if ObjAccountAgent.FindSet then begin
                VarShowAgents := true;
            end;

            SuspTransVisible := false;
            if Rec.Suspicious = true then begin
                SuspTransVisible := true;
            end;

            DeclaretionVisible := false;
            if Rec."Transaction to Be Declared" = true then begin
                DeclaretionVisible := true;
            end;

            ShowAccountImages := false;
            ShowMembershipImages := false;
            if Rec."Member No" <> '' then begin
                ShowMembershipImages := true
            end else
                ShowAccountImages := true;


        end;
        FnShowFields();

        FnRunGetAccountAvailableBalance();

        if Rec."Account Type" = '406' then
            ODDetailsVisible := true;
    end;

    local procedure FnRunFlagTransactions()
    var
        ObjAuditSuspiciousTrans: Record "Audit Suspicious Transactions";
    begin

        ObjAuditGeneralSetup.Get;

        if Rec.Suspicious = true then begin

            ObjAuditSuspiciousTrans.Reset;
            ObjAuditSuspiciousTrans.SetRange(ObjAuditSuspiciousTrans."Document No", Rec.No);
            if ObjAuditSuspiciousTrans.FindSet then begin
                ObjAuditSuspiciousTrans.DeleteAll;
            end;


            ObjAuditSuspiciousTrans.Init;
            ObjAuditSuspiciousTrans."Document No" := Rec.No;
            ObjAuditSuspiciousTrans."Account No" := Rec."Account No";
            ObjAuditSuspiciousTrans."Account Name" := Rec."Account Name";
            ObjAuditSuspiciousTrans."Transaction Date" := Rec."Transaction Date";
            ObjAuditSuspiciousTrans."Transaction Amount" := Rec.Amount;
            ObjAuditSuspiciousTrans."Transaction Type" := Format(Rec.Type);
            ObjAuditSuspiciousTrans."Transacted By" := Rec.Cashier;
            ObjAuditSuspiciousTrans."Max Credits Allowable" := Rec."Monthly Max Credits+Tolerance";
            ObjAuditSuspiciousTrans."Month TurnOver Amount" := Rec."Monthly TurnOver Amount";
            ObjAuditSuspiciousTrans."Violation Transaction Type" := ObjAuditSuspiciousTrans."violation transaction type"::"Monthly Turnover Exceed";
            ObjAuditSuspiciousTrans.Insert;

            //FnRunEmailSuspiciousTransaction;
        end;


        if Rec."Type _Transactions" = Rec."type _transactions"::Withdrawal then begin
            if Rec."Transaction to Be Declared" = true then begin

                ObjAuditSuspiciousTrans.Reset;
                ObjAuditSuspiciousTrans.SetRange(ObjAuditSuspiciousTrans."Document No", Rec.No);
                if ObjAuditSuspiciousTrans.FindSet then begin
                    ObjAuditSuspiciousTrans.DeleteAll;
                end;


                ObjAuditSuspiciousTrans.Init;
                ObjAuditSuspiciousTrans."Document No" := Rec.No;
                ObjAuditSuspiciousTrans."Account No" := Rec."Account No";
                ObjAuditSuspiciousTrans."Account Name" := Rec."Account Name";
                ObjAuditSuspiciousTrans."Transaction Date" := Rec."Transaction Date";
                ObjAuditSuspiciousTrans."Transaction Amount" := Rec.Amount;
                ObjAuditSuspiciousTrans."Transaction Type" := Format(Rec.Type);
                ObjAuditSuspiciousTrans."Transacted By" := Rec.Cashier;
                ObjAuditSuspiciousTrans."Max Credits Allowable" := ObjAuditGeneralSetup."Cumm. Daily Credits Limit Amt";
                ObjAuditSuspiciousTrans."Violation Transaction Type" := ObjAuditSuspiciousTrans."violation transaction type"::"Daily Transaction Limit Exceeed";
                ObjAuditSuspiciousTrans.Insert;
            end;

        end;


        if Rec."Type _Transactions" = Rec."type _transactions"::"Cash Deposit" then begin
            if Rec."Transaction to Be Declared" = true then begin

                ObjAuditSuspiciousTrans.Reset;
                ObjAuditSuspiciousTrans.SetRange(ObjAuditSuspiciousTrans."Document No", Rec.No);
                if ObjAuditSuspiciousTrans.FindSet then begin
                    ObjAuditSuspiciousTrans.DeleteAll;
                end;


                ObjAuditSuspiciousTrans.Init;
                ObjAuditSuspiciousTrans."Document No" := Rec.No;
                ObjAuditSuspiciousTrans."Account No" := Rec."Account No";
                ObjAuditSuspiciousTrans."Account Name" := Rec."Account Name";
                ObjAuditSuspiciousTrans."Transaction Date" := Rec."Transaction Date";
                ObjAuditSuspiciousTrans."Transaction Amount" := Rec.Amount;
                ObjAuditSuspiciousTrans."Transaction Type" := Format(Rec.Type);
                ObjAuditSuspiciousTrans."Transacted By" := Rec.Cashier;
                ObjAuditSuspiciousTrans."Max Credits Allowable" := ObjAuditGeneralSetup."Cumm. Daily Credits Limit Amt";
                ObjAuditSuspiciousTrans."Violation Transaction Type" := ObjAuditSuspiciousTrans."violation transaction type"::"Daily Transaction Limit Exceeed";
                ObjAuditSuspiciousTrans.Insert;
            end;

        end;
    end;


    procedure FnRunEmailSuspiciousTransactions()
    var
        // SMTPSetup: Record "SMTP Mail Setup";
        // SurestepFactory: Codeunit "Au Factory";
        VarEmailSubject: Text;
        VarEmailBody: Text;
        EmailRecepient: Text;
        EmailRecepientName: Text;
    begin
        // SMTPSetup.Get;
        ObjAuditGeneralSetup.Get;
        EmailRecepient := ObjAuditGeneralSetup."Notification Group Email";
        EmailRecepientName := 'Team';

        VarEmailSubject := 'Suspicious Transaction Notification - ' +Rec."Account No";
        VarEmailBody := 'Member ' +Rec."Member No" + ' - ' +Rec."Member Name" + ' has performed Cash Deposit of Ksh. ' + Format(Rec.Amount) +
        ' on Account No. ' +Rec."Account No" + ' that would bring their current month cumulative credits to Ksh. ' + Format(Rec."Month Credits to Date" + Rec.Amount) +
        ' which would exceed their current Monthly Turnover of Ksh. ' + Format(Rec."Monthly Max Credits+Tolerance");

        //    SurestepFactory.FnSendStatementViaMail(EmailRecepientName, VarEmailSubject, VarEmailBody, EmailRecepient, '', '');


    end;

    local procedure FnRunGetTransactionAmountCharge() VarChargeAmount: Decimal
    var
        ObjGraduatedCharge: Record "CWithdrawal Graduated Charges";
    begin


        ObjTransactionsII.Reset;
        ObjTransactionsII.SetRange(ObjTransactionsII.No, Rec.No);
        ObjTransactionsII.SetRange(ObjTransactionsII."Use Graduated Charges", true);
        ObjTransactionsII.SetRange(ObjTransactionsII."Bulk Withdrawal Appl Done", false);
        ObjTransactionsII.SetRange(ObjTransactionsII."Normal Transaction Charge", true);
        if ObjTransactionsII.FindSet then begin
            ObjGraduatedCharge.Reset;
            ObjGraduatedCharge.SetRange(ObjGraduatedCharge."Notice Status", ObjGraduatedCharge."notice status"::" ");
            if ObjGraduatedCharge.Find('-') then begin
                repeat
                    if (Rec.Amount >= ObjGraduatedCharge."Minimum Amount") and (Rec.Amount <= ObjGraduatedCharge."Maximum Amount") then begin
                        if ObjGraduatedCharge."Use Percentage" = true then begin
                            VarChargeAmount := Rec.Amount * (ObjGraduatedCharge."Percentage of Amount" / 100);
                        end else
                            VarChargeAmount := ObjGraduatedCharge.Amount;
                    end;
                until ObjGraduatedCharge.Next = 0;
            end;
        end;



        ObjTransactionsII.Reset;
        ObjTransactionsII.SetRange(ObjTransactionsII.No, Rec.No);
        ObjTransactionsII.SetRange(ObjTransactionsII."Use Graduated Charges", true);
        ObjTransactionsII.SetRange(ObjTransactionsII."Bulk Withdrawal Appl Done", true);
        if ObjTransactionsII.FindSet then begin
            ObjGraduatedCharge.Reset;
            ObjGraduatedCharge.SetRange(ObjGraduatedCharge."Notice Status", ObjGraduatedCharge."notice status"::"With Notice");
            if ObjGraduatedCharge.Find('-') then begin
                repeat
                    if (Rec.Amount >= ObjGraduatedCharge."Minimum Amount") and (Rec.Amount <= ObjGraduatedCharge."Maximum Amount") then begin
                        if ObjGraduatedCharge."Use Percentage" = true then begin
                            VarChargeAmount := Rec.Amount * (ObjGraduatedCharge."Percentage of Amount" / 100);
                        end else
                            VarChargeAmount := ObjGraduatedCharge.Amount;
                    end;
                until ObjGraduatedCharge.Next = 0;
            end;
        end;



        ObjTransactionsII.Reset;
        ObjTransactionsII.SetRange(ObjTransactionsII.No, Rec.No);
        ObjTransactionsII.SetRange(ObjTransactionsII."Use Graduated Charges", true);
        ObjTransactionsII.SetRange(ObjTransactionsII."Bulk Withdrawal Appl Done", false);
        if ObjTransactionsII.FindSet then begin
            ObjGraduatedCharge.Reset;
            ObjGraduatedCharge.SetRange(ObjGraduatedCharge."Notice Status", ObjGraduatedCharge."notice status"::"Without Notice");
            if ObjGraduatedCharge.Find('-') then begin
                repeat
                    if (Rec.Amount >= ObjGraduatedCharge."Minimum Amount") and (Rec.Amount <= ObjGraduatedCharge."Maximum Amount") then begin
                        if ObjGraduatedCharge."Use Percentage" = true then begin
                            VarChargeAmount := Rec.Amount * (ObjGraduatedCharge."Percentage of Amount" / 100);
                        end else
                            VarChargeAmount := ObjGraduatedCharge.Amount;
                    end;
                until ObjGraduatedCharge.Next = 0;
            end;
        end;

        exit(VarChargeAmount);
    end;
}




