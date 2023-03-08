dofile(LockOn_Options.common_script_path.."elements_defs.lua")

tex_scale = 0.35
pitch_K = 0.1062



TA_text_pos_y = 0.798
interline     = 0.686 - 0.798


use_mipfilter = true



HUD_FOV_LEVEL = 2
HUD_DEFAULT_LEVEL = HUD_FOV_LEVEL + 1

drawDbgGeometry = false
drawDbgMarkers 	= false

function AddWithDefaultClip(obj)
	obj.h_clip_relation = h_clip_relations.COMPARE
    obj.level 			= HUD_DEFAULT_LEVEL
	Add(obj)
end


--[[
  SetScale(MILLYRADIANS)
	next elements will be scaled in millyrads
  SetScale(METERS)
        next elements will be scaled in meters
  SetScale(FOV)
        and again in FOV parts
--]]

SetScale(FOV) -- MILLIRADIANS

--recalibrated for new logic in collimator

bird_position 				  = {0,-pitch_K * math.rad(10)/GetScale(),0}
vertical_displacement 		  = bird_position[1] - 0.517


heading_tape_vert_pos	      = 0.97


texture_size = 36.12

diamond_x_size = 0.03
diamond_y_size = diamond_x_size




piper_center_x = 27.8 / texture_size
piper_center_y = 5.38 / texture_size
piper_size     = 6.14 / texture_size - piper_center_y

piper_tick_vertices = {{-0.1*(piper_size/tex_scale ), 0.9 * (piper_size/tex_scale)},
						{-0.1*(piper_size/tex_scale ), 1.3 * (piper_size/tex_scale)},
						{ 0.1*(piper_size/tex_scale ), 1.3 * (piper_size/tex_scale)},
						{ 0.1*(piper_size/tex_scale ), 0.9 * (piper_size/tex_scale)}
					  }

function addPlaceholder(name, init_pos, controllers)
	local placeholder       		= CreateElement "ceSimple"
	placeholder.name        		= name
	init_pos 						= init_pos or {0, 0}
	placeholder.init_pos    		= {init_pos[1], init_pos[2], 0}
	placeholder.collimated  		= true
	
	if controllers ~= nil then
		placeholder.controllers		= controllers
	end
	
	Add(placeholder)
	return placeholder
end

function add_piper(name, controller)
	local piper				= create_HUD_element("ceTexPoly")
	piper.name				= name
	piper.vertices			= {{-piper_size/tex_scale, -piper_size/tex_scale}, 
							   {-piper_size/tex_scale, 1.32*piper_size/tex_scale},
							   {piper_size/tex_scale,  1.32*piper_size/tex_scale},
							   {piper_size/tex_scale, -piper_size/tex_scale}
							  }
	piper.indices			= default_box_indices
	piper.material			= "INDICATION_HUD_KA50"
	piper.tex_params		= {piper_center_x, piper_center_y, tex_scale, tex_scale}
	piper.controllers		= controller
	AddWithDefaultClip(piper)
	return piper
end					

function add_piper_distance_sector_basic(name, parent,controls)
local distance_sector			= create_HUD_element("ceHWSector")
	distance_sector.name			= name
	distance_sector.vertices1		= {{-0.007, -0.076}, {-0.007, 0.076}, {0.076, 0.076}, {0.076, -0.076}}
	distance_sector.tex_params1		= {30.0 / texture_size, piper_center_y, tex_scale, tex_scale}
	distance_sector.vertices2		= {{-0.076, -0.076}, {-0.076, 0.076}, {0.007, 0.076}, {0.007, -0.076}}
	distance_sector.tex_params2		= {29.81 / texture_size, piper_center_y, tex_scale, tex_scale}
	distance_sector.maskvertices	= {{-0.076, -0.076}, {-0.076, 0.076}, {0.0, 0.076}, {0.0, -0.076}}
	distance_sector.indices			= default_box_indices
	distance_sector.material		= "INDICATION_HUD_KA50"
	distance_sector.controllers     = controls
	distance_sector.parent_element	= parent
	distance_sector.minangle		= math.rad(2.0)
	distance_sector.maxangle		= math.rad(358.0)
	AddWithDefaultClip(distance_sector)
	return distance_sector
end

function add_piper_range_tick_basic(name, parent, init_angle,controls)
local tick				= create_HUD_element("ceTexPoly")
	tick.name				= name
	tick.vertices			= piper_tick_vertices
	tick.indices			= default_box_indices
	tick.material		    = "INDICATION_HUD_KA50"
	tick.tex_params			= {28.77 / texture_size, piper_center_y, tex_scale, tex_scale}
	tick.init_rot			= {init_angle, 0.0, 0.0}
	tick.parent_element		= parent
	tick.controllers		= controls
	AddWithDefaultClip(tick)
	return tick
end

function add_piper_DLZ_tick_basic(name, parent,controls)
local tick				    = create_HUD_element("ceTexPoly")
	tick.name				= name
	tick.vertices			= piper_tick_vertices
	tick.indices			= default_box_indices
	tick.material		    = "INDICATION_HUD_KA50"
	tick.tex_params			= {28.77 / texture_size, piper_center_y, tex_scale, tex_scale}
	tick.parent_element		= parent
	tick.controllers		= controls
	AddWithDefaultClip(tick)
	return tick
end

function add_piper_DLZ_tick(name, parent, tick_number ,max_distance)
	return add_piper_DLZ_tick_basic(name, parent,{{"show_piper_launch_zone"},
												  {"piper_dynamic_launch_zone", max_distance, (math.pi * 2.0) / max_distance , tick_number}})
end

function add_piper_distance_sector(name, parent)
	return add_piper_distance_sector_basic(name, parent,{{"show_piper_launch_zone"}, {"piper_distance_sector", 10000.0, (math.pi * 2.0) / 10000.0}})
end

function add_piper_range_tick(name, parent, init_angle)
	return add_piper_range_tick_basic(name, parent, init_angle,{{"show_piper_launch_zone"}})
end

function create_HUD_element(element_type)
	local element			= CreateElement(element_type)
	element.additive_alpha	= true
	element.collimated		= true
	element.use_mipfilter	= use_mipfilter
	
	return element
end

function add_debug_marker(name, init_pos, span_x, span_y, label_txt, label_shift)
	if drawDbgMarkers then
		
		local material = MakeMaterial("<REF_LINES>", {200, 50, 200, 255})
		local font 	   = MakeFont({used_DXUnicodeFontData = "font_dejavu_lgc_sans_22_white"}, {200, 50, 200, 255})

		-- cross at the marker position
		
		local cross           = CreateElement "ceMeshPoly"
		cross.name   		  = "dbg_ctr_".. (name or label_txt)
		cross.primitivetype   = "lines"
		cross.vertices        = {{-0.5 * span_x, 0.0}, {0.5 * span_x, 0.0}, {0, -0.5 * span_y}, {0, 0.5 * span_y}}
		cross.indices         = {0, 1, 2, 3}
		cross.material        = material
		cross.init_pos        = init_pos or {0, 0}
		cross.collimated      = true
		Add(cross)
		
		-- marker label text
		
		if label_txt ~= nil then
			local label			  = CreateElement "ceStringPoly"
			label.name   		  = "dbg_lbl_".. (name or label_txt)
			label.alignment		  = "LeftCenter"
			label.value			  = label_txt or name or "<REF>"
			label.material		  = font
			label.stringdefs	  = {0.01, 0.003, 0, 0}
			label.use_mipfilter   = true
			
			if label_shift ~= nil then
				label.init_pos        = label_shift
			else
				label.init_pos        = {0.5 * span_x, 0}
			end
			
			label.parent_element  = cross.name
			label.collimated	  = true
			Add(label)
		end
		
		return cross
	end
	
	return nil
end

function addDebugGeometryFor(element)
	if drawDbgGeometry then
		local dbg_box 			= CreateElement "ceMeshPoly"
		dbg_box.name 			= element.name .. "_dbg_box"
		dbg_box.primitivetype 	= "triangles"
		dbg_box.vertices 		= element.vertices
		dbg_box.indices			= default_box_indices
		dbg_box.material		= "RED_DBG"
		dbg_box.isdraw			= true
		dbg_box.change_opacity	= false
		dbg_box.collimated		= true
		dbg_box.h_clip_relation = h_clip_relations.NONE
	
		dbg_box.parent_element  = element.name
	
		Add(dbg_box)
		
		if drawDbgMarkers then
			local dbg_marker = add_debug_marker(element.name.."_dbg_marker_ctr", {0, 0}, 0.2, 0.2)
			dbg_marker.parent_element  = dbg_box.name
			dbg_marker.h_clip_relation = h_clip_relations.NONE
		end
	end
end

function addDebugGeometryForced(element)
	drawDbgGeometry 			= true
	drawDbgMarkers 				= true
	
	addDebugGeometryFor(element)
	
	drawDbgMarkers 				= false
	drawDbgGeometry 			= false
end

default_eye_distance = 0.58542335
hud_zone = default_eye_distance*math.tan(math.rad(11.2))
