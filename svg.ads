with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;

with Defs;
use Defs;

package Svg is
   
   procedure Trace_Polygone (Svg_Out_Str : in String;
			     T : in TSom_Ptr);
   
private 
   
   Svg_Out : File_Type;
   
end Svg;
