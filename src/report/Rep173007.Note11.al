report 173007 "Note 11"
{
UsageCategory = ReportsAndAnalysis;
ApplicationArea = All;
Caption = 'Fixed Assets Report';
DefaultLayout = RDLC;
RdlcLayout = 'Layouts/Note10.rdlc';
dataset
{
    dataitem(ReportHeader; "Company Information")
    {
        column(CompanyName; CompanyInfo.Name) { }
        column(ReportTitle; 'FIXED ASSETS REPORT') { }
        column(AsOfDate; 'As of: ' + Format(AsOfDateParam, 0, '<Day,2>/<Month,2>/<Year4>')) { }
        column(CurrentYearLabel; 'Current Year: ' + Format(Date2DMY(AsOfDateParam, 3))) { }
        column(PreviousYearLabel; 'Previous Year: ' + Format(Date2DMY(AsOfDateParam, 3) - 1)) { }
        column(DateFilter; DateFilterText) { }

        // Table Headers
        column(Header_AccountName; 'Assets') { }
        column(Header_AccountNo; 'Account No.') { }
        column(Header_CurrentYear; Format(Date2DMY(AsOfDateParam, 3))) { }
        column(Header_PreviousYear; Format(Date2DMY(AsOfDateParam, 3) - 1)) { }

        // NON-CURRENT ASSETS SECTION
        column(NonCurrentAssetsSectionTitle; 'NON-CURRENT ASSETS') { }

        // Tangible Fixed Assets
        column(TangibleFixedAssetsTitle; 'TANGIBLE FIXED ASSETS') { }

        // Land Section
        column(Land_No; '101130') { }
        column(Land_Name; 'Land') { }
        column(Land_Current; GetAssetBalance('101130', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(Land_Previous; GetAssetBalance('101130', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(LandCost_No; '101140') { }
        column(LandCost_Name; 'Land') { }
        column(LandCost_Current; GetAssetBalance('101140', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(LandCost_Previous; GetAssetBalance('101140', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(LandRevaluation_No; '101141') { }
        column(LandRevaluation_Name; 'Land Revaluation') { }
        column(LandRevaluation_Current; GetAssetBalance('101141', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(LandRevaluation_Previous; GetAssetBalance('101141', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(LandNbv_No; '101160') { }
        column(LandNbv_Name; 'Land Nbv') { }
        column(LandNbv_Current; GetAssetBalance('101160', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(LandNbv_Previous; GetAssetBalance('101160', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Land Subtotal
        column(LandSubtotal_Name; 'Total Land') { }
        column(LandSubtotal_Current; CalculateLandSubtotal(CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(LandSubtotal_Previous; CalculateLandSubtotal(PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Premises Section
        column(Premises_No; '101170') { }
        column(Premises_Name; 'Premises') { }
        column(Premises_Current; GetAssetBalance('101170', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(Premises_Previous; GetAssetBalance('101170', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(BuildingOfficeSpace_No; '101180') { }
        column(BuildingOfficeSpace_Name; 'Building /Office Space') { }
        column(BuildingOfficeSpace_Current; GetAssetBalance('101180', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(BuildingOfficeSpace_Previous; GetAssetBalance('101180', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(AccDepreciation_No; '101190') { }
        column(AccDepreciation_Name; 'Acc.Depreciation') { }
        column(AccDepreciation_Current; GetAssetBalance('101190', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(AccDepreciation_Previous; GetAssetBalance('101190', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(PremisesNBV_No; '101200') { }
        column(PremisesNBV_Name; 'Premises NBV') { }
        column(PremisesNBV_Current; GetAssetBalance('101200', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(PremisesNBV_Previous; GetAssetBalance('101200', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Premises Subtotal
        column(PremisesSubtotal_Name; 'Total Premises') { }
        column(PremisesSubtotal_Current; CalculatePremisesSubtotal(CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(PremisesSubtotal_Previous; CalculatePremisesSubtotal(PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Furniture & Fitting Section
        column(FurnitureFitting_No; '101210') { }
        column(FurnitureFitting_Name; 'Furniture & Fitting') { }
        column(FurnitureFitting_Current; GetAssetBalance('101210', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(FurnitureFitting_Previous; GetAssetBalance('101210', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(FurnitureFittingCost_No; '101220') { }
        column(FurnitureFittingCost_Name; 'Furniture & Fitting') { }
        column(FurnitureFittingCost_Current; GetAssetBalance('101220', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(FurnitureFittingCost_Previous; GetAssetBalance('101220', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(AccDepreciationFurniture_No; '101230') { }
        column(AccDepreciationFurniture_Name; 'Acc.Depreciation') { }
        column(AccDepreciationFurniture_Current; GetAssetBalance('101230', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(AccDepreciationFurniture_Previous; GetAssetBalance('101230', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(FurnitureFittingNbv_No; '101240') { }
        column(FurnitureFittingNbv_Name; 'Furniture & Fitting Nbv') { }
        column(FurnitureFittingNbv_Current; GetAssetBalance('101240', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(FurnitureFittingNbv_Previous; GetAssetBalance('101240', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Furniture & Fitting Subtotal
        column(FurnitureSubtotal_Name; 'Total Furniture & Fitting') { }
        column(FurnitureSubtotal_Current; CalculateFurnitureSubtotal(CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(FurnitureSubtotal_Previous; CalculateFurnitureSubtotal(PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Office Equipments Section
        column(OfficeEquipments_No; '101241') { }
        column(OfficeEquipments_Name; 'Office Equipments') { }
        column(OfficeEquipments_Current; GetAssetBalance('101241', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(OfficeEquipments_Previous; GetAssetBalance('101241', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(OfficeEquipmentCost_No; '101242') { }
        column(OfficeEquipmentCost_Name; 'Office Equipment Cost') { }
        column(OfficeEquipmentCost_Current; GetAssetBalance('101242', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(OfficeEquipmentCost_Previous; GetAssetBalance('101242', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(AccDepreciationOffice_No; '101245') { }
        column(AccDepreciationOffice_Name; 'Acc.Depreciation') { }
        column(AccDepreciationOffice_Current; GetAssetBalance('101245', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(AccDepreciationOffice_Previous; GetAssetBalance('101245', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(OfficeEquipmentsNbv_No; '101248') { }
        column(OfficeEquipmentsNbv_Name; 'Office Equipments Nbv') { }
        column(OfficeEquipmentsNbv_Current; GetAssetBalance('101248', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(OfficeEquipmentsNbv_Previous; GetAssetBalance('101248', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Office Equipment Subtotal
        column(OfficeEquipSubtotal_Name; 'Total Office Equipment') { }
        column(OfficeEquipSubtotal_Current; CalculateOfficeEquipmentSubtotal(CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(OfficeEquipSubtotal_Previous; CalculateOfficeEquipmentSubtotal(PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Motor Vehicle Section
        column(MotorVehicle_No; '101250') { }
        column(MotorVehicle_Name; 'Motor Vehicle') { }
        column(MotorVehicle_Current; GetAssetBalance('101250', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(MotorVehicle_Previous; GetAssetBalance('101250', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(MotorVehicleCost_No; '101260') { }
        column(MotorVehicleCost_Name; 'Motor Vehicle Cost') { }
        column(MotorVehicleCost_Current; GetAssetBalance('101260', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(MotorVehicleCost_Previous; GetAssetBalance('101260', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(AccDepreciationMotor_No; '101270') { }
        column(AccDepreciationMotor_Name; 'Acc.Depreciation') { }
        column(AccDepreciationMotor_Current; GetAssetBalance('101270', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(AccDepreciationMotor_Previous; GetAssetBalance('101270', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(MotorVehicleNbv_No; '101280') { }
        column(MotorVehicleNbv_Name; 'Motor Vehicle Nbv') { }
        column(MotorVehicleNbv_Current; GetAssetBalance('101280', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(MotorVehicleNbv_Previous; GetAssetBalance('101280', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Motor Vehicle Subtotal
        column(MotorVehicleSubtotal_Name; 'Total Motor Vehicle') { }
        column(MotorVehicleSubtotal_Current; CalculateMotorVehicleSubtotal(CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(MotorVehicleSubtotal_Previous; CalculateMotorVehicleSubtotal(PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Computer & Accessories Section
        column(ComputerAccessories_No; '101290') { }
        column(ComputerAccessories_Name; 'Computer & Accessories') { }
        column(ComputerAccessories_Current; GetAssetBalance('101290', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(ComputerAccessories_Previous; GetAssetBalance('101290', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(ComputerAccessoriesCost_No; '101300') { }
        column(ComputerAccessoriesCost_Name; 'Computer & Accessories') { }
        column(ComputerAccessoriesCost_Current; GetAssetBalance('101300', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(ComputerAccessoriesCost_Previous; GetAssetBalance('101300', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(AccDepreciationComputer_No; '101310') { }
        column(AccDepreciationComputer_Name; 'Acc.Depreciation') { }
        column(AccDepreciationComputer_Current; GetAssetBalance('101310', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(AccDepreciationComputer_Previous; GetAssetBalance('101310', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(ComputerAccessoriesNbv_No; '101320') { }
        column(ComputerAccessoriesNbv_Name; 'Computer & Accessories Nbv') { }
        column(ComputerAccessoriesNbv_Current; GetAssetBalance('101320', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(ComputerAccessoriesNbv_Previous; GetAssetBalance('101320', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Computer & Accessories Subtotal
        column(ComputerSubtotal_Name; 'Total Computer & Accessories') { }
        column(ComputerSubtotal_Current; CalculateComputerSubtotal(CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(ComputerSubtotal_Previous; CalculateComputerSubtotal(PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Loose Tools Section
        column(LooseTools_No; '101330') { }
        column(LooseTools_Name; 'Loose Tools') { }
        column(LooseTools_Current; GetAssetBalance('101330', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(LooseTools_Previous; GetAssetBalance('101330', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(LooseToolsCost_No; '101340') { }
        column(LooseToolsCost_Name; 'Loose Tools') { }
        column(LooseToolsCost_Current; GetAssetBalance('101340', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(LooseToolsCost_Previous; GetAssetBalance('101340', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(AccDepreciationTools_No; '101350') { }
        column(AccDepreciationTools_Name; 'Acc.Depreciation') { }
        column(AccDepreciationTools_Current; GetAssetBalance('101350', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(AccDepreciationTools_Previous; GetAssetBalance('101350', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        column(LooseToolsNbv_No; '101360') { }
        column(LooseToolsNbv_Name; 'Loose Tools Nbv') { }
        column(LooseToolsNbv_Current; GetAssetBalance('101360', CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(LooseToolsNbv_Previous; GetAssetBalance('101360', PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Loose Tools Subtotal
        column(LooseToolsSubtotal_Name; 'Total Loose Tools') { }
        column(LooseToolsSubtotal_Current; CalculateLooseToolsSubtotal(CurrentYearEnd)) { DecimalPlaces = 2:2; }
        column(LooseToolsSubtotal_Previous; CalculateLooseToolsSubtotal(PreviousYearEnd)) { DecimalPlaces = 2:2; }

        // Intangible Assets
         column(Computerization_No; '102060') { }
            column(Computerization_Name; 'Computerization & Software') { }
            column(Computerization_Current; GetAssetBalance('102060', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(Computerization_Previous; GetAssetBalance('102060', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(AccDepreciationComputerization_No; '102060') { }
            column(AccDepreciationComputerization_Name; 'Acc. Depreciation- Computerization') { }
            column(AccDepreciationComputerization_Current; GetAssetBalance('102060', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(AccDepreciationComputerization_Previous; GetAssetBalance('102060', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

            column(ComputerizationNbv_No; '102079') { }
            column(ComputerizationNbv_Name; 'Total Computerization & Software') { }
            column(ComputerizationNbv_Current; GetAssetBalance('102079', CurrentYearEnd)) { DecimalPlaces = 2 : 2; }
            column(ComputerizationNbv_Previous; GetAssetBalance('102079', PreviousYearEnd)) { DecimalPlaces = 2 : 2; }

       


        trigger OnAfterGetRecord()
        begin
            if AsOfDateParam = 0D then
                AsOfDateParam := WorkDate();
            UpdateDateRanges();
        end;
    }
}

requestpage
{
    layout
    {
        area(Content)
        {
            group(Options)
            {
                Caption = 'Report Options';
                field(AsOfDate; AsOfDateParam)
                {
                    ApplicationArea = All;
                    Caption = 'As of Date';
                    ToolTip = 'Enter the date for which you want to run the report. Previous year will be calculated automatically.';

                    trigger OnValidate()
                    begin
                        UpdateDateRanges();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if AsOfDateParam = 0D then
            AsOfDateParam := WorkDate();
        UpdateDateRanges();
    end;
}

var
    AsOfDateParam: Date;
    CurrentYearEnd: Date;
    PreviousYearEnd: Date;
    CurrentYearRangeText: Text;
    PreviousYearRangeText: Text;
    DateFilterText: Text;
    CompanyInfo: Record "Company Information";

local procedure UpdateDateRanges()
begin
    CurrentYearEnd := AsOfDateParam;
    PreviousYearEnd := CalcDate('<-1Y>', AsOfDateParam);

    CurrentYearRangeText := Format(CurrentYearEnd, 0, '<Day,2>/<Month,2>/<Year4>');
    PreviousYearRangeText := Format(PreviousYearEnd, 0, '<Day,2>/<Month,2>/<Year4>');
    DateFilterText := 'Current Year: ' + CurrentYearRangeText + ', Previous Year: ' + PreviousYearRangeText;
end;

local procedure GetAssetBalance(AccountNo: Code[20]; EndDate: Date): Decimal
var
    GLAccount: Record "G/L Account";
    Balance: Decimal;
begin
    if not GLAccount.Get(AccountNo) then
        exit(0);

    GLAccount.SetRange("Date Filter", 0D, EndDate);
    GLAccount.CalcFields("Net Change");
    Balance := GLAccount."Net Change";

    exit(Balance);
end;

// Subtotal calculation procedures
local procedure CalculateLandSubtotal(EndDate: Date): Decimal
begin
    exit(GetAssetBalance('101130', EndDate) +
         GetAssetBalance('101140', EndDate) +
         GetAssetBalance('101141', EndDate) +
         GetAssetBalance('101160', EndDate));
end;

local procedure CalculatePremisesSubtotal(EndDate: Date): Decimal
begin
    exit(GetAssetBalance('101170', EndDate) +
         GetAssetBalance('101180', EndDate) +
         GetAssetBalance('101190', EndDate) +
         GetAssetBalance('101200', EndDate));
end;

local procedure CalculateFurnitureSubtotal(EndDate: Date): Decimal
begin
    exit(GetAssetBalance('101210', EndDate) +
         GetAssetBalance('101220', EndDate) +
         GetAssetBalance('101230', EndDate) +
         GetAssetBalance('101240', EndDate));
end;

local procedure CalculateOfficeEquipmentSubtotal(EndDate: Date): Decimal
begin
    exit(GetAssetBalance('101241', EndDate) +
         GetAssetBalance('101242', EndDate) +
         GetAssetBalance('101245', EndDate) +
         GetAssetBalance('101248', EndDate));
end;

local procedure CalculateMotorVehicleSubtotal(EndDate: Date): Decimal
begin
    exit(GetAssetBalance('101250', EndDate) +
         GetAssetBalance('101260', EndDate) +
         GetAssetBalance('101270', EndDate) +
         GetAssetBalance('101280', EndDate));
end;

local procedure CalculateComputerSubtotal(EndDate: Date): Decimal
begin
    exit(GetAssetBalance('101290', EndDate) +
         GetAssetBalance('101300', EndDate) +
         GetAssetBalance('101310', EndDate) +
         GetAssetBalance('101320', EndDate));
end;

local procedure CalculateLooseToolsSubtotal(EndDate: Date): Decimal
begin
    exit(GetAssetBalance('101330', EndDate) +
         GetAssetBalance('101340', EndDate) +
         GetAssetBalance('101350', EndDate) +
         GetAssetBalance('101360', EndDate));
end;

local procedure CalculateOfficePartitionSubtotal(EndDate: Date): Decimal
begin
    exit(GetAssetBalance('101370', EndDate) +
         GetAssetBalance('101380', EndDate) +
         GetAssetBalance('101390', EndDate) +
         GetAssetBalance('101400', EndDate));
end;
local procedure CalculateTotals(EndDate: Date): Decimal
begin
    exit(GetAssetBalance('101180',EndDate) +
         GetAssetBalance('101220',EndDate) +
         GetAssetBalance('101242',EndDate) +
         GetAssetBalance('101200',EndDate) +
         GetAssetBalance('101340',EndDate) +
         GetAssetBalance('',EndDate) +
         GetAssetBalance('',EndDate) +
         GetAssetBalance('',EndDate));
end;
}