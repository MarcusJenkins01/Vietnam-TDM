--[[---------------------------------------------------------
	Handle spawn menu opening
-----------------------------------------------------------]]

hook.Add( "SpawnMenuOpen", "GGS.RestrictSpawnMenu", function()
	return true;
end );
