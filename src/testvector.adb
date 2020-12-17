with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with VECTOR;

procedure testvector is

   Type T_Double is digits 13 ;

   package Vector_integer is
     new Vector (T_Element => T_Double, CAPACITE  => 6);
    use Vector_integer;

   V1: T_VECTOR;
   V2: T_VECTOR;
   V3 : T_VECTOR;
begin

   Initialiser(V1, 1.0);
   Initialiser(V2, 1.0);
   Produit_Par_Scalaire(V2, 3.0);
   Somme(V1,V2, V3);
   New_Line;
   Afficher(V1);
   New_Line;
   Afficher(V3);
   Put(V2(1));


end testvector;
