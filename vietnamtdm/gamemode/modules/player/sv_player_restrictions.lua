--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnObject( _ply )
   Desc: Called to ask whether player is allowed to spawn any objects
-----------------------------------------------------------]]
function GM:PlayerSpawnObject( _ply )
	return _ply:IsSuperAdmin();
end;


--[[---------------------------------------------------------
   Name: gamemode:CanPlayerUnfreeze( )
   Desc: Can the player unfreeze this _entity & _phys
-----------------------------------------------------------]]
function GM:CanPlayerUnfreeze( _ply, _entity, _phys )
	if ( _entity:GetPersistent() ) then return false; end;
	return _ply:IsSuperAdmin();
end;


--[[---------------------------------------------------------
   Name: LimitReachedProcess
-----------------------------------------------------------]]
local function LimitReachedProcess( _ply, _str )
	if ( !IsValid( _ply ) ) then return true; end;
	return _ply:CheckLimit( _str );
	
	-- return !IsValid( _ply );
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnRagdoll( _ply, _model )
   Desc: Return true if it's allowed 
-----------------------------------------------------------]]
function GM:PlayerSpawnRagdoll( _ply, _model )
	return _ply:IsSuperAdmin();
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnProp( _ply, _model )
   Desc: Return true if it's allowed 
-----------------------------------------------------------]]

function GM:PlayerSpawnProp( _ply, _model )
	return _ply:IsSuperAdmin();
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnEffect( _ply, _model )
   Desc: Return true if it's allowed 
-----------------------------------------------------------]]

function GM:PlayerSpawnEffect( _ply, _model )
	return _ply:IsSuperAdmin();
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnVehicle( _ply, _model, vname, vtable )
   Desc: Return true if it's allowed 
-----------------------------------------------------------]]

function GM:PlayerSpawnVehicle( _ply, _model, _vname, _vtable )
	return _ply:IsSuperAdmin();
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnSWEP( _ply, wname, wtable )
   Desc: Return true if it's allowed 
-----------------------------------------------------------]]

function GM:PlayerSpawnSWEP( _ply, _wname, _wtable )
	return _ply:IsSuperAdmin();
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerGiveSWEP( _ply, wname, wtable )
   Desc: Return true if it's allowed 
-----------------------------------------------------------]]

function GM:PlayerGiveSWEP( _ply, _wname, _wtable )
	return _ply:IsSuperAdmin();
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnSENT( _ply, name )
   Desc: Return true if player is allowed to spawn the SENT
-----------------------------------------------------------]]

function GM:PlayerSpawnSENT( _ply, _name )
	return _ply:IsSuperAdmin();
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnNPC( _ply, npc_type )
   Desc: Return true if player is allowed to spawn the NPC
-----------------------------------------------------------]]

function GM:PlayerSpawnNPC( _ply, _npc_type, _equipment )
	return _ply:IsSuperAdmin();
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnedRagdoll( _ply, _model, ent )
   Desc: Called after the player spawned a ragdoll
-----------------------------------------------------------]]

function GM:PlayerSpawnedRagdoll( _ply, _model, _ent )
	_ply:AddCount( "ragdolls", _ent );
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnedProp( _ply, _model, ent )
   Desc: Called after the player spawned a prop
-----------------------------------------------------------]]

function GM:PlayerSpawnedProp( _ply, _model, _ent )
	_ply:AddCount( "props", _ent );
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnedEffect( _ply, _model, ent )
   Desc: Called after the player spawned an effect
-----------------------------------------------------------]]

function GM:PlayerSpawnedEffect( _ply, _model, _ent )
	_ply:AddCount( "effects", _ent );
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnedVehicle( _ply, ent )
   Desc: Called after the player spawned a vehicle
-----------------------------------------------------------]]

function GM:PlayerSpawnedVehicle( _ply, _ent )
	_ply:AddCount( "vehicles", _ent );
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnedNPC( _ply, ent )
   Desc: Called after the player spawned an NPC
-----------------------------------------------------------]]

function GM:PlayerSpawnedNPC( _ply, _ent )
	_ply:AddCount( "npcs", _ent );
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnedSENT( _ply, ent )
   Desc: Called after the player has spawned a SENT
-----------------------------------------------------------]]

function GM:PlayerSpawnedSENT( _ply, _ent )
	_ply:AddCount( "sents", _ent );
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawnedWeapon( _ply, ent )
   Desc: Called after the player has spawned a Weapon
-----------------------------------------------------------]]

function GM:PlayerSpawnedSWEP( _ply, _ent )
	-- This is on purpose..
	_ply:AddCount( "sents", _ent );
end;


--[[---------------------------------------------------------
   Name: gamemode:PlayerEnteredVehicle( player, vehicle, role )
   Desc: Player entered the vehicle fine
-----------------------------------------------------------]]

function GM:PlayerEnteredVehicle( _ply, _vehicle, _seat_number )
	_ply:SendHint( "VehicleView", 2 );
end;


--[[---------------------------------------------------------
	These are buttons that the client is pressing. They're used
	in Sandbox mode to control things like wheels, thrusters etc.
-----------------------------------------------------------]]

function GM:PlayerButtonDown( _ply, _btn )
	numpad.Activate( _ply, _btn );
end;


--[[---------------------------------------------------------
	These are buttons that the client is pressing. They're used
	in Sandbox mode to control things like wheels, thrusters etc.
-----------------------------------------------------------]]

function GM:PlayerButtonUp( _ply, _btn )
	numpad.Deactivate( _ply, _btn );
end;
