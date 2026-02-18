//<---------------------------------------------------------------------->															
Report 80017 "RETURN ON INVESTMENT."
{
    // RDLCLayout = 'Layouts/RETURNONINVESTMENT..rdlc';															
    // DefaultLayout = RDLC;		
    ExcelLayout = 'Layouts/RETURNONINVESTMENT.xlsx';
    DefaultLayout = Excel;

    dataset
    {
        dataitem(Company; "Company Information")
        {

            column(AsAt; AsAt)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(FinancialYear; FinancialYear)
            {
            }
            column(name; Company.Name)
            {
            }
            column(CoreCapital; CoreCapital)
            {
            }
            column(TotalAssets; TotalAssets)
            {
            }
            column(TotalDeposits; TotalDeposits)
            {
            }
            column(Nonearningassets; Nonearningassets)
            {
            }
            column(FinancialAssets; FinancialAssets)
            {
            }
            column(SubsidiaryandRelated; SubsidiaryandRelated)
            {
            }
            column(Equityinvestment; Equityinvestment)
            {
            }
            column(Otherinvestments; Otherinvestments)
            {
            }
            column(LandBuilding; LandBuilding)
            {
            }
            column(OtherassetsLandBuilding; OtherassetsLandBuilding)
            {
            }
            column(LandBuildingstoAssetsRatio; LandBuildingstoAssetsRatio)
            {
            }
            column(MaxLandBuildingtoAssetrequirement; MaxLandBuildingtoAssetrequirement)
            {
            }
            column(Excessdeficiency2; Excessdeficiency2)
            {
            }
            column(FinancialinvestmentstoCorecapital; FinancialinvestmentstoCorecapital)
            {
            }
            column(MaximumfinancialinvestmentstoCorecapital; MaximumfinancialinvestmentstoCorecapital)
            {
            }
            column(ExcessCoreCapital; ExcessCoreCapital)
            {
            }
            column(EquityinvestmentstoCoreCapitalRatio; EquityinvestmentstoCoreCapitalRatio)
            {
            }
            column(MaxfinancialinvestmentstoTotalDepositsliablitiesRatio; MaxfinancialinvestmentstoTotalDepositsliablitiesRatio)
            {
            }
            column(ExcessEquity; ExcessEquity)
            {
            }
            column(SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio; SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio)
            {
            }
            column(MaximumSubsidiaryinvestmenttoTotalassetsRatio; MaximumSubsidiaryinvestmenttoTotalassetsRatio)
            {
            }
            column(ExcessSubsidiary; ExcessSubsidiary)
            {
            }
            column(OtherinvestmentstoCoreCapitalRatio; OtherinvestmentstoCoreCapitalRatio)
            {
            }
            column(MaximumOtherinvestmentstoCoreCapital; MaximumOtherinvestmentstoCoreCapital)
            {
            }
            column(ExcessOtherInvestment; ExcessOtherInvestment)
            {
            }
            column(MaxLandBuildingtoAssetrequirementNew; MaxLandBuildingtoAssetrequirementNew)
            {
            }
            column(LandBuildingEquipmentNew; LandBuildingEquipmentNew)
            {
            }
            column(Excessdeficiency3; Excessdeficiency3)
            {
            }
            trigger OnAfterGetRecord();
            begin
                //CoreCapital															
                CoreCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::Core_Capital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            CoreCapital += GLEntry.Amount * -1;
                        end
                    until GLAccount.Next = 0;
                    // MESSAGE('%1',CoreCapital)															
                end;
                //Nonearningassets															
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)New", '%1', GLAccount."form2e(investment)new"::Nonearningassets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Nonearningassets += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;
                //LandBuilding															
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)Land", '%1', GLAccount."form2e(investment)land"::LandBuilding);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LandBuilding += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;

                //total assets															
                TotalAssets := 0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '499999');
                GLAccount.SetFilter(GLAccount."Date Filter", DateFilter);
                GLAccount.SetAutocalcFields("Net Change");
                if GLAccount.FindSet then begin
                    repeat
                        TotalAssets += GLAccount."Net Change"
                      until GLAccount.Next = 0;
                end;

                //deposits															
                TotalDeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::totaldeposits);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalDeposits += GLEntry.Amount * -1;
                        end
                    until GLAccount.Next = 0;
                end;

                //SubsidiaryandRelated															
                SubsidiaryandRelated := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::subsidiaryandrelatedentities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            SubsidiaryandRelated += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;

                //Equityinvestment															
                Equityinvestment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::Equityinvestment);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Equityinvestment += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;

                //Otherinvestments
                Otherinvestments := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::Otherinvestments);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherinvestments += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;

                //other asssets															
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::otherassets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherassetsLandBuilding += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;

                //MESSAGE('%1',CoreCapital);															
                FinancialAssets := Equityinvestment + SubsidiaryandRelated + Otherinvestments;
                LandBuildingEquipmentNew := OtherassetsLandBuilding / TotalAssets;
                LandBuildingstoAssetsRatio := LandBuilding / TotalAssets;

                MaxLandBuildingtoAssetrequirement := 0.1;
                MaxLandBuildingtoAssetrequirementNew := 0.05;
                Excessdeficiency2 := LandBuildingEquipmentNew - MaxLandBuildingtoAssetrequirement;
                Excessdeficiency3 := LandBuildingstoAssetsRatio - MaxLandBuildingtoAssetrequirementNew;
                FinancialinvestmentstoCorecapital := FinancialAssets / CoreCapital;
                MaximumfinancialinvestmentstoCorecapital := 0.4;
                ExcessCoreCapital := FinancialinvestmentstoCorecapital - MaximumfinancialinvestmentstoCorecapital;
                EquityinvestmentstoCoreCapitalRatio := Equityinvestment / CoreCapital;
                MaxfinancialinvestmentstoTotalDepositsliablitiesRatio := 0.2;
                ExcessEquity := EquityinvestmentstoCoreCapitalRatio - MaxfinancialinvestmentstoTotalDepositsliablitiesRatio;
                SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio := SubsidiaryandRelated / CoreCapital;
                MaximumSubsidiaryinvestmenttoTotalassetsRatio := 0.5;
                ExcessSubsidiary := SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio - MaximumSubsidiaryinvestmenttoTotalassetsRatio;
                OtherinvestmentstoCoreCapitalRatio := Otherinvestments / CoreCapital;
                MaximumOtherinvestmentstoCoreCapital := 0.3;
                ExcessOtherInvestment := OtherinvestmentstoCoreCapitalRatio - MaximumOtherinvestmentstoCoreCapital;
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
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'As At';
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
        StartDate := CalcDate('-CY', AsAt);
        FinancialYear := Date2dmy(StartDate, 3);
        DateFilter := '..' + Format(AsAt);
        ;

    end;

    var
        AsAt: Date;
        StartDate: Date;
        FinancialYear: Integer;
        CoreCapital: Decimal;
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        DateFilter: Text;
        TotalAssets: Decimal;
        TotalDeposits: Decimal;
        Nonearningassets: Decimal;
        FinancialAssets: Decimal;
        SubsidiaryandRelated: Decimal;
        Equityinvestment: Decimal;
        Otherinvestments: Decimal;
        LandBuilding: Decimal;
        OtherassetsLandBuilding: Decimal;
        FinancialAssets1: Decimal;
        LandBuildingstoAssetsRatio: Decimal;
        MaxLandBuildingtoAssetrequirement: Decimal;
        Excessdeficiency2: Decimal;
        FinancialinvestmentstoCorecapital: Decimal;
        MaximumfinancialinvestmentstoCorecapital: Decimal;
        ExcessCoreCapital: Decimal;
        EquityinvestmentstoCoreCapitalRatio: Decimal;
        MaxfinancialinvestmentstoTotalDepositsliablitiesRatio: Decimal;
        ExcessEquity: Decimal;
        SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio: Decimal;
        MaximumSubsidiaryinvestmenttoTotalassetsRatio: Decimal;
        ExcessSubsidiary: Decimal;
        OtherinvestmentstoCoreCapitalRatio: Decimal;
        MaximumOtherinvestmentstoCoreCapital: Decimal;
        ExcessOtherInvestment: Decimal;
        MaxLandBuildingtoAssetrequirementNew: Decimal;
        LandBuildingEquipmentNew: Decimal;
        Excessdeficiency3: Decimal;

    var

}


