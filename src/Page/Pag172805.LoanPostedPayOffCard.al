//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172805 "Loan Posted PayOff Card"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Loan PayOff";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = MemberNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FOSA Account No"; Rec."FOSA Account No")
                {
                    ApplicationArea = Basic;
                    Editable = FOSANoEditable;
                }
                field("FOSA Account Available Balance"; Rec."FOSA Account Available Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requested PayOff Amount"; Rec."Requested PayOff Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved PayOff Amount"; Rec."Approved PayOff Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total PayOut Amount"; Rec."Total PayOut Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000009; "Loan PayOff Details")
            {
                Editable = false;
                Enabled = false;
                SubPageLink = "Document No" = field("Document No"),
                              "Member No" = field("Member No");
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
                Caption = 'Member Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                //RunPageLink ="Member No"= field("No.");

                //RunPageLink = me
                            //RunPageLink = "No." = field();
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total PayOut Amount");
        Rec."Requested PayOff Amount" := Rec."Total PayOut Amount";
        Rec."Approved PayOff Amount" := Rec."Total PayOut Amount";

        EnablePosting := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnablePosting := true;

        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            FOSANoEditable := true
        end else
            if (Rec.Status = Rec.Status::"Pending Approval") or (Rec.Status = Rec.Status::Approved) then begin
                MemberNoEditable := false;
                FOSANoEditable := false;
            end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created By" := UserId;
        Rec."Application Date" := Today;
    end;

    trigger OnOpenPage()
    begin
        EnablePosting := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnablePosting := true;

        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            FOSANoEditable := true
        end else
            if (Rec.Status = Rec.Status::"Pending Approval") or (Rec.Status = Rec.Status::Approved) then begin
                MemberNoEditable := false;
                FOSANoEditable := false;
            end;
    end;

    var
        PayOffDetails: Record "Loans PayOff Details";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        LoansRec: Record "Loans Register";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff;
        EnablePosting: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        ObjPayOffDetails: Record "Loans PayOff Details";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        SFactory: Codeunit "Au Factory";
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        VarLoanInsuranceBalAccount: Code[20];
        MemberNoEditable: Boolean;
        FOSANoEditable: Boolean;
}




