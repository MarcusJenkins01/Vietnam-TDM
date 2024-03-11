GGS = GGS || {};

util.AddNetworkString( "GGS.ToggleRadio" );

local _meta = FindMetaTable( "Player" );

_meta.ToggleGGSRadio = function( self )
	local _current_value = self:HasGGSRadioOn();
	self:SetNWBool( "GGS.HasRadioOn", !_current_value );
end;

local _max_talk_distance_sqr = 500 ^ 2;

GGS.VoiceProximityCheck = function( _listener, _talker )
	if ( _listener:Team() == _talker:Team() ) and _listener:HasGGSRadioOn() and _talker:HasGGSRadioOn() then
		return true, true;
	elseif _listener:GetPos():DistToSqr( _talker:GetPos() ) <= _max_talk_distance_sqr then
		return true, true;
	end;
	
	return false, true;
end;

hook.Add( "PlayerCanHearPlayersVoice", "GGS.VoiceProximityCheck", GGS.VoiceProximityCheck );

net.Receive( "GGS.ToggleRadio", function( _len, _ply )
	_ply:ToggleGGSRadio();
end );
