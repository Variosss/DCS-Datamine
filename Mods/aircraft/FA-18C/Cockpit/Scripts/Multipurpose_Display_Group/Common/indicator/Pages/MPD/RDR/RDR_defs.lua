dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Sensors/Radar/RadarDefs.lua")

top_bottom_PB_shiftY 	= 8
side_PB_shiftX 			= 6
side_PB_shiftY 			= 25
label2ndRowIdentWide    = 10

tactical_display_sz 	= RDR_tacticalAreaSizeDI -- defined in RadarDefs.lua
tactical_display_sz_half = tactical_display_sz / 2

upper_data_block_posY = tactical_display_sz_half + 12

RF_channel_shiftY = 7

function adjust_PB_label_pos(label, shiftX, shiftY)
	label.init_pos = {label.init_pos[1] + shiftX, label.init_pos[2] + shiftY}
end

function add_PB_label_RDR(PBNumber, ...)
	local shiftX
	local shiftY
	
	if PBNumber >= 1 and PBNumber <= 5 then
		-- left PBs: 1-5
		shiftX = side_PB_shiftX
		shiftY = side_PB_shiftY
	elseif PBNumber >= 6 and PBNumber <= 10 then
		-- top PBs: 6-10
		shiftX = 0
		shiftY = top_bottom_PB_shiftY
	elseif PBNumber >= 11 and PBNumber <= 15 then
		-- right PBs: 11-15
		shiftX = -side_PB_shiftX
		shiftY = side_PB_shiftY
	elseif PBNumber >= 16 and PBNumber <= 20 then
		-- bottom PBs: 16-20
		shiftX = 0
		shiftY = -top_bottom_PB_shiftY
	else
		shiftX = 0
		shiftY = 0
	end
	
	local result = addTextFromArgTable(arg, PB_positions[PBNumber], getOffsetFromPBnum(PBNumber))
	
	for i = 1, #result do
		adjust_PB_label_pos(result[i], shiftX, shiftY)
	end
	
	return result
end

function add_PB16_DATA_label(displayBox)
	if displayBox == false then
		return add_PB_label_RDR(16, {" DATA "})
	else
		return add_PB_label_RDR(16, {" DATA ", nil, nil, true})
	end
end

local ten_degreesSz = tactical_display_sz_half / 7 				-- basic size is equivalent to 10 degrees of the total display azimuth (140 / 14, or 70 / 7)
local az_rng_refline_len = ten_degreesSz - 4
local az_refline_space = ten_degreesSz * 3 						-- 30 degrees
-- the range scale reference lines (the ones at the left/right sides of the tactical area) can be
--   formed as 4 gaps (3 lines) or as 5 gaps (4 lines). It depends on the radar mode and current operating range
rng_speed_refline_space_4_gaps = tactical_display_sz_half / 2
local rng_speed_refline_space_5_gaps = tactical_display_sz / 5

function add_azimuth_ref_lines(nameSuffix, posY, parent)
	local rot
	local posSuffix
	
	if posY > 0 then
		rot = 180
		posSuffix = "top"
	else
		rot = 0
		posSuffix = "bottom"
	end
	
	local suffix = posSuffix .. "_" .. nameSuffix
	
	addStrokeLine("az_ref_line_center_" .. suffix, az_rng_refline_len, {0, posY}, rot, parent)
	
	for i = 1, 2 do
		local line_space = az_refline_space * i
		addStrokeLine("az_ref_line_rifht_" .. suffix .. "_" .. i, az_rng_refline_len, {line_space, posY}, rot, parent)
		addStrokeLine("az_ref_line_left_" .. suffix .. "_" .. i, az_rng_refline_len, {-line_space, posY}, rot, parent)
	end
end

function add_range_speed_ref_lines(nameSuffix, posX, isFourGaps, parent)
	local rot
	local posSuffix
	
	if posX > 0 then
		rot = 90
		posSuffix = "right"
	else
		rot = -90
		posSuffix = "left"
	end
	
	local suffix = posSuffix .. "_" .. nameSuffix
	
	if isFourGaps == true then
		addStrokeLine("rng_speed_ref_line_center_" .. suffix, az_rng_refline_len, {posX, 0}, rot, parent)
		addStrokeLine("rng_speed_line_rifht_" .. suffix, az_rng_refline_len, {posX, rng_speed_refline_space_4_gaps}, rot, parent)
		addStrokeLine("rng_speed_line_left_" .. suffix, az_rng_refline_len, {posX, -rng_speed_refline_space_4_gaps}, rot, parent)
	else
		for i = 1, 2 do
			local line_space = rng_speed_refline_space_5_gaps * (i - 1) + rng_speed_refline_space_5_gaps / 2
			addStrokeLine("rng_speed_line_rifht_" .. suffix .. "_" .. i, az_rng_refline_len, {posX, line_space}, rot, parent)
			addStrokeLine("rng_speed_line_left_" .. suffix .. "_" .. i, az_rng_refline_len, {posX, -line_space}, rot, parent)
		end
	end
end

function add_elevation_ref_lines(parent)
	local elev_refline_len   		= 20
	local elev_refline_len_short	= 8
	local elev_refline_space 		= rng_speed_refline_space_4_gaps - 3
	local elev_refline_shift 		= -2
	local elev_refline_posX  		= -tactical_display_sz_half - 5
	
	-- -30, 0, 30
	for i = 0, 2 do
		local posY = rng_speed_refline_space_4_gaps + elev_refline_shift - elev_refline_space * i
		addStrokeLine("elev_ref_line_long_" .. i, elev_refline_len, {elev_refline_posX, posY}, 90, parent)
	end
	
	-- upper short ticks with 10 deg spacing
	local elev_refline_short_space = elev_refline_space / 3
	for i = 0, 1 do
		local posY = rng_speed_refline_space_4_gaps + elev_refline_shift - elev_refline_short_space * (1 + i)
		addStrokeLine("elev_ref_line_short_upper_" .. i, elev_refline_len_short, {elev_refline_posX, posY}, 90, parent)
	end
	
	-- lower short ticks with 10 deg spacing
	for i = 0, 1 do
		local posY = rng_speed_refline_space_4_gaps + elev_refline_shift - elev_refline_short_space * (4 + i)
		addStrokeLine("elev_ref_line_short_lower_" .. i, elev_refline_len_short, {elev_refline_posX, posY}, 90, parent)
	end
end

function addRangeIncDecArrows()
	local rangeIncrementArrow 		=
		addStrokeSymbol("RangeIncrementArrow", {"stroke_symbols_MDI_AMPCD", "076-arrow-up"}, "RightCenter", {PB_positions[11][1], PB_positions[11][2]}, nil, {{"MPD_RDR_RangeArrowsShow"}})
	local rangeDecrementArrow 		= Copy(rangeIncrementArrow)
	rangeDecrementArrow.name  		= "RangeDecrementArrow"
	rangeDecrementArrow.init_pos    = {PB_positions[12][1], PB_positions[12][2]}
	rangeDecrementArrow.init_rot    = {180}
	rangeDecrementArrow.alignment	= "LeftCenter"
	Add(rangeDecrementArrow)
	
	local arrowPosAdjX = 15
	adjust_PB_label_pos(rangeIncrementArrow, -arrowPosAdjX, 15)
	adjust_PB_label_pos(rangeDecrementArrow, -arrowPosAdjX, 50)
end

function add_RDR_caret(name, pos, rot, parent, controllers)
	return addCaretByWidthHeight(name, 24, 32, pos, rot, parent, controllers)
end

function addRDRTick(name, parent, TickLength, TickPos, TickRot, mainController, secondController)
	local lineShift = 1

	local RDRTick_Placeholder = addPlaceholder(name, TickPos, parent, mainController)
	RDRTick_Placeholder.init_rot = {TickRot}
	-- central line
	addStrokeLine(name .. "_central", TickLength, nil, 0, RDRTick_Placeholder.name, secondController)
	-- upper line
	addStrokeLine(name .. "_upper", TickLength, {lineShift, 0}, 0, RDRTick_Placeholder.name, secondController)
	-- lower line
	addStrokeLine(name .. "_lower", TickLength, {-lineShift, 0}, 0, RDRTick_Placeholder.name, secondController)
end

function addAcqusitionCursor()
	-- TDC (Acquisition Cursor), radar positioned
	local acqCursPlacehldName = "AcquisitionCursorPlaceholder"
	local AcquisitionCursorPlaceholder = addPlaceholder(acqCursPlacehldName, nil, nil, {{"TDC_assignedDisplay"}, {"MPD_RDR_TDC_position", InToDI(5) / 2}})

	local function addAcqusitionCursorLine(name, pos, controller)
		-- TDC (Acquisition Cursor) is rendered by three lines
		
		local lineShift = 1
		
		-- base line
		local baseLine = addStrokeLine(name.."_base", RDR_TDC_HeightDI, pos, nil, acqCursPlacehldName, controler)
		-- left line
		addStrokeLine(name.."_additional_1", RDR_TDC_HeightDI, {-lineShift, 0}, nil, baseLine.name, controller)
		addStrokeLine(name.."_additional_2", RDR_TDC_HeightDI, {lineShift, 0}, nil, baseLine.name, controller)
	end

	addAcqusitionCursorLine("Acquisition_cursor_line_left", {-RDR_TDC_WidthDI / 2, -RDR_TDC_HeightDI / 2}, {{"MPD_RDR_EADI_SetYellowColor"}})
	addAcqusitionCursorLine("Acquisition_cursor_line_right", {RDR_TDC_WidthDI / 2, -RDR_TDC_HeightDI / 2}, {{"MPD_RDR_EADI_SetYellowColor"}})

	return AcquisitionCursorPlaceholder
end