#SingleInstance force

#Include %A_LineFile%\..\..\TcButtonBar.ahk
#Include %A_LineFile%\..\..\TcButtonBarButton\Test\UserCommandHelpers.ahk

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
	;createTestUserCommand()
	$TcButtonBar 	:= new TcButtonBar()
	$Button 	:= new TcButtonBarButton()
				.cmd( "foo.bat" )
				.icon("%systemroot%\system32\shell32.dll", 43)

	/* ADD COMMAND
	  */
	$TcButtonBar.command( $user_command )
	
	/* ADD BUTTONS
	  */
	$TcButtonBar.button( $Button.clone().tooltip("Button To Delete") )	
	$TcButtonBar.button( $Button.tooltip("Last Button") )
	$TcButtonBar.button( $Button.clone().tooltip("First Button") ,1 )		
	
	
	/* REMOVE BUTTONS
	*/
	$TcButtonBar.remove(3)

	/* SAEVE
	*/
	$TcButtonBar.save(A_ScriptDir "\TestBar.bar")
				
	;Dump($TcButtonBar._buttons, "TcButtonBar._buttons", 1)
	
}
/** addCustomCommandTest
*/
addCustomCommandTest()
{
	;createTestUserCommand()
	
	$TcButtonBar 	:= new TcButtonBar().load()

	;$TcButtonBar.command( $user_command )
	;Dump($TcButtonBar._buttons, "TcButtonBar._buttons", 0)
	
	$TcButtonBar.save()
	
	;Dump($TcButtonBar._buttons, "TcButtonBar._buttons", 0)		
	;$TcButtonBar.command( $user_command )	
					
					
	;Dump($TcButtonBar._buttons, "TcButtonBar._buttonbar", 0)

	;deleteTestUserCommand()
	
	;Dump($Button, "Button", 1)			
}



/*---------------------------------------
	 RUN TESTS
-----------------------------------------
*/
;LoadCurrentButtonBarTest()
createButtonBar()
;addCustomCommandTest()



