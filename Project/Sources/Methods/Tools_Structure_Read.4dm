//%attributes = {"invisible":true}
// function, called on object with structure info
// 1st parameter defines what info you want, could be Table or Field
// 2nd/3rd parameter is object name (table name, field name)

C_COLLECTION:C1488($tables; $fields; $indexes; $relations; $in; $out)
C_OBJECT:C1216($result; $table; $field; $index; $relation)

Case of 
	: ($1="table")
		If (This:C1470.table#Null:C1517)
			Case of 
				: ($2.name#Null:C1517)
					$tables:=This:C1470.table.query("name=:1"; $2.name)
				: ($2.uuid#Null:C1517)
					$tables:=This:C1470.table.query("uuid=:1"; $2.uuid)
				: ($2.ptr#Null:C1517)
					var $name:=Table name:C256($2.ptr)
					If ($name#"")
						$tables:=This:C1470.table.query("name=:1"; $name)
					End if 
			End case 
			If ($tables.length>0)
				$result:=$tables[0]
			End if 
		End if 
		
	: ($1="field")
		If (This:C1470.table#Null:C1517)
			Case of 
				: (($2.table_name#Null:C1517) & ($2.field_name#Null:C1517))
					$tables:=This:C1470.table.query("name=:1"; $2.table_name)
					If ($tables.length>0)
						$table:=$tables[0]
						If ($table.field#Null:C1517)
							$fields:=$table.field.query("name=:1"; $2.field_name)
							If ($fields.length>0)
								$result:=$fields[0]
							End if 
						End if 
					End if 
					
				: ($2.uuid#Null:C1517)
					For each ($table; This:C1470.table) Until ($fields.length>0)
						If ($table.field#Null:C1517)
							$fields:=$table.field.query("uuid=:1"; $2.uuid)
						End if 
					End for each 
					If ($fields.length>0)
						$result:=$fields[0]
					End if 
					
				: ($2.ptr#Null:C1517)
					$name:=Table name:C256($2.ptr)
					If ($name#"")
						$tables:=This:C1470.table.query("name=:1"; $name)
						If ($tables.length>0)
							$table:=$tables[0]
							var $Fieldname:=Field name:C257($2.ptr)
							If ($table.field#Null:C1517)
								$fields:=$table.field.query("name=:1"; $Fieldname)
								If ($fields.length>0)
									$result:=$fields[0]
								End if 
							End if 
						End if 
					End if 
			End case 
			
		End if 
		
	: ($1="relation")
		If (This:C1470.table#Null:C1517)
			Case of 
				: ($2.uuid#Null:C1517)
					$relations:=This:C1470.relation.query("uuid=:1"; $2.uuid)
					If ($relations.length>0)
						$result:=$relations[0]
					End if 
					
				: (($2.fromTable_name#Null:C1517) & ($2.relationName#Null:C1517))
					$relations:=This:C1470.relation.query("name_1toN=:1 or name_Nto1=:1"; $2.relationName)
					For each ($relation; $relations)
						$in:=$relation.related_field.query("kind='source' and field_ref.table_ref.name=:1"; $2.fromTable_name)
						If ($in.length>0)
							$result:=$relation
						End if 
					End for each 
				Else 
					$result:=New object:C1471
			End case 
		End if 
		
	: ($1="relations")
		// return collection in object, as it could be no, one or several index using this field
		// needs table name and field name
		If (This:C1470.table#Null:C1517)
			Case of 
				: (($2.fromTable_name#Null:C1517) & ($2.toTable_name#Null:C1517))
					For each ($relation; This:C1470.relation)
						$in:=$relation.related_field.query("kind='source' and field_ref.table_ref.name=:1"; $2.fromTable_name)
						$out:=$relation.related_field.query("kind='destination' and field_ref.table_ref.name=:1"; $2.toTable_name)
						If (($in.length>0) & ($out.length>0))
							If ($result=Null:C1517)
								$result:=New object:C1471("relations"; New collection:C1472($relation))
							Else 
								$result.relations.push($relation)
							End if 
						End if 
					End for each 
					
				: (($2.Table_name1#Null:C1517) & ($2.Table_name2#Null:C1517))
					For each ($relation; This:C1470.relation)
						$in:=$relation.related_field.query("field_ref.table_ref.name=:1"; $2.Table_name1)
						$out:=$relation.related_field.query("field_ref.table_ref.name=:1"; $2.Table_name2)
						If (($in.length>0) & ($out.length>0))
							If ($result=Null:C1517)
								$result:=New object:C1471("relations"; New collection:C1472($relation))
							Else 
								$result.relations.push($relation)
							End if 
						End if 
					End for each 
					
				: ($2.Table_name#Null:C1517)
					For each ($relation; This:C1470.relation)
						$in:=$relation.related_field.query("field_ref.table_ref.name=:1"; $2.Table_name)
						If ($in.length>0)
							If ($result=Null:C1517)
								$result:=New object:C1471("relations"; New collection:C1472($relation))
							Else 
								$result.relations.push($relation)
							End if 
						End if 
					End for each 
					
				: (($2.fromTable_name#Null:C1517) & ($2.relationName#Null:C1517))
					$relations:=This:C1470.relation.query("name_1toN=:1 or name_Nto1=:1"; $2.relationName)
					For each ($relation; $relations)
						$in:=$relation.related_field.query("kind='source' and field_ref.table_ref.name=:1"; $2.fromTable_name)
						If ($in.length>0)
							If ($result=Null:C1517)
								$result:=New object:C1471("relations"; New collection:C1472($relation))
							Else 
								$result.relations.push($relation)
							End if 
						End if 
					End for each 
					
				: ($2.fromTable_name#Null:C1517)
					For each ($relation; This:C1470.relation)
						$in:=$relation.related_field.query("kind='source' and field_ref.table_ref.name=:1"; $2.fromTable_name)
						If ($in.length>0)
							If ($result=Null:C1517)
								$result:=New object:C1471("relations"; New collection:C1472($relation))
							Else 
								$result.relations.push($relation)
							End if 
						End if 
					End for each 
					
				: ($2.toTable_name#Null:C1517)
					For each ($relation; This:C1470.relation)
						$in:=$relation.related_field.query("kind='destination' and field_ref.table_ref.name=:1"; $2.toTable_name)
						If ($in.length>0)
							If ($result=Null:C1517)
								$result:=New object:C1471("relations"; New collection:C1472($relation))
							Else 
								$result.relations.push($relation)
							End if 
						End if 
					End for each 
					
			End case 
		End if 
		
	: ($1="index")
		// return collection in object, as it could be no, one or several index using this field
		// needs table name and field name
		If (This:C1470.table#Null:C1517)
			Case of 
				: ($2.name#Null:C1517)
					$indexes:=This:C1470.index.query("name=:1"; $2.name)
				: ($2.uuid#Null:C1517)
					$indexes:=This:C1470.index.query("uuid=:1"; $2.uuid)
			End case 
			
			If ($indexes.length>0)
				$result:=$indexes[0]
			End if 
		End if 
		
	: ($1="indexes")
		// return collection in object, as it could be no, one or several index using this field
		// needs table name and field name
		If (This:C1470.table#Null:C1517)
			Case of 
				: (($2.table_name#Null:C1517) & ($2.field_name#Null:C1517))
					For each ($index; This:C1470.index)
						// field_ref could be an object or a collection
						// field_ref is also used for relations, so we cannot convert to collection based on name
						If (Value type:C1509($index.field_ref)=Is object:K8:27)
							If (String:C10($index.field_ref.table_ref.name)=$2.table_name)
								If (String:C10($index.field_ref.name)=$2.field_name)
									If ($result=Null:C1517)
										$result:=New object:C1471("index"; New collection:C1472($index))
									Else 
										$result.index.push($index)
									End if 
								End if 
							End if 
						Else 
							$in:=$index.field_ref.query("table_ref.name=:1 and name=:2"; $2.table_name; $2.field_name)
							If ($in.length>0)
								If ($result=Null:C1517)
									$result:=New object:C1471("index"; New collection:C1472($index))
								Else 
									$result.index.push($index)
								End if 
							End if 
						End if 
					End for each 
					
				: ($2.table_name#Null:C1517)
					For each ($index; This:C1470.index)
						// field_ref could be an object or a collection
						// field_ref is also used for relations, so we cannot convert to collection based on name
						If (Value type:C1509($index.field_ref)=Is object:K8:27)
							If (String:C10($index.field_ref.table_ref.name)=$2.table_name)
								If ($result=Null:C1517)
									$result:=New object:C1471("index"; New collection:C1472($index))
								Else 
									$result.index.push($index)
								End if 
							End if 
						Else 
							$in:=$index.field_ref.query("table_ref.name=:1"; $2.table_name)
							If ($in.length>0)
								If ($result=Null:C1517)
									$result:=New object:C1471("index"; New collection:C1472($index))
								Else 
									$result.index.push($index)
								End if 
							End if 
						End if 
						
						
					End for each 
					
			End case 
		End if 
		
	Else 
		// nothing
		
End case 

If ($result=Null:C1517)
	$0:=New object:C1471
Else 
	$0:=$result
End if 
