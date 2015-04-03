with Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Command_Line;

with Ada.Containers.Generic_Array_Sort;

with Parseur, Defs, Svg, Liste;
use Defs, Defs.ABR_Seg;

procedure Decomposition_Polygones is
   Args_Invalides : exception;
   Nb_Sommets : Natural;
   T : TSom_Ptr := null;
   Segs : Liste_Segments;
   
   procedure Init_Segments(T : TSom_Ptr) is
      Nom : Character := 'A';
   begin
      for I in T.all'Range loop
	 T(I).Nom := Nom;
	 Nom := Character'Val(Character'Pos(Nom) + 1);
      end loop;
      
      for I in T.all'First..(T.all'Last - 1) loop
	 if T(I).Pos.X < T(I + 1).Pos.X then
	    Liste.Enqueue (T(I).Sortants, (T(I), T(I+1)));
	    Liste.Enqueue (T(I+1).Entrants, (T(I), T(I+1)));
	 else
	    Liste.Enqueue (T(I).Entrants, (T(I+1), T(I)));
	    Liste.Enqueue (T(I+1).Sortants, (T(I+1), T(I)));
	 end if;
      end loop;
      
      -- Prise en compte du segment entre le dernier et premier point
      if T(T.all'Last).Pos.X < T(T.all'First).Pos.X then
	 Liste.Enqueue (T(T.all'Last).Sortants, 
			(T(T.all'Last), 
			 T(T.all'First)));
	 Liste.Enqueue (T(T.all'First).Entrants, 
			(T(T.all'Last), 
			 T(T.all'First)));
      else
	 Liste.Enqueue (T(T.all'Last).Entrants, 
			(T(T.all'First), 
			 T(T.all'Last)));
	 Liste.Enqueue (T(T.all'First).Sortants, 
			(T(T.all'First), 
			 T(T.all'Last)));		 
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
   
   function Point_De_Connexion (P : Position;
				S : Segment) return Sommet is
      A : Float; -- Coefficient directeur de S
      B : Float; -- Ordonnée à l'origine de S
      I : Sommet; -- Le point d'intersection des deux segments
   begin
      --  Calcule Le coefficient directeur de S
      A := (S.B.Pos.Y - S.A.Pos.Y) / (S.B.Pos.X - S.A.Pos.X);
      B := S.B.Pos.Y - A * S.B.Pos.X;
      
      -- Calcul de l'ordonnée du point d'intersection de la verticale
      -- passant par P et de S
      I.Pos.Y := A * P.X + B;
      I.Pos.X := (P.X);
      
      I.Nom := 'X';
            
      return I;
   end Point_De_Connexion;   
   
   procedure Parcours_Sommets(T : in TSom_Ptr; 
			      Segs : in out Liste_Segments) is
      A : Arbre;
      R : Boolean := False;
      S : Segment;
      N : Arbre;
      V_Petit, V_Grand : Arbre;
      C_Petit, C_Grand : Natural;
      
      Seg_Cour : Cell_Ptr;
      New_Seg : Segment;
   begin       
      for I in T'Range loop
	 Put_Line ("Traitement du point: " & T(I).Nom);	      
	 
	 Affichage (A);
	 
      	 if Liste.Length(T(I).Sortants) = 2 then
      	    R := True;
      	    S := (T(I), T(I));
	    Insertion (A, S, N);
      	    Noeuds_Voisins (N, V_Petit, V_Grand);
	    Compte_Position (N, C_Petit, C_Grand);
	    Suppression (A, S);
	 end if;
	 
	 -- Enlever les segments qui terminent sur le point courant de l'ABR
	 Put_Line ("    Sup entrants: " 
		     & Integer'Image(Liste.Length(T(I).Entrants)));
	 Seg_Cour := T(I).Entrants.Tete;	 
	 while Seg_Cour /= null loop
	    Put ("    Suppression de : "); Put (Seg_Cour.Seg); New_Line;
	    Affichage(A);
	    Suppression (A, Seg_Cour.Seg);
	    Seg_Cour := Seg_Cour.Suiv;
	 end loop;
	 -- Ajouter les segments qui commencent sur le point courant à l'ABR
	 Put_Line ("    Sup sortants: "
		     & Integer'Image(Liste.Length(T(I).Sortants)));
	 Seg_Cour := T(I).Sortants.Tete;
	 while Seg_Cour /= null loop
	    Put ("    Insertion de : "); Put (Seg_Cour.Seg); New_Line;
	    Insertion (A, Seg_Cour.Seg, N);
	    Seg_Cour := Seg_Cour.Suiv;
	 end loop;
	 
	 if Liste.Length(T(I).Entrants) = 2 then
	    R := True;
      	    S := (T(I), T(I));
      	    Insertion (A, S, N );
      	    Noeuds_Voisins (N, V_Petit, V_Grand);
	    Compte_Position (N, C_Petit, C_Grand);
	    Suppression (A, S);
	 end if;
	 
	 if R then
	    if ( (C_Petit mod 2) = 1) or ( (C_Grand mod 2 = 1) ) then
	       if V_Petit /= null then
		  -- Calcul du point de rencontre avec le segment inf
		  New_Seg := (T(I), 
			      Point_De_Connexion (T(I).Pos, V_Petit.C));
		  Put ("! Trace Segment : "); Put (New_Seg); New_Line;
		  Liste.Enqueue (Segs, New_Seg);
	       end if;
	       if V_Grand /= null then
		  -- Calcul du point de rencontre avec le segment sup
		  New_Seg := (Point_De_Connexion (T(I).Pos, V_Grand.C), 
			      T(I));
		  Put ("! Trace Segment : "); Put (New_Seg); New_Line;
		  Liste.Enqueue (Segs, New_Seg);
	       end if;
	    end if;
	 end if;
      end loop;
   end Parcours_Sommets;
   
begin
   if Argument_Count /= 2 then
      raise Args_Invalides;
   end if;  
   
   Parseur.Lecture (Argument(1), Nb_Sommets, T);   
   
   Put_Line ("Nombre de sommets : " & Integer'Image(Nb_Sommets));
   
   Init_Segments (T);
   Svg.Trace_Polygone (Argument(2), T);
   
   TriParAbsisseCroissante (T.all);
   Parcours_Sommets (T, Segs);
   
   Svg.Trace_Segments (Segs);
   
exception
   when Args_Invalides =>
      Put_Line (Standard_Error, "utilisation : decpoly data.in out.svg");   
end Decomposition_Polygones;
