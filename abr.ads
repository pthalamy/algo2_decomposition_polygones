with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;

with Ada.Unchecked_Deallocation;

with Defs;
use Defs;

package ABR is
   
   type Noeud;
   type Arbre is access Noeud;
   type Direction is (Gauche , Droite);
   type Tableau_Fils is array(Direction) of Arbre; 
   type Noeud is record 
      C : Type_Clef; -- Pour le moment en test
      Fils : Tableau_Fils;
      Pere : Arbre;
      Compte : Positive; -- nombre de noeuds dans le sous−arbre 
   end record;
   type MAJ is range -1 .. 1;
   
   procedure Insertion (A : in out Arbre; C : in Type_Clef);
   
   procedure Suppression (A : in out Arbre; C : in Type_Clef);
   
   function Recherche (A : in Arbre; 
		       C : in Type_Clef;
		       R : out Arbre) return Boolean;
   
   procedure Affichage (A : in Arbre);
   
   procedure Noeuds_Voisins (Cible : in Arbre; 
			     Petit_Voisin, Grand_Voisin : out Arbre);

   
   procedure Compte_Position (Cible : in Arbre; 
			      Nb_Noeuds_Clef_Inf : out Type_Clef; 
			      Nb_Noeuds_Clef_Sup : out Type_Clef);
     
   
private
   
   procedure Put (N : Noeud);
   
end ABR;
