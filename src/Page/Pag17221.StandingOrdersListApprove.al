//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17221 "Standing Orders - List Approve"
{
    CardPageID = "Standing Order Card Approved";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Standing Orders";
    SourceTableView = where(Status = filter(Approved));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Type";Rec."Source Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No.";Rec."BOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                }
                field("Source Account No.";Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Narrations";Rec."Source Account Narrations")
                {
                    ApplicationArea = Basic;
                    Caption = 'Source Narration';
                }
                field("Next Run Date";Rec."Next Run Date")
                {
                    ApplicationArea = Basic;
                }
                field("Next Attempt Date";Rec."Next Attempt Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next Retry Date';
                }
                field("Effective/Start Date";Rec."Effective/Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Allocated Amount";Rec."Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Type";Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No.";Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name";Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Narrations";Rec."Destination Account Narrations")
                {
                    ApplicationArea = Basic;
                    Caption = 'Destination Narration';
                }
                field("Is Active";Rec."Is Active")
                {
                    ApplicationArea = Basic;
                }
                field("Created On";Rec."Created On")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";Rec."Created By")
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
                Image = DeactivateDiscounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to stop the standing order.');

                    if Confirm('Are you sure you want to stop the standing order?', false) = true then begin
                    end;
                end;
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



                        //End allocate batch number
                        //IF Approvalmgt.SendFOSASTOApprovalRequest(Rec) THEN;
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

                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing order status.');
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
                        Rec.Modify;
                        Message('Standing Order Reopened Succesfully');
                    end;
                end;
            }
        }
    }

    var
        StatusPermissions: Record "Status Change Permision";
        BankName: Text[200];
        Banks: Record Banks;
        UsersID: Record User;
        RAllocations: Record "Receipt Allocation";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",STO;
}




