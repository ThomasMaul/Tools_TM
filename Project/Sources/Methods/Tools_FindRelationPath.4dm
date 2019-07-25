//%attributes = {"invisible":true}
  // Path:=ORDA_FindRelationPath(FromName;ToName;MaxDepth)
  // find path between two classes
  // $1 = classFrom, $2 = classTo, $3 = maxdepth
  // $0 := path
  // not public

C_TEXT:C284($from;$1;$to;$2;$pathout;$0;$name)
C_LONGINT:C283($depth;$3)
C_OBJECT:C1216($field)

$from:=$1
$to:=$2
$depth:=$3
$pathout:=""

ASSERT:C1129($from#"";"$1 must not be empty")
ASSERT:C1129($to#"";"$2 must not be empty")
ASSERT:C1129(($depth>=0) & ($depth<10);"$3 must be in range 0..9")
ASSERT:C1129(ds:C1482[$from]#Null:C1517;"$1 must be the name of a data class")
ASSERT:C1129(ds:C1482[$to]#Null:C1517;"$1 must be the name of a data class")


For each ($name;ds:C1482[$from]) Until ($pathout#"")
	$field:=ds:C1482[$from][$name]
	If (($field.kind="relatedEntity") | ($field.kind="relatedEntities"))
		If ($field.relatedDataClass=$to)  // hit
			$pathout:="."+$field.name
		End if 
	End if 
End for each 

  // if no, for all properties of kind = relatedEntity or relatedEntities run recursive to find To
If ($pathout="")  // not found
	If ($depth>0)
		For each ($name;ds:C1482[$from]) While ($pathout="")
			$field:=ds:C1482[$from][$name]
			If (($field.kind="relatedEntity") | ($field.kind="relatedEntities"))
				$pathout:=Tools_FindRelationPath ($field.relatedDataClass;$to;$depth-1)
				If ($pathout#"")
					$pathout:="."+$field.name+$pathout
				End if 
			End if 
		End for each 
	End if 
End if 

$0:=$pathout