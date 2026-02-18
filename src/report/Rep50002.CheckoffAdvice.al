report 50002 "CheckoffAdvice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Generate Prd Invoice';
    //DefaultRenderingLayout = LayoutName;
    ExcelLayout = 'Layouts/CheckoffAdvice.xlsx';
    DefaultLayout = Excel;
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "Employer Code";
            //DataItemTableView = where("Outstanding Balance" = filter(> 0));

            column(Payroll_No; "Payroll No") { }
            column(No_; "No.")
            { }
            column(Name; Name) { }

            column(RegistrationFee; RegistrationFee) { }

            column(ShareCapital; ShareCapital) { }
            column(MemberDepositContrib; MemberDepositContrib) { }
            column(DevelopmentPrinciple; DevelopmentPrinciple)
            {

            }
            column(DevelopmentInterest; DevelopmentInterest)
            {

            }
            column(NormalPrinciple; NormalPrinciple)
            {

            }
            column(NormalInterest; NormalInterest)
            {

            }
            column(EmegencyP; EmegencyP) { }
            column(EmergencyI; EmergencyI) { }
            column(SchoolP; SchoolP) { }
            column(SchoolI; SchoolI) { }
            column(SuperSaverP; SuperSaverP)
            {

            }
            column(SuperSaverI; SuperSaverI)
            {

            }
            column(SpecialLoanP; SpecialLoanP) { }
            column(SpecialLoanI; SpecialLoanI) { }
            column(householdeP; householdeP) { }
            column(houseHoldeI; houseHoldeI) { }
            column(DefaulterP; DefaulterP)
            {

            }
            column(DefaulterI; DefaulterI)
            {


            }
            column(salaryAdvanceP; salaryAdvanceP) { }
            column(SalaryAdvanceI; SalaryAdvanceI) { }
            column(MavunoP; MavunoP) { }

            column(MavunoI; MavunoI) { }




            column(dhamanaP; dhamanaP) { }
            column(DhamanaI; DhamanaI) { }
            column(PremiumP; PremiumP) { }
            column(PremiumI; PremiumI) { }
            column(harakaP; harakaP) { }
            column(harakaI; harakaI) { }


            column(JumboP; JumboP) { }
            column(JumboI; JumboI) { }






            column(Dependand1; Dependand1) { }
            column(Dependand2; Dependand2) { }
            column(Dependand3; Dependand3) { }
            column(HolidaySavings; HolidaySavings) { }
            column(UtafitiHousing; UtafitiHousing) { }
            column(TotalSum; TotalSum) { }

            trigger OnAfterGetRecord()
            begin
                DevelopmentInterest := 0;
                DevelopmentPrinciple := 0;
                NormalInterest := 0;
                NormalPrinciple := 0;
                SuperSaverI := 0;
                SuperSaverP := 0;
                DefaulterI := 0;
                DefaulterP := 0;
                SalaryAdvanceI := 0;
                salaryAdvanceP := 0;
                DhamanaI := 0;
                dhamanaP := 0;
                EmegencyP := 0;
                EmergencyI := 0;
                houseHoldeI := 0;
                householdeP := 0;
                harakaI := 0;
                harakaP := 0;
                JumboI := 0;
                JumboP := 0;
                MavunoP := 0;
                MavunoI := 0;
                PremiumP := 0;
                PremiumI := 0;
                SchoolP := 0;
                SchoolI := 0;
                SpecialLoanP := 0;
                SpecialLoanI := 0;
                MemberDepositContrib := 0;
                UtafitiHousing := 0;
                HolidaySavings := 0;
                ShareCapital := 0;
                Dependand1 := 0;
                Dependand2 := 0;
                Dependand3 := 0;
                RegistrationFee := 0;
                TotalSum := 0;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'DEV');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    DevelopmentInterest := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        DevelopmentPrinciple := LoansRegister."Outstanding Balance"
                    end ELSE
                        DevelopmentPrinciple := LoansRegister."Loan Principle Repayment";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        DevelopmentPrinciple := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                        //DevelopmentInterest := Shedule."Monthly Interest";
                    end;

                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'NORMAL');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    NormalInterest := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        NormalPrinciple := LoansRegister."Outstanding Balance"
                    END ELSE
                        NormalPrinciple := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                 
                    end;
                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'SUPER SAVER');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    SuperSaverI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        SuperSaverP := LoansRegister."Outstanding Balance"
                    END ELSE
                        SuperSaverP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        //SuperSaverP := LoansRegister."Loan Principle Repayment";
                        //SuperSaverI := Shedule."Monthly Interest";
                    end;
                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'DEFAULT');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin

                    LoansRegister.CalcFields("Outstanding Balance");
                    DefaulterI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        DefaulterP := LoansRegister."Outstanding Balance"
                    END ELSE
                        DefaulterP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        //DefaulterP := Shedule."Monthly Interest";
                        //DefaulterI := LoansRegister."Loan Principle Repayment";
                    end;
                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'ADVANCE');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    SalaryAdvanceI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        salaryAdvanceP := LoansRegister."Outstanding Balance"
                    END ELSE
                        salaryAdvanceP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin

                        //SalaryAdvanceI := Shedule."Monthly Interest";
                    end;
                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'DHAMANA');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    DhamanaI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        dhamanaP := LoansRegister."Outstanding Balance"
                    END ELSE
                        dhamanaP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        //dhamanaP := LoansRegister."Loan Principle Repayment";
                        // DhamanaI := LoansRegister."Loan Principle Repayment";
                    end;
                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'EM');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    EmergencyI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        EmegencyP := LoansRegister."Outstanding Balance"
                    END ELSE
                        EmegencyP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        //EmegencyP := LoansRegister."Loan Principle Repayment";
                        //EmergencyI := Shedule."Monthly Interest";
                    end;
                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'HARAKA');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    harakaI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        harakaP := LoansRegister."Outstanding Balance"
                    END ELSE
                        harakaP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        //harakaP := LoansRegister."Loan Principle Repayment";
                        //harakaI := Shedule."Monthly Interest";
                    end;
                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'HOUSEHOLD');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    houseHoldeI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        householdeP := LoansRegister."Outstanding Balance"
                    END ELSE
                        householdeP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        //householdeP := LoansRegister."Loan Principle Repayment";
                        //houseHoldeI := Shedule."Monthly Interest";
                    end;

                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'JUMBO');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    JumboI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        JumboP := LoansRegister."Outstanding Balance"
                    END ELSE
                        JumboP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        // JumboP := LoansRegister."Loan Principle Repayment";
                        //JumboI := Shedule."Monthly Interest";
                    end;
                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'MAVUNO');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    MavunoI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        MavunoP := LoansRegister."Outstanding Balance"
                    END ELSE
                        MavunoP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        // MavunoP := LoansRegister."Loan Principle Repayment";
                        //MavunoI := Shedule."Monthly Interest";
                    end;
                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'PREMIUM');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    PremiumI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        PremiumP := LoansRegister."Outstanding Balance"
                    END ELSE
                        PremiumP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        //PremiumP := LoansRegister."Loan Principle Repayment";
                        // PremiumI := Shedule."Monthly Interest";
                    end;
                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'SCHOOL');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    SchoolI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        SchoolP := LoansRegister."Outstanding Balance"
                    END ELSE
                        SchoolP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        //SchoolP := LoansRegister."Loan Principle Repayment";
                        // SchoolI := Shedule."Monthly Interest";
                    end;
                end;
                LoansRegister.Reset();
                LoansRegister.SetRange(LoansRegister."Loan Product Type", 'SPECIAL');
                LoansRegister.SetRange("Client Code", "No.");
                // LoansRegister.SetRange("Loan  No.", "Loan  No.");
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutoCalcFields("Schedule Interest");
                if LoansRegister.Find('-') then begin
                    LoansRegister.CalcFields("Outstanding Balance");
                    SpecialLoanI := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Outstanding Balance", 1, '=');
                    IF LoansRegister."Loan Principle Repayment" > LoansRegister."Outstanding Balance" THEN begin
                        SpecialLoanP := LoansRegister."Outstanding Balance"
                    END ELSE
                        SpecialLoanP := LoansRegister."Loan Principle Repayment" + LoansRegister."Principle Amount Updated";
                    Shedule.Reset();
                    Shedule.SetRange(Shedule."Loan No.", LoansRegister."Loan  No.");
                    Shedule.SetFilter(Shedule."Repayment Date", '..%1', CalcDate('-CM', Today));
                    if Shedule.FindLast() then begin
                        //SpecialLoanP := LoansRegister."Loan Principle Repayment";
                        //SpecialLoanI := Shedule."Monthly Interest";
                    end;
                end;

                MemberSavings.Reset();
                MemberSavings.SetRange(MemberNo, "No.");
                MemberSavings.SetRange(Type, MemberSavings.Type::"Deposit Contribution");
                if MemberSavings.Find('-') then begin
                    MemberDepositContrib := MemberSavings.Amount;
                end;
                MemberSavings.Reset();
                MemberSavings.SetRange(MemberNo, "No.");
                MemberSavings.SetRange(Type, MemberSavings.Type::"Dependant 1 Savings");
                if MemberSavings.Find('-') then begin
                    Dependand1 := MemberSavings.Amount;
                end;
                MemberSavings.Reset();
                MemberSavings.SetRange(MemberNo, "No.");
                MemberSavings.SetRange(Type, MemberSavings.Type::"Dependant 2 Savings");
                if MemberSavings.Find('-') then begin
                    Dependand2 := MemberSavings.Amount;
                end;
                MemberSavings.Reset();
                MemberSavings.SetRange(MemberNo, "No.");
                MemberSavings.SetRange(Type, MemberSavings.Type::"Dependant 3 Savings");
                if MemberSavings.Find('-') then begin
                    Dependand3 := MemberSavings.Amount;
                end;
                MemberSavings.Reset();
                MemberSavings.SetRange(MemberNo, "No.");
                MemberSavings.SetRange(Type, MemberSavings.Type::"Holiday Savings");
                if MemberSavings.Find('-') then begin
                    HolidaySavings := MemberSavings.Amount;
                end;
                MemberSavings.Reset();
                MemberSavings.SetRange(MemberNo, "No.");
                MemberSavings.SetRange(Type, MemberSavings.Type::"Registration Fee");
                if MemberSavings.Find('-') then begin
                    RegistrationFee := MemberSavings.Amount;
                end;
                MemberSavings.Reset();
                MemberSavings.SetRange(MemberNo, "No.");
                MemberSavings.SetRange(Type, MemberSavings.Type::"Share Capital");
                if MemberSavings.Find('-') then begin
                    ShareCapital := MemberSavings.Amount;
                end;
                MemberSavings.Reset();
                MemberSavings.SetRange(MemberNo, "No.");
                MemberSavings.SetRange(Type, MemberSavings.Type::"Utafiti Housing");
                if MemberSavings.Find('-') then begin
                    UtafitiHousing := MemberSavings.Amount;
                end;
                TotalSum := DefaulterI + DefaulterP + Dependand1 + Dependand3 + Dependand2 + DevelopmentInterest + DevelopmentPrinciple + NormalInterest + NormalPrinciple + RegistrationFee + MemberDepositContrib + ShareCapital + UtafitiHousing + HolidaySavings + houseHoldeI + householdeP +
                EmegencyP + EmergencyI + SalaryAdvanceI + salaryAdvanceP + SpecialLoanI + SpecialLoanP + SchoolI + SchoolP + PremiumI + PremiumP + MavunoI + MavunoP + JumboI + JumboP + SuperSaverI + SuperSaverP + harakaI + harakaP;
                //if TotalSum= 0 then CurrReport.Skip();
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

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        myInt: Integer;
        LoansRegister: Record "Loans Register";
        MemberRegister: Record "Members Register";
        Shedule: Record "Loan Repayment Schedule";
        MemberDepositContrib: Decimal;
        DevelopmentPrinciple: Decimal;
        DevelopmentInterest: Decimal;
        NormalPrinciple: Decimal;
        NormalInterest: Decimal;
        SuperSaverP: Decimal;
        SuperSaverI: Decimal;
        DefaulterP: Decimal;
        DefaulterI: Decimal;
        salaryAdvanceP: Decimal;
        SalaryAdvanceI: Decimal;
        dhamanaP: Decimal;
        DhamanaI: Decimal;
        EmegencyP: Decimal;

        EmergencyI: Decimal;
        harakaP: Decimal;
        harakaI: Decimal;

        householdeP: Decimal;
        houseHoldeI: Decimal;
        JumboP: Decimal;
        JumboI: Decimal;
        MavunoP: Decimal;
        MavunoI: Decimal;
        PremiumP: Decimal;
        PremiumI: Decimal;

        SchoolP: Decimal;
        SchoolI: Decimal;

        SpecialLoanP: Decimal;
        SpecialLoanI: Decimal;

        UtafitiHousing: Decimal;
        HolidaySavings: Decimal;
        Dependand1: Decimal;

        Dependand2: Decimal;

        Dependand3: Decimal;

        RegistrationFee: Decimal;
        ShareCapital: Decimal;

        TotalSum: Decimal;

        MemberSavings: Record MemberSavings;


}