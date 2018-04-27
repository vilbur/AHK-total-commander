#Include %A_LineFile%\..\includes.ahk

#Include %A_LineFile%\..\TcButtonBarButton\TcButtonBarButton.ahk
#Include %A_LineFile%\..\TcSubButtonBar\TcSubButtonBar.ahk
/** TcButtonBar
 *
 */
Class TcButtonBar extends TcCore
{
	_path	:= ""
	_buttons 	:= {}
	
	/**
	 */
	__New()
	{
		this._init()
	}
	/** Load button bar file
	  *
	  * @param	string	$buttonbar_path	If empty, current *.bar is used
	  *
	  * @return	self
	 */
	load( $buttonbar_path:="")
	{		
		if( ! $buttonbar_path )
			IniRead, $buttonbar_path, % this._wincmd_ini, buttonbar, buttonbar
			
		this.path( $buttonbar_path )
		
		this._parseButtonBar()
		
		return this  
	}
	/** Save buttonbar
	 */
	save( $buttonbar_path:="" )
	{
		this.path( $buttonbar_path )

		For $index, $Button in this._buttons
			$all_buttons .= $Button.join($index) "`n"
		
		$buttonbar_content := "[Buttonbar]`nButtoncount=" this._buttons.length() "`n" $all_buttons
		;Dump($buttonbar, "buttonbar", 1)
		if( ! this._path )
			this.exit("TcButtonBar.save()`n`nPath is not defined")
		
		FileDelete, % this._path
		FileAppend, %$buttonbar_content%, % this._path
		
		return this 
	}
	/**
	 */
	path( $buttonbar_path:="" )
	{
		if( $buttonbar_path )
			this._path := this.pathFull($buttonbar_path)
		;Dump(this._path, "this._path", 1)
		return $buttonbar_path ? this : this._path
	}
	/*---------------------------------------
		BUTTON METHODS
	-----------------------------------------
	*/
	/** Add command from usercmd.ini
	  *
	  * @param	string	$command	Command name E.g.:  "em_custom-command"
	  * @param	int	$position	Position of button, add as last if not defined
	  *
	  * @return	self
	 */
	command( $command, $position:="" )
	{
		;Dump($command, "command", 1)
		if( InStr( $command, "em_" ) )
			$Button 	:= new TcButtonBarButton( this.getIniFile( "Usercmd.ini" ) ) 
							.loadCommand( $user_command )
		;Dump($Button, "Button", 1)
		this._buttons.insertAt( this._getPostion($position), $button )

		return this
	}
	/** Get\Set button object to _buttons
	  *
	  * @param	TcButtonBarButton|int	$Button	Button to be added, or button position to get
	  * @param	int	$position	Position of button, add as last if not defined
	  *
	  * @example button( $Button, 5 ) 	Add button at 5th position 
	  * @example button( 5 )	Get button at 5th position 
	  *
	  * @return	self
	 */
	button( $Button, $position:="" )
	{
		if $Button is number 
			return this._buttons[$Button]
		
		this._buttons.insertAt( this._getPostion($position), $Button )
		
		return this
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
	/*---------------------------------------
		PARSE BUTTONBAR.BAR
	-----------------------------------------
	*/
	/**
	 */
	_parseButtonBar()
	{
		IniRead, $lines, % this._path, buttonbar
			Loop Parse, $lines, `n
				if( RegExMatch( A_LoopField, "i)cmd\d+" )  )
					this._addItem( A_LoopField )
	}
	/**
	 */
	_addItem( $line )
	{
		RegExMatch( $line, "^[^\d]+(\d+)=(.*)", $line_match )
		
		$type	:= RegExMatch( $line, "i)\.bar$" ) ? "SubBar" : "Button"
		$position	:= $line_match1
		$value	:= $line_match2
		$Item	:= $type=="Button" ? new TcButtonBarButton(this._path) : new TcSubButtonBar(this._path)
		$Item	:= $Item.loadButton($position)
		
		
		if( $type=="SubBar" && this._notReferenceToMainBar( $path ) )
			$Item.bar($position)
		
		this._buttons[$position] := $Item
	}
	
	/** Avoids endless loop on button pointing back to main bar
	 */
	_notReferenceToMainBar( $path )
	{
		return % $path!=this._path
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