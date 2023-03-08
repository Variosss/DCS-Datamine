dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
SetScale(FOV)

add_picture(LockOn_Options.script_path.."Resources/IndicationTextures/kneepad_load.dds")

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

Name_InitLoad = CreateElement "ceStringPoly"
Name_InitLoad.name = "Name_InitLoad"
Name_InitLoad.material = "font_kneeboard"
Name_InitLoad.init_pos = {0, initload_pos_y, 0}
Name_InitLoad.value = _("INITIAL LOADOUT")
Name_InitLoad.alignment = "CenterBottom"
Name_InitLoad.stringdefs = font_item_defs
AddElement(Name_InitLoad)

local start_line = 8
local item_pos_x = -0.8

for station = 1,10 do
    local pos_y = getLineY(start_line+station-1)

    PylonStr = CreateElement "ceStringPoly"
    PylonStr.name = "PylonStr"..station
    PylonStr.material = "font_kneeboard"
    PylonStr.init_pos = {item_pos_x, pos_y, 0}
    PylonStr.alignment = "LeftBottom"
    PylonStr.stringdefs = font_item_defs
    PylonStr.controllers = {{"station_loadout", station}}
    AddElement(PylonStr)
end

item_pos_x = 0.52
Cms_Label = CreateElement "ceStringPoly"
Cms_Label.name = "Cms_Label"
Cms_Label.material = "font_kneeboard"
Cms_Label.init_pos = {item_pos_x, getLineY(start_line), 0}
Cms_Label.value = _("CMS")
Cms_Label.alignment = "LeftBottom"
Cms_Label.stringdefs = font_item_defs
AddElement(Cms_Label)

for section = 1,4 do
    local pos_y = getLineY(start_line+section)

    CmsDispenserStr = CreateElement "ceStringPoly"
    CmsDispenserStr.name = "CmsDispenserStr"..section
    CmsDispenserStr.material = "font_kneeboard"
    CmsDispenserStr.init_pos = {item_pos_x, pos_y, 0}
    CmsDispenserStr.alignment = "LeftBottom"
    CmsDispenserStr.stringdefs = font_item_defs
    CmsDispenserStr.controllers = {{"cms_dispenser_loadout", section}}
    AddElement(CmsDispenserStr)
end

Lau138Str = CreateElement "ceStringPoly"
Lau138Str.name = "Lau138Str"
Lau138Str.material = "font_kneeboard"
Lau138Str.init_pos = {item_pos_x, getLineY(start_line+5), 0}
Lau138Str.value = _("LAU-138")
Lau138Str.alignment = "LeftBottom"
Lau138Str.stringdefs = font_item_defs
Lau138Str.controllers = {{"lau138_in_use"}}
AddElement(Lau138Str)
