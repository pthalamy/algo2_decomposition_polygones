with Ada.Float_Text_IO, Ada.Text_IO;
use Ada.Float_Text_IO, Ada.Text_IO;

with Defs;
use Defs;

procedure Test_Segs is
   S1, S2 : Segment;
begin
   Put_Line ("S1.A ? -> X Y");
   Get (S1.A.X);
   Get (S1.A.Y);
   Put_Line ("S1.B ?");
   Get (S1.B.X);
   Get (S1.B.X);
   Put_Line ("S2.A ? -> X Y");
   Get (S2.A.X);
   Get (S2.A.Y);
   Put_Line ("S2.B ?");
   Get (S2.B.X);
   Get (S2.B.X);
   
   if S1 > S2 then
      Put_Line ("True");
   else
      Put_Line ("False");
   end if;
end Test_Segs;
