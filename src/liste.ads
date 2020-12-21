package LISTE is

    type T_LISTE is limited private;
    
    
    -- Initialisation d'une liste a NULL.
    procedure Initialiser (liste : out T_LISTE);
    
    -- Fonctionne qui renvoie True si et seulement si lorsque le couple (i,j) est present dans une liste.
    function Est_Present (liste : in T_LISTE; i : in Integer; j : in Integer) return Boolean;  
    
    --Cette fonction enregistre une cellule de tel sorte qu'elle respecte l'ordre des elements (cet ordre est defini
    --par la fonction Comparer defini dans Enregistrer) et rend un Booleen True si l'element est deja present dans la liste 
    procedure Enregistrer (liste : in out T_LISTE ; i : in Integer ; j : in Integer; Doublon : out Boolean);
    
    -- Nous donne acces a l'element I (analogue a un numero de ligne).
    procedure Element_I (liste : in T_LISTE; I: out Integer);
    
    -- Nous donne acces a l'element J (analogue a un numero de colonne).
    procedure Element_J (liste : in T_LISTE; J: out Integer);
    
    -- Nous donne acces a la liste suivante.
    procedure Suivant (liste : in out T_LISTE);
    
    -- Remplace la liste en In par la liste en Out.
    procedure Assigner (listeIn : in T_LISTE; listeOut : out T_LISTE);
    
    -- Procedure utile pour afficher des listes de petite taille, notamment pour les tests.
    procedure Afficher(liste : in T_LISTE);
    
private
    
    type T_Cellule;
    
    type T_LISTE is access T_Cellule;
    
    type T_Cellule is 
        record 
            I : Integer;
            J : Integer;
            Suivant : T_LISTE;
        end record;

end LISTE;
