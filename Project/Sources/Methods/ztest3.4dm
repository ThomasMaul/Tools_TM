//%attributes = {"invisible":true}
$path:="/Users/thomas/Documents/4D/4DVerw_Export/Sources/catalog.4DCatalog"
$path:=System folder:C487(Desktop:K41:16)+"catalog.4DCatalog"
C_OBJECT:C1216($ref)
$ref:=Tools_Structure_Edit_Open ($path)

Tools_Structure_Edit_Create ($ref;"table";New object:C1471("table";"test11"))
Tools_Structure_Edit_Modify ($ref;"table";New object:C1471("table";"test11");New object:C1471("prevent_journaling";True:C214))

Tools_Structure_Edit_Create ($ref;"field";New object:C1471("table";"test11";"field";"hello"))


Tools_Structure_Edit_Close ($ref;True:C214)
