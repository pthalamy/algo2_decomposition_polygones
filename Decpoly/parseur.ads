with Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;

with Defs;
use Defs;

package Parseur is
   
   -- Extrait les caractéristiques du polygone décrit par le fichier passé en 
   -- Argument 1 et les stocke dans le tableau T
   procedure Lecture (Fichier_In_Str : in String;
		      T : out TSom_Ptr);
   
end Parseur;
