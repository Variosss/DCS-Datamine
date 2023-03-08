dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

innerNoise			= getInnerNoise(2.5E-6, 6)
frequency_accuracy 	= 1000.0		--Hz
band_width			= 25000.0		--Hz (6 dB selectivity)
power 				= 10.0			--Watts

agr = {
	input_signal_deviation		= 50.0, --Db
	output_signal_deviation		= 5.0,  --Db
	input_signal_linear_zone 	= 10.0,  --Db
	regulation_time				= 0.25, --sec
}

presets = {}
presets[1] = 21500000.0 -- frequency in Hz
presets[2] = 25675000.0 -- radio Mayak
presets[3] = 27000000.0
presets[4] = 28000000.0
presets[5] = 30000000.0
presets[6] = 32000000.0 
presets[7] = 40000000.0
presets[8] = 50000000.0
presets[9] = 55525000.0
presets[10] = 59975000.0 

ElecConsumerParamsLight = {0.5, true}

GUI = {
	displayName = _('R-828'),
	AM = false,
	FM = true,
}

GUI.channels = presets

--settings 
squelch = true
volume	=	0.5
channel = 0

max_search_time = 5.0


TRANSIVER_FAILURE = 0
ANTENNA_FAILURE = 1
Damage = {	{Failure = TRANSIVER_FAILURE, Element = 4, Integrity_Treshold = 0.3}, 
			{Failure = ANTENNA_FAILURE, Element = 58}}

need_to_be_closed = false -- close lua state after initialization 