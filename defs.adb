
package body Defs is
   
   -- Return True is S1 "au-dessus de" S2
   -- else sinon
   function ">"(S1, S2 : in Type_Clef) return Boolean is      
   begin
      -- Compare la valeur moyenne de l'ordonnée du segment
      return ((S1.A.Y + S1.B.Y) / 2.0) > 
	((S2.A.Y + S2.B.Y) / 2.0);
   end ">";
   
   function Point2Str (P : Position) return String is
   begin
      return "(" & Float'Image (P.X) & ", " & Float'Image (P.Y) & " )";
   end Point2Str;
   
   procedure Put (S : Segment) is
   begin
      Put (" [" & Point2Str (S.A) & ", " & Point2Str (S.B) & "]");
   end Put;
      
end Defs;
