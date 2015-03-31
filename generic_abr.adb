
package body Generic_ABR is
   
   -- Met à jour le compte de tous les noeuds Parents de "Parent", 
   -- ce dernier y compris, de + X.
   procedure MAJ_Voisinage (Parent : in out Arbre; X : in MAJ) is
   begin
      if Parent = null then 
	 return;
      else
	 Parent.Compte := Parent.Compte + Integer(X);
	 MAJ_Voisinage (Parent.Pere, X);
      end if;
   end MAJ_Voisinage;
   
   -- Insere un noeud de valeur C dans l'arbre dont A est la racine
   -- Et retourne un pointeur sur son emplacement dans N
   procedure Insertion (A : in out Arbre; 
			C : in Type_Clef;
			N : out Arbre) is
   begin
      
      if A = null then
	 A := new Noeud'(C => C, 
			 Fils => (others => null),
			 Pere => null,
			 Compte => 1);	 
	 N := A;
	 return;
      end if;
      
      if A.C > C then
	 if A.Fils(Gauche) = null then
	    A.Fils(Gauche) := new Noeud'(C => C, 
					 Fils => (others => null),
					 Pere => A,
					 Compte => 1);
	    MAJ_Voisinage (A, 1);
	    
	    N := A.Fils(Gauche);
	 else 
	    Insertion (A.Fils(Gauche), C, N);
	 end if;	 
      else
	 if A.Fils(Droite) = null then
	    A.Fils(Droite) := new Noeud'(C => C, 
					 Fils => (others => null),
					 Pere => A,
					 Compte => 1);
	    MAJ_Voisinage (A, 1);
	    
	    N := A.Fils(Droite);
	 else 
	    Insertion (A.Fils(Droite), C, N);
	 end if;
      end if;      
      
   end Insertion;
   
   procedure Free is
      new Ada.Unchecked_Deallocation(Noeud, Arbre);
   
   -- Supprime un noeud de valeur C dans l'arbre dont A est la racine      
   procedure Suppression (A : in out Arbre; C : in Type_Clef) is
      Max : Type_Clef;
      Fils : Arbre;
      
      -- Retourne la valeur la plus grande rencontrée dans le sous-arbre
      -- dont A est la racine
      procedure Sup_Max (A : in out Arbre; Max : out Type_Clef) is
      begin 
	 if A.Fils(Droite) = null then	    
	    Max := A.C;
	    Fils := A.Fils(Gauche);
	    A := Fils;
	 else
	    Sup_Max (A.Fils(Droite), Max);	    	    
	 end if;
      end Sup_Max;
      
   begin
      if A = null then
	 Put_Line (Standard_Error, "suppression_error: Valeur non présente");
	 return;
      end if;
      
      if A.C > C then
	 Suppression (A.Fils(Gauche), C);
      else -- A.C < C ou A.C = C
	 if A.C = C then -- A.C = C ?
	    if A.Fils(Gauche) = null and A.Fils(Droite) = null then
	       if A.C > A.Pere.C then
		  A.Pere.Fils(Droite) := null;
	       else
		  A.Pere.Fils(Gauche) := null;
	       end if;
	       
	       MAJ_Voisinage (A.Pere, -1);	    	    
	       Free (A);
	    elsif A.Fils(Gauche) = null then
	       Fils := A.Fils(Droite);
	       Fils.Pere := A.Pere;
	       Free (A);
	       A := Fils;
	       
	       MAJ_Voisinage (A.Pere, -1);
	    elsif A.Fils(Droite) = null then
	       Fils := A.Fils(Gauche);
	       Fils.Pere := A.Pere;
	       Free (A);
	       A := Fils;	    
	       
	       MAJ_Voisinage (A.Pere, -1);
	    else
	       Sup_Max (A.Fils(Gauche), Max);
	       A.C := Max;
	       MAJ_Voisinage (A, -1);		    
	    end if;	    
	 else -- A.C < C
	    Suppression (A.Fils(Droite), C);		 
	 end if;
      end if;      
   end Suppression;
   
   
   -- Recherche le noeud de valeur C dans l'arbre dont A est la racine
   -- Return True si trouvé, False sinon
   -- Retourne aussi R, pointeur sur le noeud recherché
   procedure Recherche (A : in Arbre; 
			C : in Type_Clef;
			R : out Arbre)  is
   begin
      if A = null then
	 R := null;
	 return ;
      end if;
      
      if A.C = C then
	 R := A;
	 return ;
      elsif A.C > C then
	 Recherche (A.Fils(Gauche), C, R);		   
      else
	 Recherche (A.Fils(Droite), C, R);
      end if;
   end Recherche;   
   
   -- Affiche le noeud N sur Stdout
   procedure Put (N : Noeud) is
   begin
      --  Put ("NYI");
      Put (N.C); Put (" (");
      
      --  Affichage du voisinnage       
      if N.Pere /= null then
      	 Put (N.Pere.C); Put (", ");
      else
      	 Put ("null, ");
      end if;
      
      if N.Fils(Gauche) /= null then
      	 Put (N.Fils(Gauche).C); Put (", ");
      else
      	 Put ("null, ");
      end if;
      
      if N.Fils(Droite) /= null then
      	 Put (N.Fils(Droite).C); Put (")");
      else
      	 Put ("null)");
      end if;
      
      --  Affichage de la profondeur du sous-arbre      
      Put (" || Depth : " & Integer'Image(N.Compte));
      
      New_Line;
   end Put;
   
   -- Affiche l'arbre dont A est la racine sur stdout
   procedure Affichage (A : in Arbre) is
   begin
      if A = null then
	 Put_Line ("Arbre inexistant.");
      end if;
      
      if A.Fils(Gauche) /= null then	
	 Affichage (A.Fils(Gauche));
      end if;
      
      if A.Fils(Droite) /= null then
	 Affichage (A.Fils(Droite));
      end if;
      
      Put (A.all);
   end Affichage;
   
   -- Affiche le code d'export au format dot du graph dont A est la racine 
   -- sur stdout
   procedure Export_Dot (A : in Arbre) is
      Dot_Out_Str : String(1..15);
      Last : Integer;
      Dot_Out : File_Type;      
      
      procedure Export_Dot_Rec (SA : in Arbre) is
      begin
	 Put ("NYI");
	 --  if SA = null then
	 --     return;
	 --  end if;
	 
	 --  if SA.Fils(Gauche) /= null then
	 --     Put_Line (Dot_Out, Integer'Image(Integer(SA.C))
	 --  		& " -- " 
	 --  		& Integer'Image(Integer(SA.Fils(Gauche).C))
	 --  	     );
	 --     Export_Dot_Rec (SA.Fils(Gauche));
	 --  end if;
	 
	 --  if SA.Fils(Droite) /= null then
	 --     Put_Line (Dot_Out, Integer'Image(Integer(SA.C))
	 --  		& " -- " 
	 --  		& Integer'Image(Integer(SA.Fils(Droite).C))
	 --  	     );
	 --     Export_Dot_Rec (SA.Fils(Droite));
	 --  end if;
      end Export_Dot_Rec;
      
   begin
      Put_Line ("=== Export .dot ===");
      Put_Line ("Nom du fichier d'export : ");
      Get_Line (Dot_Out_Str, Last);
      
      Create (File => Dot_Out,
              Mode => Out_File,
              Name => Dot_Out_Str);
      
      Put_Line (Dot_Out, "graph mon_graphe {");
      
      Export_Dot_Rec (A);
      
      Put_Line (Dot_Out, "}");		  
   end Export_Dot;
   
   procedure Noeuds_Voisins (Cible : in Arbre; 
			     Petit_Voisin, Grand_Voisin : out Arbre) is
   begin
      Petit_Voisin := null ;
      Grand_Voisin := null ;
      
      -- Grand_Voisin : soit le père, soit le premier fils à droite
      
      if Cible.Fils(Droite) /= null then
	 Grand_Voisin := Cible.Fils(Droite) ;
	 
      else -- Cible.Fils(Droite) = null
	 if Cible.Pere /= null then
	    Grand_Voisin := Cible.Pere ;
	 elsif Cible.Pere = null then
	    Grand_Voisin := null ; -- Pas de noeud Sup
	 end if ;
      end if ;
      
      -- Petit_Voisin : soit le père, ça le dernier fils 
      -- à droite du fils à gauche
      
      if Cible.Fils(Gauche) = null then
	 if Cible.Pere /= null then 
	    
	    if Cible.Pere.all.C > Cible.C then
	       Grand_Voisin := Null ; -- Pas de noeud inferieur
	    else
	       if Cible.Pere.all.C /= Cible.C then
		  Petit_Voisin := Cible.Pere ;
	       end if;
	    end if ;
	    
	 elsif Cible.Pere = null then
	    Petit_Voisin := null ; -- Pas de noeud inferieur
	 end if ;
	 
      else -- Noeud_Cible.Fils(Gauche) /= null	 
	 Petit_Voisin := Cible.Fils(Gauche) ;
	 while Petit_Voisin.Fils(Droite) /= null loop
	    Petit_Voisin := Petit_Voisin.Fils(Droite) ;
	 end loop ;
      end if ;
      
   end Noeuds_Voisins;
   
   procedure Compte_Position (Cible : in Arbre; 
			      Nb_Petits : out Natural;
			      Nb_Grands : out Natural) is
      Arbre_Courant : Arbre ;
   begin
      
      -- Initialisation des variables
      Nb_Petits := 0 ;
      Nb_Grands := 0 ;
      Arbre_Courant := Cible ;
      
      if (Cible.all.Fils(Gauche) /= null) then 
	 -- On compte dans le sous-arbre Gauche
	 Nb_Petits := Nb_Petits + Cible.all.Fils(Gauche).all.Compte ;
      end if ;
      
      if (Cible.all.Fils(Droite) /= null) then
	 -- On compte dans le sous-arbre droit
	 Nb_Grands := Nb_Grands + Cible.all.Fils(Droite).all.Compte ;
      end if ;  
      
      while (Arbre_Courant.all.Pere /= null) loop
	 -- On remonte
	 
	 if (Arbre_Courant.all.Pere.all.C > Arbre_Courant.all.C) then
	    -- On différencie les cas où l'on est à droite ou à gauche du père
	    
	    Arbre_Courant := Arbre_Courant.all.Pere ;
	    Nb_Grands := Nb_Grands + 1 ;
	    
	    if (Cible.all.Fils(Droite) /= null) then 
	       Nb_Grands := Nb_Grands + 
		 Arbre_Courant.all.Fils(Droite).all.Compte ;
	    end if ;
	    
	 else 
	    -- (Arbre_Courant.all.Pere.all.C < Arbre_Courant.all.C) 
	    -- On ne regarde pas le cas d'égalité
	    Arbre_Courant := Arbre_Courant.all.Pere ;
	    Nb_Petits := Nb_Petits + 1 ;
	    
	    if (Cible.all.Fils(Gauche) /= null) then
	       Nb_Petits := Nb_Petits + 
		 Arbre_Courant.all.Fils(Gauche).all.Compte ;
	    end if ;
	    
	 end if ;
      end loop ;
   end Compte_Position;

end Generic_ABR;
