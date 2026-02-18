//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17222 "Standing Order Card Approved"
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
                    Visible = false;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                    AssistEdit = false;
                    Editable = true;
                    Visible = false;
                }
                field("Staff/Payroll No."; Rec."Staff/Payroll No.")
                {
                    ApplicationArea = Basic;
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
                    visible = False;
                    Caption = 'Source Account Activity';
                }
                field("Source Global Dimension 2 Code"; Rec."Source Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    visible = False;
                    Caption = 'Source Account Branch';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                    visible = False;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;
                    visible = False;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                    visible = False;
                }
                field("Destination Account Narrations"; Rec."Destination Account Narrations")
                {
                    ApplicationArea = Basic;
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
                group(BankDetails)
                {
                    Caption = 'BankDetails';
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
                field("BOSA Account No."; Rec."BOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Effective/Start Date"; Rec."Effective/Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic;
                }
                field("Execute Condition"; Rec."Execute Condition")
                {
                    ApplicationArea = Basic;
                }
                field("Don't Allow Partial Deduction"; Rec."Don't Allow Partial Deduction")
                {
                    ApplicationArea = Basic;
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
                    field("Next Attempt Date"; Rec."Next Attempt Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Next Retry Date';
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
                    Importance = Additional;
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
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Is Active"; Rec."Is Active")
                {
                    ApplicationArea = Basic;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Receipt Allocation"; "Receipt Allocation-BOSA")

            {
                SubPageLink = "Document No" = field("No.");
                Editable = false;
            }
        }
        area(factboxes)
        {
            part(Control2; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Source Account No.");
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
                Caption = 'Deactivate STO';
                Promoted = true;
                PromotedCategory = Process;
                //  Visible = false;

                trigger OnAction()
                begin
                    /*                     StatusPermissions.Reset;
                                        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                                        if StatusPermissions.Find('-') = false then
                                            Error('You do not have permissions to stop the standing order.');
                     */
                    if Confirm('Are you sure you want to stop the standing order?', false) = true then begin
                        Rec."Is Active" := false;
                        Rec.Status := Rec.Status::Stopped;
                        Rec.MODIFY;
                    end;
                end;
            }
            group(Approvals)
            {
                Visible = false;
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
                        DocumentType := Documenttype::STO;
                        ApprovalEntries.SetRecordFilters(Database::"HR Commitee Members", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
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
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.TestField("Source Account No.");
                        if Rec."Destination Account Type" <> Rec."destination account type"::"Other Banks Account" then
                            Rec.TestField("Destination Account No.");

                        Rec.TestField("Effective/Start Date");
                        Rec.TestField(Frequency);
                        Rec.TestField("Next Run Date");

                        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
                            Rec.CalcFields("Allocated Amount");
                            if Rec.Amount <> Rec."Allocated Amount" then
                                Error('Allocated amount must be equal to amount');
                        end;

                        if Rec.Status <> Rec.Status::Open then
                            Error(Text001);


                        /*
                       //End allocate batch number
                       IF Approvalmgt.SendFOSASTOApprovalRequest(Rec) THEN;
                         */
                        Rec.Status := Rec.Status::Approved;
                        Rec."Posted By" := UserId;

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
                    begin

                        //IF Approvalmgt.CancelFOSASTOApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
        }
        area(creation)
        {
            action(Create_STO)
            {
                ApplicationArea = Basic;
                Caption = 'Activate STO';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    //   if Rec."Destination Account Type" <> Rec."destination account type"::"Other Banks Account" then
                    //   Rec.TestField("Destination Account No.");
                    Rec.TestField("Effective/Start Date");
                    Rec.TestField(Frequency);
                    Rec.TestField("Next Run Date");

                    if Rec."Is Active" = true then begin
                        Error('The Standing Order is already Activated');
                        exit;
                    end;

                    if Confirm('Are you sure you want to activate this Standing Order?') = false then
                        exit;
                    Rec."Is Active" := true;
                    Rec."Posted By" := UserId;
                    Rec.Modify;
                end;
            }
            action(StopAmend)
            {
                ApplicationArea = Basic;
                Caption = 'Amend Standing Order';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Confirm Standing Order Amend', false) = true then begin
                        Rec.Status := Rec.Status::Open;
                        Rec."Is Active" := false;
                        Rec."Modified By" := UserId;
                        Rec."Modified On" := CurrentDatetime;
                        Rec.Modify;
                        Message('Standing Order Reopened Succesfully');
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
        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
            ReceiptAllVisible := true;
        end;

        BankDetailsVisible := false;
        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
            BankDetailsVisible := true;
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
        if Rec."Destination Account Type" = Rec."destination account type"::"Other Banks Account" then begin
            ReceiptAllVisible := true;
        end;

        BankDetailsVisible := false;
        if Rec."Destination Account Type" = Rec."destination account type"::"Member Account" then begin
            BankDetailsVisible := true;
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",STO;
        ReceiptAllVisible: Boolean;
        ObjAccount: Record Vendor;
        BankDetailsVisible: Boolean;
        ExecuteConditionVisible: Boolean;

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;
}




