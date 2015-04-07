
package body Defs is

   function Point2Str (P : Position) return String is
   begin
      return "(" & Float'Image (P.X) & ", " & Float'Image (P.Y) & " )";
   end Point2Str;

   procedure Put (S : Segment) is
   begin
      Put (" [" & S.A.Nom & ", " & S.B.Nom & "]");
   end Put;

   -- Return True is S1 "au-dessus de" S2
   -- else sinon
   function ">"(S1, S2 : in Segment) return Boolean is
   begin
      -- Compare la valeur moyenne de l'ordonnée du segment
      -- et donc l'ordonné des milieu
      return ((S1.A.Pos.Y + S1.B.Pos.Y) / 2.0) >
        ((S2.A.Pos.Y + S2.B.Pos.Y) / 2.0);
   end ">";

end Defs;
