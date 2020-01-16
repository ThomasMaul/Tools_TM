//%attributes = {"shared":true,"preemptive":"capable"}
  //$value:=Tools_FindArrayValue("was";->webnames;->webvalues;$json)
  // usefull for WEB GET VARIABLES or value in JSON post as body

C_TEXT:C284($1)
C_POINTER:C301($3;$2)
C_OBJECT:C1216($4;$object)
ASSERT:C1129(Type:C295($3->)=Text array:K8:16;"$3 must be pointer to Text Array")
ASSERT:C1129(Type:C295($2->)=Text array:K8:16;"$2 must be pointer to Text Array")
ASSERT:C1129(Size of array:C274($2->)=Size of array:C274($3->);"Both arrays must be same size")

If (Count parameters:C259>3)
	$object:=$4
End if 

C_LONGINT:C283($pos)
$pos:=Find in array:C230($2->;$1)
If ($pos>0)
	$0:=$3->{$pos}
Else 
	If (OB Is empty:C1297($object))
		$0:=""
	Else 
		$0:=OB Get:C1224($object;$1;Is text:K8:3)
	End if 
End if 
