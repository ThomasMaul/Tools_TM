//%attributes = {"invisible":true}
$test:=AJ_Tools_UT_runAll ()

ARRAY LONGINT:C221($a;1)
Tools_ResizeArray (->$a;10)

C_TEXT:C284($b)
Tools_ResizeArray (->$b;10)

C_POINTER:C301($c)
Tools_ResizeArray (->$c;10)

Tools_ResizeArray (->$a;-1)

  // another test
