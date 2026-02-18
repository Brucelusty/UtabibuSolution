//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17290 "HR Training Application Card"
{
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Show,Training Participants,Approval';
    SourceTable = "HR Training Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                    Editable = "Employee No.Editable";
                }
                field("Training Group No."; Rec."Training Group No.")
                {
                    ApplicationArea = Basic;
                }
                field("Training group Name"; Rec."Training group Name") { ApplicationArea = all; }
                field("No. of Participant"; Rec."No. of Participant")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee Department"; Rec."Employee Department")
                {
                    ApplicationArea = Basic;
                    Editable = "Employee DepartmentEditable";
                }
                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = Basic;
                    Editable = "Course TitleEditable";
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Purpose of Training"; Rec."Purpose of Training")
                {
                    ApplicationArea = Basic;
                    MultiLine = false;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = Basic;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    ApplicationArea = Basic;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    ApplicationArea = Basic;
                    Caption = 'Estimated Cost';
                }
                field("Approved Cost"; Rec."Approved Cost")
                {
                    ApplicationArea = Basic;
                }
                field(Provider; Rec.Provider)
                {
                    ApplicationArea = Basic;
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = "Responsibility CenterEditable";
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Trainings Factbox")
            {
                SubPageLink = "Application No" = field("Application No");
            }
        }
    }

    actions
    {
        area(navigation)
        {


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
                    PromotedCategory = Category7;

                    trigger OnAction()
                    begin
                
                        if WorkflowIntergartion.CheckHRTrainingApprovalsWorkflowEnabled(Rec) then
                            WorkflowIntergartion.OnSendHRTrainingApplicationForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                        Message('Cancelled Successully');
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        DocumentType: Enum "Approval Document Type";
                        //DocumentType: 
                    begin
                        DocumentType := Documenttype::TrainingNeeds;
                        ApprovalEntries.SetRecordFilters(Database::"HR Training Applications", DocumentType, Rec."Application No");
                        ApprovalEntries.Run();
                    end;
                }
                action("&Print")
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        HRTrainingApplications.SetRange(HRTrainingApplications."Application No", Rec."Application No");
                        if HRTrainingApplications.Find('-') then
                            Report.run(172603, true, true, HRTrainingApplications);
                    end;
                }
                action("Training Participants")
                {
                    Image = SocialSecurity;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = page "Training Participants";
                    RunPageLink = Code = field("Application No");

                    ApplicationArea = All;
                    ToolTip = 'Executes the Training Participants action';
                }
                action("<A ction1102755042>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Responsibility CenterEditable" := true;
            "Application NoEditable" := true;
            "Employee No.Editable" := true;
            "Employee NameEditable" := true;
            "Employee DepartmentEditable" := true;
            "Purpose of TrainingEditable" := true;
            "Course TitleEditable" := true;
        end else begin
            "Responsibility CenterEditable" := false;
            "Application NoEditable" := false;
            "Employee No.Editable" := false;
            "Employee NameEditable" := false;
            "Employee DepartmentEditable" := false;
            "Purpose of TrainingEditable" := false;
            "Course TitleEditable" := false;
        end;
    end;

    trigger OnInit()
    begin
        "Course TitleEditable" := true;
        "Purpose of TrainingEditable" := true;
        "Employee DepartmentEditable" := true;
        "Employee NameEditable" := true;
        "Employee No.Editable" := true;
        "Application NoEditable" := true;
        "Responsibility CenterEditable" := true;
    end;

    var
        HREmp: Record "HR Employees";
        EmpNames: Text[40];
        sDate: Date;
        HRTrainingApplications: Record "HR Training Applications";
        ApprovalComments: Page "Approval Comments";
        
        "Responsibility CenterEditable": Boolean;
        
        "Application NoEditable": Boolean;
        
        "Employee No.Editable": Boolean;
        
        "Employee NameEditable": Boolean;
        
        "Employee DepartmentEditable": Boolean;
        
        "Purpose of TrainingEditable": Boolean;
        
        "Course TitleEditable": Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;

        ShowWorkflowStatus: Boolean;

        WorkflowIntergartion: Codeunit WorkflowIntegration;


    procedure TESTFIELDS()
    begin
        Rec.TestField("Course Title");
        Rec.TestField("From Date");
        Rec.TestField("To Date");
        Rec.TestField("Duration Units");
        Rec.TestField(Duration);
        Rec.TestField("Cost Of Training");
        Rec.TestField(Location);
        Rec.TestField(Provider);
        Rec.TestField("Purpose of Training");
    end;
}




