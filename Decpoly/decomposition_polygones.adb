with Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;

with Ada.Containers.Generic_Array_Sort;

with Parseur, Defs, Svg, Liste, Traitement;
use Defs;

procedure Decomposition_Polygones is
   Args_Invalides : exception;
   T : TSom_Ptr := null;
   Segs : Liste_Segments;      
begin
   if Argument_Count /= 2 then
      raise Args_Invalides;
   end if;  
   
   Parseur.Lecture (Argument(1), T);         
   
   Traitement.Init_Segments (T);
   
   Svg.Trace_Polygone (Argument(2), T);
   
   Traitement.TriLexicographique (T.all);
   Traitement.Parcours_Sommets (T, Segs);
   
   Svg.Trace_Segments (Segs);
   
   Put_Line ("--> Decomposition terminée," & Integer'Image(Liste.Length(Segs))
	       & " segments on été ajoutés.");
   Put_Line ("    Ouvrez " & Argument(2) 
	       & " pour observer le résultat.");
   
exception
   when Args_Invalides =>
      Put_Line (Standard_Error, "utilisation : decpoly data.in out.svg");   
end Decomposition_Polygones;
