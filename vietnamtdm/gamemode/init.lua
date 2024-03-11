AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );

include( "shared.lua" );

local _modules = GM.FolderName .. "/gamemode/modules/";
local _, _folders = file.Find( _modules .. "*", "LUA" );

for _, _folder in SortedPairs( _folders, true ) do
    if _folder == "." or _folder == ".." then continue; end;

    for _, _file in SortedPairs( file.Find( _modules .. _folder .. "/sh_*.lua", "LUA" ), true ) do
        AddCSLuaFile( _modules .. _folder .. "/" .. _file );
        include( _modules .. _folder .. "/" .. _file );
    end;

    for _, _file in SortedPairs( file.Find( _modules .. _folder .. "/sv_*.lua", "LUA" ), true ) do
        include( _modules .. _folder .. "/" .. _file );
    end;

    for _, _file in SortedPairs( file.Find(_modules .. _folder .. "/cl_*.lua", "LUA" ), true ) do
        AddCSLuaFile( _modules .. _folder .. "/" .. _file );
    end;
end;

function GM:PlayerInitialSpawn( _ply )
	_ply:SetTeam( 1 );
end;

function GM:PlayerSpawn( _ply )
	player_manager.SetPlayerClass( _ply, "player_tdm" );
	
	gamemode.Call( "PlayerLoadout", _ply );
	gamemode.Call( "PlayerSetModel", _ply );
end;

function GM:PlayerSetModel( _ply )
	if ( _ply:Team() == 2 ) then
		util.PrecacheModel( "models/us/army/us_army_3_fritz.mdl" )
		_ply:SetModel( "models/us/army/us_army_3_fritz.mdl" );
	elseif ( _ply:Team() == 3 ) then
		util.PrecacheModel( "models/vietnam/humans/vc/gmod/vc_1.mdl" )
		_ply:SetModel( "models/vietnam/humans/vc/gmod/vc_1.mdl" );
	else
		util.PrecacheModel( "models/player/Group01/male_09.mdl" )
		_ply:SetModel( "models/player/Group01/male_09.mdl" );
	end;
	
	_ply:SetupHands();
end;

function GM:PlayerLoadout( _ply )
	if _ply:IsAdmin() then
		_ply:Give( "weapon_physgun" );
	end;
	
	if _ply:IsSuperAdmin() then
		_ply:Give( "gmod_tool" );
	end;
	
	if _ply.SelectedLoadout then
		for _, _swep in pairs( _ply.SelectedLoadout ) do
			_ply:Give( _swep.class );
		end;
	end;
end;

function GM:PlayerSelectSpawn( _ply )
	return ents.FindByClass( "info_player_start" )[2];
end;
