dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_tools.lua")

--drawDbgGeometry 	= true
--drawDbgMarkers  	= true

local strobeLength						= 0.4
local vertStrobeLineShift 				= strobeLength * 0.5
local vertStrobeTexParams 				= getTexParams(307, 58.5)


local enable_DBG_scan_line 				= false

if enable_DBG_scan_line == true then
	local DBG_scan_line_pos = {0, -display_area_radius}
	local DBG_scan_line_placeholder = addPlaceholder("DBG_scan_line_placeholder", DBG_scan_line_pos, {{"DBG_radar_AA_ScanLine", AA_azimuth_zone_half}})
	
	local DBG_line = RdrAddLine("DBG_AA_scan_line", scan_line_shift, scan_line_len, scan_line_tex_params, nil, scan_line_pos, {90})
	DBG_line.parent_element = DBG_scan_line_placeholder.name
end


local enable_DBG_antenna_pos 			= false

if enable_DBG_antenna_pos == true then
	local subLineLen					= strobeLength
	local subLineTexParams 				= vertStrobeTexParams
	local subLineShift 					= subLineLen * 0.5
	
	local DBG_antenna_pos_placeholder 	=
		addPlaceholder("DBG_antenna_pos_placeholder", nil,
			{{"DBG_radar_AA_ScanPos", AA_azimuth_zone_half, AA_range_vel_zone_half, 4}})
	
	local DBG_cross_hor					=
		RdrAddLine("DBG_AA_scan_pos_cross_hor", subLineShift, subLineLen, subLineTexParams)
	DBG_cross_hor.parent_element 		= DBG_antenna_pos_placeholder.name
	
	local DBG_cross_vert				=
		RdrAddLine("DBG_AA_scan_pos_cross_vert", subLineShift, subLineLen, subLineTexParams, nil, nil, {90})
	DBG_cross_vert.parent_element 		= DBG_antenna_pos_placeholder.name
end


do
	local radial_vel_scale_placeholder 	= addPlaceholder("radial_vel_scale_placeholder", {3.5, -0.5}, {{"radar_AA_RadialVelVisible"}})

	local radial_velocity_scale			= RdrAddLine("radial_velocity_scale", 0, 4, getTexParams(21, 58.5), nil, nil, {90})
	radial_velocity_scale.parent_element = radial_vel_scale_placeholder.name

	local radial_vel_mark_placeholder 	= addPlaceholder("radial_vel_mark_placeholder", nil, {{"radar_AA_RadialVelMark", 0.38, 0.73, 4}})
	radial_vel_mark_placeholder.parent_element = radial_vel_scale_placeholder.name

	local radial_velocity_mark			= RdrAddLine("radial_velocity_mark", 0.3, 0.4, getTexParams(348, 58.5))
	radial_velocity_mark.parent_element	= radial_vel_mark_placeholder.name
end

--drawDbgGeometry 	= true
--drawDbgMarkers  	= true

local strobes_placeholder 			= addPlaceholder("strobes_placeholder", nil, {{"radar_AA_StrobePos", AA_azimuth_zone_half, AA_range_vel_zone_half}})

local function addStrobe(strobe_kind)
	local name
	local texParams
	local line_shift
	local rot
	
	if strobe_kind == 0 then
		name 						= "search"
		texParams 					= vertStrobeTexParams
		line_shift 					= vertStrobeLineShift
		rot 						= 90
	else
		name 						= "track"
		texParams 					= getTexParams(298, 58.5)
		line_shift 					= 0
		rot 						= 180
	end
	
	local strobe_placeholder 		= addPlaceholder("strobe_placeholder_"..name, nil, {{"radar_AA_StrobeKind", strobe_kind}})
	strobe_placeholder.parent_element = strobes_placeholder.name

	local strobe_subs_step			= 0.025
	local strobe_subs_count			= 3
	local init_pos					= -strobe_subs_step * (strobe_subs_count - 1) * 0.5
	
	for cnt = 1, strobe_subs_count do
		local pos_var 				= init_pos + strobe_subs_step * (cnt - 1)
		local pos
		
		if strobe_kind == 0 then
			pos = {pos_var, 0}
		else
			pos = {0, pos_var}
		end
		
		local strobe_subelem		= RdrAddLine("strobe_"..name.."_subelem_"..cnt, line_shift, strobeLength, texParams, nil, pos, {rot})
		strobe_subelem.parent_element = strobe_placeholder.name
	end
end

-- Search
addStrobe(0)
-- Track
addStrobe(1)


-- Track borders and range marks

do
	local trackBordersWidth = 0.8
	local trackBordersLen = 10
	
	-- Borders
		
	--local DBG_scan_line_pos = {0, }
	local track_borders_placeholder = addPlaceholder("track_borders_placeholder", {0, -display_area_radius}, {{"radar_AA_AzTrackCenter", AA_azimuth_zone_half}})
		
	local track_border_left = RdrAddLine("track_border_left", 0, trackBordersLen, scan_line_tex_params, nil, {-trackBordersWidth * 0.5, 0}, {90})
	track_border_left.parent_element = track_borders_placeholder.name
	
	local track_border_right = RdrAddLine("track_border_right", 0, trackBordersLen, scan_line_tex_params, nil, {trackBordersWidth * 0.5, 0}, {90})
	track_border_right.parent_element = track_borders_placeholder.name
	
	-- Range marks
	
	do
		--drawDbgGeometry = true

		local rangeMaskVertsTrack = makeRangeMarksVerts(trackBordersWidth * 0.5 + range_mask_margin)

		local trackRangeMarksCmnControllers = {{"radar_AA_AzTrackCenter", AA_azimuth_zone_half}}
		openMaskArea("track_range_mask_open", rangeMaskVertsTrack, trackRangeMarksCmnControllers, scanFrameLevel - 1)
		
		local trackRangeMarksCenter = addPlaceholder("track_range_marks_center", nil, trackRangeMarksCmnControllers)
		
		local trackRangeMarksOriginPos = {-trackBordersWidth * 0.5, -AA_range_vel_zone_half}
		local trackRangeMarksOrigin = addPlaceholder("track_range_marks_origin", trackRangeMarksOriginPos)
		trackRangeMarksOrigin.parent_element = trackRangeMarksCenter.name
			
		addRangeMarks("Track", trackRangeMarksOrigin, trackBordersWidth * 0.5, scanFrameLevel)

		closeMaskArea("track_range_mask_clost", rangeMaskVertsTrack, trackRangeMarksCmnControllers, scanFrameLevel)

		--drawDbgGeometry = false
	end

end
