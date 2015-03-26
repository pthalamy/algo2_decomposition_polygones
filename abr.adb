
package body ABR is
   
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
   procedure Insertion (A : in out Arbre; C : in Type_Clef) is
   begin
      if A = null then
	 A := new Noeud'(C => C, 
			Fils => (others => null),
			Pere => null,
			Compte => 1);
	 return;
      end if;
      
      if A.C <= C then
	 if A.Fils(Droite) = null then
	    A.Fils(Droite) := new Noeud'(C => C, 
					Fils => (others => null),
					Pere => A,
					 Compte => 1);
	    MAJ_Voisinage (A, 1);
	 else 
	    Insertion (A.Fils(Droite), C);
	 end if;
      else
	 if A.Fils(Gauche) = null then
	    A.Fils(Gauche) := new Noeud'(C => C, 
					Fils => (others => null),
					Pere => A,
					 Compte => 1);
	    MAJ_Voisinage (A, 1);
	 else 
	    Insertion (A.Fils(Gauche), C);
	 end if;
      end if;      
      
   end Insertion;
   
   -- Supprime un noeud de valeur C dans l'arbre dont A est la racine      
   procedure Suppression (A : in out Arbre; C : in Type_Clef) is
      Max : Type_Clef := 0;
      
      -- Retourne la valeur la plus grande rencontrée dans le sous-arbre
      -- dont A est la racine
      procedure Sup_Max (A : in out Arbre; Max : out Type_Clef) is
      begin 
	 if A.Fils(Droite) = null then	    
	    Max := A.C;
	    A := A.Fils(Gauche);
	 else
	    Sup_Max (A.Fils(Droite), Max);	    	    
	 end if;
      end Sup_Max;
      
   begin
      if A = null then
	 Put_Line (Standard_Error, "suppression_error: Ceur non présente");
	 return;
      end if;
      
      if A.C > C then
	 Suppression (A.Fils(Gauche), C);
      elsif A.C < C then
	 Suppression (A.Fils(Droite), C);
      else
	 if A.Fils(Gauche) = null and A.Fils(Droite) = null then
	    MAJ_Voisinage (A.Pere, -1);
	 elsif A.Fils(Gauche) = null then
	    MAJ_Voisinage (A.Pere, -1);
	    A.Fils(Droite).Pere := A.Pere;
	    A := A.Fils(Droite);
	 elsif A.Fils(Droite) = null then
	    MAJ_Voisinage (A.Pere, -1);
	    A.Fils(Gauche).Pere := A.Pere;
	    A := A.Fils(Gauche);
	 else
	    Sup_Max (A.Fils(Gauche), Max);
	    A.C := Max;
	    MAJ_Voisinage (A.Pere, -1);		    
	 end if;
      end if;      
   end Suppression;
   
   
   -- Recherche le noeud de valeur C dans l'arbre dont A est la racine
   -- Return True si trouvé, false sinon
   -- Retourne aussi R, pointeur sur le noeud recherché
   function Recherche (A : in Arbre; 
		       C : in Type_Clef;
		       R : out Arbre) return Boolean is
   begin
      if A = null then
	 R := null;
	 return False;
      end if;
      
      if A.C = C then
	 R := A;
	 return True;
      elsif A.C < C then
	 return Recherche (A.Fils(Droite), C, R);
      else
	 return Recherche (A.Fils(Gauche), C, R);		   
      end if;
   end Recherche;   
   
   -- Affiche le noeud N sur Stdout
   procedure Put (N : Noeud) is
   begin
      Put (Integer'Image(Integer(N.C)) & " (");
      
      -- Affichage du voisinnage 
      
      if N.Fils(Gauche) /= null then
	 Put (Integer'Image(Integer(N.Fils(Gauche).C)) & ", ");
      else
	 Put ("null, ");
      end if;
      
      if N.Fils(Droite) /= null then
	 Put (Integer'Image(Integer(N.Fils(Droite).C)) & ")");
      else
	 Put ("null)");
      end if;
      
      --  Affichage de la profondeur du sous-arbre      
      Put (" || Depth : " & Integer'Image(Integer(N.Compte)));
      
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
   
   procedure Noeuds_Voisins (Cible : in Arbre; 
			     Petit_Voisin, Grand_Voisin : out Arbre) is
      Cour : Arbre := Cible;
   begin
      null;
   end Noeuds_Voisins;
   
   procedure Compte_Position (Cible : in Arbre; 
			      Nb_Petits, Nb_Grands : out Type_Clef) is
   begin
      null;
   end Compte_Position;

   
end ABR;
