with Ada.Text_IO;
use Ada.Text_IO;

package Defs is        
      
   type Position is record
      X : Float;
      Y : Float;
   end record;
   
   type Cellule;
   type Cell_Ptr is access Cellule;   
      
   type Liste_Segments is record
      Tete, Queue : Cell_Ptr;
   end record;
   
   type Sommet is record 
      Pos : Position;
      Entrants : Liste_Segments;
      Sortants : Liste_Segments;
   end record;
   
   type Segment is record
      A, B : Position;
   end record;
   
   type Cellule is record
      Seg : Segment;
      Suiv : Cell_Ptr;
   end record;
         
   -- Types de stockage
   
   type Type_Clef is new Segment;
   type Tab_Sommets is array(Natural range <>) of Sommet;
   type TSom_Ptr is access Tab_Sommets;
   
   function ">"(S1, S2 : in Type_Clef) return Boolean;
   function Point2Str (P : Position) return String;   
   procedure Put (S : Segment);
   
end Defs;
