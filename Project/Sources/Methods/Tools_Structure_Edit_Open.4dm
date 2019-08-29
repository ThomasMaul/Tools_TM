//%attributes = {}
  // $ref/object := Tools_Structure_Edit_Open( path to 4DCatalog)
  // belongs to group "Tools_Structure_Edit"
  // call once to get a reference, don't forget to close/save

C_TEXT:C284($1)
C_OBJECT:C1216($0;$result)

$result:=New object:C1471

If (Test path name:C476($1)#Is a document:K24:1)
	ALERT:C41("Catalog not found")
Else 
	$result.path:=$1
	$result.structure:=Tools_Structure_ConvertToObject ($1)
	$result.xml:=DOM Parse XML source:C719($1)
End if 

$0:=$result