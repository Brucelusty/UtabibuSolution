//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172983 "House Change Request Card"
{
    PageType = Card;
    SourceTable = "House Group Change Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = MemberNoEditable;

                    trigger OnValidate()
                    begin
                        Rec."Member Net Liability" := SFactory.FnGetMemberLiability(Rec."Member No");
                    end;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("House Group";Rec."House Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("House Group Name";Rec."House Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Change Type";Rec."Change Type")
                {
                    ApplicationArea = Basic;
                    Editable = ChangeEditable;
                }
                field("Destination House";Rec."Destination House")
                {
                    ApplicationArea = Basic;
                    Editable = DestinationHouseEditable;
                }
                field("Destination House Group Name";Rec."Destination House Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("House Group Status";Rec."House Group Status")
                {
                    ApplicationArea = Basic;
                    Editable = HouseGroupStatusEditable;
                }
                field("Reason For Changing Groups";Rec."Reason For Changing Groups")
                {
                    ApplicationArea = Basic;
                    Editable = ReasonforChangeEditable;
                }
                field("Date Group Changed";Rec."Date Group Changed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Changed By";Rec."Changed By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Deposits on Date of Change";Rec."Deposits on Date of Change")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits On the Date of Change';
                    Editable = false;
                }
                field("Outs. Loans on Date of Change";Rec."Outs. Loans on Date of Change")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Loans On the Date of Change';
                    Editable = false;
                }
                field("Member Net Liability";Rec."Member Net Liability")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Change Effected";Rec."Change Effected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Effect Change")
            {
                ApplicationArea = Basic;
                Enabled = EffectVisible;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to effect this change?', false) = true then begin
                        if ObjCust.Get(Rec."Member No") then begin
                            ObjCust."Member House Group" := Rec."Destination House";
                            ObjCust."Member House Group Name" := Rec."Destination House Group Name";
                            ObjCust."House Group Status" := ObjCust."house group status"::Active;
                            Rec."Date Group Changed" := Today;
                            Rec."Changed By" := UserId;
                            Rec."Change Effected" := true;
                            ObjCust.Modify;
                        end;
                    end;
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
                    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    if Rec."Change Type" <> Rec."change type"::"Join Group" then begin
                        ObjHouseGroups.Reset;
                        ObjHouseGroups.SetRange(ObjHouseGroups."Group Leader", Rec."Member No");
                        if ObjHouseGroups.Find('-') = true then begin
                            FnGroupLeaderExitNotification();
                        end;

                        ObjHouseGroups.Reset;
                        ObjHouseGroups.SetRange(ObjHouseGroups."Assistant group Leader", Rec."Member No");
                        if ObjHouseGroups.Find('-') = true then begin
                            FnGroupLeaderExitNotification();
                        end;
                    end;

                    if WorkflowIntegration.CheckHouseChangeApprovalsWorkflowEnabled(Rec) then
                        WorkflowIntegration.OnSendHouseChangeForApproval(Rec);
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
               
                begin
                    if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        WorkflowIntegration.OnCancelHouseChangeApprovalRequest(Rec);

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
                    // ApprovalEntries: Page "Approval Entries";
                begin
                    // DocumentType := Documenttype::HouseChange;
                    // ApprovalEntries.Setfilters(Database::"House Group Change Request", DocumentType, "Document No");
                    // ApprovalEntries.Run;
                end;
            }
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
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", Rec."Member No");
                    if ObjCust.Find('-') then
                        Report.run(172503, true, false, ObjCust);
                end;
            }
            action("Member is  Guaranteed")
            {
                ApplicationArea = Basic;
                Caption = 'Member is  Guaranteed';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", Rec."Member No");
                    if ObjCust.Find('-') then
                        Report.run(172504, true, false, ObjCust);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        MemberNoEditable := false;
        DestinationHouseEditable := false;
        ReasonforChangeEditable := false;

        if Rec."Change Effected" = true then
            EffectVisible := false
        else
            EffectVisible := true;

        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            DestinationHouseEditable := true;
            ReasonforChangeEditable := true;
            HouseGroupStatusEditable := true;
            ChangeEditable := true;
            EffectVisible := false
        end else
            if Rec.Status = Rec.Status::"Pending Approval" then begin
                MemberNoEditable := false;
                DestinationHouseEditable := false;
                ReasonforChangeEditable := false;
                HouseGroupStatusEditable := false;
                EffectVisible := false;
                ChangeEditable := false
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    MemberNoEditable := false;
                    DestinationHouseEditable := false;
                    ReasonforChangeEditable := false;
                    HouseGroupStatusEditable := false;
                    ChangeEditable := false;
                end;

        EnableCreateMember := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableCreateMember := true;
    end;

    trigger OnAfterGetRecord()
    begin

        EnableCreateMember := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableCreateMember := true;
    end;

    trigger OnOpenPage()
    begin
        MemberNoEditable := false;
        DestinationHouseEditable := false;
        ReasonforChangeEditable := false;

        if Rec."Change Effected" = true then
            EffectVisible := false
        else
            EffectVisible := true;

        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            DestinationHouseEditable := true;
            ReasonforChangeEditable := true;
            HouseGroupStatusEditable := true;
            EffectVisible := false;
            ChangeEditable := true
        end else
            if Rec.Status = Rec.Status::"Pending Approval" then begin
                MemberNoEditable := false;
                DestinationHouseEditable := false;
                ReasonforChangeEditable := false;
                HouseGroupStatusEditable := false;
                EffectVisible := false;
                ChangeEditable := false
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    MemberNoEditable := false;
                    DestinationHouseEditable := false;
                    ReasonforChangeEditable := false;
                    HouseGroupStatusEditable := false;
                    ChangeEditable := false;
                end;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange;
        EnableCreateMember: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
   
        EnabledApprovalWorkflowsExist: Boolean;
        ObjCust: Record "Members Register";
        MemberNoEditable: Boolean;
        DestinationHouseEditable: Boolean;
        ReasonforChangeEditable: Boolean;
        ExitMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Group Leader Group Exit </p><p style="font-family:Verdana,Arial;font-size:9pt">This is to inform you that %2  a group Leader of  %3  has applied to exit the Group,house group change application no %4,</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%5</p><p><b>KINGDOM SACCO LTD</b></p>';
        ObjHouseGroups: Record "Member House Groups";
        SFactory: Codeunit "Au Factory";
        VarMailBody: Text[250];
        ObjGensetup: Record "Sacco General Set-Up";
        HouseGroupStatusEditable: Boolean;
        ChangeEditable: Boolean;
        VarHouseName: Text[250];
        VarMemberName: Text[250];
        EffectVisible: Boolean;
        WorkflowIntegration: Codeunit WorkflowIntegration;

    local procedure FnGroupLeaderExitNotification()
    var
        //  SMTPMail: Codeunit "SMTP Mail";
        //  SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        ObjUser: Record User;
        ObjHouseGroups: Record "Member House Groups";
        VarGroupOfficer: Code[50];
    begin
        // SMTPSetup.Get();
        ObjGensetup.Get();

        if ObjHouseGroups.Get(Rec."House Group") then begin
            VarGroupOfficer := SFactory.FnConvertTexttoBeginingWordstostartWithCapital(ObjHouseGroups."Credit Officer");
        end;

        VarHouseName := SFactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec."House Group Name");
        VarMemberName := SFactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec."Member Name");

        ObjUser.Reset;
        ObjUser.SetRange(ObjUser."User Name", VarGroupOfficer);
        if ObjUser.FindSet then begin
            if ObjUser."Contact Email" = '' then begin
                Error('Email Address Missing for User' + '-' + VarGroupOfficer);
            end;
            VarMailBody := 'This is to inform you that ' + VarMemberName + '  a group Leader of ' + VarHouseName + ' has applied to exit the Group, house group change application no. ' + Rec."Document No";
            //   SFactory.FnSendStatementViaMail(VarGroupOfficer, 'Group Leader Group Exit Alert', VarMailBody, ObjUser."Contact Email", '', ObjGensetup."Credit Department E-mail");
        end;
    end;
}




