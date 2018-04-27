/* Work with path to Total Commander 
 *  
*/
Class TcCommanderPath
{
	_commander_path	:= ""

	/** SEARCH:
	 *		"%COMMANDER_PATH%"
	 *	REPLACE:
	 *		"C:\TotalCommander"
	 */
	pathFull( $path )
	{
		return % RegExReplace( $path, "i)%COMMANDER_PATH%", this._commander_path  ) 
	}
	/** SEARCH:
	 *		"C:\TotalCommander"
	 *	REPLACE:
	 *		"%COMMANDER_PATH%"
	 */
	pathEnv( $path )
	{
		$commander_path_rx := RegExReplace( this._commander_path, "i)[\\\/]+", "\\" )
		return % RegExReplace( $path, "i)" $commander_path_rx, "%COMMANDER_PATH%" ) 
	}

	/** Set absolute path to Total Commander 
	 */
	_setCommanderPath()
	{
		$commander_path	= %Commander_Path%
		this._commander_path	:= $commander_path
	}
	
	

}