with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
--with Ada.Unchecked_Deallocation;

package body VECTOR is


    procedure Initialiser (vecteur : out T_VECTOR ; N : in T_Element ) is
    begin
      for i in 1..CAPACITE loop
         vecteur(i) := N;
      end loop;
   end Initialiser;


   procedure Somme (V1 : in T_VECTOR; V2 : in T_VECTOR; V3 : out T_VECTOR)is
   begin
      for i in 1..CAPACITE loop

         V3(i) := V1(i) + V2(i);

      end loop;

   end Somme;



    procedure Produit_Par_Scalaire (V1 : in out T_VECTOR; lambda : in T_Element) is
    begin
      for i in 1..CAPACITE loop
         V1(i) := lambda * V1(i);

      end loop;

    end Produit_Par_Scalaire;



   procedure Afficher (V : in T_VECTOR) is
   begin
      Put("[");
        for i in 1..CAPACITE loop

         Put(V(i)'Image);

      end loop;
      Put(" ]");
      New_Line;



    end Afficher;

    function Element ( V : in T_VECTOR ; i : in integer ) return T_Element is
    begin
        return V(i);
    end Element;

    procedure RemplacerElement ( V : in out T_VECTOR ; i : in  integer ; E : in T_Element ) is
    begin
        V(i):=E;
    end RemplacerElement;





end VECTOR;
