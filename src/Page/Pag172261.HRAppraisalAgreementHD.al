//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172261 "HR Appraisal Agreement HD"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "HR Appraisal Header";
    SourceTableView = where(Status = filter(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Appraisal No";Rec."Appraisal No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee No";Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name";Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Employment";Rec."Date of Employment")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Job Title";Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Type";Rec."Contract Type")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period";Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("User ID";Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Comments Appraisee";Rec."Comments Appraisee")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Date";Rec."Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Period Start";Rec."Evaluation Period Start")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Period End";Rec."Evaluation Period End")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility/Duties Agrd Sco";Rec."Responsibility/Duties Agrd Sco")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Attendance&Punctuality Agr Sco";Rec."Attendance&Punctuality Agr Sco")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Communication Agreed Score";Rec."Communication Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cooperation Agreed Score";Rec."Cooperation Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Service Agreed Score";Rec."Customer Service Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Initiative Agreed Score";Rec."Initiative Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Quality Agreed Score";Rec."Quality Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Teamwork Agreed Score";Rec."Teamwork Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sales Skills Agreed Score";Rec."Sales Skills Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Leadership Agreed Score";Rec."Leadership Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Performance Coaching Agreed Sc";Rec."Performance Coaching Agreed Sc")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility/Duties Comment";Rec."Responsibility/Duties Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Attendance&Punctuality Comment";Rec."Attendance&Punctuality Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Communication Agreed Comment";Rec."Communication Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Cooperation Agreed Comment";Rec."Cooperation Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Service Agr Comment";Rec."Customer Service Agr Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Initiative Agreed Comment";Rec."Initiative Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Quality Agreed Comment";Rec."Quality Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Teamwork Agreed Comment";Rec."Teamwork Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Skills Agreed Comment";Rec."Sales Skills Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Leadership Agreed Comment";Rec."Leadership Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Coaching Comment";Rec."Performance Coaching Comment")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control9; "HR Appraisal Lines-Agreed")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No"),
                              "Appraisal Period" = field("Appraisal Period"),
                              "Employee No" = field("Employee No");
                SubPageView = sorting(Sections)
                              order(ascending);
            }
        }
        area(factboxes)
        {
            systempart(Control43; Outlook)
            {
            }
            systempart(Control44; Notes)
            {
            }
            systempart(Control45; MyNotes)
            {
            }
            systempart(Control46; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Agreed)
            {
                ApplicationArea = Basic;
                Image = BinJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //
                end;
            }
        }
    }

    var
        objJobResp: Record "HR Job Responsiblities";
        objAppraisalLines: Record "HR Appraisal Lines";
        objPrevAppraisalLines: Record "HR Appraisal Lines";
        iNo: Integer;
        objPrevApprPeriod: Record "HR Lookup Values";
        objCurrApprPeriod: Record "HR Lookup Values";
        HREmployees: Record "HR Employees";
        objAppraisalEvaluationAreas: Record "HR Appraisal Eval Areas";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;


    procedure enableDisable() enableDisable: Boolean
    begin
        enableDisable := false;
    end;
}




