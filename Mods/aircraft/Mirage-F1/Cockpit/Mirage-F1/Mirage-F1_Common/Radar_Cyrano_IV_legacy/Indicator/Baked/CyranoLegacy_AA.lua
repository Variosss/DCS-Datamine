dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_tools.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Baked/CyranoLegacy_bake_config.lua")

addPlaceholder("targets", {0, 0}, {{"radarUpdateTargets"}})

--drawDbgGeometry 	= true
--drawDbgMarkers  	= true

-- Scan borders

local function addScanBorders(nameSub, scanSelection, zoneHalfWidth)
	local scan_borders_origin		= addPlaceholder("scan_borders_origin_"..nameSub, {0, -AA_range_vel_zone_half}, {{"radarDisplayScanBorders"}})

	local controllers
	if scanSelection == 0 or scanSelection == 3 then
		-- 30 degrees scan and BZ
		controllers = {{"radar_AA_AzScanSelection", scanSelection}, {"radar_AA_AzScanCenter", AA_azimuth_zone_half}}
	else
		-- 60 degrees scan and TL
		controllers = {{"radar_AA_AzScanSelection", scanSelection}}
	end
		
	local scan_borders_orig_sel		= addPlaceholder("scan_borders_orig_sel_"..nameSub, nil, controllers)
	scan_borders_orig_sel.parent_element = scan_borders_origin.name
	
	local scanBorderTexParams 		= getTexParams(21, 76)
	local borderLen					= 10
	
	local scan_border_left 			= RdrAddLine("scan_border_left_"..nameSub, 0, borderLen, scanBorderTexParams, nil, {-zoneHalfWidth, 0}, {90}, scanFrameLevel)
	scan_border_left.parent_element	= scan_borders_orig_sel.name
	
	local scan_border_right 		= RdrAddLine("scan_border_right_"..nameSub, 0, borderLen, scanBorderTexParams, nil, {zoneHalfWidth, 0}, {90}, scanFrameLevel)
	scan_border_right.parent_element = scan_borders_orig_sel.name
end

--drawDbgGeometry = true
	
local border_mask_margin = 0.03

local bordersMaskVerts

do
	local w = display_area_radius
	local h = AA_range_vel_zone_half + border_mask_margin

	bordersMaskVerts = {{-w, -h}, {-w, h}, {w, h}, {w, -h}}
end

openMaskArea("borders_mask_open", bordersMaskVerts, nil, scanFrameLevel - 1)

--drawDbgGeometry 	= false

addScanBorders("30", 0, AA_azimuth_zone_half * 0.5)
addScanBorders("60", 1, AA_azimuth_zone_half)
addScanBorders("TL", 2, 0.8 * 0.5)
addScanBorders("BZ", 3, AA_azimuth_zone_half / 6)

closeMaskArea("borders_mask_close", bordersMaskVerts, nil, scanFrameLevel)


-- Range marks

-- 30 degrees scan
do
	--drawDbgGeometry = true
	
	local rangeMaskVerts30 = makeRangeMarksVerts(AA_azimuth_zone_half * 0.5 + range_mask_margin)
	
	local rangeMarks_30_CmnControllers = {{"radarDisplayScanBorders"}, {"radar_AA_AzScanSelection", 0}, {"radar_AA_AzScanCenter", AA_azimuth_zone_half}}
	openMaskArea("range_30_mask_open", rangeMaskVerts30, rangeMarks_30_CmnControllers, scanFrameLevel - 1)
	
	local rangeMarksCenter30 = addPlaceholder("range_marks_center_30", nil, rangeMarks_30_CmnControllers)
	
	local rangeMarksOrigin30Pos = {-AA_azimuth_zone_half * 0.5, -AA_range_vel_zone_half}
	local rangeMarksOrigin30 = addPlaceholder("range_marks_origin_30", rangeMarksOrigin30Pos)
	rangeMarksOrigin30.parent_element = rangeMarksCenter30.name
		
	addRangeMarks("30", rangeMarksOrigin30, AA_azimuth_zone_half * 0.5, scanFrameLevel)

	closeMaskArea("range_30_mask_close", rangeMaskVerts30, rangeMarks_30_CmnControllers, scanFrameLevel)

	--drawDbgGeometry = false
end

-- 60 degrees scan
do
	--drawDbgGeometry = true
	
	local rangeMaskVerts60 = makeRangeMarksVerts(AA_azimuth_zone_half + range_mask_margin)
	
	local rangeMarks_60_CmnControllers = {{"radarDisplayScanBorders"}, {"radar_AA_AzScanSelection", 1}}
	openMaskArea("range_60_mask_open", rangeMaskVerts60, rangeMarks_60_CmnControllers, scanFrameLevel - 1)

	local rangeMarksOrigin60Pos = {-AA_azimuth_zone_half, -AA_range_vel_zone_half}
	local rangeMarksOrigin60 = addPlaceholder("range_marks_origin_60", rangeMarksOrigin60Pos)
	
	addRangeMarks("60", rangeMarksOrigin60, AA_azimuth_zone_half, scanFrameLevel)

	closeMaskArea("range_60_mask_close", rangeMaskVerts60, rangeMarks_60_CmnControllers, scanFrameLevel)
	
	--drawDbgGeometry = false
end

-- TL/BZ range marks

do
	local TL_BZ_origin =
		addPlaceholder("TL_BZ_origin", {0, -AA_range_vel_zone_half}, {{"radarDisplayScanBorders"}, {"radar_AA_AzScanSelection", 2, 3}})
		
	-- 7 NM
	local scale = AA_range_vel_zone_half * 2 / 7

	-- 3 mm width
	local rangeMark_TL_BZ_halfWidth = 0.3 * 0.5

	local rangeMarksOrigin_TL_BZ_Pos = {-rangeMark_TL_BZ_halfWidth, 0}
	local rangeMarksOrigin_TL_BZ = addPlaceholder("rangeMarksOrigin_TL_BZ", rangeMarksOrigin_TL_BZ_Pos)
	rangeMarksOrigin_TL_BZ.parent_element = TL_BZ_origin.name
	
	local rangeMark_TL_BZ_TexParams = getTexParams(227, 21)
	-- 2 NM
	local rangeMark_TL_BZ_step = 2

	local rangeScale_TL_BZ = AA_range_vel_zone_half * 2 / 7

	for i = 1, 3 do
		local mark =
			RdrAddLine("range_mark_"..i.."_TL_BZ",
				0, rangeMark_TL_BZ_halfWidth * 2, rangeMark_TL_BZ_TexParams, nil, {0, i * rangeMark_TL_BZ_step * rangeScale_TL_BZ})
		mark.parent_element = rangeMarksOrigin_TL_BZ.name
	end

	local km2nm = 0.539957
	local _7km = AA_range_vel_zone_half * 2 * km2nm
	local _400m = AA_range_vel_zone_half * 2 / 7 * 0.4 * km2nm
	
	local strobe_TL_BZ_TexParams = getTexParams(213, 39)
	
	local strobe_BL_TZ = RdrAddLine("strobe_BL_TZ", 0, _7km, strobe_TL_BZ_TexParams, nil, {0, _400m}, {90})
	strobe_BL_TZ.parent_element = TL_BZ_origin.name
end

