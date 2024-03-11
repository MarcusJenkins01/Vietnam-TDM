GGS = GGS || {};
GGS.HitMarker = GGS.HitMarker || {};

GGS.HitMarker.Time = 0;

GGS.HitMarker.Display = function()
	local _hit_group = net.ReadInt( 5 );
	
	if ( _hit_group == HITGROUP_HEAD ) then
		LocalPlayer():EmitSound( "ggs/vgui/hitmarker_head.wav", 500, 100, 1, CHAN_STATIC );
	else
		LocalPlayer():EmitSound( "ggs/vgui/hitmarker.wav", 500, 100, 1, CHAN_STATIC );
	end;
	
	GGS.HitMarker.Time = CurTime() + 0.5;
end;

net.Receive( "GGS.HitMarker.Display", GGS.HitMarker.Display );

hook.Add( "HUDPaint", "GGS.HitMarker.Draw", function()
	local _time_left = GGS.HitMarker.Time - CurTime();
	
	if _time_left > 0 then
		local _center_x = ScrW() / 2;
		local _center_y = ScrH() / 2;
		local _w, _h = 16, 16;
		
		surface.SetDrawColor( 255, 255, 255, 255 * math.min( 1, ( _time_left / 0.1 ) ) );
		
		surface.DrawLine( _center_x - _w, _center_y - _h, _center_x - ( _w * 0.35 ), _center_y - ( _h * 0.35 ) );
		surface.DrawLine( _center_x + _w, _center_y - _h, _center_x + ( _w * 0.35 ), _center_y - ( _h * 0.35 ) );
		
		surface.DrawLine( _center_x - _w, _center_y + _h, _center_x - ( _w * 0.35 ), _center_y + ( _h * 0.35 ) );
		surface.DrawLine( _center_x + _w, _center_y + _h, _center_x + ( _w * 0.35 ), _center_y + ( _h * 0.35 ) );
	end;
end );
