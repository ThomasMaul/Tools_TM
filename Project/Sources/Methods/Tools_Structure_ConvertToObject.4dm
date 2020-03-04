//%attributes = {"shared":true,"preemptive":"capable"}
  // convert XML structure to object
  // pass structure text created with EXPORT STRUCTURE as $1
  // returns object with structure info

C_COLLECTION:C1488($files)
C_OBJECT:C1216($folder;$object)
C_TEXT:C284($xml)

$xml:=""
If (Count parameters:C259>0)
	$xml:=$1
End if 

If ($xml#"")
	$object:=Tools_XMLToObject ($xml;New collection:C1472("table";"field";"relation";"index";"primary_key"))
	
	$object.getTableInfo:=Formula:C1597(Tools_Structure_Read ("table";$1))
	$object.getFieldInfo:=Formula:C1597(Tools_Structure_Read ("field";$1))
	$object.getRelationInfo:=Formula:C1597(Tools_Structure_Read ("relation";$1))
	$object.getRelationInfos:=Formula:C1597(Tools_Structure_Read ("relations";$1))
	$object.getIndexInfo:=Formula:C1597(Tools_Structure_Read ("index";$1))
	$object.getIndexInfos:=Formula:C1597(Tools_Structure_Read ("indexes";$1))
	
	$0:=$object
Else 
	ALERT:C41("XML structure was passed, please specify in $1")
	$0:=New object:C1471  // failure
End if 
