#SingleInstance force

#Include %A_LineFile%\..\..\TcButtonBarButton.ahk

#Include %A_LineFile%\..\..\..\..\TcCommanderPath.ahk
#Include %A_LineFile%\..\..\..\Test\Helpers\userCommandHelpers.ahk

global $usercmd_ini
$usercmd_ini	= %Commander_Path%\usercmd.ini


$CustomCommand 	:= new TcButtonBarButton($usercmd_ini).loadCommand( $user_command )
$Separator 	:= new TcButtonBarButton()
$Button_empty 	:= new TcButtonBarButton().empty()
$Button 	:= new TcButtonBarButton()
			.cmd( "foo.bat" )
			.icon("%systemroot%\system32\shell32.dll", 43)
			.tooltip("Tooltip test")

;Dump($CustomCommand, "loadCustomCommand", 1)			
;Dump($Separator, "Separator", 1)
;Dump($Button, "CreateButtonTest", 1)			
;Dump($Button_empty, "Button_empty", 1)