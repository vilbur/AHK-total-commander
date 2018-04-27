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
	button( $icon:="" )
	{
		return % this._setOrGet( "_button", $icon )
	}
	/** Set\Get icon number
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
	/** Set\Get property 
	 */
	_setOrGet( $key, $value:="" )
	{		
		if( $value )
			this[$key]	:= $value
		
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
		
		this._setIconFromButton()
		
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
	/** Get iconic property from button property
	 *	  
	 *	@example
	 *		INPUT:
	 *			this._button=C:\Windows\system32\shell32.dll,43
	 *		OUTPUT:
	 *			this._button=C:\Windows\system32\shell32.dll
	 *			this._iconic
	 */
	_setIconFromButton()
	{
		$icon_number_pair	:= StrSplit( this._button, ",")
		
		this._setOrGet( "_button", $icon_number_pair[1] )
		this._setOrGet( "_iconic", $icon_number_pair[2] )		
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