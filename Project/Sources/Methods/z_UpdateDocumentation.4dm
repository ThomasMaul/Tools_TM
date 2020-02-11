//%attributes = {"invisible":true}
  // update Documentation folder
  // creates md files for each method which is shared and starts with either a /* or // block

C_OBJECT:C1216($docufolder;$methodfolder;$method;$file)
C_BOOLEAN:C305($status)
C_TEXT:C284($code;$comment)
C_COLLECTION:C1488($codelines)
C_LONGINT:C283($loop)

$docufolder:=Folder:C1567("/SOURCES/Documentation")  // :Tools_TM:Project:Sources:
$status:=$docufolder.create()

$methodfolder:=Folder:C1567("/SOURCES/Methods")

For each ($method;$methodfolder.files())
	$code:=$method.getText()
	$codelines:=Split string:C1554($code;Char:C90(13))
	$comment:=""
	
	If ($codelines.length>3)
		If ($codelines[0]="@\"shared\":true@")
			
			If ($codelines[1]="/*@")
				$loop:=2
				  // search for end of comment, take the part between as documentation
				While (($loop<$codelines.length) & ($codelines[$loop]#"*/@"))
					$comment:=$comment+$codelines[$loop]+"  "+Char:C90(13)
					$loop:=$loop+1
				End while 
			Else 
				$loop:=1
				While (($loop<$codelines.length) & ($codelines[$loop]="  //@"))
					$comment:=$comment+Substring:C12($codelines[$loop];5)+"  "+Char:C90(13)
					$loop:=$loop+1
				End while 
			End if 
		End if 
	End if 
	
	If ($comment#"")
		If ($comment#"##@")
			$comment:="## "+$comment
		End if 
		$file:=$docufolder.file($method.name+".md")
		$file.setText($comment)
	End if 
	
End for each 
