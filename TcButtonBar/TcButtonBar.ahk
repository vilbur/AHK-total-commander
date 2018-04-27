#Include %A_LineFile%\..\includes.ahk

#Include %A_LineFile%\..\TcButtonBarButton\TcButtonBarButton.ahk

/** TcButtonBar
 *
 */
Class TcButtonBar extends TcCore
{
	_buttonbar_ini	:= $buttonbar_ini
	_buttons 	:= {}
	
	/**
	 */
	__New()
	{
		this._init()
		;Dump(this, "this.", 1)
		;Dump(this._buttons, "this._buttons", 0)
	}
	
	/** Load button bar file
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
	/** Save buttonbar
	 */
	save( $buttonbar_path:="" )
	{
		;MsgBox,262144,buttonbar_path, %$buttonbar_path%,3 
		For $index, $Button in this._buttons
			$all_buttons .= $Button.join($index) "`n"
		
		$buttonbar_content := "[Buttonbar]`nButtoncount=" this._buttons.length() "`n" $all_buttons
		;Dump($buttonbar, "buttonbar", 1)
		if( ! $buttonbar_path && ! this._buttonbar_ini )
			this.exit("TcButtonBar.save()`n`nPath is not defined")
		
		if( ! $buttonbar_path )
			$buttonbar_path := this._buttonbar_ini
		
		FileDelete, %$buttonbar_path% 
		FileAppend, %$buttonbar_content%, %$buttonbar_path%
		
	}
	/** Add command from usercmd.ini
	  *
	  * @param	string	$command	Command name E.g.:  "em_custom-command"
	  * @param	int	$position	Position of button, add as last if not defined
	  *
	  * @return	self
	 */
	command( $command, $position:="" )
	{
		if( InStr( $command, "em_" ) )
			$Button 	:= new TcButtonBarButton( this.getIniFile( "Usercmd.ini" ) ) 
							.loadCommand( $user_command )
		
		this._buttons.insertAt( this._getPostion($position), $button )

		return this
	}
	/** Add button object to _buttons
	  *
	  * @param	TcButtonBarButton	$Button	Button to be added
	  * @param	int	$position	Position of button, add as last if not defined
	  *	  
	  * @return	self
	 */
	button( $Button, $position:="" )
	{
		this._buttons.insertAt( this._getPostion($position), $Button )
	}
	/** Remove button at position
	  * @param	int	$position	Position of button
	 */
	remove( $position )
	{
		this._buttons.removeAt($position)
	}
	
	/** Get index of button
	  *
	  * @param	int	$position	Index of button
	  *	  
	  * @return	int	position of button, if $position is not defined, then return new last position
	 */
	_getPostion( $position )
	{
		return % $position ? $position : this._buttons.length() +1
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
	_setButton( $key, $position, $value )
	{
		;Dump($key, "key", 1)
		if( ! $position )
			return 
		
		if( ! this._buttons[$position] )
			this._buttons[$position] := new TcButtonBarButton()
			
		this._buttons[$position].set( $key, $value )
	} 
	/**
	 */
	_parseLine( $line )
	{
		RegExMatch( $line, "^([^\d]+)(\d+)=(.*)", $line_match )

		return [ $line_match1, $line_match2, $line_match3]
	} 
	

	/*---------------------------------------
		HELPERS
	-----------------------------------------
	*/
	/** Exit script with message
	 */
	exit( $message  )
	{
		MsgBox,262144, TcButtonBar, %$message%
		ExitApp
	} 
	
	
}