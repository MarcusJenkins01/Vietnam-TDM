local BlockTeamKill = function( _victim, _attacker )
	if _victim:IsBot() then return true; end;
	
	if IsValid( _attacker ) and _attacker:IsPlayer() and ( _victim != _attacker ) then
		local _victim_team = _victim:Team();
		local _attacker_team = _attacker:Team();
		
		if ( _victim_team == _attacker_team ) then return false; end;
	end;
end;

hook.Add( "PlayerShouldTakeDamage", "BlockTeamKill", BlockTeamKill );
