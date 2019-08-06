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

C_TEXT:C284($gitpath)

If (Count parameters:C259>0)
	$gitpath:=$1
Else 
	$gitpath:=Get 4D folder:C485(Database folder:K5:14;*)  //+"Project"+Folder separator  // normally git is in main folder, including resources
End if 
  // $gitpath needs to be a valid path to a git repository. So we need to find inside ".git" folder
If (Test path name:C476($gitpath+".git")#Is a folder:K24:2)
	ASSERT:C1129(False:C215;"Git path seems invalid failed, cannot find repository in this folder")
	$gitpath:=""
End if 


Use (Storage:C1525)
	Storage:C1525.GitSetting:=New shared object:C1526
	Use (Storage:C1525.GitSetting)
		Storage:C1525.GitSetting.GitFolder:=$gitpath
		
		If (Count parameters:C259>1)
			Storage:C1525.GitSetting.Prefix:=$2
		Else 
			Storage:C1525.GitSetting.Prefix:=""
			If (Not:C34(Storage:C1525.GitSetting.GitFolder="@Sources"))
				If (Test path name:C476(Storage:C1525.GitSetting.GitFolder+"Project"+Folder separator:K24:12+"Sources"+Folder separator:K24:12)=Is a folder:K24:2)
					Storage:C1525.GitSetting.Prefix:="Project"
				Else 
					ASSERT:C1129(False:C215;"Git Prefix setting failed, cannot find Sources folder")
					Storage:C1525.GitSetting.Prefix:=""
				End if 
			End if 
		End if 
		
	End use 
End use 