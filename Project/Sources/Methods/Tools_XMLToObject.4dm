//%attributes = {"shared":true,"preemptive":"capable"}
  // $object:=XMLToObject($XML_as_TEXT)
  // second parameter optional, if passed a collection of property names always to set as collection, not as object
  // used to convert Structure to XML

C_TEXT:C284($1;$text)
C_OBJECT:C1216($0;$obj)
C_COLLECTION:C1488($2;$col)

If (Count parameters:C259>1)
	$col:=$2
Else 
	$col:=New collection:C1472
End if 

$text:=$1
$ref:=DOM Parse XML variable:C720($text)
C_TEXT:C284($name)

If (OK=1)
	$obj:=New object:C1471
	
	  // root
	DOM GET XML ELEMENT NAME:C730($ref;$name)
	Tools_XMLtoObject_Sub ($obj;$name;$ref;$ref;$col)
	
	$subref:=DOM Get first child XML element:C723($ref;$Name;$ElemValue)
	Tools_XMLtoObject_Sub ($obj;$name;$subref;$ElemValue;$col)
	
	While (OK=1)
		$next_XML_Ref:=DOM Get next sibling XML element:C724($subref;$Name;$ElemValue)
		$subref:=$next_XML_Ref
		If (OK=1)
			Tools_XMLtoObject_Sub ($obj;$name;$next_XML_Ref;$ElemValue;$col)
		End if 
	End while 
	
	DOM CLOSE XML:C722($ref)
End if 
$0:=$obj