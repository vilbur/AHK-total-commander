/** Create Sub button bar
 *
 * Set TcButtonBar to TcButtonBarButton
 *
 *
 *    
 */
Class TcSubButtonBar extends TcButtonBarButton
{
	_subbar := ""
	_iconic	:= 0 ; show as: bar = 0 | menu = 1	

	/** Asssign TcButtonBar to button
	 */
	bar( $TcButtonBar )
	{
		this._subbar	:= $TcButtonBar
		
		this.cmd( this._subbar.path() )
		
		this.tryFindIcon()
		
		return this
	}
	
	/** Show subbar as bar
	 */
	asBar( )
	{
		return % this._set( "_iconic",0 )
	}
	/** Show subbar as menu
	 */
	asMenu( )
	{
		return % this._set( "_iconic",1 )
	}
	
	/** Set this._button and this._iconnic
	  *
	  * @param	string	$icon	Path to icon
	  * @param	int	$index	Index of icon
	  *
	  * @return	self
	 */
	tryFindIcon( )
	{
		$icon_path := RegExReplace( this.cmd(), ".bar$", ".ico" )
		
		if( ! this._button )
			if( FileExist( $icon_path ) )
				this.icon($icon_path)
		
		return this
	}
	
	
}