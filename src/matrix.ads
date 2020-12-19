generic
    type T_Element is digits <>;
    CAPACITE : integer;

package MATRIX is

    type T_MATRIX is  private;


    -- Initialiser une matrice carre de taille CAPACITE dont les elements sont N.
    procedure Initialiser (N : in T_Element; M : out T_MATRIX);

    -- Initialiser une matrice carre de taille CAPACITE dont les elements sont 0.
    procedure Initialiser (M : out T_MATRIX);

    -- Somme usuelle de deux matrices.
    procedure Somme (M1 : in T_MATRIX; M2 : in T_MATRIX; M : out T_MATRIX);

    -- Produit d'une matrice par un scalaire.
    procedure Produit_Par_Scalaire (M : in out T_MATRIX; lambda : in T_Element);

    -- Procedure utile pour les tests sur les matrices de petite capacite
    procedure Afficher (M : in T_MATRIX);

    function Element ( M : in T_MATRIX; i : in integer; j : in integer ) return T_Element ; -- pré condition 1<=i<=Capacité

    procedure RemplacerElement (M : in out T_MATRIX; i : in  integer; j : in Integer; E : in T_Element );

    procedure Ajoutconstante ( M : in out T_MATRIX ; a : in T_Element ) ;

private

    type T_MATRIX is array (0..CAPACITE-1, 0..CAPACITE-1) of T_Element;

end MATRIX;
