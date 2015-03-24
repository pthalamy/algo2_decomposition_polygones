with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;

package ABR is
   type Noeud;
   type Arbre is access Noeud;
   type Direction is (Gauche , Droite);
   type Tableau_Fils is array(Direction) of Arbre; 
   type Noeud is record 
      Val : Natural; -- Pour le moment en test
      Fils : Tableau_Fils;
      Pere : Arbre;
      Compte : Positive; -- nombre de noeuds dans le sous−arbre 
   end record;
   type MAJ is range -1 .. 1;
   
   procedure Insertion (A : in out Arbre; V : in Natural);
   
   procedure Suppression (A : in out Arbre; V : in Natural);
   
   function Recherche (A : in out Arbre; V : in Natural) return Boolean;
   
   procedure Affichage (A : in out Arbre);
   
end ABR;
