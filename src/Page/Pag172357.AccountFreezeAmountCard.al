//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172357 "Account Freeze Amount Card"
{
    PageType = Card;
    SourceTable = "Member Account Freeze Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFreeze;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFreeze;
                }
                field("Current Book Balance"; Rec."Current Book Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Uncleared Cheques"; Rec."Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                }
                field("Overdraft Limit"; Rec."Overdraft Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Current Frozen Amount"; Rec."Current Frozen Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Current Available Balance"; Rec."Current Available Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Freeze"; Rec."Amount to Freeze")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFreeze;
                }
                field("Reason For Freezing"; Rec."Reason For Freezing")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFreeze;
                }
                field("Loan Freeze"; Rec."Loan Freeze")
                {
                    ApplicationArea = Basic;
                }
                field("Captured On"; Rec."Captured On")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field(Frozen; Rec.Frozen)
                {
                    ApplicationArea = Basic;
                }
                field("Frozen On"; Rec."Frozen On")
                {
                    ApplicationArea = Basic;
                }
                field("Frozen By"; Rec."Frozen By")
                {
                    ApplicationArea = Basic;
                }
                field(Unfrozen; Rec.Unfrozen)
                {
                    ApplicationArea = Basic;
                }
                field("Unfrozen On"; Rec."Unfrozen On")
                {
                    ApplicationArea = Basic;
                }
                field("Unfrozen By"; Rec."Unfrozen By")
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
            action("Freeze Amount")
            {
                ApplicationArea = Basic;
                Enabled = EnableFreeze;
                Image = Lock;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Reason For Freezing");
                    if Rec.Frozen = true then
                        Error('The amount is already frozen');

                    if Confirm('Confirm Freeze Action?', false) = true then begin

                        if ObjAccount.Get(Rec."Account No") then begin
                            ObjAccount."Frozen Amount" := ObjAccount."Frozen Amount" + Rec."Amount to Freeze";
                            Rec.Frozen := true;
                            Rec."Frozen On" := WorkDate;
                            Rec."Frozen By" := UserId;
                            ObjAccount.Modify;
                        end;
                    end;
                end;
            }
            action("UnFreeze Amount")
            {
                ApplicationArea = Basic;
                Enabled = EnableUnFreeze;
                Image = UnLinkAccount;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Unfrozen = true then
                        Error('The amount is already unfrozen');

                    if Confirm('Confirm Freeze Action?', false) = true then begin
                        if ObjAccount.Get(Rec."Account No") then begin
                            ObjAccount."Frozen Amount" := ObjAccount."Frozen Amount" - Rec."Amount to Freeze";
                            Rec.Unfrozen := true;
                            Rec."Unfrozen On" := WorkDate;
                            Rec."Unfrozen By" := UserId;
                            ObjAccount.Modify;
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnEnableActions;
    end;

    trigger OnAfterGetRecord()
    begin
        FnEnableActions;
    end;

    trigger OnOpenPage()
    begin
        FnEnableActions;
    end;

    var
        ObjAccount: Record Vendor;
        EnableFreeze: Boolean;
        EnableUnFreeze: Boolean;

    local procedure FnEnableActions()
    begin
        EnableFreeze := false;
        EnableUnFreeze := false;

        if Rec.Frozen = true then
            EnableUnFreeze := true;

        if Rec.Frozen = false then
            EnableFreeze := true;

        if Rec.Unfrozen = true then
            EnableUnFreeze := false;
    end;
}




