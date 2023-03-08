dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.2

innerNoise 			= getInnerNoise(2.5E-6, 6)--V/m (20 dB S+N/N)
frequency_accuracy 	= 500.0				--Hz
band_width			= 12E3				--Hz (6 dB selectivity)
power 				= 10.0				--Watts

agr = {
	input_signal_deviation		= rangeUtoDb(4E-6, 0.5), --Db
	output_signal_deviation		= 5 - (-4),  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

ARN_82_FAILURE_TOTAL	= 0
ARN_82_VOR_ANT_FAILURE	= 1

Damage = {	
	{Failure = ARN_82_FAILURE_TOTAL, Failure_name = "ARN_82_FAILURE_TOTAL", Failure_editor_name = _("Radio nav. set total failure"),  Element = 5, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}
	--{Failure = ARN_82_VOR_ANT_FAILURE, Failure_name = "ARN_82_VOR_ANT_FAILURE", Failure_editor_name = _("VOR ant. failure"),  Element = 56, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}
}

need_to_be_closed = true -- close lua state after initialization 
