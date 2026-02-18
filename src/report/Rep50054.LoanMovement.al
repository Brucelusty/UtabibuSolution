report 50054 "Loan Movement"
{
    Caption = 'Loan Movement';
    RDLCLayout = 'Layouts/Loans Movement Report II.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loan Products Setup"; "Loan Products Setup")
        {
            RequestFilterFields = "Date Filter";

            column(Code_LoanProductsSetup; "Loan Products Setup".Code) { }
            column(Accounts; TransactedAccounts) { }
            column(OpeningBal; ClosingBalPreviousDay) { }
            column(TotalDeposits; TotalDeposits) { }
            column(TotalWithdrawals; TotalWithdrawals) { }
            column(Issued_Amount; "Issued Amount") { }
            column(Total_Debits; "Total Debits") { }
            column(ClosingBal; ClosingBalToday) { }
            column(AccountNumber; GLAccountNo) { }
            column(CompanyName; Company.Name) { }
            column(CompanyPicture; Company.Picture) { }
            column(AsAtDate; ASAT) { }
            column(User; UserId) { }
            column(FromDate; FromDate) { }
            column(ApprovedAmount; ApprovedAmount) { }

            trigger OnAfterGetRecord();
            begin
                CurrDate := ASAT;
                if FromDate = 0D then
                    FromDate := CurrDate;

                PreviousDay := FromDate - 1;

                TotalDeposits := 0;
                TotalWithdrawals := 0;
                ClosingBalToday := 0;
                ClosingBalPreviousDay := 0;

                FnGetAccountNo("Loan Products Setup".Code);
                FnGetOpeningBalance(GLAccountNo, PreviousDay);
                FnGetMovements(GLAccountNo, FromDate, CurrDate);
                FnGetClosingBalance(GLAccountNo, CurrDate);
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
                field("From Date"; FromDate) { ApplicationArea = Basic; }
                field("To Date"; ASAT) { ApplicationArea = Basic; }
            }
        }
        actions { }
        trigger OnOpenPage()
        begin
        end;
    }

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        GLAccount: Record "G/L Account";
        Company: Record "Company Information";
        ClosingBalPreviousDay: Decimal;
        TotalDeposits: Decimal;
        TotalWithdrawals: Decimal;
        ClosingBalToday: Decimal;
        GLAccountNo: Code[20];
        VendorPostingGroups: Record "Vendor Posting Group";
        StartDate: Date;
        PreviousDay: Date;
        CurrDate: Date;
        LoanSetup: Record "Loan Products Setup";
        GLAccounts: Record "G/L Account";
        CurrDateFilter: Text;
        PrevDateFilter: Text;
        GLEntry: Record "G/L Entry";
        ASAT: Date;
        TransactedAccounts: Integer;
        VendLedger: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        Dep: Decimal;
        MoveDateFilter: Text;
        LoanProd: Record "Loan Products Setup";
        Memb: Record Customer;
        MembLedger: Record "Member Ledger Entry";
        Loans: Record "Loans Register";
        loanNo: Code[20];
        FromDate: Date;
        LoanCount: Integer;
        ApprovedAmount: Decimal;

    local procedure FnGetAccountNo(LoanType: Code[20])
    begin
        LoanProd.Reset();
        LoanProd.SetRange(LoanProd.Code, LoanType);
        if LoanProd.Find('-') then
            GLAccountNo := LoanProd."Loan Account";
    end;

    local procedure FnGetLoans(Type: Code[20]): Integer
    var
        LoanCnt: Integer;
    begin
        LoanCnt := 0;
        Loans.RESET();
        Loans.SETRANGE(Loans."Loan Product Type", Type);
        if Loans.FindSet() then begin
            repeat
                LoanCnt += 1;
            until Loans.Next() = 0;
        end;
        exit(LoanCnt);
    end;

    local procedure FnGetOpeningBalance(AccountNo: Code[20]; Date_: Date)
    begin
        ClosingBalPreviousDay := 0;
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", 0D, Date_);
        if GLEntry.FindSet() then
            repeat
                ClosingBalPreviousDay += GLEntry.Amount;
            until GLEntry.Next() = 0;
    end;

    local procedure FnGetMovements(AccountNo: Code[20]; FromDate: Date; ToDate: Date)
    begin
        TotalDeposits := 0;
        TotalWithdrawals := 0;
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", FromDate, ToDate);
        if GLEntry.FindSet() then
            repeat
                if GLEntry.Amount > 0 then
                    TotalDeposits += GLEntry.Amount
                else
                    TotalWithdrawals += Abs(GLEntry.Amount);
            until GLEntry.Next() = 0;
    end;

    local procedure FnGetClosingBalance(AccountNo: Code[20]; Date_: Date)
    begin
        ClosingBalToday := 0;
        GLEntry.Reset();
        GLEntry.SetRange("G/L Account No.", AccountNo);
        GLEntry.SetRange("Posting Date", 0D, Date_);
        if GLEntry.FindSet() then
            repeat
                ClosingBalToday += GLEntry.Amount;
            until GLEntry.Next() = 0;
    end;
    
    local procedure FnGetClosingBal(Type: Code[20]; CurrDateFilter: Text[300])
    begin
        ClosingBalToday := 0;
        LoanSetup.Reset();
        LoanSetup.SETFILTER(LoanSetup."Date Filter", CurrDateFilter);
        LoanSetup.SetRange(LoanSetup.Code, Type);
        LoanSetup.SetAutoCalcFields("Product Totals");
        if LoanSetup.Find('-') then begin
            LoanSetup.CALCFIELDS(LoanSetup."Product Totals");
            ClosingBalToday := LoanSetup."Product Totals";
        end;
    end;

    local procedure DateToFilterText(d: Date): Text[30]
    begin

        exit(FORMAT(d, 0, '<Year4>-<Month,2>-<Day,2>'));
    end;
}
