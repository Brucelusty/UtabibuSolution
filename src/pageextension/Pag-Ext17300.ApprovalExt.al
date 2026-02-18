pageextension 17300 ApprovalExt extends "Requests to Approve"
{
    layout
    {
        addbefore(Comment)
        {


        }
        //modify()

    }
    actions
    {
        // Add changes to page actions here
        modify(Delegate)
        {
            Visible = false;
        }
        addafter(Reject)
        {
            action(DelegateII)
            {
                ApplicationArea = Suite;
                Caption = 'Delegate';
                Image = Delegate;
                Scope = Repeater;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Delegate the approval to a substitute approver.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Reset();
                    UserSetup.SetRange("User ID", UserId);
                    if UserSetup.Find('-') then begin
                        if UserSetup."Approval Administrator" then begin
                            CurrPage.SetSelectionFilter(ApprovalEntry);
                            ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                        end else begin
                            Error('you dont have rights for this action');
                        end;
                    end;

                end;
            }
        }
    }

}
pageextension 20379 ApprovalRequestExt extends "Approval Entries"
{
    layout
    {

    }
    actions
    {
        // Add changes to page actions here
        modify("&Delegate")
        {
            Visible = true;
        }
        addafter("&Delegate")
        {
            action(DelegateII)
            {
                ApplicationArea = Suite;
                Caption = 'Delegate';
                Image = Delegate;
                Scope = Repeater;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Delegate the approval to a substitute approver.';
                visible = false;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Reset();
                    UserSetup.SetRange("User ID", UserId);
                    if UserSetup.Find('-') then begin
                        if UserSetup."Approval Administrator" then begin
                            CurrPage.SetSelectionFilter(ApprovalEntry);
                            ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                        end else begin
                            Error('you dont have rights for this action');
                        end;
                    end;

                end;
            }
        }
    }


}



