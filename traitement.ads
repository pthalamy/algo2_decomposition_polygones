with Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;

with Ada.Containers.Generic_Array_Sort;

with Defs, Liste;
use Defs, Defs.ABR_Seg;

package Traitement is
   
   procedure Init_Segments(T : TSom_Ptr);
   
   procedure Affichage_Sommets (T : TSom_Ptr);
   
   procedure Parcours_Sommets(T : in TSom_Ptr; 
			      Segs : in out Liste_Segments);   
   
   -- Instanciation du generic array sort de la bibliothèque standard Ada
      -- Fonction nécessaire à l'instantiation de Generic_Array_Sort 
      -- Compare deux éléments du tableau pour son tri croissant
   function "<" (A, B : Som_Ptr) return Boolean;
   procedure TriParAbsisseCroissante is 
      new Ada.Containers.Generic_Array_Sort (Index_Type => Natural, 
					     Element_Type => Som_Ptr, 
					     Array_Type => Tab_Sommets);
private 
   function Point_De_Connexion (P : Position;
				S : Segment) return Som_Ptr;  
end Traitement;   
