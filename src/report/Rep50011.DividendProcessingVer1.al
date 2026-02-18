report 50011 "Dividend Processing Ver1"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Customer; Customer)
        {

            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }

            trigger OnAfterGetRecord()
            var
                Datefilter2: Text;
            begin
                ShareCapital := 0;
                TotalDeposit := 0;
                InterestOnDeposit := 0;

                // DivProg.Reset();
                // DivProg.SetCurrentKey("Member No");
                // DivProg.SetFilter(DivProg."Member No", Customer."No.");
                // DivProg.SetFilter(Date, '>=%1', CalcDate('-1D', StartDate));
                // if DivProg.Find('-') then
                //     DivProg.DeleteAll();


                Datefilter := '..' + Format(CalcDate('-1D', StartDate));
                Datefilter2 := '..' + FORMAT(CalcDate('CY', StartDate));
                IterationFromDate := Customer."Registration Date";
                IterationToDate := CalcDate('-1D', StartDate);
                DatefilterII := '..' + Format(CalcDate('-1D', StartDate));
                // Datefilter2 := '..' + FORMAT(CalcDate('CY', StartDate));
                IterationFromDateII := Customer."Registration Date";
                IterationToDateII := CalcDate('-1D', StartDate);
                if ProcessDividendIOD then begin
                    Cust.Reset();
                    Cust.SetCurrentKey("No.");
                    Cust.SetRange("No.", Customer."No.");
                    Cust.SetFilter("Date Filter", Datefilter2);
                    //Cust.SetRange("Date Filter", 0D, CalcDate('-CY-1D', Today));
                    IF Cust.Find('-') then begin

                        GenSetup.Get();
                        Cust.CalcFields("Shares Retained");
                        ShareCapital := Round((GenSetup."Dividend (%)" / 100) * Cust."Shares Retained", 0.01, '<');

                        DivProg.Init();
                        DivProg."Member No" := Cust."No.";
                        //DivProg.Date := CalcDate('-CY-1D', Today);
                        DivProg.Date := Today;
                        DivProg."Gross Dividends" := ShareCapital;
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg."Qualifying Share Capital" := Cust."Shares Retained";
                        DivProg."Interest Type" := DivProg."Interest Type"::Dividends;
                        DivProg."Witholding Tax" := 0; // exemption of tax
                        if NOT IsMemberExemptFromTax(Cust."No.") then
                            DivProg."Witholding Tax" := Round(ShareCapital * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');
                        // DivProg."Witholding Tax" := Round(ShareCapital * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');
                        DivProg."Net Dividends" := DivProg."Gross Dividends" - DivProg."Witholding Tax";
                        DivProg."Dividend Withholding Tax" := Round(ShareCapital * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');

                        if DivProg."Qualifying Share Capital" <> 0 then
                            DivProg.Insert(true);
                    end;
                    if GetWithdrawnMembers() = false then
                        for i := 12 DownTo 1 do begin

                            Cust.Reset();
                            Cust.SetCurrentKey("No.");
                            Cust.SetRange("No.", Customer."No.");
                            Cust.SetFilter(Cust."Date Filter", Datefilter);
                            if Cust.Find('-') then begin
                                GenSetup.Get();
                                Cust.CalcFields(Cust."Current Shares");
                                TotalDeposit := Cust."Current Shares";
                                //Message('%1-iteration Value %2', GenSetup."Interest on Deposits (%)", i);
                                InterestOnDeposit := round(TotalDeposit * (GenSetup."Interest on Deposits (%)" / 1200), 0.01, '<');//* i / 12
                                //Message('%1', GenSetup."Interest on Deposits (%)");
                                DivProg.Init();
                                DivProg.Date := IterationToDate;
                                DivProg."Member No" := Cust."No.";
                                DivProg."Gross Interest On Deposit" := InterestOnDeposit;
                                DivProg."Interest Type" := DivProg."Interest Type"::"Interest on Deposit";
                                DivProg."Witholding Tax" := 0; // exemption of tax
                                if NOT IsMemberExemptFromTax(Cust."No.") then
                                    DivProg."Witholding Tax" := Round(InterestOnDeposit * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');

                                //DivProg."Witholding Tax" := Round(InterestOnDeposit * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');
                                DivProg.Shares := TotalDeposit;
                                DivProg."Qualifying Shares" := Round(TotalDeposit * (i / 12), 0.01, '<');
                                DivProg."Net Interest On Deposit" := DivProg."Gross Interest On Deposit" - DivProg."Witholding Tax";
                                DivProg."IOD withholding Tax" := Round(InterestOnDeposit * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');
                                if DivProg."Qualifying Shares" <> 0 then
                                    DivProg.Insert();

                            end;
                            IterationFromDate := CalcDate('1D', IterationToDate);
                            IterationToDate := CalcDate('CM', IterationFromDate);
                            Datefilter := '..' + Format(IterationToDate);
                            //Datefilter := Format(IterationFromDate) + '..' + Format(IterationToDate);
                        end;
                end;

                if ProcessChamaSavings then begin
                    for i := 12 DownTo 1 do begin

                        Cust.Reset();
                        Cust.SetCurrentKey("No.");
                        Cust.SetRange("No.", Customer."No.");
                        Cust.SetFilter(Cust."Date Filter", DatefilterII);
                        Cust.SetAutoCalcFields("Programmed Deposits");
                        if Cust.Find('-') then begin
                            ChamSavingsInterest := 0;
                            ChamaSavings := 0;
                            GenSetup.Get();
                            Cust.CalcFields(Cust."Programmed Deposits");
                            ChamaSavings := Cust."Programmed Deposits";
                            if ChamaSavings <> 0 then
                                //  Message('%1-iteration Value %2', GenSetup."Chama Savings Rate", i);
                                ChamSavingsInterest := round(ChamaSavings * (0.07 / 12), 0.01, '<');
                            DivProg.Init();
                            DivProg.Date := IterationToDateII;
                            DivProg."Member No" := Cust."No.";
                            DivProg."Interest Type" := DivProg."Interest Type"::"Other Interest";
                            DivProg."Gross Interest On Chama Saving" := ChamSavingsInterest;
                            if NOT IsMemberExemptFromTax(Cust."No.") then begin
                                DivProg."Witholding Tax" := Round(ChamSavingsInterest * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');
                            END;
                            DivProg."Chama saving" := ChamaSavings;
                            DivProg.QualifyingChama := Round(ChamaSavings * (i / 12), 0.01, '<');
                            DivProg."Net Interest On Chama" := DivProg."Gross Interest On Chama Saving" - DivProg."Witholding Tax";
                            if NOT IsMemberExemptFromTax(Cust."No.") then begin
                                DivProg."Chama withholding Tax" := Round(ChamSavingsInterest * (GenSetup."Withholding Tax (%)" / 100), 0.01, '<');
                            END;
                            //Message('%1-iteration Value %2 -%3', GenSetup."Chama Savings Rate", i, DivProg.QualifyingChama);
                            if DivProg.QualifyingChama <> 0 then
                                DivProg.Insert();
                            ///  DivProg.Modify();
                        end;
                        IterationFromDateII := CalcDate('1D', IterationToDateII);
                        IterationToDateII := CalcDate('CM', IterationFromDateII);
                        DatefilterII := '..' + Format(IterationToDateII);
                        //Datefilter := Format(IterationFromDate) + '..' + Format(IterationToDate);
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if StartDate = 0D then Error('You must define the start date.');
                if StartDate <> CalcDate('-CY', StartDate) then Error('Start date must be the begining of the year.');
                DivProg.Reset();
                DivProg.SetCurrentKey("Member No");
                //DivProg.SetRange(DivProg."Member No", Customer."No.");
                DivProg.SetFilter(Date, '>=%1', CalcDate('-1D', StartDate));
                if DivProg.Find('-') then
                    DivProg.DeleteAll();
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
                    field(StartDate; StartDate) { ApplicationArea = all; }
                    field(ProcessDividendIOD; ProcessDividendIOD) { ApplicationArea = all; }
                    field(ProcessChamaSavings; ProcessChamaSavings) { ApplicationArea = all; }
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

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/mylayout2.rdl';
        }
    }

    var
        myInt: Integer;
        StartDate: date;

        DivProg: Record "Dividends Progression";

        Cust: Record Customer;

        Datefilter: Text[50];
        DatefilterII: Text[50];
        IterationFromDate: Date;
        IterationToDate: Date;
        IterationToDateII: Date;
        IterationFromDateII: Date;

        GenSetup: Record "Sacco General Set-Up";

        ShareCapital: Decimal;
        ProcessDividendIOD: Boolean;
        ProcessChamaSavings: Boolean;
        ChamaSavings: Decimal;
        ChamSavingsInterest: Decimal;

        i: Integer;
        TotalDeposit: Decimal;
        InterestOnDeposit: Decimal;

    procedure GetWithdrawnMembers() Withdrawn: Boolean;

    var
        Cust: Record Customer;
    //Withdrawn: Boolean;
    begin
        Withdrawn := false;

        // Cust.Reset();
        // Cust.SetRange("No.", Customer."No.");
        // Cust.SetFilter("Date Filter", '..%1', CalcDate('CY', StartDate));
        // Cust.SetAutoCalcFields("Current Shares");
        // IF Cust.Find('-') THEN begin
        //     if Cust."Current Shares" <= 0 then begin
        //         Withdrawn := true;
        //     end;
        // end;
    end;

    procedure IsMemberExemptFromTax(MemberNo: Code[20]): Boolean;
    var
        MemberExempt: Boolean;
    begin
        Cust.Reset();
        Cust.SetRange("No.", MemberNo);
        Cust.SetRange("Exempted From Tax", true);
        if Cust.FindFirst() then
            //     MemberExempt := Cust."Exempted From Tax";
            exit(true);
    end;
}
