
package body Parseur is
      
   procedure Lecture (Fichier_In_Str : in String;
		      Nb_Sommets : out Natural;
		      T : out TSom_Ptr)
   is
      Fichier_In : File_Type;            
   begin
      Open (File => Fichier_In,
            Mode => In_File,
            Name => Fichier_In_Str);
      
      -- Lecture du nombre de sommets
      Get (Fichier_In, Nb_Sommets);
      
      T := new Tab_Sommets(1..Nb_Sommets);
      
      -- Lecture des coordonnées des sommets
      for I in T.all'range loop
	 Get (Fichier_In, T.all(I).Pos.X);
	 Get (Fichier_In, T.all(I).Pos.Y);
      end loop;

      Close (Fichier_In);
   end Lecture;

end Parseur;
