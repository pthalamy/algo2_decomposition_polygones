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
	    if A.Fils(Gauche) /= null then
	       Fils := A.Fils(Gauche);
	       Fils.Pere := A.Pere;
	    end if;
	    
	    MAJ_Voisinage (A.Pere, -1);
	    
	    Free (A);
	    
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
      
      if A.C = C then
	 if A.Fils(Gauche) = null and A.Fils(Droite) = null then
	    if A.Pere /= null then	       	       
	       MAJ_Voisinage (A.Pere, -1);
	    end if;
	    
	    Free (A);	      
	    A := null;	   
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
	    Put ("     Sup_Max = "); Put(Max); New_Line;
	    A.C := Max;
	 end if;	    
      elsif A.C > C then
	 Suppression (A.Fils(Gauche), C);
      else -- A.C < C
	 Suppression (A.Fils(Droite), C);		   
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
	 return;
      end if;
      
      if A.C = C then
	 R := A;
	 return;
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
      	 Put ("       null, ");
      end if;
      
      if N.Fils(Gauche) /= null then
      	 Put (N.Fils(Gauche).C); Put (", ");
      else
      	 Put ("       null, ");
      end if;
      
      if N.Fils(Droite) /= null then
      	 Put (N.Fils(Droite).C); Put (")");
      else
      	 Put ("       null)");
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
	 return;
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
      
      procedure Export_Dot_Rec (SA : in Arbre) is
      begin
	 if SA = null then
	    return;
	 end if;
	 
	 if SA.Fils(Gauche) /= null then
	    Put (SA.C); Put (" -- "); Put (SA.Fils(Gauche).C);
	    Export_Dot_Rec (SA.Fils(Gauche));
	 end if;
	 
	 if SA.Fils(Droite) /= null then
	    Put (SA.C); Put (" -- "); Put (SA.Fils(Droite).C);
	    Export_Dot_Rec (SA.Fils(Droite));
	 end if;
      end Export_Dot_Rec;
      
   begin
      Put_Line ("=== Export .dot ===");
            
      Put_Line ("graph mon_graphe {");
      
      Export_Dot_Rec (A);
      
      Put_Line ("}");		  
   end Export_Dot;
   
   procedure Noeuds_Voisins (Cible : in Arbre; 
			     Petit_Voisin, Grand_Voisin : out Arbre) is
      Cour : Arbre;
   begin
      Petit_Voisin := null;
      Grand_Voisin := null;
      
      -- Grand_Voisin : 
      
      if Cible.Fils(Droite) /= null then
	 Cour := Cible.Fils(Droite);
	 loop
	    Grand_Voisin := Cour;
	    exit when Cour.Fils(Gauche) = null;
	    Cour := Cour.Fils(Gauche);
	 end loop;
      else
	 Cour := Cible.Pere;
	 loop
	    Grand_Voisin := Cour;
	    exit when Cour = null or else Cour.C > Cible.C;
	    Cour := Cour.Pere;
	 end loop;
      end if;
      
      -- Petit_Voisin : 
      
      if Cible.Fils(Gauche) /= null then
	 Cour := Cible.Fils(Gauche);
	 loop
	    Petit_Voisin := Cour;
	    exit when Cour.Fils(Droite) = null;
	    Cour := Cour.Fils(Droite);
	 end loop;
      else
	 Cour := Cible.Pere;
	 loop
	    Petit_Voisin := Cour;
	    exit when Cour = null or else not (Cour.C > Cible.C);
	    Cour := Cour.Pere;
	 end loop;
      end if;
      
   end Noeuds_Voisins;
   
   procedure Compte_Position (Cible : in Arbre;
			      Nb_Petits : out Natural;
			      Nb_Grands : out Natural) is
      Arbre_Courant : Arbre;
   begin
      
      -- Initialisation des variables
      Nb_Petits := 0;
      Nb_Grands := 0;
      Arbre_Courant := Cible;
      
      if (Cible.all.Fils(Gauche) /= null) then 
	 -- On compte dans le sous-arbre Gauche
	 Nb_Petits := Nb_Petits + Cible.all.Fils(Gauche).all.Compte;
      end if;
      
      if (Cible.all.Fils(Droite) /= null) then
	 -- On compte dans le sous-arbre droit
	 Nb_Grands := Nb_Grands + Cible.all.Fils(Droite).all.Compte;
      end if;  
      
      while (Arbre_Courant.all.Pere /= null) loop -- On remonte
	 
	 if (Arbre_Courant.all.Pere.all.C > Arbre_Courant.all.C) then
	    -- On différencie les cas où l'on est à droite ou à gauche du père
	    
	    Arbre_Courant := Arbre_Courant.all.Pere;
	    Nb_Grands := Nb_Grands + 1;
	    
	    if (Arbre_Courant.all.Fils(Droite) /= null) then 
	       Nb_Grands := Nb_Grands + Arbre_Courant.all.Fils(Droite).all.Compte ;
	    end if ;
	    
	 else -- (Arbre_Courant.all.Pere.all.C < Arbre_Courant.all.C) then -- On ne regarde pas le cas d'égalité
	    Arbre_Courant := Arbre_Courant.all.Pere ;
	    Nb_Petits := Nb_Petits + 1 ;
	    
	    if (Arbre_Courant.all.Fils(Gauche) /= null) then
	       Nb_Petits := Nb_Petits + 
		 Arbre_Courant.all.Fils(Gauche).all.Compte ;
	    end if ;
	    
	 end if ;
      end loop ;
   end Compte_Position ;   
   
end Generic_ABR;
