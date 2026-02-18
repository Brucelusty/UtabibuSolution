//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172190 "HR Company Activities Card"
{
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SaveValues = true;
    SourceTable = "HR Company Activities";

    layout
    {
        area(content)
        {
            group(Control1102755007)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Employee Responsible";Rec."Employee Responsible")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Employee Name";Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Name';
                    Editable = false;
                }
                field(Costs; Rec.Costs)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Contribution Amount (If Any)";Rec."Contribution Amount (If Any)")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account No";Rec."G/L Account No")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account Name";Rec."G/L Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bal. Account Type";Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account No";Rec."Bal. Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Email Message";Rec."Email Message")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
            part(Control1102755011; "HR Activity Participants SF")
            {
                SubPageLink = "Document No." = field(Code);
            }
        }
        area(factboxes)
        {
            part(Control1102755024; "HR Company Activities Factbox")
            {
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                action("Get Participants")
                {
                    ApplicationArea = Basic;
                    Image = SalesPurchaseTeam;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField(Closed, false);

                        //DELETE ANY PREVIOS RECORDS RELATED TO THIS ACTIVITY
                        HRActivityApprovalEntry.SetRange(HRActivityApprovalEntry."Document No.", Rec.Code);
                        if HRActivityApprovalEntry.Find('-') then
                            HRActivityApprovalEntry.DeleteAll;

                        //GET ONLY ACTIVE EMPLOYEES
                        HREmp.Reset;
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        HREmp.FindFirst;
                        begin
                            HRActivityApprovalEntry.Reset;
                            repeat
                                HRActivityApprovalEntry.Init;
                                HREmp.TestField(HREmp."User ID");
                                HRActivityApprovalEntry.Participant := HREmp."No.";
                                HRActivityApprovalEntry."Document No." := Rec.Code;
                                HRActivityApprovalEntry.Validate(HRActivityApprovalEntry.Participant);
                                HRActivityApprovalEntry.Insert();
                            until HREmp.Next = 0;
                        end;
                    end;
                }
                action("Notify Participants")
                {
                    ApplicationArea = Basic;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        //TESTFIELD(Closed,FALSE);

                        HRActivityApprovalEntry.Reset;
                        HRActivityApprovalEntry.SetRange(HRActivityApprovalEntry."Document No.", Rec.Code);
                        if HRActivityApprovalEntry.Count = 0 then
                            Error('You must get participants to notify before using this function');

                        Rec.Get(Rec.Code);
                        HRActivityApprovalEntry.Reset;

                        with HRActivityApprovalEntry do begin


                            DocType := Doctype::"Company Activity";


                            SetRange("Table ID", Database::"HR Activity Participants");
                            SetRange("Document Type", DocType);
                            SetRange("Document No.", Rec.Code);
                            SetRange(Status, Status::Created);
                            if FindSet(true, false) then begin

                                repeat

                                    //ApprovalsMgtNotification.SendActivityNotificationMail(Rec,HRActivityApprovalEntry);

                                    HRActivityApprovalEntry.Notified := true;
                                    HRActivityApprovalEntry.Modify;

                                until HRActivityApprovalEntry.Next = 0;
                                Message('%1', Text001)
                            end
                        end
                    end;
                }
                action(Close)
                {
                    ApplicationArea = Basic;
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.Closed := true;
                        Rec.Modify;
                        Message('Event :: %1 :: has been marked as Closed', Rec.Description);
                        CurrPage.Close;
                    end;
                }
                action("Re-Open")
                {
                    ApplicationArea = Basic;
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.Closed := false;
                        Rec.Modify;
                        Message('Event :: %1 :: has been Re-Opened', Rec.Description);
                        CurrPage.Close;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        LineNo := 10000;

                        GenJournal.Reset;
                        GenJournal.SetRange(GenJournal."Journal Template Name", 'GENERAL');
                        GenJournal.SetRange(GenJournal."Journal Batch Name", 'WELFARE');
                        GenJournal.DeleteAll;

                        //REPEAT
                        GenJournal.Init;
                        GenJournal."Journal Template Name" := 'GENERAL';
                        GenJournal."Journal Batch Name" := 'WELFARE';
                        GenJournal."Line No." := LineNo;
                        GenJournal."Account Type" := GenJournal."account type"::"G/L Account";
                        GenJournal."Account No." := Rec."G/L Account No";
                        GenJournal."Posting Date" := WorkDate;
                        GenJournal."Document No." := Rec.Code + '-' + Format(WorkDate);
                        GenJournal."Bal. Account Type" := GenJournal."account type"::"Bank Account";
                        GenJournal."Bal. Account No." := Rec."Bal. Account No";
                        GenJournal.Description := Rec.Description;
                        GenJournal.Amount := Rec.Costs;
                        GenJournal.Validate(GenJournal.Amount);
                        //GenJournal."Shortcut Dimension 1 Code":=TrainingCharges."Department Code";
                        //GenJournal.VALIDATE(GenJournal."Shortcut Dimension 1 Code");
                        GenJournal.Insert;


                        GenJournal.Reset;
                        GenJournal.SetRange(GenJournal."Journal Template Name", 'GENERAL');
                        GenJournal.SetRange(GenJournal."Journal Batch Name", 'WELFARE');
                        if GenJournal.Find('-') then
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJournal);

                        Rec.Posted := true;
                        Rec.Modify;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        HRCompanyActivities.Reset;
                        HRCompanyActivities.SetRange(HRCompanyActivities.Code,Rec. Code);
                        if HRCompanyActivities.Find('-') then
                            Report.Run(53921, true, true, HRCompanyActivities);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnInit()
    begin
        // UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        D: Date;
        // SMTP: Codeunit "SMTP Mail";
        CTEXTURL: Text[500];
        HREmp: Record "HR Employees";
        HRCompanyActivities: Record "HR Committees";
        HRActivityApprovalEntry: Record "HR Activity Participants";
        DocType: Option "Company Activity";
        Text001: label 'All Participants have been notified via E-Mail';
        GenJournal: Record "Gen. Journal Line";
        LineNo: Integer;


    procedure UpdateControls()
    begin
        if Rec.Closed then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;


        end;
    end;
}




