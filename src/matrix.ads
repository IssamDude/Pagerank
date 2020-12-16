
generic
   -- type reel de precision quelconque
   type T_Element is digits <>;
   CAPACITE : integer;


package MATRIX is

   --Type T_Double is digits 6 ; --Modifiable
   type T_MATRIX is  private;


   -- Initialiser une matrice carre de taille CAPACITE dont les elements sont N.
   procedure Initialiser (N : in T_Element; M : out T_MATRIX);

   -- Initialiser une matrice carre de taille CAPACITE dont les elements sont 0.
   procedure Initialiser (M : out T_MATRIX);

   -- Somme usuelle de deux matrices.
   procedure Somme (M1 : in T_MATRIX; M2 : in T_MATRIX; M : out T_MATRIX);

   -- Produit d'une matrice par un scalaire.
   procedure Produit_Par_Scalaire (M : in out T_MATRIX; lambda : in T_Element);

   -- Procedure utile pour les tests sur les matrices de petite capacite
   procedure Afficher (M : in T_MATRIX);







private

    type T_MATRIX is array (1..CAPACITE, 1..CAPACITE) of T_Element;



end MATRIX;
