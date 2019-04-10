//%attributes = {"shared":true}
  // commit source changes to git - $1 = message
  // git repository needs to be created/setup upfront, git installed

If (Count parameters:C259>0)
	$message:=$1
Else 
	$message:=""
End if 

If ($message="")
	$message:=Request:C163("Commit message")
End if 

$path:=Get 4D folder:C485(Database folder:K5:14;*)  // structure for host
$in:=""
$out:=""
$error:=""

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";$path)
SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
LAUNCH EXTERNAL PROCESS:C811("git add --all";$in;$out;$error)
If (($out#"") | ($error#""))
	ALERT:C41("Error git add: "+$out+" "+$error)
Else 
	$command:="git commit -a -q -m "+Char:C90(34)+$message+Char:C90(34)
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";$path)
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	LAUNCH EXTERNAL PROCESS:C811($command;$in;$out;$error)
	If (($out#"") | ($error#""))
		ALERT:C41("Error git commit: "+$out+" "+$error)
	Else 
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";$path)
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
		LAUNCH EXTERNAL PROCESS:C811("git push";$in;$out;$error)
		If (($out#"") | ($error#""))
			ALERT:C41($out+" "+$error)
		Else 
			ALERT:C41("Done, but no return message?")
		End if 
	End if 
End if 
