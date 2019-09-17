//%attributes = {"shared":true}
  // __UNIT_TEST

$test:=New AJ_Tools_UT_describe ("FindArrayValue";Current method name:C684;"Tools")


ARRAY TEXT:C222($t1;3)
ARRAY TEXT:C222($t2;3)
$t1{1}:="name"
$t1{2}:="value"
$t1{3}:="option"
$t2{1}:="1"
$t2{2}:="2"
$t2{3}:="3"
$test.given:="array1"
$test.should:="2"
$test.expected:="2"
$test.actual:=Tools_FindArrayValue ("value";->$t1;->$t2)
$test.assert()

ARRAY TEXT:C222($t1;3)
ARRAY TEXT:C222($t2;3)
$t1{1}:="name"
$t1{2}:="value"
$t1{3}:="option"
$t2{1}:="1"
$t2{2}:="2"
$t2{3}:="3"
$test.given:="array2"
$test.should:=""
$test.expected:=""
$test.actual:=Tools_FindArrayValue ("valu";->$t1;->$t2)
$test.assert()

ARRAY TEXT:C222($t1;3)
ARRAY TEXT:C222($t2;3)
$t1{1}:="name"
$t1{2}:="value"
$t1{3}:="option"
$t2{1}:="1"
$t2{2}:="2"
$t2{3}:="3"
$object:=New object:C1471("valu";"4")
$test.given:="array3"
$test.should:="4"
$test.expected:="4"
$test.actual:=Tools_FindArrayValue ("valu";->$t1;->$t2;$object)
$test.assert()


