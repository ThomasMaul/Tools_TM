//%attributes = {"invisible":true}
$path:=System folder:C487(Desktop:K41:16)+"catalog.4DCatalog"
$ref:=Tools_Structure_Edit_Open ($path)
  //Tools_Structure_Edit_Modify ($ref;"table";New object("table";"Brief");New object("prevent_journaling";True))
Tools_Structure_Edit_Modify ($ref;"field";New object:C1471("table";"Brief";"field";"Gruppe");New object:C1471("limiting_length";"30"))

Tools_Structure_Edit_Close ($ref;True:C214)

TRACE:C157
ABORT:C156

Tools_Structure_Edit_Create ($ref;"table";New object:C1471("table";"test11"))
Tools_Structure_Edit_Modify ($ref;"table";New object:C1471("table";"test11");New object:C1471("prevent_journaling";True:C214))

Tools_Structure_Edit_Create ($ref;"field";New object:C1471("table";"test11";"field";"hello"))


Tools_Structure_Edit_Close ($ref;True:C214)
