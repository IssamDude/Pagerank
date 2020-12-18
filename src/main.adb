with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with MATRIX;
with VECTOR;

procedure Main is

    Type T_Double is digits 6;

    NN : Integer;
    C: Integer;

    Procedure Calcul (N : in integer) is
        package MATRIX_INTEGER is
                new MATRIX (T_Element => T_Double, CAPACITE  => N);
        use MATRIX_INTEGER;

        package Vector_integer is
                new Vector (T_Element => T_Double, CAPACITE  => N);
        use Vector_integer;

        H : T_MATRIX;
        OCC : T_VECTOR;
        CAPACITE : integer := N;

        procedure vectmatprod ( V : in T_VECTOR ; M : in T_MATRIX ; R : out T_VECTOR ) is -- on a d�j� un vecteur initialis� � 1/capacit� au d�but de l'algo
        begin
            Vector_integer.Initialiser(vecteur => R, N=> 0.0);
            for i in 1..CAPACITE loop
                for j in 1..CAPACITE loop
                    RemplacerElement(R, j, Element(R,j)+Element(V,j)*Element(M,i,j));
                end loop;
            end loop;
        end vectmatprod;

    begin

        Initialiser(0.0, H);
        Initialiser(OCC,0.0);

        while not End_Of_File(F) loop
            Get(F,C); -- on lit un entier dans
            I:=C;
            Get(F,C);
            J:=C;
            --On doit ecrire des procedures RemplacerElement dans Matrix pour pouvoir ecrire la ligne suivante
            H(I,J):=1.0; -- à changer REMPLIER LE FICHIER OCCURENCE -- RELECTURE DES FICHIERS POUR CHANGER 1 EN 1 / OCC(I) et les 0 en 1/CAPACITE POUR OBTENIR MATRICE S
                         -- G = alpha*S + (1-alpha)*(1/capacite)*ones(capacite)
            if End_Of_Line(F) then
                NL:=NL+1;
                RemplacerElement(OCC,I, Element(OCC,I)+1.0);
                New_line;
            end if;
        end loop;

    end Calcul;



begin


    Open(F,In_File,"exemple_sujet.net");
    Get(F,C); -- On GET le premier nombre du fichier.net qui correspond au nombre de noeuds NN.
    NN:=C; -- On stocke ce nombre.
    Calcul(NN);




end Main;

