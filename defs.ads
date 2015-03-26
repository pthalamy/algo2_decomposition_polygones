
package Defs is
   
   type Sommet is record
      X : Float;
      Y : Float;
   end record;
   
   type Type_Clef is new Natural;
   type Tab_Sommets is array(Natural range <>) of Sommet;
   type TS_Ptr is access Tab_Sommets;
   
end Defs;
