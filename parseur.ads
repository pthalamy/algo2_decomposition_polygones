with Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;

with Defs;
use Defs;

package Parseur is
   
   procedure Lecture (Fichier_In_Str : in String;
		      Nb_Sommets : out Natural;
		      T : out TS_Ptr);
   
end Parseur;
