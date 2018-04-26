#Include %A_LineFile%\..\includes.ahk

#Include %A_LineFile%\..\TcButtonBarButton\TcButtonBarButton.ahk

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
		
		;Dump(this, "this.", 1)
		;Dump(this._buttonbar, "this._buttonbar", 0)
	}
	
	/** Load buttonbar file
	  *
	  * @param	string	$buttonbar_path	If empty, current *.bar is used
	  *
	  * @return	self
	 */
	load( $buttonbar_path:="" )
	{
		if( ! $buttonbar_path )
			IniRead, $buttonbar_path, % this._wincmd_ini, buttonbar, buttonbar
		
		this._setButtonBar( $buttonbar_path )
		
		this._parseButtonBar()
		
		return this  
	} 
	/**
	 */
	addCommand( $command, $position:="" )
	{
		if( InStr( $command, "em_" ) )
			$Button 	:= new TcButtonBarButton( this.getIniFile( "Usercmd.ini" ) ) 
					.loadCommand( $user_command )
		
		Dump($Button, "Button", 1)
		
		return this
	}

	
	
	
	
	/**
	 */
	_setButtonBar( $buttonbar )
	{
		
		this._setIniFile( RegExReplace( $buttonbar, "%Commander_Path%", "" ), "_buttonbar_ini"  )
	} 
	/*---------------------------------------
		PARSE BUTTONBAR.BAR
	-----------------------------------------
	*/
	/**
	 */
	_parseButtonBar()
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