--[[-------------
  GGS.Container
-------------]]--

local PANEL = {};

-- Transparent background
PANEL.Paint = function( self, _w, _h ) end;

vgui.Register( "GGS.Container", PANEL, "DPanel" );


--[[---------
  GGS.Panel
---------]]--

local PANEL = {};

PANEL.Init = function( self )
	self.ExtendedPaint = function() end;
end;

PANEL.Paint = function( self, _w, _h )
	-- Background
	draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.PanelBackground );
	
	-- Outline
	surface.SetDrawColor( GGS.Config.Derma.Colour.Outline );
	surface.DrawOutlinedRect( GGS.Config.Derma.Sizing.OutlineGap, GGS.Config.Derma.Sizing.OutlineGap, _w - ( GGS.Config.Derma.Sizing.OutlineGap * 2 ), _h - ( GGS.Config.Derma.Sizing.OutlineGap * 2 ), GGS.Config.Derma.Sizing.Outline );
	
	self.ExtendedPaint( self, _w, _h );
end;

vgui.Register( "GGS.Panel", PANEL, "DPanel" );


--[[------------------
  GGS.PanelSecondary
------------------]]--

local PANEL = {};

PANEL.Init = function( self )
	self.ExtendedPaint = function() end;
end;

PANEL.Paint = function( self, _w, _h )
	-- Background
	draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.PanelBackgroundSecondary );
	
	-- Outline
	surface.SetDrawColor( GGS.Config.Derma.Colour.Outline );
	surface.DrawOutlinedRect( GGS.Config.Derma.Sizing.OutlineGap, GGS.Config.Derma.Sizing.OutlineGap, _w - ( GGS.Config.Derma.Sizing.OutlineGap * 2 ), _h - ( GGS.Config.Derma.Sizing.OutlineGap * 2 ), GGS.Config.Derma.Sizing.Outline );
	
	self.ExtendedPaint( self, _w, _h );
end;

vgui.Register( "GGS.PanelSecondary", PANEL, "DPanel" );


--[[----------
  GGS.Navbar
----------]]--

local PANEL = {};

PANEL.AddHomeButton = function( self, _text, _function )
	local _navbar_w, _navbar_h = self:GetSize();
	
	local _home_button = vgui.Create( "DButton", self );
	_home_button:SetText( _text );
	_home_button:SetFont( GGS.GetFont( 36 ) );
	_home_button:SetTextColor( GGS.Config.Derma.Colour.TextColor );
	_home_button:SizeToContents();
	_home_button:SetPos( _navbar_w / 2 - _home_button:GetWide() / 2, _navbar_h / 2 - _home_button:GetTall() / 2 );
	_home_button.Paint = function() end;
	_home_button.DoClick = function( self )
		_function( self );
	end;
	_home_button.OnCursorEntered = function( self )
		if self and IsValid( self ) then
			self:SetTextColor( GGS.Config.Derma.Colour.TextHover );
		end;
	end;
	_home_button.OnCursorExited = function( self )
		if self and IsValid( self ) then
			self:SetTextColor( GGS.Config.Derma.Colour.TextColor );
		end;
	end;
	
	return _home_button;
end;

PANEL.AddButton = function( self, _slot, _text, _function )
	local _navbar_w, _navbar_h = self:GetSize();
	local _button_x;
	
	local _nav_button = vgui.Create( "DButton", self );
	_nav_button:SetText( _text );
	_nav_button:SetFont( GGS.GetFont( 27 ) );
	_nav_button:SetTextColor( GGS.Config.Derma.Colour.TextColorSecondary );
	_nav_button:SizeToContents();
	
	if _slot == 1 then
		_button_x = 20;
	elseif _slot == 2 then
		_button_x = _navbar_w * 0.25 - _nav_button:GetWide() / 2;
	elseif _slot == 3 then
		_button_x = _navbar_w * 0.75 - _nav_button:GetWide() / 2;
	elseif _slot == 4 then
		_button_x = _navbar_w - 20 - _nav_button:GetWide();
	else
		_nav_button:Remove();
		return;
	end;
	
	_nav_button:SetPos( _button_x, _navbar_h / 2 - _nav_button:GetTall() / 2 );
	_nav_button.Paint = function() end;
	_nav_button.DoClick = function( self )
		_function( self );
	end;
	_nav_button.OnCursorEntered = function( self )
		if self and IsValid( self ) then
			self:SetTextColor( GGS.Config.Derma.Colour.TextHover );
		end;
	end;
	_nav_button.OnCursorExited = function( self )
		if self and IsValid( self ) then
			self:SetTextColor( GGS.Config.Derma.Colour.TextColorSecondary );
		end;
	end;
	
	return _nav_button;
end;

vgui.Register( "GGS.Navbar", PANEL, "GGS.Panel" );
