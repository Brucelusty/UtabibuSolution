//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80037 "HR Leave Journal Lines"
{
    AutoSplitKey = false;
    DelayedInsert = true;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Functions,Approvals';
    RefreshOnActivate = true;
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HR Journal Line";

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = Basic;
                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord;

                    //Rec.RESET;

                    InsuranceJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.Update(false);
                end;

                trigger OnValidate()
                begin
                    InsuranceJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Control1102755000)
            {
                field("Line No.";Rec."Line No.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Period";Rec."Leave Period")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No.";Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Name";Rec."Staff Name")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Type";Rec."Leave Type")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Entry Type";Rec."Leave Entry Type")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Days";Rec."No. of Days")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Document No.";Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Post Adjustment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Adjustment';
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", Rec);

                        CurrentJnlBatchName := rec.GetRangemax("Journal Batch Name");
                        CurrPage.Update(false);
                    end;
                }
                action("Batch Allocation")
                {
                    ApplicationArea = Basic;
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    //     RunObject = Report UnknownReport53932;
                    Visible = false;

                    trigger OnAction()
                    begin



                       

                    end;
                }
                action("Import Leave Days")
                {
                    ApplicationArea = Basic;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to Upload Leave Balances ?', true) = false then exit;
                        Xmlport.Run(51516504, true, true);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                        //ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
        InsuranceJnlManagement: Codeunit LeaveJnlManagementold;
    begin
        OpenedFromBatch := (Rec."Journal Batch Name" <> '') and (Rec."Journal Template Name" = '');
        if OpenedFromBatch then begin
            CurrentJnlBatchName := Rec."Journal Batch Name";
            InsuranceJnlManagement.OpenJournal(CurrentJnlBatchName, Rec);
            exit;
        end;
        InsuranceJnlManagement.TemplateSelection(Page::"HR Leave Journal Lines", Rec, JnlSelected);
        if not JnlSelected then
            Error('');
        InsuranceJnlManagement.OpenJournal(CurrentJnlBatchName, Rec);
    end;

    var
        HRLeaveTypes: Record "HR Leave Types";
        HREmp: Record "HR Employees";
        HRLeaveLedger: Record "HR Leave Ledger Entries";
        InsuranceJnlManagement: Codeunit LeaveJnlManagementold;
        ReportPrint: Codeunit "Test Report-Print";
        CurrentJnlBatchName: Code[10];
        InsuranceDescription: Text[30];
        FADescription: Text[30];
        ShortcutDimCode: array[8] of Code[20];
        OpenedFromBatch: Boolean;
        HRLeavePeriods: Record "HR Leave Periods";
        AllocationDone: Boolean;
        HRJournalBatch: Record "HR Leave Journal Batch";
        OK: Boolean;
        ApprovalEntries: Record "Approval Entry";
        LLE: Record "HR Leave Ledger Entries";
       // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;


    procedure CheckGender(Emp: Record "HR Employees"; LeaveType: Record "HR Leave Types") Allocate: Boolean
    begin

        //CHECK IF LEAVE TYPE ALLOCATION APPLIES TO EMPLOYEE'S GENDER

        if Emp.Gender = Emp.Gender::Male then begin
            if LeaveType.Gender = LeaveType.Gender::Male then
                Allocate := true;
        end;

        if Emp.Gender = Emp.Gender::Female then begin
            if LeaveType.Gender = LeaveType.Gender::Female then
                Allocate := true;
        end;

        if LeaveType.Gender = LeaveType.Gender::Other then
            Allocate := true;
        exit(Allocate);

        if Emp.Gender <> LeaveType.Gender then
            Allocate := false;

        exit(Allocate);
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SaveRecord;
        InsuranceJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.Update(false);
    end;


    procedure AllocateLeave1()
    begin
    end;


    procedure AllocateLeave2()
    begin
    end;
}




