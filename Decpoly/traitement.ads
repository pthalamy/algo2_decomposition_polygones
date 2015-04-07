with Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;

with Ada.Containers.Generic_Array_Sort;
with Ada.Unchecked_Deallocation;

with Defs, Liste;
use Defs, Defs.ABR_Seg;

package Traitement is

   -- Nomme les sommets et initialise leur liste de segments entrants/sortants
   procedure Init_Segments(T : TSom_Ptr);

   -- Affiche le contenu du tableau de sommet pointé par T
   procedure Affichage_Sommets (T : TSom_Ptr);

   -- Procedure de tri des sommets du tableau par absisse croissante
     -- Fonction nécessaire à l'instantiation de Generic_Array_Sort
     -- Compare deux éléments du tableau pour son tri croissant
     -- Instanciation du generic array sort de la bibliothèque standard Ada
   function "<" (A, B : Som_Ptr) return Boolean;
   procedure TriLexicographique is
      new Ada.Containers.Generic_Array_Sort (Index_Type => Natural,
                                             Element_Type => Som_Ptr,
                                             Array_Type => Tab_Sommets);

   -- Parcours les sommets du tableau pointé par T et traite chacun
   -- d'eux pour generer les segments de monotonisation du polynome
   procedure Parcours_Sommets(T : in TSom_Ptr;
                              Segs : in out Liste_Segments);

   -- Libere tous les sommets et le tableau
   -- Garantit : T := null
   procedure Liberer(T : in out TSom_Ptr);

private
   -- Etant donné un point P et un segment S, calcule et retourne le point
   -- d'intersection entre la verticale passant par P et le segment S.
   function Point_De_Connexion (P : Position;
                                S : Segment) return Som_Ptr;

   procedure Free_Sommet is
      new Ada.Unchecked_Deallocation(Sommet, Som_Ptr);
   procedure Free_Tab is
      new Ada.Unchecked_Deallocation(Tab_Sommets, TSom_Ptr);
end Traitement;
