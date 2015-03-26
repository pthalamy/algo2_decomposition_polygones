
package body Svg is
   
   type Color is (Violet, Indigo, Bleu, Vert, Jaune, Orange, Rouge, Noir, Blanc);
   function Code_Couleur (C : Color) return String is
   begin
      case C is
         when Violet  => return "rgb(255,0,255)";
         when Indigo  => return "rgb(111,0,255)";
         when Bleu  => return "rgb(0,0,255)";
         when Vert  => return "rgb(0,255,0)";
         When Jaune => return "rgb(0,255,255)";
         When Orange => return "rgb(255,165,0)";
         when Rouge => return "rgb(255,0,0)";
         when Noir  => return "rgb(0,0,0)";
         when Blanc => return "rgb(255,255,255)";
      end case;
   end Code_Couleur;
   
   -- Dessine une ligne A -- B
   procedure Svg_Line (A, B : in Sommet; 
		       C: in Color)
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
      Put (Svg_Out, """ style=""stroke:");
      Put (Svg_Out, Code_Couleur(C));
      Put_Line (Svg_Out, ";stroke-width:0.1""/>");
   end Svg_Line;
   
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
			     T : in TS_Ptr)
   is      
   begin
      Create (File => Svg_Out,
              Mode => Out_File,
              Name => Svg_Out_Str);
      
      Svg_Header;            
            
      -- Tracé du polygone
      for I in T.all'First..(T.all'Last - 1) loop	 
	 Svg_Line (T(I), T(I + 1), Bleu);
      end loop;
      Svg_Line (T(T.all'Last), T(T.all'First), Bleu);
      
      Svg_Footer;
      
      Close (Svg_Out);
   end Trace_Polygone;
   
end Svg;
