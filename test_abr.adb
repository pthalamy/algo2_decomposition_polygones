with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;

with ABR, Defs;
use Defs;

procedure Test_ABR is   
   Nb_Elt : Positive;
begin
   Put_Line ("Nombre d'éléments :");   
   Get (Nb_Elt);   
   
   declare 
      Elements : array(1..Nb_Elt) of Type_Clef;
      A : ABR.Arbre := null;
      R : ABR.Arbre;
      
      ClefAR : Type_Clef;
      Vinf, VSup : Type_Clef;
      
      PVoisin, GVoisin : ABR.Arbre;
   begin
      Put_Line ("Suite d'entiers :");      
      for I in Elements'Range loop
	 Get (Integer(Elements(I)));
      end loop;
      
      -- Génération de l'arbre
      for I in Elements'Range loop
	 ABR.Insertion (A, Elements(I));
      end loop;
	 
      ABR.Affichage (A);      
      
      Put_Line ("Nombre à rechercher :");
      Get (Integer(ClefAR));
      Put_Line ("Recherche et compte de voisins de : " 
		  & Integer'Image(Integer(ClefAR)));
      
      ABR.Recherche (A, ClefAR, R);
      ABR.Compte_Position (R, VInf, VSup);
      Put_Line ("Nb voisins inf: " & Integer'Image(Integer(VInf)));
      Put_Line ("Nb voisins sup: " & Integer'Image(Integer(VSup)));
      
      ABR.Noeuds_Voisins (R, PVoisin, GVoisin);
      Put_Line ("Petit voisin: " & Integer'Image(Integer(PVoisin.C)));
      Put_Line ("Grand voisin: " & Integer'Image(Integer(GVoisin.C)));

      
      --  Put_Line ("Nombre à rechercher :");
      --  Get (Integer(R));

      --  if ABR.Recherche (A, R, Found) then 
      --  	 Put_Line ("Trouvé");
      --  else 
      --  	 Put_Line ("Introuvable");
      --  end if;
      
      --  Put_Line ("Suppression de " & Integer'Image(Integer(R)));
      --  ABR.Suppression (A, R);
      --  ABR.Affichage (A);
	    
      --  if ABR.Recherche (A, R, Found) then 
      --  	 Put_Line ("Trouvé");
      --  else 
      --  	 Put_Line ("Introuvable");
      --  end if;
      
   end;      
end Test_ABR;
