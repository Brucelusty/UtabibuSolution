//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172372 "Loans Guarantee Details"
{
    DrillDownPageId = "Loans Guarantee Details";
    LookupPageId = "Loans Guarantee Details";

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Member No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                LnGuarantor.Reset;
                LnGuarantor.SetRange(LnGuarantor."Loan  No.", "Loan No");
                if LnGuarantor.Find('-') then begin
                    if LnGuarantor."Client Code" = "Member No" then begin

                        "Self Guarantee" := true;
                        //MODIFY;
                    end;
                end;
                //     LoanGuarantors.SetRange(LoanGuarantors."Self Guarantee", true);
                LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No");
                SelfGuaranteedA := 0;
                Date := Today;






                if Cust.Get("Member No") then begin
                    // if Cust.Status <> Cust.Status::Active then Error('Only Active Members can guarantee Loan. Member status %1', Cust.Status);
                    Cust.CalcFields(Cust."Outstanding Balance", Cust."Current Shares", Cust.TLoansGuaranteed);
                    Name := Cust.Name;
                    "Staff/Payroll No." := Cust."Payroll No";
                    "Loan Balance" := Cust."Outstanding Balance";
                    Shares := Cust."Current Shares" * 1;
                    //"Amont Guaranteed":=Shares;
                    "TotalLoan Guaranteed" := Cust.TLoansGuaranteed;
                    "Free Shares" := (Shares * 3) - "TotalLoan Guaranteed";
                end;



            end;
        }
        field(3; Name; Text[200])
        {
            Editable = false;
        }
        field(4; "Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(5; Shares; Decimal)
        {
            Editable = false;
        }
        field(6; "No Of Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("Member No"),
                                                                 "Outstanding Balance" = filter(> 1)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Substituted; Boolean)
        {

            trigger OnValidate()
            begin
                //TESTFIELD("Substituted Guarantor");
            end;
        }
        field(8; Date; Date)
        {
        }
        field(9; "Shares Recovery"; Boolean)
        {
        }
        field(10; "New Upload"; Boolean)
        {
        }
        field(11; "Amont Guaranteed"; Decimal)
        {

            trigger OnValidate()
            var
                Loan: Record "Loans Register";
                Loanbalance: Decimal;
                TotalsSelf: Decimal;
                SelfAvailable: Decimal;
                ApprovedAmount: Decimal;
                OtherGuarantee: Decimal;
                TotalAvailabeForQuarantee: Decimal;
                ApprovedAmount2: Decimal;
            begin
                if "Amont Guaranteed" > Shares then
                    Error('You cannot guarantee more than your current shares. Current Shares: %1', Shares);
                SharesVariance := 0;
                Loanbalance := 0;
                OtherGuarantee := 0;
                TotalAvailabeForQuarantee := 0;
                Loan.Reset();
                Loan.SetRange("Client Code", "Member No");
                Loan.SetAutoCalcFields("Outstanding Balance");
                if Loan.Find('-') then begin
                    Loanbalance += Loan."Outstanding Balance";
                    ApprovedAmount += Loan."Approved Amount";
                end;
                LoanGuarantors.Reset;
                LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No");
                LoanGuarantors.SetRange("Self Guarantee", false);
                if LoanGuarantors.Find('-') then begin

                    repeat
                        LoanGuarantors.CalcFields(LoanGuarantors."Outstanding Balance");
                        if LoanGuarantors."Outstanding Balance" > 0 then begin
                            OtherGuarantee := Totals + LoanGuarantors."Outstanding Balance";
                            ApprovedAmount2 := ApprovedAmount2 + LoanGuarantors."Approved Amount";
                        end;
                    until LoanGuarantors.Next = 0;
                end;
                LoanGuarantors.Reset;
                LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No");
                LoanGuarantors.SetRange("Self Guarantee", false);
                if LoanGuarantors.Find('-') then begin

                    repeat
                        LoanGuarantors.CalcFields(LoanGuarantors."Outstanding Balance");
                        if LoanGuarantors."Outstanding Balance" > 0 then begin
                            Totals := Totals + LoanGuarantors."Amont Guaranteed";
                        end;
                    until LoanGuarantors.Next = 0;
                end;
                if ApprovedAmount2 > 0 then
                    TotalAvailabeForQuarantee := (Shares * 5) - (OtherGuarantee / ApprovedAmount2 * Totals)
                else
                    TotalAvailabeForQuarantee := (Shares * 5);
                LoanGuarantors.Reset;
                LoanGuarantors.SetRange(LoanGuarantors."Member No", "Member No");
                LoanGuarantors.SetRange("Self Guarantee", true);
                if LoanGuarantors.Find('-') then begin
                    repeat
                        LoanGuarantors.CalcFields(LoanGuarantors."Outstanding Balance");
                        if LoanGuarantors."Outstanding Balance" > 0 then begin
                            TotalsSelf := TotalsSelf + LoanGuarantors."Amont Guaranteed";
                        end;
                    until LoanGuarantors.Next = 0;
                end;


                if "Self Guarantee" = true then begin
                    if ApprovedAmount > 0 then
                        SelfAvailable := Shares - (Loanbalance / ApprovedAmount * TotalsSelf)
                    else
                        SelfAvailable := shares;
                    if SelfAvailable > Shares then begin
                        "Amont Guaranteed" := Shares;
                    end else
                        if "Amont Guaranteed" > SelfAvailable then begin
                            "Amont Guaranteed" := SelfAvailable;
                        end else
                            "Amont Guaranteed" := "Amont Guaranteed";


                end else
                    // "Free Shares" := (Shares * 5) - "TotalLoan Guaranteed" - Loanbalance;
                    "Free Shares" := TotalAvailabeForQuarantee;
                if freeshares > 0 then begin
                    if Shares > "Free Shares" then begin
                        "Amont Guaranteed" := "Free Shares"
                    end else begin
                        if "Amont Guaranteed" > "Free Shares" then begin
                            Error('you cannot guarantee more than the availabe shares. Availabe Shares %1', "Free Shares");
                        end else
                            "Amont Guaranteed" := Shares;
                    end;

                end;

            end;
        }
        field(12; "Staff/Payroll No."; Code[20])
        {

            trigger OnValidate()
            begin
                /*Cust.RESET;
                Cust.SETRANGE(Cust."Personal No","Staff/Payroll No.");
                IF Cust.FIND('-') THEN BEGIN
                "Member No":=Cust."No.";
                VALIDATE("Member No");
                END
                ELSE
                "Member No":='';//ERROR('Record not found.')
                */

            end;
        }
        field(13; "Account No."; Code[20])
        {
        }
        field(14; "Self Guarantee"; Boolean)
        {


        }
        field(15; "ID No."; Code[70])
        {
        }
        field(16; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = filter(Loan | repayment),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(17; "Total Loans Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Loan No" = field("Loan No"),
                                                                                  Substituted = const(false),
                                                                                  "Self Guarantee" = const(false)));
            FieldClass = FlowField;
        }
        field(18; "Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = filter(Loan | repayment),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin

            end;
        }
        field(19; "Guarantor Outstanding"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Member No"),
                                                                  "Transaction Type" = filter(Loan | repayment)
                                                                  ));
            FieldClass = FlowField;
        }
        field(20; "Employer Code"; Code[20])
        {
            //TableRelation = Customer."No.";
        }
        field(21; "Employer Name"; Text[100])
        {
        }
        field(22; "Substituted Guarantor"; Code[80])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                GenSetUp.Get();

            end;
        }
        field(23; "Loanees  No"; Code[50])
        {
            CalcFormula = lookup("Loans Register"."Client Code" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(24; "Loanees  Name"; Text[100])
        {
            CalcFormula = lookup("Loans Register"."Client Name" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(25; "Loan Product"; Code[50])
        {
            CalcFormula = lookup("Loans Register"."Loan Product Type" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(26; "Entry No."; Integer)
        {
        }
        field(27; "Loan Application Date"; Date)
        {
            CalcFormula = lookup("Loans Register"."Application Date" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(28; "Free Shares"; Decimal)
        {
        }
        field(29; "Line No"; Integer)
        {
        }
        field(30; "Member Cell"; Code[10])
        {
        }
        field(31; "Share capital"; Decimal)
        {
        }
        field(32; "TotalLoan Guaranteed"; Decimal)
        {
            Description = '`';
        }
        field(33; Totals; Decimal)
        {
        }
        field(34; "Shares *3"; Decimal)
        {
        }
        field(35; "Deposits variance"; Decimal)
        {
        }
        field(36; "Defaulter Loan Installments"; Code[10])
        {
        }
        field(37; "Defaulter Loan Repayment"; Decimal)
        {
        }
        field(38; "Exempt Defaulter Loan"; Boolean)
        {
        }
        field(39; "Additional Defaulter Amount"; Decimal)
        {
        }
        field(40; "Total Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Loan Balance" where("Loan No" = field("Loan No"),
                                                                              Substituted = filter(false)));
            Description = '//>Sum total guaranteed amount for each loan';
            FieldClass = FlowField;
        }
        field(69161; "Total Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("Member No")));
            FieldClass = FlowField;
        }
        field(69162; "Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Member No"),
                                                                  "Transaction Type" = filter("Interest Paid"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(69163; "Loan Risk Amount"; Decimal)
        {
        }
        field(69164; "Total Loan Risk"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Loan Risk Amount" where("Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(69165; "Total Amount Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Loan No" = field("Loan No"),
                                                                                  Substituted = const(false)));
            FieldClass = FlowField;
        }
        field(69166; "Approval Token"; Code[50])
        {
        }
        field(69167; "Acceptance Status"; Option)
        {
            OptionCaption = 'Pending,Accepted,Declined';
            OptionMembers = Pending,Accepted,Declined;
        }
        field(69168; "Date Accepted"; DateTime)
        {
        }
        field(69169; "Mobile No"; Code[30])
        {
        }
        field(69170; "Date Responded"; Date)
        {
        }
        field(69172; "Approved Amount"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Approved Amount" where("Loan  No." = field("Loan No"), Posted = filter(true))
                                                                                );
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Staff/Payroll No.", "Member No", "Entry No.")
        {
        }
        // key(Key2; "Loan No", "Member No")
        // {
        //     Clustered = true;
        //     SumIndexFields = Shares;
        // }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        LoanGuarantors: Record "Loans Guarantee Details";
        Loans: Record "Loans Register";
        LoansR: Record "Loans Register";
        LoansG: Integer;
        GenSetUp: Record "Sacco General Set-Up";
        SelfGuaranteedA: Decimal;
        StatusPermissions: Record "Status Change Permision";
        Employer: Record "Sacco Employers";
        loanG: Record "Loans Guarantee Details";
        CustomerRecord: Record Customer;
        MemberSaccoAge: Date;
        ComittedShares: Decimal;
        LoanApp: Record "Loans Register";
        DefaultInfo: Text;
        ok: Boolean;
        SharesVariance: Decimal;
        MemberCust: Record Customer;
        LnGuarantor: Record "Loans Register";
        LoanApps: Record "Loans Register";
        Text0001: label 'This Member has an Outstanding Defaulter Loan which has never been serviced';
        freeshares: Decimal;
        AvailableLoanBalance: Decimal;
        AvailableSelfFreeShares: Decimal;
        loanrec: Record "Loans Guarantee Details";
        ObjWithApp: Record "Membership Exist";
        ObjCust: Record Customer;
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        ObjSaccoGeneralSetUp: Record "Sacco General Set-Up";

    local procedure UPDATEG()
    begin
    end;

    local procedure FnRunGetLoanRisk() VarLoanRisk: Decimal
    var
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanCollateral: Record "Loan Collateral Details";
        VarCollateralSecurity: Decimal;
        VarArreasAmount: Decimal;
        VarNoGroupMembers: Integer;
        VarGroupNetWorth: Decimal;
        ObjCust: Record Customer;
        VarLastMonth: Date;
        ObjRepaymentSch: Record "Loan Repayment Schedule";
        VarArrears: Decimal;
        VarDateFilter: Text;
        VarRepaymentPeriod: Date;
        VarScheduledLoanBal: Decimal;
        VarLBal: Decimal;
        VarLastMonthDate: Integer;
        VarLastMonthMonth: Integer;
        VarLastMonthYear: Integer;
        VarRepaymentDate: Date;
        VarRepayDate: Integer;
        VarTotalArrears: Decimal;
        VarExitDeposits: Decimal;
        VarExitLoans: Decimal;
        VarMemberGuarantorshipLiability: Decimal;
        "NoofMonthsArrears:Deposit": Decimal;
        "AmountArrears:Deposit": Decimal;
        VarLastDayofPreviousMonth: Date;
        VarTotalLoansIssued: Decimal;
        ObjLoans: Record "Loans Register";
    begin
        //-----------------------------------------------------Get Group Networth
        VarCollateralSecurity := 0;
        VarRepaymentPeriod := WorkDate;
        VarArrears := 0;
        VarTotalArrears := 0;

        ObjLoanCollateral.Reset;
        ObjLoanCollateral.SetRange(ObjLoanCollateral."Member No", "Member No");
        if ObjLoanCollateral.FindSet then begin
            repeat

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", ObjLoanCollateral."Loan No");
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        VarCollateralSecurity := VarCollateralSecurity + ObjLoanCollateral."Guarantee Value";
                    end;
                end;
            until ObjLoanCollateral.Next = 0;
        end;


        ObjCust.Reset;
        ObjCust.SetRange(ObjCust."No.", "Member No");
        if ObjCust.FindSet then begin
            ObjCust.CalcFields(ObjCust."Total Loans Outstanding");
            if ObjCust."Total Loans Outstanding" > VarCollateralSecurity then begin
                VarLoanRisk := ObjCust."Total Loans Outstanding" - VarCollateralSecurity
            end else
                VarLoanRisk := 0;
        end;
    end;

    local procedure FnGetHouseGroupNetWorth(VarGuarantorNo: Code[30]) VarLoanRisk: Decimal
    var
        VarCollateralSecurity: Decimal;
        ObjLoanCollateral: Record "Loan Collateral Details";
        ObjLoans: Record "Loans Register";
        ObjCust: Record Customer;
    begin
        //-----------------------------------------------------Get Group Networth
        VarCollateralSecurity := 0;


        ObjLoanCollateral.Reset;
        ObjLoanCollateral.SetRange(ObjLoanCollateral."Member No", VarGuarantorNo);
        if ObjLoanCollateral.FindSet then begin
            repeat

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", ObjLoanCollateral."Loan No");
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        VarCollateralSecurity := VarCollateralSecurity + ObjLoanCollateral."Guarantee Value";
                    end;
                end;
            until ObjLoanCollateral.Next = 0;
        end;


        ObjCust.Reset;
        ObjCust.SetRange(ObjCust."No.", VarGuarantorNo);
        if ObjCust.FindSet then begin
            ObjCust.CalcFields(ObjCust."Total Loans Outstanding");
            if ObjCust."Total Loans Outstanding" > VarCollateralSecurity then begin
                VarLoanRisk := ObjCust."Total Loans Outstanding" - VarCollateralSecurity
            end else
                VarLoanRisk := 0;

        end;
    end;
}




