with Ada.Text_IO;
use Ada.Text_IO;

package SemaforB is

-- typ chroniony
protected type Semaphore (Initial : Natural := 1) is
   entry Wait;         -- P operation
   procedure Signal;   -- V operation;
private
   Value : Natural := Initial;
end Semaphore;

end SemaforB;
