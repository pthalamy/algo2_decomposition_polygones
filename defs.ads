
package Defs is
   
   type Sommet is record
      X : Float;
      Y : Float;
   end record;
   
   type Segment is record
      A, B : Sommet;
   end record;
   
   type Type_Clef is new Natural;   
   type Tab_Sommets is array(Natural range <>) of Sommet;
   type TS_Ptr is access Tab_Sommets;
   
   function ">"(S1, S2 : in Segment) return Boolean;
   
end Defs;
