with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with MATRIX;
with VECTOR;
with LISTE; use LISTE;
with Command_Exception; use Command_Exception;

procedure Main is

    Type T_Double is digits 6; -- Precision variable, grace a la generecite du type T_Element.

    function "+" (Item : in String) return Unbounded_String
                  renames To_Unbounded_String;

    function "-" (Item : in Unbounded_String) return String
                  renames To_String;

    NN : Integer;  -- Le nombre de noeuds de notre reseau, indique dans la premiere ligne de tous les fichiers.net
    Elm_Fichier: Integer; -- Entiers present dans les fichiers.net
    F: File_Type; -- Fichier.net
    NomF : Unbounded_String := +"worm.net";
    Alpha : T_Double := 0.85; -- qu'il faut changer en fonction de la ligne de commande
    Nb_Iteration : integer := 150; -- qu'il faut changer en fonction de la ligne de commande
    Implantation : Unbounded_String := +"Creuse";
    Nb_Argument : Integer;



    procedure Gestion_Command (Nb_Argument : in Integer) is

        Taille_nom_fichier : Integer;
        Compt : Integer := 0;
        Nb_I : Integer := 0;
        Nb_A : Integer := 0;
        Nb_P : Integer := 0;

    begin
        --for I in 1..Nb_Argument loop
            --Put_Line("Argument" & Natural'Image(I) & ": " & Argument(I)) ;
        --end loop;

        Taille_nom_fichier := Length(+Argument(Nb_Argument));
        if Nb_Argument > 0 and Nb_Argument <= 6 then
            if element(+Argument(Nb_Argument),Taille_nom_fichier - Compt) /= 't' then
                raise Parametre_Command_Exception;
            else
                Compt := Compt + 1;
            end if;
            if element(+Argument(Nb_Argument),Taille_nom_fichier - Compt) /= 'e' then
                raise Parametre_Command_Exception;
            else
                Compt := Compt + 1;
            end if;
            if element(+Argument(Nb_Argument),Taille_nom_fichier - Compt) /= 'n' then
                raise Parametre_Command_Exception;
            else
                Compt := Compt + 1;
            end if;
            if element(+Argument(Nb_Argument),Taille_nom_fichier - Compt) /= '.' then
                raise Parametre_Command_Exception;
            else
                Compt := Compt + 1;
            end if;
            NomF := +Argument(Nb_Argument);

            for K in 1..Nb_Argument-1 loop
                if Argument(K) = "-I" then
                    if Integer'Value(Argument(K+1)) > 0 and Nb_I = 0 then
                        Nb_Iteration := Integer'Value(Argument(K+1));
                        Nb_I := Nb_I + 1;
                    else
                        raise Parametre_Command_Exception;
                    end if;
                elsif Argument(K) = "-A" then
                    if T_Double'Value(Argument(K+1)) >= 0.0 and T_Double'Value(Argument(K+1)) <= 1.0 and Nb_A = 0 then
                        Alpha := T_Double'Value(Argument(K+1));
                        Nb_A := Nb_A + 1;
                    else
                        raise Parametre_Command_Exception;
                    end if;
                elsif Argument(K) = "-P" then
                    if Nb_P = 0 then
                        Implantation := +"Naive";
                        Nb_P := Nb_P + 1;
                    else
                        raise Parametre_Command_Exception;
                    end if;
                end if;
            end loop;
        else
            raise Parametre_Command_Exception;
        end if;

    exception
        when Constraint_Error =>
            raise Parametre_Command_Exception;
    end Gestion_Command;


    Procedure Naive (N : in integer) is  -- Notre procedure principale, prend en argument N qui est NN : Le nombre de noeuds de notre reseau.
        package MATRIX_INTEGER is
                new MATRIX (T_Element => T_Double, CAPACITE  => N);
        use MATRIX_INTEGER;

        package Vector_integer is
                new Vector (T_Element => T_Double, CAPACITE  => N);
        use Vector_integer;

        H : T_MATRIX; -- Matrice naive que l'on va manipuler tout le long du programme
        OCC : T_VECTOR;  -- Vecteur dans lequel on met le nombre d'occurence de chaque noeud
        CAPACITE :constant Integer := N; -- Capacite du type vecteur et matrice
        I : Integer; -- Ligne de la matrice H/ Element de la premiere colonne du fichier
        J : Integer; -- Colonne de la matrice H/ Element de la deuxieme colonne du fichier
        Elm_Fichier : Integer; --Entier qui stocke les elements qu'on recupere des fichiers
        F: File_Type; --Fichier qu'on va ouvrir
        NL : Integer; -- Nombre de lignes du fichier
        N_T_Double : constant T_Double := T_Double(N); -- Variable qui stocke la conversion de l'entier N en T_Double.
        Pk: T_VECTOR; -- Vecteur poids
        Pk1: T_VECTOR;
        --Pr: T_VECTOR; --pagerank vector
        Fichier : T_LISTE; --Liste qui va contenir les elements du fichier.net tries sans les doublons
        Courant : T_LISTE;
        Test_Doublon : Boolean;



        procedure vectmatprod ( V : in T_VECTOR ; M : in T_MATRIX ; R : out T_VECTOR ) is -- Multiplication d'un vecteur ligne par une matrice -- CONDITION : nb de colonne du vecteur = taille de la matrice
        begin
            Initialiser(R, 0.0);
            for i in 0..CAPACITE-1 loop
                for j in 0..CAPACITE-1 loop
                    RemplacerElement(R, i, (Element(R,i)+Element(V,j)*Element(M,j,i)) );
                end loop;
            end loop;
        end vectmatprod;


    begin

        --Dans cette partie de code, on lit le fichier.net et on recupere la matrice H et le vecteur OCC qui contient le nombre d'occurence de chaque noeud
        Initialiser(Pk, 1.0/N_T_Double); -- Le vecteur poids est initialise a 1/CAPACITE;
        --Put_Line("Vecteur poids initial : ");
        --Afficher(Pk);
        Initialiser(0.0, H); -- La matrice H est initialisé à 0 partout.
        Initialiser(OCC,0.0); -- Le vecteur occurence aussi.
        NL := 0; -- Compteur de nombres de lignes
        Initialiser(Fichier); --Initialise la liste qui va contenir les doublons dans le fichier.net

        Open(F,In_File,-NomF);
        Get(F,Elm_Fichier); --On fait un premier get car on a deja recuperer la valeur de NN en dehors de la procedure Calcul, voir ligne 152 ( ATTENTION SI LA LIGNE CHANGE )


        ------------------------------------------------------------------------ Premier parcours du fichier.net pour créer la matrice d'adjacence H du sujet.

        while not End_Of_File(F) loop -- Tout le long du fichier, c'est a dire tant qu'on est pas a la fin du fichier, on repete ce qui suit :
            Get(F,Elm_Fichier);
            I:=Elm_Fichier; -- On stocke dans I l'element de la premiere colonne
            Get(F,Elm_Fichier);
            J:=Elm_Fichier; -- On stocke dans J l'element de la deuxième colonne
            Enregistrer (Fichier, I, J, Test_Doublon); -- On les enregistre dans la liste Fichier et on detecte si c'est un doublon ou non.
            if Test_Doublon then
                NL := NL + 1; -- Si c'etait un doublon, on incremente  quand meme le nombre de ligne.
            else
                NL:=NL+1;  -- Si pas de doublon, on incremente le nombre de ligne.
                RemplacerElement(OCC,I, Element(OCC,I)+1.0); -- L'element I du vecteur OCC est incremente de un, on compte ainsi combien d'element non nuls nous aurons dans chaque ligne de la matrice H : OCC(I) = Nombre d'elements non nuls dans la ligne I de la matrice H.
                RemplacerElement(H, I, J, 1.0); -- Lors de ce premier parcours du fichier.net, a chaque ligne du fichier on recupere I et J, et on met 1.0 dans l'element de coordonnees (I,J)
            end if;

        end loop;
        Close(F);  -- Pour ne pas encombrer la memoire, on ferme le fichier.net

        -- Pour visionner ce qui se passe sur des fichier .net avec peu de noeuds ( moins de 10 ), decommentez les lignes suivantes :

        --Put_Line("La Matrice H : ");
        --New_Line;
        --Afficher(H);
        --New_Line;
        --Put_Line("Le vecteur d'occurrences OCC :");
        --Afficher(OCC);
        --New_Line;

        ------------------------------------------------------------------------ Deuxieme parcours du fichier parcours pour passer de la matrice H à S.

        Open(F,In_File,-NomF);
        Get(F,Elm_Fichier); --On fait un premier get car on a deja recuperer la valeur de NN en dehors de la procedure Calcul

        Initialiser(Courant);

        Assigner(Fichier, Courant);

        for K in 0..N-1 loop
            if Element(OCC,K) = 0.0 then -- Ici, les lignes vides de la matrice H vont toutes avoir comme valeurs le float 1/Nombre_de_noeuds.

                for L in 0..N-1 loop
                    RemplacerElement(H, K, L, (1.0/N_T_Double));
                end loop;
            else   -- Ici, les lignes non vides de la matrice H vont avoir les elements non nuls changes de 1.0 au reel 1/Le_nombre_de_1.0_dans_la_ligne
                for L in 1..Integer(Element(OCC, K)) loop
                    Element_I (Courant, I);
                    Element_J (Courant, J);
                    Suivant (Courant);
                    RemplacerElement(H, I, J, 1.0/Element(OCC, I));
                end loop;
            end if;
        end loop;
        Close(F);

        -- Pareil, decommentez les lignes suivantes si vous souhaitez voir ce changement sur des petites matrices.

        --Afficher(H); -- Qui est en fait la matrice S
        --New_Line;

        --Dans cette partie, on modifie la matrice S pour obtenir la matrice G

        Produit_Par_Scalaire(H,Alpha);

        --Afficher(H);
        Ajoutconstante(H, (1.0-alpha)/N_T_Double);
        --Put_Line("Matrice G");
        --Afficher(H); -- Qui est en fait la matrice G.

        ------------------------------------------------------------------------ On calcule matriciellement le poids de chaque noeud.
        for k in 1..Nb_Iteration loop
            vectmatprod(Pk, H, Pk1);
            Pk := Pk1;
        end loop;

        Put_Line("Vecteur poids final : ");
        New_line;
        Afficher(Pk);
        New_line;

    end Naive;

    procedure Creuse is
    begin
        Put_Line("Implantation Creuse pas encore prete. Veuillez ajouter -P dans la ligne de commande pour utiliser l'implantation Naive");
    end Creuse;

begin

    Nb_Argument := Argument_Count;
    Gestion_Command(Nb_Argument);

    Open(F,In_File,-NomF);
    Get(F,Elm_Fichier); -- On GET le premier nombre du fichier.net qui correspond au nombre de noeuds NN.
    NN:=Elm_Fichier; -- On stocke ce nombre.
    Close(F);


    if Implantation = +"Naive" then
        Naive(NN);
    elsif Implantation = +"Creuse" then
        Creuse;
    end if;


    Put("Le nombre de noeuds est : ");
    Put(NN, 1);
    New_Line;
    Put("Nb iterations : ");
    Put(Nb_Iteration, 1);
    New_Line;
    Put("Alpha : ");
    Put(Alpha'Image);
    New_Line;

exception
    when Parametre_Command_Exception =>
        Put_Line("Erreur: Les parametres entres dans la ligne de commande sont incompatibles");
    when Name_Error =>
        Put_Line("Erreur: Le fichier entre n'est pas present dans le repertoire");
end Main;

