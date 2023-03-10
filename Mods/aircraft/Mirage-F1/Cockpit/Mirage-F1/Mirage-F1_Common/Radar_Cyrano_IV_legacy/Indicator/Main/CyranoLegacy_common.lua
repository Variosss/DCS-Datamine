dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_tools.lua")

local dspl_sz = display_side_sz

local use_MT_render = true

local rdrRenderTex

if use_MT_render ~= true then
	rdrRenderTex = addRadarRenderTex("rdrRenderTex", dspl_sz, dspl_sz, bake_scale / dspl_sz, {0, 0}, nil, nil, "BUFF_LEGACY_RADAR_1")
	--rdrRenderTex.h_clip_relation = h_clip_relations.NULL
else
	local rdrRenderTexTest = addRadarRenderTex("rdrRenderTex", dspl_sz, dspl_sz, bake_scale / dspl_sz, {0, 0}, nil, nil, "BUFF_LEGACY_RADAR_1")
	rdrRenderTexTest.h_clip_relation = h_clip_relations.NULL
	rdrRenderTexTest.isvisible = false
	
	--rdrRenderTex = addStandardRenderTex("rdrRenderTexMT", dspl_sz, dspl_sz, bake_general_scale / dspl_sz, {0, 0}, MakeMaterial("BUFF_LEGACY_RADAR_MT", {255, 255, 255, 255}))
	rdrRenderTex = addStandardRenderTex("rdrRenderTexMT", dspl_sz, dspl_sz, 1 / dspl_sz, {0, 0}, MakeMaterial("BUFF_LEGACY_RADAR_MT", {255, 255, 255, 255}))
	
	--[[
	do
		local half_w = dspl_sz / 2
		local half_h = dspl_sz / 2

		local verts = {{-half_w,  half_h},
					   { half_w,  half_h},
					   { half_w, -half_h},
					   {-half_w, -half_h}}

		drawDbgGeometry = false --true
		
		addDebugGeometry("rdrRenderTexBox", nil, verts)
		
		drawDbgGeometry = false
	end
	--]]
end

local rect_sz = display_area_radius / bake_scale
--local rect_sz = display_area_radius
	
--[[
do
	--local function makeBoxVerts(x_min, x_max, y_min, y_max)
	--	return {{x_min, y_min}, {x_min, y_max}, {x_max, y_max}, {x_max, y_min}}
	--end
	
	local s_bake_test							= CreateElement "ceTexPoly"
	s_bake_test.name							= "s_bake_pic"
	s_bake_test.material		 				= MakeMaterial("RadarBakedSymbology", RadarLegacy_GREEN)
	s_bake_test.vertices		 				= makeBoxVerts(-rect_sz, rect_sz, -rect_sz, rect_sz)
	s_bake_test.indices							= default_box_indices
	s_bake_test.additive_alpha   				= additive_alpha
	s_bake_test.tex_coords						= {{0, 0}, {1, 0}, {1, 1}, {0, 1}}
	s_bake_test.h_clip_relation					= h_clip_relations.NULL --determineClipRelation(h_clip_relations.COMPARE)
	s_bake_test.level							= INDICATOR_DEFAULT_LEVEL
	s_bake_test.init_rot						= {-90}
	s_bake_test.parent_element  				= boresightPos.name
	Add(s_bake_test)
end
--]]

local displayR = false --true
local shifted = true --false

local drawOne = false --true

local drawRectAll = true --false
local drawRect = 1
local drawRect2 = 2

local displayRectAll = false
local displayRect = 1
local displayRect2 = 3

if displayR then
	
	local Rshift 								= 0
	
	if shifted == true then
		Rshift 									= -10
	end
	
	local R_origin								= addPlaceholder("R_origin", {Rshift * bake_scale, 0})
	
	if shifted == true then
		local verts    = {{-display_area_radius * bake_scale, -display_area_radius * bake_scale},
		 			      { display_area_radius * bake_scale, -display_area_radius * bake_scale},
						  { display_area_radius * bake_scale, display_area_radius * bake_scale},
						  {-display_area_radius * bake_scale, display_area_radius * bake_scale}}
		local inds     = default_box_indices

		
		local displayR_back		  	  			= CreateElement "ceMeshPoly"
		displayR_back.collimated	  			= false
		displayR_back.vertices        			= verts              
		displayR_back.indices         			= inds
		displayR_back.name 			  			= "displayR_back"
		displayR_back.material		  			= "RADAR_BACKGROUND"
		displayR_back.h_clip_relation 			= h_clip_relations.NULL
		displayR_back.parent_element  			= R_origin.name
		Add(displayR_back)
	end

	--[[
	do	
		drawDbgMarkers 					= true
		local lineK 					= 10
		local dbg_ctrline 				= add_debug_marker("dbg_ctrline", {0, 0}, dbg_marker_span, dbg_marker_span * lineK)
	end
	--]]
	
	local RK = a_r_num * 0.5
	--local rect_sz2 = rect_sz * bake_scale * AA_azimuth_zone_az_scale / RK
	local rect_sz2 = AA_azimuth_zone_half / RK
	
	--rect_sz2 = rect_sz * bake_scale * AA_azimuth_zone_az_scale / RK
	--rect_sz = display_area_radius / bake_scale
	
	--local ctr_x = rect_sz / RK * AA_azimuth_zone_az_scale
	local ctr_x = rect_sz2
	local ip_pos = ctr_x * (RK - 1)
	local ip_neg = -ip_pos
	
	for i = 1, a_r_num do
	--for i = 1, 8 do
		
		if drawOne == true and i == 3 or drawOne == false then
			
			if drawRectAll == true or drawRect == i or drawRect2 == i then
				local r_bake_test						= CreateElement "ceTexPoly"
				r_bake_test.name						= "r_bake_pic_"..i
				r_bake_test.material		 			= MakeMaterial("RadarContacts"..i, RadarLegacy_GREEN)
				
				if drawOne then
					r_bake_test.vertices		 			= makeBoxVerts(-rect_sz, rect_sz, -rect_sz, rect_sz)
				else
					r_bake_test.vertices		 			= makeBoxVerts(-rect_sz2 * a_o, rect_sz2 * a_o, -rect_sz, rect_sz)
				end
				
				r_bake_test.indices						= default_box_indices
				r_bake_test.additive_alpha   			= additive_alpha
				r_bake_test.tex_coords					= {{0, 0}, {1, 0}, {1, 1}, {0, 1}}
				r_bake_test.h_clip_relation				= h_clip_relations.NULL --determineClipRelation(h_clip_relations.COMPARE)
				r_bake_test.level						= INDICATOR_DEFAULT_LEVEL
				
				if drawOne == false then
					local pos_x
					if i - 1 < RK - 0.5 then
						pos_x = ip_neg + (i - 1) * ctr_x * 2
					else
						pos_x = ip_pos - (i - 1 - RK) * ctr_x * 2
					end
					
					r_bake_test.init_pos					= {pos_x, 0}
				end
				
				r_bake_test.parent_element  			= R_origin.name
				
				local side
				if i > math.floor(RK) then
					side = 1
				else
					side = 0
				end
						
				r_bake_test.controllers					= {{"radarScanDir", side}, {"bakeIsNotFrozen", i - 1}}
				
				Add(r_bake_test)
				
				if displayRectAll == true or i == displayRect or i == displayRect2 then
					local r_bake_poly					= CreateElement "ceMeshPoly"
					r_bake_poly.name					= "r_bake_poly_"..i
					r_bake_poly.material				= "DBG_RED"
					r_bake_poly.vertices				= r_bake_test.vertices
					r_bake_poly.indices					= r_bake_test.indices
					r_bake_poly.additive_alpha			= r_bake_test.additive_alpha
					r_bake_poly.h_clip_relation			= r_bake_test.h_clip_relation
														
					r_bake_poly.init_pos				= r_bake_test.init_pos
					r_bake_poly.init_rot				= r_bake_test.init_rot
					r_bake_poly.parent_element			= r_bake_test.parent_element
					Add(r_bake_poly)
				end
			end
			
		end
		
	end
end

-- Aircraft + horizon symbols

local acft_silhouette_origin		= addPlaceholder("acft_silhouette_origin", {0, -display_area_radius})

local acft_silhouette				= RdrAddLine("acft_silhouette", 1.9, 3.8, getTexParams(108, 39), {{"radarAircraftSymbolVertPos"}})
acft_silhouette.parent_element 		= acft_silhouette_origin.name

local horizon 						= RdrAddLine("horizon", 2, 4, getTexParams(115, 21), {{"radarHorizonSymbol"}})
horizon.parent_element				= acft_silhouette.name
