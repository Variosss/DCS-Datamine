dofile(LockOn_Options.common_script_path .. "Radio.lua")
dofile(LockOn_Options.common_script_path .. "mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

innerNoise 			= getInnerNoise(4E-6, 10)--V/m (dB S+N/N)
frequency_accuracy 	= 1000.0			--Hz
band_width			= 3E3				--Hz (6 dB selectivity)
power 				= 10.0				--Wt

agr = {
	input_signal_deviation		= rangeUtoDb(5E-6, 0.5), --Db
	output_signal_deviation		= 5,  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

GUI = {
	displayName = _("AN/ARA-8"),
	AM = true,
	FM = false
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
