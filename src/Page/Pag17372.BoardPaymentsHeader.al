page 17372 "Board Payments Header"
{
    ApplicationArea = All;
    Caption = 'Board Payments Header';
    PageType = Card;
    SourceTable = "Boad Payments Allowance";
    PromotedActionCategories = 'New,Process,Report,Send & Cancel Approval,Update Changes';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                    Editable = EditableApproval;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    Editable = EditableApproval;
                }
                field("Paying Bank"; Rec."Paying Bank")
                {
                    ToolTip = 'Specifies the value of the Paying Bank field.';
                    Editable = EditableApproval;
                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {
                    ToolTip = 'Specifies the value of the Paying Bank Name field.';
                    Editable = EditableApproval;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = EditableApproval;
                }
                field(Status; Rec.Status)
                {
                    Editable = EditableApproval;
                }
                field(Posted; Rec.Posted)
                {

                }
                field("Total Amount Payable"; Rec."Total Amount Payable")
                {
                    Editable = EditableApproval;
                }


            }
            part(Lines; "Board payments Lines")
            {
                Editable = EditableApproval;
                SubPageLink = "Document No" = field(No);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Posting)
            {
                action(post)
                {
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        if (rec.Status <> rec.Status::Approved) then begin
                            Error('board payment Must be Approved First');
                        end;

                        GenBatches.Reset();
                        GenBatches.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenBatches.SetRange(Name, BATCH_NAME);
                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init();
                            GenBatches.Name := BATCH_NAME;
                            GenBatches."Journal Template Name" := BATCH_TEMPLATE;
                            GenBatches.Insert(true);
                        end;

                        GenJournalLine.Reset();
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.Find('-') then begin
                            GenJournalLine.DeleteAll();
                        end;

                        Rec.TestField(Posted, false);
                        if Confirm('Are you sure you want to post this payment?') = false then exit;

                        BoardPaymentLines.Reset();
                        BoardPaymentLines.SetRange("Document No", Rec.No);
                        BoardPaymentLines.SetRange("Board No");
                        if BoardPaymentLines.Find('-') then begin
                            repeat

                                //bank payments
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, Rec.No, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"Bank Account", Rec."Paying Bank", Rec."Posting Date", BoardPaymentLines."Net  Amount" * -1, 'BOSA',
                                Rec.No, BoardPaymentLines."Payment Descrition", ' ', GenJournalLine."Application Source"::" ");

                                if BoardPaymentLines."Transaction Type" <> BoardPaymentLines."Transaction Type"::" " then begin
                                    LineNo := LineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, Rec.No, LineNo, BoardPaymentLines."Transaction Type",
                                    GenJournalLine."Account Type"::Customer, BoardPaymentLines."Board No", Rec."Posting Date", BoardPaymentLines."Member Amount" * -1, 'BOSA',
                                    Rec.No, BoardPaymentLines."Payment Descrition", BoardPaymentLines."Loan No", GenJournalLine."Application Source"::" ");
                                end;

                                //end bank payments
                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, Rec.No, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", BoardPaymentLines."G/L Account", Rec."Posting Date", BoardPaymentLines."Amount Paid" * 1, 'BOSA',
                                Rec.No, BoardPaymentLines."Payment Descrition", '', GenJournalLine."Application Source"::" ");

                                LineNo := LineNo + 10000;
                                AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, Rec.No, LineNo, GenJournalLine."Transaction Type"::" ",
                                GenJournalLine."Account Type"::"G/L Account", '704032', Rec."Posting Date", BoardPaymentLines."Housing Leavy" * -1, 'BOSA',
                                Rec.No, BoardPaymentLines."Payment Descrition", '', GenJournalLine."Application Source"::" ");

                                If BoardPaymentLines."Staff\Board" = BoardPaymentLines."Staff\Board"::Staff Then begin
                                    LineNo := LineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, Rec.No, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::"G/L Account", '703040', Rec."Posting Date", BoardPaymentLines."Paye Amount" * -1, 'BOSA',
                                    Rec.No, 'Paye On Staff Allowance', ' ', GenJournalLine."Application Source"::" ");
                                end;

                                If BoardPaymentLines."Staff\Board" = BoardPaymentLines."Staff\Board"::"Board Member" Then begin
                                    LineNo := LineNo + 10000;
                                    AUFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, Rec.No, LineNo, GenJournalLine."Transaction Type"::" ",
                                    GenJournalLine."Account Type"::"G/L Account", '704030', Rec."Posting Date", BoardPaymentLines."Paye Amount" * -1, 'BOSA',
                                    Rec.No, 'Paye On Director Allowance', ' ', GenJournalLine."Application Source"::" ");
                                end;

                            until BoardPaymentLines.Next() = 0;
                        end;

                        GenJournalLine.Reset();
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        end;
                        Rec.Posted := true;
                        Rec.Modify(true);
                    end;
                }
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
                    //TESTFIELD(Posted,TRUE);
                    PHeader2.RESET;
                    PHeader2.SETRANGE(PHeader2."No", rec."No");
                    IF PHeader2.FINDFIRST THEN
                        Report.run(50083, TRUE, TRUE, PHeader2);
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    Workflowintegration: Codeunit WorkflowIntegration;
                begin

                    if rec.Status <> rec.Status::Open then
                        Error(text001);

                    if Workflowintegration.CheckboardpaymentApprovalsWorkflowEnabled(Rec) then
                        Workflowintegration.OnSendboardpaymentForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel A&pproval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                //ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    rec.Status := rec.Status::Open;// THEN
                                                   //ERROR(text001);
                end;
            }
            action(Approvals)
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
                    //     DocumentType := Documenttype::bo;
                    //     ApprovalEntries.SetRecordFilters(Database::"Boad Payments Allowance", DocumentType, Rec.No);
                    //     ApprovalEntries.Run;
                end;
            }
        }

    }



    trigger OnOpenPage()
    begin
        EditableApproval := false;
        if Rec.Posted = true then begin
            EditableApproval := false
        end else begin
            EditableApproval := true;
        end;
    end;

    var
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        AUFactory: Codeunit "Au Factory";
        BATCH_TEMPLATE: Label 'General';
        BATCH_NAME: Label 'Board';

        BoardPaymentLines: Record "Boarb Payments Lines";

        GenBatches: Record "Gen. Journal Batch";

        GLPosting: Codeunit 12;

        EditableApproval: Boolean;

        PHeader2: Record "Boad Payments Allowance";
}
