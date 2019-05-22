//%attributes = {"shared":true,"preemptive":"capable"}
  // tools_ResizeArray(Arraypointer;newsize)
  // allows resizing for arrays of any type

ASSERT:C1129($2>=0;"Size needs to be >=0")
ASSERT:C1129(Type:C295($1)=Is pointer:K8:14;"parameter 1 needs to be a pointer to an array")
$a:=Type:C295($1->)
ASSERT:C1129(($a=Boolean array:K8:21) | ($a=Date array:K8:20) | ($a=Integer array:K8:18) | ($a=LongInt array:K8:19) | ($a=Picture array:K8:22)\
 | ($a=Pointer array:K8:23) | ($a=Real array:K8:17) | ($a=String array:K8:15) | ($a=Text array:K8:16) | ($a=31) | ($a=32) | ($a=39);\
"Parameter 1 needs to be pointer to array, received type="+String:C10($a))

$alt:=Size of array:C274($1->)
Case of 
	: ($2>$alt)
		$pos:=$2-$alt
		INSERT IN ARRAY:C227($1->;$alt+1;$pos)
	: ($2<$alt)
		$pos:=$alt-$2
		DELETE FROM ARRAY:C228($1->;$alt-$pos+1;$pos)
End case 
