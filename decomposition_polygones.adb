with Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;

with Parseur, Defs, ABR, Svg, Liste;
use Defs;

procedure Decomposition_Polygones is
   Args_Invalides : exception;
   Nb_Sommets : Natural;
   T : TSom_Ptr := null;
   
   procedure Init_Segments(T : TSom_Ptr) is
   begin
      for I in T.all'First..(T.all'Last - 1) loop	 
	 if T(I).Pos.X < T(I + 1).Pos.X then
	   Liste.Enqueue (T(I).Sortants, (T(I), T(I+1)));
	 else
	    Liste.Enqueue (T(I).Entrants, (T(I), T(I+1)));
	 end if;
      end loop;
      
      -- Prise en compte du segment entre le dernier et premier point
      if T(T.all'Last).Pos.X < T(T.all'First).Pos.X then
	 Liste.Enqueue (T(T.all'Last).Sortants, 
			(T(T.all'Last), 
			 T(T.all'First)));
      else
	 Liste.Enqueue (T(T.all'Last).Entrants, 
			(T(T.all'Last), 
			 T(T.all'First)));
      end if;
   end Init_Segments;
   
begin
   if Argument_Count /= 2 then
      raise Args_Invalides;
   end if;  
   
   Parseur.Lecture (Argument(1), Nb_Sommets, T);   
   
   Put_Line ("Nombre de sommets : " & Integer'Image(Nb_Sommets));
   
   for I in T.all'Range loop
      Put (T.all(I).Pos.X);
      Put (' ');
      Put (T.all(I).Pos.Y);
      New_Line;
   end loop;
   
   Svg.Trace_Polygone (Argument(2), T);
   
exception
   when Args_Invalides =>
      Put_Line (Standard_Error, "utilisation : decpoly data.in out.svg");   
end Decomposition_Polygones;
