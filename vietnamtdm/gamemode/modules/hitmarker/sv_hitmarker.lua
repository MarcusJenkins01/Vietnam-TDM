GGS = GGS || {};
GGS.HitMarker = GGS.HitMarker || {};

util.AddNetworkString( "GGS.HitMarker.Display" );

GGS.HitMarker.Times = {};

GGS.HitMarker.OnDamaged = function( _ent, _dmg_info, _took_damage )
	if _ent and _ent:IsPlayer() and _took_damage then
		local _last_hit_group = _ent:LastHitGroup();
		local _attacker = _dmg_info:GetAttacker();
		
		if IsValid( _attacker ) and _attacker:IsPlayer() then
			local _next_call_allowed = GGS.HitMarker.Times[_attacker] or CurTime();
			
			if ( _next_call_allowed - CurTime() ) <= 0 then
				net.Start( "GGS.HitMarker.Display" );
					net.WriteInt( _last_hit_group, 5 );
				net.Send( _attacker );
				
				GGS.HitMarker.Times[_attacker] = CurTime() + 0.4 - FrameTime();
			end;
		end;
	end;
end;

hook.Add( "PostEntityTakeDamage", "GGS.HitMarker.OnDamaged", GGS.HitMarker.OnDamaged );
