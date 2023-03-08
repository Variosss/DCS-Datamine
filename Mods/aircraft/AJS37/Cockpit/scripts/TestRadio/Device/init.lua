dofile(LockOn_Options.common_script_path..'Radio.lua')

local gettext = require("i_18n")
_ = gettext.translate

power 				= 10.0			--Watts
presets = {}
presets[1]  = 123 * 1e6 --MHz
presets[2]  = 123 * 1e6 --MHz
presets[3]  = 123 * 1e6 --MHz
presets[4]  = 123 * 1e6 --MHz


GUI = {
	displayName = _('AM Radio'),
	AM = true,
	FM = false,
}

GUI.channels = presets

--settings 
squelch = true
volume	=	0.5
channel = 0

max_search_time = 5.0

need_to_be_closed = true