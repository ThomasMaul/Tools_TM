//%attributes = {}
  // Tools_Structure_Edit_Delete( ref; job; what)
  // belongs to group "Tools_Structure_Edit"
  // job = table, Field

  //Tools_Structure_Edit_Delete ($ref;"table";new object("table";"test10"))

C_OBJECT:C1216($1;$3)
C_TEXT:C284($2)

C_TEXT:C284($curname)
C_OBJECT:C1216($structure;$thetable;$field)

If ((String:C10($1.xml)#"") & (String:C10($1.path)#"") & ($1.structure#Null:C1517))
	$xml:=$1.xml
	$structure:=$1.structure
	
	
	Case of 
		: ($2="Table")
			If (String:C10($3.table)#"")
				$thetable:=$structure.getTableInfo(New object:C1471("name";$3.table))
				If ($thetable#Null:C1517)
					  // now we can modify...
					$found:=Structure_FindTable ($xml;$3.table)
					If ($found#"")
						DOM REMOVE XML ELEMENT:C869($found)
						$newfieldlist:=$structure.table.query("name != :1";$3.table)
						$structure.table:=$newfieldlist
					Else 
						ALERT:C41("Internal error, table not found")
					End if 
				Else 
					ALERT:C41("table does not exists")
				End if 
			Else 
				ALERT:C41("table name must not be empty")
			End if 
			
		: ($2="field")
			If ((String:C10($3.table)#"") & (String:C10($3.field)#""))
				$thetable:=$structure.getTableInfo(New object:C1471("name";$3.table))
				If (OB Is empty:C1297($thetable))
					ALERT:C41("table does not exist yet")
				Else 
					$field:=$structure.getFieldInfo(New object:C1471("table_name";$3.table;"field_name";$3.field))
					If ($field=Null:C1517)
						ALERT:C41("field does not exist yet")
					Else 
						$found:=Structure_FindTable ($xml;$3.table)
						$foundfield:=Structure_FindField ($found;$3.field)
						If ($foundfield#"")
							  //$4 contains all attributes to add or modify
							$newfieldlist:=$thetable.field.query("name != :1";$3.field)
							$thetable.field:=$newfieldlist
							DOM REMOVE XML ELEMENT:C869($foundfield)
						Else 
							ALERT:C41("Internal error, field not found")
						End if 
					End if 
				End if 
			End if   // case field
			
		: ($2="primary_key")
			If (String:C10($3.table)#"")
				$thetable:=$structure.getTableInfo(New object:C1471("name";$3.table))
				If (OB Is empty:C1297($thetable))
					ALERT:C41("table does not exist yet")
				Else 
					$found:=Structure_FindTable ($xml;$3.table)
					Repeat 
						$element:=DOM Find XML element:C864($found;"table/primary_key")
						If (OK=1)
							DOM REMOVE XML ELEMENT:C869($element)
						End if 
					Until (ok=0)
					OB REMOVE:C1226($thetable;"primary_key")
				End if 
			Else 
				ALERT:C41("Internal error, field not found")
			End if   // case pk
			
		: ($2="relation")
			If (String:C10($3.uuid)#"")
				$relation:=$structure.getRelationInfo(New object:C1471("uuid";$3.uuid))
				If (OB Is empty:C1297($relation))
					ALERT:C41("relation does not exist yet")
				Else 
					  // delete in xml
					
					  // delete in object
					
				End if 
			Else 
				ALERT:C41("Internal error, field not found")
			End if   // case pk
			
		Else   // case of
			ALERT:C41("Unknown kind for Edit_Create")
	End case 
	
Else 
	ALERT:C41("Reference seems not to be a valid Tools_Structure_Edit reference")
End if 
