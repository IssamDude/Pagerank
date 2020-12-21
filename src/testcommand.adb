with Ada.Text_Io ; use Ada.Text_Io ;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Command_Line; use  Ada.Command_Line;

-- Pour lancer depuis une ligne de command : View, OS SHELL
-- Placez vous sur src, et tapez gcc -o testcommand.adb
-- ensuite tapez gnat make testcommand testcommand.adb
-- Pour lancer, tapez testcommand
-- Des arguments peuvent être ajouté, exemple : testcommand a e 99 ..


procedure testcommand is
    procedure aff (N:in Integer) is
    begin
        for I in 1..N loop
            Put_Line("Argument" & Natural'Image(I) & ": " & Argument(I)) ;
        end loop ;
            end aff;
begin
    Put_Line("Nom du programme: " & Command_Name) ;
    New_Line;
    aff(Argument_Count);

    put(Integer'Value(Argument(1)));
    New_Line;
    if Integer'Value(Argument(1)) > (2) then
        Put_Line("Premier argument superieur a 2");
    else
        Put_Line("Premier argument non superieur a 2");
    end if;

end testcommand;
