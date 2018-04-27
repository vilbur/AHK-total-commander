/** Representation of Button in button bar
 *
 *
 */
Class TcButtonBarButton
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
		if( $cmd_ini )
			this._cmd_ini.path := $cmd_ini

		return this
	}


	/** If button is subbar
	 */
	isSubbar()
	{
		return RegExMatch( this._cmd, "i).bar$") 
	}
	/** If button is separator
	 */
	isSeparator()
	{
		return ! this._cmd && ! this._button &&  ! this._iconic &&  ! this._param
	}
	
	/** Join object to string
	  *
	  * @param	int	$index	index of button
	  * @return	string	Lines ready to be written to *.bar file
	 */
	join($index)
	{
		For $key, $value in this
			if( $value )
				$cmd_string .= RegExReplace( $key, "^_", "" ) $index "=" $value "`n"
		
		;return $cmd_string
		return % SubStr( $cmd_string, 1, StrLen($cmd_string)-1 ) 
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
		return % this._setOrGet( "_iconic", $iconic )
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
		LOAD COMMAND FORM usercmd.ini
	-----------------------------------------
	*/
	/** Load Command as button
	 *  
	 *  @param	string	$command	Command name from "Usercmd.ini" E.G.: "em_custom-command"
	 *
	 * @return	self	
	 */
	loadCommand( $command )
	{
		this.cmd( $command)
		
		For $key, $value in this
			this._loadProperty($key)
		
		;this._setIconFromButton()
		
		return this
	}
	/** Load value from ini
	 */
	_loadProperty($key)
	{
		$ini_value := this._getIniValue( $key )
		
		if( $ini_value && ! this[$key] )
			this[$key] := $ini_value
	}

	/*---------------------------------------
		INI METHODS
	-----------------------------------------
	*/
	/**
	 */
	_getIniValue( $key )
	{
		$key := RegExReplace( $key, "^_", "" ) 
		
		IniRead, $value, % this._cmd_ini.path, % this.cmd(), %$key%
		
		return $value!="ERROR" ? $value : "" 
	} 
	
	
	
	
}