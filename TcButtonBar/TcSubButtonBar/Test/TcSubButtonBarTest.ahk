#SingleInstance force

#Include %A_LineFile%\..\..\..\TcButtonBar.ahk

#Include %A_LineFile%\..\..\..\Test\Helpers\userCommandHelpers.ahk 


;Dump($TcSubButtonBar, "TcSubButtonBar", 1)

/** TcSubButtonBarTest
*/
TcSubButtonBarTest()
{
	
	$TcSubButtonBar 	:= new TcSubButtonBar()
	$ButtonBar	:= getNewButtonBar().save(A_ScriptDir "\SubButtonBar.bar")
	
	$TcSubButtonBar.subbar($ButtonBar)
	
	Dump($TcSubButtonBar, "TcSubButtonBar", 1)
	
}

/*---------------------------------------
	RUN TESTS
-----------------------------------------
*/
TcSubButtonBarTest()