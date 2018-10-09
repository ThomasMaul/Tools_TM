//%attributes = {"invisible":true}
$url:="abc küßt"
$result:=Tools_URL_Encoder ($url;"UTF-8")
ALERT:C41($result)
