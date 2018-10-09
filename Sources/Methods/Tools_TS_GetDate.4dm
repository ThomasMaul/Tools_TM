//%attributes = {"shared":true,"preemptive":"capable"}
  // TimeStamp, returns Date
  // $1 = Timestamp (L), optional $2 startdate

C_LONGINT:C283($1)
C_DATE:C307($0)

If (Count parameters:C259>1)
	$start:=$2
Else 
	$start:=!1980-01-01!
End if 

$0:=$start+($1\86400)