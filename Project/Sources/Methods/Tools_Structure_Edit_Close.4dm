//%attributes = {}
  // Tools_Structure_Edit_Close( ref (from open); savefile (true/false))
  // belongs to group "Tools_Structure_Edit"

C_OBJECT:C1216($1)
C_BOOLEAN:C305($2)

If ((String:C10($1.xml)#"") & (String:C10($1.path)#""))
	If ($2)
		DOM EXPORT TO FILE:C862($1.xml;$1.path)
	End if 
	DOM CLOSE XML:C722($1.xml)
	$1.xml:=""  // clear content
	$1.path:=""
	$1.structure:=New object:C1471
Else 
	ALERT:C41("Reference seems not to be a valid Tools_Structure_Edit reference")
End if 