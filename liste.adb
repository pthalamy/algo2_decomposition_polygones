
package body Liste is

   procedure Enqueue (L : in out Liste_Segments;
                      S : in Segment)
   is
   begin
      if L.Tete = null then
         raise Liste_Vide;
      end if;
      
      L.Queue.Suiv := new Cellule'(S, null);
      L.Queue := L.Queue.Suiv;

   exception
      when Liste_Vide =>
         L.Tete := new Cellule'(S, null);
         L.Queue := L.Tete;
   end Enqueue;
   
   procedure Liberer (L : in out Liste_Segments) is
      Suiv : Cell_Ptr;
      Cour : Cell_Ptr;
      
      procedure Free is
	 new Ada.Unchecked_Deallocation(Cellule, Cell_Ptr);
      
   begin 
      Cour := L.Tete;

      while Cour /= null loop
         Suiv := Cour.Suiv;
	 Free (Cour);
	 Cour := Suiv;
      end loop;

      L.Tete := null;
      L.Queue := null;
   end Liberer;
   
   procedure Put (L : in Liste_Segments) is
      Cour : Cell_Ptr;
   begin
      if L.Tete = null then
	 return;
      end if;

      Cour := L.Tete;

      while Cour /= null loop
	 Put (Cour.Seg);
         New_Line;
         Cour := Cour.Suiv;
      end loop;

   end Put;

end Liste;
