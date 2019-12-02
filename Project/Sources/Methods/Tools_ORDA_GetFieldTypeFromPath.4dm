//%attributes = {"shared":true}
  // returns field type for a given path
  // like Customer.name or Invoice.Customer.Name or InvoiceItem.Invoice.Customer.Name

C_TEXT:C284($1)
C_LONGINT:C283($0)

C_COLLECTION:C1488($parts;$col)
C_OBJECT:C1216($type;$table)

$parts:=Split string:C1554($1;".";sk trim spaces:K86:2+sk ignore empty strings:K86:1)
ASSERT:C1129($parts.length>=2;"Path needs to be minimum class and attribute")

If ($parts.length=2)  // we have the direct field
	$type:=ds:C1482[$parts[0]][$parts[1]]
	$0:=$type.fieldType
Else 
	  // first part is table name, second relation name, more to follow
	  // find related table name
	$table:=ds:C1482[$parts[0]][$parts[1]]
	$tablename:=String:C10($table.relatedDataClass)
	
	$col:=$parts.remove(0;2)
	$newpath:=$tablename+"."+$col.join(".")
	$0:=Tools_ORDA_GetFieldTypeFromPath ($newpath)
End if 