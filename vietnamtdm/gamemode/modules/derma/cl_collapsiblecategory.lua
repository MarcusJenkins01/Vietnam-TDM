--[[-----------------------
  GGS.CollapsibleCategory
-----------------------]]--

local COLLAPSIBLE = {};

COLLAPSIBLE.Init = function( self )
	self:SetLabel( "" );
	self:SetExpanded( 1 );
	
	self.Header.Title = "";
	self.Header.TitleColour = GGS.Config.Derma.Colour.TextColor;
	self.Header.Font = GGS.GetFont( 24 );
	self.Header.ExtendedPaint = function() end;
	self.Header.Paint = function( self, _w, _h )
		-- Background
		draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.PanelBackground );
		
		-- Outline
		surface.SetDrawColor( GGS.Config.Derma.Colour.Outline );
		surface.DrawOutlinedRect( 0, 0, _w, _h );
		
		-- Title
		draw.SimpleText( self.Title, self.Font, _w/2, _h/2, self.TitleColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
		
		self.ExtendedPaint( self, _w, _h );
	end;
	self.Header.SetTextColor = function( self, _color )
		self.TitleColour = _color;
	end;
end;

COLLAPSIBLE.SetTitle = function( self, _title )
	self.Header.Title = _title;
end;

COLLAPSIBLE.SetTextSize = function( self, _size )
	self.Header.Font = GGS.GetFont( _size );
end;

COLLAPSIBLE.SetHeaderHeight = function( self, _h )
	self.Header:SetTall( _h );
end;

--[[
COLLAPSIBLE.PerformLayout = function( self )
	if ( IsValid( self.Contents ) ) then
		if ( self:GetExpanded() ) then
			self.Contents:InvalidateLayout( true );
			self.Contents:SetVisible( true );
		else
			self.Contents:SetVisible( false );
		end
	end

	if ( self:GetExpanded() ) then
		--if ( IsValid( self.Contents ) && #self.Contents:GetChildren() > 0 ) then self.Contents:SizeToChildren( false, true ) end
		--self:SizeToChildren( false, true )
	else
		if ( IsValid( self.Contents ) && !self.OldHeight ) then self.OldHeight = self.Contents:GetTall() end
		self:SetTall( self.Header:GetTall() )
	end

	self.Header:ApplySchemeSettings()

	self.animSlide:Run()
	self:UpdateAltLines()
end;
]]--

-- Transparent background
COLLAPSIBLE.Paint = function( self, _w, _h ) end;

vgui.Register( "GGS.CollapsibleCategory", COLLAPSIBLE, "DCollapsibleCategory" );
