concommand.Add( "toggle_radio", function()
	if LocalPlayer():HasGGSRadioOn() then
		surface.PlaySound( "ggs/vgui/radio_off.wav" );
	else
		surface.PlaySound( "ggs/vgui/radio_on.wav" );
	end;
	
	net.Start( "GGS.ToggleRadio" );
	net.SendToServer();
end );

hook.Add( "HUDPaint", "GGS.RadioSystemHUD", function()
	draw.SimpleText( "RADIO: " .. ( LocalPlayer():HasGGSRadioOn() and "ON" or "OFF" ), GGS.GetFont( 30 ), 10, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT );
	
	if LocalPlayer():HasGGSRadioOn() and LocalPlayer():IsSpeaking() then
		draw.SimpleText( "Speaking...", GGS.GetFont( 24 ), 10, 32 * ( ScrH() / 1080 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT );
	else
		draw.SimpleText( ( input.LookupBinding( "toggle_radio", true ) and "Press " .. string.upper( input.LookupBinding( "toggle_radio" ) ) .. " to toggle" ) or 'Bind "toggle_radio" to a button to use', GGS.GetFont( 20 ), 10, 32 * ( ScrH() / 1080 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT );
	end;
end );
