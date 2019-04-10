//%attributes = {"shared":true,"preemptive":"capable"}
  // errechnet aus TimeStamp Datum und Zeit
  //  gGetTimeStamp (TS;->Datum;->Zeit;{startdate})

C_POINTER:C301($2;$3)
C_LONGINT:C283($1)
C_DATE:C307($4;$start)

If (Count parameters:C259>3)
	$start:=$4
Else 
	$start:=!1980-01-01!
End if 

$2->:=$start+($1\86400)
$3->:=($1%86400)+?00:00:00?