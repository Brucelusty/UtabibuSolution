codeunit 131073 "block workflow"
{



    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Management", 'FindWorkflowStepInstance', '', false, false)]
    local procedure PreventDelegationToSender(var WorkflowStepInstance: Record "Workflow Step Instance"; var IsHandled: Boolean)
    var
        InitiatingUserID: Text[50];
        TargetUserID: Text[50];
        CurrentUser: Text[50];
    begin

        if WorkflowStepInstance.IsEmpty() then
            exit;


        InitiatingUserID := WorkflowStepInstance."Created By User ID";


        CurrentUser := USERID;


        if InitiatingUserID = CurrentUser then begin

            Message('Delegation back to the sender is not allowed. User ID: %1', InitiatingUserID);


            IsHandled := true;
        end;
    end;
}