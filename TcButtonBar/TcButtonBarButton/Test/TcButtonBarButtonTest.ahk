#SingleInstance force

#Include %A_LineFile%\..\..\TcButtonBarButton.ahk
#Include %A_LineFile%\..\UserCommandHelpers.ahk

global $usercmd_ini
$usercmd_ini	= %Commander_Path%\usercmd.ini

/** addCustomCommandTest
*/
addCustomCommandTest()
{
	createTestUserCommand()
	
	$Button 	:= new TcButtonBarButton($usercmd_ini)
					.loadCommand( $user_command )
	
	;deleteTestUserCommand()
	
	Dump($Button, "Button", 1)			
}




/*---------------------------------------
	RUN TESTS
-----------------------------------------
*/
addCustomCommandTest()
