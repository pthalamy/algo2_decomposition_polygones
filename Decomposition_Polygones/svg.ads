with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;

with Defs;
use Defs;

package Svg is
   
   -- Trace un polygone à partir des sommets contenus dans le tableau pointé par T
   -- sur le fichier donné en argument(2) du programme
   procedure Trace_Polygone (Svg_Out_Str : in String;
			     T : in TSom_Ptr);
   
   -- Trace les segments de régularisation du polynome contenus dans Segs
   -- dans le fichier de sortie SVG et en imprime le code sur stdout
   procedure Trace_Segments (Segs : in Liste_Segments);
   
private 
   
   Svg_Out : File_Type;
   
end Svg;
