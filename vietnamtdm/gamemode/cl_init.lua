include( "shared.lua" );

local _modules = GM.FolderName .. "/gamemode/modules/";
local _, _folders = file.Find( _modules .. "*", "LUA" );

for _, _folder in SortedPairs( _folders, true ) do
    if _folder == "." or _folder == ".." then continue; end;

    for _, _file in SortedPairs( file.Find( _modules .. _folder .. "/sh_*.lua", "LUA" ), true ) do
        include( _modules .. _folder .. "/" .. _file );
    end;

    for _, _file in SortedPairs( file.Find(_modules .. _folder .. "/cl_*.lua", "LUA" ), true ) do
        include( _modules .. _folder .. "/" .. _file );
    end;
end;

function GM:PlayerInitialSpawn( _ply )
	RunConsoleCommand( "ggs_vietnam_loadout_menu" );
end;
