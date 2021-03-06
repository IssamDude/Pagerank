with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;


package body MATRICE_CREUSE_VECTOR is
    
    
    procedure Free is
            new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LISTE);
    
    procedure Initialiser (vecteur : out T_VECTOR1 ; N : in T_Element ) is
    begin
        for i in 0..CAPACITE-1 loop
            vecteur(i) := N;
        end loop;
    end Initialiser;
    
    
    procedure Somme (V1 : in T_VECTOR1; V2 : in T_VECTOR1; V3 : out T_VECTOR1)is
    begin
        for i in 0..CAPACITE-1 loop
            V3(i) := V1(i) + V2(i);
        end loop;
    end Somme;

    
    
    procedure Produit_Par_Scalaire (V1 : in out T_VECTOR1; lambda : in T_Element) is
    begin
        for i in 0..CAPACITE-1 loop
            V1(i) := lambda * V1(i);
        end loop;
    end Produit_Par_Scalaire;
    
    
    
    procedure Afficher (V : in T_VECTOR1) is
    begin
        Put("[");
        for i in 0..CAPACITE-1 loop
            Put(V(i)'Image);
        end loop;
        Put(" ]");
        New_Line;
    end Afficher;

    
    function Element ( V : in T_VECTOR1; i : in integer ) return T_Element is
    begin
        return V(i);
    end Element;


    procedure RemplacerElement ( V : in out T_VECTOR1 ; i : in  integer ; E : in T_Element ) is
    begin
        V(i):=E;
    end RemplacerElement;

    procedure Initialiser (tableau : out T_Matrice_Creuse) is
    begin
        for i in 0..CAPACITE-1 loop
            tableau(i) := null;
        end loop;
    end Initialiser;
    
    
    
    function Est_Present (tableau : in T_Matrice_Creuse; i : in Integer; j : in Integer) return Boolean is
        
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

    
    
    procedure Enregistrer (tableau : in out T_Matrice_Creuse; i : in Integer; j : in Integer; val : in T_Element; Doublon : out Boolean) is
        
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
    
    
    procedure RemplacerLigne (tableau : in out T_Matrice_Creuse; i : in Integer; occurence : in T_Element) is -- N à supprimer
        Courant : T_LISTE;
    begin
        Courant := tableau(i);
        if Integer(occurence) /= 0 then
            while Courant /= null loop
                Courant.all.Valeur := T_Element(1)/occurence;
                Courant:= Courant.all.Suivant;
            end loop;
        end if;
    end RemplacerLigne;
    
    
    
    
    
    
    
    
    
           
    procedure Afficher(tableau : in T_Matrice_Creuse) is
        
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
    
    procedure vectmatprod_Creuse ( V : in T_VECTOR1; L : in T_Matrice_Creuse; R : out T_VECTOR1; N : in Integer; Alpha : in T_Element ) is -- Multiplication d'un vecteur ligne par une matrice -- CONDITION : nb de colonne du vecteur = taille de la matrice
        Valeur_constante : constant T_Element := 1.0/T_Element(N); -- Valeur_constant = alpha/N + (1-alpha)/N = 1/N.
        Courant : T_LISTE;
       
    begin
        Initialiser(R, 0.0);
        
        for i in 0..N-1 loop
            if L(i) = null then
                for k in 0..N-1 loop
                    R(k):=R(k)+V(i)*Valeur_constante;
                    --RemplacerElement(R,k,Element(R,k)+Element(V,k)*Valeur_constante);
                end loop;
                
            else
                Courant := L(i);
                for k in 0..N-1 loop
                    if Courant /= null then
                        if Courant.all.Colonne = k then
                            R(k):=R(k)+V(i)*(Alpha*Courant.all.Valeur + ( (1.0-Alpha)/T_Element(N) ) ) ;
                            --RemplacerElement(R, k, Element(R,k) + Element(V,k) * (Alpha * Courant.all.Valeur + ( (1.0-Alpha) / T_Element(N) ) ));
                            Courant := Courant.all.Suivant;
                        else
                            R(k):=R(k)+V(i)*( (1.0-Alpha) / T_Element(N) );
                            --RemplacerElement(R, k, Element(R, k) + Element(V, k) * ( (1.0-Alpha) / T_Element(N) ) );
                        end if;
                       
                    else
                        R(k):=R(k)+V(i)*( (1.0-Alpha) / T_Element(N) ) ;
                        --RemplacerElement(R, k, Element(R, k) + Element(V, k) * ( (1.0-Alpha) / T_Element(N) ) );
                    end if;
                    
                end loop;
                
            end if;
            --afficher(R);
            
            
        end loop;
    end vectmatprod_Creuse;
    
    
    
    function Est_nul_Liste (L : in T_Matrice_Creuse; i : in Integer) return Boolean is 
    begin
        return L(i) = null;
    end Est_nul_Liste;
    
    
    
    procedure Vider (L : in out  T_Matrice_Creuse) is
        procedure Vider_Liste(liste : in out T_LISTE) is 
        begin
            if liste /= null then
                Vider_Liste(liste.all.Suivant);
                Free ( liste );
            end if;
        end Vider_Liste;
    begin
        for k in 0..CAPACITE-1 loop
            Vider_Liste(L(k));
        end loop;
    end Vider;
    
    
end MATRICE_CREUSE_VECTOR;
