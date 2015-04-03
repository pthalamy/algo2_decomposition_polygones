
package body Svg is
      
   -- Dessine une ligne A -- B
   procedure Svg_Line (A, B : in Position)
   is
   begin
      Put (Svg_Out, "<line x1=""");
      Put (Svg_Out, A.X);
      Put (Svg_Out, """ y1=""");
      Put (Svg_Out, A.Y);
      Put (Svg_Out, """ x2=""");
      Put (Svg_Out, B.X);
      Put (Svg_Out, """ y2=""");
      Put (Svg_Out, B.Y);
      Put (Svg_Out, """ style=""stroke:darkred");
      Put_Line (Svg_Out, ";stroke-width:0.05"" transform=""translate(5,5)""/>");
   end Svg_Line;
   
   procedure Svg_Polygon (T : in TSom_Ptr)
   is
   begin
      Put (Svg_Out, "<polygon points=""");
      for I in T.all'Range loop
	 Put (Svg_Out, T(I).Pos.X); 
	 Put (Svg_Out, ',');
	 Put (Svg_Out, T(I).Pos.Y);
	 Put (Svg_Out, ' ');
      end loop;
      Put (Svg_Out, """ style=""fill:lightcyan;stroke:black;stroke-width:0.05""" 
	     & " transform=""translate(5,5)"" />");
   end Svg_Polygon;

   
   procedure Svg_Header is
      begin
         Put (Svg_Out, "<svg width=""");
         Put (Svg_Out, 10.0);
         Put (Svg_Out, """ height=""");
         Put (Svg_Out, 10.0);
         Put_Line (Svg_Out, """>");
      end Svg_Header;
      
      procedure Svg_Footer is
      begin
         Put_Line (Svg_Out, "</svg>");
      end Svg_Footer;

   procedure Trace_Polygone (Svg_Out_Str : in String;
			     T : in TSom_Ptr)
   is      
   begin
      Create (File => Svg_Out,
              Mode => Out_File,
              Name => Svg_Out_Str);
      
      Svg_Header;            
            
      -- Tracé du polygone
      --  for I in T.all'First..(T.all'Last - 1) loop	 
      --  	 Svg_Line (T(I).Pos, T(I + 1).Pos, Bleu);
      --  end loop;
      Svg_Polygon (T);
      
      --  Svg_Line (T(T.all'Last).Pos, T(T.all'First).Pos, Bleu);                  
   end Trace_Polygone;
   
   procedure Trace_Segments (Segs : in Liste_Segments) is
      Seg_Cour : Cell_Ptr;   
   begin
      Seg_Cour := Segs.Tete;
      while Seg_Cour /= null loop
	 Svg_Line (Seg_Cour.Seg.A.Pos, Seg_Cour.Seg.B.Pos);
	 Seg_Cour := Seg_Cour.Suiv;
      end loop;
      
      Svg_Footer;
      
      Close (Svg_Out);
   end Trace_Segments;
   
end Svg;
