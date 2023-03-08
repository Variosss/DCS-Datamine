dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.2

min_search_time = 0.0
max_search_time = 0.0

-- Receiver
innerNoise			= getInnerNoise(2.5E-6, 6)
frequency_accuracy 	= 40.0		--Hz
band_width			= 15000.0	--Hz 
power				= 500.0		-- Watt

presets = {}
presets[ 1] = 305000000.0
presets[ 2] = 264000000.0
presets[ 3] = 265000000.0
presets[ 4] = 256000000.0
presets[ 5] = 254000000.0
presets[ 6] = 250000000.0
presets[ 7] = 270000000.0
presets[ 8] = 257000000.0
presets[ 9] = 255000000.0
presets[10] = 262000000.0
presets[11] = 259000000.0
presets[12] = 268000000.0
presets[13] = 269000000.0
presets[14] = 260000000.0
presets[15] = 263000000.0
presets[16] = 261000000.0
presets[17] = 267000000.0
presets[18] = 251000000.0
presets[19] = 253000000.0
presets[20] = 266000000.0

agr = {
	input_signal_deviation		= 50.0, --Db
	output_signal_deviation		= 5.0,  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

GUI = {
	displayName = _('COMM1: ARC-210'),
	AM = true,
	FM = true,
}


need_to_be_closed = true -- close lua state after initialization 