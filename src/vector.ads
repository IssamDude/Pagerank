

generic
    type T_Element is digits <>;
    CAPACITE : integer;

package VECTOR is

    type T_VECTOR is private;




    procedure Initialiser (vecteur : out T_VECTOR);

    procedure Somme (V1 : in T_VECTOR; V2 : in T_VECTOR; V3 : out T_VECTOR);

    procedure Produit_Par_Scalaire (V1 : in out T_VECTOR; lambda : in T_Element) ;

    procedure Afficher (V : in T_VECTOR);



private

    type T_VECTOR is array (1..CAPACITE) of T_Element;



end VECTOR;
