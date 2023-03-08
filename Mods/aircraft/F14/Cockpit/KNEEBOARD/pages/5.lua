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

Name_Arc159Channels = CreateElement "ceStringPoly"
Name_Arc159Channels.name = "Name_Arc159Channels"
Name_Arc159Channels.material = "font_kneeboard"
Name_Arc159Channels.init_pos = {0, getLineY(0), 0}
Name_Arc159Channels.value = _("AN/ARC-159 CHANNELS")
Name_Arc159Channels.alignment = "CenterBottom"
Name_Arc159Channels.stringdefs = font_item_defs
AddElement(Name_Arc159Channels)

for channel = 1,10 do
	local ch_line = start_line + channel
    local pos_y = getLineY(ch_line)

    Arc159ChannelStrL = CreateElement "ceStringPoly"
    Arc159ChannelStrL.name = "Arc159ChannelStrL"..channel
    Arc159ChannelStrL.material = "font_kneeboard"
    Arc159ChannelStrL.init_pos = {item_pos_x_l, pos_y, 0}
    Arc159ChannelStrL.alignment = "LeftBottom"
    Arc159ChannelStrL.stringdefs = font_item_defs
    Arc159ChannelStrL.controllers = {{"arc159_channel_label", channel}}
    AddElement(Arc159ChannelStrL)
	
	Arc159ChannelStrR = CreateElement "ceStringPoly"
    Arc159ChannelStrR.name = "Arc159ChannelStrR"..channel
    Arc159ChannelStrR.material = "font_kneeboard"
    Arc159ChannelStrR.init_pos = {item_pos_x_r, pos_y, 0}
    Arc159ChannelStrR.alignment = "LeftBottom"
    Arc159ChannelStrR.stringdefs = font_item_defs
    Arc159ChannelStrR.controllers = {{"arc159_channel_label", channel+10}}
    AddElement(Arc159ChannelStrR)
end
