generic
    type T_Element is digits <>;
    CAPACITE : integer;

package VECTOR is

    type T_VECTOR is private;


    -- Initialiser un vecteur de taille CAPACITE dont les elements sont N.
    procedure Initialiser (vecteur : out T_VECTOR; N : in T_Element );

    -- Somme usuelle de deux vecteurs.
    procedure Somme (V1 : in T_VECTOR; V2 : in T_VECTOR; V3 : out T_VECTOR);

    -- Produit usuel d'un vecteur par un scalaire.
    procedure Produit_Par_Scalaire (V1 : in out T_VECTOR; lambda : in T_Element) ;

    -- Procedure utile pour effectuer des tests sur des vecteurs de petite capacite.
    procedure Afficher (V : in T_VECTOR);

    -- Fonction qui renvoie l'element i d'un vecteur.
    function Element ( V : in T_VECTOR; i : in integer ) return T_Element with
            Pre => 0 <= i and i < CAPACITE;


    -- Procedure qui remplace l'element i d'un vecteur.
    procedure RemplacerElement ( V : in out T_VECTOR; i : in  integer; E : in T_Element )with
            Pre => 0 <= i and i < CAPACITE;


private

    type T_VECTOR is array (0..CAPACITE-1) of T_Element;

end VECTOR;
