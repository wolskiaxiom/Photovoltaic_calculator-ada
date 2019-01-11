with semaforb, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO,Ada.Numerics.Float_Random;
use semaforb, Ada.Text_IO, Ada.Integer_Text_IO,Ada.Float_Text_IO,Ada.Numerics.Float_Random;
package how_many_modules is
  type Irradiance is array (1..12) of Float;
  type NumberOfDaysInMonth is array(1..12) of Float;
  type DurationOfDayInMonth is array(1..12) of Float;
  -- task type SumProduction;
  -- type Wsk_SumProduction is access SumProduction;
  -- type Degrees is (0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90);
  type WspKor is array (1..19, 1..19) of Float;
  NumberOfDays: NumberOfDaysInMonth := (31.0, 28.0, 31.0, 30.0, 31.0, 30.0, 31.0, 31.0, 30.0, 31.0, 30.0, 31.0);
  DurationOfDay: DurationOfDayInMonth := (8.35, 9.97, 11.92, 13.97, 15.75, 16.68, 16.18, 14.58, 12.62, 10.60, 8.77, 7.7);
  I_Specific: Irradiance := (27217.0, 37262.0, 66879.0, 107159.0, 160845.0, 162168.0, 155488.0, 130632.0, 87335.0, 54470.0, 30835.0, 25242.0);
  -- Directory_Ratio: Float;
  -- NumberOfUsers : Float;
  type General_Float_Pointer is access all Float;
  ConstantUsage : constant Float := 7.2;
  UsagePerPerson: constant Float := 1.25;
  PriceRatio: constant Float := 1.25;
  SumRealYearProduction : Integer := 0 with Atomic;
  -- Request: Float;
  -- MocMods: Float;

  task type SumMonthProduction(MonthNumber: Positive;Directory_Ratio: Positive; NumberOfPanels: Positive; PowerOfModule: Positive; PanelEfficiency:Positive);
  type PointerSumMonthProduction is access SumMonthProduction;
  SemaphoreForReading: Semaphore; 


  function GetFullRow(InputFile: in FILE_TYPE; LineNumber: in Integer) return String;
  function GetValueFromRowAndCol(InputFile: in FILE_TYPE; Row: in Count; Col: in Count) return Float;
  procedure GetMinIrradiance(IrTab: in Irradiance; IrVal: out Float; IrNumberOfDays: Out Float);
  procedure CalculateRequest(ConstUsage: In Float; NumberOfUsers: In Float; UsagePerson: In Float; Request: Out Float);
  procedure CalculateExpectedPowerOfModules(Request: In Float; NumberOfDays:In Float; Specific_Irradiance: In Float; Directory_Ratio: In Float; PanelEfficiency: In Float; PowerOfModules: Out Float);
  -- procedure CalculateNumberOfPanelsInWinter(Request: in Float);
  procedure CalculateNumberOfPanelsInWinter(ExpectedPowerOfModules: In Float; PowerOfModule: In Float; NumberOfModules: Out Float);
  procedure CalculateAreaOfPanels(NumberOfPanels: In Float; Area: Out Float);
  procedure CalculateYearUsage(Request: In Float; YearUsage: Out Float);
  procedure SumYearIrradiance(IrTab: In Irradiance; IrSum: Out Float);
  procedure SumYearProduction(IrSum: In Float; Directory_Ratio: In Float; NumberOfPanels: In Float; PowerOfModule: In Float; PanelEfficiency: In Float; SumEnergy: Out Float);
  procedure DifferenceBetweenProductionAndRequest(Production: In Float; Request: In Float; Difference: Out Float);

  procedure CalculateWaste(DayUsage: In Float; ConstantDayUsage: In Float; PowerOfAllModules: In Float; TotalWaste: Out Float);
  procedure CalculateRealYearProduction(Cloudy: in FILE_TYPE; Irradiance_Specific: in Irradiance;Directory_Ratio: In Float; NumberOfPanels: In Float; PowerOfModule: In Float; PanelEfficiency: In Float; SumEnergy: Out Float);

  function GetPossibilityOfSunnyWeather(NumberOfSunnyDays: in Float; NumberOfDays: in Float) return Float;
  function GetPossibilityOfCloudyWeather(NumberOfCloudyDays: in Float; NumberOfDays: in Float) return Float;
  function GetPossibilityOfFoggyWeather(NumberOfFoggyDays: in Float; NumberOfDays: in Float) return Float;
  function GetPossibilityOfRainyWeather(NumberOfRainyDays: in Float; NumberOfDays: in Float) return Float;
  function WheatherInRandomDay(PossibilityOfSunnyWeather: in Float;PossibilityOfCloudyWeather: in Float;PossibilityOfFoggyWeather: in Float;PossibilityOfRainyWeather: in Float; RandomNumber: in Float) return Float;

  -- task type SumProduction;

  -- procedure Dzielona;

  -- task Zad;

end how_many_modules;
