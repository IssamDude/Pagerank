with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with MATRIX;

procedure testmatrix is

    Type T_Double is digits 13 ;
    
    package MATRIX_INTEGER is
            new MATRIX (T_Element => T_Double, CAPACITE  => 6);
    use MATRIX_INTEGER;

    M1: T_MATRIX;
    M2: T_MATRIX;
    M_Somme : T_MATRIX;
begin

    Initialiser(M2);
    Initialiser(3.0, M1);
   Somme(M1,M2, M_Somme);
   Produit_Par_Scalaire(M1, 2.0);
   New_Line;
   Afficher(M1);
   New_Line;
   Afficher(M2);
   New_Line;
   Afficher(M_Somme);


end testmatrix;
