with Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;

with Parseur, Defs, ABR, Svg;
use Defs;

procedure Decomposition_Polygones is
   Args_Invalides : exception;
   Nb_Sommets : Natural;
   T : TS_Ptr := null;
begin
   if Argument_Count /= 2 then
      raise Args_Invalides;
   end if;  
   
   Parseur.Lecture (Argument(1), Nb_Sommets, T);   
   
   Put_Line ("Nombre de sommets : " & Integer'Image(Nb_Sommets));
   
   for I in T.all'Range loop
      Put (T.all(I).X);
      Put (' ');
      Put (T.all(I).Y);
      New_Line;
   end loop;
   
   Svg.Trace_Polygone (Argument(2), T);
   
exception
   when Args_Invalides =>
      Put_Line (Standard_Error, "utilisation : decpoly data.in out.svg");   
end Decomposition_Polygones;
