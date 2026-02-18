codeunit 131004 "Pagemanagent"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        CASE RecordRef.NUMBER OF
            DATABASE::"Loans Register":
                PageID := (Page::"Loan Application BOSA(New)");
            Database::"HR Leave Application":
                PageID := (Page::"HR Leave Application Card");
            Database::"Membership Applications":
                PageID := (Page::"Membership Application Card");
            Database::
                "Change Request":
                PageID := (Page::"Change Request Card");
            Database::
                "Treasury Transactions":
                PageID := (Page::"Teller & Treasury Trans Card");
            Database::
                "Boad Payments Allowance":
                PageID := (Page::"Board Payments Header");
            Database::
                "Loan Recovery Header":
                PageID := (Page::"Loan Recovery Header");
        end;
    end;

    procedure GetPurchaseHeaderPageID(RecRef: RecordRef): Integer
    var
        PurchaseHeader: Record "Loans Register";
        LeaveApplication: Record "HR Leave Application";
    begin
        RecRef.SetTable(PurchaseHeader);
        EXIT(PAGE::"Loan Application BOSA(New)");




    end;



}