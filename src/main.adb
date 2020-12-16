with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with MATRIX;
with VECTOR;

procedure Main is

   Type T_Double is digits 13 ;


   package Vector_integer is
     new Vector (T_Element => T_Double, CAPACITE  => 6);
   use Vector_integer;

   Procedure Calcul (N : in integer, H : out) is
      package MATRIX_INTEGER is
        new MATRIX (T_Element => T_Double,
                    CAPACITE  => N);
      use MATRIX_INTEGER;
   begin
      Initialiser(0.0, H);


      while not End_Of_File(F) loop
         Get(F,C); -- on lit un entier dans
         I:=C;
         Get(F,C);
         J:=C;
         H(I,J):=1.0;
         if End_Of_Line(F) then
            NL:=NL+1;
            New_line;
         end if;

      end loop;
   end Calcul;

   Occ : T_VECTOR;
   H: T_MATRIX;
   NN : Integer;
   I : Integer ;
   J : Integer;
   C: Integer;

begin


   Open(F,In_File,"exemple_sujet.net");
   Get(F,C); -- On GET le premier nombre du fichier.net qui correspond au nombre de noeuds NN.
   NN:=C; -- On stocke ce nombre.
   Initialiser(0.0, H);


   while not End_Of_File(F) loop
      Get(F,C); -- on lit un entier dans
      I:=C;
      Get(F,C);
      J:=C;
      H(I,J):=1.0;
      if End_Of_Line(F) then
         NL:=NL+1;
         New_line;
      end if;

   end loop;





end Main;
