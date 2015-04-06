with Ada.Text_IO;
use Ada.Text_IO;

with Generic_ABR;

package Defs is        
   
   -- Extrema de coordonnées de sommets
   X_Max, X_Min : Float;
   Y_Max, Y_Min : Float;
   Translation_Offset_X : Float;
   Translation_Offset_Y : Float;
   Margin_Offset : constant Float := 0.30;
   
   -- Liste de segments pour segments voisins et de régularisation
   type Cellule;
   type Cell_Ptr is access Cellule;   
      
   type Liste_Segments is record
      Tete, Queue : Cell_Ptr;
   end record;
   
   -- Point (X, Y)
   type Position is record
      X : Float;
      Y : Float;
   end record;
   
   type Sommet is record 
      Nom : Character;
      Pos : Position;
      Entrants : Liste_Segments;
      Sortants : Liste_Segments;
   end record;
   
   type Som_Ptr is access Sommet; 
   type Segment is record
      A, B : Som_Ptr;
   end record;
   
   type Cellule is record
      Seg : Segment;
      Suiv : Cell_Ptr;
   end record;
   
   -- Tableau de pointeur sur sommet
   type Tab_Sommets is array(Natural range <>) of Som_Ptr;
   type TSom_Ptr is access Tab_Sommets;
   
   -- Instantiation de l'arbre generique avec le Type_Clef Segment :
   function ">"(S1, S2 : in Segment) return Boolean;
   procedure Put (S : Segment);      
   package ABR_Seg is 
      new Generic_ABR (Type_Clef => Segment);
   ----------
   
   function Point2Str (P : Position) return String;
   
end Defs;
