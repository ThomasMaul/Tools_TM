//%attributes = {"shared":true,"preemptive":"capable"}
  // $sel := ORDA_GetRelationSelection(fromsel;Data class name;maxdepth)
  // join an entity selection to a related data class and return selection

C_OBJECT:C1216($0;$1;$result;$in)
C_TEXT:C284($2;$toName)
C_LONGINT:C283($3;$depth)

$in:=$1
$toName:=$2
If (Count parameters:C259<3)
	$depth:=2
Else 
	$depth:=$3
End if 

ASSERT:C1129($in.getDataClass()#Null:C1517;"$1 must be an entity selection or entity")
ASSERT:C1129($toName#"";"$2 must not be empty")
ASSERT:C1129(ds:C1482[$toName]#Null:C1517;"$2 must be the name of a data class")
ASSERT:C1129(($depth>=0) & ($depth<10);"$3 must be in range 0..9")

C_TEXT:C284($fromName;$path)
$fromName:=$in.getDataClass().getInfo().name

$path:=Tools_FindRelationPath ($fromName;$toName;$depth)
If ($path#"")
	$o:=New object:C1471("from";$in;"to";New object:C1471())
	$o.formula:=Formula from string:C1601("This.to:=This.from"+$path)
	$o.formula()  //$o.to contains result!
	$result:=$o.to
End if 

If ($result=Null:C1517)
	$0:=ds:C1482[$toName].newSelection()
Else 
	$0:=$result
End if 