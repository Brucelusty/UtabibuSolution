//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80017 "Member Statistics FactBox"
{
    Caption = 'Member FactBox';
    Editable = false;
    PageType = CardPart;
    SaveValues = true;
    SourceTable = Customer;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = Basic;
                Caption = 'Member No.';
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = Basic;
            }
            field("ID No."; Rec."ID No.")
            {
                ApplicationArea = Basic;
            }
            field("Mobile Phone No"; Rec."Mobile Phone No")
            {
                ApplicationArea = Basic;
            }
            field(Comment1; Rec.Comment1)
            {
                ApplicationArea = Basic;
                Caption = 'Comment';
                Style = Attention;
                StyleExpr = true;
            }

            field("No of BD Trainings Attended"; Rec."No of BD Trainings Attended")
            {
                ApplicationArea = Basic;
                Editable = false;
                Visible = false;
            }
            group("Member Details FactBox")
            {
                Caption = 'Member Details FactBox';
                field("Registration Fee Paid"; Rec."Registration Fee Paid")
                {
                    ApplicationArea = Basic;
                    Caption = 'Registration Fee';
                    Importance = Promoted;

                }

                field("Current Shares"; Rec."Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposits';
                    //  Image = Star;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(MemberFosabalance; MemberFosabalance)
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Balance';
                    Visible = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital';
                    //Style = Favorable;
                    StyleExpr = FieldStyleI;

                }
                field("Chama Savings"; Rec."Programmed Deposits")
                {
                    Caption = 'Programmed Deposits';
                }

                field("Interest on PD"; Rec."Interest on PD")
                {
                    Caption = 'Interest On Programmed Deposits';
                }

                field("Benevolent Fund"; Rec."Benevolent Fund")
                {
                    ApplicationArea = Basic;

                    //Style = Favorable;
                    StyleExpr = FieldStyleI;
                }
                field("Standing OrderStanding Order"; Rec."Standing Order Acount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Order';
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Defaulted Loan Recovery"; Rec."Defaulted Loan Recovery")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Caption = 'Defaulted Loan Recovery';
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Rejoining Fee"; Rec."Rejoining Fee")
                {

                    ApplicationArea = Basic;
                }

                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Outstanding Balance';
                    StyleExpr = FieldStyleL;
                }
                field("Disbursment Account"; Rec."Disbursment Account")
                {
                    Caption = 'Disbursement Account';
                    ApplicationArea = Basic;
                    Width = 50;
                    Editable = false;
                }
                field("M-Wallet Account"; Rec."M-Wallet Account")
                {
                    Caption = 'M-Wallet Account';
                    ApplicationArea = Basic;
                    Width = 50;
                    Editable = false;
                }
                field("Partial Disbursement"; Rec."Partial Disbursement")
                {
                    Caption = 'Partial Disbursement';
                    ApplicationArea = Basic;
                    Width = 50;
                    Editable = false;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Charged"; Rec."Interest Charged") { }
                field("Loan Count"; Rec."Loan Count")
                {
                    Caption = 'Running Loans';
                }
                field("Loan Count taken"; Rec."Loan Count taken")
                {
                    Caption = 'Loans Taken';
                }

                field(VarMemberLiability; VarMemberLiability)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Liability';
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Interest On Deposits"; Rec."Interest On Deposits")
                {
                    ApplicationArea = basic;

                }

                field("Dividend Amount"; Rec."Dividend Amount")
                {
                    ApplicationArea = basic;

                }

                field("Un-allocated Funds"; Rec."Un-allocated Funds")
                {
                    Caption = 'Un-allocated Funds';
                    ApplicationArea = basic;
                }



            }
            group("File Movement FactBox")
            {
                Caption = 'File Movement FactBox';
                Visible = false;
                field("Currect File Location"; Rec."Currect File Location")
                {
                    ApplicationArea = Basic;
                }
                field("Loc Description"; Rec."Loc Description")
                {
                    ApplicationArea = Basic;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin


        VarMemberLiability := SFactory.FnGetMemberLiability(Rec."No.");

        VarTotalInterestCharged := 0;
        VarTotalInterestPaid := 0;
        VarOutstandingInterest := 0;

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", Rec."No.");
        if ObjLoans.FindSet then begin
            repeat
                VarLoanOutstandingInt := SFactory.FnRunLoanAmountDue(ObjLoans."Loan  No.");
                VarOutstandingInterest := VarOutstandingInterest + ObjLoans."Current Interest Due";
            until ObjLoans.Next = 0;
        end;


    end;

    trigger OnAfterGetRecord()
    begin

        MemberFosabalance := 0;
        Vendor.Reset();
        Vendor.SetRange("BOSA Account No", Rec."No.");
        Vendor.SetAutoCalcFields("Balance (LCY)");
        if Vendor.Find('-') then begin
            MemberFosabalance := Vendor."Balance (LCY)";
        end;
        // if Rec."Special Accounts" then begin
        //     if UserSetup.Get(UserId) then begin
        //         if not UserSetup."View Special Accounts" then
        //             Error('You do not have permission to view Insider member accounts. Contact your system administrator.');
        //     end else
        //         Error('User setup record not found. Contact your system administrator.');
        // end;
        if Rec."Special Accounts" then begin
            if not UserSetup.Get(UserId) then
                Error('User setup record not found. Contact your system administrator.');


            if (Rec."Mobile Phone No." <> '') and (UserSetup."Phone No." <> '') and (Rec."Mobile Phone No." = UserSetup."Phone No.") then begin
            end else begin
                if not UserSetup."View Special Accounts" then
                    Error('You do not have permission to view insider member accounts that are not your own. Contact your system administrator.');
            end;
        end;
        SetFieldStyle;

        //VarMemberLiability:=SFactory.FnGetMemberLiability("No.");
    end;

    trigger OnOpenPage()
    begin
        Rec.CalcFields("Current Shares");
        Rec.CalcFields("Shares Retained");
        Rec.CalcFields("Interest on PD");
        Rec.CalcFields("Programmed Deposits");
        Rec.CalcFields("Outstanding Balance");
        Rec.CalcFields("Outstanding Interest");
        Rec.CalcFields("Un-allocated Funds");
        Rec.CalcFields("Dividend Amount");
        Rec.CalcFields("Interest On Deposits");
        Rec.CalcFields("Interest Charged");
        Rec.CalcFields("Loan Count");
        Rec.CalcFields("Standing Order Acount");
        Rec.CalcFields("Benevolent Fund");
        Rec.CalcFields("Defaulted Loan Recovery");
        Rec.CalcFields("Registration Fee Paid");
        Rec.CalcFields("Disbursment Account");
        Rec.CalcFields("M-Wallet Account");
        if Rec."Special Accounts" then begin
            if UserSetup.Get(UserId) then begin
                if not UserSetup."View Special Accounts" then
                    Error('You do not have permission to view Insider member accounts. Contact your system administrator.');
            end else
                Error('User setup record not found. Contact your system administrator.');
        end;

    end;

    var
        LatestCustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry: array[4] of Record "Cust. Ledger Entry";
        AgingTitle: array[4] of Text[30];
        AgingPeriod: DateFormula;
        I: Integer;
        PeriodStart: Date;
        MemberFosabalance: Decimal;
        Vendor: Record Vendor;
        PeriodEnd: Date;
        Text002: label 'Not Yet Due';
        Text003: label 'Over %1 Days';
        Text004: label '%1-%2 Days';
        LoanGuarantors: Record "Loans Guarantee Details";
        ComittedShares: Decimal;
        Loans: Record "Loans Register";
        FreeShares: Decimal;
        UserSetup: Record "User Setup";
        FieldStyle: Text;
        FieldStyleL: Text;
        FieldStyleI: Text;
        LoanNo: Code[20];
        LoanGuar: Record "Loans Guarantee Details";
        TGrAmount: Decimal;
        GrAmount: Decimal;
        FGrAmount: Decimal;
        TAmountGuaranteed: Decimal;
        AllGuaratorsTotal: Decimal;
        AmounttoRelease: Decimal;
        TotalOutstaningBal: Decimal;
        TotalApprovedAmount: Decimal;
        TotalAmountPaid: Decimal;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "Au Factory";
        ObjLoans: Record "Loans Register";
        VarMemberLiability: Decimal;
        VarOutstandingInterest: Decimal;
        VarTotalInterestCharged: Decimal;
        VarTotalInterestPaid: Decimal;
        VarLoanOutstandingInt: Decimal;


    procedure CalculateAgingForPeriod(PeriodBeginDate: Date; PeriodEndDate: Date; Index: Integer)
    var
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        NumDaysToBegin: Integer;
        NumDaysToEnd: Integer;
    begin
        // Calculate the Aged Balance for a particular Date Range
        if PeriodEndDate = 0D then
            CustLedgerEntry[Index].SetFilter("Due Date", '%1..', PeriodBeginDate)
        else
            CustLedgerEntry[Index].SetRange("Due Date", PeriodBeginDate, PeriodEndDate);

        CustLedgerEntry2.Copy(CustLedgerEntry[Index]);
        CustLedgerEntry[Index]."Remaining Amt. (LCY)" := 0;
        if CustLedgerEntry2.Find('-') then
            repeat
                CustLedgerEntry2.CalcFields("Remaining Amt. (LCY)");
                CustLedgerEntry[Index]."Remaining Amt. (LCY)" :=
                  CustLedgerEntry[Index]."Remaining Amt. (LCY)" + CustLedgerEntry2."Remaining Amt. (LCY)";
            until CustLedgerEntry2.Next = 0;

        if PeriodBeginDate <> 0D then
            NumDaysToBegin := WorkDate - PeriodBeginDate;
        if PeriodEndDate <> 0D then
            NumDaysToEnd := WorkDate - PeriodEndDate;
        if PeriodEndDate = 0D then
            AgingTitle[Index] := Text002
        else
            if PeriodBeginDate = 0D then
                AgingTitle[Index] := StrSubstNo(Text003, NumDaysToEnd - 1)
            else
                AgingTitle[Index] := StrSubstNo(Text004, NumDaysToEnd, NumDaysToBegin);
    end;


    procedure CalculateAging()
    begin
        // Calculate the Entire Aging (four Periods)
        for I := 1 to ArrayLen(CustLedgerEntry) do begin
            case I of
                1:
                    begin
                        PeriodEnd := 0D;
                        PeriodStart := WorkDate;
                    end;
                ArrayLen(CustLedgerEntry):
                    begin
                        PeriodEnd := PeriodStart - 1;
                        PeriodStart := 0D;
                    end;
                else begin
                    PeriodEnd := PeriodStart - 1;
                    PeriodStart := CalcDate('-' + Format(AgingPeriod), PeriodStart);
                end;
            end;
            CalculateAgingForPeriod(PeriodStart, PeriodEnd, I);
        end;
    end;


    procedure GetLatestPayment()
    begin
        // Find the Latest Payment
        if LatestCustLedgerEntry.FindLast then
            LatestCustLedgerEntry.CalcFields("Amount (LCY)")
        else
            LatestCustLedgerEntry.Init;
    end;


    procedure ChangeCustomer()
    begin
        // Change the Customer Filters
        LatestCustLedgerEntry.SetRange("Customer No.", Rec."No.");
        for I := 1 to ArrayLen(CustLedgerEntry) do
            CustLedgerEntry[I].SetRange("Customer No.", Rec."No.");
    end;


    procedure DrillDown(Index: Integer)
    begin
        if Index = 0 then
            Page.RunModal(Page::"Customer Ledger Entries", LatestCustLedgerEntry)
        else
            Page.RunModal(Page::"Customer Ledger Entries", CustLedgerEntry[Index]);
    end;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        //Rec.CalcFields("Un-allocated Funds");
        if Rec."Un-allocated Funds" <> 0 then
            FieldStyle := 'Attention';
        Rec.CalcFields("Outstanding Balance", "Outstanding Interest");
        if (Rec."Outstanding Balance" < 0) then
            FieldStyleL := 'Attention';

        Rec.CalcFields("Outstanding Balance", "Outstanding Interest");
        if (Rec."Outstanding Interest" < 0) then
            FieldStyleI := 'Attention';
        if Rec."Shares Retained" >= 5000 then begin
            FieldStyleI := 'Favorable'
        end;
        if Rec."Shares Retained" < 5000 then begin
            FieldStyleI := 'Attention';
        end;


    end;
}




