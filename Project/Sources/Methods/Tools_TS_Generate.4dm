//%attributes = {"shared":true,"preemptive":"capable"}
  // create Time Stamp
  // TS := gGenerateTimeStamp(date;time;{startdate})
  // creates timestamp based on 1.1.1980, except other value is passed in $3

C_DATE:C307($1;$3;$start)
C_TIME:C306($2)

If (Count parameters:C259>2)
	$start:=$3
Else 
	$start:=!1980-01-01!
End if 

  //  86400 = 60*60*24
$0:=(($1-$start)*86400)+($2+0)