//%attributes = {"shared":true}
  // __UNIT_TEST

$test:=New AJ_Tools_UT_describe ("CalendarWeek";Current method name:C684;"Tools")

$test.given:="2019-1-1"
$test.should:="1"
$test.expected:=1
$test.actual:=Tools_CalendarWeek (!2019-01-01!)
$test.assert()

$test.given:="2018-12-31"
$test.should:="1"
$test.expected:=1
$test.actual:=Tools_CalendarWeek (!2018-12-31!)
$test.assert()

$test.given:="2018-12-31"
$test.should:="52"
$test.expected:=52
$test.actual:=Tools_CalendarWeek (!2018-12-30!)
$test.assert()
