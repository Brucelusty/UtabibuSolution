page 17326 "Payment Request Card"
{

    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Payments Header";

    layout
    {
        area(content)
        {
            group(General)

            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    //Editable = DateEditable;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    //Editable = GlobalDimension1CodeEditable;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {

                }


                field("Payment Narration"; Rec."Payment Narration")
                {
                    //Editable = "Payment NarrationEditable";
                }

                field("Total Payment Amount"; Rec."Total Payment Amount")
                {
                }



                field("Total Payment Amount LCY"; Rec."Total Payment Amount LCY")
                {
                    Caption = 'Total Net Amount LCY';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                }

            }
            part("Payment Request"; "Paymet Request Lines")

            {

                SubPageLink = No = FIELD("No.");
            }
        }
    }

    actions
    {

        area(Processing)
        {

            action("Send Approval Request")
            {
                Caption = 'Send A&pproval Request';

                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Text001: Label 'This transaction is already pending approval';

                begin
                    IF Workflowmanagement.CheckPaymentApprovalsWorkflowEnabled(Rec) THEN
                        Workflowmanagement.OnSendPaymentDocForApprovaL(Rec);

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
                    DocumentType := Documenttype::"Payment Voucher";
                    ApprovalEntries.Setrecordfilters(Database::"Payments Header", DocumentType, Rec."No.");
                    ApprovalEntries.Run;
                end;
            }
            action(Print)
            {
                Caption = 'Print/Preview';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PHeader2.RESET;
                    PHeader2.SETRANGE(PHeader2."No.", rec."No.");
                    IF PHeader2.FINDFIRST THEN
                        Report.run(50038, TRUE, TRUE, PHeader2);
                end;
            }
        }
    }

    var
        user: Record "User Setup";
        PHeader2: Record "Payments Header";
        UserMgt: Codeunit "User Setup Management BR";
        Noseries: Codeunit NoSeriesManagement;
        Workflowmanagement: Codeunit WorkflowIntegration;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."No." := Noseries.GetNextNo('PAYMENT R', Today, true);
        Rec."Payment Type" := Rec."Payment Type"::"Payment Request";
        Rec.Status := Rec.Status::New;
        rec."Responsibility Center" := UserMgt.GetSalesFilter();
        rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(USERID, 2);
        rec."Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(USERID, 3);
        rec.VALIDATE("Shortcut Dimension 3 Code");
        rec."Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(USERID, 4);
        if user.Get(UserId) then begin
            rec."Responsibility Center" := user."Responsibility Center";
            rec."Shortcut Dimension 2 Code" := user."Branch Code";
        end;
        rec.VALIDATE("Shortcut Dimension 4 Code");
        rec."Global Dimension 1 Code" := 'BOSA';

    end;
}


