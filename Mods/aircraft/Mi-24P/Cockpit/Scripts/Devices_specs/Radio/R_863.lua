dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

frequency_dial = {
	limit = {100E6,399999E3},
	dials = {
		{157,	100.0,	1E7, shift= 10, limit = {10,33}},
		{158,	10.0,	1E6},
		{159,	10.0,	1E5},
		{160,	100.0,	1E3,limit = {0,100}}
	}
}

innerNoise			= getInnerNoise(2.5E-6, 6)
frequency_accuracy 	= 1000.0		--Hz
band_width			= 25E3			--Hz 

power_MW			= 10.0			-- Power in metric range, Watts
power_DMW			= 8.0			-- Power in decimetric range, Watts

-- Presets for channels. Frequencies must be in ranges: 100..150 (MHz) or 220..400 (MHz)
-- ATTENTION! presets works only in old missions, now presets are in ME
presets = {}
presets[1] = 243000000.0
presets[2] = 225000000.0
presets[3] = 235000000.0
presets[4] = 245000000.0
presets[5] = 255000000.0
presets[6] = 265000000.0
presets[7] = 275000000.0
presets[8] = 285000000.0
presets[9] = 295000000.0
presets[10] = 305000000.0
presets[11] = 315000000.0
presets[12] = 325000000.0
presets[13] = 335000000.0
presets[14] = 345000000.0
presets[15] = 355000000.0
presets[16] = 365000000.0
presets[17] = 375000000.0
presets[18] = 385000000.0
presets[19] = 395000000.0
presets[20] = 395000000.0

agr = {
	input_signal_deviation		= 50.0, --Db
	output_signal_deviation		= 5.0,  --Db
	input_signal_linear_zone 	= 10.0,  --Db
	regulation_time				= 0.25, --sec
}

GUI = {
	ranges = { 	{min = 100E6, max = 149975E3, step = 25E3}, --Hz
				{min = 220E6, max = 399975E3, step = 25E3} },
	displayName = _('R-863'),
	AM = true,
	FM = true,
}
