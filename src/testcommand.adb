with Ada.Text_Io ; use Ada.Text_Io ;
with Ada.Command_Line; use  Ada.Command_Line;

-- Pour lancer depuis une ligne de command : View, OS SHELL
-- Placez vous sur src, et tapez gcc -o testcommand.adb
-- ensuite tapez gnat make testcommand testcommand.adb
-- Pour lancer, tapez testcommand
-- Des arguments peuvent être ajouté, exemple : testcommand a e 99 ..


procedure testcommand is
begin
   Put_Line("Nom du programme: " & Command_Name) ;
   for I in 1..Argument_Count loop
      Put_Line("Argument" & Natural'Image(I) & ": " & Argument(I)) ;
   end loop ;
end testcommand;
u_ztg 
