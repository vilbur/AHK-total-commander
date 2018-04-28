#SingleInstance force

#Include %A_LineFile%\..\..\TcButtonBarButton.ahk

#Include %A_LineFile%\..\..\..\..\TcCommanderPath\TcCommanderPath.ahk
#Include %A_LineFile%\..\..\..\Test\Helpers\userCommandHelpers.ahk

global $usercmd_ini
$usercmd_ini	= %Commander_Path%\usercmd.ini

$Separator 	:= new TcButtonBarButton()
$Button_empty 	:= new TcButtonBarButton().empty()
$CustomCommand 	:= new TcButtonBarButton($usercmd_ini).loadCommand( $user_command )
$Button 	:= new TcButtonBarButton()
				.cmd( "foo.bat" )
				.icon("%systemroot%\system32\shell32.dll", 43)
				.tooltip("Tooltip test")

;Dump($Separator, "Separator", 1)
;Dump($Button, "CreateButtonTest", 1)			
;Dump($CustomCommand, "loadCustomCommand", 1)			
;Dump($Button_empty, "Button_empty", 1)