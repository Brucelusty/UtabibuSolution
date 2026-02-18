//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 20385 "MOBILE Application Card"
{
    PageType = Card;
    SourceTable = "MOBILE Applications";
    Caption = 'Mobile Banking Application Card';
    DelayedInsert = true;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Time Applied"; Rec."Time Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Approvals")
            {
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;
                    //      PromotedCategory=
                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status = Rec.Status::Approved then
                            Error('The record is already approved.');
                        if Rec.Status = Rec.Status::" Pending Approval" then
                            Error('The record is already Pending Approval.');
                        Codeunit.RUN(CODEUNIT::"Custom Workflow Events");

                        //if WorkflowManagement.CheckMobileApplicationApprovalsWorkflowEnabled(Rec) then
                        //    WorkflowManagement.OnSendMobileApplicationForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status = Rec.Status::Application then
                            Error('The record is already open.');
                        Rec.Status := Rec.Status::Application;
                        Rec.Modify;

                    end;
                }
                action(Deactivate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deactivate';
                    Image = Approvals;
                    Promoted = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to deactivate?') = false then exit;
                        Rec.Activated := false;
                        Rec.Modify(true);
                    end;

                }

                action(ReActivate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Re Activate ';
                    Image = Approvals;
                    Promoted = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        // if Confirm('Are you sure you want to deactivate?') = false then exit;
                        Rec.Activated := false;
                        // Rec.Validate("Account No");
                        Rec.Modify(true);
                    end;

                }

                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MobileApplication;
                        ApprovalEntries.SetRecordFilters(Database::"MOBILE Applications", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }
    var
        WorkflowManagement: Codeunit WorkflowIntegration;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,MobileApplication;
}




