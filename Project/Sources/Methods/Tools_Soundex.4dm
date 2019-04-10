//%attributes = {"shared":true,"preemptive":"capable"}
  // Aus Tech Note 6/92
  //  Soundex (Originalstring; Genauigkeit) -> String

If ($1#"")
	C_TEXT:C284($0;$1;$SoundsI;$Sounds)
	C_LONGINT:C283($2;$Zähler;$Nummer;$i;$Genau)
	
	$Sounds:="aehiouwybfpvcgjkqsxzdtlmnr"  //Group characters that sound alike
	$SoundsI:="11111111222233333333445667"  //Assign numbers for each group
	
	If (Count parameters:C259>=2)
		$Genau:=$2
	Else 
		$Genau:=3
	End if 
	
	If (Count parameters:C259=3)
		$variabel:=$3
	Else 
		$variabel:=False:C215
	End if 
	
	$0:=$1[[1]]+("0"*$Genau)  //Set a phonetic equivalent default
	$Zähler:=2
	$Nummer:=0
	For ($i;2;Length:C16($1)-1)
		$Nummer:=Position:C15($1[[$i]];$Sounds)
		If ($Nummer>0)
			If (($Zähler=2) | (($Zähler>2) & (Character code:C91($SoundsI[[$Nummer]])#Character code:C91($0[[$Zähler-1]]))))
				$0[[$Zähler]]:=$SoundsI[[$Nummer]]
				$Zähler:=$Zähler+1
				If ($Zähler>($Genau+1))
					$i:=Length:C16($1)
				End if 
			End if 
		End if 
	End for 
	
	If ($variabel)
		$0:=Substring:C12($0;1;$zähler-1)
	End if 
Else 
	$0:=""
End if 