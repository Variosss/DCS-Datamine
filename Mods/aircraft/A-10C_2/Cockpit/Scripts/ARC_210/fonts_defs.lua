dofile("Scripts\\Plane\\Cockpit\\tools.lua")

function get_font_description_common(fonttable, fontname)
	return fonttable[fontname].texture,
	fonttable[fontname].table[1],		--rows
	fonttable[fontname].table[2],	    --columns
	fonttable[fontname].resolution[1],
	fonttable[fontname].resolution[2],
	fonttable[fontname].default[1],
	fonttable[fontname].default[2],
	fonttable[fontname].chars
end
