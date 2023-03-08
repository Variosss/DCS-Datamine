dofile(LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/Indicator/definitions.lua")

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
INDICATOR_LEVEL = RADIO_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

SetScale(FOV)

local half_width   = GetScale()
local half_height  = GetAspect() * half_width
local aspect       = GetAspect()

local grid_origin = create_origin()
grid_origin.init_pos		= {-0.04, 0, -0.02}
grid_origin.init_rot		 = {-0.52, 0, 0}

local fontsizey = 0.27 * GetScale()  
local fontsizex = 0.16 * GetScale()
local fontshift = -0.032 * GetScale()

freqchart_stringdef   = {fontsizey, fontsizex, fontshift, 0}

function CreateChannelString( col, row, xshift, yshift )
	local posx = 0.55 * (col - 1.5) + xshift - 0.025
	local posy = 0.095 * (3.0 - row) - 0.047 + yshift
	local ch = col * 5 + row + 1
	local channel_text           = CreateElement "ceStringPoly"
		channel_text.name            = create_guid_string()
		channel_text.material        = "font_radio_freq_chart"
		channel_text.parent_element = grid_origin.name
		channel_text.stringdefs    = freqchart_stringdef
		channel_text.init_pos = {posx,posy}
		channel_text.alignment     = "CenterCenter"
		channel_text.controllers = {{"arc159channel_label",ch}}
		channel_text.isdraw = true
		channel_text.use_mipfilter = true
		channel_text.additive_alpha = false
	Add(channel_text)
end

CreateChannelString( 0, 0, -0.0107, -0.0007)
CreateChannelString( 0, 1, -0.0110, 0.0019)
CreateChannelString( 0, 2, -0.0117, 0.0014)
CreateChannelString( 0, 3, -0.0136, 0.0003)
CreateChannelString( 0, 4, -0.0138, -0.0002)
CreateChannelString( 1, 0, -0.0024, 0.0014)
CreateChannelString( 1, 1, -0.0055, 0.0009)
CreateChannelString( 1, 2, -0.0064, 0.0012)
CreateChannelString( 1, 3, -0.0042, 0.0012)
CreateChannelString( 1, 4, -0.0016, -0.0002)
CreateChannelString( 2, 0, 0.0120, 0.0019)
CreateChannelString( 2, 1, 0.0111, -0.0010)
CreateChannelString( 2, 2, 0.0094, -0.0016)
CreateChannelString( 2, 3, 0.0125, 0.0007)
CreateChannelString( 2, 4, 0.0123, -0.0018)
CreateChannelString( 3, 0, 0.0022, 0.0018)
CreateChannelString( 3, 1, 0.0001, -0.0012)
CreateChannelString( 3, 2, 0.0003, -0.0019)
CreateChannelString( 3, 3, 0.0013, -0.0020)
CreateChannelString( 3, 4, 0.0000, 0.0018)


