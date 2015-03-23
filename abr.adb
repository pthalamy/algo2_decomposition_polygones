
package body ABR is
   
   procedure Insertion (A : in out Arbre; V : in Natural) is
   begin
      if A = null then
	 A := new Noeud'(Val => V, 
			Fils => (others => null),
			Pere => null,
			Compte => 1);
	 return;
      end if;
      
      if A.Val <= V then
	 if A.Fils(Droite) = null then
	    A.Fils(Droite) := new Noeud'(Val => V, 
					Fils => (others => null),
					Pere => A,
					Compte => 1);
	 else 
	    Insertion (A.Fils(Droite), V);
	 end if;
      else
	 if A.Fils(Gauche) = null then
	    A.Fils(Gauche) := new Noeud'(Val => V, 
					Fils => (others => null),
					Pere => A,
					Compte => 1);
	 else 
	    Insertion (A.Fils(Gauche), V);
	 end if;
      end if;
   end Insertion;
   
   procedure Suppression (A : in out Arbre; V : in Natural) is
      Max : Natural := 0;
      
      procedure Sup_Max (Max : out Natural; A : in Arbre) is
      begin 
	 if A.Fils(Droite) /= null then
	    Sup_Max (Max, A.Fils(Droite));	    
	 else
	    Max := A.Val;
	 end if;
      end Sup_Max;
   begin
      if A = null then
	 Put_Line ("Arbre inexistant.");
      end if;
      
      if A.Val > V then
	 Suppression (A.Fils(Gauche), V);
      elsif A.Val < V then
	 Suppression (A.Fils(Droite), V);
      else
	 if A.Fils(Gauche) = null then
	    A := A.Fils(Droite);
	 elsif A.Fils(Droite) = null then
	    A := A.Fils(Gauche);
	 else
	    Sup_Max (Max, A.Fils(Gauche));
	    A.Val := Max;
	 end if;
      end if;      
   end Suppression;
   
   function Recherche (A : in out Arbre; V : in Natural) return Boolean is
   begin
      if A = null then
	 return False;
      end if;
      
      if A.Val = V then
	 return True;
      elsif A.Val < V then
	 return Recherche (A.Fils(Droite), V);
      else
	 return Recherche (A.Fils(Gauche), V);		   
      end if;
   end Recherche;   
   
   procedure Put (N : Noeud) is
   begin
      Put_Line (Integer'Image(N.Val) & "(" 
		  & Integer'Image(N.Fils(Droite).Val) & ", "
		  & Integer'Image(N.Fils(Gauche).Val) & ")");
   end Put;
   
   procedure Affichage (A : in out Arbre) is
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
   
end ABR;
