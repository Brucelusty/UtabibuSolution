//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172527 "Cheque Application"
{
    PageType = Card;
    SourceTable = "Cheque Book Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No.";Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No.";Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Book Type";Rec."Cheque Book Type")
                {
                    ApplicationArea = Basic;
                    Editable = ChequeBookTypeEditable;
                }
                field("Begining Cheque No.";Rec."Begining Cheque No.")
                {
                    ApplicationArea = Basic;
                    Editable = BeginingChequeNoEditable;
                }
                field("End Cheque No.";Rec."End Cheque No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility Centre";Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last check";Rec."Last check")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Book Account No.";Rec."Cheque Book Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Register Generated";Rec."Cheque Register Generated")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Cheque Book charges Posted";Rec."Cheque Book charges Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requested By";Rec."Requested By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(Details)
            {
                Editable = true;
                field("Cheque Book Fee Charged";Rec."Cheque Book Fee Charged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Book Fee Charged On";Rec."Cheque Book Fee Charged On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Book Fee Charged By";Rec."Cheque Book Fee Charged By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Book Ordered";Rec."Cheque Book Ordered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ordered By";Rec."Ordered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ordered On";Rec."Ordered On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Book Received";Rec."Cheque Book Received")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received By";Rec."Received By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received On";Rec."Received On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Listed For Destruction";Rec."Listed For Destruction")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Destroyed; Rec.Destroyed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Destroyed On";Rec."Destroyed On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Destroyed By";Rec."Destroyed By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Collected; Rec.Collected)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Confirm('Confirm Cheque Dispatch ?', false) = true then begin
                            Rec."Date Collected" := WorkDate;
                            Rec."Card Issued By" := UserId;
                        end;
                    end;
                }
                field("Date Collected";Rec."Date Collected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Card Issued By";Rec."Card Issued By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Issued to";Rec."Issued to")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Issue/Generate Cheque Register")
            {
                ApplicationArea = Basic;
                Caption = 'Receive Cheque Book';
                Image = Interaction;

                trigger OnAction()
                begin

                    if Rec."Cheque Register Generated" then
                        Error('Cheque generation already done');
                    Rec.TestField("Begining Cheque No.");
                    Rec.TestField("End Cheque No.");
                    IncrNo := Rec."Begining Cheque No.";

                    if Rec."End Cheque No." < Rec."Begining Cheque No." then
                        Error('Beginning number is more than ending number');


                    while IncrNo <= Rec."End Cheque No." do begin
                        CheqReg.Init;
                        CheqReg."Cheque Book Account No." := Rec."Cheque Book Account No.";
                        CheqReg."Cheque No." := IncrNo;
                        CheqReg."Application No." := Rec."No.";
                        CheqReg."Account No." := Rec."Account No.";
                        CheqReg.Insert;

                        IncrNo := IncStr(IncrNo);
                    end;

                    Rec."Cheque Book Received" := true;
                    Rec."Received On" := WorkDate;
                    Rec."Received By" := UserId;
                    Rec."Cheque Register Generated" := true;
                    Rec.Modify;

                    ObjVendors.Reset;
                    ObjVendors.SetRange(ObjVendors."No.", Rec."Account No.");
                    if ObjVendors.FindSet then begin
                        ObjMember.Reset;
                        ObjMember.SetRange(ObjMember."No.", ObjVendors."BOSA Account No");
                        if ObjMember.FindSet then begin
                            SMSMessage := 'Dear ' + ObjMember.Name + ', your new cheque book for Account No. ' + Rec."Account No." + ' is ready for collection. Please note,' +
                            'if not collected within 60 days the cheque book will be discarded. Kindly come with your original ID Card. Kingdom Sacco.';
                            //  CloudPesa.SMSMessageTBL("No.","Account No.",ObjMember."Mobile Phone No",CopyStr(SMSMessage,1,250),CopyStr(SMSMessage,251,500));
                        end;
                    end;

                    Message('The Cheque Book has successfully been recieved, cheque register generated and Member notified via SMS to collect the cheque book');
                end;
            }
            action("Cheque Register")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                RunObject = Page "Cheque Register List";
                RunPageLink = "Application No." = field("No.");
            }
            action("Post Cheque Book Charges")
            {
                ApplicationArea = Basic;
                Image = Post;

                trigger OnAction()
                begin

                    if Rec."Cheque Book charges Posted" = true then begin
                        Error('Cheque book charges has already been posted');
                    end;

                    if Confirm('Are you sure you want post cheques', true) = true then begin

                        ObjChequeBookType.Reset;
                        ObjChequeBookType.SetRange(ObjChequeBookType."Cheque Code", Rec."Cheque Book Type");
                        if ObjChequeBookType.Find('-') then begin

                            ObjGensetup.Get;

                            ObjVendors.Reset;
                            ObjVendors.SetRange(ObjVendors."No.", Rec."Account No.");
                            if ObjVendors.Find('-') then begin
                                ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                                AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                                ObjAccTypes.Reset;
                                ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                                if ObjAccTypes.Find('-') then
                                    AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                            end;

                            VarTotalChequeBookCharges := ObjChequeBookType.Amount + (ObjChequeBookType.Amount * (ObjGensetup."Excise Duty(%)" / 100));
                            if VarTotalChequeBookCharges > AvailableBal then
                                Error('Member Account has insufficient Balance for this Transaction. Available Balance is %1', AvailableBal);

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'CHQTRANS');
                            GenJournalLine.DeleteAll;



                            //=======================================================================================Debit FOSA Account
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine('GENERAL', 'CHQTRANS', Rec."No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                                    Rec."Account No.", WorkDate, ObjChequeBookType.Amount, 'FOSA', Rec."Account No.", 'Cheque Book Application fees', '', GenJournalLine."application source"::" ");

                            //=======================================================================================Credit G/L Cheque Book Fee Account Account
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine('GENERAL', 'CHQTRANS', Rec."No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                                    ObjChequeBookType."Charge G/L Account", WorkDate, -ObjChequeBookType.Amount, 'FOSA', Rec."Cheque Book Account No.", 'Cheque Book Application fees - ' + Rec."Account No.", '', GenJournalLine."application source"::" ");


                            //=======================================================================================Debit Tax:Cheque Book Fee FOSA Account
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine('GENERAL', 'CHQTRANS', Rec."No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                                    Rec."Account No.", WorkDate, (ObjChequeBookType.Amount * (ObjGensetup."Excise Duty(%)" / 100)), 'FOSA', Rec."Cheque Book Account No.", 'Tax: Cheque Book fees', '', GenJournalLine."application source"::" ");

                            //=======================================================================================Credit Tax:Cheque Book Fee G/L Account
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine('GENERAL', 'CHQTRANS', Rec."No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                                    ObjGensetup."Excise Duty Account", WorkDate, -(ObjChequeBookType.Amount * (ObjGensetup."Excise Duty(%)" / 100)), 'FOSA', Rec."Cheque Book Account No.", 'Tax: Cheque Book fees - ' + Rec."Account No.", '', GenJournalLine."application source"::" ");


                            //CU Post
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'CHQTRANS');
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            end;

                            Rec."Cheque Book charges Posted" := true;
                            Rec."Cheque Book Fee Charged" := true;
                            Rec."Cheque Book Fee Charged By" := UserId;
                            Rec."Cheque Book Fee Charged On" := WorkDate;
                            Message('Cheque book charged successfully');
                        end;
                    end;
                end;
            }
            action(DestroyChequeBook)
            {
                ApplicationArea = Basic;
                Caption = 'Destroy Cheque Book';
                Image = Reject;

                trigger OnAction()
                begin
                    if Confirm('Confirm destruction?', false) = true then begin
                        Rec.Destroyed := true;
                        Rec."Destroyed By" := UserId;
                        Rec."Destroyed On" := WorkDate;
                        Rec."Destruction Approval" := true;
                    end;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                Image = SendApprovalRequest;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ObjVendors.Reset;
                    ObjVendors.SetRange(ObjVendors."No.", Rec."Account No.");
                    if ObjVendors.Find('-') then begin
                        ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                        AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                    end;

                    VarTotalChequeBookCharges := Charges."Charge Amount" + (Charges."Charge Amount" * (ObjGensetup."Excise Duty(%)" / 100));
                    if VarTotalChequeBookCharges > AvailableBal then
                        Error('Member Account has insufficient Balance for this Transaction. Available Balance is %1', AvailableBal);




                    if WkFlwIntegration.CheckChequeBookApprovalsWorkflowEnabled(Rec) then
                        WkFlwIntegration.OnSendChequeBookForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        WkFlwIntegration.OnCancelChequeBookApprovalRequest(Rec);

                end;
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::ChequeBookApplication;
                    ApprovalEntries.SetRecordFilters(Database::"Cheque Book Application", DocumentType, Rec."No.");
                    ApprovalEntries.Run;
                end;
            }
        }
        area(Promoted)
        {
            group(Category_New)
            {
                actionref("Issue/Generate Cheque Register_Promoted"; "Issue/Generate Cheque Register")
                {
                }
                actionref("Cheque Register_Promoted"; "Cheque Register")
                {
                }
                actionref("Post Cheque Book Charges_Promoted"; "Post Cheque Book Charges")
                {
                }
            }
            group(Category_Process)
            {
                actionref(DestroyChequeBook_Promoted; DestroyChequeBook)
                {
                }
            }
            group(Category_Category4)
            {
                actionref("Send Approval Request_Promoted"; "Send Approval Request")
                {
                }
                actionref("Cancel Approval Request_Promoted"; "Cancel Approval Request")
                {
                }
                actionref(Approval_Promoted; Approval)
                {
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        EnableCreateMember := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableCreateMember := true;


        if (Rec.Status = Rec.Status::"Pending Approval") then begin
            AccountNoEditable := false;
            BeginingChequeNoEditable := false;
            EndingChequeNoEditable := false;
            ChequeBookTypeEditable := false;
        end;

        if (Rec.Status = Rec.Status::Approved) then begin
            AccountNoEditable := false;
            BeginingChequeNoEditable := true;
            EndingChequeNoEditable := true;
            ChequeBookTypeEditable := false;
        end;
        if (Rec.Status = Rec.Status::Open) then begin
            AccountNoEditable := true;
            BeginingChequeNoEditable := false;
            EndingChequeNoEditable := false;
            ChequeBookTypeEditable := true;
        end;
    end;

    trigger OnAfterGetRecord()
    begin

        EnableCreateMember := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableCreateMember := true;


        if (Rec.Status = Rec.Status::"Pending Approval") then begin
            AccountNoEditable := false;
            BeginingChequeNoEditable := false;
            EndingChequeNoEditable := false;
            ChequeBookTypeEditable := false;
        end;

        if (Rec.Status = Rec.Status::Approved) then begin
            AccountNoEditable := false;
            BeginingChequeNoEditable := true;
            EndingChequeNoEditable := true;
            ChequeBookTypeEditable := false;
        end;
        if (Rec.Status = Rec.Status::Open) then begin
            AccountNoEditable := true;
            BeginingChequeNoEditable := false;
            EndingChequeNoEditable := false;
            ChequeBookTypeEditable := true;
        end;
    end;

    trigger OnOpenPage()
    begin

        if (Rec.Status = Rec.Status::"Pending Approval") then begin
            AccountNoEditable := false;
            BeginingChequeNoEditable := false;
            EndingChequeNoEditable := false;
            ChequeBookTypeEditable := false;
        end;

        if (Rec.Status = Rec.Status::Approved) then begin
            AccountNoEditable := false;
            BeginingChequeNoEditable := true;
            EndingChequeNoEditable := true;
            ChequeBookTypeEditable := false;
        end;
        if (Rec.Status = Rec.Status::Open) then begin
            AccountNoEditable := true;
            BeginingChequeNoEditable := false;
            EndingChequeNoEditable := false;
            ChequeBookTypeEditable := true;
        end;
    end;

    var
        CheqReg: Record "Cheques Register";
        IncrNo: Code[10];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Vend: Record Vendor;
        AccountTypeS: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        Charges: Record Charges;
        GenSetup: Record "Sacco General Set-Up";
        ChequeSetUp: Record "Cheque Set Up";
        "TOTAL CHARGES": Decimal;
        TEST: Code[10];
        EnableCreateMember: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure,SweepingInstructions,ChequeBookApplication;
        SFactory: Codeunit "Au Factory";
        ObjGensetup: Record "Sacco General Set-Up";
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarTotalChequeBookCharges: Decimal;
        ObjChequeBookType: Record "Cheque Set Up";
        BeginingChequeNoEditable: Boolean;
        EndingChequeNoEditable: Boolean;
        AccountNoEditable: Boolean;
        ChequeBookTypeEditable: Boolean;
        ObjMember: Record "Members Register";
        SMSMessage: Text;

        WkFlwIntegration: Codeunit WorkflowIntegration;
}




