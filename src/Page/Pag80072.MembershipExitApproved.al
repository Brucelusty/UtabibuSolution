page 80072 "Membership Exit-Approved"
//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings

{
    CardPageID = "Membership Exit Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Exist";
    SourceTableView = where(Posted = filter(false),Status=filter(Approved));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Total Loan"; Rec."Total Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Member Liability2"; Rec."Member Liability2")
                {
                    Caption = 'Member Liability';
                }
                field("Closure Type"; Rec."Closure Type")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Withdrawal"; Rec."Reason For Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field("Sell Share Capital"; Rec."Sell Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Type"; Rec."Exit Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("Member No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Member is  a Guarantor")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        cust.Reset;
                        cust.SetRange(cust."No.", rec."Member No.");
                        if cust.Find('-') then
                            Report.run(172503, true, false, cust);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MembershipWithdrawal;
                        ApprovalEntries.SetRecordFilters(Database::"Membership Exist", DocumentType, rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                    // ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if (rec."Closure Type" = rec."closure type"::"Member Exit - Normal") and (rec."Member Liability" > 0) then
                            Error('Member has Liability of Ksh. %1 for Loans Guaranteed. Member Exit cannot be processed at the moment.', rec."Member Liability");


                        if rec.Status <> rec.Status::Open then
                            Error(text001);

                        if WorkflowIntegration.CheckMWithdrawalApprovalsWorkflowEnabled(Rec) then
                            WorkflowIntegration.OnSendMWithdrawalForApproval(Rec);

                        GenSetUp.Get();

                        if Generalsetup."Send Membership Withdrawal SMS" = true then begin
                            FnSendWithdrawalApplicationSMS();
                        end;

                        FnRunCreateHouseGroupExitApplication;//===================================================================Exit Member From Group
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                    //ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //End allocate batch number
                        //ApprovalMgt.CancelClosureApprovalRequest(Rec)
                    end;
                }
                action("Post Membership Exit")
                {
                    ApplicationArea = Basic;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        VarExitType: Option "Member Exit - Normal","Member Exit - Deceased";
                    begin
                        case VarExitType of
                            Varexittype::"Member Exit - Normal":
                                FnRunPostNormalExitApplication(rec."Member No.");
                            Varexittype::"Member Exit - Deceased":
                                FnRunPostExitDeceasedApplication(rec."Member No.");
                        end;
                    end;
                }
            }
        }
    }

    var
        Closure: Integer;
        cust: Record "Members Register";
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        MNoEditable: Boolean;
        ClosingDateEditable: Boolean;
        ClosureTypeEditable: Boolean;
        PostingDateEditable: Boolean;
        TotalFOSALoan: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[30];
        DBranch: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        "Remaining Amount": Decimal;
        LoansR: Record "Loans Register";
        "AMOUNTTO BE RECOVERED": Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        ClosureR: Record "Membership Exist";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        PTEN: Text;
        DataSheet: Record "Data Sheet Main";
        Customer: Record "Members Register";
        GenSetUp: Record "Sacco General Set-Up";
        compinfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ShareCapitalTransferVisible: Boolean;
        ShareCapSellPageVisible: Boolean;
        ObjShareCapSell: Record "Share Capital Sell";
        SurestepFactory: Codeunit "Au Factory";
        JVTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        JVAccountType: Enum "Gen. Journal Account Type";
        TemplateName: Code[20];
        BatchName: Code[20];
        JVBalAccounttype: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        JVBalAccountNo: Code[20];
        TransferFee: Decimal;
        AvailableBal: Decimal;
        ObjMember: Record "Members Register";
        VarMemberAvailableAmount: Decimal;
        ObjCust: Record "Members Register";
        ObjGensetup: Record "Sacco General Set-Up";
        VarWithdrawalFee: Decimal;
        VarTaxonWithdrawalFee: Decimal;
        VarShareCapSellFee: Decimal;
        VarTaxonShareCapSellFee: Decimal;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        ObjHouseChangeAppl: Record "House Group Change Request";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VarShareCapitalFee: Decimal;
        // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowIntegration: Codeunit WorkflowIntegration;


    procedure UpdateControl()
    begin
        if rec.Status = rec.Status::Open then begin
            MNoEditable := true;
            ClosingDateEditable := false;
            ClosureTypeEditable := true;
            PostingDateEditable := false;
        end;

        if rec.Status = rec.Status::Pending then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if rec.Status = rec.Status::Rejected then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if rec.Status = rec.Status::Approved then begin
            MNoEditable := false;
            ClosingDateEditable := true;
            ClosureTypeEditable := false;
            PostingDateEditable := true;
        end;
    end;


    procedure FnSendWithdrawalApplicationSMS()
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := rec."No.";
        SMSMessage."Document No" := rec."No.";
        SMSMessage."Account No" := rec."Member No.";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBERSHIPWITH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Membership Withdrawal Application has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        cust.Reset;
        cust.SetRange(cust."No.", rec."Member No.");
        if cust.Find('-') then begin
            SMSMessage."Telephone No" := cust."Mobile Phone No";
        end;
        if cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnRunPostShareCapSell()
    var
        VarBuyerMemberNos: Code[50];
    begin
        TemplateName := 'GENERAL';
        BatchName := 'CLOSURE';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", TemplateName);
        GenJournalLine.SetRange("Journal Batch Name", BatchName);
        GenJournalLine.DeleteAll;




        if ObjMember.Get(rec."Member No.") then begin
            //=========================================================================================================Credit Buyer Account
            ObjShareCapSell.Reset;
            ObjShareCapSell.SetRange(ObjShareCapSell."Document No", rec."No.");
            if ObjShareCapSell.FindSet then begin
                repeat
                    LineNo := LineNo + 10000;
                    SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, rec."No.", LineNo, GenJournalLine."transaction type"::"Share Capital",
                    GenJournalLine."account type"::Vendor, ObjShareCapSell."Buyer Share Capital Account", rec."Posting Date",
                    (ObjShareCapSell.Amount * -1), 'BOSA', rec."No.", 'Share Capital Purchase From ' + Format(ObjShareCapSell."Selling Member No"), '', GenJournalLine."application source"::" ");
                    VarBuyerMemberNos := VarBuyerMemberNos + ObjShareCapSell."Buyer Member No" + ', ';
                until ObjShareCapSell.Next = 0;
            end;

            LineNo := LineNo + 10000;
            //=========================================================================================================Debit Seller Account
            rec.CalcFields("Share Capital to Sell");
            SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, rec."No.", LineNo, GenJournalLine."transaction type"::"Share Capital",
            GenJournalLine."account type"::Vendor, rec."Seller Share Capital Account", rec."Posting Date",
                (rec."Share Capital to Sell"), 'BOSA', rec."No.", 'Share Capital Sell to ' + VarBuyerMemberNos, '', GenJournalLine."application source"::" ");


            //=========================================================================================================Debit Buyer FOSA Account
            ObjShareCapSell.Reset;
            ObjShareCapSell.SetRange(ObjShareCapSell."Document No", rec."No.");
            if ObjShareCapSell.FindSet then begin
                repeat
                    LineNo := LineNo + 10000;
                    SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, rec."No.", LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjShareCapSell."Buyer FOSA Account", rec."Posting Date",
                    (ObjShareCapSell.Amount), 'FOSA', rec."No.", 'Share Capital Purchase From ' + Format(ObjShareCapSell."Selling Member No"), '', GenJournalLine."application source"::" ");
                until ObjShareCapSell.Next = 0;
            end;

            LineNo := LineNo + 10000;
            //======================================================================================================Credit Seller FOSA Account
            rec.CalcFields("Share Capital to Sell");
            SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, rec."No.", LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, rec."FOSA Account No.", rec."Posting Date",
                (rec."Share Capital to Sell" * -1), 'FOSA', rec."No.", 'Share Capital Sell to ' + VarBuyerMemberNos, '', GenJournalLine."application source"::" ");

            LineNo := LineNo + 10000;
            //========================================================================================================Post Transfer Fee
            Generalsetup.Get();
            SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, rec."No.", LineNo, GenJournalLine."transaction type"::"Deposit Contribution", GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", rec."Posting Date"
            , 'Share Capital Transfer Fee ' + Format(rec."Member No."), GenJournalLine."bal. account type"::"G/L Account", Generalsetup."Share Capital Transfer Fee Acc", (rec."Share Capital Transfer Fee"), 'BOSA', '');
            //========================================================================================================Post JV

            LineNo := LineNo + 10000;
            //==========================================================================================================Post Transfer Fee Excise Duty
            Generalsetup.Get();
            SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, rec."No.", LineNo, GenJournalLine."transaction type"::"Deposit Contribution", GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", rec."Posting Date"
            , 'Tax: Share Capital Transfer Fee ' + Format(rec."Member No."), GenJournalLine."bal. account type"::"G/L Account", Generalsetup."Excise Duty Account", (rec."Share Capital Transfer Fee" * (Generalsetup."Excise Duty(%)" / 100)), 'BOSA', '');
            //==========================================================================================================Post Transfer Fee Excise Duty
        end;

        //CU posting
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", TemplateName);
        GenJournalLine.SetRange("Journal Batch Name", BatchName);
        if GenJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    end;

    local procedure FnRunCreateHouseGroupExitApplication()
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", rec."Member No.");
        ObjMember.SetRange(ObjMember."House Group Status", ObjMember."house group status"::Active);
        if ObjMember.FindSet then begin

            if ObjNoSeries.Get then begin
                ObjNoSeries.TestField(ObjNoSeries."House Change Request No");
                VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."House Change Request No", 0D, true);
                if VarDocumentNo <> '' then begin

                    ObjHouseChangeAppl.Init;
                    ObjHouseChangeAppl."Document No" := VarDocumentNo;
                    ObjHouseChangeAppl."Member No" := ObjMember."No.";
                    ObjHouseChangeAppl."Member Name" := ObjMember.Name;
                    ObjHouseChangeAppl."House Group" := ObjMember."Member House Group";
                    ObjHouseChangeAppl."House Group Name" := ObjMember."Member House Group Name";
                    ObjHouseChangeAppl."Reason For Changing Groups" := 'Triggered By Membership Exit';
                    ObjHouseChangeAppl."Date Group Changed" := WorkDate;
                    ObjHouseChangeAppl."Changed By" := UserId;
                    ObjHouseChangeAppl."Change Type" := ObjHouseChangeAppl."change type"::"Remove From Group";
                    ObjHouseChangeAppl.Insert;

                    ObjHouseChangeAppl.Validate(ObjHouseChangeAppl."Member No");
                    ObjHouseChangeAppl.Modify;
                    rec."House Group Exit Application" := VarDocumentNo;
                end;
            end;
        end;
    end;

    local procedure FnEffectHouseGroupExit()
    begin
        ObjHouseChangeAppl.Reset;
        ObjHouseChangeAppl.SetRange(ObjHouseChangeAppl."Document No", rec."House Group Exit Application");
        if ObjHouseChangeAppl.FindSet then begin
            if ObjCust.Get(ObjHouseChangeAppl."Member No") then begin
                ObjCust."Member House Group" := ObjHouseChangeAppl."Destination House";
                ObjCust."Member House Group Name" := ObjHouseChangeAppl."Destination House Group Name";
                ObjCust."House Group Status" := ObjCust."house group status"::Active;
                ObjHouseChangeAppl."Date Group Changed" := Today;
                ObjHouseChangeAppl."Changed By" := UserId;
                ObjHouseChangeAppl."Change Effected" := true;
                ObjCust.Modify;
                ObjHouseChangeAppl.Modify;
            end;
        end;
    end;

    local procedure FnRunPostNormalExitApplication(VarMemberNo: Code[30])
    var
        ObjGensetup: Record "Sacco General Set-Up";
        ObjMember: Record "Members Register";
        VarRunningBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjLoansII: Record "Loans Register";
        VarCurrentPayOff: Decimal;
        SFactory: Codeunit "Au Factory";
        VarMemberTotalLoanLiability: Decimal;
        VarMembershipExitFee: Decimal;
        VarMemberTotalLiability: Decimal;
        VarMemberAvailableBal: Decimal;
        VarAmounttoDeduct: Decimal;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        VarMembershipExit: Decimal;
        VarTaxOnExitFee: Decimal;
        VarAmounttoTransfertoFOSA: Decimal;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", VarMemberNo);
        if ObjMember.FindSet then begin
            ObjMember.CalcFields(ObjMember."Current Shares", ObjMember."Shares Retained");
            ObjGensetup.Get;

            VarMemberAvailableBal := ObjMember."Current Shares";
            VarMembershipExit := ObjGensetup."Withdrawal Fee";
            VarTaxOnExitFee := VarMembershipExit * (ObjGensetup."Excise Duty(%)" / 100);
            VarMembershipExitFee := VarMembershipExit + VarTaxOnExitFee;
            VarAmounttoTransfertoFOSA := VarMemberAvailableBal - VarMembershipExitFee;

            if rec."Sell Share Capital" = true then begin
                VarShareCapitalFee := ObjGensetup."Share Capital Transfer Fee";
                VarShareCapitalFee := VarShareCapitalFee + (VarShareCapitalFee * (ObjGensetup."Excise Duty(%)" / 100));
            end;
            VarAmounttoTransfertoFOSA := VarMemberAvailableBal - VarMembershipExitFee - VarShareCapitalFee;

            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            if ObjLoans.FindSet then begin
                repeat
                    VarCurrentPayOff := SFactory.FnRunGetLoanPayoffAmount(ObjLoans."Loan  No.");
                    VarMemberTotalLoanLiability := VarMemberTotalLoanLiability + VarCurrentPayOff;
                until ObjLoans.Next = 0;
            end;
            VarMemberTotalLiability := VarMemberTotalLoanLiability + VarMembershipExitFee;

            rec.CalcFields("Share Capital to Sell");
            if rec."Sell Share Capital" = true then
                VarMemberAvailableBal := VarMemberAvailableBal + rec."Share Capital to Sell";

            if (VarMemberTotalLiability > VarMemberAvailableBal) then
                Error('Members Deposits is not enough to Clear Liability. Member Deposits # %1 Member Liability # %2', VarMemberAvailableBal, VarMemberTotalLiability);


            BATCH_TEMPLATE := 'PURCHASES';
            BATCH_NAME := 'FTRANS';
            DOCUMENT_NO := rec."No.";

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            GenJournalLine.DeleteAll;



            //============================================================================================================Post Membership Exit Fee
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", WorkDate, VarMembershipExit, 'BOSA', '',
            'Membership Exit Fee: ' + rec."No.", '', GenJournalLine."application source"::" ");

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGensetup."Withdrawal Fee Account", WorkDate, VarMembershipExit * -1, 'BOSA', '',
            'Membership Exit Fee For ' + rec."Member No.", '', GenJournalLine."application source"::" ");

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", WorkDate, VarTaxOnExitFee, 'BOSA', '',
            'Membership Exit Fee Tax: ' + rec."No.", '', GenJournalLine."application source"::" ");

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", WorkDate, VarTaxOnExitFee * -1, 'BOSA', '',
            'Membership Exit Fee Tax For ' + rec."Member No.", '', GenJournalLine."application source"::" ");
            //============================================================================================================End Post Membership Exit Fee


            //===========================================================================================================Post Remaining Amount to FOSA
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", WorkDate, VarAmounttoTransfertoFOSA, 'BOSA', '',
            'Membership Exit Deposit Transfer: ' + rec."No.", '', GenJournalLine."application source"::" ");

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, rec."FOSA Account No.", WorkDate, VarAmounttoTransfertoFOSA * -1, 'BOSA', '',
            'Membership Exit Deposit Transfer: ' + rec."No.", '', GenJournalLine."application source"::" ");
            //===========================================================================================================Post Remaining Amount to FOSA

            //CU posting
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

            if rec."Sell Share Capital" = true then begin
                FnRunPostShareCapSell;
            end;

            ObjLoansII.CalcFields(ObjLoansII."Outstanding Balance");
            ObjLoansII.Reset;
            ObjLoansII.SetRange(ObjLoansII."Client Code", VarMemberNo);
            ObjLoansII.SetFilter(ObjLoansII."Outstanding Balance", '>%1', 0);
            if ObjLoansII.FindSet then begin
                repeat
                    SFactory.FnCreateLoanPayOffJournals(ObjLoansII."Loan  No.", BATCH_TEMPLATE, BATCH_NAME, rec."No.", VarMemberNo, WorkDate, ObjLoansII."Loan  No.",
                   rec."FOSA Account No.", rec."Member Name", VarAmounttoTransfertoFOSA);

                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                until ObjLoansII.Next = 0;
            end;


        end;


        ObjMember.CalcFields(ObjMember."Shares Retained", ObjMember."Current Shares");
        if ObjMember.Get(VarMemberNo) then begin
            ObjMember.Status := ObjMember.Status::Exited;
            ObjMember.Blocked := ObjMember.Blocked::All;

            if ObjMember."Shares Retained" = 0 then
                ObjMember."Share Capital No" := '';

            if ObjMember."Current Shares" = 0 then
                ObjMember."Deposits Account No" := '';
            ObjMember.Modify;
        end;
    end;

    local procedure FnRunPostExitDeceasedApplication(VarMemberNo: Code[30])
    var
        ObjGensetup: Record "Sacco General Set-Up";
        ObjMember: Record "Members Register";
        VarRunningBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjLoansII: Record "Loans Register";
        VarCurrentPayOff: Decimal;
        SFactory: Codeunit "Au Factory";
        VarMemberTotalLoanLiability: Decimal;
        VarMembershipExitFee: Decimal;
        VarMemberTotalLiability: Decimal;
        VarMemberAvailableBal: Decimal;
        VarAmounttoDeduct: Decimal;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        VarMembershipExit: Decimal;
        VarTaxOnExitFee: Decimal;
        VarAmounttoTransfertoFOSA: Decimal;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", VarMemberNo);
        if ObjMember.FindSet then begin
            ObjMember.CalcFields(ObjMember."Current Shares", ObjMember."Shares Retained");
            ObjGensetup.Get;

            VarMemberAvailableBal := ObjMember."Current Shares";
            VarMembershipExit := ObjGensetup."Withdrawal Fee";
            VarTaxOnExitFee := VarMembershipExit * (ObjGensetup."Excise Duty(%)" / 100);
            VarMembershipExitFee := VarMembershipExit + VarTaxOnExitFee;
            VarAmounttoTransfertoFOSA := VarMemberAvailableBal - VarMembershipExitFee;

            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            if ObjLoans.FindSet then begin
                repeat
                    VarCurrentPayOff := SFactory.FnRunGetLoanPayoffAmount(ObjLoans."Loan  No.");
                    VarMemberTotalLoanLiability := VarMemberTotalLoanLiability + VarCurrentPayOff;
                until ObjLoans.Next = 0;
            end;
            VarMemberTotalLiability := VarMemberTotalLoanLiability + VarMembershipExitFee;

            //IF VarMemberTotalLiability>VarMemberAvailableBal THEN
            // ERROR('Members Deposits is not enough to Clear Liability. Member Deposits # %1 Member Liability # %2',VarMemberAvailableBal,VarMemberTotalLiability);


            BATCH_TEMPLATE := 'PURCHASES';
            BATCH_NAME := 'FTRANS';
            DOCUMENT_NO := rec."No.";

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            GenJournalLine.DeleteAll;



            //===========================================================================================================Post Remaining Amount to FOSA
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", WorkDate, VarAmounttoTransfertoFOSA, 'BOSA', '',
            'Membership Exit Deposit Transfer: ' + rec."No.", '', GenJournalLine."application source"::" ");

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, rec."FOSA Account No.", WorkDate, VarAmounttoTransfertoFOSA * -1, 'BOSA', '',
            'Membership Exit Deposit Transfer: ' + rec."No.", '', GenJournalLine."application source"::" ");
            //===========================================================================================================Post Remaining Amount to FOSA

            //CU posting
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);



            ObjVendors.Reset;
            ObjVendors.SetRange(ObjVendors."No.", rec."FOSA Account No.");
            if ObjVendors.Find('-') then begin
                ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                ObjAccTypes.Reset;
                ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                if ObjAccTypes.Find('-') then
                    AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
            end;


            ObjLoansII.CalcFields(ObjLoansII."Outstanding Balance");
            ObjLoansII.Reset;
            ObjLoansII.SetRange(ObjLoansII."Client Code", VarMemberNo);
            ObjLoansII.SetFilter(ObjLoansII."Outstanding Balance", '>%1', 0);
            if ObjLoansII.FindSet then begin
                repeat
                    SFactory.FnCreateLoanPayOffJournals(ObjLoansII."Loan  No.", BATCH_TEMPLATE, BATCH_NAME, rec."No.", VarMemberNo, WorkDate, ObjLoansII."Loan  No.",
                    rec."FOSA Account No.", rec."Member Name", AvailableBal);

                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                until ObjLoansII.Next = 0;
            end;


        end;

        if ObjMember.Get(VarMemberNo) then begin
            ObjMember.Status := ObjMember.Status::Deceased;
            ObjMember.Blocked := ObjMember.Blocked::All;
            ObjMember.Modify;
        end;
    end;
}





