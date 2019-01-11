-- semaforb.adb
-- semafr binarny

with Ada.Text_IO;
use Ada.Text_IO;

package body SemaforB is

  protected body Semaphore is
     entry Wait when Value > 0 is
     begin
       Value := Value - 1;
     end Wait;
     procedure Signal is
     begin
      Value := Value + 1;
     end Signal;
  end Semaphore;

end SemaforB;
