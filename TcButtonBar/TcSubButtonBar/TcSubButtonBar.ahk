/** Create Sub button bar
 *
 * Set buttonbar as button
 *
 */
Class TcSubButtonBar extends TcButtonBarButton
{
	_bar 	:= "" ; subbar
	_iconic	:= 0 ; show as: bar = 0 | menu = 1

	/** Asssign TcButtonBar to button
	  *
	  * @param	buttonbar|string	$buttonbar	TcButtonBar object OR path to *.bar file
	  *
	  *	  	  
	 */
	bar( $buttonbar )
	{
		this._bar	:= isObject($buttonbar) ? $buttonbar : new TcButtonBar().load($buttonbar)
		
		return this
	}
	/** Save buttonbar
	 */
	save( $buttonbar_path:="" )
	{
		this._bar.save( $buttonbar_path )
		
		this._setBarPath( $buttonbar_path )

		return this 
	}
	/** Show subbar as bar
	 */
	asBar()
	{
		return % this.iconic( 0 )
	}
	/** Show subbar as menu
	 */
	asMenu()
	{
		return % this.iconic( 1 )
	}
	/**
	 */
	backButton( $main_buttonbar_path )
	{
		$backbutton := this._bar.button(1)
		
		if( ! RegExMatch( $backbutton.cmd(), "i).bar$" ) )
			this._addBackButton( $main_buttonbar_path )

		return this
	}
	/**
	 */
	_addBackButton( $buttonbar_path )
	{
		this._bar.button( new TcButtonBarButton()
								.cmd($buttonbar_path)
								.icon( "%Commander_Path%\wcmicons.dll,15" )								
								.tooltip( "Back to " this._getButtonBarName( $buttonbar_path )  ), 1)
	} 
	/**
	 */
	_setBarPath( $path:="" )
	{
		if( ! $path )
			return 

		this.cmd( $path )
		this.menu( this._getButtonBarName( $path )  )		
		
		this._tryFindIcon()
	}
	/**
	 */
	_getButtonBarName( $path )
	{
		return % RegExReplace( $path, ".*\\([^\\]+).bar$", "$1" )
	} 
	/** Set this._button and this._iconnic
	  *
	  * @param	string	$icon	Path to icon
	  * @param	int	$index	Index of icon
	  *
	  * @return	self
	 */
	_tryFindIcon( )
	{
		$icon_path := RegExReplace( this.cmd(), ".bar$", ".ico" )
		
		if( ! this._button )
			if( FileExist( $icon_path ) )
				this.icon($icon_path)
		
		return this
	}
	
	
}