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

local initload_pos_y = getLineY(0)

Name_TDS = CreateElement "ceStringPoly"
Name_TDS.name = "Name_TDS"
Name_TDS.material = "font_kneeboard"
Name_TDS.init_pos = {0, initload_pos_y, 0}
Name_TDS.value = _("TACTICAL DATALINK SYSTEMS")
Name_TDS.alignment = "CenterBottom"
Name_TDS.stringdefs = font_item_defs
AddElement(Name_TDS)

local start_line = 2
local item_pos_x = -0.9

submodel = get_aircraft_type()
if submodel ~= "F-14A-95-GR" then
    for tds_entry = 1,18 do
        local pos_y = getLineY(start_line+tds_entry-1)

        TDS_Str = CreateElement "ceStringPoly"
        TDS_Str.name = "TDS_Str"..tds_entry
        TDS_Str.material = "font_kneeboard"
        TDS_Str.init_pos = {item_pos_x, pos_y, 0}
        TDS_Str.alignment = "LeftBottom"
        TDS_Str.stringdefs = font_item_defs
        TDS_Str.controllers = {{"tds_entry", tds_entry}}
        AddElement(TDS_Str)
    end
else
    local warn_pos_y = getLineY(9)
    Name_DLWarn = CreateElement "ceStringPoly"
    Name_DLWarn.name = "Name_DLWarn"
    Name_DLWarn.material = "font_general_red"
    Name_DLWarn.init_pos = {0, warn_pos_y, 0}
    Name_DLWarn.value = _("NOT AVAILABLE")
    Name_DLWarn.alignment = "CenterBottom"
    Name_DLWarn.stringdefs = font_item_defs
    AddElement(Name_DLWarn)
end
