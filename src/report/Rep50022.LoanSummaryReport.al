report 50022 "Loan Summary Report"
{
    ApplicationArea = All;
    Caption = 'Loan Summary Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts/LoanSummaryReport.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(LoansRegister; "Loans Register")
        {
            DataItemTableView = where(Posted = filter(true));
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(OutstandingBalance; "Outstanding Balance")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(Requested_Amount; "Requested Amount") { }
            column(Loans_Category; "Loans Category") { }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
