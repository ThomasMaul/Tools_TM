C_TEXT:C284($commit)

If (Form event:C388=On Load:K2:1)
	$path:=Get 4D folder:C485(Current resources folder:K5:16)+"gitdif"+Folder separator:K24:12+"template.html"
	WA OPEN URL:C1020(*;"Web Area";$path)
	
	
	$col:=New collection:C1472
	If ((Form:C1466.method#"") & (Form:C1466.folder#""))
		$path:="git log --abbrev-commit --date=iso -n 20 "+Char:C90(34)+Form:C1466.method+Char:C90(34)
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";Form:C1466.folder)
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
		$input:=""
		$out:=""
		$err:=""
		LAUNCH EXTERNAL PROCESS:C811($path;$input;$out;$err)
		
		
		  // error: fatal: ambiguous argument 'xxxx': unknown revision or path not in the working tree.\nUse '--' to separate paths from revisions, like this:\n'git <command> [<revision>...] -- [<file>...]'\n
		If (($err#"") & ($err#"@unknown revision or path not in the working tree@"))
			ALERT:C41($err)
		Else 
			$col.push(New object:C1471("name";"-";"stamp";"current";"commit";"-";"ID";"current"))
			If ($out#"")
				$lines:=Split string:C1554($out;Char:C90(10);sk trim spaces:K86:2)  // **** 10 auch unter windows?
				$counter:=0
				$max:=$lines.length
				While ($counter<=($max-5))
					If (($lines[$counter]="commit@") & (($counter+5)<$max))
						$name:=Substring:C12($lines[$counter+1];9)
						$id:=Substring:C12($lines[$counter];8)
						$date:=Substring:C12($lines[$counter+2];8)
						$commit:=$lines[$counter+4]
						$col.push(New object:C1471("name";$name;"stamp";$date;"commit";$commit;"ID";$id))
						$counter:=$counter+6
					Else 
						$counter:=$counter+1
					End if 
				End while 
			End if 
		End if 
	End if 
	Form:C1466.list:=$col
End if 