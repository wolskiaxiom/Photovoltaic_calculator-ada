package body how_many_modules is
-- procedure Zapelnij(Tab : in out Irradiance) is
-- begin
--    for E of Tab loop
--       E := 2.0;
--    end loop;
-- end Zapelnij;

procedure GetMinIrradiance(IrTab: In Irradiance; IrVal: Out Float; IrNumberOfDays: Out Float) is
begin
  -- null;
  IrVal := IrTab(1);
  IrNumberOfDays := NumberOfDays(1);
  for I in IrTab'Range loop
  -- for V of IrTab loop
    if IrVal>IrTab(I) then
      IrVal := IrTab(I);
      IrNumberOfDays := NumberOfDays(I);
    end if;
  end loop;
end GetMinIrradiance;

procedure CalculateRequest(ConstUsage: In Float; NumberOfUsers: In Float; UsagePerson: In Float; Request: Out Float) is
begin
  Request := Float(ConstUsage) + Float(NumberOfUsers * UsagePerson);
end CalculateRequest;

procedure CalculateExpectedPowerOfModules(Request: In Float; NumberOfDays:In Float; Cracow_Irradiance: In Float; Directory_Ratio: In Float; PanelEfficiency: In Float; PowerOfModules: Out Float) is
begin
  PowerOfModules := Request * NumberOfDays/ (Cracow_Irradiance/1000.0 * Directory_Ratio * PanelEfficiency);
end CalculateExpectedPowerOfModules;

procedure CalculateNumberOfPanelsInWinter(ExpectedPowerOfModules: In Float; PowerOfModule: In Float; NumberOfModules: Out Float) is
begin
  NumberOfModules := Float'Rounding(ExpectedPowerOfModules/PowerOfModule);
end CalculateNumberOfPanelsInWinter;

procedure CalculateAreaOfPanels(NumberOfPanels: In Float; Area: Out Float) is
begin
  Area := NumberOfPanels*1.1;
end CalculateAreaOfPanels;

procedure CalculateYearUsage(Request: In Float; YearUsage: Out Float) is
begin
  YearUsage := Request * 365.0;
end CalculateYearUsage;

procedure SumYearIrradiance(IrTab: In Irradiance; IrSum: Out Float) is
begin
  IrSum := 0.0;
  for V of IrTab loop
    IrSum := IrSum + V;
  end loop;
end SumYearIrradiance;

procedure SumYearProduction(IrSum: In Float; Directory_Ratio: In Float; NumberOfPanels: In Float; PowerOfModule: In Float; PanelEfficiency: In Float; SumEnergy: Out Float) is
begin
  SumEnergy := IrSum * Directory_Ratio * NumberOfPanels * PowerOfModule * PanelEfficiency/1000.0;
end SumYearProduction;

procedure DifferenceBetweenProductionAndRequest(Production: In Float; Request: In Float; Difference: Out Float) is
begin
  Difference := abs (Production - Request);
end DifferenceBetweenProductionAndRequest;

procedure CalculateWaste(DayUsage: In Float; ConstantDayUsage: In Float; PowerOfAllModules: In Float; TotalWaste: Out Float) is
UsageDuringNight: Float;
UsageDuringDay: Float;
MonthProduction: Float;
MonthWaste: Float;
-- PowerOfAllModules:Float;
begin
  MonthWaste := 0.0;
  TotalWaste:= 0.0;
  -- PowerOfAllModules := NumberOfPanels * PowerOfModule * PanelEfficiency;
  for I in NumberOfDays'Range loop
    UsageDuringNight := (24.0-DurationOfDay(I))*ConstantDayUsage;
    UsageDuringDay := DayUsage - UsageDuringNight;
    MonthProduction := I_Cracow(I) * PowerOfAllModules;
    MonthWaste := MonthProduction - (UsageDuringDay + UsageDuringNight*PriceRatio)* NumberOfDays(I);
    -- TotalWaste :=  DayWaste * NumberOfDays(I);
    TotalWaste := TotalWaste + MonthWaste;
  end loop;
end CalculateWaste;


task type SumProduction is
end SumProduction;
task body SumProduction is
begin
  null;
end SumProduction;




end how_many_modules;
