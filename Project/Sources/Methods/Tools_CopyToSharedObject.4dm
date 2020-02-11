//%attributes = {"shared":true,"preemptive":"capable"}
/*
## Tools_CopyToSharedObject(Object ToCopy, Object CopyTo)
source: https://kb.4d.com/assetid=78197
*/

C_OBJECT:C1216($1;$2)
ARRAY TEXT:C222($arrNames;0)
OB GET PROPERTY NAMES:C1232($1;$arrNames;$arrTypes)
For ($counter;1;Size of array:C274($arrNames))
	Case of 
			  //Attribute type is object, copy with OB_CopyObject again
		: ($arrTypes{$counter}=Is object:K8:27)
			$2[$arrNames{$counter}]:=New shared object:C1526
			Use ($2[$arrNames{$counter}])
				Tools_CopyToSharedObject ($1[$arrNames{$counter}];$2[$arrNames{$counter}])
			End use 
			  //Attribute type is collection, copy with OB_CopyCollection
		: ($arrTypes{$counter}=Is collection:K8:32)
			$2[$arrNames{$counter}]:=New shared collection:C1527
			Use ($2[$arrNames{$counter}])
				Tools_CopyToSharedCollection ($1[$arrNames{$counter}];$2[$arrNames{$counter}])
			End use 
		Else 
			  // The rest supported types can be copied directly.
			$2[$arrNames{$counter}]:=$1[$arrNames{$counter}]
	End case 
End for 
