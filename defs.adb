
package body Defs is
   
   -- Return True is S1 "au-dessus de" S2
   -- else sinon
   function ">"(S1, S2 : in Segment) return Boolean is
      S1TopY, S2TopY : Float;
   begin
      if S1.A.Y > S1.B.Y then
	 S1TopY := S1.A.Y;
      else
	 S1TopY := S1.B.Y;
      end if;
      
      if S2.A.Y > S2.B.Y then
	 S2TopY := S2.A.Y;
      else
	 S2TopY := S2.B.Y;
      end if;
      
      return S1TopY > S2TopY;
   end ">";
   
end Defs;
