#Include %A_LineFile%\..\includes.ahk

/** TcButtonBar
 *
 */
Class TcButtonBar extends TcCore
{
	_buttonbar_ini	:= $buttonbar_ini
	_buttonbar 	:= {}
	
	/**
	 */
	__New()
	{
		this._init()
		this._setButtonBar()
		this._loadButtonBar()		
		
		;Dump(this, "this.", 1)
		Dump(this._buttonbar, "this._buttonbar", 0)
	}
	
	/**
	 */
	_setButtonBar()
	{
		IniRead, $buttonbar, % this._wincmd_ini, buttonbar, buttonbar
		
		this._setIniFile( RegExReplace( $buttonbar, "%Commander_Path%", "" ), "_buttonbar_ini"  )
		;$buttonbar = %$buttonbar% ; convert environment variables 
		;this._buttonbar_ini := $buttonbar
	} 
	/*---------------------------------------
		PARSE BUTTONBAR.BAR
	-----------------------------------------
	*/
	/**
	 */
	_loadButtonBar()
	{
		IniRead, $lines, % this._buttonbar_ini, buttonbar
			Loop Parse, $lines, `n
			;Dump(A_LoopField, "", 1)
				this._setButton( this._parseLine(A_LoopField)* )
	}
	/**
	 */
	_setButton( $key, $index, $value )
	{
		;Dump($key, "key", 1)
		if( ! $index )
			return 
		
		if( ! this._buttonbar[$index] )
			this._buttonbar[$index] := {}
			
		this._buttonbar[$index][$key] := $value
		
	} 
	/**
	 */
	_parseLine( $line )
	{
		RegExMatch( $line, "^([^\d]+)(\d+)=(.*)", $line_match )

		return [ $line_match1, $line_match2, $line_match3]

	} 
	
	
	
}