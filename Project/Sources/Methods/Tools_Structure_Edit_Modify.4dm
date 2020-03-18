//%attributes = {}
  // Tools_Structure_Edit_Modify( ref; job; what; object)
  // belongs to group "Tools_Structure_Edit"
  // job = table, Field

  //Tools_Structure_Edit_Modify ($ref;"table";new object("table";"test10");new object("prevent_journaling";true))

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
				If (Not:C34(OB Is empty:C1297($thetable)))
					$found:=DOM Find XML element:C864($xml;"/base/table[@name=\""+$3.table+"\"]")
					If (OK=1)
						For each ($attribute;$4)
							DOM SET XML ATTRIBUTE:C866($found;$attribute;$4[$attribute])
							$thetable[$attribute]:=$4[$attribute]
						End for each 
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
				If (OB Is empty:C1297($structure.getTableInfo(New object:C1471("name";$3.table))))
					ALERT:C41("table does not exist yet")
				Else 
					$field:=$structure.getFieldInfo(New object:C1471("table_name";$3.table;"field_name";$3.field))
					
					If (Not:C34(OB Is empty:C1297($field)))
						$found:=DOM Find XML element:C864($xml;"/base/table[@name=\""+$3.table+"\"]/field[@name=\""+$3.field+"\"]")
						If (OK=1)
							For each ($attribute;$4)
								DOM SET XML ATTRIBUTE:C866($found;$attribute;$4[$attribute])
								$field[$attribute]:=$4[$attribute]
							End for each 
						Else 
							ALERT:C41("Internal error, field not found")
						End if 
					End if 
				End if 
			End if   // case field
			
		Else   // case of
			ALERT:C41("Unknown kind for Edit_Create")
	End case 
	
Else 
	ALERT:C41("Reference seems not to be a valid Tools_Structure_Edit reference")
End if 
