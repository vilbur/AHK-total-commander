
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
	$separator 	:= new TcButtonBarButton().separator()
	$Button_empty 	:= new TcButtonBarButton().empty()
	$Button 	:= new TcButtonBarButton()
				.cmd( $commander_path "\commands\foo.bat" )
				.icon("%systemroot%\system32\shell32.dll", 43)
				
	
	/* ADD BUTTONS
	  */
	$TcButtonBar.command( $user_command )
	$TcButtonBar.button( $separator  )
	$TcButtonBar.button( $Button_empty  )
	$TcButtonBar.button( $Button_empty  )			
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