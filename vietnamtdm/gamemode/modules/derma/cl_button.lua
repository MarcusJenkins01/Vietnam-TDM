--[[----------
  GGS.Button
----------]]--

local BUTTON = {};

BUTTON.Init = function( self )
	self:SetTextColor( GGS.Config.Derma.Colour.TextColor );
	self:SetTextSize( 21 );
	
	self.ExtendedPaint = function() end;
end;

BUTTON.SetTextSize = function( self, _size )
	self:SetFont( GGS.GetFont( _size ) );
end;

BUTTON.Paint = function( self, _w, _h )
	-- Background
	draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.PanelBackground );
	
	-- Outline
	surface.SetDrawColor( GGS.Config.Derma.Colour.Outline );
	
	local _outline_size = 1;
	
	surface.DrawOutlinedRect( GGS.Config.Derma.Sizing.OutlineGap, GGS.Config.Derma.Sizing.OutlineGap, _w - ( GGS.Config.Derma.Sizing.OutlineGap * 2 ), _h - ( GGS.Config.Derma.Sizing.OutlineGap * 2 ), _outline_size );
	
	self.ExtendedPaint( self, _w, _h );
end;

vgui.Register( "GGS.Button", BUTTON, "DButton" );

--[[-------------------
  GGS.ButtonSecondary
-------------------]]--

local BUTTON = {};

BUTTON.Init = function( self )
	self:SetTextColor( GGS.Config.Derma.Colour.TextColorSecondary );
	self:SetTextSize( 21 );
	
	self.ExtendedPaint = function() end;
end;

BUTTON.SetTextSize = function( self, _size )
	self:SetFont( GGS.GetFont( _size ) );
end;

BUTTON.Paint = function( self, _w, _h )
	-- Background
	draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.PanelBackgroundSecondary );
	
	-- Outline
	surface.SetDrawColor( GGS.Config.Derma.Colour.Outline );
	
	local _outline_size = 1;
	surface.DrawOutlinedRect( GGS.Config.Derma.Sizing.OutlineGap, GGS.Config.Derma.Sizing.OutlineGap, _w - ( GGS.Config.Derma.Sizing.OutlineGap * 2 ), _h - ( GGS.Config.Derma.Sizing.OutlineGap * 2 ), _outline_size );
	
	self.ExtendedPaint( self, _w, _h );
end;

vgui.Register( "GGS.ButtonSecondary", BUTTON, "DButton" );


--[[--------------
  GGS.IconButton
--------------]]--

local BUTTON = {};

BUTTON.Init = function( self )
	self:SetTextColor( GGS.Config.Derma.Colour.TextColorSecondary );
	self:SetText( "" );
	
	self.IconMaterial = nil;
	self.IconScaleX = 1;
	self.IconScaleY = 1;
	self.IconColor = Color( 255, 255, 255, 200 );
	
	self.ExtendedPaint = function() end;
end;

BUTTON.SetIconMaterial = function( self, _mat )
	self.IconMaterial = _mat;
end;

BUTTON.SetIconScale = function( self, _ws, _hs )
	self.IconScaleX = _ws;
	self.IconScaleY = _hs;
end;

BUTTON.SetIconColor = function( self, _color )
	self.IconColor = _color;
end;

BUTTON.Paint = function( self, _w, _h )
	-- Background
	draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.PanelBackground );
	
	-- Outline
	surface.SetDrawColor( GGS.Config.Derma.Colour.Outline );
	
	local _outline_size = 1;
	surface.DrawOutlinedRect( GGS.Config.Derma.Sizing.OutlineGap, GGS.Config.Derma.Sizing.OutlineGap, _w - ( GGS.Config.Derma.Sizing.OutlineGap * 2 ), _h - ( GGS.Config.Derma.Sizing.OutlineGap * 2 ), _outline_size );
	
	-- Draw icon
	if self.IconMaterial then
		local _icon_w, _icon_h = self.IconScaleX * ( math.min( _w, _h ) * 0.7 ), self.IconScaleY * ( math.min( _w, _h ) * 0.7 );
		
		surface.SetDrawColor( self.IconColor );
		surface.SetMaterial( self.IconMaterial );
		surface.DrawTexturedRect( ( _w - _icon_w ) / 2, ( _h - _icon_h ) / 2, _icon_w, _icon_h );
	end;
	
	self.ExtendedPaint( self, _w, _h );
end;

vgui.Register( "GGS.IconButton", BUTTON, "DButton" );
