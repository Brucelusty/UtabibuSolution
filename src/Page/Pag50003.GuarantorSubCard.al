#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50003 "Guarantor Sub Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Guarantorship Substitution H";

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
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loanee Member No"; Rec."Loanee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = LoaneeNoEditable;
                }
                field("Loanee Name"; Rec."Loanee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Guaranteed"; Rec."Loan Guaranteed")
                {
                    ApplicationArea = Basic;
                    Editable = LoanGuaranteedEditable;
                }
                field("Substituting Member"; Rec."Substituting Member")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member to be substuted';
                    Editable = SubMemberEditable;
                }
                field("Substituting Member Name"; Rec."Substituting Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Substituted"; Rec."Date Substituted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Substituted By"; Rec."Substituted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000014; "Guarantor Sub Subform")
            {
                SubPageLink = "Document No" = field("Document No"),
                              "Member No" = field("Substituting Member"),
                              "Loan No." = field("Loan Guaranteed");

                ApplicationArea = ALL;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                //ApprovalEntries: Page "Approval Entries";
                begin

                    //ApprovalsMgmt.OpenApprovalEntriesPage(re);
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
                    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    GuarantorshipSubstitutionL: Record "Guarantorship Substitution L";
                begin
                    if Rec.Status <> Rec.Status::Open then
                        Error('Status must be open.');

                    Rec.TestField(Rec."Loanee Member No");
                    Rec.TestField(Rec."Loan Guaranteed");

                    GuarantorshipSubstitutionL.Reset;
                    GuarantorshipSubstitutionL.SetRange("Document No", Rec."Document No");
                    GuarantorshipSubstitutionL.FindFirst;


                    LGuarantor.Reset;
                    LGuarantor.SetRange(LGuarantor."Loan No", Rec."Loan Guaranteed");
                    LGuarantor.SetRange(LGuarantor."Member No", Rec."Substituting Member");
                    if LGuarantor.FindSet then begin
                        //Add All Replaced Amounts
                        TotalReplaced := 0;
                        GSubLine.Reset;
                        GSubLine.SetRange(GSubLine."Document No", Rec."Document No");
                        GSubLine.SetRange(GSubLine."Member No", Rec."Substituting Member");
                        if GSubLine.FindSet then begin
                            repeat
                                TotalReplaced := TotalReplaced + GSubLine."Sub Amount Guaranteed";
                            until GSubLine.Next = 0;
                        end;

                    end;

                    if WorkflowIntegration.CheckGuarantorSubstitutionApprovalsWorkflowEnabled(Rec) then
                        WorkflowIntegration.OnSendGuarantorSubstitutionForApproval(Rec);
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
                // ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if Rec.Status <> Rec.Status::Pending then
                        Error(text001);

                    if WorkflowIntegration.CheckGuarantorSubstitutionApprovalsWorkflowEnabled(Rec) then
                        WorkflowIntegration.OnCancelGuarantorSubstitutionApprovalRequest(Rec);
                end;
            }
            action("Process Substitution")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SMSMessage: Record "SMS Messages";
                    CustomerRecord: Record Customer;
                    iEntryNo: Integer;
                    Cust: Record Customer;
                    compinfo: Record "Company Information";
                    GenSetUp: Record "Sacco General Set-Up";
                    LoanLastEntryNo: Integer;
                begin
                    compinfo.Get;
                    //TestField(Status, Rec.Status::Approved);

                    // Ensure we have a loan and substituting member selected
                    Rec.TestField(Rec."Loan Guaranteed");
                    Rec.TestField(Rec."Substituting Member");

                    // If there are existing guarantors for this loan & member, sum replaced amounts (as before)
                    LGuarantor.Reset;
                    LGuarantor.SetRange(LGuarantor."Loan No", Rec."Loan Guaranteed");
                    LGuarantor.SetRange(LGuarantor."Member No", Rec."Substituting Member");
                    if LGuarantor.FindSet then begin
                        //Add All Replaced Amounts
                        TotalReplaced := 0;
                        GSubLine.Reset;
                        GSubLine.SetRange(GSubLine."Document No", Rec."Document No");
                        GSubLine.SetRange(GSubLine."Member No", Rec."Substituting Member");
                        if GSubLine.FindSet then begin
                            repeat
                                TotalReplaced := TotalReplaced + GSubLine."Sub Amount Guaranteed";
                            until GSubLine.Next = 0;
                        end;
                    end;

                    //Create Lines - for each substitution line create or update loans-guarantee-details
                    GSubLine.Reset;
                    GSubLine.SetRange(GSubLine."Document No", Rec."Document No");
                    // iterate all substitution lines for this document (not only for one substituting member)
                    if GSubLine.FindSet then begin
                        repeat
                            // Prepare "new" guarantor record values
                            NewLGuar.Init;
                            NewLGuar."Loan No" := Rec."Loan Guaranteed";
                            NewLGuar."Member No" := GSubLine."Substitute Member";
                            // Validate member (keeps any validation logic)
                            NewLGuar.Validate(NewLGuar."Member No");
                            NewLGuar.Name := GSubLine."Substitute Member Name";
                            NewLGuar."Amont Guaranteed" := GSubLine."Sub Amount Guaranteed";
                            NewLGuar."Substituted Guarantor" := GSubLine."Member No";

                            // Check if this guarantor already exists for the loan
                            LGuarantor.Reset;
                            LGuarantor.SetRange(LGuarantor."Loan No", NewLGuar."Loan No");
                            LGuarantor.SetRange(LGuarantor."Member No", NewLGuar."Member No");

                            if LGuarantor.FindFirst then begin
                                // Existing guarantor -> add on top of amount
                                LGuarantor."Amont Guaranteed" := LGuarantor."Amont Guaranteed" + NewLGuar."Amont Guaranteed";
                                LGuarantor.Modify;
                            end else begin
                                // New guarantor -> determine next Entry No for that loan and insert
                                // Compute next Entry No (page-level logic, not depending on table-local proc)
                                LoanLastEntryNo := 0;
                                LGuarantor.Reset;
                                LGuarantor.SetRange(LGuarantor."Loan No", NewLGuar."Loan No");
                                if LGuarantor.FindLast then
                                    LoanLastEntryNo := LGuarantor."Entry No."
                                else
                                    LoanLastEntryNo := 0;

                                NewLGuar."Entry No." := LoanLastEntryNo + 1;
                                NewLGuar.Insert;
                            end;
                        until GSubLine.Next = 0;
                    end;

                    // Edit Loan Guar - mark substituted guarantor(s) if present
                    LGuarantor.Reset;
                    LGuarantor.SetRange(LGuarantor."Loan No", Rec."Loan Guaranteed");
                    LGuarantor.SetRange(LGuarantor."Member No", Rec."Substituting Member");
                    if LGuarantor.FindSet then begin
                        LGuarantor.Substituted := true;
                        LGuarantor.Modify(true);

                        // send SMS/messages for substituted guarantor (existing behavior)
                        CustomerRecord.Reset();
                        CustomerRecord.Setrange("No.", LGuarantor."Member No");
                        if CustomerRecord.Find('-') then begin
                            SMSMessage.Reset;
                            if SMSMessage.Find('+') then begin
                                iEntryNo := SMSMessage."Entry No";
                                iEntryNo := iEntryNo + 1;
                            end else begin
                                iEntryNo := 1;
                            end;

                            SMSMessage.Init;
                            SMSMessage."Entry No" := iEntryNo;
                            SMSMessage."Document No" := LGuarantor."Loan No";
                            SMSMessage."Account No" := LGuarantor."Member No";
                            SMSMessage."Date Entered" := Today;
                            SMSMessage."Time Entered" := Time;
                            SMSMessage.Source := 'Sustitution';
                            SMSMessage."Entered By" := UserId;
                            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                            CompInfo.Get();
                            GenSetUp.Get();
                            SMSMessage."SMS Message" := 'Dear Member,you have been sustituted on loan of ' + ' ' + LGuarantor."Loanees  Name"
                                + '.' + ' ' + 'Call' + ' ' + compinfo."Phone No." + ',if in dispute .' + ' ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
                            Cust.Reset;
                            Cust.SetRange(Cust."No.", LGuarantor."Member No");
                            if Cust.Find('-') then begin
                                SMSMessage."Telephone No" := Cust."Mobile Phone No";
                            end;
                            if SMSMessage."Telephone No" <> '' then
                                SMSMessage.Insert;
                        end;
                    end;

                    // Mark header record as substituted and save
                    Rec.Substituted := true;
                    Rec."Date Substituted" := Today;
                    Rec."Substituted By" := UserId;
                    Rec.Modify;

                    Message('Guarantor Substituted Successfully');
                end;

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FNAddRecordRestriction();
    end;

    trigger OnAfterGetRecord()
    begin
        FNAddRecordRestriction();
    end;

    trigger OnOpenPage()
    begin
        Rec."Application Date" := Today;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,GuarantorSubstitution;
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        LGuarantor: Record "Loans Guarantee Details";
        GSubLine: Record "Guarantorship Substitution L";
        LoaneeNoEditable: Boolean;
        LoanGuaranteedEditable: Boolean;
        SubMemberEditable: Boolean;
        TotalReplaced: Decimal;
        Commited: Decimal;
        NewLGuar: Record "Loans Guarantee Details";
        WorkflowIntegration: codeunit WorkflowIntegration;

    local procedure FNAddRecordRestriction()
    begin
        if Rec.Status = Rec.Status::Open then begin
            LoaneeNoEditable := true;
            LoanGuaranteedEditable := true;
            SubMemberEditable := true

        end else
            if Rec.Status = Rec.Status::Pending then begin
                LoaneeNoEditable := false;
                LoanGuaranteedEditable := false;
                SubMemberEditable := false
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    LoaneeNoEditable := false;
                    LoanGuaranteedEditable := false;
                    SubMemberEditable := false;
                end;
    end;

    local procedure CalculateAmountGuaranteed(AmountReplaced: Decimal; TotalAmount: Decimal; AmountGuaranteed: Decimal) AmtGuar: Decimal
    begin
        AmtGuar := ((AmountReplaced / TotalAmount) * AmountGuaranteed);

        exit(AmtGuar);
    end;
}

