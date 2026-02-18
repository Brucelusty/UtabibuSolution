page 80068 "Loan Calculator"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Calculator";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ObjCust.Reset;
                        ObjCust.SetRange(ObjCust."No.", Rec."Member No");
                        if ObjCust.Find('-') then begin
                            ObjCust.CalcFields(ObjCust."Total Loans Outstanding", ObjCust."Current Shares");
                            Rec."Total Loans Outstanding" := ObjCust."Total Loans Outstanding";
                            Rec."Member Name" := ObjCust.Name;
                            Rec."Current Deposits" := ObjCust."Current Shares";
                            Rec."Membership Duration(Years)" := ROUND((WorkDate - ObjCust."Registration Date") / 30, 1, '<');
                            Rec."Member House Group" := ObjCust."Member House Group";
                            Rec."Member House Group Name" := ObjCust."Member House Group Name";
                        end;
                    end;

                }
                field("Member Name"; Rec."Member Name") { ApplicationArea = all; Enabled = false; }
                field("Current Deposits"; Rec."Current Deposits") { ApplicationArea = all; Enabled = false; }
                field("Basic Pay"; Rec."Basic Pay") { ApplicationArea = all; Caption = 'Gross Pay'; }

                field("Total Deduction"; Rec."Total Deduction") { ApplicationArea = all; }

                field("Total Loans Outstanding"; Rec."Total Loans Outstanding") { ApplicationArea = all; Enabled = false; }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ObjLoanType.Reset;
                        ObjLoanType.SetRange(ObjLoanType.Code, Rec."Loan Product Type");
                        if ObjLoanType.Find('-') then begin
                            Rec."Interest rate" := ObjLoanType."Interest rate";
                            Rec."Repayment Method" := ObjLoanType."Repayment Method";
                            Rec."Product Description" := ObjLoanType."Product Description";
                            Rec.Installments := ObjLoanType."No of Installment";
                            Rec."Instalment Period" := ObjLoanType."Instalment Period";
                            Rec."Qualification As Per Deposit" := (Rec."Current Deposits" * ObjLoanType."Deposits Multiplier") - Rec."Total Loans Outstanding";
                            Rec."Repayment Frequency" := ObjLoanType."Repayment Frequency";
                            // Message(Format("Qualification As Per Deposit"));
                        end;
                    end;

                }
                field("Product Description"; Rec."Product Description") { ApplicationArea = all; Enabled = false; }

                field(Installments; Rec.Installments)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        LoanProduct.Reset();
                        LoanProduct.SetRange(Code, Rec."Loan Product Type");
                        if LoanProduct.Find('-') then begin
                            if Rec.Installments > LoanProduct."Default Installements" then begin
                                Error('loan maximum duration is %1', LoanProduct."Default Installements");
                            end
                        end;
                    end;
                }
                field("Repayment Method"; Rec."Repayment Method") { ApplicationArea = all; Enabled = false; }
                field("Interest rate"; Rec."Interest rate") { ApplicationArea = all; Enabled = false; }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        LoanProduct.Reset();
                        LoanProduct.SetRange(Code, Rec."Loan Product Type");
                        if LoanProduct.Find('-') then begin
                            if Rec."Requested Amount" > LoanProduct."Max. Loan Amount" then begin
                                Error('loan maximum amount is %1', LoanProduct."Max. Loan Amount");
                            end
                        end;

                        Rec."Qualification As Per Salary" := (Rec."Basic Pay" - Rec."Total Deduction" - Rec."1/3rd") * Rec.Installments;
                        Rec."Qualification As Per Deposit" := (Rec."Current Deposits" * ObjLoanType."Deposits Multiplier") - Rec."Total Loans Outstanding";
                        if ObjLoanType.Get(Rec."Loan Product Type") then begin
                            IF (ObjLoanType."Appraise Deposits") AND (ObjLoanType."Appraise Salary") THEN begin
                                if Rec."Qualification As Per Deposit" < Rec."Qualification As Per Salary" then
                                    Rec."Eligible Amount" := Rec."Qualification As Per Deposit"
                                else
                                    if Rec."Qualification As Per Salary" < Rec."Qualification As Per Deposit" then
                                        Rec."Eligible Amount" := Rec."Qualification As Per Salary";

                                IF Rec."Requested Amount" > Rec."Eligible Amount" THEN begin
                                    Rec."Eligible Amount" := Rec."Eligible Amount";
                                end ELSE begin
                                    Rec."Eligible Amount" := Rec."Requested Amount";
                                end;
                            end;

                            IF ObjLoanType."Appraise Deposits" THEN begin
                                Rec."Eligible Amount" := Rec."Qualification As Per Deposit";
                                IF Rec."Requested Amount" > Rec."Eligible Amount" THEN begin
                                    Rec."Eligible Amount" := Rec."Eligible Amount";
                                end ELSE begin
                                    Rec."Eligible Amount" := Rec."Requested Amount";
                                end;
                            end;
                            IF ObjLoanType."Appraise Salary" THEN begin
                                Rec."Eligible Amount" := Rec."Qualification As Per Salary";
                                IF Rec."Requested Amount" > Rec."Eligible Amount" THEN begin
                                    Rec."Eligible Amount" := Rec."Eligible Amount";
                                end ELSE begin
                                    Rec."Eligible Amount" := Rec."Requested Amount";
                                end;
                            end;
                        end;


                    end;
                }

                field("Principle Repayment"; Rec."Principle Repayment") { ApplicationArea = all; Enabled = false; }
                field("Interest Repayment"; Rec."Interest Repayment") { ApplicationArea = all; Enabled = false; }
                field("Total Monthly Repayment"; Rec."Total Monthly Repayment") { ApplicationArea = all; Enabled = false; }
                field("Repayment Start Date"; Rec."Repayment Start Date") { ApplicationArea = all; }
                field("Instalment Period"; Rec."Instalment Period") { ApplicationArea = all; Enabled = false; }
            }
            group("Qualification Analysis")
            {

                field("Qualification As Per Deposit"; Rec."Qualification As Per Deposit") { ApplicationArea = all; Enabled = false; }
                field("Qualification As Per Salary"; Rec."Qualification As Per Salary") { ApplicationArea = all; Enabled = false; }
                field("2/3rds"; Rec."2/3rds") { ApplicationArea = all; Enabled = false; }
                field("1/3rd"; Rec."1/3rd") { ApplicationArea = all; Enabled = false; }
                field("Eligible Amount"; Rec."Eligible Amount") { ApplicationArea = all; Enabled = false; }


            }

        }
    }
    actions
    {
        area(Processing)
        {
            action(ViewSchedule)
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = basic;
                trigger OnAction()
                var
                    LoanCalculator: Record "Loan Calculator";

                begin
                    GenerateSchedule(Rec."Member No", Rec."Loan Product Type", Rec."Entry No");
                    LoanCalculator.Reset();
                    LoanCalculator.SetRange("Member No", Rec."Member No");
                    LoanCalculator.SetRange("Entry No", Rec."Entry No");
                    LoanCalculator.SetRange("Loan Product Type", Rec."Loan Product Type");
                    if LoanCalculator.Find('-') then begin
                        Report.Run(50035, true, false, LoanCalculator);
                    end;
                end;
            }
        }
    }



    var
        myInt: Integer;
        ObjCust: Record Customer;
        LoanProduct: Record "Loan Products Setup";
        ObjLoanType: Record "Loan Products Setup";
        LoanCalculator: Record "Loan Calculator";
        LoanScheduleCal: Record "Loan Repay Schedule-Calc";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;


    procedure GenerateSchedule(MemberNo: Code[200]; LoanCategory: Code[200]; EntryNo: Integer)
    begin
        LoanScheduleCal.RESET;
        // LoanScheduleCal.SETRANGE(LoanScheduleCal."Member No.", MemberNo);
        // LoanScheduleCal.SetRange("Loan Category", LoanCategory);
        if LoanScheduleCal.Find('-') then begin
            LoanScheduleCal.DELETEALL;
        end;

        if ObjLoanType.Get(Rec."Loan Product Type") then begin
            IF (ObjLoanType."Appraise Deposits") AND (ObjLoanType."Appraise Salary") THEN begin
            
                if Rec."Qualification As Per Deposit" < Rec."Qualification As Per Salary" then
                    Rec."Eligible Amount" := Rec."Qualification As Per Deposit"
                else
                    if Rec."Qualification As Per Salary" < Rec."Qualification As Per Deposit" then
                        Rec."Eligible Amount" := Rec."Qualification As Per Salary";

                IF Rec."Requested Amount" > Rec."Eligible Amount" THEN begin
                    Rec."Eligible Amount" := Rec."Eligible Amount";
                end ELSE begin
                    Rec."Eligible Amount" := Rec."Requested Amount";
                end;
                  Rec.Modify(true);
            end;

            IF (ObjLoanType."Appraise Deposits") and (ObjLoanType."Appraise Salary"= false) THEN begin
                
                Rec."Eligible Amount" := Rec."Qualification As Per Deposit";
                IF Rec."Requested Amount" > Rec."Eligible Amount" THEN begin
                    Rec."Eligible Amount" := Rec."Eligible Amount";
                end ELSE begin
                    Rec."Eligible Amount" := Rec."Requested Amount";
                end;
            end;
            IF (ObjLoanType."Appraise Salary") and (ObjLoanType."Appraise Deposits"= false) THEN begin
              
                Rec."Eligible Amount" := Rec."Qualification As Per Salary";
                IF Rec."Requested Amount" > Rec."Eligible Amount" THEN begin
                    Rec."Eligible Amount" := Rec."Eligible Amount";
                end ELSE begin
                    Rec."Eligible Amount" := Rec."Requested Amount";
                end;
                  Rec.Modify(true);
            end;
          
        end;

        LoanCalculator.RESET;
        LoanCalculator.SetCurrentKey("Entry No");
        LoanCalculator.SETRANGE(LoanCalculator."Member No", MemberNo);
        LoanCalculator.SetRange(LoanCalculator."Loan Product Type", LoanCategory);
        LoanCalculator.SetRange("Entry No", EntryNo);
        LoanCalculator.SETFILTER(LoanCalculator."Requested Amount", '>%1', 0);
        IF LoanCalculator.FIND('-') THEN BEGIN

            IF (LoanCalculator."Repayment Start Date" <> 0D) THEN BEGIN

                LoanCalculator.TESTFIELD(LoanCalculator."Repayment Start Date");




                LoanAmount := LoanCalculator."Eligible Amount";
                InterestRate := LoanCalculator."Interest rate";

                RepayPeriod := LoanCalculator.Installments;
                InitialInstal := LoanCalculator.Installments + LoanCalculator."Grace Period - Principle (M)";

                LBalance := LoanCalculator."Eligible Amount";
                RunDate := LoanCalculator."Repayment Start Date";
                InstalNo := 0;
                LoanAmount := LoanCalculator."Eligible Amount";




                IF LoanCalculator."Repayment Frequency" = LoanCalculator."Repayment Frequency"::Daily THEN
                    RunDate := CALCDATE('-1D', RunDate)
                ELSE
                    IF LoanCalculator."Repayment Frequency" = LoanCalculator."Repayment Frequency"::Weekly THEN
                        RunDate := CALCDATE('-1W', RunDate)
                    ELSE
                        IF LoanCalculator."Repayment Frequency" = LoanCalculator."Repayment Frequency"::Monthly THEN
                            RunDate := CALCDATE('-1M', RunDate)
                        ELSE
                            IF LoanCalculator."Repayment Frequency" = LoanCalculator."Repayment Frequency"::Quaterly THEN
                                RunDate := CALCDATE('-1Q', RunDate);



                REPEAT
                    InstalNo := InstalNo + 1;

                    IF LoanCalculator."Repayment Frequency" = LoanCalculator."Repayment Frequency"::Daily THEN
                        RunDate := CALCDATE('1D', RunDate)
                    ELSE
                        IF LoanCalculator."Repayment Frequency" = LoanCalculator."Repayment Frequency"::Weekly THEN
                            RunDate := CALCDATE('1W', RunDate)
                        ELSE
                            IF LoanCalculator."Repayment Frequency" = LoanCalculator."Repayment Frequency"::Monthly THEN
                                RunDate := CALCDATE('1M', RunDate)
                            ELSE
                                IF LoanCalculator."Repayment Frequency" = LoanCalculator."Repayment Frequency"::Quaterly THEN
                                    RunDate := CALCDATE('1Q', RunDate);

                    IF LoanCalculator."Repayment Method" = LoanCalculator."Repayment Method"::Amortised THEN BEGIN
                        LoanCalculator.TESTFIELD(LoanCalculator.Installments);


                        TotalMRepay := ROUND((InterestRate / 100) / (1 - POWER((1 + (InterestRate / 100)), -RepayPeriod)) * LoanAmount, 1, '=');


                        LInterest := ROUND(LBalance / 100 * InterestRate, 0.1, '=');


                        if InterestRate = 0 then begin
                            LInterest := 0
                        end else
                            LInterest := ROUND(LBalance / 100 * InterestRate, 0.1, '>');
                        LPrincipal := TotalMRepay - LInterest;
                        if InstalNo = LoanCalculator.Installments then begin
                            if LPrincipal < LBalance then begin
                                LPrincipal := LBalance
                            end else begin
                                LPrincipal := LPrincipal
                            end;
                            if LPrincipal > LBalance then begin
                                LPrincipal := LBalance
                            end else begin
                                LPrincipal := LPrincipal
                            end;
                        end;
                    END;

                    IF LoanCalculator."Repayment Method" = LoanCalculator."Repayment Method"::"Straight Line" THEN BEGIN
                        LoanCalculator.TESTFIELD(LoanCalculator.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 1200) * LoanAmount / RepayPeriod;
                    END;

                    IF LoanCalculator."Repayment Method" = LoanCalculator."Repayment Method"::"Reducing Balance" THEN BEGIN
                        LoanCalculator.TESTFIELD(LoanCalculator.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := Round((InterestRate / 1200) * LBalance, 1, '>');
                    END;
                    IF LoanCalculator."Repayment Method" = LoanCalculator."Repayment Method"::Amortised THEN BEGIN
                        LoanCalculator.TESTFIELD(LoanCalculator.Installments);
                        TotalMRepay := ROUND((InterestRate / 1200) / (1 - POWER((1 + (InterestRate / 1200)), -(RepayPeriod))) * (LoanAmount), 1, '>');


                        LInterest := ROUND(LBalance / 1200 * InterestRate, 1, '>');

                        LPrincipal := TotalMRepay - LInterest;
                    END;


                    IF LoanCalculator."Repayment Method" = LoanCalculator."Repayment Method"::Constants THEN BEGIN
                        LoanCalculator.TESTFIELD(LoanCalculator.Repayment);
                        IF LBalance < LoanCalculator.Repayment THEN
                            LPrincipal := LBalance
                        ELSE
                            LPrincipal := LoanCalculator.Repayment;
                        LInterest := LoanCalculator."Interest rate";
                    END;
                    if LPrincipal > LBalance then
                        LPrincipal := LBalance;
                    LBalance := LBalance - LPrincipal;
                    EVALUATE(RepayCode, FORMAT(InstalNo));


                    LoanScheduleCal.INIT;
                    LoanScheduleCal."Repayment Code" := RepayCode;
                    LoanScheduleCal."Interest Rate" := InterestRate;
                    LoanScheduleCal."Loan No." := LoanCalculator."Member No";
                    LoanScheduleCal."Loan Amount" := LoanAmount;
                    LoanScheduleCal."Instalment No" := InstalNo;
                    LoanScheduleCal."Repayment Date" := RunDate;
                    LoanScheduleCal."Member No." := LoanCalculator."Member No";
                    LoanScheduleCal."Loan Category" := LoanCalculator."Loan Product Type";
                    LoanScheduleCal."Monthly Repayment" := LInterest + LPrincipal;
                    LoanScheduleCal."Monthly Interest" := LInterest;
                    LoanScheduleCal."Principal Repayment" := LPrincipal;
                    LoanScheduleCal."Loan Balance" := LBalance;
                    LoanScheduleCal.INSERT;


                    WhichDay := DATE2DWY(LoanScheduleCal."Repayment Date", 1);
                UNTIL LBalance < 1

            END;
        END;

        COMMIT;



    end;
}