with Ada.Text_IO, how_many_modules, Ada.Command_Line;
use Ada.Text_IO, how_many_modules,Ada.Command_Line;



procedure Main is




begin
  NumberOfUsers := Float(Float'value(Argument(1)));
  Directory_Ratio := Float(Float'value(Argument(2)));
  PanelEfficiency := Float(Float'value(Argument(3)));
  PowerOfModule := Float(Float'value(Argument(4)));
  CheckInputValues(NumberOfUsers, Directory_Ratio,PanelEfficiency,PowerOfModule);
  MakeCalculations(NumberOfUsers, Directory_Ratio,PanelEfficiency,PowerOfModule);

  -- WZS := new SumMonthProduction(1,Positive(Directory_Ratio*100.0),Positive(NumberOfPanelsInCaseOfWinter),Positive(PowerOfModule*100.0),Positive(PanelEfficiency*100.0));
  -- WZS := new SumMonthProduction(1,Integer(NumberOfUsers*100.0),1,1,1);
  -- how_many_modules.ReadingFile.ReadValue(MonthNumber, 1,NumberOfSunnyDays: Float);
  exception
    when others => Put_Line("Zły format wprowadzonych danych");
      Put_Line("Ustawiono domyślne parametry: ");
      Put_Line("2 użytkowników");
      Put_Line("Współczynnik nachylenia: 1.13 (Maksymalny)");
      Put_Line("Sprawność modułu: 0.20 (Maksymalny)");
      Put_Line("Moc jednego modułu: 0.28 kW");
      NumberOfUsers := 2.0;
      Directory_Ratio := 1.13;
      PanelEfficiency := 0.80;
      PowerOfModule := 0.28;
      MakeCalculations(NumberOfUsers, Directory_Ratio,PanelEfficiency,PowerOfModule);
  end Main;
