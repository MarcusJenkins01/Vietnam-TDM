--[[---------
  draw.Blur
---------]]--

-- Fetch and assign the blur material to a variable
local _blur = Material( "pp/blurscreen" );

-- The procedure to draw the blur material for a panel
draw.BlurPanel = function( _panel, _amount, _alpha )
	local _x, _y = _panel:LocalToScreen( 0, 0 );
	local _w, _h = ScrW(), ScrH();
	
	surface.SetDrawColor( 255, 255, 255, _alpha or 255 );
	surface.SetMaterial( _blur );
	
	for i = 1, 5 do
		-- Apply the variable density
		_blur:SetFloat( "$blur", ( i / 3 ) * ( _amount || 5 ) );
		_blur:Recompute();
		render.UpdateScreenEffectTexture();

		-- Draw the blur material
		surface.DrawTexturedRect( -_x, -_y, _w, _h );
	end;
end;

-- A general blur
draw.Blur = function( _x, _y, _w, _h, _layers, _density, _alpha )
	surface.SetDrawColor( 255, 255, 255, _alpha );
	surface.SetMaterial( _blur );

	for _i = 1, _layers do
		_blur:SetFloat( "$blur", ( _i / _layers ) * _density );
		_blur:Recompute();

		render.UpdateScreenEffectTexture();
		render.SetScissorRect( _x, _y, _x + _w, _y + _h, true );
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() );
		render.SetScissorRect( 0, 0, 0, 0, false );
	end;
end;


--[[-------------
  draw.Gradient
-------------]]--

-- Fetch and assign the gradient material to a variable
local _gradient_up = Material( "vgui/gradient_up" );
local _gradient_down = Material( "vgui/gradient_down" );
local _gradient_center = Material( "gui/center_gradient" );
local _gradient_left = Material( "vgui/gradient-r" );
local _gradient_right = Material( "vgui/gradient-l" );

-- The procedure to draw the gradient material on the panel
draw.Gradient = function( _x, _y, _w, _h, _color, _type )
	local _gradient = _gradient_center;
	
	if ( _type && _type == 'u' ) then
		_gradient = _gradient_up;
	elseif ( _type && _type == 'd' ) then
		_gradient = _gradient_down;
	elseif ( _type && _type == 'l' ) then
		_gradient = _gradient_left;
	elseif ( _type && _type == 'r' ) then
		_gradient = _gradient_right;
	end;
	
	surface.SetDrawColor( _color );
	surface.SetMaterial( _gradient );
	surface.DrawTexturedRect( _x, _y, _w, _h );
end;


--[[-----------------
  draw.FunkyOutline
-----------------]]--

draw.FunkyOutline = function( _offset_x, _offset_y, _w, _h, _color )
	local _length = _h*0.3;
	local _width = 3;
	
	draw.RoundedBox( 0, _offset_x, _offset_y, _length, _width, _color );
	draw.RoundedBox( 0, _offset_x, _offset_y, _width, _length, _color );
	
	draw.RoundedBox( 0, _w-_offset_x-_length, _h-_offset_y-_width, _length, _width, _color );
	draw.RoundedBox( 0, _w-_offset_x-_width, _h-_offset_y-_length, _width, _length, _color );
end;