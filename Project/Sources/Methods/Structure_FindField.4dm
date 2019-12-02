//%attributes = {}
  // internal helper
  // find field in xml
  // $1 = xml to table element, $2 field name, returns element xml

$xml:=$1
$fieldname:=$2
$xml_Child_Ref:=DOM Get first child XML element:C723($xml;$name)

$found:=""
$continue:=True:C214
Repeat 
	DOM GET XML ATTRIBUTE BY NAME:C728($xml_Child_Ref;"name";$curName)
	If ($curName=$fieldname)
		$found:=$xml_Child_Ref
		$continue:=False:C215
	End if 
	$xml_Child_Ref:=DOM Get next sibling XML element:C724($xml_Child_Ref;$name)
	If (($name#"field") | (ok=0))
		$continue:=False:C215
	End if 
Until ($continue=False:C215)

$0:=$found