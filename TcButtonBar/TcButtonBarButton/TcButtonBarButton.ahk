/** Representation of Button in button bar
 *
 *
 */
Class TcButtonBarButton extends TcCommanderPath
{
	static _cmd_ini := {path:""} ; path to *.ini with command, ussually Usercmd.ini
	
	_cmd	:= ""
	_param	:= ""	
	_button	:= "" ; icon
	_iconic	:= "" ; icon number
	_menu	:= "" ; tooltip

	/**
	 */
	__New( $cmd_ini:="" )
	{
		this._setCommanderPath()
		
		if( $cmd_ini )
			this._cmd_ini.path := $cmd_ini

		return this
	}
	/** Load Command as button from Usercmd.ini
	 *  
	 *  @param	string	$command	Command name from "Usercmd.ini" E.G.: "em_custom-command"
	 *
	 * @return	self	
	 */
	loadCommand( $command )
	{
		this.cmd( $command)
		
		For $key, $value in this
			this._loadCommandProperty($key)
				
		return this
	}
	/** Load Command as button from Usercmd.ini
	 *  
	 *  @param	string	$command	Command name from "Usercmd.ini" E.G.: "em_custom-command"
	 *
	 * @return	self	
	 */
	loadButton( $position )
	{		
		For $key, $value in this
			this._loadButtonProperty($key, $position)
				
		return this
	}
	/** Make button separator
	 */
	separator()
	{
		;this.button("separator")
		this.iconic(0)
		return this 
	}
	/** Make empty button
	 */
	empty()
	{
		this.cmd( "cmd.exe /c exit" )	; do nothing command
		this.icon("%systemroot%\system32\shell32.dll,49") 	; empty icon
		this.iconic(0)	; run minimized
		this.tooltip("-")
		
		return this 
	}
	
	/** Join object to string
	  *
	  * @param	int	$position	position of button
	  * @return	string	Lines ready to be written to *.bar file
	 */
	join($position)
	{
		if( this._isSeparator() )
			return "iconic" $position "=0"
	
		For $key, $value in this
			if( (!isObject($value) && $value ) || this._isIconicNumber($key)  )
				$cmd_string .= RegExReplace( $key, "^_", "" ) $position "=" this.pathEnv($value) "`n"
		
		return % SubStr( $cmd_string, 1, StrLen($cmd_string)-1 ) 
	}
	/**
	 */
	_isSeparator()
	{
		For $key, $value in this
			if( $value )
				return
				
		return true
	} 
	/**
	 */
	_isIconicNumber($key)
	{
		
		$iconnic := this._iconic
		
		if( $key=="_iconic" )
			if $iconnic is number
				return true
		
		;return % $key == "iconic" && this._iconic==0
	} 
	/*---------------------------------------
		SET\GET BUTTNO PROPERTY
	-----------------------------------------
	*/

	/**
	 */
	cmd( $cmd:="" )
	{
		return % this._setOrGet( "_cmd", $cmd )
	}
	/**
	 */
	param( $param:="" )
	{
		return % this._setOrGet( "_param", $param )
	} 
	/** Set\Get icon
	 */
	button( $icon:="", $index:="" )
	{
		this.set( "_button", $icon ($index?"," $index : "") )

		return $value ? this : this[$key]
		
	}
	/** Options of button
	 */
	iconic( $iconic:="" )
	{
		if $iconic is number
			this._iconic := $iconic
		else
			return this._iconic

		return this
	}
	/** Set\Get tooltip
	 */
	menu( $tooltip:="" )
	{
		return % this._setOrGet( "_menu", $tooltip )
	}
	/*---------------------------------------
		ALIASES
	-----------------------------------------
	*/
	/** Set this._button and this._iconnic
	  *
	  * @param	string	$icon	Path to icon
	  * @param	int	$index	Index of icon
	  *
	  * @return	self
	 */
	icon( $icon, $index:="" )
	{
		this.button( $icon, $index )
		
		return this
	}
	/** Alias for this.menu()
	 */
	tooltip( $tooltip )
	{
		this.menu($tooltip)
		
		return this
	}
	
	/*---------------------------------------
		SET PROPERTIES
	-----------------------------------------
	*/
	
	/** Set\Get property
	  *
	  * @param	string	$key	Key of property
	  * @param	string	$value	Value of property 
	  *
	 */
	set( $key, $value:="" )
	{
		$key := RegExReplace( $key, "^_*", "_" ) 

		if( $value )
			this[$key]	:= $value
		
		return  this
	} 	
	/** Set\Get property 
	 */
	_setOrGet( $key, $value:="" )
	{
		this.set( $key, $value )

		return $value ? this : this[$key]
	} 	

	/*---------------------------------------
		LOAD COMMAND FROM usercmd.ini
	-----------------------------------------
	*/

	/** Load value from ini
	 */
	_loadCommandProperty($key)
	{
		$ini_value := this._getIniValue( this.cmd(), $key )
		
		if( $ini_value && ! this[$key] )
			this[$key] := $ini_value
	}
	/*---------------------------------------
		LOAD COMMAND FROM *.bar FILE
	-----------------------------------------
	*/

	/** Load value from ini
	 */
	_loadButtonProperty($key, $position)
	{
		$ini_value := this._getIniValue( "Buttonbar", $key $position )
		
		if( $ini_value && ! this[$key] )
			this[$key] := $ini_value
	}
	
	/*---------------------------------------
		INI METHODS
	-----------------------------------------
	*/
	/**
	 */
	_getIniValue( $section, $key )
	{
		$key := RegExReplace( $key, "^_", "" ) 

		IniRead, $value, % this._cmd_ini.path, %$section%, %$key%
		
		return $value!="ERROR" ? $value : "" 
	} 
	
}