#SingleInstance force

#Include %A_LineFile%\..\..\..\TcButtonBar.ahk

#Include %A_LineFile%\..\..\..\Test\Helpers\userCommandHelpers.ahk 


;Dump($TcSubButtonBar, "TcSubButtonBar", 1)

/** TcSubButtonBarTest
*/
TcSubButtonBarTest()
{
	$ButtonBar 	:= getNewButtonBar()
	$SubButtonBar 	:= new TcSubButtonBar()
	$newSubbar	:= getNewButtonBar().save(A_ScriptDir "\SubButtonBar.bar")
	
	$SubButtonBar.bar($newSubbar)
	$ButtonBar.button($SubButtonBar, 2)
	
	
	;Dump($TcSubButtonBar, "TcSubButtonBar", 1)
	Dump($ButtonBar, "ButtonBar", 0)	
	
}

/*---------------------------------------
	RUN TESTS
-----------------------------------------
*/
TcSubButtonBarTest()