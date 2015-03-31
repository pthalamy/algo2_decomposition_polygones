with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;

with Ada.Unchecked_Deallocation;

generic
   type Type_Clef is private;
   with function ">"(Left, Right : in Type_Clef) return Boolean is <>;
   with procedure Put (X : in Type_Clef) is <>;
package Generic_ABR is
         
   type Noeud;
   type Arbre is access Noeud;
   type Direction is (Gauche , Droite);
   type Tableau_Fils is array(Direction) of Arbre; 
   type Noeud is record 
      C : Type_Clef;
      Fils : Tableau_Fils;
      Pere : Arbre;
      Compte : Positive; -- nombre de noeuds dans le sous−arbre 
   end record;
   type MAJ is range -1 .. 1;
   
   procedure Insertion (A : in out Arbre; C : in Type_Clef; N : out Arbre);
   
   procedure Suppression (A : in out Arbre; C : in Type_Clef);
   
   procedure Recherche (A : in Arbre; 
			C : in Type_Clef;
			R : out Arbre);
   
   procedure Affichage (A : in Arbre);

   procedure Export_Dot (A : in Arbre);
   
   procedure Noeuds_Voisins (Cible : in Arbre; 
			     Petit_Voisin, Grand_Voisin : out Arbre);

   
   procedure Compte_Position (Cible : in Arbre; 
			      Nb_Petits : out Natural; 
			      Nb_Grands : out Natural);
   
   
private
   
   procedure Put (N : Noeud);
   
end Generic_ABR;
