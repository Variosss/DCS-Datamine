dofile(LockOn_Options.script_path.."TEWS/indicator/RWR_ALR67_Common_definitions.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

---------------------------- RWR Azimuth Display ---------------------------------
local status_circle_radius		= 70
local lethality_circle_radius	= 224
local outer_circle_radius		= 400
addStrokeCircle("EW_Status_circle", 	status_circle_radius,	 {0, 0}, nil)
addStrokeCircle("EW_Lethality_circle", 	lethality_circle_radius, {0, 0}, nil)
addStrokeCircle("EW_Outer_circle", 		outer_circle_radius,	 {0, 0}, nil)

local dash_length = 20
local dash_radius = outer_circle_radius + dash_length/2 + 4
for i = 0, 23 do
	addStrokeLine("EW_dash_"..i, dash_length, {math.sin(math.rad(i * 15)) * dash_radius, math.cos(math.rad(i * 15)) * dash_radius}, -i*15, nil)
end

local bold_dash_length = 86
local function addBoldLine(name, dX, dY)
	for i = 0, 2 do
		addStrokeLine("EW_bold_dash_"..name.."_"..i, bold_dash_length, {(outer_circle_radius + bold_dash_length*0.45)*dX, (dash_length*1.2 + 2*i)*dY}, dX*90, nil)
	end
end

addBoldLine("rh_up",  1,  1)
addBoldLine("rh_dn",  1, -1)
addBoldLine("lh_up", -1,  1)
addBoldLine("lh_dn", -1, -1)


-------------------------------------- Menu --------------------------------------
add_PB_label(9, {"ARM", nil, {{"MPD_EW_ARM_label"}}})
add_PB_label(19, "MODE")
