--[[-------------
  GGS.PanelList
-------------]]--

local PANEL_LIST = {};

PANEL_LIST.EnableVerticalScrollbar = function( self )
	if !self.VBar then
		self.VBar = vgui.Create( "DVScrollBar", self );
		
		local _sbar = self.VBar;
		
		_sbar.Paint = function()
			draw.RoundedBox( 0, 0, 0, _sbar:GetWide(), _sbar:GetTall(), GGS.Config.Derma.Colour.SBarBG );
		end
		_sbar.btnGrip.Paint = function( self, _w, _h )
			draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.SBarColor );
			
			surface.SetDrawColor( GGS.Config.Derma.Colour.SBarOutline );
			surface.DrawOutlinedRect( -1, 0, _w+1, _h );
		end
		_sbar.btnUp.Paint = function( self, _w, _h )
			draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.SBarColor );
			
			surface.SetDrawColor( GGS.Config.Derma.Colour.SBarOutline );
			surface.DrawOutlinedRect( -1, 0, _w+1, _h );
		end
		_sbar.btnDown.Paint = function( self, _w, _h )
			draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.SBarColor );
			
			surface.SetDrawColor( GGS.Config.Derma.Colour.SBarOutline );
			surface.DrawOutlinedRect( -1, 0, _w+1, _h );
		end
	end;
end;

-- Transparent background
PANEL_LIST.Paint = function( self, _w, _h ) end;

vgui.Register( "GGS.PanelList", PANEL_LIST, "DPanelList" );
