--[[-------------------
  GGS.BlurBackground
-------------------]]--

local FRAME = {};

FRAME.Init = function( self )
	-- Disable default DFrame title
	self:SetTitle( "" );
	
	-- Set up sizing etc
	self:SetSize( ScrW(), ScrH() );
	self:SetDraggable( false );
	
	self.Intensity = 1;
	self.BlurAlpha = 255;
end;

FRAME.SetIntensity = function( self, _intensity )
	self.Intensity = _intensity;
end;

FRAME.SetBlurAlpha = function( self, _blur_alpha )
	self.BlurAlpha = _blur_alpha;
end;

FRAME.Paint = function( self, _w, _h )
	-- Draw blur
	draw.BlurPanel( self, 4, self.BlurAlpha );
	
	local _bg_color = GGS.Config.Derma.Colour.BlurBackground;
	draw.RoundedBox( 0, 0, 0, _w, _h, Color( _bg_color.r, _bg_color.g, _bg_color.b, _bg_color.a * self.Intensity ) );
end;

vgui.Register( "GGS.BlurBackground", FRAME, "DFrame" );
