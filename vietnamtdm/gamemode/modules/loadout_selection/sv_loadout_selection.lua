util.AddNetworkString( "GGS.SelectTeamMenu" );
util.AddNetworkString( "GGS.WeaponSelectionMenu" );
util.AddNetworkString( "GGS.SelectWeapon" );
util.AddNetworkString( "GGS.LoadoutSelect" );
util.AddNetworkString( "GGS.SelectTeam" );
util.AddNetworkString( "GGS.Deploy" );

include( GM.FolderName .. "/gamemode/modules/loadout_selection/sh_weapons.lua" );

GGS.SelectTeamMenu = function( _ply )
	net.Start( "GGS.SelectTeamMenu" );
	net.Send( _ply );
end;

GGS.WeaponSelectionMenu = function( _ply )
	local _team = _ply:Team();
	
	if table.HasValue( { 2, 3 }, _team ) then
		net.Start( "GGS.WeaponSelectionMenu" );
			net.WriteInt( _team, 4 );
		net.Send( _ply );
	end;
end;

GGS.SelectWeapon = function( _ply, _weapon )
	for _type, _type_tbl in pairs( GGS.LoadoutWeapons ) do
		for _category, _category_tbl in pairs( _type_tbl.categories ) do
			if _category_tbl.weapons[_weapon] then
				local _wep_tbl = _category_tbl.weapons[_weapon];
				
				if _ply:Team() == _wep_tbl.team then
					_ply.SelectedLoadout = _ply.SelectedLoadout || {};
					_ply.SelectedLoadout[_type] = {};
					_ply.SelectedLoadout[_type].class = _weapon;
					_ply.SelectedLoadout[_type].category = _category;
					
					net.Start( "GGS.LoadoutSelect" );
						net.WriteTable( _ply.SelectedLoadout );
					net.Send( _ply );
					
					break;
				end;
			end;
		end;
	end;
end;

GGS.GiveLoadoutWeapons = function( _ply )
	if _ply.SelectedLoadout then
		for _, _swep in pairs( _ply.SelectedLoadout ) do
			_ply:Give( _swep.class );
		end;
	end;
end;

net.Receive( "GGS.SelectTeam", function( _len, _ply )
	local _team = net.ReadInt( 4 );
	
	if table.HasValue( { 2, 3 }, _team ) then
		local _team_count = team.NumPlayers( _team );
		local _other_team_count = team.NumPlayers( ( ( _team == 2 ) and 3 or 2 ) );
		
		if _ply:Team() == _team then
			net.Start( "GGS.WeaponSelectionMenu" );
				net.WriteInt( _team, 4 );
			net.Send( _ply );
		elseif _team_count <= _other_team_count + 1 then
			_ply:SetTeam( _team );
			_ply.SelectedLoadout = {};
			
			_ply:KillSilent();
			
			net.Start( "GGS.LoadoutSelect" );
				net.WriteTable( _ply.SelectedLoadout );
			net.Send( _ply );
			
			net.Start( "GGS.WeaponSelectionMenu" );
				net.WriteInt( _team, 4 );
			net.Send( _ply );
		end;
	end;
end );

net.Receive( "GGS.SelectWeapon", function( _len, _ply )
	local _weapon = net.ReadString();
	
	GGS.SelectWeapon( _ply, _weapon );
end );

net.Receive( "GGS.Deploy", function( _len, _ply, _team )
	_ply:StripWeapons();
	
	_ply:Spawn();
end );

hook.Add( "ShowSpare2", "GGS.SelectTeamMenu", GGS.SelectTeamMenu );
hook.Add( "ShowTeam", "GGS.WeaponSelectionMenu", GGS.WeaponSelectionMenu );

hook.Add( "PlayerSpawn", "GGS.GiveLoadoutWeapons", GGS.GiveLoadoutWeapons );
