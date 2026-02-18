//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172793 "OverDraft Application Card"
{
    PageType = Card;
    SourceTable = "OverDraft Application";

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
                    Editable = MemberNoEditable;
                }
                field("Over Draft Account";Rec."Over Draft Account")
                {
                    ApplicationArea = Basic;
                    Editable = ODAccountEditable;
                }
                field("Over Draft Account Name";Rec."Over Draft Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("OverDraft Application Type";Rec."OverDraft Application Type")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationTypeEditable;

                    trigger OnValidate()
                    begin
                        PreviousODetailsVisible := false;
                        if Rec."OverDraft Application Type" = Rec."overdraft application type"::Amend then
                            PreviousODetailsVisible := true;
                    end;
                }
                field("Interest Rate";Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                group(PrePreviousODDetails)
                {
                    Editable = false;
                    Visible = PreviousODetailsVisible;
                    field("Prev_Qualifying Overdraft Amnt";Rec."Prev_Qualifying Overdraft Amnt")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Previous Overdraft Amount';
                    }
                    field("Prev_OverDraft Expiry Date";Rec."Prev_OverDraft Expiry Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Previous OverDraft Expiry Date';
                    }
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Security Type";Rec."Security Type")
                {
                    ApplicationArea = Basic;
                    Editable = SecurityTypeEditable;
                }
                field("Member Deposits";Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Member Guarantee Liability";Rec."Member Guarantee Liability")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Total Members Unsecured Loans";Rec."Total Members Unsecured Loans")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("OD Qualifying Amount:Deposits";Rec."OD Qualifying Amount:Deposits")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("OD Qualifying Amount:Collatera";Rec."OD Qualifying Amount:Collatera")
                {
                    ApplicationArea = Basic;
                    Caption = 'OD Qualifying Amount:Collateral';
                }
                field("Qualifying Overdraft Amount";Rec."Qualifying Overdraft Amount")
                {
                    ApplicationArea = Basic;
                    Editable = QualifyingAmountEditable;
                }
                field("Overdraft Duration";Rec."Overdraft Duration")
                {
                    ApplicationArea = Basic;
                    Editable = DurationEditable;
                }
                field("OverDraft Expiry Date";Rec."OverDraft Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part("Collateral Security";"OverDraft Collateral Register")
            {
                Caption = 'Collateral Security';
                SubPageLink = "OD No" = field("Document No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(EnableUpdateOverDraftLimit)
            {
                ApplicationArea = Basic;
                Caption = 'Update OverDraft Limit';
                Enabled = EnableCreateHouse;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Confirm Over Draft Limit Set?') then begin
                        if ObjAccount.Get(Rec."Over Draft Account") then begin
                            ObjAccount."Over Draft Limit Amount" := Rec."Qualifying Overdraft Amount";
                            ObjAccount."Over Draft Limit Expiry Date" := Rec."OverDraft Expiry Date";
                            ObjAccount.Modify;


                            ObjOverDraftApplications.Reset;
                            ObjOverDraftApplications.SetRange(ObjOverDraftApplications."Member No", Rec."Member No");
                            ObjOverDraftApplications.SetRange(ObjOverDraftApplications.Status, ObjOverDraftApplications.Status::Approved);
                            ObjOverDraftApplications.SetRange(ObjOverDraftApplications."OverDraft Application Status", ObjOverDraftApplications."overdraft application status"::Active);
                            if ObjOverDraftApplications.FindSet then begin
                                repeat
                                    ObjOverDraftApplications."OverDraft Application Status" := ObjOverDraftApplications."overdraft application status"::Terminated;
                                    ObjOverDraftApplications."Date Terminated" := WorkDate;
                                    ObjOverDraftApplications."Terminated By" := UserId;
                                    ObjOverDraftApplications."Reason For Termination" := Format(Rec."OverDraft Application Type") + ' Application ' + Rec."Document No";
                                    ObjOverDraftApplications.Modify;
                                until ObjOverDraftApplications.Next = 0;
                            end;

                            Rec."OD Application Effected" := true;
                            Rec."OD Application Effected By" := UserId;
                            Rec."OD Application Effected Date" := WorkDate;
                        end;
                    end;

                    CurrPage.Close;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if WorkflowIntegration.CheckOverDraftApprovalsWorkflowEnabled(Rec) then
                        WorkflowIntegration.OnSendOverDraftForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        WorkflowIntegration.OnCancelOverDraftApprovalRequest(Rec);

                end;
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::OverDraft;
                   // ApprovalEntries.Setfilters(Database::"OverDraft Application", DocumentType, "Document No");
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FnRecordRestriction;

        EnableCreateHouse := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableCreateHouse := true;

        PreviousODetailsVisible := false;
        if Rec."OverDraft Application Type" = Rec."overdraft application type"::Amend then
            PreviousODetailsVisible := true;
    end;

    trigger OnOpenPage()
    begin
        FnRecordRestriction;

        EnableCreateHouse := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableCreateHouse := true;

        PreviousODetailsVisible := false;
        if Rec."OverDraft Application Type" = Rec."overdraft application type"::Amend then
            PreviousODetailsVisible := true;
    end;

    var
        ObjCellGroups: Record "Member House Groups";
        ObjCust: Record "Members Register";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft;
        EnableCreateHouse: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        VarBOSANOKVisible: Boolean;
        VarFOSANOKVisible: Boolean;
        VarAccountAgentVisible: Boolean;
        ObjSaccoNos: Record "Sacco No. Series";
        VarHouseNo: Code[30];
        ObjHouseG: Record "Member House Groups";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjCollaralDetails: Record "OD Collateral Details";
        VarCollateralValue: Decimal;
        MemberNoEditable: Boolean;
        ODAccountEditable: Boolean;
        SecurityTypeEditable: Boolean;
        QualifyingAmountEditable: Boolean;
        DurationEditable: Boolean;
        ObjAccount: Record Vendor;
        PreviousODetailsVisible: Boolean;
        ObjOverDraftApplications: Record "OverDraft Application";
        ApplicationTypeEditable: Boolean;
        WorkflowIntegration: Codeunit WorkflowIntegration;

    local procedure FnRecordRestriction()
    begin
        if (Rec.Status = Rec.Status::Open) then begin
            MemberNoEditable := true;
            ODAccountEditable := true;
            QualifyingAmountEditable := true;
            DurationEditable := true;
            SecurityTypeEditable := true;
            ApplicationTypeEditable := true;
        end;



        if (Rec.Status = Rec.Status::"Pending Approval") or (Rec.Status = Rec.Status::Approved) then begin
            MemberNoEditable := false;
            ODAccountEditable := false;
            QualifyingAmountEditable := false;
            DurationEditable := false;
            SecurityTypeEditable := false;
            ApplicationTypeEditable := false;
        end;

    end;
}




