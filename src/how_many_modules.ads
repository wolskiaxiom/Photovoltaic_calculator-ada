package how_many_modules is
  type Irradiance is array (1..12) of Float;
  type NumberOfDaysInMonth is array(1..12) of Float;
  type DurationOfDayInMonth is array(1..12) of Float;
  -- type Degrees is (0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90);
  type WspKor is array (1..19, 1..19) of Float;
  NumberOfDays: NumberOfDaysInMonth := (31.0, 28.0, 31.0, 30.0, 31.0, 30.0, 31.0, 31.0, 30.0, 31.0, 30.0, 31.0);
  DurationOfDay: DurationOfDayInMonth := (8.35, 9.97, 11.92, 13.97, 15.75, 16.68, 16.18, 14.58, 12.62, 10.60, 8.77, 7.7);
  I_Cracow: Irradiance := (27217.0, 37262.0, 66879.0, 107159.0, 160845.0, 162168.0, 155488.0, 130632.0, 87335.0, 54470.0, 30835.0, 25242.0);
  -- Directory_Ratio: Float;
  -- NumberOfUsers : Float;
  ConstantUsage : constant Float := 7.2;
  UsagePerPerson: constant Float := 1.25;
  PriceRatio: constant Float := 1.25;
  -- Request: Float;
  -- MocMods: Float;

  procedure GetMinIrradiance(IrTab: in Irradiance; IrVal: out Float; IrNumberOfDays: Out Float);
  procedure CalculateRequest(ConstUsage: In Float; NumberOfUsers: In Float; UsagePerson: In Float; Request: Out Float);
  procedure CalculateExpectedPowerOfModules(Request: In Float; NumberOfDays:In Float; Cracow_Irradiance: In Float; Directory_Ratio: In Float; PanelEfficiency: In Float; PowerOfModules: Out Float);
  -- procedure CalculateNumberOfPanelsInWinter(Request: in Float);
  procedure CalculateNumberOfPanelsInWinter(ExpectedPowerOfModules: In Float; PowerOfModule: In Float; NumberOfModules: Out Float);
  procedure CalculateAreaOfPanels(NumberOfPanels: In Float; Area: Out Float);
  procedure CalculateYearUsage(Request: In Float; YearUsage: Out Float);
  procedure SumYearIrradiance(IrTab: In Irradiance; IrSum: Out Float);
  procedure SumYearProduction(IrSum: In Float; Directory_Ratio: In Float; NumberOfPanels: In Float; PowerOfModule: In Float; PanelEfficiency: In Float; SumEnergy: Out Float);
  procedure DifferenceBetweenProductionAndRequest(Production: In Float; Request: In Float; Difference: Out Float);

  procedure CalculateWaste(DayUsage: In Float; ConstantDayUsage: In Float; PowerOfAllModules: In Float; TotalWaste: Out Float);
  -- procedure Dzielona;

  -- task Zad;

end how_many_modules;
