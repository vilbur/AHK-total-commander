#SingleInstance force
#Include %A_LineFile%\..\..\..\TcCommandCreator.ahk

/*---------------------------------------
	CREATE COMMANDS WITH SHORTCUT
-----------------------------------------
*/
;new TcCommandCreator()
;		.cmd("TcCommandCreator-shorcut-test")
;		.create()
;		.shortcut("shift", "alt", "A")		
;		.create()		
		
new TcShortcut()
		.name("em_TcCommandCreator-shorcut-test")
		.keys("control", "shift", "alt", "win", "f4", true)