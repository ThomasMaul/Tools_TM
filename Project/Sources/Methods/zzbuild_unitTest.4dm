//%attributes = {}
  // run Unit tests
  // to do so, first copy them into the right folder
  // after testing, move them out


/*
C_COLLECTION($unittests;$createdmethods;$existingmethods)
C_OBJECT($unittestfolder;$methodfolder;$unittest;$todelete)

$createdmethods:=New collection()
$unittestfolder:=Folder("/PACKAGE").folder("UnitTests")
$unittests:=$unittestfolder.files()
$methodfolder:=Folder("/PACKAGE").folder("Project").folder("Sources").folder("Methods")
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
ALERT("click ok to open debugger, then click finder or explorer window, then back in trace window, then continue")
TRACE
End if 

$result:=New object
EXECUTE METHOD("AJ_Tools_UT_runAll";$result)
  //$result:=AJ_Tools_UT_runAll 
If ($result.countFail#0)
ALERT("Unit Tests failed")
EXECUTE METHOD("AJ_Tools_UT_LaunchMainWindow")
  //AJ_Tools_UT_LaunchMainWindow 
$continue:=False
Else 
$continue:=True
End if 

If ($createdmethods.length#0)
If ($result.countFail#0)
ALERT("ERROR - click on for debugger, keep it open till you fixed all issues, then click finder or explorer window, then back in trace window, then continue")
Else 
ALERT("click ok to open debugger, then click finder or explorer window, then back in trace window, then continue")
End if 
TRACE
For each ($todelete;$createdmethods)
$todelete.delete()
End for each 
End if 

$0:=$continue
*/