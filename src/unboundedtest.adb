with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;



procedure unboundedtest is
    input_array : array(1..5) of Ada.Strings.Unbounded.Unbounded_String;
    test : Boolean;
begin
    input_array(1) := Ada.Strings.Unbounded.To_Unbounded_String ("ayman");
    put(To_String(input_array(1)));
    New_Line;
    put(Length(input_array(1)));
    New_Line;
    for i in reverse 1..length(input_array(1)) loop
        test := To_String(input_array(1)) = "lolo";
        if test then
            put ("element = n");
            New_Line;
        end if;
        put(element(input_array(1),i) & " ");
    end loop;
end unboundedtest;
