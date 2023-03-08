dofile(LockOn_Options.script_path.."Scorpion_HMCS/Indicator/HMCS_definitions.lua")

local dbg_group_test_pos = {-45, 65}

local render_init_sz = 2 * 65 --math.rad(200) / 1000
local render_init_half_sz = render_init_sz / 2

local tgp_video_origin = addPlaceholder("tgp_video_origin", {-130, -110}, {{"is_symbol_occluded", -1, -1}, {"tgp_video_enable"}})

local RMFCD_video_render			= CreateElement "ceTexPoly"
RMFCD_video_render.name				= "RMFCD_video_render_picture"
RMFCD_video_render.material		 	= MakeMaterial("RMFCD_video_render", {0, 255, 0, 255})
RMFCD_video_render.vertices		 	= makeBoxVerts(-render_init_half_sz, render_init_half_sz, -render_init_half_sz, render_init_half_sz)
RMFCD_video_render.indices			= default_box_indices
RMFCD_video_render.additive_alpha   = true
RMFCD_video_render.tex_coords		= {{0, 0}, {1, 0}, {1, 1}, {0, 1}}
RMFCD_video_render.h_clip_relation	= determineClipRelation(h_clip_relations.COMPARE)
RMFCD_video_render.level			= HMCS_DEFAULT_LEVEL
RMFCD_video_render.init_rot			= {-90}
RMFCD_video_render.parent_element   = tgp_video_origin.name
Add(RMFCD_video_render)

local airspeedAltititudeY = 0

-- Airspeed
AddText_Pos_Formats("Airspeed_Numerics", 
			{{"is_symbol_occluded", PRFL_SYMB_AIRSPEED, -1}, {"airspeed_numerics_txt"}},
			{-100, airspeedAltititudeY}, 
			HMCS_DEFAULT_LEVEL,
			"RightCenter",
			{"XXX", "%3.0f", "%3.0fT", "%3.0fG"},
			3)

-- Barometric altitude
AddText_Pos_Formats("Barometric_Altitude_Numerics", 
			{{"is_symbol_occluded", PRFL_SYMB_BARO_ALTITUDE, -1}, {"barometric_altitude_numerics_txt"}},
			{120, airspeedAltititudeY}, 
			HMCS_DEFAULT_LEVEL,
			"RightCenter",
			{"XXXX", "%5.0f"},
			3)

local radarAltY = airspeedAltititudeY - 105

-- Radar altitude
AddText_Pos_Formats("Radar_Altitude_Numerics", 
			{{"is_symbol_occluded", PRFL_SYMB_RADAR_ALTITUDE, -1}, {"radar_altitude_numerics_txt"}}, 
			{120, radarAltY},
			HMCS_DEFAULT_LEVEL,
			"RightCenter",
			{"XXXXR", "%4.0fR"},
			2)

-- Aircraft heading
AddText_Pos_Formats("Aircraft_Heading_Numerics", 
			{{"is_symbol_occluded", PRFL_SYMB_A_C_HEADING, -1}, {"aircraft_heading_numerics_txt"}},
			{0, -130}, 
			HMCS_DEFAULT_LEVEL,
			"CenterCenter",
			{"XXX", "%03.0f"},
			2)

-- HMCS heading
AddText_Pos_Formats("HMCS_Heading_Numerics", 
			{{"is_symbol_occluded", PRFL_SYMB_HELMET_HEADING, -1}, {"HMCS_heading_numerics_txt"}},
			{0, 150}, 
			HMCS_DEFAULT_LEVEL,
			"CenterCenter",
			{"XXX", "%03.0f"},
			2)

--[[
-- G meter
AddText_Pos("G_Meter_Display_Numerics", 
			{{"is_symbol_occluded", -1, -1}, {"g_meter_display_txt"}},
			{-100, 80}, 
			HMCS_DEFAULT_LEVEL,
			"RightCenter",
			2)
]]

local HookInfoX = -95
local HookInfoY = radarAltY
local HookInfoYstep = 12

-- SOI indicator asterisk
AddText_Pos_Val("SOI_Indicator_Asterisk", 
			{{"is_symbol_occluded", PRFL_SYMB_SPI_INDICATOR, -1}, {"SOI_indicator_asterisk"}}, 
			{-100, HookInfoY + HookInfoYstep * 5 + 5},
			HMCS_DEFAULT_LEVEL,
			"RightCenter",
			"*",
			2)

local Hook_Text_Main_Origin = addPlaceholder("Hook_Text_Main_Origin", {HookInfoX, HookInfoY}, {{"is_symbol_occluded", PRFL_SYMB_HOOKSHIP, -1}, {"hook_text", 0}})

-- Hook bearing/range
local Hook_Bearing_Range = AddText_Pos_Formats("Hook_Bearing_Range", 
			{{"hook_text_bearing_range"}},
			{0, HookInfoYstep * 4},
			HMCS_DEFAULT_LEVEL,
			"RightCenter",
			{"%03d/%d"},
			2)
Hook_Bearing_Range.parent_element = Hook_Text_Main_Origin.name

-- Hook altitude
local Hook_Altitude = AddText_Pos_Formats("Hook_Altitude", 
			{{"hook_text_altitude"}},
			{0, HookInfoYstep * 3},
			HMCS_DEFAULT_LEVEL,
			"RightCenter",
			{"%5d"},
			2)
Hook_Altitude.parent_element = Hook_Text_Main_Origin.name

-- Hooked object type
local Hooked_Obj_Type = AddText_Pos_Formats("Hooked_Obj_Type", 
			{{"hook_text", 1}, {"hook_text_type"}},
			{0, HookInfoYstep * 2},
			HMCS_DEFAULT_LEVEL,
			"RightCenter",
			{"%s"},
			2)
Hooked_Obj_Type.parent_element = Hook_Text_Main_Origin.name

local Hook_Info_PPLI_Origin = addPlaceholder("Hook_Info_PPLI_Origin", {0, 0}, {{"hook_text", 2}})
Hook_Info_PPLI_Origin.parent_element = Hook_Text_Main_Origin.name

-- Hooked object or originator callsign
local Hooked_Obj_Callsign = AddText_Pos_Formats("Hooked_Obj_Callsign", 
			{{"hook_text_callsign"}},
			{0, HookInfoYstep},
			HMCS_DEFAULT_LEVEL,
			"RightCenter",
			{"%s"},
			2)
Hooked_Obj_Callsign.parent_element = Hook_Info_PPLI_Origin.name

-- Hooked object heading/ground speed
local Hooked_Obj_Heading_GndSpeed = AddText_Pos_Formats("Hooked_Obj_Heading_GndSpeed", 
			{{"hook_text_hdg_gnd_speed"}},
			{0, 0},
			HMCS_DEFAULT_LEVEL,
			"RightCenter",
			{"%03d/%03d"},
			2)
Hooked_Obj_Heading_GndSpeed.parent_element = Hook_Info_PPLI_Origin.name

--[[
-- Master Arm status
AddText_Pos_Formats("Master_Arm_Status", 
			{{"is_symbol_occluded", -1, -1}, {"master_arm_txt"}},
			{-100, -70},
			HMCS_DEFAULT_LEVEL,
			"RightCenter",
			{"SIM", "SAFE", "ARM"},
			2)
]]

-- Selected profile
AddText_Pos("Selected_Profile_Name", 
			{{"is_symbol_occluded", -1, -1}, {"selected_pro_name_or_brightness"}},
			{0, 50}, 
			HMCS_DEFAULT_LEVEL,
			"CenterCenter",
			3)

-- Debug center cross and Az/El display
local display_debugAzEl = false

if display_debugAzEl == true then
	-- cross
	
	local DBG_LOS_sz = 20
	local DBG_LOS_half_sz = DBG_LOS_sz / 2
	local DBG_LOS_verts = makeBoxVerts(-DBG_LOS_half_sz, DBG_LOS_half_sz, -DBG_LOS_half_sz, DBG_LOS_half_sz)
	
	local DBG_LOS_crosshair = AddTexuredElement("DBG_LOS_crosshair",
				DBG_LOS_verts,
				getTexParams(106, 174),
				nil,
				{},
				{},
				HMCS_DEFAULT_LEVEL)
	
	-- azimuth/elevation
	AddText_Pos("DBG_HMCS_AzEl", 
				{{"HMCS_AzEl_body_txt"}},
				{140, -140}, 
				HMCS_DEFAULT_LEVEL,
				"LeftCenter",
				2)
end
				
-- TODO: pitch ladder parts beyond +/-90 degrees
do
	do
		--local dbg_shift = 2 * (dbgLineParams.lineXend_px - dbgLineParams.lineXbegin_px) / pixelsPerMil
		
		addAllscrLine("Horizon_Line_Solid", solidLineParams, 0, 0, {{"is_symbol_occluded", -1, -1}, {"horizon_line", 0}})
		--addAllscrLine("Horizon_Line_Solid", dbgLineParams, dbg_shift, 0, {{"is_symbol_occluded", -1, -1}, {"horizon_line", 0}})
	end
	
	do
		local strokeMiddle_px = 18
		
		local ghostLineParams = {
			-- variable line texture coordinates
			lineXbegin_px 	= solidLineParams.lineXbegin_px,
			lineXend_px		= 492,
			lineY_px		= 491,
			
			-- mils
			lineEndLen		= solidLineParams.lineEndLen
		}
		
		local connectGap_px = strokeMiddle_px - ghostLineParams.lineXbegin_px
		
		--local dbg_shift = 2 * (ghostLineParams.lineXend_px - ghostLineParams.lineXbegin_px - connectGap_px * 2) / pixelsPerMil
				
		addAllscrLine("Horizon_Line_Ghost", ghostLineParams, 0, connectGap_px, {{"is_symbol_occluded", -1, -1}, {"horizon_line", 1}})
	end
	
	-- HELs origin
	local HELs_origin = addPlaceholder("HELs_origin", {0, 0}, {{"is_symbol_occluded", PRFL_SYMB_HMD_ELEV_LINES, -1}, {"pitch_ladder_pos"}})
	
	--local lineLen = (18 - 8) / pixelsPerMil	
	--add_debug_marker("LN_ORIG", horizon_line.init_pos, 20)
	--add_debug_marker("LN_END", {horizon_line.init_pos[1] + lineLen, horizon_line.init_pos[2]}, 20)
	--add_debug_marker("LN_END", {horizon_line.init_pos[1] - lineLen, horizon_line.init_pos[2]}, 20)

	local pitch_ln_width = 74
	local pitch_ln_half_sz = pitch_ln_width / 2
	local pitch_ln_height = 4.5
	
	local function AddPitchLine(line_name, tex_params, parent_name, index)
	
		local angle = index * 5
		
		local pitch_ln_verts
		if angle > 0 then
			pitch_ln_verts = makeBoxVerts(-pitch_ln_half_sz, pitch_ln_half_sz, -pitch_ln_height, lineWidth / 2)
		else
			pitch_ln_verts = makeBoxVerts(-pitch_ln_half_sz, pitch_ln_half_sz, -lineWidth / 2, pitch_ln_height)
		end
		
		local line = AddTexuredElement(line_name,
					pitch_ln_verts,
					tex_params,
					{{"pitch_line", index}},
					{0.0, angle * degToMil},
					{},
					HMCS_DEFAULT_LEVEL)

		line.parent_element = parent_name
		
		--local textHorizontalOffset = 41 -- 2/3 font size setting
		local textHorizontalOffset = 42 -- 3/4 font size setting
		
		local textVerticalPos
		if angle > 0 then
			textVerticalPos = -1.2
		else
			textVerticalPos = 0.8
		end
		
		local pitch_numerics_format
		if angle > 0 then
			if angle > 90 then
				angle = -angle + 180
			end
			
			pitch_numerics_format = "%02d"
		else
			if angle < -90 then
				angle = -angle - 180
			end
			
			pitch_numerics_format = "%03d"
		end
		
		local pitch_numerics_str = string.format(pitch_numerics_format, angle)
		
		local TextLeft = AddText_Pos_Val("txt_left_" .. line_name, 
					nil,
					{-textHorizontalOffset, textVerticalPos}, 
					HMCS_DEFAULT_LEVEL,
					"CenterCenter",
					pitch_numerics_str,
					1)
		
		TextLeft.parent_element = line.name
		TextLeft.value = pitch_value
		
		local TextRight = AddText_Pos_Val("txt_right_" .. line_name, 
					nil,
					{textHorizontalOffset, textVerticalPos}, 
					HMCS_DEFAULT_LEVEL,
					"CenterCenter",
					pitch_numerics_str,
					1)

		TextRight.parent_element = line.name
		TextRight.value = pitch_value
	end

	-- 5 to 90 with 5 degrees step, then 85, 80
	for i = 1, 20 do
		AddPitchLine("posit_pitch" .. string.format("%i", i),
					getTexParams(367, 26),
					HELs_origin.name,
					i)
					
		AddPitchLine("negat_pitch" .. string.format("%i", i),
					getTexParams(367, 58.5),
					HELs_origin.name,
					-1 * i)
	end

	--add_debug_marker("LN_ORIG", horizonLine.init_pos, 20)
	--add_debug_marker("LN_END", {horizonLine.init_pos[1] + lineLen, horizonLine.init_pos[2]}, 20)
end

-- Waypoints
addPlaceholder("Waypoints", nil, {{"updateMultipleSymbolsBuffer", 0}})

-- Datalink symbols
do
	local DL_areaMaskSz
	
	if large_TFOV == true then
		DL_areaMaskSz = largeTFOV_horizontal_sz_mil
	else
		DL_areaMaskSz = HMCS_horizontal_sz_mil
	end
	
	local DL_areaMaskVerts = makeCircleVerts(32, DL_areaMaskSz * 0.5)
	local DL_areaMaskInds = buildConvexPolyIndices(#DL_areaMaskVerts)
	
	local DL_areaOpenMask = openMaskArea("DL_areaOpenMask", DL_areaMaskVerts, nil, HMCS_DEFAULT_LEVEL)
	DL_areaOpenMask.indices = DL_areaMaskInds
	--DL_areaOpenMask.isvisible = true
	
	addPlaceholder("DL_symbols", nil, {{"updateMultipleSymbolsBuffer", 1}})
	
	local DL_areaCloseMask = closeMaskArea("DL_areaCloseMask", DL_areaMaskVerts, nil, HMCS_DEFAULT_LEVEL + 1)
	DL_areaCloseMask.indices = DL_areaMaskInds
end

local HLL_SLL_len = 28
local HLL_SLL_width = lineWidth --11
local HLL_SLL_arm = 2

-- Commented until we make sure it is applicable for HMCS
--[[
do
	-- Target Designator Cue
	
	local tdc_sz = 12
	local tdc_half_sz = tdc_sz / 2

	local tdc = AddTexuredElement("tdc",
				makeBoxVerts(-tdc_half_sz, tdc_half_sz, -tdc_half_sz, tdc_half_sz),
				getTexParams(171.5, 93),
				{{"is_symbol_occluded", -1, -1}, {"HUD_tdc_pos"}},
				{},
				{},
				HMCS_DEFAULT_LEVEL)
	
	--tdc.init_pos = {-30, -60}
	--tdc.isdraw = false
	
	local tdc_bearing_range_origin = addPlaceholder("tdc_bearing_range_origin", {0, 0}, {{"HUD_tdc_display_bearing_range"}})
	tdc_bearing_range_origin.parent_element = tdc.name
	
	local tdc_bearing = AddText_Pos("tdc_bearing", 
					{{"HUD_tdc_bearing_txt"}},
					{-tdc_half_sz, tdc_half_sz},
					HMCS_DEFAULT_LEVEL,
					"LeftBottom",
					2)

	tdc_bearing.parent_element = tdc_bearing_range_origin.name

	local tdc_range = AddText_Pos("tdc_range", 
					{{"HUD_tdc_range_txt"}},
					{-tdc_half_sz, -tdc_half_sz},
					HMCS_DEFAULT_LEVEL,
					"LeftTop",
					2)
					
	tdc_range.parent_element = tdc_bearing_range_origin.name
end
--]]

-- Hookship
local hookship_sz = 25
local hookship_half_sz = hookship_sz * 0.5
local hookship_verts = makeBoxVerts(-hookship_half_sz, hookship_half_sz, -hookship_half_sz, hookship_half_sz)

local hookship_mask_sz = hookship_sz - 3
local hookship_mask_half_sz = hookship_mask_sz * 0.5
local hookship_mask_verts = makeBoxVerts(-hookship_mask_half_sz, hookship_mask_half_sz, -hookship_mask_half_sz, hookship_mask_half_sz)

local hookship = AddTexuredElement("Hookship",
			hookship_verts,
			getTexParams(53, 261),
			{{"is_symbol_occluded", PRFL_SYMB_HOOKSHIP, -1}, {"hookship_pos"}},
			{},
			{},
			HMCS_DEFAULT_LEVEL)
			
--hookship.init_pos = {0, 50}
--hookship.init_pos = dbg_group_test_pos
--hookship.isdraw = false

do
	-- Fixed crosshair - HMD LOS
	local LOS_sz = 20
	local LOS_half_sz = LOS_sz / 2
	local LOS_verts = makeBoxVerts(-LOS_half_sz, LOS_half_sz, -LOS_half_sz, LOS_half_sz)
	
	-- Fixed part
	local LOS_crosshair = AddTexuredElement("LOS_crosshair",
				LOS_verts,
				getTexParams(106, 174),
				{{"is_symbol_occluded", PRFL_SYMB_CROSSHAIR, -1}},
				{},
				{},
				HMCS_DEFAULT_LEVEL)
	
	-- HDC caged indicator
	local HDC_caged_indicator = AddTexuredElement("HDC_caged_indicator",
				LOS_verts,
				getTexParams(175, 261),
				{{"is_symbol_occluded", PRFL_SYMB_HDC, -1}, {"designation_cue_kind", 1}},
				{},
				{},
				HMCS_DEFAULT_LEVEL)

	HDC_caged_indicator.parent_element = LOS_crosshair.name
	
	-- HDC (Helmet Designation Cue) + hook locator lines

	local HDC_origin = addPlaceholder("HDC_origin", {0, 0}, {{"is_symbol_occluded", PRFL_SYMB_HDC, -1}, {"designation_cue_pos"}})

	local HDC_sz = 22
	local HDC_half_sz = HDC_sz / 2
	local HDC_verts = makeBoxVerts(-HDC_half_sz, HDC_half_sz, -HDC_half_sz, HDC_half_sz)

	local HDC_slewed = AddTexuredElement("HDC_Slewed",
				HDC_verts,
				getTexParams(401, 175),
				{{"designation_cue_kind", 0}},
				{},
				{},
				HMCS_DEFAULT_LEVEL)

	HDC_slewed.parent_element = HDC_origin.name
	
	local HLL_SLL_lenTotal = HLL_SLL_len + HLL_SLL_arm
	
	local function addSolid_SLL_HLL(name, controllers, parent_name)
		-- SPI locator line when is originated from fixed cross. Has an offset (an 'arm') from the cross center.
		local line = AddTexuredElement(name,
						makeBoxVerts(-lineEndLen + HLL_SLL_arm, HLL_SLL_lenTotal + lineEndLen, -lineWidth / 2, lineWidth / 2),
						getTexParams(256 - pixelsPerMil * HLL_SLL_arm, 202),
						controllers,
						{},
						{},
						HMCS_DEFAULT_LEVEL)

		line.parent_element = parent_name
		
		return line
	end
	
	-- Open mask 1 - hookship rectangle. Hides the solid (short) HLL part when it overlaps the hookship rectangle.
	local HLL_opening_mask_placeholder = addPlaceholder("HLL_opening_mask_placeholder", nil, {{"hookship_pos"}})
	local HLL_opening_mask1 = openMaskArea("HLL_opening_mask1", hookship_mask_verts, nil, HMCS_DEFAULT_LEVEL)
	HLL_opening_mask1.parent_element = HLL_opening_mask_placeholder.name
	--HLL_opening_mask1.isvisible = true
	
	-- Open mask 2 - solid (short) part of the HLL. Hides the solid (short) HLL part when it is so close that it starts to be visible from opposite side of the hookship rectangle.
	local HLL_mask2_verts = makeBoxVerts(0, HLL_SLL_lenTotal + lineEndLen, -HLL_SLL_width / 2, HLL_SLL_width / 2)
	local HLL_opening_mask2 = openMaskArea("HLL_opening_mask2", HLL_mask2_verts, {{"hook_locator_line"}}, HMCS_DEFAULT_LEVEL)
	HLL_opening_mask2.parent_element = HLL_opening_mask1.name
	--HLL_opening_mask2.isvisible = true
	
	local hook_locator_placeholder = addPlaceholder("hook_locator_placeholder", nil,
		{{"is_symbol_occluded", PRFL_SYMB_HOOKSHIP, PRFL_SYMB_CROSSHAIR}, {"hook_locator_line"}})
	
	local dashedLineLen = (dashedLineParams.lineXend_px - dashedLineParams.lineXbegin_px) / pixelsPerMil
	
	local dashed_SLL_HLL_posX = HLL_SLL_lenTotal + 1.4
	local SLL_HLL_dashed_mask_verts =
		makeBoxVerts(-dashedLineParams.lineEndLen, dashedLineLen * 2 + dashedLineParams.lineEndLen, -HLL_SLL_width / 2, HLL_SLL_width / 2)
	
	-- HLL line itself - solid (short) part
	local hook_locator_solid = addSolid_SLL_HLL("Hook_Locator_Line_Solid", nil, hook_locator_placeholder.name)
	-- override disable_clipping debug variable
	hook_locator_solid.h_clip_relation = h_clip_relations.COMPARE
	hook_locator_solid.material = "INDICATION_HMCS_YELLOW"
	
	local HLL_dashed_placeholder = addPlaceholder("HLL_dashed_placeholder", {dashed_SLL_HLL_posX, 0})
	HLL_dashed_placeholder.parent_element = hook_locator_solid.name
	
	-- Open mask 3 - dashed (variable len) part of the HLL. Is used to set the current visible length of the dashed part.
	local HLL_opening_dashed_mask = openMaskArea("HLL_opening_dashed_mask", SLL_HLL_dashed_mask_verts, {{"hook_locator_dashed_line"}}, HMCS_DEFAULT_LEVEL)
	HLL_opening_dashed_mask.parent_element = HLL_dashed_placeholder.name
	--HLL_opening_dashed_mask.isvisible = true
	--HLL_opening_dashed_mask.h_clip_relation = h_clip_relations.NULL
	
	-- HLL line itself - dashed (variable len) part
	addHalfscrLine("Hook_Locator_Dashed", dashedLineParams, dashedLineLen,
		dashConnectGap_px, nil, HLL_dashed_placeholder.name, nil, nil, HMCS_DEFAULT_LEVEL, "INDICATION_HMCS_YELLOW")
	
	-- Close mask 3 - dashed (variable len) part
	local HLL_closing_dashed_mask = closeMaskArea("HLL_closing_dashed_mask", SLL_HLL_dashed_mask_verts, {{"hook_locator_dashed_line"}}, HMCS_DEFAULT_LEVEL + 1)
	HLL_closing_dashed_mask.parent_element = HLL_dashed_placeholder.name
	
	-- Close mask 1 - hookship rectangle
	local HLL_closing_mask_placeholder = addPlaceholder("HLL_closing_mask_placeholder", nil, {{"hookship_pos"}})
	local HLL_closing_mask1 = closeMaskArea("HLL_closing_mask1", hookship_mask_verts, nil, HMCS_DEFAULT_LEVEL + 1)
	HLL_closing_mask1.parent_element = HLL_closing_mask_placeholder.name
	
	-- Close mask 2 - solid (short) part of the HLL
	local HLL_closing_mask2 = closeMaskArea("HLL_closing_mask2", HLL_mask2_verts, {{"hook_locator_line"}}, HMCS_DEFAULT_LEVEL + 1)
	HLL_closing_mask2.parent_element = HLL_closing_mask1.name
	
	-- SPI symbol + SPI locator line (two possible origins)
	
	local SPI_width 		= 18
	local SPI_half_width 	= SPI_width / 2
	local SPI_y_sz_up 		= 7
	local SPI_y_sz_down 	= 6
	
	local SPI_Symbol = AddTexuredElement("SPI_Symbol",
				makeBoxVerts(-SPI_half_width, SPI_half_width, -SPI_y_sz_down, SPI_y_sz_up),
				getTexParams(35, 39),
				{{"is_symbol_occluded", PRFL_SYMB_OWN_SPI, -1}, {"SPI_symbol"}},
				{},
				{},
				HMCS_DEFAULT_LEVEL)

	if useDBGcolor == true then
		SPI_Symbol.material	= "INDICATION_HMCS_DBG_DARK"
	else
		SPI_Symbol.material	= "INDICATION_HMCS_WHITE"
	end
	
	-- SPI locator line when is originated from fixed cross. Has an offset (an 'arm') from the cross center.
	local SPI_locator_solid = addSolid_SLL_HLL("SPI_Locator_Line_from_cross", {{"is_symbol_occluded", PRFL_SYMB_OWN_SPI, -1}, {"SPI_locator_line"}}, LOS_crosshair.name)
	-- override disable_clipping debug variable
	SPI_locator_solid.h_clip_relation = h_clip_relations.COMPARE

	local SLL_dashed_placeholder = addPlaceholder("SLL_dashed_placeholder", {dashed_SLL_HLL_posX, 0})
	SLL_dashed_placeholder.parent_element = SPI_locator_solid.name
	
	local SLL_opening_dashed_mask = openMaskArea("SLL_opening_dashed_mask", SLL_HLL_dashed_mask_verts, {{"SPI_locator_dashed_line"}}, HMCS_DEFAULT_LEVEL)
	SLL_opening_dashed_mask.parent_element = SLL_dashed_placeholder.name
	
	addHalfscrLine("SPI_Locator_Dashed", dashedLineParams, dashedLineLen,
		dashConnectGap_px, nil, SLL_dashed_placeholder.name, nil, nil, HMCS_DEFAULT_LEVEL)
	
	local SLL_closing_dashed_mask = closeMaskArea("SLL_closing_dashed_mask", SLL_HLL_dashed_mask_verts, {{"SPI_locator_dashed_line"}}, HMCS_DEFAULT_LEVEL + 1)
	SLL_closing_dashed_mask.parent_element = SLL_dashed_placeholder.name
end

-- TGP diamond (LOS)
local tgp_LOS_origin = addPlaceholder("tgp_LOS_origin", {0, 0}, {{"is_symbol_occluded", PRFL_SYMB_TGP_DIAMOND, -1}, {"tgp_LOS_origin_pos"}})

local tgp_diamond_sz = 9
local tgp_diamond_half_sz = tgp_diamond_sz / 2

local tgp_diamond = AddTexuredElement("TGP_Diamond",
			makeBoxVerts(-tgp_diamond_half_sz, tgp_diamond_half_sz, -tgp_diamond_half_sz, tgp_diamond_half_sz),
			getTexParams(120, 93),
			{{"tgp_diamond"}},
			{},
			{},
			HMCS_DEFAULT_LEVEL)

tgp_diamond.parent_element = tgp_LOS_origin.name
--tgp_diamond.init_pos = {70, -60}
--tgp_diamond.isdraw = false

do

	local lineTexParams = getTexParams(8, 8)
	local mask_verts = makeBoxVerts(0.0, solidLineLenMax + lineEndLen, -lineWidth / 2, lineWidth / 2)
	local line_verts = makeBoxVerts(-lineEndLen, solidLineLenMax + lineEndLen, -lineWidth / 2, lineWidth / 2)

	local tgp_FOV_origin = addPlaceholder("tgp_FOV_origin", {0, 0}, {{"is_symbol_occluded", PRFL_SYMB_TGP_FOV, PRFL_SYMB_TGP_DIAMOND}})
	tgp_FOV_origin.parent_element = tgp_LOS_origin.name
	
	-- TGP FOV
	for i = 0, 3 do
	--for i = 0, 0 do
			
		local line 
		local tgp_FOV_area_origin = addPlaceholder("tgp_FOV_area_origin_"..i, {0, 0}, {{"tgp_FOV_area_line_pos", i}})
		tgp_FOV_area_origin.parent_element = tgp_FOV_origin.name
		
		local opening_mask = openMaskArea("tgp_FOV_area_line_open_mask_"..i, mask_verts, {{"tgp_FOV_area_line_mask_pos", i}}, HMCS_DEFAULT_LEVEL)
		opening_mask.parent_element = tgp_FOV_area_origin.name
		
		local tgp_FOV_area_line = AddTexuredElement("tgp_FOV_area_line_"..i,
					line_verts,
					lineTexParams,
					nil,
					{0, 0},
					{},
					HMCS_DEFAULT_LEVEL)

		tgp_FOV_area_line.parent_element  = tgp_FOV_area_origin.name
		tgp_FOV_area_line.h_clip_relation = determineClipRelation(h_clip_relations.COMPARE, true)
		
		local closing_mask = closeMaskArea("tgp_FOV_area_line_close_mask_"..i, mask_verts, {{"tgp_FOV_area_line_mask_pos", i}}, HMCS_DEFAULT_LEVEL + 1)
		closing_mask.parent_element = tgp_FOV_area_line.name
			
		--[[
		local tgp_FOV_area_line = addVarLenLine("tgp_FOV_area_line_"..i,
					math.rad(5.0) * 1000,
					solidVarLenLineMax, 
					{{"tgp_FOV_area_line_pos", i}},
					{0, 0},
					{},
					HMCS_DEFAULT_LEVEL,
					true)

		tgp_FOV_area_line.parent_element = tgp_FOV_origin.name
		]]
	end
end

-- Occlusion zone lines
--addPlaceholder("Occlusion_Zone_Lines", nil, {{"updateMultipleSymbolsBuffer", 2}})
