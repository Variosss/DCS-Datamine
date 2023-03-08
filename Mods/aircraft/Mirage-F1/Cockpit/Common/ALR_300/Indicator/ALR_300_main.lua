dofile(LockOn_Options.script_path.."../../Common/ALR_300/Indicator/ALR_300_tools.lua")

do
	--[[
	do
		local aspect_adjustment 							= 1
		
		local w 											= 1.02
		local h 											= w * aspect_adjustment

		local ALR_300_template			 					= CreateElement "ceTexPoly"
		ALR_300_template.name								= "ALR_300_template"
		ALR_300_template.material		 					= MakeMaterial(LockOn_Options.script_path.."../../Common/Resources/IndicationTextures/ALR_300/template.tga", {255, 0, 0, 150})
		ALR_300_template.vertices		 					= makeBoxVerts(-w, w, -h, h)
		ALR_300_template.indices			 				= default_box_indices
		ALR_300_template.additive_alpha   					= true
		ALR_300_template.tex_coords		 					= {{0, 0}, {1, 0}, {1, 1}, {0, 1}}
		ALR_300_template.init_pos        					= {-0.01, 0.01}
		Add(ALR_300_template)
	end
	
	local material 										= MakeMaterial("<ALR_LINE>", {200, 50, 200, 255})

	local line_len										= 1
	local line_len_half									= line_len * 0.5
	
	local function addLn(name, pos, rot)
		local ALR_300_dbg_ln           					= CreateElement "ceMeshPoly"
		ALR_300_dbg_ln.name   		  					= name
		ALR_300_dbg_ln.primitivetype   					= "lines"
		ALR_300_dbg_ln.vertices        					= {{0, -line_len_half}, {0, line_len_half}}
		ALR_300_dbg_ln.indices         					= {0, 1}
		ALR_300_dbg_ln.material        					= material
		ALR_300_dbg_ln.init_pos        					= pos
		ALR_300_dbg_ln.init_rot        					= rot
		ALR_300_dbg_ln.collimated      					= false
		Add(ALR_300_dbg_ln)
	end
	
	local ctr_pos = {0, 0}
	--addLn("ALR_300_dbg_line_ctr_1", ctr_pos, {0})
	--addLn("ALR_300_dbg_line_ctr_2", ctr_pos, {90})
	
	local ln_offset_far = 0.517
	addLn("ALR_300_dbg_line_far_left", {-ln_offset_far, 0}, {0})
	addLn("ALR_300_dbg_line_far_right", {ln_offset_far, 0}, {0})
	addLn("ALR_300_dbg_line_far_top", {0, ln_offset_far}, {90})
	addLn("ALR_300_dbg_line_far_bottom", {0, -ln_offset_far}, {90})
	
	local ln_offset_near = 0.1
	addLn("ALR_300_dbg_line_near_left", {-ln_offset_near, 0}, {0})
	addLn("ALR_300_dbg_line_near_right", {ln_offset_near, 0}, {0})
	addLn("ALR_300_dbg_line_near_top", {0, ln_offset_near}, {90})
	addLn("ALR_300_dbg_line_near_bottom", {0, -ln_offset_near}, {90})
	--]]
end

--ALR_300_AddText_Pos_Val("TSSSTT", nil, nil, nil, "CenterCenter", "T", 2)

-- Reference grid in the operating mode
do
	local line_width    = 0.035
	
	local function addSector(name, rot)
		local w_long 	= 0.55
		local h_long 	= w_long
		
		local w_short 	= 0.05
		local h_short 	= w_short
		
		local verts_sector = makeBoxVerts(-w_long, w_short, h_long, -h_short)
		local text_coord_px = 290
		
		ALR_300_AddTexuredElement(name, verts_sector, getTexParams(text_coord_px, text_coord_px), nil, nil, {rot})
	end
	
	drawDbgGeometry 	= false --true
	drawDbgMarkers  	= false --true

	for i = 0, 3 do
		addSector("sector_" .. i + 1, 90 * i)
	end
	
	drawDbgGeometry 	= false
	drawDbgMarkers  	= false
		
	local small_circle_half_side = 0.13
	local verts_small_circle = makeBoxVerts(-small_circle_half_side, small_circle_half_side, small_circle_half_side, -small_circle_half_side)
	
	ALR_300_AddTexuredElement("small_circle", verts_small_circle, getTexParams(388, 77))
	
	drawDbgGeometry 	= false
	drawDbgMarkers  	= false
	
	local function addLine(name, rot, pos)
		local h_long 	= 0.85
		local verts_line = makeBoxVerts(-line_width, line_width, line_width, -h_long)
		
		ALR_300_AddTexuredElement(name, verts_line, getTexParams(488, 24), nil, pos, {rot})
	end
	
	drawDbgGeometry 	= false
	drawDbgMarkers  	= false
	
	local line_shift    = 0.11
	
	for i = 0, 3 do
		local angle = 90 * i
		local angle_rad = math.rad(angle)

		addLine("line_" .. i + 1, angle, {line_shift * math.sin(angle_rad), -line_shift * math.cos(angle_rad)})
	end
	
	drawDbgGeometry 	= false
	drawDbgMarkers  	= false
	
	local function addTick(name, rot, pos)
		local h_long 	= 0.045
		local verts_tick = makeBoxVerts(-line_width, line_width, line_width, -h_long)
		
		ALR_300_AddTexuredElement(name, verts_tick, getTexParams(24, 327), nil, pos, {rot})
	end
	
	drawDbgGeometry 	= false
	drawDbgMarkers  	= false
	
	local tick_shift    = 0.51
	
	for i = 0, 11 do
		local angle = 30 * i
		
		if angle % 90 ~= 0 then
			
			local angle_rad = math.rad(angle)
			addTick("tick_" .. i + 1, angle + 180, {tick_shift * math.sin(angle_rad), -tick_shift * math.cos(angle_rad)})
		end
	end
	
	drawDbgGeometry 	= false
	drawDbgMarkers  	= false
end

for i = 1, 16 do
	local threatPlaceholder = addPlaceholder("threatPlaceholder_"..i, nil, {{"threatIsValid", i - 1}, {"threatBlink", i - 1}, {"threatPos", i - 1}})
	
	-- Normal symbols display
	
	local threatPlaceholderNormal = addPlaceholder("threatPlaceholderNormal_"..i, nil, {{"displayDetailedInfo", 0}})
	threatPlaceholderNormal.parent_element = threatPlaceholder.name
	
	local threatSymbolNormal = ALR_300_AddText_Pos_Formats("threatSymbolNormal_"..i, {{"threatSymbol", i - 1, 0}}, nil, nil, "CenterCenter", {"%s"}, 2)
	threatSymbolNormal.parent_element = threatPlaceholderNormal.name
	
	-- Detailed symbols display
	
	local threatPlaceholderDetailed = addPlaceholder("threatPlaceholderDetailed_"..i, nil, {{"displayDetailedInfo", 1}})
	threatPlaceholderDetailed.parent_element = threatPlaceholder.name
	
	local threatSymbolDetailed = ALR_300_AddText_Pos_Formats("threatSymbolDetailed_"..i, {{"threatSymbol", i - 1, 1}}, nil, nil, "CenterCenter", {"%s\nSC", "%s\nLO", "%s\nPD", "%s\nCW"}, 1)
	threatSymbolDetailed.parent_element = threatPlaceholderDetailed.name
	
end
