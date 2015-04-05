with Ada.Text_IO, Ada.Unchecked_Deallocation;
use Ada.Text_IO;

with Defs;
use Defs;

package Liste is
   
   Liste_Vide, Memoire_Pleine : exception;
   
   -- Ajoute une cellule de valeur S à la liste L
   procedure Enqueue (L : in out Liste_Segments;
                      S : in Segment);
   
   -- Libere toutes les cellules de la liste L
   -- Garantit : L.Tete = L.Queue = null
   procedure Liberer (L : in out Liste_Segments);
   
   -- Affiche le contenu de la liste L
   procedure Put (L : in Liste_Segments);
   
   -- Retourne le nombre d'éléments dans la liste L
   function Length (L : in Liste_Segments) Return Natural;
   
end Liste;
