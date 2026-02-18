//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172157 "Scheduled Statements Card"
{
    PageType = Card;
    SourceTable = "Scheduled Statements";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Statement Type"; Rec."Statement Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        EnableField := false;
                        if Rec."Statement Type" = Rec."statement type"::"Account Statement" then
                            EnableField := true;
                    end;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Enabled = EnableField;
                }
                field("Account Email"; Rec."Account Email")
                {
                    ApplicationArea = Basic;
                    Enabled = EnableField;
                }
                field("Statement Period"; Rec."Statement Period")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statement Period (e.g. -5D, -3W, -1M)';
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic;
                    OptionCaption = 'Daily,Weekly,Monthly';

                    trigger OnValidate()
                    begin
                        EnableWeeklyFreq := false;
                        EnableDayOfMonth := false;
                        if Rec.Frequency = Rec.Frequency::Weekly then
                            EnableWeeklyFreq := true;
                        if Rec.Frequency = Rec.Frequency::Mothly then
                            EnableDayOfMonth := true;
                    end;
                }
                field("Output Format"; Rec."Output Format")
                {
                    ApplicationArea = Basic;
                    OptionCaption = 'PDF,EXCEL';
                }
                group(Control23)
                {
                    Visible = EnableWeeklyFreq;
                    field("Days of Week"; Rec."Days of Week")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Days of Week (Mo,Tu,We..)';
                    }
                }
                group(Control24)
                {
                    Visible = EnableDayOfMonth;
                    field("Days Of Month"; Rec."Days Of Month")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Days Of Month (01,05,30)';
                        Visible = EnableDayOfMonth;
                    }
                }
                field("Schedule Status"; Rec."Schedule Status")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = Basic;
                }
                field("Activated By"; Rec."Activated By")
                {
                    ApplicationArea = Basic;
                }
                field("Activated On"; Rec."Activated On")
                {
                    ApplicationArea = Basic;
                }
                field("Stopped By"; Rec."Stopped By")
                {
                    ApplicationArea = Basic;
                }
                field("Stopped On"; Rec."Stopped On")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ActiveSheduledStatement)
            {
                ApplicationArea = Basic;
                Caption = 'Activate Sheduled Statement';
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Confirm Scheduled Statement Enable', false) = true then begin
                        Rec."Schedule Status" := Rec."schedule status"::Active;
                        Rec."Activated By" := UserId;
                        Rec."Activated On" := WorkDate;
                    end;
                end;
            }
            action(StopScheduledStatement)
            {
                ApplicationArea = Basic;
                Caption = 'Stop Scheduled Statement';
                Image = UnApply;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Confirm Scheduled Statement Disable', false) = true then begin
                        Rec."Schedule Status" := Rec."schedule status"::Stopped;
                        Rec."Stopped By" := UserId;
                        Rec."Stopped On" := WorkDate;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EnableField := false;
        if Rec."Statement Type" = Rec."statement type"::"Account Statement" then
            EnableField := true;

        EnableWeeklyFreq := false;
        EnableDayOfMonth := false;
        if Rec.Frequency = Rec.Frequency::Weekly then
            EnableWeeklyFreq := true;
        if Rec.Frequency = Rec.Frequency::Mothly then
            EnableDayOfMonth := true;
    end;

    trigger OnAfterGetRecord()
    begin
        EnableField := false;
        if Rec."Statement Type" = Rec."statement type"::"Account Statement" then
            EnableField := true;

        EnableWeeklyFreq := false;
        EnableDayOfMonth := false;
        if Rec.Frequency = Rec.Frequency::Weekly then
            EnableWeeklyFreq := true;
        if Rec.Frequency = Rec.Frequency::Mothly then
            EnableDayOfMonth := true;
    end;

    trigger OnOpenPage()
    begin
        EnableField := false;
        if Rec."Statement Type" = Rec."statement type"::"Account Statement" then
            EnableField := true;

        EnableWeeklyFreq := false;
        EnableDayOfMonth := false;
        if Rec.Frequency = Rec.Frequency::Weekly then
            EnableWeeklyFreq := true;
        if Rec.Frequency = Rec.Frequency::Mothly then
            EnableDayOfMonth := true;
    end;

    var
        EnableField: Boolean;
        EnableWeeklyFreq: Boolean;
        EnableDayOfMonth: Boolean;
}




