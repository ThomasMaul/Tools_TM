//%attributes = {"invisible":true,"preemptive":"capable"}
$obj:=$1
$name:=$2
$ref:=$3
$value:=$4
$col:=$5  // property name list, to be set always as collection, never as object

C_OBJECT:C1216($oldobject; $dummy)
$dummy:=New object:C1471
$numAttributes:=DOM Count XML attributes:C727($ref)
C_TEXT:C284($Attrib; $ValAttrib)

// store original name and fix issues such as hyphens
$dummy["__name"]:=$name
$name:=Replace string:C233($name; "-"; "_")

For ($i; 1; $numAttributes)
	DOM GET XML ATTRIBUTE BY INDEX:C729($ref; $i; $Attrib; $ValAttrib)
	$dummy[$Attrib]:=$ValAttrib
End for 
$testvalue:=Replace string:C233(Replace string:C233($value; "\n"; ""); "\t"; "")
If ($testvalue#"")
	$dummy.__value:=$value
End if 

$oldok:=ok
// check for childs
$subref:=DOM Get first child XML element:C723($ref; $child; $ElemValue)
If (OK=1)
	Tools_XMLtoObject_Sub($dummy; $child; $subref; $ElemValue; $col)
	
	While (OK=1)
		$next_XML_Ref:=DOM Get next sibling XML element:C724($subref; $child; $ElemValue)
		$subref:=$next_XML_Ref
		If (OK=1)
			Tools_XMLtoObject_Sub($dummy; $child; $next_XML_Ref; $ElemValue; $col)
		End if 
	End while 
End if 
ok:=$oldok

// add object to existing main object
If ($obj[$name]#Null:C1517)  // object already exists, we need a collection
	$type:=Value type:C1509($obj[$name])
	If ($type=Is object:K8:27)
		$oldobject:=$obj[$name]
		$obj[$name]:=New collection:C1472($obj[$name]; $dummy)
	Else 
		$obj[$name].push($dummy)
	End if 
Else 
	// add it as standard object - except if name is in exception list
	If ($col.indexOf($name)<0)
		$obj[$name]:=$dummy
	Else 
		// handle it as collection
		$obj[$name]:=New collection:C1472($dummy)
	End if 
End if 

