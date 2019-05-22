//%attributes = {"shared":true,"preemptive":"incapable"}
  // AdjustWindowSize(TEXT Formularname; POINTER CurFormTable)
  // checks if current window is fully visible and large enough for current form

C_TEXT:C284($1;$Formularname)
$Formularname:=$1
C_POINTER:C301($2;$CurFormTable)
$CurFormTable:=$2

ASSERT:C1129($Formularname#"";"Form name required as parameter 1")
ASSERT:C1129(Type:C295($2)=Is pointer:K8:14;"Pointer required as parameter 2")

$pos:=Position:C15("].";$Formularname)
$Formularname:=Substring:C12($Formularname;$pos+2)

GET WINDOW RECT:C443($links2;$oben2;$rechts2;$unten2)
FORM GET PROPERTIES:C674($CurFormTable->;$Formularname;$breite;$höhe)
If (($rechts2-$links2)<$breite)
	$rechts2:=$links2+$breite
	If ($rechts2>(Screen width:C187-10))
		$rechts2:=Screen width:C187-10
		$links2:=$rechts2-$breite
	End if 
	SET WINDOW RECT:C444($links2;$oben2;$rechts2;$unten2)
End if 
If (($unten2-$oben2)<$höhe)
	$unten2:=$oben2+$höhe
	If ($unten2>(Screen height:C188-10))
		$unten2:=Screen height:C188-10
		$oben2:=$unten2-$oben2
	End if 
	SET WINDOW RECT:C444($links2;$oben2;$rechts2;$unten2)
End if 
