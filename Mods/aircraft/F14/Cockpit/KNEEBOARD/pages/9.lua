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

local start_line = 0
local item_pos_x = -0.87

Name_Tacans = CreateElement "ceStringPoly"
Name_Tacans.name = "Name_Tacans"
Name_Tacans.material = "font_kneeboard"
Name_Tacans.init_pos = {0, getLineY(0), 0}
Name_Tacans.value = _("TACAN LIST")
Name_Tacans.alignment = "CenterBottom"
Name_Tacans.stringdefs = font_item_defs
AddElement(Name_Tacans)

-- Labels_FlightPlan = CreateElement "ceStringPoly"
-- Labels_FlightPlan.name = "Labels_FlightPlan"
-- Labels_FlightPlan.material = "font_kneeboard"
-- Labels_FlightPlan.init_pos = {item_pos_x, getLineY(1), 0}
-- Labels_FlightPlan.value = _("         LAT        LON     ALT  MAG VAR")
-- Labels_FlightPlan.alignment = "LeftBottom"
-- Labels_FlightPlan.stringdefs = font_item_defs
-- AddElement(Labels_FlightPlan)

for index = 1,19 do
	local wp_line = start_line + index
    local pos_y = getLineY(wp_line)

    TacanStr = CreateElement "ceStringPoly"
    TacanStr.name = "TacanStr"..index
    TacanStr.material = "font_kneeboard"
    TacanStr.init_pos = {item_pos_x, pos_y, 0}
    TacanStr.alignment = "LeftBottom"
    TacanStr.stringdefs = font_item_defs
    TacanStr.controllers = {{"tacan_line", index-1}}
    AddElement(TacanStr)
end
