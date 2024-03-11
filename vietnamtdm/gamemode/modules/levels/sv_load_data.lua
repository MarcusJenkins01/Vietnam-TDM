GGS = GGS || {};
GGS.Levels = GGS.Levels || {};

-- include( "ggs_levels/core/sh_ggs_levels.lua" );

GGS.Levels.LoadPlayerData = function( _ply )
	_ply:SetNWInt( "GGS.LevelXP", 100 );
end;

hook.Add( "PlayerSpawn", "GGS.Levels.LoadPlayerData", GGS.Levels.LoadPlayerData );


-- player.GetAll()[2]:SetGGSUserGroup("headofstaff")