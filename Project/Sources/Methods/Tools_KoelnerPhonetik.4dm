//%attributes = {"shared":true,"preemptive":"capable"}
// soundex for German Language
// http//de.wikipedia.org/wiki/K%C3%B6lner_Phonetik
//$soundex := Tools_Soundex_Koeln(Wort)


C_TEXT:C284($1; $0)

$result:=""

$word:=Uppercase:C13($1)

$word:=Replace string:C233($word; "v"; "F")
$word:=Replace string:C233($word; "w"; "F")
$word:=Replace string:C233($word; "j"; "I")
$word:=Replace string:C233($word; "ph"; "F")

If (Length:C16($word)>0)
	
	// Nur Buchstaben(keine Zahlen, keine Sonderzeichen)
	$zwischen:=""
	For ($i; 1; Length:C16($word))
		$charvalue:=Character code:C91($word[[$i]])
		If (($charvalue>64) & ($charvalue<91))
			$zwischen:=$zwischen+$word[[$i]]
		End if 
	End for 
	$word:=$zwischen
	
	$loopstart:=0
	If (Length:C16($word)>0)
		// Sonderfälle bei Wortanfang(Anlaut)
		If ($word[[1]]="c")
			If (Length:C16($word)=1)
				$result:="8"
				$loopstart:=1
			Else 
				If (Position:C15($word[[2]]; "ahkloqrux")>0)
					$result:="4"
				Else 
					$result:="8"
				End if 
				$loopstart:=1
			End if 
		End if 
		
		// end Anlaut
		
		For ($x; $loopstart+1; Length:C16($word))
			$char:=$word[[$x]]
			Case of 
				: (Position:C15($char; "aeiou")>0)
					$result:=$result+"0"
				: (Position:C15($char; "bp")>0)
					$result:=$result+"1"
				: (Position:C15($char; "dt")>0)
					If ($x<Length:C16($word))
						If (Position:C15($word[[$x+1]]; "csz")>0)
							$result:=$result+"8"
						Else 
							$result:=$result+"2"
						End if 
					Else 
						$result:=$result+"2"
					End if 
				: ($char="f")
					$result:=$result+"3"
				: (Position:C15($char; "qkg")>0)
					$result:=$result+"4"
				: ($char="c")
					If ($x<Length:C16($word))
						If (Position:C15($word[[$x+1]]; "ahkoqux")>0)
							// nun davor
							If (Position:C15($word[[$x-1]]; "sz")>0)
								$result:=$result+"8"
							Else 
								$result:=$result+"4"
							End if 
						Else 
							$result:=$result+"8"
						End if 
					Else 
						$result:=$result+"8"
					End if 
				: ($char="x")
					If ($x>1)
						If (Position:C15($word[[$x-1]]; "ckq")>0)
							$result:=$result+"8"
						Else 
							$result:=$result+"48"
						End if 
					Else 
						$result:=$result+"48"
					End if 
				: ($char="l")
					$result:=$result+"5"
				: (Position:C15($char; "mn")>0)
					$result:=$result+"6"
				: ($char="r")
					$result:=$result+"7"
				: (Position:C15($char; "sz")>0)
					$result:=$result+"8"
			End case 
		End for 
		
	End if   // size#0
	
	
End if   // size#0

If ($result#"")
	$result:=$result[[1]]+Replace string:C233(Substring:C12($result; 2); "0"; "")
End if 

// Mehrfach Codes entfernen
$last:=""
$x:=1
$zwischen:=""
For ($x; 1; Length:C16($result))
	$char:=$result[[$x]]
	If ($char#$last)
		$zwischen:=$zwischen+$char
		$last:=$char
	End if 
End for 
$result:=$zwischen



$0:=$result