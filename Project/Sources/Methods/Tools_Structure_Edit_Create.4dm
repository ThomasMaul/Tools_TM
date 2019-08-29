//%attributes = {}
  // Tools_Structure_Edit_Create( ref; kind; id; object)
  // belongs to group "Tools_Structure_Edit"
  // job = Field, Table, Index, Relation; id = object

  //Tools_Structure_Edit_Create ($ref;"table";new object("table";"test10"))
  //Tools_Structure_Edit_Create ($ref;"field";new object("table";"test10";"field";"hello"))

C_OBJECT:C1216($1;$3)
C_TEXT:C284($2)

C_TEXT:C284($curName)
C_OBJECT:C1216($structure;$thetable)

If ((String:C10($1.xml)#"") & (String:C10($1.path)#"") & ($1.structure#Null:C1517))
	$xml:=$1.xml
	$structure:=$1.structure
	
	
	Case of 
		: ($2="Table")
			If (String:C10($3.table)#"")
				If (OB Is empty:C1297($structure.getTableInfo(New object:C1471("name";$3.table))))
					  //  we can create the table
					$new:=DOM Create XML Ref:C861("base")
					If ($structure.table#Null:C1517)
						$id:=String:C10(Num:C11($structure.table.max("id"))+1)
					Else 
						$id:="1"
					End if 
					$uuid:=Generate UUID:C1066
					$element:=DOM Create XML element:C865($new;"table";"name";$3.table;"uuid";$uuid;"id";$id)
					$structure.table.push(New object:C1471("name";$3.table;"uuid";$uuid;"id";$id))
					$base:=DOM Find XML element:C864($xml;"base")
					$child:=1
					$xml_Child_Ref:=DOM Get first child XML element:C723($base;$name)
					While (($name#"table") & (ok=1))
						$child:=$child+1
						$xml_Child_Ref:=DOM Get next sibling XML element:C724($xml_Child_Ref;$name)
					End while 
					
					$new:=DOM Insert XML element:C1083($base;$element;$child)
				Else 
					ALERT:C41("table already exists")
				End if 
			Else 
				ALERT:C41("table name must not be empty")
			End if 
			
		: ($2="Field")
			If ((String:C10($3.table)#"") & (String:C10($3.field)#""))
				If (OB Is empty:C1297($structure.getTableInfo(New object:C1471("name";$3.table))))
					ALERT:C41("table does not exist yet")
				Else 
					If (OB Is empty:C1297($structure.getFieldInfo(New object:C1471("table_name";$3.table;"field_name";$3.field))))
						  // finally, we can create the field. We first need to find the table, then add the field as first value
						$thetable:=$structure.getTableInfo(New object:C1471("name";$3.table))
						
						$new:=DOM Create XML Ref:C861("table")
						If ($thetable.field#Null:C1517)
							$id:=String:C10(Num:C11($thetable.field.max("id"))+1)
						Else 
							$id:="1"
						End if 
						$uuid:=Generate UUID:C1066
						$element:=DOM Create XML element:C865($new;"field";"name";$3.field;"uuid";$uuid;"id";$id)
						$thetable.field.push(New object:C1471("name";$3.field;"uuid";$uuid;"id";$id))
						
						$base:=DOM Find XML element:C864($xml;"base")
						$child:=1
						$xml_Child_Ref:=DOM Get first child XML element:C723($base;$name)
						While (($name#"table") & (ok=1))
							$child:=$child+1
							$xml_Child_Ref:=DOM Get next sibling XML element:C724($xml_Child_Ref;$name)
						End while 
						  // we have the first table, now let's find the right one
						$found:=""
						$continue:=True:C214
						Repeat 
							DOM GET XML ATTRIBUTE BY NAME:C728($xml_Child_Ref;"name";$curName)
							If ($curName=$3.table)
								$found:=$xml_Child_Ref
								$continue:=False:C215
							End if 
							$xml_Child_Ref:=DOM Get next sibling XML element:C724($xml_Child_Ref;$name)
							If (($name#"table") | (ok=0))
								$continue:=False:C215
							End if 
						Until ($continue=False:C215)
						If ($found#"")
							$new:=DOM Insert XML element:C1083($found;$element;1)
						End if 
					Else 
						ALERT:C41("field already exists")
					End if 
				End if 
			End if   // case field
			
			
			
			
			  // case
		Else 
			ALERT:C41("Unknown kind for Edit_Create")
	End case 
	
Else 
	ALERT:C41("Reference seems not to be a valid Tools_Structure_Edit reference")
End if 
