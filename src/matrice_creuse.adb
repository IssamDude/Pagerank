with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;

package body MATRICE_CREUSE is

    procedure Initialiser (tableau : out T_LIGNE) is
    begin
        for i in 0..CAPACITE-1 loop
            tableau(i) := null;
        end loop;
    end Initialiser;
    
    
    
    function Est_Present (tableau : in T_LIGNE; i : in Integer; j : in Integer) return Boolean is
        
        function Est_Present_liste (liste : in T_LISTE; j : in Integer) return Boolean is
            Resultat : Boolean;
        begin
            if liste = null then
                Resultat := False;
            elsif j = liste.all.Colonne then
                Resultat := True;
            else
                Resultat :=  Est_Present_liste(liste.all.Suivant, j);   
            end if;
            return Resultat;
        end Est_Present_liste;
        
    begin
        return Est_Present_liste(tableau(i), j);
        
    end Est_Present;

    
    
    procedure Enregistrer (tableau : in out T_LIGNE; i : in Integer; j : in Integer; val : in T_Element; Doublon : out Boolean) is
        
        procedure Enregistrer_Liste (liste : in out T_LISTE; j : in Integer; val : in T_Element; Doublon : out Boolean) is
        Courant : T_LISTE;
        Precedent :  T_LISTE;
        Temporaire : T_LISTE;
        begin
            Temporaire := new T_Cellule;
            Doublon := False;
            
            if liste = null then
                liste := new T_Cellule'(j, val, null);
                
            elsif j > liste.all.Colonne then
                Precedent := liste;
                Courant := liste.all.Suivant;
                while Courant /= null and then j > Courant.all.Colonne loop
                    Precedent := Courant;
                    Courant := Courant.all.Suivant;
                end loop;
                if Courant = null then
                    Temporaire.all.Colonne := j;
                    Temporaire.all.Valeur := val;
                    Temporaire.all.Suivant := null;
                    Precedent.all.Suivant := Temporaire;
                elsif j = Courant.all.Colonne then
                    Doublon := True;
                    Courant.all.Valeur := val;
                elsif j < Courant.all.Colonne then
                    Temporaire.all.Colonne := j;
                    Temporaire.all.Valeur := val;
                    Temporaire.all.Suivant := Courant;
                    Precedent.all.Suivant := Temporaire;
                end if;
                
            elsif j < liste.all.Colonne then
                Temporaire.all.Colonne := j;
                Temporaire.all.Valeur := val;
                Temporaire.all.Suivant := liste;
                liste := Temporaire;
                
            elsif j = liste.all.Colonne then
                Doublon := True;
                liste.all.Valeur := val;
            end if;
        end Enregistrer_Liste;
        
    begin
        Enregistrer_Liste(tableau(i), j, val, Doublon);
        
    end Enregistrer;
    
    
    procedure RemplacerLigne (tableau : in out T_LIGNE; i : in Integer; occurence : in T_Element;  : in : Integer) is
        Courant : T_LISTE;
    begin
        Courant := tableau(i);
        if Integer(occurence) = 0 then
            for k in 0..N-1 loop
                Courant := new T_Cellule'(k, T_Element(1/N), null);
                Courant := Courant.all.Suivant;
            end loop;
        else
            while Courant /= null loop
                Courant.all.Valeur := T_Element(1/occurence);
                Courant:= Courant.all.Suivant;
            end loop;
        end if;
    end RemplacerLigne;
    
    
    
    
    
    
    
    
    
           
    procedure Afficher(tableau : in T_LIGNE) is
        
        procedure Afficher_Liste(liste : in T_LISTE; i : in Integer) is
            Courant : T_LISTE;
        begin
            Courant := liste;
            While Courant /= null loop
                put("I: ");
                put(i, 1);
                put(" J: ");
                put(Courant.all.Colonne, 1);
                put(" Val:");
                put(Courant.all.Valeur'Image);
                Courant := Courant.all.Suivant;
                if Courant /= null then
                    New_Line;
                end if;
            end loop;
        end Afficher_Liste;
        
    begin
        
        New_Line;
        for i in 0..CAPACITE-1 loop
            Put("[");
            Afficher_Liste(tableau(i), i);
            Put(" ]");
            New_Line;
        end loop;
        New_Line;
    end Afficher;
    
    
    
    
    
end MATRICE_CREUSE;
