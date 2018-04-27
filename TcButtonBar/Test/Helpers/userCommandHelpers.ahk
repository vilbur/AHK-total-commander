
global $user_command	:= "em_TestTcButtonBar"



/*---------------------------------------
	HELPERS FOR TEST
-----------------------------------------
*/

/** getNewButtonBar
*/
getNewButtonBar()
{
	$commander_path	= %Commander_Path%

	$TcButtonBar 	:= new TcButtonBar()
	$Button 	:= new TcButtonBarButton()
				.cmd( $commander_path "\commands\foo.bat" )
				.icon("%systemroot%\system32\shell32.dll", 43)

	/* ADD COMMAND
	  */
	$TcButtonBar.command( $user_command )
	
	/* ADD BUTTONS
	  */
	$TcButtonBar.button( $Button.tooltip("Last Button") )
	$TcButtonBar.button( $Button.clone().tooltip("First Button") ,1 )		
	
	return $TcButtonBar
}


/**
 */
createTestUserCommand()
{
	
	IniWrite, \foo\file\pah,	%$ini_path%, %$user_command%, cmd
	IniWrite, %systemroot%\system32\shell32.dll`,43,	%$ini_path%, %$user_command%, button
	IniWrite, "foo param",	%$ini_path%, %$user_command%, param
	IniWrite, Tooltip test,	%$ini_path%, %$user_command%, menu	
	
}
/**usercmd_ini
 */
deleteTestUserCommand()
{
	IniDelete, %$ini_path%, %$user_command%
}