//%attributes = {"shared":true}
  // __UNIT_TEST

$test:=New AJ_Tools_UT_describe ("FilterText";Current method name:C684;"Tools")

$test.given:="hallo"
$test.should:="empty"
$test.expected:=""
$test.actual:=Tools_FilterText ($test.given;1)
$test.assert()

$test.given:="ha1lle"
$test.should:="1"
$test.expected:="1"
$test.actual:=Tools_FilterText ($test.given;1)
$test.assert()

$test.given:="-5;1"
$test.should:="5"
$test.expected:="5"
$test.actual:=Tools_FilterText ("-5";1)
$test.assert()

$test.given:="2,3;1"
$test.should:="23"
$test.expected:="23"
$test.actual:=Tools_FilterText ("2,3";1)
$test.assert()

$test.given:="-5;2"
$test.should:="-5"
$test.expected:="-5"
$test.actual:=Tools_FilterText ("-5";2)
$test.assert()

$test.given:="2,3;2"
$test.should:="2,3"
$test.expected:="2,3"
$test.actual:=Tools_FilterText ("2,3";2)
$test.assert()



$test.given:="pass@word;3"
$test.should:="password"
$test.expected:="password"
$test.actual:=Tools_FilterText ("pass@word";3)
$test.assert()

$test.given:="password@;3"
$test.should:="password"
$test.expected:="password"
$test.actual:=Tools_FilterText ("password@";3)
$test.assert()

$test.given:=" password  ;4"
$test.should:="password"
$test.expected:="password"
$test.actual:=Tools_FilterText (" password  ";4)
$test.assert()

$test.given:="0000123"
$test.should:="123"
$test.expected:="123"
$test.actual:=Tools_FilterText ("0000123";5)
$test.assert()

$test.given:="test\ttest"
$test.should:="testtest"
$test.expected:="testtest"
$test.actual:=Tools_FilterText ("test\ttest";6)
$test.assert()
$test.given:="test\rtest"
$test.should:="testtest"
$test.expected:="testtest"
$test.actual:=Tools_FilterText ("test\rtest";6)
$test.assert()
$test.given:="test\ntest"
$test.should:="testtest"
$test.expected:="testtest"
$test.actual:=Tools_FilterText ("test\ntest";6)
$test.assert()
