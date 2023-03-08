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
local item_pos_x_l = -0.82
local item_pos_x_r = 0.11

Name_Arc182Channels = CreateElement "ceStringPoly"
Name_Arc182Channels.name = "Name_Arc182Channels"
Name_Arc182Channels.material = "font_kneeboard"
Name_Arc182Channels.init_pos = {0, getLineY(0), 0}
Name_Arc182Channels.value = _("AN/ARC-182 CHANNELS")
Name_Arc182Channels.alignment = "CenterBottom"
Name_Arc182Channels.stringdefs = font_item_defs
AddElement(Name_Arc182Channels)

for channel = 1,15 do
	local ch_line = start_line + channel
    local pos_y = getLineY(ch_line)

    Arc182ChannelStrL = CreateElement "ceStringPoly"
    Arc182ChannelStrL.name = "Arc182ChannelStrL"..channel
    Arc182ChannelStrL.material = "font_kneeboard"
    Arc182ChannelStrL.init_pos = {item_pos_x_l, pos_y, 0}
    Arc182ChannelStrL.alignment = "LeftBottom"
    Arc182ChannelStrL.stringdefs = font_item_defs
    Arc182ChannelStrL.controllers = {{"arc182_channel_label", channel}}
    AddElement(Arc182ChannelStrL)
	
	Arc182ChannelStrR = CreateElement "ceStringPoly"
    Arc182ChannelStrR.name = "Arc182ChannelStrR"..channel
    Arc182ChannelStrR.material = "font_kneeboard"
    Arc182ChannelStrR.init_pos = {item_pos_x_r, pos_y, 0}
    Arc182ChannelStrR.alignment = "LeftBottom"
    Arc182ChannelStrR.stringdefs = font_item_defs
    Arc182ChannelStrR.controllers = {{"arc182_channel_label", channel+15}}
    AddElement(Arc182ChannelStrR)
end
