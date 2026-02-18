//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172047 "Posted Cheque Rcpt H-Family"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Cheque Receipts-Family";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time";Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By";Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unpaid By";Rec."Unpaid By")
                {
                    ApplicationArea = Basic;
                }
                field("Refference Document";Rec."Refference Document")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Unpaid; Rec.Unpaid)
                {
                    ApplicationArea = Basic;
                }
                field(Imported; Rec.Imported)
                {
                    ApplicationArea = Basic;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = Basic;
                }
                field("Document Name";Rec."Document Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account";Rec."Bank Account")
                {
                    ApplicationArea = Basic;

                }
            }
            // part(Control1000000011;"Cheque Receipt Line-Family")
            // {
            //     SubPageLink = "Header No"=field("No.");
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action("Inward Cheques Report")
            {
                ApplicationArea = Basic;
                Image = Form;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    ObjInwardHeader.Reset;
                    ObjInwardHeader.SetRange(ObjInwardHeader."No.", Rec."No.");
                    if ObjInwardHeader.FindSet then
                        Report.run(172877, true, true, ObjInwardHeader)
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EnablePosting := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;


        if ((Rec.Status = Rec.Status::Approved) and (Rec.Posted = false)) then
            EnablePosting := true;
    end;

    trigger OnAfterGetRecord()
    begin
        EnablePosting := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;


        if ((Rec.Status = Rec.Status::Approved) and (Rec.Posted = false)) then
            EnablePosting := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Created By" := UserId;
    end;

    trigger OnOpenPage()
    begin
        EnablePosting := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;


        if ((Rec.Status = Rec.Status::Approved) and (Rec.Posted = false)) then
            EnablePosting := true;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        ObjAccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        LineNo: Integer;
        EFTDetails: Record "prVital Setup Info.";
        STORegister: Record "Standing Order Register";
        ObjAccounts: Record Vendor;
        EFTHeader: Record "HR General Setup.";
        Transactions: Record Transactions;
        ReffNo: Code[20];
        Account: Record Vendor;
        SMSMessage: Record Vendor;
        iEntryNo: Integer;
        ObjVend: Record Vendor;
        ObjChqRecLines: Record "Cheque Issue Lines-Family";
        AccountTypes: Record "Account Types-Saving Products";
        ObjCheqReg: Record "Cheques Register";
        Charges: Record Charges;
        ObjGenSetup: Record "Sacco General Set-Up";
        objChequeTransactions: Record "Cheque Truncation Buffer";
        ObjChequeFamily: Record "Cheque Receipts-Family";
        FileMgt: Codeunit "File Management";
        objChequeCharges: Record "Cheque Processing Charges";
        ChargeAmount: Decimal;
        SFactory: Codeunit "Au Factory";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        VarChequeCharge: Decimal;
        VarSaccoIncome: Decimal;
        VarBankAmount: Decimal;
        VarAccountAvailableBal: Decimal;
        VarUnPayChequeCharge: Decimal;
        VarUnpaySaccoIncome: Decimal;
        VarUnpayBankAmount: Decimal;
        EnablePosting: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure,SweepingInstructions,ChequeBookApplication,LoanTrunchDisbursement,InwardChequeClearing,InValidPaybillTransactions;
        ObjInwardHeader: Record "Cheque Receipts-Family";

    local procedure FnGetAccountNo(MemberNo: Code[100]) AccountNo: Code[100]
    begin
        Account.Reset;
        Account.SetRange(Account."Cheque Clearing No", MemberNo);
        if Account.Find('-') then begin
            AccountNo := Account."No.";
        end
    end;

    local procedure FnGetAccountName(MemberNo: Code[100]) AccountName: Text[250]
    begin
        Account.Reset;
        Account.SetRange(Account."Cheque Clearing No", MemberNo);
        if Account.Find('-') then begin
            AccountName := Account.Name;
        end
    end;


    procedure Balance(Acc: Code[30]; Vendor: Record Vendor) Bal: Decimal
    begin
        if Vendor.Get(Acc) then begin
            Vendor.CalcFields(Vendor."Balance (LCY)", Vendor."ATM Transactions", Vendor."Uncleared Cheques");
            Bal := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions");
        end
    end;

    local procedure FnGetAccountBalance(MemberNo: Code[100]) AccountBalance: Decimal
    begin
        Account.Reset;
        Account.SetRange(Account."Cheque Clearing No", MemberNo);
        if Account.Find('-') then begin
            AccountBalance := Balance(Account."No.", Account);
        end
    end;

    local procedure FnGetMemberBranch(FosaAccountNumber: Code[100]): Code[100]
    var
        ObjVendor: Record Vendor;
    begin
        ObjVendor.Reset;
        ObjVendor.SetRange("No.", FosaAccountNumber);
        if ObjVendor.Find('-') then begin
            exit(ObjVendor."Global Dimension 2 Code");
        end;
    end;
}




