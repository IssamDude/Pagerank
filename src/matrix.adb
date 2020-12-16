
with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
--with Ada.Unchecked_Deallocation;

package body MATRIX is


    procedure Initialiser (N : in T_Element; M : out T_MATRIX) is
    begin
        for i in 1..CAPACITE loop
            for k in 1..CAPACITE loop
                M(i,k) := N;
            end loop;
        end loop;

    end Initialiser;


    procedure Initialiser (M : out T_MATRIX) is
    begin
        for i in 1..CAPACITE loop
            for k in 1..CAPACITE loop
                M(i,k) := 1.0;
            end loop;
        end loop;

    end Initialiser;



    procedure Somme (M1 : in T_MATRIX; M2 : in T_MATRIX; M : out T_MATRIX) is
    begin
        for i in 1..CAPACITE loop
            for k in 1..CAPACITE loop
                M(i,k) := M1(i,k) + M2(i,k);
            end loop;
        end loop;

    end Somme;



    procedure Produit_Par_Scalaire (M : in out T_MATRIX; lambda : in T_Element) is
    begin
        for i in 1..CAPACITE loop
            for k in 1..CAPACITE loop
                M(i,k) := lambda * M(i,k);
            end loop;
        end loop;

    end Produit_Par_Scalaire;



    procedure Afficher (M : in T_MATRIX) is
    begin
        for i in 1..CAPACITE loop
            for k in 1..CAPACITE loop
                Put(M(i,k)'Image);
            end loop;
            New_Line;
        end loop;


    end Afficher;




end MATRIX;
