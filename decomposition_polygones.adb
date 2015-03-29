with Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;

with Ada.Containers.Generic_Array_Sort;

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
	    Liste.Enqueue (T(I).Sortants, (T(I).Pos, T(I+1).Pos));
	    Liste.Enqueue (T(I+1).Entrants, (T(I).Pos, T(I+1).Pos));
	 else
	    Liste.Enqueue (T(I).Entrants, (T(I+1).Pos, T(I).Pos));
	    Liste.Enqueue (T(I+1).Sortants, (T(I+1).Pos, T(I).Pos));
	 end if;
      end loop;
      
      -- Prise en compte du segment entre le dernier et premier point
      if T(T.all'Last).Pos.X < T(T.all'First).Pos.X then
	 Liste.Enqueue (T(T.all'Last).Sortants, 
			(T(T.all'Last).Pos, 
			 T(T.all'First).Pos));
	 Liste.Enqueue (T(T.all'First).Entrants, 
			(T(T.all'Last).Pos, 
			 T(T.all'First).Pos));
      else
	 Liste.Enqueue (T(T.all'Last).Entrants, 
			(T(T.all'First).Pos, 
			 T(T.all'Last).Pos));
	 Liste.Enqueue (T(T.all'First).Sortants, 
			(T(T.all'First).Pos, 
			 T(T.all'Last).Pos));		 
      end if;
   end Init_Segments;
   
   procedure Affichage_Sommets (T : TSom_Ptr) is
   begin
      for I in T.all'Range loop	 
	 Put_Line ("=== Sommet " & Integer'Image(I) & " ===");
	 Put_Line (" Position : " & Point2Str(T(I).Pos));
	 Put (" Segments entrants : "); 
	 Put_Line (Integer'Image(Liste.Length(T(I).Entrants)));
	 Liste.Put (T(I).Entrants);
	 Put (" Segments sortants : ");
	 Put_Line (Integer'Image(Liste.Length(T(I).Sortants)));
	 Liste.Put (T(I).Sortants);
	 New_Line;
      end loop;      
   end Affichage_Sommets;
   
   -- Fonction nécessaire à l'instantiation de Generic_Array_Sort 
   -- Compare deux éléments du tableau pour son tri croissant
   function "<" (A, B : Sommet) return Boolean is
   begin
      return  A.Pos.X < B.Pos.X;
   end "<";
   
   -- Instanciation du package generic sort de la bibliothèque standard Ada
   procedure TriParAbsisseCroissante is 
      new Ada.Containers.Generic_Array_Sort (Index_Type => Natural, 
					     Element_Type => Sommet, 
					     Array_Type => Tab_Sommets);
   
   procedure Parcours_Sommets(T : in TSom_Ptr; A : in out ABR.Arbre) is
      R : Boolean := False;
      S : Segment;
      N : ABR.Arbre;
      V_Petit, V_Grand : ABR.Arbre;
      C_Petit, C_Grand : Natural;
   begin 
      for I in T'Range loop
      	 if Liste.Length(T(I).Sortants) = 2 then
      	    R := True;
      	    S := (T(I).Pos, T(I).Pos);
      	    N := ABR.Insertion (A, Type_Clef(S));
      	    ABR.Noeuds_Voisins (N, V_Petit, V_Grand);
	    
      	 end if;
      end loop;
      
      null;
   end Parcours_Sommets;
   
begin
   if Argument_Count /= 2 then
      raise Args_Invalides;
   end if;  
   
   Parseur.Lecture (Argument(1), Nb_Sommets, T);   
   
   Put_Line ("Nombre de sommets : " & Integer'Image(Nb_Sommets));
   
   Init_Segments (T);
   TriParAbsisseCroissante (T.all);
   Affichage_Sommets (T);   
   
   Svg.Trace_Polygone (Argument(2), T);
   
exception
   when Args_Invalides =>
      Put_Line (Standard_Error, "utilisation : decpoly data.in out.svg");   
end Decomposition_Polygones;
