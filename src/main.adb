with Ada.Text_IO, how_many_modules, Ada.Command_Line;
use Ada.Text_IO, how_many_modules, Ada.Command_Line;



procedure Main is

-- task WaitForSignalToExit;
-- task body WaitForSignalToExit is
-- begin
--   loop
--     Get_Immediate(Zn);
--     exit when Zn in 'q'|'Q';
--   end loop;
-- end WaitForSignalToExit;



begin
  Create(OutputFile, Out_File, "stats.txt");
  Close(OutputFile);
  Create(OutputFileForOneDay, Out_File, "statsForOneDay.txt");
  Close(OutputFileForOneDay);
  NumberOfUsers := Float(Float'value(Argument(1)));
  Directory_Ratio := Float(Float'value(Argument(2)));
  PanelEfficiency := Float(Float'value(Argument(3)));
  PowerOfModule := Float(Float'value(Argument(4)));
  CheckInputValues(NumberOfUsers, Directory_Ratio,PanelEfficiency,PowerOfModule);
  MakeCalculations(NumberOfUsers, Directory_Ratio,PanelEfficiency,PowerOfModule);

  exception
    when Constraint_Error => Put_Line("Zły format wprowadzonych danych");
      Put_Line("Ustawiono domyślne parametry: ");
      Put_Line("2 użytkowników");
      Put_Line("Współczynnik nachylenia: 1.13 (Maksymalny)");
      Put_Line("Sprawność modułu: 0.20 (Maksymalny)");
      Put_Line("Moc jednego modułu: 0.28 kW");
      NumberOfUsers := 2.0;
      Directory_Ratio := 1.13;
      PanelEfficiency := 0.20;
      PowerOfModule := 0.28;

      MakeCalculations(NumberOfUsers, Directory_Ratio,PanelEfficiency,PowerOfModule);
    when others =>
    Put_Line("Coś poszło nie tak");
  end Main;
