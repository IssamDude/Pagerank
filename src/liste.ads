package LISTE is

    type T_LISTE is limited private;
    
    procedure Initialiser (liste : out T_LISTE);
    
    function Est_Present (liste : in T_LISTE; i : in Integer; j : in Integer) return Boolean;  
    
    --Cette fonction enregistre une cellule de tel sorte qu'elle respecte l'ordre des elements (cet ordre est defini
    --par la fonction Comparer defini dans Enregistrer) et rend un Booleen True si l'element est deja present dans la liste 
    procedure Enregistrer (liste : in out T_LISTE ; i : in Integer ; j : in Integer; Doublon : out Boolean);
    
    procedure Element_I (liste : in T_LISTE; I: out Integer);
    
    procedure Element_J (liste : in T_LISTE; J: out Integer);
    
    procedure Suivant (liste : in out T_LISTE);
    
    procedure Assigner (listeIn : in T_LISTE; listeOut : out T_LISTE);
    
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
