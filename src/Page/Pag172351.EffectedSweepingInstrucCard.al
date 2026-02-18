//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172351 "Effected Sweeping Instruc Card"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Member Sweeping Instructions";
    SourceTableView = where(Effected = filter(true));

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
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Monitor Account";Rec."Monitor Account")
                {
                    ApplicationArea = Basic;
                }
                field("Monitor Account Type";Rec."Monitor Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Monitor Account Type Desc";Rec."Monitor Account Type Desc")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monitor Account Type Description';
                }
                field("Check Minimum Threshold";Rec."Check Minimum Threshold")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sweep From Investment Min Threshold';
                    ToolTip = 'Sweep From Investment Account Amount Below Minimum Threshold';
                }
                field("Check Maximum Threshold";Rec."Check Maximum Threshold")
                {
                    ApplicationArea = Basic;
                    Caption = 'Swep From Monitor Account Above Max Threshold';
                }
                group("Minimum Threshold")
                {
                    field("Minimum Account Threshold";Rec."Minimum Account Threshold")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Maximum Threshold")
                {
                    field("Maximum Account Threshold";Rec."Maximum Account Threshold")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Investment Account";Rec."Investment Account")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Account Type";Rec."Investment Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Account Type Desc";Rec."Investment Account Type Desc")
                {
                    ApplicationArea = Basic;
                    Caption = 'Investment Account Type Description';
                }
                field("Schedule Frequency";Rec."Schedule Frequency")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        WeeklyVisible := false;
                        MonthlyVisible := false;
                        if Rec."Schedule Frequency" = Rec."schedule frequency"::Weekly then begin
                            WeeklyVisible := true;
                        end;
                        if Rec."Schedule Frequency" = Rec."schedule frequency"::Monthly then begin
                            MonthlyVisible := true;
                        end;
                    end;
                }
                group("Weekly ")
                {
                    Visible = WeeklyVisible;
                    field("Day Of Week";Rec."Day Of Week")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Day Of Week';
                    }
                }
                group(Monthly)
                {
                    Visible = MonthlyVisible;
                    field("Day Of Month";Rec."Day Of Month")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Days Of Month e.g. 05,12,20';
                    }
                }
                field("Created On";Rec."Created On")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Effected; Rec.Effected)
                {
                    ApplicationArea = Basic;
                }
                field("Effected on";Rec."Effected on")
                {
                    ApplicationArea = Basic;
                }
                field("Last Execution";Rec."Last Execution")
                {
                    ApplicationArea = Basic;
                }
                field(Stopped; Rec.Stopped)
                {
                    ApplicationArea = Basic;
                }
                field("Stopped By";Rec."Stopped By")
                {
                    ApplicationArea = Basic;
                }
                field("Stopped On";Rec."Stopped On")
                {
                    ApplicationArea = Basic;
                }
                label(Control32)
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
            action("Stop Instruction")
            {
                ApplicationArea = Basic;
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Stopped;
                    Rec.Stopped := true;
                    Rec."Stopped By" := UserId;
                    Rec."Stopped On" := Today();
                    Rec.Modify;
                    Message('Standing instruction stopped successfully');
                end;
            }
        }
    }

    var
        WeeklyVisible: Boolean;
        MonthlyVisible: Boolean;
}




