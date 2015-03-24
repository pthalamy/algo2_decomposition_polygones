with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;

with ABR;

procedure Test_ABR is
   Nb_Elt : Positive;
begin
   Put_Line ("Nombre d'éléments :");   
   Get (Nb_Elt);   
   
   declare 
      Elements : array(1..Nb_Elt) of Natural;
      A : ABR.Arbre := null;
      R : Natural;
   begin
      Put_Line ("Suite d'entiers :");      
      for I in Elements'Range loop
	 Get (Elements(I));
      end loop;
      
      -- Génération de l'arbre
      for I in Elements'Range loop
	 ABR.Insertion (A, Elements(I));
      end loop;
	 
      ABR.Affichage (A);      
      
      Put_Line ("Nombre à rechercher :");
      Get (R);
      
      if ABR.Recherche (A, R) then 
	 Put_Line ("Trouvé");
      else 
      	 Put_Line ("Introuvable");
      end if;
            
      ABR.Suppression (A, R);
      ABR.Affichage (A);
	    
      if ABR.Recherche (A, R) then 
	 Put_Line ("Trouvé");
      else 
      	 Put_Line ("Introuvable");
      end if;
      
   end;      
end Test_ABR;
