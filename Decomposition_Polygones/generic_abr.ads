with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;

with Ada.Unchecked_Deallocation;

generic
   type Type_Clef is private; -- nodevalue_t
   with function ">"(Left, Right : in Type_Clef) return Boolean is <>;
   with procedure Put (X : in Type_Clef) is <>; -- +Pratique pour DEBUG
   
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
   type MAJ is range -1 .. 1; -- Valeurs de mise à jour de l'attribut compte
   
   -- Insere un nouveau noeud de clef C dans l'arbre A et retourne un 
   -- pointeur sur ce dernier dans N
   procedure Insertion (A : in out Arbre; C : in Type_Clef; N : out Arbre);
   
   -- Supprime le noeud de clef C de l'arbre A
   procedure Suppression (A : in out Arbre; C : in Type_Clef);
   
   -- Recherche le noeuf de clef  C dans l'arbre A
   -- Si ce dernier est trouvé : R = pointeur sur le noeud
   -- Sinon :                    R = null
   procedure Recherche (A : in Arbre; 
			C : in Type_Clef;
			R : out Arbre);
   
   -- Affiche le contenu de l'arbre A dans le format suivant :
   -- NoeudCourant (Pere, FilsG, FilsD) || Compte : N
   procedure Affichage (A : in Arbre);
   
   -- Exporte le contenu de l'arbre A dans un fichier .dot
   procedure Export_Dot (A : in Arbre);
   
   -- Retourne les noeuds de clef inf et sup les plus proches du noeud Cible
   procedure Noeuds_Voisins (Cible : in Arbre; 
			     Petit_Voisin, Grand_Voisin : out Arbre);

   -- Retourne le nombre de noeud de clef inf et sup à celle de Cible dans
   -- l'arbre auquel il appartient
   procedure Compte_Position (Cible : in Arbre; 
			      Nb_Petits : out Natural; 
			      Nb_Grands : out Natural);
   
   
private   
   procedure Put (N : Noeud);
   
end Generic_ABR;
