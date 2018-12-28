with Ada.Text_IO;
use Ada.Text_IO;

procedure Projekt is

type Irradiance is array (1..12) of Float;
type NumberOfDaysInMonth is array(1..12) of Float;
type DurationOfDayInMonth is array(1..12) of Float;
-- type Degrees is (0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90);
type WspKor is array (1..19, 1..19) of Float;

NumberOfDays: NumberOfDaysInMonth := (31.0, 28.0, 31.0, 30.0, 31.0, 30.0, 31.0, 31.0, 30.0, 31.0, 30.0, 31.0);
DurationOfDay: DurationOfDayInMonth := (8.35, 9.97, 11.92, 13.97, 15.75, 16.68, 16.18, 14.58, 12.62, 10.60, 8.77, 7.07);

I_Cracow: Irradiance := (27217.0, 37262.0, 66879.0, 107159.0, 160845.0, 162168.0, 155488.0, 130632.0, 87335.0, 54470.0, 30835.0, 25242.0);
Directory_Ratio: Float;
NumberOfUsers : Float;
ConstantUsage : Float;
UsagePerPerson: Float;
Request: Float;
MocMods: Float;
-- Tmp: Float;
begin
  -- null;
  NumberOfUsers := 4.0;
  ConstantUsage := 9.0;
  Directory_Ratio := 1.13;
  UsagePerPerson := 1.25;
  Request := Float(ConstantUsage) + Float(NumberOfUsers*UsagePerPerson);
  MocMods := Request*NumberOfDays(12)/(I_Cracow(6)/1000.0*1.13*0.80);
  -- MocMods := Request*Float(30)/(I_Cracow(1)*1.13*0.17);
  Put_Line("Request: " & Request'Img & "  MocMods: " & MocMods'Img);

end Projekt;
