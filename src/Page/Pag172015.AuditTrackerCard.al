//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172015 "Audit Tracker Card"
{
    PageType = Card;
    SourceTable = "Audit Issues Tracker";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Audit";Rec."Date Of Audit")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field(Theme;Rec.Theme)
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field("Theme Description";Rec."Theme Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Issue Description";Rec."Issue Description")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                    MultiLine = true;
                }
                field("Issue Description Additional";Rec."Issue Description Additional")
                {
                    ApplicationArea = Basic;
                    Caption = 'Audit Recommendations';
                    Editable = IsInternalAuditor;
                    MultiLine = true;
                }
                field("Mgt Action Point";Rec."Mgt Action Point")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                    MultiLine = true;
                }
                field("Action Owner";Rec."Action Owner")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field("Action Date";Rec."Action Date")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field("Day Past";Rec."Day Past")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic;
                    OptionCaption = ' ,Open,Due,OverDue,Closed,Failed';
                }
                field("Combined Status";Rec."Combined Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mgt Response";Rec."Mgt Response")
                {
                    ApplicationArea = Basic;
                }
                field("Revised Mgt Comment";Rec."Revised Mgt Comment")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Revised Mgt Comment Additional";Rec."Revised Mgt Comment Additional")
                {
                    ApplicationArea = Basic;
                    Caption = 'Revised Mgt Comment Additional Details';
                    MultiLine = true;
                }
                field("Audit Opinion On Closure";Rec."Audit Opinion On Closure")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field("Audit Comments After Review";Rec."Audit Comments After Review")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                    MultiLine = true;
                }
                field("Mgt Comment After Review";Rec."Mgt Comment After Review")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                    MultiLine = true;
                }
                field("Revised Implementation";Rec."Revised Implementation")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field("Mnt response on failed";Rec."Mnt response on failed")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnRunUpdateStatus;
        SetStyles
    end;

    trigger OnAfterGetRecord()
    begin
         //FnRunUpdateStatus;
         //SetStyles
    end;

    trigger OnOpenPage()
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID",UserId);
        if UserSetup.FindSet then
        begin
          IsInternalAuditor:=UserSetup."Is Internal Auditor";
        end;
    end;

    var
        ObjAuditSetup: Record "Audit General Setup";
        CoveragePercentStyle: Text;
        UserSetup: Record "User Setup";
        IsInternalAuditor: Boolean;

    local procedure FnRunUpdateStatus()
    begin
        if Rec."Action Date" <> 0D then
        begin
          Rec."Day Past":=WorkDate-Rec."Action Date";

          Rec.Status:=Rec.Status::" ";
          ObjAuditSetup.Get;
          if Rec."Audit Opinion On Closure"=Rec."audit opinion on closure"::Closed then
          begin
            Rec.Status:=Rec.Status::Closed
          end else
          if Rec."Audit Opinion On Closure"=Rec."audit opinion on closure"::Failed then
          begin
            Rec.Status:=Rec.Status::Failed
          end else
          if (Rec."Audit Opinion On Closure"=Rec."audit opinion on closure"::"Issue Assurance Not Yet Done") and
           (Rec."Day Past">ObjAuditSetup."Over Due Date") then
          begin
            Rec.Status:=Rec.Status::OverDue
          end else
          if (Rec."Audit Opinion On Closure"=Rec."audit opinion on closure"::"Issue Assurance Not Yet Done") and
           (Rec."Day Past">ObjAuditSetup."Due Date") then
          begin
            Rec.Status:=Rec.Status::Due
          end;
        end;

        Rec."Combined Status":=Format(Rec.Status)+' '+Format(Rec."Mgt Response");
       Rec. Modify;
    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle:='Strong';
        if (Rec.Status =Rec.Status::Due) or (Rec.Status =Rec.Status::Closed)  then
           CoveragePercentStyle := 'Unfavorable';
        if (Rec.Status =Rec.Status::Open) or (Rec.Status =Rec.Status::OverDue)  then
            CoveragePercentStyle := 'Favorable';
    end;
}




