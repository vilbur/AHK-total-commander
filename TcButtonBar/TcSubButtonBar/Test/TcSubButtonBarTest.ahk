#SingleInstance force

#Include %A_LineFile%\..\..\..\TcButtonBar.ahk

#Include %A_LineFile%\..\..\..\Test\Helpers\userCommandHelpers.ahk 


global  $buttonbar_path	:=  A_ScriptDir "\ButtonBarTest.bar"
global  $sub_buttonbar_path	:=  A_ScriptDir "\SubButtonBarTest.bar"

/** createButtonBarWithSubBar
*/
createButtonBarWithSubBar()
{
	$ButtonBar 	:= getNewButtonBar()
	$SubButtonBar 	:= new TcSubButtonBar()
				.bar(getNewButtonBar())
				.asMenu()
				.backButton($buttonbar_path)
				.save($sub_buttonbar_path)
				
	$ButtonBar.button($SubButtonBar, 1)

	$ButtonBar.save($buttonbar_path)
}
/**
 */
loadSubbarFromString()
{
	$TcSubButtonBar 	:= new TcSubButtonBar().bar($sub_buttonbar_path)
	;Dump($TcSubButtonBar, "TcSubButtonBar", 0)
}

/**
 */
loadSubbars()
{
	$TcButtonBar 	:= new TcButtonBar().load($buttonbar_path)
	;Dump($TcButtonBar, "TcButtonBar", 0)
}
/*---------------------------------------
	RUN TESTS
-----------------------------------------
*/
createButtonBarWithSubBar()
loadSubbarFromString()
loadSubbars()
