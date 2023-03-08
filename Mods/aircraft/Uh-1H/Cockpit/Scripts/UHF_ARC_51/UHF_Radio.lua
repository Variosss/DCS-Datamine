dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.2

innerNoise 			= getInnerNoise(2.5E-6, 6)--V/m (20 dB S+N/N)
frequency_accuracy 	= 500.0				--Hz
band_width			= 12E3				--Hz (6 dB selectivity)
power 				= 10.0				--Watts

goniometer = {isLagElement = true, T1 = 0.3, bias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(1)}}}

agr = {
	input_signal_deviation		= rangeUtoDb(4E-6, 0.5), --Db
	output_signal_deviation		= 5 - (-4),  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

GUI = {
	range = {min = 225E6, max = 399.975E6, step = 25E3}, --Hz
	displayName = _('UHF'),
	AM = true,
	FM = false
}


-- ATTENTION!!! Presets in this script are only for old missions, now you should set presets in Mission Editor

presets = {}

presets[1] = 225000000.0
presets[2] = 235000000.0
presets[3] = 245000000.0
presets[4] = 255000000.0
presets[5] = 265000000.0
presets[6] = 275000000.0
presets[7] = 285000000.0
presets[8] = 295000000.0
presets[9] = 305000000.0
presets[10] = 315000000.0
presets[11] = 325000000.0
presets[12] = 335000000.0
presets[13] = 345000000.0
presets[14] = 355000000.0
presets[15] = 365000000.0
presets[16] = 375000000.0
presets[17] = 385000000.0
presets[18] = 395000000.0
presets[19] = 396000000.0
presets[20] = 397000000.0

UHF_RADIO_FAILURE_TOTAL	= 0
ARC_51_ANTENNA_DAMAGED = 1

Damage = {	{Failure = UHF_RADIO_FAILURE_TOTAL, Failure_name = "UHF_RADIO_FAILURE_TOTAL", Failure_editor_name = _("UHF radio total failure"),  Element = 4, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
			{Failure = ARC_51_ANTENNA_DAMAGED, Failure_name = "ARC_51_ANTENNA_DAMAGED", Failure_editor_name = _("UHF radio antenna damaged"),  Element = 10, Integrity_Treshold = 0.25, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}

need_to_be_closed = false -- close lua state after initialization 
