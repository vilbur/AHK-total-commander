#SingleInstance force

#Include %A_LineFile%\..\..\TcButtonBar.ahk
#Include %A_LineFile%\..\..\TcButtonBarButton\Test\UserCommandHelpers.ahk

/** LoadCurrentButtonBarTest
*/
LoadCurrentButtonBarTest()
{
	$TcButtonBar 	:= new TcButtonBar().load()
	Dump($TcButtonBar, "TcButtonBar", 0)
}
/** addCustomCommandTest
*/
addCustomCommandTest()
{
	;createTestUserCommand()
	
	$TcButtonBar 	:= new TcButtonBar()
			.load()
				.addCommand( $user_command )
					
					
	Dump($TcButtonBar, "TcButtonBar", 0)

	;deleteTestUserCommand()
	
	;Dump($Button, "Button", 1)			
}



/*---------------------------------------
	 RUN TESTS
-----------------------------------------
*/
;LoadCurrentButtonBarTest()
addCustomCommandTest()()



