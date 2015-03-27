
package body Defs is
   
   -- Return True is S1 "au-dessus de" S2
   -- else sinon
   function ">"(S1, S2 : in Segment) return Boolean is      
   begin
      -- Compare la valeur moyenne de l'ordonnée du segment
      return ((S1.A.Pos.Y + S1.B.Pos.Y) / 2.0) > 
	((S2.A.Pos.Y + S2.B.Pos.Y) / 2.0);
   end ">";
   
end Defs;
