--[[--------
  GGS.Grid
--------]]--

local GRID = {};

AccessorFunc( GRID, "horizontalMargin", "HorizontalMargin", FORCE_NUMBER );
AccessorFunc( GRID, "verticalMargin", "VerticalMargin", FORCE_NUMBER );
AccessorFunc( GRID, "columns", "Columns", FORCE_NUMBER );

function GRID:Init()
	self:SetHorizontalMargin( 0 );
	self:SetVerticalMargin( 0 );

	self.Rows = {};
	self.Cells = {};
	
	local _sbar = self:GetVBar();
	
	if _sbar then
		_sbar.Paint = function()
			draw.RoundedBox( 0, 0, 0, _sbar:GetWide(), _sbar:GetTall(), GGS.Config.Derma.Colour.SBarBG );
		end
		_sbar.btnGrip.Paint = function( self, _w, _h )
			draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.PanelBackground );
			
			surface.SetDrawColor( GGS.Config.Derma.Colour.SBarOutline );
			surface.DrawOutlinedRect( 0, 0, _w, _h );
		end
		_sbar.btnUp.Paint = function( self, _w, _h )
			draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.PanelBackground );
			
			surface.SetDrawColor( GGS.Config.Derma.Colour.SBarOutline );
			surface.DrawOutlinedRect( 0, 0, _w, _h );
		end
		_sbar.btnDown.Paint = function( self, _w, _h )
			draw.RoundedBox( 0, 0, 0, _w, _h, GGS.Config.Derma.Colour.PanelBackground );
			
			surface.SetDrawColor( GGS.Config.Derma.Colour.SBarOutline );
			surface.DrawOutlinedRect( 0, 0, _w, _h );
		end;
	end;
end;

function GRID:AddCell( _pnl )
	local _cols = self:GetColumns()
	local _idx = math.floor( #self.Cells / _cols ) + 1;
	self.Rows[_idx] = self.Rows[_idx] || self:CreateRow();

	local _margin = self:GetHorizontalMargin();
	
	_pnl:SetParent( self.Rows[_idx] );
	_pnl:Dock( LEFT );
	_pnl:DockMargin( 0, 0, #self.Rows[_idx].Items + 1 < _cols && self:GetHorizontalMargin() || 0, 0 );
	_pnl:SetWide( ( self:GetWide() - _margin * ( _cols - 1 ) ) / _cols );

	table.insert( self.Rows[_idx].Items, _pnl );
	table.insert( self.Cells, _pnl );
	
	self:CalculateRowHeight( self.Rows[_idx] );
end

function GRID:CreateRow()
	local _row = self:Add( "DPanel" );
	_row:Dock( TOP );
	_row:DockMargin( 0, 0, 0, self:GetVerticalMargin() );
	_row.Paint = nil;
	_row.Items = {};
	
	return _row;
end;

function GRID:CalculateRowHeight( _row )
	local _height = 0;
	
	for _, _v in pairs( _row.Items ) do
		_height = math.max( _height, _v:GetTall() );
	end;
	
	_row:SetTall( _height );
end;

function GRID:Skip()
	local _cell = vgui.Create( "DPanel" );
	
	_cell.Paint = nil;
	self:AddCell( _cell );
end;

function GRID:Clear()
	for _, _row in pairs( self.Rows ) do
		for _, _cell in pairs( _row.Items ) do
			_cell:Remove();
		end;
		
		_row:Remove();
	end;

	self.Cells, self.Rows = {}, {};
end;

GRID.OnRemove = GRID.Clear;

vgui.Register( "GGS.Grid", GRID, "DScrollPanel" );
