codeunit 131011 AprovalManagement
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        LastDocumentNo: Code[20];
        ApprovalEnrt: Record "Approval Entry";
    begin

        ApprovalEntry.Reset();
        if ApprovalEntry.FindLast then begin
            LastDocumentNo := ApprovalEntry."Document No.";
            ApprovalEnrt.Reset();
            ApprovalEnrt.SetRange("Document No.", LastDocumentNo);
            if ApprovalEnrt.FindFirst() then begin
                ApprovalEnrt.CalcFields(Comment);
                if ApprovalEnrt.Comment = false then
                    Error('Comments must have a value in document No %1 - Comment value %2', ApprovalEntry."Document No.", ApprovalEntry.Comment);
            end;
        end;
    end;
}
