with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with MATRIX;
with VECTOR;


procedure testprod is
    
    Type T_Double is digits 7 ;
    
    package Vector_integer is
            new Vector (T_Element => T_Double,CAPACITE  => 6);
    use Vector_integer;
    
    package MATRIX_INTEGER is
            new MATRIX (T_Element => T_Double, CAPACITE  => 6);
    use MATRIX_INTEGER;
    
    M: T_MATRIX;
    V : T_VECTOR;
    R : T_VECTOR;
    CAPACITE : integer := 6;
    
    
    procedure vectmatprod ( V : in T_VECTOR ; M : in T_MATRIX ; R : out T_VECTOR ) is -- on a d�j� un vecteur initialis� � 1/capacit� au d�but de l'algo
    begin
        Vector_integer.Initialiser(vecteur => R, N => 0.0);
        for i in 1..CAPACITE loop
            for j in 1..CAPACITE loop
                RemplacerElement(R, j, Element(R,j)+Element(V,j)*Element(M,i,j));
                --Element(R,j):=Element(R,j)+Element(V,j)*Element(M,i,j); -- R est initialis� � des 0 partout ( par exemple )
            end loop;
        end loop;
    end vectmatprod;
    
begin 
    
    Initialiser(2.0, M);
    Initialiser(V, 1.0/6.0);
    vectmatprod(V, M, R);
    Afficher(R);
    
end testprod;
