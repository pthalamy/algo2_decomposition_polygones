with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;

with ABR, Defs;
use Defs;

procedure Test_Dot is   
   Nb_Elt : Positive;
begin
   Put_Line ("Nombre d'éléments :");   
   Get (Nb_Elt);   
   
   declare 
      Elements : array(1..Nb_Elt) of Type_Clef;
      A : ABR.Arbre := null;
      --  R : Type_Clef;
      --  Found : ABR.Arbre;
   begin
      Put_Line ("Suite d'entiers :");      
      for I in Elements'Range loop
	 Get (Integer(Elements(I)));
      end loop;
      
      -- Génération de l'arbre
      for I in Elements'Range loop
	 ABR.Insertion (A, Elements(I));
      end loop;
	 
      ABR.Export_Dot (A);
      
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
end Test_Dot;
