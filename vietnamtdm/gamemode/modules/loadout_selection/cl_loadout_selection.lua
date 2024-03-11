GGS.LoadoutSelection = GGS.LoadoutSelection || {};
GGS.LoadoutSelection.Menus = GGS.LoadoutSelection.Menus || {};
GGS.LoadoutSelection.ActiveMenu = 0;

GGS.SelectedLoadout = GGS.SelectedLoadout || {};

include( GM.FolderName .. "/gamemode/modules/loadout_selection/sh_weapons.lua" );

GGS.LoadoutSelection.Teams = {
	[2] = {
		name = "United States",
		model = "models/us/army/us_army_2_fritz.mdl",
		pose = "idle_all_01",
		flag = Material( "ggs/nam/us_flag.png", "noclamp smooth" )
		-- gesture = "gesture_salute_original",
		-- pose_start = 0.2,
		-- end_offset = 0.3
	},
	[3] = {
		name = "PAVN",
		model = "models/vietnam/humans/vc/gmod/vc_1.mdl",
		pose = "idle_all_01",
		flag = Material( "ggs/nam/vc_flag.png", "noclamp smooth" )
	}
}

-- Handle loadouts
net.Receive( "GGS.LoadoutSelect", function()
	local _loadout_table = net.ReadTable();
	
	GGS.SelectedLoadout = _loadout_table;
end );

local none = Material( "ggs/nam/icons/none.png", "noclamp smooth" );

local function GetMenuBase()
	if GGS.LoadoutSelection.Background and GGS.LoadoutSelection.Background:IsValid() then
		if GGS.LoadoutSelection.Main and GGS.LoadoutSelection.Main:IsValid() then
			GGS.LoadoutSelection.Main:Clear();
			
			return GGS.LoadoutSelection.Main;
		end;
		
		GGS.LoadoutSelection.Background:Remove();
	end;
	
	-- Blur background
	GGS.LoadoutSelection.Background = vgui.Create( "GGS.BlurBackground" );
	GGS.LoadoutSelection.Background:MakePopup();
	GGS.LoadoutSelection.Background:SetIntensity( 1 );
	GGS.LoadoutSelection.Background:SetBlurAlpha( 150 );
	GGS.LoadoutSelection.Background:SetKeyboardInputEnabled();
	GGS.LoadoutSelection.Background:ShowCloseButton( false );
	
	-- Main container
	local _container_w, _container_h = ScrW() - ( ScrH() * 0.25 ), ScrH() - ( ScrH() * 0.25 );
	
	GGS.LoadoutSelection.Main = vgui.Create( "GGS.Container", GGS.LoadoutSelection.Background );
	GGS.LoadoutSelection.Main:SetSize( _container_w, _container_h );
	GGS.LoadoutSelection.Main:Center();
	
	return GGS.LoadoutSelection.Main;
end;

local SelectTeamMenu = function()
	util.PrecacheModel( GGS.LoadoutSelection.Teams[2].model );
	util.PrecacheModel( GGS.LoadoutSelection.Teams[3].model );
	
	local _page_container = GetMenuBase();
	
	GGS.LoadoutSelection.ActiveMenu = 1;
	
	local _page_container_w, _page_container_h = _page_container:GetSize();
	local _offset_x = 0.1;
	
	local i = 0;
	
	for _team, _team_tbl in pairs( GGS.LoadoutSelection.Teams ) do
		-- Team panel
		local _team_panel_w, _team_panel_h = _page_container_w * 0.32, _page_container_h * 0.88;
		local _second_team_x_offset = ( _page_container_w * ( 1 - _offset_x * 2 ) ) - _team_panel_w;
		local _team_panel_x, _team_panel_y = ( _page_container_w * _offset_x ) + ( i * _second_team_x_offset ), ( _page_container_h - _team_panel_h ) / 2;
		
		local _team_panel = vgui.Create( "GGS.Panel", _page_container );
		_team_panel:SetSize( _team_panel_w, _team_panel_h );
		_team_panel:SetPos( _team_panel_x, _team_panel_y );
		
		local _inner_w, _inner_h = _team_panel_w * 0.9, _team_panel_h - ( _team_panel_w * 0.1 );
		local _inner_x, _inner_y = _team_panel_w * 0.05, _team_panel_w * 0.05;
		
		-- Flag
		_team_panel.ExtendedPaint = function( self, _w, _h )
			surface.SetDrawColor( 255, 255, 255, 150 );
			surface.SetMaterial( _team_tbl.flag );
			surface.DrawTexturedRect( _inner_x, _inner_y, _inner_w, _inner_h * 0.4 );
		end;
		
		-- Model panel
		local _fov = 20;
		local _model_w, _model_h = _team_panel_w, _team_panel_h;
		local _model_x, _model_y = 0, 0;
		
		local _model_panel = vgui.Create( "DModelPanel", _team_panel );
		_model_panel:SetSize( _model_w, _model_h );
		_model_panel:SetPos( _model_x, _model_y );
		_model_panel:SetFOV( _fov );
		_model_panel:SetModel( _team_tbl.model );
		
		if _model_panel.Entity:LookupSequence( _team_tbl.pose ) then
			_model_panel.Entity:SetSequence( _model_panel.Entity:LookupSequence( _team_tbl.pose ) );
		end;
		
		_model_panel.LayoutEntity = function( self, _ent )
			_model_panel:RunAnimation();
			return;  -- Stop the playermodel rotating
		end;
		
		if _model_panel.Entity then
			local _eyepos = Vector( 0, 0, 0 );
			
			if _model_panel.Entity:LookupBone( "ValveBiped.Bip01_Spine2" ) then
				_eyepos = _model_panel.Entity:GetBonePosition( _model_panel.Entity:LookupBone( "ValveBiped.Bip01_Spine2" ) );
				_eyepos:Add( Vector( 0, 0, 0 ) );
			end;
			
			_model_panel.Entity:SetPos( Vector( 0, 0, 0 ) );
			_model_panel:SetCamPos( _eyepos + Vector( 140, 0, 0 ) );
			_model_panel:SetLookAt( _eyepos );
		end;
		
		local _team_button = vgui.Create( "DButton", _team_panel );
		_team_button:SetSize( _team_panel_w, _team_panel_h );
		_team_button:SetPos( 0, 0 );
		_team_button:SetText( "" );
		
		local _title_w = _inner_w - ( _inner_x * 2 );
		local _title_h = _inner_h * 0.07;
		local _title_y = ( _inner_h - _title_h ) * 0.75;
		
		local _players_w = _inner_w * 0.3;
		local _players_h = _inner_h * 0.042;
		local _players_y = _title_y + _inner_h * 0.1;
		
		_team_button.Paint = function( self, _w, _h )
			draw.RoundedBox( 3, ( _w - _title_w ) / 2, _title_y, _title_w, _title_h, Color( 0, 0, 0, 180 ) );
			draw.SimpleText( string.upper( _team_tbl.name ), GGS.GetFont( 36 ), _w / 2, _title_y + ( _title_h / 2 ), Color( 255, 255, 255, 150 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
			
			draw.RoundedBox( 3, ( _w - _players_w ) / 2, _players_y, _players_w, _players_h, Color( 0, 0, 0, 150 ) );
			draw.SimpleText( team.NumPlayers( _team ) .. " PLAYERS", GGS.GetFont( 20 ), _w / 2, _players_y + ( _players_h / 2 ), Color( 255, 255, 255, 150 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
		end;
		
		_team_button.OnCursorEntered = function( self )
			surface.PlaySound( "ggs/vgui/button_accent.wav" );
		end;
		
		_team_button.DoClick = function()
			net.Start( "GGS.SelectTeam" );
				net.WriteInt( _team, 4 );
			net.SendToServer();
		end;
		
		i = i + 1;
	end;
end;

local function AddWeaponsToList( _list, _type_name, _side )
	_list:Clear();
	local _list_w, _list_h  = _list:GetSize();
	
	for _category, _category_tbl in SortedPairsByMemberValue( GGS.LoadoutWeapons[_type_name].categories, "sortOrder" ) do
		local _category_collapsible = vgui.Create( "GGS.CollapsibleCategory" );
		_category_collapsible:SetHeaderHeight( _list_h / 15 );
		_category_collapsible:SetTitle( string.upper( _category ) );
		_category_collapsible.Header.OnCursorEntered = function( self )
			if self and self:IsValid() then
				self:SetTextColor( GGS.Config.Derma.Colour.TextHover );
			end;
		end;
		_category_collapsible.Header.OnCursorExited = function( self )
			if self and self:IsValid() then
				self:SetTextColor( GGS.Config.Derma.Colour.TextColor );
			end;
		end;
		
		_list:AddItem( _category_collapsible );

		local _wep_list = vgui.Create( "GGS.PanelList" );
		_category_collapsible:SetContents( _wep_list );
	
		for _class, _weapon_data in pairs( _category_tbl.weapons ) do
			if _weapon_data.team == _side then
				local _wep_button = vgui.Create( "GGS.ButtonSecondary" );
				_wep_button:SetSize( 0, _list_h / 18 );
				_wep_button:SetText( _weapon_data.name .. " - Level " .. _weapon_data.level );
				_wep_button.DoClick = function( self )
					surface.PlaySound( "ggs/vgui/button_click.wav" );
					
					net.Start( "GGS.SelectWeapon" );
						net.WriteString( _class );
					net.SendToServer();
				end;
				
				_wep_button.OnCursorEntered = function( self )
					surface.PlaySound( "ggs/vgui/button_accent.wav" );
				end;
				
				_wep_button.ExtendedPaint = function( self, _w, _h )
					if GGS.SelectedLoadout[_type_name] then
						local _equipped = GGS.SelectedLoadout[_type_name];
						-- local _equipped_weapon_data = GGS.LoadoutWeapons[_type_name].weapons[_equipped.category][_equipped.class];
						
						local _highlight_color = GGS.Config.Derma.Colour.Highlight;
						local _sin_curve = 0;
						
						if _equipped.class == _class then
							_sin_curve = math.abs( math.sin( CurTime() * 1.5 ) * 10 );
							draw.RoundedBox( 0, 0, 0, _w, _h, Color( _highlight_color.r, _highlight_color.g, _highlight_color.b, math.max( _highlight_color.a, _sin_curve ) ) );
						elseif self:IsHovered() then
							draw.RoundedBox( 0, 0, 0, _w, _h, _highlight_color );
						end;
					end;
				end;
				
				_wep_list:AddItem( _wep_button );
			end;
		end;
	end;
end;

local function WeaponSelectionMenu( _side )
	local _page_container = GetMenuBase();
	
	GGS.LoadoutSelection.ActiveMenu = 2;
	
	local _page_container_w, _page_container_h = _page_container:GetSize();
	
	local _top_buttons = vgui.Create( "GGS.Container", _page_container );
	_top_buttons:SetSize( _page_container_w / 3.5, _page_container_h * 0.08 );
	
	local _top_buttons_w, _top_buttons_h = _top_buttons:GetSize();
	
	local _type_count = table.Count( GGS.LoadoutWeapons );
	local _button_w = ( _top_buttons_w - ( 10 * ( _type_count - 1 ) ) ) / math.max( _type_count, 1 );
	local _button_x = _button_w + 10;
	
	local _side_list = vgui.Create( "GGS.PanelList", _page_container );
	_side_list:EnableVerticalScrollbar();
	_side_list:SetSize( _page_container_w / 3.5, _page_container_h - _top_buttons_h - 10 );
	_side_list:SetPos( 0, _top_buttons_h + 10 );
	_side_list:SetSpacing( 10 );
	
	local _side_list_w, _side_list_h = _side_list:GetSize();
	
	local _main_panel = vgui.Create( "GGS.Container", _page_container );
	_main_panel:SetSize( _page_container_w - _side_list_w - 20, _side_list_h );
	_main_panel:SetPos( _side_list_w + 20, 0 );
	
	local _main_panel_w, _main_panel_h = _main_panel:GetSize();
	
	local _loadout_selection = vgui.Create( "GGS.Container", _main_panel );
	_loadout_selection:SetSize( _main_panel_w * 0.58, _main_panel_h );
	_loadout_selection:SetPos( 0, 0 );
	
	local _loadout_selection_w, _loadout_selection_h = _loadout_selection:GetSize();
	
	local _equipped_container_h = _loadout_selection_h / 4;
	local _equipped_container_y = _loadout_selection_h / 4 + 20;
	
	local _i = 0;
	
	for _type_name, _type_tbl in pairs( GGS.LoadoutWeapons ) do
		local _equipped_container = vgui.Create( "GGS.Panel", _loadout_selection );
		_equipped_container:SetSize( _loadout_selection_w, _equipped_container_h );
		_equipped_container:SetPos( 0, _equipped_container_y * _i );
		_equipped_container.ExtendedPaint = function( self, _w, _h )
			draw.SimpleText( string.upper( _type_name ), GGS.GetFont( 30 ), _w / 2, _h * 0.1, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP );
			
			local _material = none;
			local _name = "none";
			
			local _icon_w = _h * 0.3;
			local _icon_h = _h * 0.3;
			
			if GGS.SelectedLoadout[_type_name] then
				local _equipped = GGS.SelectedLoadout[_type_name];
				local _equipped_weapon_data = GGS.LoadoutWeapons[_type_name].categories[_equipped.category].weapons[_equipped.class];
				
				_material = _equipped_weapon_data.material;
				_name = _equipped_weapon_data.name;
				
				_icon_w = _icon_w * _equipped_weapon_data.iconScale.w;
				_icon_h = _icon_h * _equipped_weapon_data.iconScale.h;
			end;
			
			surface.SetDrawColor( 255, 255, 255, 150 );
			surface.SetMaterial( _material );
			surface.DrawTexturedRect( ( _w - _icon_w ) / 2, ( _h - _icon_h ) / 2, _icon_w, _icon_h );
			
			draw.SimpleText( string.upper( _name ), GGS.GetFont( 24 ), _w / 2, _h - _h * 0.1, Color( 255, 255, 255, 150 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM );
		end;
		
		local _type_button = vgui.Create( "GGS.IconButton", _top_buttons );
		_type_button:SetSize( _button_w, _top_buttons_h );
		_type_button:SetPos( _button_x * _i, 0 );
		_type_button:SetIconMaterial( _type_tbl.material );
		_type_button:SetIconScale( 0.7, 0.7 );
		_type_button.OnCursorEntered = function( self )
			if self and self:IsValid() then
				surface.PlaySound( "ggs/vgui/button_accent.wav" );
				
				self:SetIconColor( GGS.Config.Derma.Colour.TextHover );
			end;
		end;
		_type_button.OnCursorExited = function( self )
			if self and self:IsValid() then
				self:SetIconColor( Color( 255, 255, 255, 200 ) );
			end;
		end;
		_type_button.DoClick = function( self )
			surface.PlaySound( "ggs/vgui/button_click.wav" );
			AddWeaponsToList( _side_list, _type_name, _side );
		end;
		
		_i = _i + 1
	end;
	
	AddWeaponsToList( _side_list, "Primary", _side );
	
	-- Model panel
	local _fov = 35;
	local _model_w, _model_h = _main_panel_w - _loadout_selection_w - 20, _main_panel_h * 0.9 - 10;
	local _model_x, _model_y = _loadout_selection_w + 20, 0;
	
	local _model_container = vgui.Create( "GGS.Panel", _main_panel );
	_model_container:SetSize( _model_w, _model_h );
	_model_container:SetPos( _model_x, _model_y );
	
	local _ply = LocalPlayer();
	local _name = _ply:Nick();
	
	_model_container.ExtendedPaint = function( self, _w, _h )
		draw.RoundedBox( 3, _w * 0.1, _h * 0.055, _w * 0.8, _h * 0.052, Color( 0, 0, 0, 150 ) );
		draw.SimpleText( string.upper( _name ), GGS.GetFont( 30 ), _w / 2, _h * 0.08, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
		
		draw.RoundedBox( 3, _w * 0.3, _h * 0.12, _w * 0.4, _h * 0.042, Color( 0, 0, 0, 150 ) );
		draw.SimpleText( "LEVEL: " .. _ply:GetLevel(), GGS.GetFont( 24 ), _w / 2, _h * 0.14, Color( 255, 255, 255, 150 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
		
		surface.SetDrawColor( 255, 255, 255, 150 );
		surface.SetMaterial( GGS.LoadoutSelection.Teams[2].flag );
		surface.DrawTexturedRect( _w * 0.05, _h * 0.5 - _w * 0.25, _w * 0.9, _w * 0.5 );
	end;
	
	local _model_container_w, _model_container_h = _model_container:GetSize();
	
	local _model_panel = vgui.Create( "DModelPanel", _model_container );
	_model_panel:SetSize( _model_container_w, _model_container_h * 0.8 );
	_model_panel:SetPos( 0, _model_container_h * 0.17 );
	_model_panel:SetFOV( _fov );
	_model_panel:SetModel( LocalPlayer():GetModel() );
	
	_model_panel.LayoutEntity = function( self, _ent )
		_model_panel:RunAnimation();
		return;  -- Stop the playermodel rotating
	end;
	
	if _model_panel.Entity then
		local _eyepos = Vector( 0, 0, 0 );
		
		if _model_panel.Entity:LookupBone( "ValveBiped.Bip01_Pelvis" ) then
			_eyepos = _model_panel.Entity:GetBonePosition( _model_panel.Entity:LookupBone( "ValveBiped.Bip01_Pelvis" ) );
		end;
		
		_model_panel.Entity:SetPos( Vector( 0, 0, 0 ) );
		_model_panel:SetCamPos( _eyepos + Vector( 120, 0, -2 ) );
		_model_panel:SetLookAt( _eyepos + Vector( 0, 0, -2 ) );
	end;
	
	local _deploy_button = vgui.Create( "GGS.Button", _main_panel );
	_deploy_button:SetSize( _model_w, _main_panel_h * 0.1 );
	_deploy_button:SetPos( _model_x, _model_h + 10 );
	_deploy_button:SetText( "DEPLOY" );
	_deploy_button:SetTextSize( 30 );
	_deploy_button.DoClick = function( self )
		GGS.LoadoutSelection.Background:Remove();
		
		net.Start( "GGS.Deploy" );
		net.SendToServer();
	end;
end;

net.Receive( "GGS.WeaponSelectionMenu", function()
	local _team = net.ReadInt( 4 );
	
	if GGS.LoadoutSelection.ActiveMenu == 2 then
		GGS.LoadoutSelection.Background:Remove();
		GGS.LoadoutSelection.ActiveMenu = 0;
	else
		WeaponSelectionMenu( _team );
	end;
end );

concommand.Add( "ggs_vietnam_loadout_menu", function()
	if GGS.LoadoutSelection.ActiveMenu == 1 then
		GGS.LoadoutSelection.Background:Remove();
		GGS.LoadoutSelection.ActiveMenu = 0;
	else
		SelectTeamMenu();
	end;
end	);

net.Receive( "GGS.SelectTeamMenu", function()
	if GGS.LoadoutSelection.ActiveMenu == 1 then
		GGS.LoadoutSelection.Background:Remove();
		GGS.LoadoutSelection.ActiveMenu = 0;
	else
		SelectTeamMenu();
	end;
end );
