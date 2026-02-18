//<---------------------------------------------------------------------->															
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // 															

Report 50063 "CheckOff Advice"
{
    RDLCLayout = 'Layouts/CheckOffAdvice.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {

            column(CompanyInfoPic; CompanyInfo.Picture) { }
            column(CompanyInfoName; CompanyInfo.Name) { }
            column(CompanyInfoAddress; CompanyInfo.Address) { }
            column(CompanyInfoPhone; CompanyInfo."Phone No.") { }
            column(CompanyInfoEmail; CompanyInfo."E-Mail") { }

            column(Payroll_No; "Payroll No")
            {

            }
            column(Name; Name) { }
            column(LoanBalanceExp; LoanBalanceExp) { }
            column(PrincipleLoan; PrincipleLoan) { }
            column(InterestBal; InterestBal) { }
            column(MonthlyContribution; MonthlyContribution) { }
            column(TotalDeduction; TotalDeduction) { }
            column(RunDate; RunDate) { }

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                ExpectedBal := 0;
                LoanBal := 0;
                LoanBalanceExp := 0;
                PrincipleLoan := 0;
                InterestBal := 0;
                MonthlyContribution := 0;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetFilter("Date filter", '..%1', RunDate);
                if LoansRec.Find('-') then begin
                    repeat
                        if LoansRec."Outstanding Balance" > 0 then begin
                            LoanRepaymentSchedule.Reset();
                            LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Member No.", LoansRec."Client Code");
                            LoanRepaymentSchedule.SetFilter("Repayment Date", '..%1', RunDate);
                            if LoanRepaymentSchedule.FindLast() then begin
                                ExpectedBal += LoanRepaymentSchedule."Loan Balance";
                            end;
                        end;
                    until LoansRec.Next() = 0;
                end;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetFilter("Date filter", '..%1', RunDate);
                if LoansRec.Find('-') then begin
                    repeat
                        if LoansRec."Outstanding Balance" > 0 then begin
                            LoanRepaymentSchedule.Reset();
                            LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Member No.", LoansRec."Client Code");
                            LoanRepaymentSchedule.SetFilter("Repayment Date", '..%1', RunDate);
                            if LoanRepaymentSchedule.FindLast() then begin
                                PrincipleLoan += LoanRepaymentSchedule."Principal Repayment";
                            end;
                        end;
                    until LoansRec.Next() = 0;
                end;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetFilter("Date filter", '..%1', RunDate);
                if LoansRec.Find('-') then begin
                    repeat
                        if LoansRec."Outstanding Balance" > 0 then begin
                            LoanRepaymentSchedule.Reset();
                            LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Member No.", LoansRec."Client Code");
                            LoanRepaymentSchedule.SetFilter("Repayment Date", '..%1', RunDate);
                            if LoanRepaymentSchedule.FindLast() then begin
                                InterestBal += LoanRepaymentSchedule."Monthly Interest";
                            end;
                        end;
                    until LoansRec.Next() = 0;
                end;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetFilter("Date filter", '..%1', RunDate);
                LoansRec.SetAutoCalcFields("Outstanding Balance");
                if LoansRec.Find('-') then begin
                    repeat
                        LoanBal += LoansRec."Outstanding Balance";
                    until LoansRec.Next() = 0;
                end;
                LoanBalanceExp := LoanBal - ExpectedBal;

                if LoanBalanceExp < 0 then
                    LoanBalanceExp := 0
                else
                    LoanBalanceExp := LoanBalanceExp;
                //monthly contribution;
                MonthlyContribution := 0;
                CustomerTable.Reset();
                CustomerTable.SetRange("No.", Customer."No.");
                if CustomerTable.FindFirst() then begin
                    MonthlyContribution := CustomerTable."Monthly Contribution";
                end;

                TotalDeduction := MonthlyContribution + LoanBalanceExp + PrincipleLoan + InterestBal;
                if TotalDeduction <= 0 then CurrReport.Skip();
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(RunDate; RunDate)
                    {
                        Caption = 'CheckOff Date';
                    }
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        LoansRec: Record "Loans Register";
        CustomerTable: Record Customer;
        CompanyInfo: Record "Company Information";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        NormPr: Decimal;
        TotalDeduction: Decimal;
        MonthlyContribution: Decimal;
        NormInt: Decimal;
        EmerPr: Decimal;
        EmerInt: Decimal;
        SchoolPr: Decimal;
        SchoolInt: Decimal;
        TopupPr: Decimal;
        Topupint: Decimal;
        CollegePr: Decimal;
        CollegeInt: Decimal;
        DefaulterPr: Decimal;
        DefaulterInt: Decimal;

        ExpectedBal: Decimal;
        RunDate: Date;

        LoanBal: Decimal;

        LoanBalanceExp: Decimal;

        PrincipleLoan: Decimal;

        InterestBal: Decimal;


    var

}



