GGS.ESC = GGS.ESC || {};

hook.Add( "PreRender", "GGS.ToggleESC", function()
	if input.IsKeyDown( KEY_ESCAPE ) and gui.IsGameUIVisible() then
		GGS.ToggleESC();
		gui.HideGameUI();
	end;
end );

GGS.ToggleESC = function()
	if GGS.ESC.Background and GGS.ESC.Background:IsValid() then
		GGS.ESC.Background:Remove();
		return;
	end;
	
	-- Blur background
	GGS.ESC.Background = vgui.Create( "GGS.BlurBackground" );
	-- GGS.ESC.Background:SetIntensity( 2 );
	GGS.ESC.Background:ShowCloseButton( false );
	GGS.ESC.Background:MakePopup();
	GGS.ESC.Background:SetKeyboardInputEnabled();
	
	local _logo = Material( "ggs/logo.png" );
	local _logo_w, _logo_h = ScrW()*0.2, ScrW()*0.2;
	local _logo_x, _logo_y = ScrW() / 2 - _logo_w / 2, ScrH()*0.12;
	
	local _logo_container = vgui.Create( "GGS.Container", GGS.ESC.Background );
	_logo_container:SetSize( _logo_w, _logo_h );
	_logo_container:SetPos( _logo_x, _logo_y );
	_logo_container.Paint = function( self, _w, _h )
		surface.SetDrawColor( 255, 255, 255, 255 );
		surface.SetMaterial( _logo );
		surface.DrawTexturedRect( 0, 0, _w, _h );
	end;
	
	local _button_w, _button_h = _logo_w, _logo_h * 0.12;
	local _button_x, _button_y = ScrW() / 2 - _button_w / 2, _logo_y + _logo_h * 1.18;
	local _button_y_offset = _button_h * 0.2;
	
	local _extended_paint = function( self, _w, _h )
		-- Hover highlight
		if self:IsHovered() then
			draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.Highlight );
		end;
	end;
	
	local _i = 0;
	
	local _button = vgui.Create( "GGS.Button", GGS.ESC.Background );
	_button:SetSize( _button_w, _button_h );
	_button:SetPos( _button_x, _button_y + _i * ( _button_h + _button_y_offset ) );
	_button:SetText( "RESUME" );
	_button:SetTextSize( 26 );
	_button.DoClick = function()
		GGS.ESC.Background:Remove();
	end;
	_button.ExtendedPaint = _extended_paint;
	_i = _i + 1;
	
	local _button = vgui.Create( "GGS.Button", GGS.ESC.Background );
	_button:SetSize( _button_w, _button_h );
	_button:SetPos( _button_x, _button_y + _i * ( _button_h + _button_y_offset ) );
	_button:SetText( "FORUMS" );
	_button:SetTextSize( 26 );
	_button.DoClick = function()
		gui.OpenURL( "http://www.goldengrizzlyservers.co.uk" );
	end;
	_button.ExtendedPaint = _extended_paint;
	_i = _i + 1;
	
	local _button = vgui.Create( "GGS.Button", GGS.ESC.Background );
	_button:SetSize( _button_w, _button_h );
	_button:SetPos( _button_x, _button_y + _i * ( _button_h + _button_y_offset ) );
	_button:SetText( "DONATE" );
	_button:SetTextSize( 26 );
	_button.DoClick = function()
		gui.OpenURL( "http://www.goldengrizzlyservers.co.uk/donate" );
	end;
	_button.ExtendedPaint = _extended_paint;
	_i = _i + 1;
	
	local _button = vgui.Create( "GGS.Button", GGS.ESC.Background );
	_button:SetSize( _button_w, _button_h );
	_button:SetPos( _button_x, _button_y + _i * ( _button_h + _button_y_offset ) );
	_button:SetText( "OPTIONS" );
	_button:SetTextSize( 26 );
	_button.DoClick = function()
		RunConsoleCommand( "gamemenucommand", "OpenOptionsDialog" );
		gui.ActivateGameUI();
	end;
	_button.ExtendedPaint = _extended_paint;
	_i = _i + 1;
	
	local _button = vgui.Create( "GGS.Button", GGS.ESC.Background );
	_button:SetSize( _button_w, _button_h );
	_button:SetPos( _button_x, _button_y + _i * ( _button_h + _button_y_offset ) + _logo_h * 0.1 );
	_button:SetText( "DISCONNECT" );
	_button:SetTextSize( 26 );
	_button.DoClick = function()
		RunConsoleCommand( "disconnect" );
	end;
	_button.ExtendedPaint = _extended_paint;
	_i = _i + 1;
	
	local _button = vgui.Create( "GGS.Button", GGS.ESC.Background );
	_button:SetSize( _button_w, _button_h );
	_button:SetPos( _button_x, _button_y + _i * ( _button_h + _button_y_offset ) + _logo_h * 0.1 );
	_button:SetText( "QUIT GAME" );
	_button:SetTextSize( 26 );
	_button.DoClick = function()
		RunConsoleCommand( "gamemenucommand", "Quit" );
	end;
	_button.ExtendedPaint = _extended_paint;
	_i = _i + 1;
end;


