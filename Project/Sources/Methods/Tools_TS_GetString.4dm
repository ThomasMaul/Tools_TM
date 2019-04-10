//%attributes = {"shared":true,"preemptive":"capable"}
  //  übergibt aus TimeStamp String
  // Tools_TS_GetString(Timestamp Longint;{Startdatei})

C_LONGINT:C283($1)
C_TEXT:C284($0)
C_DATE:C307($2)

If (Count parameters:C259>1)
	$start:=$2
Else 
	$start:=!1980-01-01!
End if 

$0:=String:C10($start+($1\86400);7)+" - "+Time string:C180(($1%86400)+?00:00:00?)