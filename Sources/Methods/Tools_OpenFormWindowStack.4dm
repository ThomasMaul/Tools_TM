//%attributes = {"shared":true}
  // open form window with stack feature
  // parameter : form name, then window type, then table ptr (if table form)

GET WINDOW RECT:C443($left_Master;$top_Master;$right_Master;$bottom_Master;Frontmost window:C447)

If (Count parameters:C259=1)
	$windowtyp:=Plain window:K34:13
Else 
	$windowtyp:=$2
End if 

$formular:=$1

If (Count parameters:C259<3)
	$win:=Open form window:C675($formular;$windowtyp;$left_Master+20;$top_Master+20)
Else 
	$win:=Open form window:C675($3->;$formular;$windowtyp;$left_Master+20;$top_Master+20)
End if 

$0:=$win