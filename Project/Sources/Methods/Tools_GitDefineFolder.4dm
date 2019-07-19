//%attributes = {"shared":true,"preemptive":"capable"}
  // Tools_GitDefineFolder(path to folder published via Git; prefix to sources)
  // call to define the source folder
  // needed to allow the macro to find the source if you still work in binary mode but export the structure to another folder
  // use the same path you pass to Tools_GitCommit.4dm
  // example to build that path:
  //$dbfolder:=Get 4D folder(Database folder)
  //$folder:=Path to object($dbfolder)
  //$gitfolder:=$folder.parentFolder+"MyApp_Export"+Folder separator 


C_TEXT:C284($1)  // path to Git folder (usually containing Project, Resources, WebFolder, etc)
C_TEXT:C284($2)  // prefix for Sources folder, if missing default to "Project"

Use (Storage:C1525)
	Storage:C1525.GitSetting:=New shared object:C1526
	Use (Storage:C1525.GitSetting)
		If (Count parameters:C259>0)
			Storage:C1525.GitSetting.GitFolder:=$1
		Else 
			Storage:C1525.GitSetting.GitFolder:=Get 4D folder:C485(Database folder:K5:14;*)  //+"Project"+Folder separator  // normally git is in main folder, including resources
		End if 
		
		If (Count parameters:C259>1)
			Storage:C1525.GitSetting.Prefix:=$2
		Else 
			Storage:C1525.GitSetting.Prefix:=""
			If (Not:C34(Storage:C1525.GitSetting.GitFolder="@Sources"))
				If (Test path name:C476(Storage:C1525.GitSetting.GitFolder+"Project"+Folder separator:K24:12+"Sources"+Folder separator:K24:12)=Is a folder:K24:2)
					Storage:C1525.GitSetting.Prefix:="Project"
				End if 
			End if 
		End if 
		
	End use 
End use 