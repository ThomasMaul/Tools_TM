//%attributes = {"shared":true,"preemptive":"capable"}
  // Tools_Split2DimTextTTR(Arrayptr, Text;$MaxNumElements; {tabchar; returnzchar})
  //  Arrayptr Zeiger auf 2 dimensionale Alpha-Tabelle
  // ZERLEGT Text in Tab, Tab, Tab, ev. Return, bis zum Schluß und setzt in Tabelle,
  // diese wird neu dimensioniert!

$MaxAnzElemente:=$3
If (Count parameters:C259<5)
	$tab:=9
	$return:=13
Else 
	$tab:=$4
	$return:=$5
End if 

If (Type:C295($1->)#Array 2D:K8:24)
	  // do nothing
Else 
	
	C_LONGINT:C283($i;$pos)
	$i:=1
	$alti:=1
	  //%W-518.5
	ARRAY TEXT:C222($1->;0;$MaxAnzElemente)
	  //%W+518.5
	While ($i<=Length:C16($2))
		$buch:=Character code:C91($2[[$i]])
		If (($buch=$return) | ($i=Length:C16($2)))
			INSERT IN ARRAY:C227($1->;Size of array:C274($1->)+1)
			If ($i=Length:C16($2))
				$teiltext:=Substring:C12($2;$alti;($i-$alti)+1)+Char:C90($tab)
				$teiltext:=Replace string:C233($teiltext;Char:C90($return);"")
			Else 
				$teiltext:=Substring:C12($2;$alti;($i-$alti))+Char:C90($tab)
			End if 
			
			$i2:=1
			While ($teiltext#"")
				$p:=Position:C15(Char:C90($tab);$teiltext)
				If ($p>0)
					$wort:=Substring:C12($teiltext;1;$p-1)
					$teiltext:=Substring:C12($teiltext;$p+1)
					$1->{Size of array:C274($1->)}{$i2}:=$wort
					$i2:=$i2+1
					If ($i2>$MaxAnzElemente)
						$teiltext:=""
					End if 
				Else 
					$teiltext:=""
				End if 
			End while 
			
			$alti:=$i+1
		End if 
		$i:=$i+1
	End while 
	
	
End if 