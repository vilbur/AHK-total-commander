/** Activate\deactivate Total Commander window.
 * Used for temporary activation of TC e.g.: for getting focused control
 *
 * ACTIVATE:
 *		Save active window and make it on top, then activate Total Commander window
 *
 * DEACTIVATE:
 *		Restore on top state of last active window and activate it
 *       
 */
Class TcActivate
{
	_ahk_id	:= 0
	_on_top	:= ""

	/** Save active window and activate TC
	 */
	activate($hwnd_tc)
	{
		$hwnd_active := WinActive("A") 
		
		if( this._isTotalCommanderActive( $hwnd_tc, $hwnd_active ) )
			return % this._resetWinData()

		this._saveActiveAhkId( $hwnd_active )
		this._saveActiveOnTopState()		
			
		this._setActiveWindowOnTopState( "On" )
			
		WinActivate, ahk_id %$hwnd_tc% 
	}
	/** Restore always on top state of last window and activate it.
	 */
	deactivate($hwnd_tc)
	{
		if ( ! this._ahk_id )
			return

		WinActivate, % "ahk_id " this._ahk_id

		this._setActiveWindowOnTopState( this._on_top ? "On" : "Off" )
	}
	/**
	 */
	_isTotalCommanderActive( $hwnd_tc, $hwnd_active )
	{
		return % $hwnd_tc==$hwnd_active
	}  
	/**
	 */
	_setActiveWindowOnTopState( $state )
	{
		WinSet, AlwaysOnTop, %$state%, % this._ahkId()
	}
	/**
	 */
	_saveActiveAhkId( $hwnd )
	{
		this._ahk_id := $hwnd
	}
	/**
	 */
	_saveActiveOnTopState()
	{
		this._on_top := this._getAlwaysOnTopState()
		;MsgBox,262144,_on_top, % this._on_top,2  
	}
	/**
	 */
	_getAlwaysOnTopState()
	{
		WinGet, $ExStyle, ExStyle, % this._ahkId()
		return ($ExStyle & 0x8) == 8 ? true : false
	}
	/**
	 */
	_resetWinData()
	{
		this._ahk_id	:= 0
		this._on_top	:= ""
	}  

	/**
	 */
	_ahkId()
	{
		return "ahk_id " this._ahk_id
	}  
	
}
