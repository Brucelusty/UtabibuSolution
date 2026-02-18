report 80043 "Interest Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Loansinterest.rdlc';
   
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") order(ascending);
            PrintOnlyIfDetail = false;

            CalcFields = "Outstanding Balance", "Interest Paid", "Principal Paid", "Scheduled Principal to Date",
                         "Schedule Interest to Date",
                         "Outstanding Interest";

            RequestFilterFields = "Loan  No.",
                                 Source,
                                 "Loan Product Type",
                                 "Date filter",
                                 "Application Date",
                                 "Loan Status",
                                 "Issued Date",
                                 Posted,
                                 "Batch No.",
                                 "Captured By",
                                 "Branch Code",
                                 "Outstanding Balance",
                                 "Date Approved",
                                 "Employer Code",
                                 Closed;

     
            column(ReportDate; Format(Today, 0, '<Standard Format,0>')) { }
            column(CompanyName; Company.Name) { }
            column(CompanyAddress; Company.Address) { }
            column(CompanyAddress2; Company."Address 2") { }
            column(CompanyPhoneNo; Company."Phone No.") { }
            column(CompanyFaxNo; Company."Fax No.") { }
            column(CompanyEmail; Company."E-Mail") { }
            column(CompanyPicture; Company.Picture) { }
            column(UserID; UserId) { }
            column(ReportFilters; RFilters) { }
            column(LoanCount; LCount) { }

            column(Loan__No_; "Loan  No.") { }
            column(ClientCode; "Client Code") { }
            column(ClientName; "Client Name") { }
            column(LoanProductType; "Loan Product Type") { }
            column(LoanProductTypeName; "Loan Product Type Name") { }
            column(LoanTypeDescription; LoanType) { }

            column(RequestedAmount; "Requested Amount") { }
            column(ApprovedAmount; "Approved Amount") { }
            column(DisbursedAmount; "Loan Disbursed Amount") { }
            column(OutstandingPrincipal; "Outstanding Balance") { }
            column(OutstandingInterest; "Outstanding Interest") { }
            column(InterestPaid; "Interest Paid") { }
            column(PrincipalPaid; "Principal Paid") { }

            column(InterestDueThisPeriod; InterestDue) { }
            column(PrincipalArrears; LoanArrears) { }
            column(CustomOutstandingInterestDue; OutstandingInterestDue) { }
            column(InterestDueDocumentNo; DocNo) { }

            column(MonthsInArrears; "No of Months in Arrears") { }


            column(LoanStatus; "Loan Status") { }
            column(ApplicationDate; "Application Date") { }
            column(IssuedDate; "Issued Date") { }
            column(ApprovedDateFormatted; Format("Date Approved")) { }
            column(LastPaymentDate; "Last Pay Date") { }

            column(Installments; Installments) { }
            column(RepaymentAmount; Repayment) { }
            column(RepaymentFrequency; "Repayment Frequency") { }
            column(RepaymentMethod; "Repayment Method") { }
            column(ExpectedCompletionDate; "Expected Date of Completion") { }
            column(EmployerCode; "Employer Code") { }
            column(EmployerName; "Employer Name") { }
            column(StaffNo; LAppl."Staff No") { }
            column(CurrentShares; "Current Shares") { }

            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Client Code");

                column(CustomerNo; "No.") { }
                column(IDNumber; "ID No.") { }
                column(DateOfBirth; "Date Of Birth") { }
            }

            trigger OnPreDataItem()
            begin
                DateFilter := GetFilter("Date filter");
                LCount := 0;

                if GetFilter("Loan Product Type") <> '' then
                    if LoanProdType.Get(GetFilter("Loan Product Type")) then
                        LoanType := LoanProdType."Product Description";

                // Branch filter description
                if GetFilter("Branch Code") <> '' then begin
                    DValue.Reset();
                    DValue.SetRange("Global Dimension No.", 2);
                    DValue.SetRange(Code, GetFilter("Branch Code"));
                    if DValue.FindFirst() then
                        RFilters := StrSubstNo('Branch: %1', DValue.Name);
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                LCount += 1;


                InterestDue := "Schedule Interest to Date";
                LoanArrears := "Scheduled Principal to Date" - Abs("Principal Paid");
                OutstandingInterestDue := 0;
                DocNo := '';

                CustLedgEntry.Reset();
                CustLedgEntry.SetRange("Customer No.", "Client Code");
                CustLedgEntry.SetRange("Transaction Type", CustLedgEntry."Transaction Type"::"Interest Due");


                if CustLedgEntry.FindSet() then begin
                    repeat
                        // CustLedgEntry.CalcFields(Amount);
                        OutstandingInterestDue += "Outstanding Interest";
                        DocNo := CustLedgEntry."Document No.";
                    until CustLedgEntry.Next() = 0;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                // Add request page fields/controls here when needed
            }
        }
    }

    labels
    {
        ReportTitleLbl = 'Loans Balances Report';
        PageLbl = 'Page';
        LoanTypeLbl = 'Loan Type';
        ClientNoLbl = 'Client No.';
        OutstandingPrincipalLbl = 'Outstanding Principal';
        OutstandingInterestLbl = 'Outstanding Interest';
        InterestDueLbl = 'Interest Due';
        DocumentNoLbl = 'Document No.';
    }

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Picture);
    end;

    trigger OnPreReport()
    begin
        if CompInfor.Get() then begin
            CompInfor.CalcFields(Picture);
            CompanyName := CompInfor.Name;
        end;
    end;

    var
        Company: Record "Company Information";
        CompInfor: Record "Company Information";
        LoanProdType: Record "Loan Products Setup";
        DValue: Record "Dimension Value";
        CustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        cust: Record Customer;

        LoanType: Text[100];
        DateFilter: Text;
        RFilters: Text[250];
        LCount: Integer;

        InterestDue: Decimal;
        LoanArrears: Decimal;
        OutstandingInterestDue: Decimal;
        DocNo: Code[20];
        CompanyName: Text[100];

        // Keep these if still used in layout
        LAppl: Record "Loans Register";
        Repayment: Decimal;
}

