with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;




procedure unboundedtest is
    input_array : array(1..5) of Ada.Strings.Unbounded.Unbounded_String;
begin
    input_array(1) := Ada.Strings.Unbounded.To_Unbounded_String ("12345");
end unboundedtest;
