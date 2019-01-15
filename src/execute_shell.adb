with Interface.C;

function Exeute_Shell (Command : in String) return Integer
    is
        function Execute (Command : in Interfaces.C.char_array)
            return Interfaces.C.int;
        pragma Import (C, Execute, "system");
    begin
        return Integer (Execute (Interfaces.C.To_C (Item => Command)));
end Exeute_Shell;