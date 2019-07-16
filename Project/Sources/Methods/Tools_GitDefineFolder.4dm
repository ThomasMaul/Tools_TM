//%attributes = {"shared":true,"preemptive":"capable"}
  // call to define the source folder
  // needed to allow the macro to find the source if you still work in binary mode but export the structure to another folder
  // use the same path you pass to Tools_GitCommit.4dm

  // example to build that path:
  //$dbfolder:=Get 4D folder(Database folder)
  //$folder:=Path to object($dbfolder)
  //$gitfolder:=$folder.parentFolder+"MyApp_Export"


C_TEXT:C284($1)
Use (Storage:C1525)
	Storage:C1525.GitSetting:=New shared object:C1526
	Storage:C1525.GitSetting.GitFolder:=$1
End use 