with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;

with Generic_ABR, Defs;
use Defs;

procedure Test_ABR is   
   Nb_Elt : Positive;
   
   -- Instantiation de l'arbre generique avec le type segment :   
   procedure Put (N : Natural) is
   begin
      Ada.Integer_Text_IO.Put (N);
   end Put;
   
   package ABR_Int is 
      new Generic_ABR (Type_Clef => Natural);
   use ABR_Int;
   ----------
   
begin
   Put_Line ("Nombre d'éléments :");   
   Get (Nb_Elt);   
   
   declare 
      Elements : array(1..Nb_Elt) of Natural;
      A : Arbre := null;
      R : Arbre;
      N : Arbre;
      
      Vinf, VSup : Natural;
      
      PVoisin, GVoisin : Arbre;
   begin
      Put_Line ("Suite d'entiers :");      
      for I in Elements'Range loop
	 Get (Integer(Elements(I)));
      end loop;
      
      -- Génération de l'arbre
      for I in Elements'Range loop
	 Insertion (A, Elements(I), N);
      end loop;
	 
      Affichage (A);      
      
      --  Put_Line ("Nombre à rechercher :");
      --  Get (Integer(ClefAR));
      
      for I in Elements'Range loop
	 New_Line;
	 Put_Line ("Recherche et compte de voisins de : " 
		     & Integer'Image(Elements(I)));
	 	 
	 Recherche (A, Elements(I), R);

	 Compte_Position (R, VInf, VSup);
	 Put_Line ("Nb voisins inf: " & Integer'Image(VInf));
	 Put_Line ("Nb voisins sup: " & Integer'Image(VSup));
	 
	 Noeuds_Voisins (R, PVoisin, GVoisin);
	 
	 if PVoisin /= null then
	    Put_Line ("Petit voisin: " & Integer'Image(PVoisin.C));
	 else
	    Put_Line ("Petit voisin: " & "null");
	 end if;
	 
	 if GVoisin /= null then
	    Put_Line ("Grand voisin: " & Integer'Image(GVoisin.C));
	 else 
	    Put_Line ("Grand voisin: " & "null");		    
	 end if;
	 
      end loop;
          
      --  Put_Line ("Nombre à rechercher :");
      --  Get (Integer(R));

      --  if Recherche (A, R, Found) then 
      --  	 Put_Line ("Trouvé");
      --  else 
      --  	 Put_Line ("Introuvable");
      --  end if;
      
      --  Put_Line ("Suppression de " & Integer'Image(Integer(R)));
      --  Suppression (A, R);
      --  Affichage (A);
	    
      --  if Recherche (A, R, Found) then 
      --  	 Put_Line ("Trouvé");
      --  else 
      --  	 Put_Line ("Introuvable");
      --  end if;
      
   end;      
end Test_ABR;
