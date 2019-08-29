//%attributes = {}
  //  // $1 = object what to do
  //  // $2, path to structure, optional
  //  // testing only


  //If (Count parameters>1)
  //$path:=$2
  //Else 
  //$folder:=Folder("/SOURCES")
  //If ($folder.name="Sources")  // we are in project mode, in binary it would be resources
  //$files:=$folder.files().query("name=:1";"catalog")
  //If ($files.length>0)
  //$path:=$files[0].platformPath
  //End if 
  //End if 
  //End if 

  //$ref:=Open document("";"";Get pathname)
  //$path:=document

  //If ($path="")
  //ALERT("Path to Structure Catalog not found")
  //Else 
  //$structure:=Tools_Structure_ConvertToObject ($path)

  //  // create table

  //$table:=New object
  //$table.name:="test"
  //$table.prevent_journaling:=True
  //$table.fields:=New collection
  //$table.fields.push(New object("name";"id";"type";2;"unique";True;"autosequence";True;"never_null";True))
  //$table.fields.push(New object("name";"field1";"type";10))

  //$table.primary_key:=New collection("id")
  //$table.table_extra:=New object("editor_table_info";New object("displayable_fields_count";6))

  //  // hier fehlt color und coordinates - und korrekte Auswertung *********************


  //  // need to get new id, find largest upfront
  //$id:=String(Num($structure.table.max("id"))+1)

  //  // check if table exists
  //ASSERT($table.name#"";"table name must not be empty")
  //$check:=$structure.getTableInfo(New object("name";$table.name))
  //If (OB Is empty($check))
  //$xml:=DOM Parse XML source($path)
  //$base:=DOM Find XML element($xml;"base")
  //$new:=DOM Create XML Ref("base")

  //  // create table with everything except fields, primary key and table_extra
  //  // add uuid and id automatically

  //$element:=DOM Create XML element($new;"table";"name";$table.name;"uuid";Generate UUID;"id";$id)
  //For each ($attribute;$table)
  //Case of 
  //: ($attribute="fields")
  //$i:=1
  //For each ($field;$table.fields)
  //$fielduuid:=Generate UUID
  //$fieldref:=DOM Create XML element($element;"field";"name";$field.name;"uuid";$fielduuid;"id";String($i))
  //$field.uuid:=$fielduuid
  //For each ($fieldattribute;$field)
  //If ($fieldattribute#"name")
  //DOM SET XML ATTRIBUTE($fieldref;$fieldattribute;$field[$fieldattribute])
  //End if 
  //End for each 
  //$i:=$i+1
  //End for each 

  //: ($attribute="primary_key")
  //  // nothing, we need to delay that and do it later!

  //: ($attribute="table_extra")

  //Else   // add all the other attributes
  //DOM SET XML ATTRIBUTE($element;$attribute;$table[$attribute])
  //End case 
  //End for each 

  //  // now handle Primary Keys
  //If ($table.primary_key#Null)
  //For each ($pk_fieldname;$table.primary_key)
  //$fieldcol:=$table.fields.query("name=:1";$pk_fieldname)
  //If ($fieldcol.length>0)
  //$fielduuid:=$fieldcol[0].uuid
  //$fieldref:=DOM Create XML element($element;"primary_key";"field_name";$pk_fieldname;"uuid";$fielduuid)
  //Else 
  //ALERT("Primary key field "+$pk_fieldname+" not found")
  //End if 
  //End for each 
  //End if 


  //  //$field:=DOM Create XML element($element;"field";"name";"uid";"uuid";Generate UUID;"id";"1";"type";"10";"limiting_length";"255";"unique";"true";\
						"autogenerate";"true";"store_as_UUID";"true")
  //  //$field2:=DOM Create XML element($element;"field";"name";"test";"uuid";Generate UUID;"id";"4";"type";"10")


  //$child:=1
  //$xml_Child_Ref:=DOM Get first child XML element($base;$name)
  //While (($name#"table") & (ok=1))
  //$child:=$child+1
  //$xml_Child_Ref:=DOM Get next sibling XML element($xml_Child_Ref;$name)
  //End while 

  //DOM Insert XML element($base;$element;$child)

  //DOM EXPORT TO FILE($xml;$path)
  //DOM CLOSE XML($xml)
  //Else 
  //ALERT("table already exists")
  //End if 
  //End if 