#Include %A_LineFile%\..\..\TcCommanderPath\TcCommanderPath.ahk

/* Class TcCore
*/
Class TcCore extends TcCommanderPath
{
	_wincmd_ini	:= ""	
	_process_name	:= ""	
	_hwnd	:= ""

	/** Init core
	  9 must be called in __New() mehthod in class which extends TcCore
	 */
	initCore()
	{
		this._setCommanderPath()
		this._setIniFile( "wincmd.ini" )
		this._setProcessName()
		this._setHwnd()
	}
	/**
	 */
	ahkId()
	{
		return % "ahk_id " this._hwnd
	}
	/**
	 */
	proccesName()
	{
		return % this._process_name
	}
	/**
	 */
	_setProcessName()
	{
		WinGet, $process_name , ProcessName, ahk_class TTOTAL_CMD
		this._process_name := $process_name
	}
	/**
	 */
	_setHwnd()
	{
		WinGet, $hwnd , ID, ahk_class TTOTAL_CMD
		this._hwnd := $hwnd
	}

	/*---------------------------------------
		INI FILE
	-----------------------------------------
	*/
	/** Set ini file as property
	 *  
	 * @param	string	$ini_file	Relative path to file in Total Commander 
	 * @param	string	$key	Key to save to this object, if empty then sanitized ini file name is used E.G.: "wincmd.ini" WILL BE this._wincmd_ini
	 *
	 */
	_setIniFile( $ini_file, $key:="" )
	{
		
		if( ! $key )
		{
			SplitPath, $ini_file, $filename
			$key := "_" RegExReplace( $filename, "\.", "_" )
		}
		
		this[$key] := this.getIniFile( $ini_file )
	}
	/**
	 */
	getIniFile( $ini_file )
	{
		$ini_file_path	= %Commander_Path%\%$ini_file%

		return $ini_file_path	
	} 
	/*---------------------------------------
		COMMANDS
	-----------------------------------------
	*/
	/** Command: ConfigSAveSettings
	 */
	saveConfig()
	{
		SendMessage  1075, 580, 0, , % this.ahkId()
		return this
	}
	/** Command: RereadSource
	 */
	refresh()
	{
		SendMessage  1075, 540, 0, , % this.ahkId()
		return this
	}
	
	
	

}