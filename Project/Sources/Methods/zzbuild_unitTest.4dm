//%attributes = {}
  // run Unit tests
  // to do so, first copy them into the right folder
  // after testing, move them out

C_COLLECTION:C1488($unittests;$createdmethods;$existingmethods)
C_OBJECT:C1216($unittestfolder;$methodfolder;$unittest;$todelete)

$createdmethods:=New collection:C1472()
$unittestfolder:=Folder:C1567("/PACKAGE").folder("UnitTests")
$unittests:=$unittestfolder.files()
$methodfolder:=Folder:C1567("/PACKAGE").folder("Project").folder("Sources").folder("Methods")
$existingmethods:=$methodfolder.files()
For each ($unittest;$unittests)
	If ($unittest.extension=".4DM")
		If ($existingmethods.countValues("name";$unittest.name)=0)
			  // does not exists yet
			$createdmethods.push($unittest.copyTo($methodfolder))
		End if 
	End if 
End for each 

If ($createdmethods.length#0)
	ALERT:C41("click ok to open debugger, then click finder or explorer window, then back in trace window, then continue")
	TRACE:C157
End if 

$result:=New object:C1471
EXECUTE METHOD:C1007("AJ_Tools_UT_runAll";$result)
  //$result:=AJ_Tools_UT_runAll 
If ($result.countFail#0)
	ALERT:C41("Unit Tests failed")
	EXECUTE METHOD:C1007("AJ_Tools_UT_LaunchMainWindow")
	  //AJ_Tools_UT_LaunchMainWindow 
	$continue:=False:C215
Else 
	$continue:=True:C214
End if 

If ($createdmethods.length#0)
	If ($result.countFail#0)
		ALERT:C41("ERROR - click on for debugger, keep it open till you fixed all issues, then click finder or explorer window, then back in trace window, then continue")
	Else 
		ALERT:C41("click ok to open debugger, then click finder or explorer window, then back in trace window, then continue")
	End if 
	TRACE:C157
	For each ($todelete;$createdmethods)
		$todelete.delete()
	End for each 
End if 

$0:=$continue
