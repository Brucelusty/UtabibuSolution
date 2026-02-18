report 173001 UtapesaLoaninterest
{
    Caption = 'UtapesaLoaninterest';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Loan Product Type" = FILTER('UTAPESA'));
            trigger OnPreDataItem()
            begin
                IF repaymentdate = 0D then error('Kindly enter loan interest date');
                if repaymentdate > Today then error('You cannot process interest for future dates');
                aufactory.FnClearGnlJournalLine('GENERAL', 'INTMOBILE');
            end;

            trigger OnAfterGetRecord()
            begin


                mobile.FnPostIntrestMobileAuto(repaymentdate, "Loans Register"."Loan  No.");

            end;

            trigger OnPostDataItem()
            begin
                aufactory.FnPostGnlJournalLine('GENERAL', 'INTMOBILE');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Interest date"; repaymentdate) { }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        mobile: Codeunit "Mobile Banking Code";

    var
        repaymentdate: Date;

    var
        aufactory: Codeunit "Au Factory";

}
