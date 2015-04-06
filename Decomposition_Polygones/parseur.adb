
package body Parseur is
      
   procedure Lecture (Fichier_In_Str : in String;
		      T : out TSom_Ptr)
   is
      Fichier_In : File_Type;
      Nb_Sommets : Natural;
   begin
      X_Max := Float'First;
      X_Min := Float'Last;
      Y_Max := Float'First;
      Y_Min := Float'Last;
      
      Open (File => Fichier_In,
            Mode => In_File,
            Name => Fichier_In_Str);
      
      -- Lecture du nombre de sommets
      Get (Fichier_In, Nb_Sommets);
      
      T := new Tab_Sommets(1..Nb_Sommets);
      
      -- Lecture des coordonnées des sommets
      for I in T.all'range loop
	 T.all(I) := new Sommet;
	 Get (Fichier_In, T.all(I).Pos.X);
	 if T.all(I).Pos.X < X_Min then
	    X_Min := T.all(I).Pos.X;
	 elsif T.all(I).Pos.X > X_Max then
	    X_Max := T.all(I).Pos.X;
	 end if;
	 
	 Get (Fichier_In, T.all(I).Pos.Y);
	 if T.all(I).Pos.Y < Y_Min then
	    Y_Min := T.all(I).Pos.Y;
	 elsif T.all(I).Pos.Y > Y_Max then
	    Y_Max := T.all(I).Pos.Y;
	 end if;
      end loop;
      
      Put (X_Min);       Put (X_Max); New_Line;
      Put (Y_Min);       Put (Y_Max); New_Line;
      
      -- Calcul de l'offset pour un affichage svg centré
      --  Translation_Offset_X := (abs(X_Min) + abs(X_Max))*Margin_Offset;
      --  Translation_Offset_Y := (abs(Y_Min) + abs(Y_Max))*Margin_Offset;
      
      Translation_Offset_X := Margin_Offset + abs(X_Min) ;
      Translation_Offset_Y := Margin_Offset + abs(Y_Min) ;  
    
      
      Put (Translation_Offset_X);       Put (Translation_Offset_Y); New_Line;
      
      
      Close (Fichier_In);
   end Lecture;

end Parseur;
