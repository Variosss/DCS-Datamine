dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
SetScale(FOV)

add_picture(LockOn_Options.script_path.."Resources/IndicationTextures/kneepad.dds")

local gettext = require("i_18n")
_ = gettext.translate

function AddElement(object)
 object.use_mipfilter = true
 Add(object)
end

-- fonts
font_size_item_y = 0.0070
font_size_item_x = 0.5517 * font_size_item_y

font_item_defs = {font_size_item_y, font_size_item_x, -0.0007, 0.0}

local start_line_y = 1.22
local line_size_y = 0.137

local function getLineY(line)
 return start_line_y - line_size_y * (line)
end

local start_line = 1
local item_pos_x = -0.87

Name_FlightPlan = CreateElement "ceStringPoly"
Name_FlightPlan.name = "Name_FlightPlan"
Name_FlightPlan.material = "font_kneeboard"
Name_FlightPlan.init_pos = {0, getLineY(0), 0}
Name_FlightPlan.value = _("REFERENCE POINTS")
Name_FlightPlan.alignment = "CenterBottom"
Name_FlightPlan.stringdefs = font_item_defs
AddElement(Name_FlightPlan)

Labels_FlightPlan = CreateElement "ceStringPoly"
Labels_FlightPlan.name = "Labels_FlightPlan"
Labels_FlightPlan.material = "font_kneeboard"
Labels_FlightPlan.init_pos = {item_pos_x, getLineY(1), 0}
Labels_FlightPlan.value = _("         LAT        LON     ALT  MAG VAR")
Labels_FlightPlan.alignment = "LeftBottom"
Labels_FlightPlan.stringdefs = font_item_defs
AddElement(Labels_FlightPlan)

for wp_index = 1,17 do
	local wp_line = start_line + wp_index
	if wp_index > 10 then
		wp_line = wp_line + 1
	end
    local pos_y = getLineY(wp_line)

    WPCoordsStr = CreateElement "ceStringPoly"
    WPCoordsStr.name = "WPCoordsStr"..wp_index
    WPCoordsStr.material = "font_kneeboard"
    WPCoordsStr.init_pos = {item_pos_x, pos_y, 0}
    WPCoordsStr.alignment = "LeftBottom"
    WPCoordsStr.stringdefs = font_item_defs
    WPCoordsStr.controllers = {{"waypoint_coords", wp_index-1}}
    AddElement(WPCoordsStr)
end
