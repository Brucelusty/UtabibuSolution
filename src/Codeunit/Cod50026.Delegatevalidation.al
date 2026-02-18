codeunit 50026 "Delegate validation"
{

    // [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnBeforeInsertEvent', true, true)]
    local procedure ValidateDelegationOnInsert(Rec: Record "Approval Entry"; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
        ErrorMessage: Text;
    begin
        // Check if the request is a delegation attempt
        if Rec."Sender ID" <> '' then begin
            // Verify if the delegator exists in User Setup
            if not UserSetup.Get(Rec."Sender ID") then
                ErrorMessage := 'Delegator is not configured in User Setup. Please contact an administrator.';
            // Verify if the delegator has permission
            if not UserSetup."Can Delegate Requests" then
                ErrorMessage := 'You do not have permission to delegate requests. Please contact an administrator.';

            // If any validation fails, show an error and prevent the action
            if ErrorMessage <> '' then begin
                IsHandled := true; // Prevent the insertion of the delegation entry
                Error(ErrorMessage);
            end;
        end;
    end;
}


