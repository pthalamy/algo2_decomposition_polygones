with Ada.Text_IO, Ada.Unchecked_Deallocation;
use Ada.Text_IO;

with Defs;
use Defs;

package Liste is
   
   Liste_Vide, Memoire_Pleine : exception;
      
   procedure Enqueue (L : in out Liste_Segments;
                      S : in Segment);
   
   procedure Liberer (L : in out Liste_Segments);
   
   -- Affiche le contenu d'une liste
   procedure Put (L : in Liste_Segments);
   
   -- Retourne le nombre d'éléments dans la liste
   function Length (L : in Liste_Segments) Return Natural;
   
end Liste;
