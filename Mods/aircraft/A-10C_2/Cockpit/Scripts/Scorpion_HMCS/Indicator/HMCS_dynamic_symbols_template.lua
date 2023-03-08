dofile(LockOn_Options.script_path.."Scorpion_HMCS/Indicator/HMCS_definitions.lua")

-- Waypoints
local waypt_symbol_placeholder = addPlaceholder("Waypoint", nil, {{"waypoint_symbol_pos"}})
waypt_symbol_placeholder.parent_element = ""

do
	local pt = addWaypointSymbol("WaypointSymbol", false, {{"waypoint_kind", 0}})
	pt.parent_element = waypt_symbol_placeholder.name
end

do
	local pt = addWaypointSymbol("SteerpointSymbol", true, {{"waypoint_kind", 1}})
	pt.parent_element = waypt_symbol_placeholder.name
end

-- Datalink symbols
local DL_symbol_placeholder = addPlaceholder("DL_symbol", nil, {{"DL_symbol_pos"}})
DL_symbol_placeholder.parent_element = ""

-- EPLRS reports

local EPLRS_symb_sz = 12
local EPLRS_symb_half_sz = EPLRS_symb_sz / 2

local EPLRS_symbol = AddTexuredElement("Gnd_EPLRS_symbol",
				makeBoxVerts(-EPLRS_symb_half_sz, EPLRS_symb_half_sz, -EPLRS_symb_half_sz, EPLRS_symb_half_sz),
				getTexParams(225.5, 93),
				{{"DL_symbol_kind", 0}},
				{},
				{},
				HMCS_DEFAULT_LEVEL + 1)

EPLRS_symbol.parent_element = DL_symbol_placeholder.name

-- PPLI

local PPLI_placeholder = addPlaceholder("PPLI", nil, {{"DL_symbol_kind", 1}})

PPLI_placeholder.parent_element = DL_symbol_placeholder.name

local function addPPLI(name, isFlightMember)

	local PPLI_sz = 19
	local PPLI_half_sz = PPLI_sz / 2

	local PPLI = AddTexuredElement("PPLI_"..name,
			makeBoxVerts(-PPLI_half_sz, PPLI_half_sz, -PPLI_half_sz, PPLI_half_sz),
			getTexParams(425, 104),
			nil,
			{},
			{},
			HMCS_DEFAULT_LEVEL + 1)
	
	--PPLI.init_pos = {70, 30}
	PPLI.parent_element = PPLI_placeholder.name
	
	if isFlightMember == true then
		if useDBGcolor == true then
			PPLI.material = "INDICATION_HMCS_DBG_DARK"
		else
			PPLI.material = "INDICATION_HMCS_BLUE"
		end
	end

	-- PPLI velocity vector
	local PPLI_vel_vector_origin = addPlaceholder("PPLI_"..name.."_vel_vector_origin", nil, {{"DL_symbol_mag_bearing"}})
	PPLI_vel_vector_origin.parent_element = PPLI.name
	
	--[[
	local PPLI_vel_vector = addVarLenLine("PPLI_"..name.."_Vel_Vector",
				12,
				solidVarLenLineMax, 
				{{"PPLI_vel_vector_len"}},
				{8, 0},
				{},
				HMCS_DEFAULT_LEVEL + 1,
				false)

	PPLI_vel_vector.parent_element = PPLI_vel_vector_origin.name
	if isFlightMember == true then
		if useDBGcolor == true then
			PPLI_vel_vector.material = "INDICATION_HMCS_DBG_DARK"
		else
			PPLI_vel_vector.material = "INDICATION_HMCS_BLUE"
		end
	end
	]]
	
	--[[
	-- altitude in thousands of feet
	local PPLI_altitude = AddText_Pos("PPLI_"..name.."_altitude", 
				{{"PPLI_altitude_txt"}},
				{0, -15}, 
				HMCS_DEFAULT_LEVEL + 1,
				"CenterCenter",
				2)
			
	PPLI_altitude.parent_element = PPLI.name
	--]]
	
	local PPLI_info_shiftY = 14
	
	-- range in nm
	local PPLI_range = AddText_Pos("PPLI_"..name.."_range", 
				{{"DL_symbol_range_txt"}},
				{0, -PPLI_info_shiftY},
				HMCS_DEFAULT_LEVEL + 1,
				"CenterCenter",
				1)
			
	PPLI_range.parent_element = PPLI.name
	
	-- unit callsign
	local PPLI_callsign = AddText_Pos("PPLI_"..name.."_callsign", 
				{{"DL_symbol_callsign_txt"}},
				{0, PPLI_info_shiftY},
				HMCS_DEFAULT_LEVEL + 1,
				"CenterCenter",
				1)
	
	PPLI_callsign.parent_element = PPLI.name
	
	return PPLI
end


-- Flight member
do
	local PPLI_flight_member = addPPLI("PPLI_flight_member", true)

	PPLI_flight_member.controllers = {{"PPLI_kind", 0}}

	local PPLI_member_number = AddText_Pos_Formats("PPLI_Member_Number", 
				{{"DL_symbol_fl_member_number_txt"}},
				{}, 
				HMCS_DEFAULT_LEVEL + 1,
				"CenterCenter",
				{"%d"},
				1)
	
	PPLI_member_number.parent_element 	= PPLI_flight_member.name
end

-- Donor
do
	local PPLI_donor = addPPLI("PPLI_donor", false)

	PPLI_donor.controllers = {{"PPLI_kind", 1}}

	local PPLI_donor_dot_sz = 7
	local PPLI_donor_dot_half_sz = PPLI_donor_dot_sz / 2

	local PPLI_donor_dot = AddTexuredElement("PPLI_Donor_Dot",
				makeBoxVerts(-PPLI_donor_dot_half_sz, PPLI_donor_dot_half_sz, -PPLI_donor_dot_half_sz, PPLI_donor_dot_half_sz),
				getTexParams(474.6, 104),
				nil,
				{},
				{},
				HMCS_DEFAULT_LEVEL + 1)

	PPLI_donor_dot.parent_element = PPLI_donor.name
end

-- Other PPLI
do
	local PPLI_other = addPPLI("PPLI_other", false)

	PPLI_other.controllers = {{"PPLI_kind", 2}}
end

-- mini SPI
local mini_SPI_placeholder = addPlaceholder("mini_SPI_placeholder", nil, {{"DL_symbol_kind", 2}})
mini_SPI_placeholder.parent_element = DL_symbol_placeholder.name
	
local function addMiniSPI(name, isFromFlMember, controllers)

	local mini_SPI_plhld_particul = addPlaceholder(name .. "_placeholder", nil, controllers)
	mini_SPI_plhld_particul.parent_element = mini_SPI_placeholder.name
	
	-- mini-SPI donor line
	local lineName 				= name.."_donor_line"
	local lineControllers		= {{"mini_SPI_donor_line_rot"}}
	local lineLenControllerName = "mini_SPI_donor_line_len"
	local lineClipLevel 		= HMCS_DEFAULT_LEVEL + 1
	local lineMaterial 			= "INDICATION_HMCS_BLUE"
	
	if isFromFlMember == true then
		addAllscrVarLenLine(lineName,
			solidLineParams,
			lineControllers,
			lineLenControllerName,
			mini_SPI_plhld_particul.name,
			nil,
			nil,
			lineClipLevel,
			lineMaterial)
	else
		addAllscrDashVarLenLine(lineName,
			dashedLineParams,
			dashConnectGap_px,
			lineControllers,
			lineLenControllerName,
			mini_SPI_plhld_particul.name,
			nil,
			nil,
			lineClipLevel,
			lineMaterial)
	end
	
	local mini_SPI_width 		= 19
	local mini_SPI_y_sz_up 		= 9
	local mini_SPI_y_sz_down 	= 6
	
	local mini_SPI = AddTexuredElement(name .. "_symbol",
				makeBoxVerts(-mini_SPI_width / 2, mini_SPI_width / 2, -mini_SPI_y_sz_down, mini_SPI_y_sz_up),
				getTexParams(35, 160),
				nil,
				{},
				{},
				HMCS_DEFAULT_LEVEL + 1)

	if isFromFlMember == true then
		if useDBGcolor == true then
			mini_SPI.material = "INDICATION_HMCS_DBG_DARK"
		else
			mini_SPI.material = "INDICATION_HMCS_BLUE"
		end
	end
	
	mini_SPI.parent_element = mini_SPI_plhld_particul.name
	
	if isFromFlMember == true then
		local mini_SPI_member_number = AddText_Pos_Formats(name .. "mini_SPI_member_number", 
					{{"DL_symbol_fl_member_number_txt"}},
					{}, 
					HMCS_DEFAULT_LEVEL + 1,
					"CenterCenter",
					{"%d"},
					1)
		
		mini_SPI_member_number.parent_element = mini_SPI.name
	end

	-- range in nm
	local mini_SPI_range = AddText_Pos("mini_SPI_"..name.."_range", 
				{{"DL_symbol_range_txt"}},
				{0, 13},
				HMCS_DEFAULT_LEVEL + 1,
				"CenterCenter",
				1)
			
	mini_SPI_range.parent_element = mini_SPI.name
	
	-- unit callsign
	local mini_SPI_callsign = AddText_Pos("mini_SPI_"..name.."_callsign", 
				{{"DL_symbol_callsign_txt"}},
				{0, -10},
				HMCS_DEFAULT_LEVEL + 1,
				"CenterCenter",
				1)
			
	mini_SPI_callsign.parent_element = mini_SPI.name
end

addMiniSPI("mini_SPI_fromflMem", true, {{"mini_SPI_kind", 0}})
addMiniSPI("mini_SPI_fromDonor", false, {{"mini_SPI_kind", 1}})

-- Designated Target - MA Attack Objective
local MA_Objective_width 	= 21
local MA_Objective_width 	= MA_Objective_width / 2
local MA_Objective_y_sz_up 		= 12
local MA_Objective_y_sz_down 	= 8

local MA_objective = AddTexuredElement("MA_objective",
			makeBoxVerts(-MA_Objective_width, MA_Objective_width, -MA_Objective_y_sz_down, MA_Objective_y_sz_up),
			getTexParams(354, 111),
			{{"DL_symbol_kind", 3}, {"DL_symbol_mag_bearing"}},
			{},
			{},
			HMCS_DEFAULT_LEVEL + 1)

if useDBGcolor == true then
	MA_objective.material 	= "INDICATION_HMCS_DBG_DARK"
else
	MA_objective.material 	= "INDICATION_HMCS_RED"
end

MA_objective.parent_element = DL_symbol_placeholder.name

-- Occlusion zone lines
local occlusionZoneMat
if useDBGcolor == true then
	occlusionZoneMat 	= "INDICATION_HMCS_DBG_DARK"
else
	occlusionZoneMat 	= "INDICATION_HMCS_RED"
end

-- Occlusion zone line
do
	local Occlusion_Zone_Line = addPlaceholder("Occlusion_Zone_Line")
	Occlusion_Zone_Line.parent_element = ""
	
	local lineClipLevel = HMCS_DEFAULT_LEVEL
	local lineMaterial = "INDICATION_HMCS_RED"
	addAllscrVarLenLine("Occlusion_Zone_Line", solidLineParams, {{"occlusion_zone_line_pos"}}, "occlusion_zone_line_len", Occlusion_Zone_Line.name, nil, nil, lineClipLevel, lineMaterial)
end
