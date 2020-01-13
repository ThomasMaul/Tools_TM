//%attributes = {}
  // builds the application
  // after build, it copies the Macros folder inside the component
  // I build on Mac, you might need to adapt path for windows

$continue:=True:C214

ARRAY TEXT:C222($components;0)
COMPONENT LIST:C1001($components)
If (Find in array:C230($components;"AJ_Tools_UnitTest")>0)  // Unit Test component is installed
	$continue:=zzbuild_unitTest 
End if 

If ($continue)
	$path:=Get 4D folder:C485(Database folder:K5:14)
	$buildpath:=$path+"Project"+Folder separator:K24:12+"BuildSettings"+Folder separator:K24:12+"BuildApp.xml"
	BUILD APPLICATION:C871($buildpath)
	If (OK=1)
		$pathtarget:=$path+"Build"+Folder separator:K24:12+"Components"+Folder separator:K24:12+"Tools_TM.4dbase"+Folder separator:K24:12+"Macros v2"
		$pathsource:=$path+"Macros v2"+Folder separator:K24:12+"Macros.xml"
		$pathtarget:=$pathtarget+Folder separator:K24:12+"Macros.xml"
		CREATE FOLDER:C475($pathtarget;*)
		If (Test path name:C476($pathtarget)=Is a document:K24:1)
			DELETE DOCUMENT:C159($pathtarget)
		End if 
		COPY DOCUMENT:C541($pathsource;$pathtarget)
		CONFIRM:C162("Build successfull - push to git?")
		If (OK=1)
			Tools_GitCommit 
		End if 
	Else 
		ALERT:C41("error during build")
	End if 
End if 
