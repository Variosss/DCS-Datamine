
function makeBoxVerts(x_min, x_max, y_min, y_max)
	--return {{x_min, y_min}, {x_min, y_max}, {x_max, y_max}, {x_max, y_min}}
	return {{x_min, y_max}, {x_max, y_max}, {x_max, y_min}, {x_min, y_min}}
end

function makeEllipseVerts(num_points, radius, ellipse_k)
	local step = math.rad(360.0 / num_points)

	local ell_k = ellipse_k or 1
	
	local verts = {}
	for i = 1, num_points do
		-- making an ellipse
		verts[i] = { radius * math.cos(i * step), radius / ell_k * math.sin(i * step)}
	end
	
	return verts
end

function addPlaceholder__Raw(name, init_pos, controllers, collimated)
	local placeholder       		= CreateElement "ceSimple"
	placeholder.name        		= name
	local init_pos 					= init_pos or {0, 0}
	placeholder.init_pos    		= {init_pos[1], init_pos[2], 0}
	placeholder.collimated  		= collimated or false
	
	if controllers ~= nil then
		placeholder.controllers		= controllers
	end
	
	Add(placeholder)
	return placeholder
end
