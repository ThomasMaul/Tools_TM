//%attributes = {"shared":true,"preemptive":"capable"}
  //CalendarWeek(Date)=LongInt
  //return calenderweek based on DIN 1355 (ISO/R 2015-1971)
  // from Ortwin Zillgen
C_LONGINT:C283($0)  //Ergebnis: Kalenderwoche
C_DATE:C307($1)  //Eingabe: Datum
C_DATE:C307($dat_jan4;$dat_dez31;$dat_jan1_vj)
$dat_jan4:=Add to date:C393(!1900-01-04!;(Year of:C25($1)-1900);0;0)
$0:=(($1+7)-($dat_jan4-((Day number:C114($dat_jan4)+5)%7)))\7
Case of 
	: ($0=0)
		$dat_jan1_vj:=Add to date:C393(!1900-01-01!;(Year of:C25($1)-1901);0;0)
		If ((Day number:C114($dat_jan1_vj)=5) | (Day number:C114($dat_jan4-4)=5))
			$0:=53
		Else 
			$0:=52
		End if 
	: ($0=53)
		$dat_dez31:=Add to date:C393(!1900-12-31!;(Year of:C25($1)-1900);0;0)
		If ((Day number:C114($dat_jan4-3)#5) & (Day number:C114($dat_dez31)#5))
			$0:=1
		End if 
End case 

