with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with MATRIX;
with VECTOR;
with LISTE; use LISTE;
with Command_Exception; use Command_Exception;
with MATRICE_CREUSE_VECTOR;



procedure test_produit_creux is
    Type T_Double is digits 6; -- Precision variable, grace a la generecite du type T_Element.
    N : integer :=6;
    package Matrice_Creuse_Double is
            new MATRICE_CREUSE_VECTOR (T_Element => T_Double, CAPACITE  => N);
    use Matrice_Creuse_Double;
    H_Creuse : T_Tableau_des_lignes;
    FichierNet : File_Type;
    Elm_Fichier : Integer;
    I : Integer;
    J : Integer;
    Test_Doublon : Boolean;
    OCC : T_VECTOR1;
    Pk: T_VECTOR1; -- Vecteur poids
    Pk1: T_VECTOR1;
    N_T_Double : constant T_Double := T_Double(N);
    alpha : T_Double := 0.85;
    Iter : Integer := 4;
    
begin
    Initialiser(H_Creuse);
    Open(FichierNet, In_File, "exemple_sujet.net");
    Get(FichierNet, Elm_Fichier);
    Initialiser(OCC, 0.0);
    Initialiser(Pk, 1.0/N_T_Double);
    Initialiser(Pk1, 0.0);
    
    While not End_Of_File(FichierNet) loop
        Get(FichierNet, Elm_Fichier);
        I := Elm_Fichier;
        Get(FichierNet, Elm_Fichier);
        J := Elm_Fichier;
        Enregistrer(H_Creuse, I, J, T_Double(1), Test_Doublon);
        if Test_Doublon then
            null;
        else
            RemplacerElement(OCC, I, Element(OCC, I) + 1.0);
        end if;
    end loop;
    Close(FichierNet);
    
    
    --Passer de la matrice H_Creuse Ã  S_Creuse
    
    for l in 0..N-1 loop
        RemplacerLigne(H_Creuse, l, Element(OCC, l));
    end loop;
    
    Afficher(H_Creuse);
    
    
    
    for k in 1..Iter loop
    vectmatprod_Creuse(Pk, H_Creuse, Pk1, N, alpha); -- La première itération qui donne un résultat correct
    Pk := Pk1;
    afficher(Pk);
    end loop;
        --Afficher(H_Creuse);
    --vectmatprod_Creuse(Pk, H_Creuse, Pk1, N, alpha); -- La deuxième itération qui donne un résultat faux.
    --Pk:=Pk1;
    --Afficher(Pk);
    --Afficher(H_Creuse);
    --end loop;
    
    
    
    
    
    
    
end test_produit_creux;
