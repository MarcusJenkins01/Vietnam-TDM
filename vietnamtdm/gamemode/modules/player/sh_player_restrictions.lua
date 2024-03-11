--[[---------------------------------------------------------
	Handle no clip restrictions
-----------------------------------------------------------]]

function GM:PlayerNoClip( _ply, _desired_state )
	if ( _desired_state == false ) then
		return true;
	elseif _ply:IsAdmin() then
		return true;
	end;
end;


--[[---------------------------------------------------------
	Disable context menu actions
-----------------------------------------------------------]]

hook.Add( "CanProperty", "GGS.BlockContextMenuActions", function( _ply, _property, _ent )
	return _ply:IsSuperAdmin();
end )
