codeunit 131074 "Posting Date Control"
{
   

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure CheckGenJournalPosting(var GenJournalLine: Record "Gen. Journal Line")
    begin
        ValidatePostingDate(GenJournalLine."Posting Date");
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure CheckSalesPosting(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    begin
        ValidatePostingDate(SalesHeader."Posting Date");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure CheckPurchasePosting(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    begin
        ValidatePostingDate(PurchaseHeader."Posting Date");
    end;

    local procedure ValidatePostingDate(PostingDate: Date)
    var
        UserSetup: Record "User Setup";
        TodayDate: Date;
    begin
        TodayDate := WorkDate(); 

       
        if PostingDate > TodayDate then
            Error('You cannot post into the future. Today is %1, your posting date is %2.',
                   TodayDate, PostingDate);

        if PostingDate < TodayDate then begin
            if not (UserSetup.Get(UserId) and UserSetup."Allow Backdating") then
                Error('Backdating is not allowed for your user. Today is %1, your posting date is %2.',
                      TodayDate, PostingDate);
        end;
    end;

}
