with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Command_Line; use  Ada.Command_Line;
with MATRIX;
with VECTOR;

procedure Main is

    Type T_Double is digits 6;

    NN : Integer;
    Elm_Fichier: Integer;
    F: File_Type;

    Procedure Calcul (N : in integer) is
        package MATRIX_INTEGER is
                new MATRIX (T_Element => T_Double, CAPACITE  => N);
        use MATRIX_INTEGER;

        package Vector_integer is
                new Vector (T_Element => T_Double, CAPACITE  => N);
        use Vector_integer;

        H : T_MATRIX;
        OCC : T_VECTOR; --Vecteur dans lequel on met le nombre d'occurence de chaque noeud
        CAPACITE : Integer := N; -- Capacite du type vecteur et matrice
        I : Integer; -- Ligne de la matrice H/ Element de la premiere colonne du fichier
        J : Integer; -- Colonne de la matrice H/ Element de la deuxieme colonne du fichier
        Elm_Fichier : Integer; --Entier qui stocke les elements qu'on recupere des fichiers
        Elm_Fichier_Temporaire_I : Integer;
        Elm_Fichier_Temporaire_J : Integer;
        F: File_Type; --Fichier qu'on va ouvrir
        NL : Integer; -- Nombre de lignes du fichier
        N_T_Double : T_Double := T_Double(N);
        Alpha : T_Double := 0.85; -- qu'il faut changer en fonction de la ligne de commande
        --v: T_Double :=0.0;
        Nb_Iteration : integer := 150; -- qu'il faut changer en fonction de la ligne de commande
        Pk: T_VECTOR; -- Vecteur poids
        Pk1: T_VECTOR;
        --Pr: T_VECTOR; --pagerank vector


        procedure vectmatprod ( V : in T_VECTOR ; M : in T_MATRIX ; R : out T_VECTOR ) is -- on a d�j� un vecteur initialis� � 1/capacit� au d�but de l'algo
        begin
            Initialiser(R, 0.0);
            for i in 0..CAPACITE-1 loop
                for j in 0..CAPACITE-1 loop
                    RemplacerElement(R, i, Element(R,i)+Element(V,j)*Element(M,j,i));
                end loop;
            end loop;
        end vectmatprod;


    begin

        --Dans cette partie de code, on lit le fichier.net et on recupere la matrice H et le vecteur OCC qui contient le nombre d'occurence de chaque noeud
        Initialiser(Pk, 1.0/N_T_Double); -- Le vecteur poids est initialisé à 1/capacite
        Put_Line("Vecteur poids initial : ");
        Afficher(Pk);
        Initialiser(0.0, H);
        Initialiser(OCC,0.0);
        NL := 0; -- Compteur de nombres de lignes

        Open(F,In_File,"exemple_sujet.net");
        Get(F,Elm_Fichier); --On fait un premier get car on a deja recuperer la valeur de NN en dehors de la procedure Calcul


        --Les 7 prochaines lignes sont ecrite pour pouvoir gerer la presence de doublon dans le fichier
        --Les variables Elm_Fichier_Temporaire stockent les valeurs de I et J qui precede pour pouvoir les comparer avec les valeurs actuelles
        Get(F,Elm_Fichier);
        Elm_Fichier_Temporaire_I:=Elm_Fichier;
        Get(F,Elm_Fichier);
        Elm_Fichier_Temporaire_J:=Elm_Fichier;
        RemplacerElement(H, Elm_Fichier_Temporaire_I, Elm_Fichier_Temporaire_J, 1.0);
        RemplacerElement(OCC,Elm_Fichier_Temporaire_I, Element(OCC,Elm_Fichier_Temporaire_I)+1.0);
        NL := NL + 1;

        while not End_Of_File(F) loop
            Get(F,Elm_Fichier);
            I:=Elm_Fichier;
            Get(F,Elm_Fichier);
            J:=Elm_Fichier;
            if (Elm_Fichier_Temporaire_I = I and Elm_Fichier_Temporaire_J = J) then
                NL := NL +1;
            else
                RemplacerElement(H, I, J, 1.0);
                NL:=NL+1;
                RemplacerElement(OCC,I, Element(OCC,I)+1.0);
                Elm_Fichier_Temporaire_I := I;
                Elm_Fichier_Temporaire_J := J;
            end if;
        end loop;
        Close(F);

        Put_Line("La Matrice H : ");
        New_Line;
        Afficher(H);
        New_Line;
        Put_Line("Le vecteur d'occurrences OCC :");
        Afficher(OCC);
        New_Line;


        --Dans cette partie on relit le fichier.net pour modifier la matrice H et obtenir la matrice S

        Open(F,In_File,"exemple_sujet.net");
        Get(F,Elm_Fichier); --On fait un premier get car on a deja recuperer la valeur de NN en dehors de la procedure Calcul

        for K in 0..N-1 loop
            if Element(OCC,K) = 0.0 then
                for L in 0..N-1 loop
                    RemplacerElement(H, K, L, (1.0/N_T_Double));
                end loop;
            else
                for L in 1..Integer(Element(OCC, K)) loop
                    Get(F,Elm_Fichier);
                    I:=Elm_Fichier;
                    Get(F,Elm_Fichier);
                    J:=Elm_Fichier;
                    RemplacerElement(H, I, J, 1.0/Element(OCC, I));
                end loop;
            end if;
        end loop;
        Close(F);
        Afficher(H); -- Qui est en fait la matrice S
        New_Line;



        Produit_Par_Scalaire(H,Alpha);
        New_Line;
        Afficher(H); -- Qui est enfait le premier terme de la matrice G
        New_Line;
        Ajoutconstante(H, (1.0-alpha)/N_T_Double);
        Put_Line("Matrice G");
        Afficher(H); -- Qui est en fait la matrice G.

        -- Algorithme du pagerank :
        for k in 1..Nb_Iteration loop
            vectmatprod(Pk, H, Pk1);
            Pk := Pk1;
        end loop;
        New_Line;
        Put_Line("Vecteur poids final : ");
        New_line;
        Afficher(Pk);


    end Calcul;


begin


    Open(F,In_File,"exemple_sujet.net");
    Get(F,Elm_Fichier); -- On GET le premier nombre du fichier.net qui correspond au nombre de noeuds NN.
    NN:=Elm_Fichier; -- On stocke ce nombre.
    Put("Le nombre de noeuds est : ");
    Put(NN, 1);
    New_Line;
    Close(F);
    Calcul(NN);






end Main;

