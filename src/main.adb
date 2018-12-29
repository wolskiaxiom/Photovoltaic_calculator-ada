with Ada.Text_IO, how_many_modules, Ada.Command_Line;
use Ada.Text_IO, how_many_modules, Ada.Command_Line;

procedure Main is
  NumberOfUsers: Float;
  Directory_Ratio:Float;
  PanelEfficiency: Float;
  PowerOfModule: Float;

  MinimumIrradiance:Float;
  NumberOfDaysInMonthOfMinimumIrradiance:Float;
  DayRequest: Float;
  YearUsage: Float;
  ExpectedPowerOfModules:Float;

  NumberOfPanelsInCaseOfWinter: Float;
  NumberOfPanelsInCaseOfSummer: Float;

  PanelsAreaInCaseOfWinter: Float;
  PanelsAreaInCaseOfSummer: Float;


  SumOfYearIrradiance: Float;
  SumOfYearProductionInCaseOfWinter: Float;
  SumOfYearProductionInCaseOfSummer: Float;

  ExcessInCaseOfWinter: Float;
  DeficiencyInCaseOfSummer: Float;

  WasteInWinter: Float;
  WasteInSummer: Float;


begin
--  NumberOfUsers := 4.0;
--  Directory_Ratio := 1.13;
--  PanelEfficiency := 0.80;
--  PowerOfModule := 0.28;
  NumberOfUsers := Float'value(Argument(1));
  Directory_Ratio := Float'value(Argument(2));
  PanelEfficiency := Float'value(Argument(3));
  PowerOfModule := Float'value(Argument(4));

  GetMinIrradiance(I_Cracow, MinimumIrradiance, NumberOfDaysInMonthOfMinimumIrradiance);
  Put_Line("Irradiance " & Integer(MinimumIrradiance)'Img & " NumberOfDays: " & Integer(NumberOfDaysInMonthOfMinimumIrradiance)'Img);

  CalculateRequest(ConstantUsage, NumberOfUsers, UsagePerPerson, DayRequest);
  Put_Line("Request " & Integer(DayRequest)'Img & " kWh");

  CalculateYearUsage(DayRequest, YearUsage);
  Put_Line("Year Usage for House " & Integer(YearUsage)'Img & " kWh");

  CalculateExpectedPowerOfModules(DayRequest, NumberOfDaysInMonthOfMinimumIrradiance, MinimumIrradiance, Directory_Ratio,PanelEfficiency, ExpectedPowerOfModules);
  Put_Line("ExpectedPowerOfModules: "& Integer(ExpectedPowerOfModules)'Img & "kW");

  CalculateNumberOfPanelsInWinter(ExpectedPowerOfModules, PowerOfModule, NumberOfPanelsInCaseOfWinter);
  Put_Line("NumberOfPanelsInCaseOfWinter " & Integer(NumberOfPanelsInCaseOfWinter)'Img);

  CalculateAreaOfPanels(NumberOfPanelsInCaseOfWinter, PanelsAreaInCaseOfWinter);
  Put_Line("PanelsAreaInCaseOfWinter "& PanelsAreaInCaseOfWinter'Img);

  SumYearIrradiance(I_Cracow, SumOfYearIrradiance);
  Put_Line("Year Irradiance" & Integer(SumOfYearIrradiance)'Img & " Wh/m^2");

  SumYearProduction(SumOfYearIrradiance, Directory_Ratio, NumberOfPanelsInCaseOfWinter, PowerOfModule, PanelEfficiency, SumOfYearProductionInCaseOfWinter);
  Put_Line("Year Production(Winter)" & Integer(SumOfYearProductionInCaseOfWinter)'Img & " kWh");

  DifferenceBetweenProductionAndRequest(SumOfYearProductionInCaseOfWinter, YearUsage, ExcessInCaseOfWinter);
  Put_Line("Difference " & Integer(ExcessInCaseOfWinter)'Img & " kWh");

  CalculateWaste(DayRequest, ConstantUsage, Directory_Ratio*NumberOfPanelsInCaseOfWinter*PowerOfModule*PanelEfficiency/1000.0, WasteInWinter);
  Put_Line("Balance in Winter " & Integer(WasteInWinter)'Img & " kWh");


end Main;
