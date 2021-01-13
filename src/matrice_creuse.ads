generic
    type T_Element is digits <>;
    CAPACITE : integer;


package MATRICE_CREUSE is

   type T_LIGNE is limited private;
    
    
    -- Initialisation d'une liste a NULL.
    procedure Initialiser (tableau : out T_LIGNE);
    
    -- Fonctionne qui renvoie True si et seulement si lorsque le couple (i,j) est present dans une liste.
    function Est_Present (tableau : in T_LIGNE; i : in Integer; j : in Integer) return Boolean;  
    
    --Cette fonction enregistre une cellule de tel sorte qu'elle respecte l'ordre des elements (cet ordre est defini
    --par la fonction Comparer defini dans Enregistrer) et rend un Booleen True si l'element est deja present dans la liste 
    --Si l'element (i,j) est présent, la valeur correspondante est remplacée par val  
    procedure Enregistrer (tableau : in out T_LIGNE; i : in Integer; j : in Integer; val : in T_Element; Doublon : out Boolean);
    
    procedure RemplacerLigne (tableau : in out T_LIGNE; i : in Integer; occurence : in T_Element; N : in Integer);
    
    -- Procedure utile pour afficher des listes de petite taille, notamment pour les tests.
    procedure Afficher(tableau : in T_LIGNE);
    
private
    
    type T_Cellule;
    
    type T_LISTE is access T_Cellule;
 
    type T_Cellule is 
        record
            Colonne : Integer;
            Valeur : T_Element;
            Suivant : T_LISTE;
        end record;
    
    
    type T_LIGNE is array (0..CAPACITE-1) of T_LISTE;
            
            
end MATRICE_CREUSE;
