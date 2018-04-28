#Include %A_LineFile%\..\includes.ahk
/** Class TcShortcut
*/
Class TcShortcut extends TcCommanderPath
{
	_name	:= "" ; name of command
	_section	:= "Shortcuts"
	_keys	:= []
	_force	:= false
	
	/**
	  * @param	string	$name Name of command
	  */
	__New($name:="")
	{
		this._setCommanderPath()
		this._setIniFile("usercmd.ini")
		this._setIniFile("wincmd.ini")		
		
		if( $name )
			this.name($name)
	}
	/**
	 */
	name( $name )
	{
		this._name := $name
		return this 		
	}
	/** Set control keys
	 * @param	string	$keys	Key for shortcut
	 */
	keys( $keys* )
	{
		For $k, $key in $keys
			if( RegExMatch( $key, "i)win" ) )
				this._section := "ShortcutsWin"
				
			else if $key is number
				this._force := $key
				
			else
				this._keys.push($key)

		;this._setKeys($keys*)

		this.create()
		
		return this
	}
	/** create keyboard shortcut to run this._cmd_load_tabs command
		create keyboard shortcut in section "ShortcutsWin"
		section "ShortcutsWin" runs keyboard shortcuts with win key 
	 */
	create()
	{
		$shortcut := this._getShortcut()

		if( this._ifCommandExists() && (  this._force || this._ifShortcutDoesNotExists($shortcut) ) )
			IniWrite, % this._name, % this._wincmd_ini, % this._section, %$shortcut%
	}
	
	/** Delete shorcut
		Find command name in section and delete it
	 */
	delete()
	{
		For $s, $section in ["Shortcuts","ShortcutsWin"]
			IniRead, $sections, % this._usercmd_ini, %$section%
				loop, Parse, $sections, `n
					if( RegExMatch( A_LoopField, "i)^([^\=]+)\=" this._name, $key_match ) )
						IniDelete,  % this._usercmd_ini, %$section%, %$key_match1% 
	}

	/**
	 */
	_ifCommandExists()
	{
		IniRead, $exist_cmd,	% this._usercmd_ini,	% this._name
		
		if( ! $exist_cmd )
			this.exit("COMMAND DOES NOT EXISTS:`n`n" this._name )
		
		return $exist_cmd ? true :false
	}
	/**
	 */
	_ifShortcutDoesNotExists($shortcut)
	{
		IniRead, $exist_shortcut,	% this._wincmd_ini,	% this._section, %$shortcut%, 0
		
		;MsgBox,262144,exist_shortcut, %$exist_shortcut%,3 
		if( $exist_shortcut )
			MsgBox,262144,, % "SHORTCUT ALREADY EXISTS`n`n" this._joinKeys()
		
		return % ! $exist_shortcut
	}
	
	/**
	 */
	_getShortcut()
	{
		For $i, $key in this._keys
			if( ! InStr( $key, "win" ) )
				$keys .= RegExMatch( $key, "i)(ctr|control|alt|shift)" ) ? SubStr($key, 1, 1) : "+" $key
		
		return %$keys% 
	}
	/**
	 */
	_joinKeys()
	{
		For $i, $key in this._keys
			$keys .=  $key "+"
		
		$keys := SubStr( $keys, 1, StrLen($keys)-1 ) 
		
		return $keys 
	}
	/** Exit script with message
	 */
	exit( $message  )
	{
		MsgBox,262144, TcShortcut, %$message%
		return
	}
	
}

