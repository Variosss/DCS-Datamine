dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_tools.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Baked/CyranoLegacy_bake_config.lua")

--drawDbgGeometry 	= true
--drawDbgMarkers  	= true

local scan_line_pos_cst = {0, -display_area_radius + AG_scan_center_shift_y}

do
	local rotFix = 0.5
	RdrAddLine("AG_rendered_scan_border_left", scan_line_shift, scan_line_len, scan_line_tex_params, {{"radar_AG_ScanBorder", -1}}, scan_line_pos_cst, {90 + rotFix})
	RdrAddLine("AG_rendered_scan_border_right", scan_line_shift, scan_line_len, scan_line_tex_params, {{"radar_AG_ScanBorder", 1}}, scan_line_pos_cst, {90 - rotFix})
end

local function makeAndAddScanArc(name_suffix, scanWidth, radius, parent)
	local tex_params = getTexParams(326, 21)
	
	local angle = -math.rad(scanWidth)
	local step = math.rad(1.5 / (radius / 4))
	local i = 0
	
	while angle < math.rad(scanWidth) do
		
		if (angle + step * 0.5 >= math.rad(scanWidth)) then
			break
		end
			
		local name = "AG_rendered_scan_arc_"..name_suffix.."_w_"..scanWidth.."_r_"..radius.."_n"..i
		local pos = {radius * math.sin(angle), radius * math.cos(angle)}
		local rot_deg = math.deg(-angle)
		
		local line = RdrAddLine(name, 0, 0.16, tex_params, nil, pos, {rot_deg})
		line.parent_element = parent.name
		
		angle = angle + step
		i = i + 1
	end
end

-- Cycle for two scan widths (30 and 60 degrees)
for scan_idx = 0, 1 do
	
	local scanNominal
	local scanReal
	
	if scan_idx == 0 then
		scanNominal = 30
		scanReal = 27
	else
		scanNominal = 60
		scanReal = 57
	end
	
	local arcs_center = addPlaceholder("arcs_center_"..scanNominal.."_scan", scan_line_pos_cst, {{"radarScanWidth", scan_idx}})
	
	local most_far_arc_cm = 10.2 - (0.58 - AG_scan_center_shift_y) -- centimeters
	
	local function addArc(range_nm, name_suffix, range_idx, radius_cm, parent)
		makeAndAddScanArc(name_suffix, scanReal, radius_cm, parent)
	end
	
	local function addArcsParent(name_suffix, range_idx)
		local arcs_center_for_this_rng = addPlaceholder("arcs_center_"..scanNominal.."_scan_"..name_suffix, {0, 0}, {{"radarSelectedRange", range_idx}})
		arcs_center_for_this_rng.parent_element = arcs_center.name
		
		return arcs_center_for_this_rng
	end
	
	local function addArcs(step_nm, arcs_num, name_suffix, range_idx)
		local arcs_center_for_this_rng = addArcsParent(name_suffix, range_idx)
		
		local arc_step_cm = most_far_arc_cm / arcs_num
		for i = 1, arcs_num do
			local range_nm = step_nm * i
			local radius_cm = arc_step_cm * i
			
			addArc(range_nm, name_suffix, range_idx, radius_cm, arcs_center_for_this_rng)
		end
		
		return arcs_center_for_this_rng
	end
	
	-- 7 NM
	do
		local name_suffix = "7NM"
		local range_idx = 0
		
		local arcs_center_for_this_rng = addArcsParent(name_suffix, range_idx)
	
		local arcs_num = 3
		local step_nm = 2
		local arc_step_cm = most_far_arc_cm * step_nm / 7
		
		for i = 1, arcs_num do
			local range_nm = step_nm * i
			local radius_cm = arc_step_cm * i
			
			addArc(range_nm, name_suffix, range_idx, radius_cm, arcs_center_for_this_rng)
		end
	end
	
	-- 15 NM
	addArcs(5, 3, "15NM", 1)
	
	-- 35 NM
	do
		local name_suffix = "35NM"
		local range_idx = 2
		
		local arcs_center_for_this_rng = addArcsParent(name_suffix, range_idx)
	
		local arcs_num = 3
		local step_nm = 10
		local arc_step_cm = most_far_arc_cm / 3.5
		
		for i = 1, arcs_num do
			local range_nm = step_nm * i
			local radius_cm = arc_step_cm * i
			
			addArc(range_nm, name_suffix, range_idx, radius_cm, arcs_center_for_this_rng)
		end
		
		addArc(35, "35NM", 2, most_far_arc_cm, arcs_center_for_this_rng)
	end
		
	-- 60 NM
	addArcs(10, 6, "60NM", 3)

end

