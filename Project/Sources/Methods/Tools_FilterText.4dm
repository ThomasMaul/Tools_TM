//%attributes = {"shared":true,"preemptive":"capable"}
  // Filter Text
  // $1 = Source, $0 = result
  // $2 = type
  // 1 = only numeric (0-9)
  // 2 = only numeric + special (0-9, -.,)
  // 3 = remove @
  // 4 = remove leading/ending blanks
  // 5 = remove leading '0'
  // 6 = remove tab or return

If (Count parameters:C259=2)
	Case of 
		: (($2=1) | ($2=2))
			$numeric:="0123456789"
			If ($2=2)
				$numeric:=$numeric+"-"
				GET SYSTEM FORMAT:C994(Decimal separator:K60:1;$char)
				$numeric:=$numeric+$char
				GET SYSTEM FORMAT:C994(Thousand separator:K60:2;$char)
				$numeric:=$numeric+$char
			End if 
			$t:=""
			For ($i;1;Length:C16($1))
				If (Position:C15($1[[$i]];$numeric)>0)
					$t:=$t+$1[[$i]]
				End if 
			End for 
			$0:=$t
			
		: ($2=3)
			$t:=""
			For ($i;1;Length:C16($1))
				If (Character code:C91($1[[$i]])#64)
					$t:=$t+$1[[$i]]
				End if 
			End for 
			$0:=$t
			
		: ($2=4)
			$text:=$1
			While ($text=" @")
				$text:=Substring:C12($text;2)
			End while 
			While ($text="@ ")
				$text:=Substring:C12($text;1;Length:C16($text)-1)
			End while 
			$0:=$text
			
		: ($2=5)
			$text:=$1
			While ($text="0@")
				$text:=Substring:C12($text;2)
			End while 
			$0:=$text
			
		: ($2=6)
			$t:=""
			For ($i;1;Length:C16($1))
				$charcode:=Character code:C91($1[[$i]])
				If (($charcode#9) & ($charcode#13) & ($charcode#10))
					$t:=$t+$1[[$i]]
				End if 
			End for 
			$0:=$t
			
		Else 
			$0:=$1
	End case 
Else 
	$0:="Internal error in Tools_FilterText, wrong parameters"
End if 
