package body how_many_modules is

procedure CheckInputValues(NumberOfUsers: in out Float; Directory_Ratio: in out Float;PanelEfficiency: in out Float; PowerOfModule: in out Float) is
begin
  if(NumberOfUsers<1.0) then
    Put_Line("Liczba użytkowników ustawiona domyślnie(2)");
    NumberOfUsers := 2.0;
  end if;
  if(Directory_Ratio<0.6 or Directory_Ratio>1.14) then
    Put_Line("Współczynnik nachylenia paneli ustawiono domyślnie(1.13)");
    Directory_Ratio := 1.13;
  end if;
  if(PanelEfficiency<0.0 or PanelEfficiency>1.0) then
    Put_Line("Sprawność paneli ustawiona domyślnie(0.2)");
    PanelEfficiency := 0.2;
  end if;
  if(PowerOfModule<0.0 or PowerOfModule>10.0) then
      Put_Line("Moc panelu ustawiona domyślnie(0.28kw)");
      PowerOfModule:=0.28;
  end if;
end CheckInputValues;

procedure MakeCalculations(NumberOfUsers: in Float; Directory_Ratio: in Float; PanelEfficiency: in Float;PowerOfModule: in Float ) is
begin
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
CalculateRealYearProduction;
exception
  when others => Put_Line("Coś poszło nie tak!");
end MakeCalculations;


procedure CalculateRealYearProduction is
begin
  if(Exists("../resources/zachmurzenie_krakow.txt"))then
    for I in 1..12 loop
      WZS := new SumMonthProduction(I,Positive(Directory_Ratio*100.0),Positive(NumberOfPanelsInCaseOfWinter),Positive(PowerOfModule*100.0),Positive(PanelEfficiency*100.0),1);
    end loop;
  end if;
  if(Exists("resources/zachmurzenie_krakow.txt"))then
    for I in 1..12 loop
      WZS := new SumMonthProduction(I,Positive(Directory_Ratio*100.0),Positive(NumberOfPanelsInCaseOfWinter),Positive(PowerOfModule*100.0),Positive(PanelEfficiency*100.0),2);
    end loop;
  end if;
end CalculateRealYearProduction;

function GetFullRow(InputFile: in FILE_TYPE; LineNumber: in Integer) return String is
begin
  for I in Integer range 1 .. LineNumber loop
    declare
        Line: String := Get_Line(InputFile);
      begin
        if(I = LineNumber) then
          return  Line;
        end if;
      end;
  end loop;
  return "There is no line";
end GetFullRow;

function GetValueFromRowAndCol(InputFile: in FILE_TYPE; Row: in Count; Col: in Count) return Float is
Value: Float;
begin
Set_Line(InputFile, Row);
Set_Col(InputFile, Col);
Get(InputFile, Value);
return Value;
end GetValueFromRowAndCol;


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

procedure CalculateExpectedPowerOfModules(Request: In Float; NumberOfDays:In Float; Specific_Irradiance: In Float; Directory_Ratio: In Float; PanelEfficiency: In Float; PowerOfModules: Out Float) is
begin
  PowerOfModules := Request * NumberOfDays/ (Specific_Irradiance/1000.0 * Directory_Ratio * PanelEfficiency);
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
MonthBilance: Float;
-- PowerOfAllModules:Float;
begin
  MonthBilance := 0.0;
  TotalWaste:= 0.0;
  -- PowerOfAllModules := NumberOfPanels * PowerOfModule * PanelEfficiency;
  for I in NumberOfDays'Range loop
    UsageDuringNight := (24.0-DurationOfDay(I))*ConstantDayUsage;
    UsageDuringDay := DayUsage - UsageDuringNight;
    MonthProduction := I_Specific(I) * PowerOfAllModules;
    MonthBilance := MonthProduction - (UsageDuringDay + UsageDuringNight*PriceRatio)* NumberOfDays(I);
    -- TotalWaste :=  DayWaste * NumberOfDays(I);
    TotalWaste := TotalWaste + MonthBilance;
  end loop;
end CalculateWaste;



function GetPossibilityOfSunnyWeather(NumberOfSunnyDays: in Float; NumberOfDays: in Float) return Float is
begin
  return NumberOfSunnyDays/NumberOfDays;
end GetPossibilityOfSunnyWeather;


function GetPossibilityOfCloudyWeather(NumberOfCloudyDays: in Float; NumberOfDays: in Float) return Float is
begin
  return NumberOfCloudyDays/NumberOfDays;
end GetPossibilityOfCloudyWeather;


function GetPossibilityOfFoggyWeather(NumberOfFoggyDays: in Float; NumberOfDays: in Float) return Float is
begin
  return NumberOfFoggyDays/NumberOfDays;
end GetPossibilityOfFoggyWeather;


function GetPossibilityOfRainyWeather(NumberOfRainyDays: in Float; NumberOfDays: in Float) return Float is
begin
  return NumberOfRainyDays/NumberOfDays;
end GetPossibilityOfRainyWeather;

function WheatherInRandomDay(PossibilityOfSunnyWeather: in Float;PossibilityOfCloudyWeather: in Float;PossibilityOfFoggyWeather: in Float;PossibilityOfRainyWeather: in Float; RandomNumber: in Float) return Float is
SumOfPossibilities: Float :=0.0;
begin
  SumOfPossibilities:= PossibilityOfSunnyWeather;
  if SumOfPossibilities > RandomNumber then
    return 1.0;
  end if;
  SumOfPossibilities := SumOfPossibilities + PossibilityOfCloudyWeather;
  if SumOfPossibilities > RandomNumber then
    return 0.6;
  end if;
  SumOfPossibilities := SumOfPossibilities + PossibilityOfFoggyWeather;
  if SumOfPossibilities > RandomNumber then
    return 0.3;
  end if;
  return 0.1;
end WheatherInRandomDay;

protected ReadingFile is
  procedure ReadValue(MonthNumber: in Positive; WeatherState: in Positive; Value: out Float);
end ReadingFile;

protected body ReadingFile is
  procedure ReadValue(MonthNumber: in Positive; WeatherState: in Positive; Value: out Float) is
  begin
    Value:=1.1;
    Put_Line(MonthNumber'Img & " "& WeatherState'Img);
  end ReadValue;
end ReadingFile;

procedure File_Exists is
   procedure Print_File_Exist (Name : String) is
   begin
      Put_Line ("Does " & Name & " exist? " &
                  Boolean'Image (Exists (Name)));
   end Print_File_Exist;
   procedure Print_Dir_Exist (Name : String) is
   begin
      Put_Line ("Does directory " & Name & " exist? " &
                  Boolean'Image (Exists (Name) and then Kind (Name) = Directory));
   end Print_Dir_Exist;
begin
   Print_File_Exist ("input.txt" );
   Print_File_Exist ("/input.txt");
   Print_Dir_Exist ("docs");
   Print_Dir_Exist ("/docs");
end File_Exists;

function GetSourceFile(TypeSource: Positive) return String is
begin
  if(TypeSource=1)then
    return "../resources/zachmurzenie_krakow.txt" ;
  end if;
  if(TypeSource=2) then
    return "resources/zachmurzenie_krakow.txt";
  end if;
  if(TypeSource=3) then
    return "../resources/zachmurzenie_gdansk.txt";
  end if;
  if(TypeSource=4)then
    return "resources/zachmurzenie_gdansk.txt";
  end if;
  return "../resources/zachmurzenie_krakow.txt" ;
end GetSourceFile;


task body SumMonthProduction is
  SumInMonth: Float := 0.0;
  WheatherInRandomDayValue:Float:=1.0;
  NumberOfDaysValue: Float := NumberOfDays(MonthNumber);
  OneDayIrradiance: Float := I_Specific(MonthNumber)/NumberOfDaysValue;
  OneDayEnergy: Float := 0.0;

  NumberOfSunnyDays:Float;
  NumberOfCloudyDays:Float;
  NumberOfFoggyDays:Float;
  NumberOfRainyDays:Float;

  PossibilityOfSunnyWeather: Float;
  PossibilityOfCloudyWeather: Float;
  PossibilityOfFoggyWeather: Float;
  PossibilityOfRainyWeather: Float;

  InputFile: FILE_TYPE;

  G: Generator;
  RandomNumber: Float;
  begin
    SemaphoreForReading.Wait;
    Open(InputFile, In_File, GetSourceFile(TypeSource));
    NumberOfSunnyDays := GetValueFromRowAndCol(InputFile,Count(MonthNumber),1);
    -- Put_Line(NumberOfSunnyDays'Img&"Sunny");
    Close(InputFile);
    SemaphoreForReading.Signal;

    SemaphoreForReading.Wait;
    Open(InputFile, In_File, GetSourceFile(TypeSource));
    NumberOfCloudyDays := GetValueFromRowAndCol(InputFile,Count(MonthNumber),4);
    -- Put_Line(NumberOfCloudyDays'Img&"Cloudy");
    Close(InputFile);
    SemaphoreForReading.Signal;

    SemaphoreForReading.Wait;
    Open(InputFile, In_File, GetSourceFile(TypeSource));
    NumberOfFoggyDays := GetValueFromRowAndCol(InputFile,Count(MonthNumber),10);
    Close(InputFile);
    -- Put_Line(NumberOfFoggyDays'Img&"Foggy");
    SemaphoreForReading.Signal;

    SemaphoreForReading.Wait;
    Open(InputFile, In_File, GetSourceFile(TypeSource));
    NumberOfRainyDays := GetValueFromRowAndCol(InputFile,Count(MonthNumber),14);
    -- Put_Line(NumberOfRainyDays'Img&"Rainy");
    Close(InputFile);
    SemaphoreForReading.Signal;

    PossibilityOfSunnyWeather := GetPossibilityOfSunnyWeather(NumberOfSunnyDays,NumberOfDaysValue);
    PossibilityOfCloudyWeather := GetPossibilityOfCloudyWeather(NumberOfCloudyDays,NumberOfDaysValue);
    PossibilityOfFoggyWeather := GetPossibilityOfFoggyWeather(NumberOfFoggyDays,NumberOfDaysValue);
    PossibilityOfRainyWeather := GetPossibilityOfRainyWeather(NumberOfRainyDays,NumberOfDaysValue);

  for DayInMonth in 1..Integer(NumberOfDaysValue) loop
    Reset(G);
    RandomNumber := Random(G);
    WheatherInRandomDayValue := WheatherInRandomDay(PossibilityOfSunnyWeather,PossibilityOfCloudyWeather,PossibilityOfFoggyWeather,PossibilityOfRainyWeather, RandomNumber);
    OneDayEnergy := OneDayIrradiance * Float(Directory_Ratio) * Float(NumberOfPanels) * Float(PowerOfModule) * Float(PanelEfficiency) * WheatherInRandomDayValue/1000000000.0;
    SumInMonth := SumInMonth + OneDayEnergy;
  end loop;
  SumRealYearProduction:= SumRealYearProduction+ Integer(SumInMonth);
  Put_Line("Produkcja w "& MonthNumber'Img&" "&Positive(SumInMonth)'Img & "  Łącznie:" & SumRealYearProduction'Img);
end SumMonthProduction;



end how_many_modules;
