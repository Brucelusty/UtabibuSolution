//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17217 "Standing Order Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Standing Orders";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Source Account Type"; Rec."Source Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No."; Rec."BOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                    // Importance = Additional;
                }

                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                    AssistEdit = false;
                    Editable = false;
                    Visible = false;
                }
                field("Staff/Payroll No."; Rec."Staff/Payroll No.")
                {
                    ApplicationArea = Basic;
                    AssistEdit = false;
                    Editable = false;
                    Visible = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("Source Account Narrations"; Rec."Source Account Narrations")
                {
                    ApplicationArea = Basic;
                    Caption = 'STO Narration';
                }
                field("Source Global Dimension 1 Code"; Rec."Source Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Source Account Activity';
                    visible = False;
                }
                field("Source Global Dimension 2 Code"; Rec."Source Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Source Account Branch';
                    visible = False;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = AmountEditable;
                }
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                    visible = False;
                    Editable = DestinationAccountTypeEditable;
                    OptionCaption = '<,Member Account,Other Banks Account,G/L Account,Supplier Account,Loan Account';

                    trigger OnValidate()
                    begin
                        ReceiptAllVisible := false;
                        DestinationAccountsVisible := false;

                        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
                            ReceiptAllVisible := false;
                            DestinationAccountsVisible := true;
                        end;


                        BankDetailsVisible := false;
                        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
                            BankDetailsVisible := true;
                            DestinationAccountsVisible := true;
                        end;


                        ReceiptAllVisible := false;
                        DestinationAccountsVisible := false;

                        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
                            ReceiptAllVisible := false;
                            DestinationAccountsVisible := true;
                        end;


                        BankDetailsVisible := false;
                        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
                            BankDetailsVisible := true;
                            DestinationAccountsVisible := true;
                        end;
                    end;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;
                    visible = False;
                    Editable = DestinationAccountNoEditable;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                    visible = False;
                    Editable = DestinationAccountNameEditable;
                }
                group(BankDetails)
                {
                    Caption = 'Bank Details';

                    Visible = BankDetailsVisible;
                    field("Bank Code"; Rec."Bank Code")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            BankName := '';
                            if Banks.Get(Rec."Bank Code") then
                                BankName := Banks."Bank Name";
                        end;
                    }
                    field(BankName; BankName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bank Name';
                    }
                }
                field("Destination Account Narrations"; Rec."Destination Account Narrations")
                {
                    ApplicationArea = Basic;
                    Caption = 'Destination Account Narration';
                    visible = False;
                }
                field("Dest. Global Dimension 1 Code"; Rec."Dest. Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Destination Account Activity';
                    visible = False;
                }
                field("Dest. Global Dimension 2 Code"; Rec."Dest. Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Destination Account Branch';
                    visible = False;
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Effective/Start Date"; Rec."Effective/Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = EffectiveDateEditable;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                    Editable = DurationEditable;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic;
                    Editable = FrequencyEditable;
                }
                field("Execute Condition"; Rec."Execute Condition")
                {
                    ApplicationArea = Basic;
                    visible = False;
                    ToolTip = 'Specify Execute Condition when funds are not Sufficient';

                    trigger OnValidate()
                    begin
                        ExecuteConditionVisible := false;
                        if Rec."Execute Condition" = Rec."execute condition"::"If no Funds Retry Standing Order" then begin
                            ExecuteConditionVisible := true;
                        end;
                    end;
                }
                field("Don't Allow Partial Deduction"; Rec."Don't Allow Partial Deduction")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    visible = False;
                }
                field(Unsuccessfull; Rec.Unsuccessfull)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Next Run Date"; Rec."Next Run Date")
                {
                    ApplicationArea = Basic;
                }
                group("Retry Details:")
                {
                    Caption = 'Retry Details:';
                    Visible = ExecuteConditionVisible;
                    field("No of Tolerance Days"; Rec."No of Tolerance Days")
                    {
                        ApplicationArea = Basic;
                        Caption = 'No of Retry Days';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("End of Tolerance Date"; Rec."End of Tolerance Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Last Retry Date';
                        Editable = false;
                        ToolTip = 'This is the last date the system will attempt to run the standing order after the tolerance period';
                    }
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Effected; Rec.Effected)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Auto Process"; Rec."Auto Process")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Standing Order Dedution Type"; Rec."Standing Order Dedution Type")
                {
                    ApplicationArea = Basic;
                }
                field("None Salary"; Rec."None Salary")
                {
                    ApplicationArea = Basic;
                }
                field("Date Reset"; Rec."Date Reset")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
            }
            // part("Receipt Allocation";Rec."Receipt Allocation-BOSA")
            // {
            //     SubPageLink = "Document No" = field("No.");
            //     Visible = ReceiptAllVisible;
            // }
            part("Receipt Allocation"; "Receipt Allocation-BOSA")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
        area(factboxes)
        {
            part(Control25; "FOSA Statistics FactBox")
            {
                SubPageLink = "BOSA Account No" = field("BOSA Account No.");
                Visible = false;
            }
            part(Control1000000052; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("BOSA Account No.");

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Reset)
            {
                ApplicationArea = Basic;
                Caption = 'Reset';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reset the standing order?') = true then begin

                        Rec.Effected := false;
                        Rec.Balance := 0;
                        Rec.Unsuccessfull := false;
                        Rec."Auto Process" := false;
                        Rec."Date Reset" := Today;
                        Rec.Modify;

                        RAllocations.Reset;
                        RAllocations.SetRange(RAllocations."Document No", Rec."No.");
                        if RAllocations.Find('-') then begin
                            repeat
                                RAllocations."Amount Balance" := 0;
                                RAllocations."Interest Balance" := 0;
                                RAllocations.Modify;
                            until RAllocations.Next = 0;
                        end;

                    end;
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Source Account No.");
                    if Rec."Destination Account Type" <> Rec."destination account type"::"Other Banks Account" then
                        Rec.TestField("Destination Account No.");
                    Rec.TestField("Effective/Start Date");
                    Rec.TestField(Frequency);
                    Rec.TestField("Next Run Date");


                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing order status.');
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing status.');
                end;
            }
            action(Stop)
            {
                ApplicationArea = Basic;
                Caption = 'Stop';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to stop the standing order.');

                    if Confirm('Are you sure you want to stop the standing order?', false) = true then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify;
                    end;
                end;
            }
            group(Approvals)
            {
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        Rec.TestField("Effective/Start Date");
                        Rec.TestField(Frequency);
                        Rec.TestField("Next Run Date");

                        if Rec.Status <> Rec.Status::Open then
                            Error(Text001);

                        if workflowintegration.CheckStandingOrderApprovalsWorkflowEnabled(Rec) then
                            workflowintegration.OnSendStandingOrderForApproval(Rec);
                        Rec.Status := Rec.Status::Approved;
                        //Rec.Modify();
                        Message('Record has been approved.');
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if workflowintegration.CheckStandingOrderApprovalsWorkflowEnabled(Rec) then begin
                            workflowintegration.OnCancelStandingOrderApprovalRequest(Rec);
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
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
                        DocumentType := Documenttype::StandingOrder;

                        ApprovalEntries.SetRecordFilters(Database::"Standing Orders", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
        area(creation)
        {
            action(Create_STO)
            {
                ApplicationArea = Basic;
                Caption = 'Create_STO';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Source Account No.");
                    if Rec."Destination Account Type" <> Rec."destination account type"::"Other Banks Account" then
                        Rec.TestField("Destination Account No.");
                    Rec.TestField("Effective/Start Date");
                    Rec.TestField(Frequency);
                    Rec.TestField("Next Run Date");

                    //IF Status<>Status::"2" THEN
                    //ERROR('Standing order status must be approved for you to create it');

                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing order status.');
                end;
            }
            action(Stop_STO)
            {
                ApplicationArea = Basic;
                Caption = 'Stop_STO';
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*StatusPermissions.RESET;
                    StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                    StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Standing Order");
                    IF StatusPermissions.FIND('-') = FALSE THEN
                    ERROR('You do not have permissions to stop the standing order.');*/

                    if Confirm('Are you sure you want to stop the standing order?', false) = true then begin
                        STOs.Reset;
                        STOs.SetRange(STOs."No.", Rec."No.");
                        if STOs.FindSet then begin
                            STOs."Stopped By" := UserId;
                            STOs."Stopped On" := CurrentDatetime;
                            STOs."Is Active" := false;
                            STOs.Status := Rec.Status::Stopped;
                            STOs.Modify;
                        end;
                    end;

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BankName := '';
        if Banks.Get(Rec."Bank Code") then
            BankName := Banks."Bank Name";

        ReceiptAllVisible := false;
        DestinationAccountsVisible := false;

        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
            ReceiptAllVisible := false;
            DestinationAccountsVisible := true;
        end;


        BankDetailsVisible := false;
        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
            BankDetailsVisible := true;
            DestinationAccountsVisible := true;
        end;



        if Rec.Status = Rec.Status::Open then begin
            AmountEditable := true;
            DestinationAccountNoEditable := true;
            DestinationAccountNameEditable := true;
            FrequencyEditable := true;
            DurationEditable := true;
            EffectiveDateEditable := true;
            DestinationAccountTypeEditable := true
        end else
            if Rec.Status = Rec.Status::Pending then begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false
            end else begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false;
            end;

        ExecuteConditionVisible := false;
        if Rec."Execute Condition" = Rec."execute condition"::"If no Funds Retry Standing Order" then begin
            ExecuteConditionVisible := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable := false;

        ReceiptAllVisible := false;

        BankDetailsVisible := false;
        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
            BankDetailsVisible := true;
        end;

        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
            ReceiptAllVisible := false;
            DestinationAccountsVisible := true;
        end;




        if Rec.Status = Rec.Status::Open then begin
            AmountEditable := true;
            DestinationAccountNoEditable := true;
            DestinationAccountNameEditable := true;
            FrequencyEditable := true;
            DurationEditable := true;
            EffectiveDateEditable := true;
            DestinationAccountTypeEditable := true
        end else
            if Rec.Status = Rec.Status::Pending then begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false
            end else begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false;
            end;


        ExecuteConditionVisible := false;
        if Rec."Execute Condition" = Rec."execute condition"::"If no Funds Retry Standing Order" then begin
            ExecuteConditionVisible := true;
        end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        BankName: Text[20];
        Banks: Record Banks;
        UsersID: Record User;
        RAllocations: Record "Receipt Allocation";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        ReceiptAllVisible: Boolean;
        ObjAccount: Record Vendor;
        BankDetailsVisible: Boolean;
        AmountEditable: Boolean;
        DestinationAccountTypeEditable: Boolean;
        DestinationAccountNoEditable: Boolean;
        EffectiveDateEditable: Boolean;
        FrequencyEditable: Boolean;
        DescriptionEditable: Boolean;
        DestinationAccountNameEditable: Boolean;
        DurationEditable: Boolean;
        DestinationAccountsVisible: Boolean;
        ExecuteConditionVisible: Boolean;
        STOs: Record "Standing Orders";
        workflowintegration: Codeunit WorkflowIntegration;

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;
}




