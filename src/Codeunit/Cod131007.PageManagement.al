codeunit 131007 PageManagement
{

    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        case RecordRef.Number of
            //Payments
            Database::"Membership Applications":
                PageID := GetMemberPageID(RecordRef);
            Database::"HR Jobss":
                PageID := Page::"HR Jobs Card";
            Database::"Standing Orders":
                PageID := Page::"Standing Order Card";
            Database::"Loans Register":
                PageID := Page::"Loan Application Card(BOSA)";
            Database::"HR Training Applications":
                PageID := page::"HR Training Application Card";
            Database::"Membership Exist":
                PageID := page::"Membership Exit Card";
            Database::"Loan trunch Disburesment":
                PageID := page::"Loan Trunch Disburesment";
            Database::"Payment Header.":
                PageID := page::"Cash Payment Header";

            Database::"Payments Header":
                PageID := GetPaymentVoucherCard(RecordRef);

            Database::"Sacco Transfers":
                PageID := page::"Sacco Transfer Card";

            Database::"Member Agent/Next Of Kin Chang":
                PageID := page::"Agent/NOK/Sign. Change Card";

        end;
    end;

    local procedure GetMemberPageID(RecRef: RecordRef): Integer
    var
        MemberApp: Record "Membership Applications";
    begin
        RecRef.SetTable(MemberApp);
        case MemberApp."Account Category" of
            MemberApp."Account Category"::Individual:
                exit(Page::"Membership Application Card");

            MemberApp."Account Category"::Group:
                exit(Page::"Group/Corporate Applic Card");
            MemberApp."Account Category"::Corporate:
                exit(Page::"Group/Corporate Applic Card");
            MemberApp."Account Category"::Joint:
                exit(Page::"Group/Corporate Applic Card")





        end;
    end;

    procedure GetPaymentVoucherCard(RecRef: RecordRef): Integer
    var
        PaymentVoucher: Record "Payments Header";
    begin
        RecRef.SetTable(PaymentVoucher);
        case PaymentVoucher."Payment Type" of
            PaymentVoucher."Payment Type"::"Payment Request":
                exit(Page::"Payment Request Card");
            PaymentVoucher."Payment Type"::Normal:
                exit(Page::"Payment Voucher")
        end;
    end;

}