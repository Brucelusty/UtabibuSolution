pageextension 172190 bankAccountStatement extends "Bank Account Statement"
{

    layout
    {
    }

    actions
    {

        // Add changes to page actions here
        addafter(Print)
        {
            action("Reconciliation Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reconciliation Report';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Report;
                Image = Report;
                ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';
                trigger OnAction()
                var
                    BankAccountStatement: Record "Bank Acc. Reconciliation";
                begin
                    BankAccountStatement.RESET;
                    BankAccountStatement.SETRANGE("Bank Account No.", rec."Bank Account No.");
                    BankAccountStatement.SETRANGE("Statement No.", rec."Statement No.");
                    IF BankAccountStatement.FINDFIRST THEN
                        REPORT.RUN(50055, TRUE, FALSE, BankAccountStatement);

                end;
            }
        }
    }




}
