dofile(LockOn_Options.common_script_path..'Radio.lua')

local gettext = require("i_18n")
_ = gettext.translate

radio_type = 0

device_timer_dt = 0.2

-- frequency dialer window [arg, k] digit = arg_value * k
frequency_dialer = {{157,20.0},{158,10.0},{159,10.0},{160,100.0}}

innerNoise 			= getInnerNoise(0.75E-6, 10)--V/m (dB S+N/N)
innerNoise_108_116_MHz_coeff = 1.2
frequency_accuracy 	= 2000.0			--Hz
band_width			= 19E3				--Hz (6 dB selectivity)
power 				= 10.0				--Wt

agr = {
	input_signal_deviation		= rangeUtoDb(4E-6, 0.5), --Db
	output_signal_deviation		= 5 - (-4),  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

GUI = {
	range = {min = 30E6, max = 76E6, step = 25E3}, --Hz
	displayName = (_'VHF FM'),
	AM = false,
	FM = true
}

VHF_RADIO_FAILURE_TOTAL	= 0

Damage = {	{Failure = VHF_RADIO_FAILURE_TOTAL, Failure_name = "VHF_FM_RADIO_FAILURE_TOTAL", Failure_editor_name = _("VHF FM radio total failure"),  Element = 10, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}

need_to_be_closed = false -- close lua state after initialization 