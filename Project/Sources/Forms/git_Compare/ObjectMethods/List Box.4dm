C_TEXT:C284($result)
If (Form event:C388=On Clicked:K2:4)
	If (Form:C1466.lines.length>0)
		$id:=Form:C1466.lines[0].ID
		If ($id="current")
			Form:C1466.text1:=Form:C1466.newcontent
			$oldtime:="current"
		Else 
			$oldtime:=Form:C1466.lines[0].stamp
			$path:="git show "+$id+":"+Form:C1466.method
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";Form:C1466.folder)
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
			$input:=""
			$out:=""
			$err:=""
			LAUNCH EXTERNAL PROCESS:C811($path;$input;$out;$err)
			If ($err#"")
				ALERT:C41($err)
			Else 
				If ($out#"")
					Form:C1466.text1:=$out
				End if 
			End if 
		End if 
		
		If (Form:C1466.lines.length>1)
			$id:=Form:C1466.lines[1].ID
			$newtime:=Form:C1466.lines[1].stamp
			$path:="git show "+$id+":"+Form:C1466.method
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";Form:C1466.folder)
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
			$input:=""
			$out:=""
			$err:=""
			LAUNCH EXTERNAL PROCESS:C811($path;$input;$out;$err)
			If ($err#"")
				ALERT:C41($err)
			Else 
				If ($out#"")
					Form:C1466.text2:=$out
					
					$old:=Replace string:C233(Form:C1466.text1;Char:C90(13)+Char:C90(10);"\\n")
					$old:=Replace string:C233($old;Char:C90(13);"\\n")
					$old:=Replace string:C233($old;Char:C90(10);"\\n")
					$old:=Replace string:C233($old;Char:C90(34);"\\\"")  // replace with \"
					$old:=Replace string:C233($old;"'";"\\'")
					
					$new:=Replace string:C233(Form:C1466.text2;Char:C90(13)+Char:C90(10);"\\n")
					$new:=Replace string:C233($new;Char:C90(13);"\\n")
					$new:=Replace string:C233($new;Char:C90(10);"\\n")
					$new:=Replace string:C233($new;Char:C90(34);"\\\"")  // replace with \"
					$new:=Replace string:C233($new;"'";"\\'")
					
					$code:="TMdiff('"+$old+"', '"+$new+"', '"+$oldtime+"', '"+$newtime+"')"
					$result:=WA Evaluate JavaScript:C1029(*;"Web Area";$code)
				End if 
			End if 
		End if 
	End if 
End if 