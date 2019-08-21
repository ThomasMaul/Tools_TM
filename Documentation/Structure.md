## Summary

The component includes commands helping to retrieve information about your structure, such as table or field details, info about relation or index.

## Tools_Structure_ConvertToObject

The command returns an object providing access to all details of your structure.
If your application runs in project mode, no parameter is needed.
If it is still in binary, export your structure once (in interpreted mode, before compile/build) and save it as text file on disk, such as:

EXPORT STRUCTURE($vTStruc)

TEXT TO DOCUMENT("myStructure.xml";$vTStruc)

Pass the path to the document as parameter to the command.


## Using the object

The object provides direct access to all content of the XML (which describes your structure). An object is much easier (and faster) to access as an XML, feel free to use all the power of the object notation in 4D.

## Object member methods
The object provides a set of member methods to ease the access to often needed elements, such as fields or tables.

Usage examples:  
$structure:=Tools_Structure_ConvertToObject ($path)

$table:=$structure.getTableInfo(New object("name";"Kunden"))  
$table:=$structure.getTableInfo(New object("uuid";"B54858F5EF4DA4409FFEA45A36030BA8"))
$table:=$structure.getTableInfo(New object("ptr";->[Table_1]))

$field:=$structure.getFieldInfo(New object("table_name";"Table_1";"field_name";"anotherfield"))
$field:=$structure.getFieldInfo(New object("uuid";"765C8B6456C04E8A9060E30729499663"))
$field:=$structure.getFieldInfo(New object("ptr";->[Table_1]testing_only))

$relation:=$structure.getRelationInfo(New object("uuid";"AF5A443934107E48870113FDBA3079DB"))

$relations:=$structure.getRelationInfos(New object("fromTable_name";"Auftrage";"toTable_name";"Kunden"))  
$relations:=$structure.getRelationInfos(New object("Table_name1";"Auftrage";"Table_name2";"Kunden"))  // any direction  
$relations:=$structure.getRelationInfos(New object("Table_name";"Auftrage"))  // any direction  
$relations:=$structure.getRelationInfos(New object("fromTable_name";"Kunden"))  
$relations:=$structure.getRelationInfos(New object("fromTable_name";"A@"))  
$relations:=$structure.getRelationInfos(New object("toTable_name";"Auftrage"))

$index:=$structure.getIndexInfo(New object("uuid";"DDD2D5C46CC74D8CA1B12B2DE61735A6"))
$index:=$structure.getIndexInfo(New object("name";"LKZ_PLZ"))

$indexes:=$structure.getIndexInfos(New object("table_name";"Kunden"))  
$indexes:=$structure.getIndexInfos(New object("table_name";"Kunden";"field_name";"PLZ"))  // could be more than one index  

In the examples above, returned value with singular (relation) is an object, containing the information for this single relation. If the name is plural (relations) it is a collection, containing a list of relations.


## Note
This part of the component is not useable if you did not enabled object notation in your compatibility settings.

