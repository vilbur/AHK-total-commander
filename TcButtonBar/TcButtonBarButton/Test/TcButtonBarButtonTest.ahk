#SingleInstance force

#Include %A_LineFile%\..\..\TcButtonBarButton.ahk

#Include %A_LineFile%\..\..\..\..\TcCommanderPath.ahk
#Include %A_LineFile%\..\..\..\Test\Helpers\userCommandHelpers.ahk

global $usercmd_ini
$usercmd_ini	= %Commander_Path%\usercmd.ini

/** loadCustomCommand
*/
loadCustomCommand()
{	
	$Button 	:= new TcButtonBarButton($usercmd_ini)
					.loadCommand( $user_command )

	Dump($Button, "loadCustomCommand", 1)			
}

/** makeSeparator
*/
makeSeparator()
{	
	$separator 	:= new TcButtonBarButton().separator()

	Dump($separator, "separator", 1)			
}
/** makeEmptyButton
*/
makeEmptyButton()
{	
	$Button_empty 	:= new TcButtonBarButton().empty()

	Dump($Button_empty, "Button_empty", 1)			
}
/** CreateButtonTest
*/
CreateButtonTest()
{	
	$Button 	:= new TcButtonBarButton()
				.cmd( "foo.bat" )
				.icon("%systemroot%\system32\shell32.dll", 43)
				.tooltip("Tooltip test")

	Dump($Button, "CreateButtonTest", 1)			
}


/*---------------------------------------
	RUN TESTS
-----------------------------------------
*/
loadCustomCommand()
makeSeparator()
makeEmptyButton()
CreateButtonTest()
