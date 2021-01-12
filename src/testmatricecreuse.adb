with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with MATRICE_CREUSE;

procedure testmatricecreuse is
    
    Type T_Double is digits 3 ;
    
    package Matrice_Creuse_Double is
            new MATRICE_CREUSE (T_Element => T_Double, CAPACITE  => 6);
    use Matrice_Creuse_Double;
    
    Tab : T_LIGNE;
    Doublon : Boolean;
    
begin
    
    Initialiser(Tab);
    Enregistrer(Tab, 0, 1, 1.0, Doublon);
    
    Enregistrer(Tab, 0, 5, 1.0, Doublon);
    
    Enregistrer(Tab, 0, 2, 1.0, Doublon);
    Enregistrer(Tab, 5, 1, 1.0, Doublon);
    
    Enregistrer(Tab, 3, 2, 1.0, Doublon);
    Enregistrer(Tab, 5, 1, 3.0, Doublon);
    
    
    Enregistrer(Tab, 3, 2, 1.0, Doublon);
    if Doublon then
        Put_Line ("Element present");
    else
        Put_Line("Non present");
    end if;
    
    
    Afficher(Tab);
   
end testmatricecreuse;
