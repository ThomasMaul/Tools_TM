//%attributes = {"shared":true,"preemptive":"capable"}
  // ZerlegeTabText (Arrayptr, Text; {tabzeichen; returnzeichen})
  //  Arrayptr Zeiger auf Alpha-Tabelle
  // ZERLEGT Text in Tab, Tab, Tab, ev. Return, bis zum Schluß und setzt in Tabelle,



ASSERT:C1129(Type:C295($1)=Is pointer:K8:14;"parameter 1 needs to be a pointer to an array")
$a:=Type:C295($1->)
ASSERT:C1129((($a=String array:K8:15) | ($a=Text array:K8:16));\
"Parameter 1 needs to be pointer to text array, received type="+String:C10($a))

If (Count parameters:C259<4)
	$tab:=9
	$return:=13
Else 
	$tab:=$3
	$return:=$4
End if 

DELETE FROM ARRAY:C228($1->;1;Size of array:C274($1->))

If ((Type:C295($1->)#Text array:K8:16) & (Type:C295($1->)#String array:K8:15))
	  // do nothing
Else 
	
	C_LONGINT:C283($i;$alti;$buch)
	
	$i:=1
	$alti:=1
	
	While ($i<=Length:C16($2))
		$buch:=Character code:C91($2[[$i]])
		If (($buch=$tab) | ($buch=$return))  // Tab oder Return
			$new:=Substring:C12($2;$alti;($i-$alti))
			If ($new=(Char:C90(10)+"@"))
				$new:=Substring:C12($new;2)
			End if 
			APPEND TO ARRAY:C911($1->;$new)
			$alti:=$i+1
		End if 
		$i:=$i+1
	End while 
	If ($i>$alti)
		$new:=Substring:C12($2;$alti;($i-$alti))
		If ($new=(Char:C90(10)+"@"))
			$new:=Substring:C12($new;2)
		End if 
		APPEND TO ARRAY:C911($1->;$new)
	End if 
End if 