--[[------------
  Create fonts
------------]]--

local _font_sizes = { 256, 128, 75, 65, 55, 45, 40, 36, 30, 28, 27, 24, 21, 18, 16, 14, 8 };

-- Create all the fonts for each size specified above
for _, _font_size in pairs( _font_sizes ) do
	surface.CreateFont( "GGS.Font." .. _font_size, {
		font = "Patua One",
		-- font = "Germania One",
		size = _font_size,
		antialias = true
	} );
end;

GGS.GetFont = function( _size )
	local _screen_ratio = ScrW() / 1920;
	_size = _size * _screen_ratio;
	
	local _closest_size;
	local _diff;
	
	for _, _font_size in pairs( _font_sizes ) do
		if !_diff or math.abs( _font_size - _size ) < _diff then
			_closest_size = _font_size;
			_diff = _font_size - _size;
		end;
	end;
	
	local _font = "GGS.Font." .. _closest_size;
	
	return _font;
end;


