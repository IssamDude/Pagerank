with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body LISTE is
    
    procedure Free is
            new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LISTE);
    
    procedure Initialiser (liste : out T_LISTE) is
    begin
        liste := null;
    end Initialiser;
    
    
    procedure Enregistrer (liste : in out T_LISTE; i : in Integer; j : in Integer; Doublon : out Boolean) is
        Courant : T_LISTE;
        Precedent :  T_LISTE;
        Temporaire : T_LISTE;
        
        function Comparer(I : in Integer; J : in Integer; K : in Integer; L : in Integer) return Character is
            Resultat : Character;
        begin
            if I > K then
                Resultat := '>';
            elsif I < K then
                Resultat := '<';
            else
                if J > L then
                    Resultat := '>';
                elsif J < L then
                    Resultat := '<';
                else
                    Resultat := '=';
                end if;
            end if;
            return Resultat;
        end Comparer;
        
    begin
        Initialiser(Temporaire);
        Temporaire := new T_Cellule;
        Doublon := False;
        
        if liste = null then
            liste := new T_Cellule'(i, j, null);
            
        elsif Comparer(i, j, liste.all.I, liste.all.J) = '>' then
            Precedent := liste;
            Courant := liste.all.Suivant;
            while Courant /= null and then Comparer(i, j, Courant.all.I, Courant.all.J) = '>'   loop
                Precedent := Courant;
                Courant := Courant.all.Suivant;
            end loop;
            if Courant = null then
                Temporaire.all.I := i;
                Temporaire.all.J := j;
                Temporaire.all.Suivant := null;
                Precedent.all.Suivant := Temporaire;
            elsif Comparer(i, j, Courant.all.I, Courant.all.J) = '=' then
                Doublon := True;
            elsif Comparer(i, j, Courant.all.I, Courant.all.J) = '<' then
                Temporaire.all.I := i;
                Temporaire.all.J := J;
                Temporaire.all.Suivant := Courant;
                Precedent.all.Suivant := Temporaire;
            end if;
            
        elsif Comparer(i, j, liste.all.I, liste.all.J) = '<' then
            Temporaire.all.I := i;
            Temporaire.all.J := j;
            Temporaire.all.Suivant := liste;
            liste := Temporaire;
            
        elsif Comparer(i, j, liste.all.I, liste.all.J) = '=' then
            Doublon := True;
        end if;
    end Enregistrer;
    
    
    function Est_Present (liste : in T_LISTE; i : in Integer; j : in Integer) return Boolean is
        Resultat : Boolean;
    begin
        if liste = null then
            Resultat := False;
        elsif i = liste.all.I and j = liste.all.J then
            Resultat := True;
        else
            Resultat :=  Est_Present(liste.all.Suivant, i, j);   
        end if;
        return Resultat;
    end Est_Present;
    
    
    procedure Element_I (liste : in T_LISTE; I: out Integer) is
    begin
        I := liste.all.I;
    end Element_I;
    
    procedure Element_J (liste : in T_LISTE; J: out Integer) is
    begin
        J := liste.all.J;
    end Element_J;
    
    procedure Suivant (liste : in out T_LISTE) is
    begin
        liste := liste.all.Suivant;
    end Suivant;
    
    
    procedure Assigner (listeIn : in T_LISTE; listeOut : out T_LISTE) is
    begin
        listeOut := listeIn;
    end Assigner;
    
    
    procedure Afficher(liste : in T_LISTE) is
        Courant : T_LISTE;
    begin
        Courant := liste;
        While Courant /= null loop
            put("I: ");
            put(Courant.all.I, 1);
            put(" J: ");
            put(Courant.all.J, 1);
            New_Line;
            Courant := Courant.all.Suivant;
        end loop;
    end Afficher;
    
    
    procedure Vider(liste : in out T_LISTE) is 
    begin
        if liste /= null then
            Vider(liste.all.Suivant);
            Free(liste);
        end if;
    end Vider;

end LISTE;
