//%attributes = {"shared":true}
  // Find next new line
  // in case we don't know if it is 10, 13 or 13/10
  // $1 = text
  // $2 (optional) start pos
  // $0 resultpos

C_TEXT:C284($1)
C_LONGINT:C283($2;$pos;$0)
If (Count parameters:C259>1)
	$pos:=$2
Else 
	$pos:=1
End if 

If ($1#"")
	While (($pos<Length:C16($1)) & ($1[[$pos]]#Char:C90(13)) & ($1[[$pos]]#Char:C90(10)))
		$pos:=$pos+1
	End while 
	$0:=$pos
Else 
	$0:=0
End if 