//%attributes = {"shared":true}
If (Storage:C1525.GitSetting=Null:C1517)
	Tools_GitDefineFolder 
End if 

  // GET MACRO PARAMETER(Full method text;$methodText)  // different formating/options compared to method get code
  // benefit: contains unsaved changes. Method Get Code returns saved method.
$path:=$2
$methodText:=""
METHOD GET CODE:C1190($path;$methodText;Code with tokens:K72:18;*)

  //$method:="Sources/Methods/CompilerPara4.4dm"
$col:=Split string:C1554($path;"/")
If ($col.length>0)
	Case of 
		: ($col[0]="[projectForm]")
			If ($col[2]="{formMethod}")
				$method:="Sources/Forms/"+$col[1]+"/method.4dm"
			Else 
				$method:="Sources/Forms/"+$col[1]+"/ObjectMethods/"+$col[2]+".4dm"
			End if 
		: ($col[0]="[tableForm]")
			$table:=String:C10(ds:C1482[$col[1]].getInfo().tableNumber)
			If ($col[3]="{formMethod}")
				$method:="Sources/TableForms/"+$table+"/"+$col[2]+"/method.4dm"
			Else 
				$method:="Sources/TableForms/"+$table+"/"+$col[2]+"/ObjectMethods/"+$col[3]+".4dm"
			End if 
		: ($col[0]="[databaseMethod]")
			$method:="Sources/DatabaseMethods/"+$col[1]+".4dm"
		: ($col[0]="[trigger]")
			$table:=String:C10(ds:C1482[$col[1]].getInfo().tableNumber)
			$method:="Sources/Triggers/table_"+$table+".4dm"
		Else 
			$method:="Sources/Methods/"+$1+".4dm"
	End case 
	
Else 
	$method:="Sources/Methods/"+$1+".4dm"
End if 
If (String:C10(Storage:C1525.GitSetting.Prefix)#"")
	$method:=Storage:C1525.GitSetting.Prefix+"/"+$method
End if 

$formdata:=New object:C1471("method";$method;"folder";Storage:C1525.GitSetting.GitFolder;"newcontent";$methodText)
$win:=Open form window:C675("git_Compare")
DIALOG:C40("git_Compare";$formdata)
CLOSE WINDOW:C154($win)
