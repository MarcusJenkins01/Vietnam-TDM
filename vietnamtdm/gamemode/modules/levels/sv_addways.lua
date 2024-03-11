GGS = GGS || {};
GGS.Levels = GGS.Levels || {};

-- include( "ggs_levels/config/sh_ranks.lua" );

local _meta = FindMetaTable( "Player" );

_meta.GetTotalXP = function( self )
	return self:GetNWInt( "GGS.LevelXP", 100 );
end;

_meta.GetLevel = function( self )
	local _xp = self:GetTotalXP();
	local _level = math.floor( _xp / 100 );
	
	return _level;
end;

_meta.GetXPToNextLevel = function( self )
	local _level = self:GetLevel();
	local _total_xp = self:GetTotalXP();
	
	local _remaining_xp = _total_xp - ( _level * 100 );
	
	return _remaining_xp;
end;

_meta.GetRank = function( self )
	local _player_level = self:GetLevel();
	
	local _last_rank = GGS.Levels.Ranks[1];
	
	for _rank_level, _rank in SortedPairs( GGS.Levels.Ranks ) do
		if _player_level == _rank_level then
			return _rank;
		elseif _player_level > _rank_level then
			_last_rank = _rank;
		elseif _player_level < _rank_level then
			return _last_rank
		end;
	end;
	
	return GGS.Levels.Ranks[1];
end;
