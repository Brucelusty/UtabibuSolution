//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172462 "ATM Applications Card"
{
    PageType = Card;
    SourceTable = "ATM Card Applications";

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
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        Rec."Name Length" := StrLen(Rec."Account Name");
                    end;
                }
                field("Product Code";Rec."Product Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category";Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Applicant Name';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        Rec."Name Length" := StrLen(Rec."Account Name");
                    end;
                }
                field("Name Length";Rec."Name Length")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Phone No.";Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("ID No";Rec."ID No")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                }
                field("Card No";Rec."Card No")
                {
                    ApplicationArea = Basic;
                    Editable = CardNoEditable;

                    trigger OnValidate()
                    begin


                        if StrLen(Rec."Card No") <> 16 then
                            Error('ATM No. cannot contain More or less than 16 Characters.');
                    end;
                }
                field("Request Type";Rec."Request Type")
                {
                    ApplicationArea = Basic;
                    Editable = RequestTypeEditable;
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Expiry Date";Rec."ATM Expiry Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Terms Read and Understood";Rec."Terms Read and Understood")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                field("Order ATM Card";Rec."Order ATM Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Order';
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
                field("Card Received";Rec."Card Received")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Card Received By";Rec."Card Received By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Received';
                    Editable = false;
                }
                field("Card Received On";Rec."Card Received On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Collected; Rec.Collected)
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Editable = IssuedtoEditable;
                }
                field("Card Issued to Customer";Rec."Card Issued to Customer")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Card Status";Rec."Card Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Activated";Rec."Date Activated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Frozen";Rec."Date Frozen")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Replacement For Card No";Rec."Replacement For Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Has Other Accounts";Rec."Has Other Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Date";Rec."Approval Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Fee Charged";Rec."ATM Card Fee Charged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Fee Charged On";Rec."ATM Card Fee Charged On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Fee Charged By";Rec."ATM Card Fee Charged By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked";Rec."ATM Card Linked")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked By";Rec."ATM Card Linked By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked On";Rec."ATM Card Linked On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Destroyed; Rec.Destroyed)
                {
                    ApplicationArea = Basic;
                }
                field("Destroyed On";Rec."Destroyed On")
                {
                    ApplicationArea = Basic;
                }
                field("Destroyed By";Rec."Destroyed By")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Delinked";Rec."ATM Delinked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Delinked By";Rec."ATM Delinked By")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Delinked On";Rec."ATM Delinked On")
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
            group("Pesa Point ATM Card")
            {
                Caption = 'Pesa Point ATM Card';
                action("Link ATM Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Link ATM Card';
                    Enabled = EnableActions;
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error('This ATM Card application has not been approved');

                        if Rec."ATM Card Fee Charged" = false then
                            Error('ATM Card Fee has not been Charged on this Application');

                        //Linking Details*******************************************************************************
                        if Confirm('Are you sure you want to link this ATM Card to the Account', false) = true then begin
                            if ObjAccount.Get(Rec."Account No") then begin

                                ObjATMCardsBuffer.Init;
                                ObjATMCardsBuffer."Account No" :=Rec."Account No";
                                ObjATMCardsBuffer."Account Name" :=Rec."Account Name";
                                ObjATMCardsBuffer."Account Type" :=Rec."Account Type C";
                                ObjATMCardsBuffer."ATM Card No" :=Rec."Card No";
                                ObjATMCardsBuffer."ID No" :=Rec."ID No";
                                ObjATMCardsBuffer.Status := ObjATMCardsBuffer.Status::Active;
                                ObjATMCardsBuffer.Insert;
                                //ObjAccount."ATM No.":="Card No";
                                //ObjAccount.MODIFY;
                            end;
                            Rec."ATM Card Linked" := true;
                            Rec."ATM Card Linked By" := UserId;
                            Rec."ATM Card Linked On" := Today;
                            Rec.Modify;
                        end;
                        Message('ATM Card linked to Succesfuly to Account No %1', Rec."Account No");
                        //End Linking Details****************************************************************************

                        //Collection Details***********************************
                        Rec.Collected := true;
                        Rec."Date Collected" := Today;
                        Rec."Card Issued By" := UserId;
                        Rec."Card Status" :=Rec."card status"::Active;
                        Rec.Modify;
                        //End Collection Details******************************



                        Vend.Get(Rec."Account No");
                        Vend."ATM No." :=Rec."Card No";
                        Vend."Atm card ready" := true;
                        Vend.Modify;

                        GeneralSetup.Get();
                        Rec."ATM Expiry Date" := CalcDate(GeneralSetup."ATM Expiry Duration", Today);
                    end;
                }
                action("DeLink ATM Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'DeLink ATM Card';
                    Enabled = EnableActions;
                    Image = DisableAllBreakpoints;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error('This ATM Card application has not been approved');


                        if Rec."Card Status" <> Rec."card status"::Active then
                            Error('Card is not active');


                        Vend.Get(Rec."Account No");
                        if Confirm('Confirm Card Delink?', false) = true then
                            Vend."ATM No." := '';
                        Rec."ATM Delinked" := true;
                        Rec."ATM Delinked By" := UserId;
                        Rec."ATM Delinked On" := WorkDate;
                        Vend.Modify;
                    end;
                }
                action("Enable ATM Card")
                {
                    ApplicationArea = Basic;
                    Enabled = EnableActions;
                    Image = EnableAllBreakpoints;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error('This ATM Card application has not been approved');


                        Vend.Get(Rec."Account No");
                        if Confirm('Are you sure you want to Enable ATM no. for this account  ?', true) = true then
                            Vend."ATM No." :=Rec."Card No";
                        //Vend.Blocked:=Vend.Blocked::Payment;
                        //Vend."Account Frozen":=TRUE;
                        Vend.Modify;

                        Rec."Card Status" :=Rec."card status"::Active;
                        Rec.Modify;
                    end;
                }
                action("Charge ATM Card Fee")
                {
                    ApplicationArea = Basic;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error('This ATM Card application has not been approved');

                        if Rec."ATM Card Fee Charged" = true then
                            Error('This ATM Card application has already been charged');

                        if Rec.Collected = true then
                            Error('The ATM Card has already been collected');

                        if Confirm('Are you sure you want to charge this ATM Card Application?', true) = true then begin


                            ObjGensetup.Get;

                            ObjVendors.Reset;
                            ObjVendors.SetRange(ObjVendors."No.", Rec."Account No");
                            if ObjVendors.Find('-') then begin
                                ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                                AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                                ObjAccTypes.Reset;
                                ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                                if ObjAccTypes.Find('-') then
                                    AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                            end;

                            if Rec."Request Type" = Rec."request type"::New then begin
                                VarTotalATMCardCharge := (ObjGensetup."ATM Card Fee-New Sacco" + ObjGensetup."ATM Card Fee-New Coop") +
                                ((ObjGensetup."ATM Card Fee-New Sacco" + ObjGensetup."ATM Card Fee-New Coop") * (ObjGensetup."Excise Duty(%)" / 100));
                                VarChargeExcTax := (ObjGensetup."ATM Card Fee-New Sacco" + ObjGensetup."ATM Card Fee-New Coop");
                                VarBankAmount := ObjGensetup."ATM Card Fee-New Coop";
                                VarSaccoAmount := ObjGensetup."ATM Card Fee-New Sacco";
                                VarTaxAmount := ((ObjGensetup."ATM Card Fee-New Sacco" + ObjGensetup."ATM Card Fee-New Coop") * (ObjGensetup."Excise Duty(%)" / 100))
                            end else
                                if Rec."Request Type" = Rec."request type"::Replacement then begin
                                    VarTotalATMCardCharge := (ObjGensetup."ATM Card Fee-Replacement SACCO" + ObjGensetup."ATM Card Fee-Replacement Coop") +
                                    ((ObjGensetup."ATM Card Fee-Replacement SACCO" + ObjGensetup."ATM Card Fee-Replacement Coop") * (ObjGensetup."Excise Duty(%)" / 100));
                                    VarChargeExcTax := (ObjGensetup."ATM Card Fee-Replacement SACCO" + ObjGensetup."ATM Card Fee-Replacement Coop");
                                    VarBankAmount := ObjGensetup."ATM Card Fee-Replacement Coop";
                                    VarSaccoAmount := ObjGensetup."ATM Card Fee-Replacement SACCO";
                                    VarTaxAmount := ((ObjGensetup."ATM Card Fee-Replacement SACCO" + ObjGensetup."ATM Card Fee-Replacement Coop") * (ObjGensetup."Excise Duty(%)" / 100))
                                end else
                                    if Rec."Request Type" = Rec."request type"::Renewal then begin
                                        VarTotalATMCardCharge := (ObjGensetup."ATM Card Renewal Fee Sacco" + ObjGensetup."ATM Card Renewal Fee Coop") +
                                        ((ObjGensetup."ATM Card Renewal Fee Sacco" + ObjGensetup."ATM Card Renewal Fee Coop") * (ObjGensetup."Excise Duty(%)" / 100));
                                        VarChargeExcTax := (ObjGensetup."ATM Card Renewal Fee Sacco" + ObjGensetup."ATM Card Renewal Fee Coop");
                                        VarBankAmount := ObjGensetup."ATM Card Renewal Fee Coop";
                                        VarSaccoAmount := ObjGensetup."ATM Card Renewal Fee Sacco";
                                        VarTaxAmount := ((ObjGensetup."ATM Card Renewal Fee Sacco" + ObjGensetup."ATM Card Renewal Fee Coop") * (ObjGensetup."Excise Duty(%)" / 100));
                                    end;

                            if (VarTotalATMCardCharge > AvailableBal) and (Rec."Product Code" <> '403') then
                                Error('Member Account has insufficient Balance for this Application. Available Balance is %1', AvailableBal);

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                            GenJournalLine.DeleteAll;



                            //=======================================================================================Debit FOSA Account
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine('GENERAL', 'DEFAULT',Rec."No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                                    Rec."Account No", WorkDate, VarChargeExcTax, 'FOSA', Rec."No.", 'ATM Card Application Fees', '', GenJournalLine."application source"::" ");

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine('GENERAL', 'DEFAULT',Rec."No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                                    Rec."Account No", WorkDate, VarTaxAmount, 'FOSA',Rec."No.", 'Tax: ATM Card Application Fees', '', GenJournalLine."application source"::" ");


                            //=======================================================================================Credit Bank With Charge and Tax
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine('GENERAL', 'DEFAULT',Rec."No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"Bank Account",
                                    ObjGensetup."ATM Card Co-op Bank Account", WorkDate, (VarBankAmount + (VarBankAmount * (ObjGensetup."Excise Duty(%)" / 100))) * -1, 'FOSA',Rec."No.", 'ATM Card Application Fees - ' + Rec."Account No", '', GenJournalLine."application source"::" ");


                            //=======================================================================================Credit Income Account
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine('GENERAL', 'DEFAULT',Rec."No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                                    ObjGensetup."ATM Card Income Account", WorkDate, VarSaccoAmount * -1, 'FOSA',Rec."No.", 'ATM Card Application Fee - ' + Rec."Account No", '', GenJournalLine."application source"::" ");

                            //=======================================================================================Credit Tax:ATM Card Fee G/L Account
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine('GENERAL', 'DEFAULT',Rec."No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                                    ObjGensetup."Excise Duty Account", WorkDate, (VarSaccoAmount * ObjGensetup."Excise Duty(%)" / 100) * -1, 'FOSA',Rec."No.", 'Tax: ATM Card Application Fees - ' + Rec."Account No", '', GenJournalLine."application source"::" ");


                            //CU Post
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            end;

                            Rec."ATM Card Fee Charged" := true;
                            Rec."ATM Card Fee Charged By" := UserId;
                            Rec."ATM Card Fee Charged On" := Today;
                            Message('ATM Card Fee Posted Succesfully');
                        end;
                    end;
                }
                action(DestroyCard)
                {
                    ApplicationArea = Basic;
                    Caption = 'Destroy Card';
                    Enabled = EnableActions;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;

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
            }
            group(Approvals)
            {
                action(Approval)
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
                        DocumentType := Documenttype::ATMCard;
                        ApprovalEntries.SetRecordFilters(Database::"ATM Card Applications", DocumentType,Rec."No.");
                        ApprovalEntries.Run;
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

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowIntegration: Codeunit WorkflowIntegration;
                    begin

                        ObjGensetup.Get;

                        ObjVendors.Reset;
                        ObjVendors.SetRange(ObjVendors."No.",Rec."Account No");
                        if ObjVendors.Find('-') then begin
                            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                            AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                            ObjAccTypes.Reset;
                            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                            if ObjAccTypes.Find('-') then
                                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                        end;
                        if Rec."Request Type" = Rec."request type"::New then begin
                            VarTotalATMCardCharge := (ObjGensetup."ATM Card Fee-New Sacco" + ObjGensetup."ATM Card Fee-New Coop") +
                            ((ObjGensetup."ATM Card Fee-New Sacco" + ObjGensetup."ATM Card Fee-New Coop") * (ObjGensetup."Excise Duty(%)" / 100))
                        end else
                            if Rec."Request Type" = Rec."request type"::Replacement then begin
                                VarTotalATMCardCharge := (ObjGensetup."ATM Card Fee-Replacement SACCO" + ObjGensetup."ATM Card Fee-Replacement Coop") +
                                ((ObjGensetup."ATM Card Fee-Replacement SACCO" + ObjGensetup."ATM Card Fee-Replacement Coop") * (ObjGensetup."Excise Duty(%)" / 100))
                            end else
                                if Rec."Request Type" = Rec."request type"::Renewal then begin
                                    VarTotalATMCardCharge := (ObjGensetup."ATM Card Renewal Fee Sacco" + ObjGensetup."ATM Card Renewal Fee Coop") +
                                    ((ObjGensetup."ATM Card Renewal Fee Sacco" + ObjGensetup."ATM Card Renewal Fee Coop") * (ObjGensetup."Excise Duty(%)" / 100))
                                end;

                        if (VarTotalATMCardCharge > AvailableBal) and (Rec."ATM Card Fee Charged" = false) and (Rec."Product Code" <> '403') then
                            Error('Member Account has insufficient Balance for this Application. Available Balance is %1', AvailableBal);





                        ATMCardApplication.Reset;
                        ATMCardApplication.SetRange(ATMCardApplication."Account No",Rec."Account No");
                        ATMCardApplication.SetRange(ATMCardApplication."ID No",Rec."ID No");
                        ATMCardApplication.SetRange(ATMCardApplication."Order ATM Card", false);
                        if ATMCardApplication.Find('-') then
                            if ATMCardApplication.Count > 1 then
                                Error('This Account already has an ATM Card Application \for the same ID Number that is pending to be ordered.');

                        if StrLen(Rec."Account Name") > 21 then
                            Error('The ATM Card Applicant Name cannot be more than 21 characters.');

                        if WorkflowIntegration.CheckATMCardApprovalsWorkflowEnabled(Rec) then
                            WorkflowIntegration.OnSendATMCardForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowIntegration: Codeunit WorkflowIntegration;
                    begin

                        if WorkflowIntegration.CheckATMCardApprovalsWorkflowEnabled(Rec) then
                            WorkflowIntegration.OnCancelATMCardApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        EnableActions := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableActions := true;


        FnAddRecRestriction();
    end;

    trigger OnAfterGetRecord()
    begin
        Rec."Name Length" := StrLen(Rec."Account Name");
        EnableActions := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableActions := true;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        AccountHolders: Record Vendor;
        window: Dialog;
        PostingCode: Codeunit "Gen. Jnl.-Post Line";
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Office/Group";
        PictureExists: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        ForfeitInterest: Boolean;
        InterestBuffer: Record "Interest Buffer";
        FDType: Record "Fixed Deposit Type";
        Vend: Record Vendor;
        Cust: Record Customer;
        UsersID: Record User;
        Bal: Decimal;
        AtmTrans: Decimal;
        UnCheques: Decimal;
        AvBal: Decimal;
        Minbal: Decimal;
        GeneralSetup: Record "Sacco General Set-Up";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest;
        AccountNoEditable: Boolean;
        CardNoEditable: Boolean;
        CardTypeEditable: Boolean;
        RequestTypeEditable: Boolean;
        ReplacementCardNoEditable: Boolean;
        IssuedtoEditable: Boolean;
        ObjAccount: Record Vendor;
        ObjATMCardsBuffer: Record "ATM Card Nos Buffer";
        EnableActions: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        AccountNameEditable: Boolean;
        IDNoEditable: Boolean;
        PhoneNoEditable: Boolean;
        ATMCardApplication: Record "ATM Card Applications";
        VarTotalATMCardCharge: Decimal;
        ObjGensetup: Record "Sacco General Set-Up";
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        SFactory: Codeunit "Au Factory";
        VarChargeExcTax: Decimal;
        VarTaxAmount: Decimal;
        VarBankAmount: Decimal;
        VarSaccoAmount: Decimal;

    local procedure FnGetUserBranch() branchCode: Code[50]
    var
        UserSetup: Record User;
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User Name", UserId);
        if UserSetup.Find('-') then begin
            //  branchCode:=UserSetup."Branch Code";
        end;
        exit(branchCode);
    end;

    local procedure FnAddRecRestriction()
    begin
        if Rec.Status = Rec.Status::Open then begin
            AccountNoEditable := true;
            CardNoEditable := false;
            CardTypeEditable := true;
            ReplacementCardNoEditable := true;
            IssuedtoEditable := false;
            AccountNameEditable := true;
            IDNoEditable := true;
            PhoneNoEditable := true;
            RequestTypeEditable := true;
        end else
            if Rec.Status = Rec.Status::Pending then begin
                AccountNoEditable := false;
                CardNoEditable := false;
                CardTypeEditable := false;
                ReplacementCardNoEditable := false;
                IssuedtoEditable := false;
                AccountNameEditable := false;
                IDNoEditable := false;
                PhoneNoEditable := false;
                RequestTypeEditable := false;
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    AccountNoEditable := false;
                    CardNoEditable := true;
                    CardTypeEditable := false;
                    ReplacementCardNoEditable := true;
                    IssuedtoEditable := true;
                    AccountNameEditable := false;
                    IDNoEditable := false;
                    PhoneNoEditable := false;
                    RequestTypeEditable := false;
                end;
    end;
}