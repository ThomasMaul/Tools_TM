//%attributes = {"shared":true,"preemptive":"capable"}
  // convert XML structure to object
  // pass path to structure.xml, without $1 it uses structure from host
  // this method is required to call for binary mode. For project mode structures it is handled automatically
  // returns object with structure info

C_OBJECT:C1216($files;$folder;$object)
C_TEXT:C284($path;$xml)

$path:=""
If (Count parameters:C259>0)
	$path:=$1
Else 
	$folder:=Folder:C1567("/SOURCES")
	If ($folder.name="Sources")  // we are in project mode, in binary it would be resources
		$files:=$folder.files().query("name=:1";"catalog")
		If ($files.length>0)
			$path:=$files[0].platformPath
		End if 
	End if 
End if 

If ($path#"")
	$xml:=Document to text:C1236($path)
	$object:=Tools_XMLToObject ($xml;New collection:C1472("table";"field";"relation";"index";"primary_key"))
	
	$object.getTableInfo:=Formula:C1597(Tools_Structure_Read ("table";$1))
	$object.getFieldInfo:=Formula:C1597(Tools_Structure_Read ("field";$1))
	$object.getRelationInfo:=Formula:C1597(Tools_Structure_Read ("relation";$1))
	$object.getRelationInfos:=Formula:C1597(Tools_Structure_Read ("relations";$1))
	$object.getIndexInfo:=Formula:C1597(Tools_Structure_Read ("index";$1))
	$object.getIndexInfos:=Formula:C1597(Tools_Structure_Read ("indexes";$1))
	
	$0:=$object
Else 
	ALERT:C41("XML structure was not found, please specify in $1")
	$0:=New object:C1471  // failure
End if 
