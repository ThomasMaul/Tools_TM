//%attributes = {}
  // internal helper
  // find table in xml
  // $1 = xml, $2 table name, returns element xml

$xml:=$1
$tablename:=$2

$base:=DOM Find XML element:C864($xml;"base")
$child:=1
$xml_Child_Ref:=DOM Get first child XML element:C723($base;$name)
While (($name#"table") & (ok=1))
	$child:=$child+1
	$xml_Child_Ref:=DOM Get next sibling XML element:C724($xml_Child_Ref;$name)
End while 
  // we have the first table, now let's find the right one
$found:=""
$continue:=True:C214
Repeat 
	DOM GET XML ATTRIBUTE BY NAME:C728($xml_Child_Ref;"name";$curName)
	If ($curName=$tablename)
		$found:=$xml_Child_Ref
		$continue:=False:C215
	End if 
	$xml_Child_Ref:=DOM Get next sibling XML element:C724($xml_Child_Ref;$name)
	If (($name#"table") | (ok=0))
		$continue:=False:C215
	End if 
Until ($continue=False:C215)

$0:=$found