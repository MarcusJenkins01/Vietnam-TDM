local _meta = FindMetaTable( "Player" );

_meta.HasGGSRadioOn = function( self )
	return self:GetNWBool( "GGS.HasRadioOn", false );
end;
