//%attributes = {"shared":true}
  // $object:=XMLToObject($XML_as_TEXT)

C_TEXT:C284($1;$text)
C_OBJECT:C1216($0;$obj)

$text:=$1
$ref:=DOM Parse XML variable:C720($text)
C_TEXT:C284($name)

If (OK=1)
	$obj:=New object:C1471
	
	  // root
	DOM GET XML ELEMENT NAME:C730($ref;$name)
	Tools_XMLtoObject_Sub ($obj;$name;$ref;$ref)
	
	$subref:=DOM Get first child XML element:C723($ref;$Name;$ElemValue)
	Tools_XMLtoObject_Sub ($obj;$name;$subref;$ElemValue)
	
	While (OK=1)
		$next_XML_Ref:=DOM Get next sibling XML element:C724($subref;$Name;$ElemValue)
		$subref:=$next_XML_Ref
		If (OK=1)
			Tools_XMLtoObject_Sub ($obj;$name;$next_XML_Ref;$ElemValue)
		End if 
	End while 
	
	DOM CLOSE XML:C722($ref)
End if 
$0:=$obj