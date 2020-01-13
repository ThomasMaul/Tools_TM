//%attributes = {"shared":true}
  // __UNIT_TEST

$test:=New AJ_Tools_UT_describe ("CheckIBAN";Current method name:C684;"Tools")

  // numbers from https://ibanvalidieren.de/beispiele.html

$tests:=New collection:C1472
$tests.push("DE02120300000000202051")
$tests.push("DE02500105170137075030")
$tests.push("AT026000000001349870")
$tests.push("AT022081500000698597")
$tests.push("LI0308803103143000000")
$tests.push("CH0200784102000140304")

For each ($IBAN;$tests)
	$test.given:=$IBAN
	$test.should:="true"
	$test.expected:=True:C214
	$test.actual:=Tools_CheckIBAN ($iban)
	$test.assert()
End for each 

$test.given:="DE02500105170137075031"
$test.should:="false"
$test.expected:=False:C215
$test.actual:=Tools_CheckIBAN ("DE02500105170137075031")
$test.assert()
