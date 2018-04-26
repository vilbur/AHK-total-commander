/** Representation of Button in button bar
 *
 *
 */
Class TcButtonBarButton
{
	static _cmd_ini := {path:""} ; path to *.ini with command, ussually Usercmd.ini

	cmd	:= ""
	param	:= ""	
	button	:= "" ; icon
	iconic	:= "" ; icon number
	menu	:= "" ; tooltip
	
	/**
	 */
	__New( $cmd_ini:="" )
	{
		if( $cmd_ini )
			this._cmd_ini.path := $cmd_ini

		return this
	}
		
		
	/**
	 */
	loadCommand( $command )
	{
		this.cmd	:= $command

		For $k, $key in ["param", "button", "menu"]
			this["_load" $key]()
		
		;Dump(this, "this.", 1)
		return this
	}
	
	/** Load value from ini
	 */
	_loadParam()
	{
		this.param := this._getIniValue( "param" )
	}
	/** Set icon and icon nuumber
	 */
	_loadButton()
	{
		$value := this._getIniValue( "button" )
		if( ! $value )
			return
		
		$icon_number_pair	:= StrSplit( $value, ",")
		
		this.button := $icon_number_pair[1]
		this.iconic := $icon_number_pair[2]		
	}
	
	/** Load value from ini
	 */
	_loadMenu()
	{
		this.menu := this._getIniValue( "menu" )
	}
	
	/**
	 */
	_getIniValue( $key )
	{
		IniRead, $value, % this._cmd_ini.path, % this.cmd, %$key%
		
		return $value!="ERROR" ? $value : "" 
	} 
	
	
	
	
}