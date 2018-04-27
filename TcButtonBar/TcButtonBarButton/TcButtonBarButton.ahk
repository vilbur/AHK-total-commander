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
			if( $value && !isObject($value) )
				$cmd_string .= RegExReplace( $key, "^_", "" ) $index "=" this.pathEnv($value) "`n"
		
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
			this._loadProperty($key)
				
		return this
	}
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