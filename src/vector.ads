generic
    type T_Element is digits <>;
    CAPACITE : integer;

package VECTOR is

    type T_VECTOR is private;


    procedure Initialiser (vecteur : out T_VECTOR; N : in T_Element );

    procedure Somme (V1 : in T_VECTOR; V2 : in T_VECTOR; V3 : out T_VECTOR);

    procedure Produit_Par_Scalaire (V1 : in out T_VECTOR; lambda : in T_Element) ;

    procedure Afficher (V : in T_VECTOR);

    function Element ( V : in T_VECTOR; i : in integer ) return T_Element; -- pré condition 1<=i<=Capacité

    procedure RemplacerElement ( V : in out T_VECTOR; i : in  integer; E : in T_Element );


private

    type T_VECTOR is array (0..CAPACITE-1) of T_Element;

end VECTOR;
