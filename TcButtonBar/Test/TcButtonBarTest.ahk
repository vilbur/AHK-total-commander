#SingleInstance force

#Include %A_LineFile%\..\..\TcButtonBar.ahk
#Include %A_LineFile%\..\Helpers\userCommandHelpers.ahk
/** LoadCurrentButtonBarTest
*/
LoadCurrentButtonBarTest()
{
	$TcButtonBar 	:= new TcButtonBar().load()
	;Dump($TcButtonBar, "TcButtonBar", 0)
}
/** createButtonBar
*/
createButtonBar()
{
	$TcButtonBar 	:= getNewButtonBar()
	;Dump($TcButtonBar._buttons, "TcButtonBar._buttons", 1)

	/* ADD BUTTONS
	  */
	$TcButtonBar.button( new TcButtonBarButton().tooltip("Button To Delete"), 2 )	
		
	/* REMOVE BUTTONS
	*/
	$TcButtonBar.remove(2)

	/* SAVE
	*/
	$TcButtonBar.save(A_ScriptDir "\TestBar.bar")
	;Dump($TcButtonBar._buttons, "TcButtonBar._buttons", 1)
}

/*---------------------------------------
	 RUN TESTS
-----------------------------------------
*/
;LoadCurrentButtonBarTest()
createButtonBar()
