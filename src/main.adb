with Ada.Text_IO, how_many_modules, Ada.Command_Line;
use Ada.Text_IO, how_many_modules,Ada.Command_Line;



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

  InputFile : FILE_TYPE;
  OutputTmpFIle: FILE_TYPE;

  WZS : PointerSumMonthProduction;
  -- SemaphoreForReading: Semafor_Bin(False);

begin
  NumberOfUsers := 4.0;
  Directory_Ratio := 1.13;
  PanelEfficiency := 0.80;
  PowerOfModule := 0.28;
  -- NumberOfUsers := Float'value(Argument(1));
  -- Directory_Ratio := Float'value(Argument(2));
  -- PanelEfficiency := Float'value(Argument(3));
  -- PowerOfModule := Float'value(Argument(4));

  GetMinIrradiance(I_Specific, MinimumIrradiance, NumberOfDaysInMonthOfMinimumIrradiance);
  Put_Line("Najmniejsze nasłonecznienie w roku" & Integer(MinimumIrradiance)'Img & " Liczba dni w tym miesiącu: " & Integer(NumberOfDaysInMonthOfMinimumIrradiance)'Img);

  CalculateRequest(ConstantUsage, NumberOfUsers, UsagePerPerson, DayRequest);
  Put_Line("Średnie dzienne zapotrzebowanie na energię elektryczną" & Integer(DayRequest)'Img & " kWh");

  CalculateYearUsage(DayRequest, YearUsage);
  Put_Line("Roczne zapotrzebowanie na energię " & Integer(YearUsage)'Img & " kWh");

  CalculateExpectedPowerOfModules(DayRequest, NumberOfDaysInMonthOfMinimumIrradiance, MinimumIrradiance, Directory_Ratio,PanelEfficiency, ExpectedPowerOfModules);
  Put_Line("Oczekiwana moc paneli: "& Integer(ExpectedPowerOfModules)'Img & "kW");

  CalculateNumberOfPanelsInWinter(ExpectedPowerOfModules, PowerOfModule, NumberOfPanelsInCaseOfWinter);
  Put_Line("Liczba paneli wystarczająca w 'najzimniejszym miesiącu' na wyprodukowanie dziennego zapotrzebowania na energię: " & Integer(NumberOfPanelsInCaseOfWinter)'Img);

  CalculateAreaOfPanels(NumberOfPanelsInCaseOfWinter, PanelsAreaInCaseOfWinter);
  Put_Line("Powierzchnia paneli: "& Integer(PanelsAreaInCaseOfWinter)'Img & " m^2");

  SumYearIrradiance(I_Specific, SumOfYearIrradiance);
  Put_Line("Roczne nasłonecznienie:" & Integer(SumOfYearIrradiance)'Img & " Wh/m^2");

  SumYearProduction(SumOfYearIrradiance, Directory_Ratio, NumberOfPanelsInCaseOfWinter, PowerOfModule, PanelEfficiency, SumOfYearProductionInCaseOfWinter);
  Put_Line("Roczna produkcja prądu:" & Integer(SumOfYearProductionInCaseOfWinter)'Img & " kWh");

  DifferenceBetweenProductionAndRequest(SumOfYearProductionInCaseOfWinter, YearUsage, ExcessInCaseOfWinter);
  Put_Line("Różnica pomiędzy energią wyprodukowaną, a energią wykorzystaną w przypadku posiadania akumulatora o pojemności wystarczającej na całą noc:" & Integer(ExcessInCaseOfWinter)'Img & " kWh");

  CalculateWaste(DayRequest, ConstantUsage, Directory_Ratio*NumberOfPanelsInCaseOfWinter*PowerOfModule*PanelEfficiency/1000.0, WasteInWinter);
  Put_Line("Różnica pomiędzy energią wyprodukowaną, a energią wykorzystaną w przypadku nieposiadania  akumulatora:" & Integer(WasteInWinter)'Img & " kWh");
  -- Put_Line(GetValueFromRowAndCol(InputFile, 1,1)'Img);
  for I in 1..12 loop
    WZS := new SumMonthProduction(I,Positive(Directory_Ratio*100.0),Positive(NumberOfPanelsInCaseOfWinter),Positive(PowerOfModule*100.0),Positive(PanelEfficiency*100.0));
  end loop;
  -- WZS := new SumMonthProduction(1,Positive(Directory_Ratio*100.0),Positive(NumberOfPanelsInCaseOfWinter),Positive(PowerOfModule*100.0),Positive(PanelEfficiency*100.0));
  -- WZS := new SumMonthProduction(1,Integer(NumberOfUsers*100.0),1,1,1);
  -- how_many_modules.ReadingFile.ReadValue(MonthNumber, 1,NumberOfSunnyDays: Float);

  end Main;
