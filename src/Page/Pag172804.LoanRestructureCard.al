//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172804 "Loan Restructure Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Loan Rescheduling";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Issue Date";Rec."Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount";Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Rescheduled; Rec.Rescheduled)
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduled By";Rec."Rescheduled By")
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduled Date";Rec."Rescheduled Date")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date";Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Loan Amount";Rec."Outstanding Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("New Installments";Rec."New Installments")
                {
                    ApplicationArea = Basic;
                }
                field("Original Installments";Rec."Original Installments")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Insurance";Rec."Loan Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Active Schedule";Rec."Active Schedule")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Amount";Rec."Repayment Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Principle Repayment";Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Repayment";Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'New Repayment Schedule';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    LoanRegister.Reset;
                    LoanRegister.SetRange(LoanRegister."Loan  No.", Rec."Loan No");
                    if LoanRegister.Find('-') then begin
                        Report.Run(172477, true, false, LoanRegister);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableEffectRetructure := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;


        if ((Rec.Status = Rec.Status::Approved) and (Rec."Rescheduled Date" = 0D)) then
            EnableEffectRetructure := true;
        //FnRecordRestriction;
    end;

    trigger OnOpenPage()
    begin
        EnableEffectRetructure := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;


        if ((Rec.Status = Rec.Status::Approved) and (Rec."Rescheduled Date" = 0D)) then
            EnableEffectRetructure := true;
        //FnRecordRestriction;
    end;

    var
        EnableEffectRetructure: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure;
        MemberNoEditable: Boolean;
        LoantoRestructureEditable: Boolean;
        NewPeriodEditable: Boolean;
        SFactory: Codeunit "Au Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        ObjAccount: Record Vendor;
        VarLSAAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoans: Record "Loans Register";
        ObjLoansII: Record "Loans Register";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        VarNewLoanNo: Code[30];
        ObjAccounts: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarInterestRateMin: Decimal;
        VarInterestRateMax: Decimal;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanRegister: Record "Loans Register";
}




