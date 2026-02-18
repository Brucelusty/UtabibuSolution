query 9157 "powerbiloan"
{
    Caption = 'powerbi loan';
   

    elements
    {
        dataitem(Loans_Register; "Loans Register")
        {
            column(AmountDisbursed; "Amount Disbursed")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(ApprovalStatus; "Approval Status")
            {
            }
            column(Defaulted; Defaulted)
            {
            }
            column(ClientCode; "Client Code")
            {
            }
            column(DepositBoosting; "Deposit Boosting")
            {
            }
            column(DepositBoostingCommision; "Deposit Boosting Commision")
            {
            }
            column(DefaulterLoan; "Defaulter Loan")
            {
            }
            column(Defaulter; Defaulter)
            {
            }
            column(DisburesmentType; "Disburesment Type")
            {
            }
            column(ExistingLoan; "Existing Loan")
            {
            }
            column(IDNO; "ID NO")
            {
            }
            column(Interest; Interest)
            {
            }
            column(InterestPaid; "Interest Paid")
            {
            }
            column(InterestCharged; "Interest Charged")
            {
            }
            column(LoanNo; "Loan  No.")
            {
            }
            column(LoanAmount; "Loan Amount")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanStatus; "Loan Status")
            {
            }
            column(OutstandingBalance; "Outstanding Balance")
            {
            }
            column(OutstandingInterest; "Outstanding Interest")
            {
            }
            column(OutstandingPenalty; "Outstanding Penalty")
            {
            }
            column(Upfronts; Upfronts)
            {
            }
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(IssuedDate; "Issued Date")
            {
            }
            column(Loan_Disbursement_Date; "Loan Disbursement Date")
            {

            }
            column(Total_Interest_Paid; "Total Interest Paid")
            {

            }
        }
    }
    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}
