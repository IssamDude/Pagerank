generic
    type T_Element is digits <>;
    CAPACITE : integer;


package MATRICE_CREUSE_VECTOR is
   

    type T_Tableau_des_lignes is  private;
    
    type T_VECTOR1 is private;
    
    
    -- Initialiser un vecteur de taille CAPACITE dont les elements sont N.
    procedure Initialiser (vecteur : out T_VECTOR1; N : in T_Element );
    
    -- Somme usuelle de deux vecteurs.
    procedure Somme (V1 : in T_VECTOR1; V2 : in T_VECTOR1; V3 : out T_VECTOR1);
    
    -- Produit usuel d'un vecteur par un scalaire.
    procedure Produit_Par_Scalaire (V1 : in out T_VECTOR1; lambda : in T_Element) ;
    
    -- Procedure utile pour effectuer des tests sur des vecteurs de petite capacite.
    procedure Afficher (V : in T_VECTOR1);
    
    -- Fonction qui renvoie l'element i d'un vecteur.
    function Element ( V : in T_VECTOR1; i : in integer ) return T_Element with
            Pre => 0 <= i and i < CAPACITE;
    
    
    -- Procedure qui remplace l'element i d'un vecteur.
    procedure RemplacerElement ( V : in out T_VECTOR1; i : in  integer; E : in T_Element )with
            Pre => 0 <= i and i < CAPACITE;
    
    
    -- Initialisation d'une liste a NULL.
    procedure Initialiser (tableau : out T_Tableau_des_lignes);
    
    -- Fonctionne qui renvoie True si et seulement si lorsque le couple (i,j) est present dans une liste.
    function Est_Present (tableau : in T_Tableau_des_lignes; i : in Integer; j : in Integer) return Boolean;  
    
    --Cette fonction enregistre une cellule de tel sorte qu'elle respecte l'ordre des elements (cet ordre est defini
    --par la fonction Comparer defini dans Enregistrer) et rend un Booleen True si l'element est deja present dans la liste 
    --Si l'element (i,j) est présent, la valeur correspondante est remplacée par val  
    procedure Enregistrer (tableau : in out T_Tableau_des_lignes; i : in Integer; j : in Integer; val : in T_Element; Doublon : out Boolean);
    
    procedure RemplacerLigne (tableau : in out T_Tableau_des_lignes; i : in Integer; occurence : in T_Element);
    
    -- Procedure utile pour afficher des listes de petite taille, notamment pour les tests.
    procedure Afficher(tableau : in T_Tableau_des_lignes);
    
    procedure vectmatprod_Creuse ( V : in T_VECTOR1; L : in T_Tableau_des_lignes; R :  out T_VECTOR1; N : in Integer; Alpha : in T_Element );
    
    function Est_nul_Liste (L : in T_Tableau_des_lignes; i : in Integer) return Boolean;
    
private
    
    type T_VECTOR1 is array (0..CAPACITE-1) of T_Element;              
                               
    type T_Cellule;
    
    type T_LISTE is access T_Cellule;
    
    type T_Cellule is 
        record
            Colonne : Integer;
            Valeur : T_Element;
            Suivant : T_LISTE;
        end record;
    
    
    type T_Tableau_des_lignes is array (0..CAPACITE-1) of T_LISTE;
    
            
end MATRICE_CREUSE_VECTOR;
