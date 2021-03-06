
package body Svg is

   -- Dessine une ligne A -- B sur le fichier SVG
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
      Put (Svg_Out, ";stroke-width:0.05"" ");
      Put_Line (Svg_Out, "transform=""translate("
                  & Float'Image(Translation_Offset_X)
                  & ',' & Float'Image(Translation_Offset_Y)
                  & ")"" />");
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
      Put (Svg_Out, """ style=""fill:lightcyan;stroke:black;stroke-width:0.01"" ");
      Put_Line (Svg_Out, "transform=""translate("
                  & Float'Image(Translation_Offset_X)
                  & ',' & Float'Image(Translation_Offset_Y)
                  & ")"" />");
   end Svg_Polygon;


   procedure Svg_Header is
   begin
      Put (Svg_Out, "<svg width=""");
      Put (Svg_Out, 2.0 * Margin_Offset*(X_Max - X_Min)  + X_Max - X_Min);
      Put (Svg_Out, """ height=""");
      Put (Svg_Out, 2.0 * Margin_Offset*(Y_Max - Y_Min) +
             Y_Max - Y_Min);
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

      Svg_Polygon (T);
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
