dofile(LockOn_Options.script_path.."VHF_Radio/device/radio_type.lua")
dofile(LockOn_Options.common_script_path..'Radio.lua')

device_timer_dt		= 0.2

init_time	= 9.0

--radio_type = "AM"

prset_channels = {}
prset_channels[0] = {freq = 251000, modulation = "AM", name = "WING"}
prset_channels[1] = {freq = 124000, modulation = "AM", name = "ATC"}
prset_channels[2] = {freq = 262000, modulation = "AM", name = "ATC"}
prset_channels[3] = {freq = 259000, modulation = "AM", name = "ATC"}
prset_channels[4] = {freq = 127000, modulation = "AM", name = "ATC"}
prset_channels[5] = {freq = 135000, modulation = "AM", name = "ATC"}
prset_channels[6] = {freq = 112250, modulation = "AM", name = "ATC"}
prset_channels[7] = {freq = 123500, modulation = "AM", name = "ATC"}
prset_channels[8] = {freq = 337260, modulation = "AM", name = "ATC"}
prset_channels[9] = {freq = 350050, modulation = "FM"}
prset_channels[10] = {freq = 243975, modulation = "FM"}
prset_channels[11] = {freq = 173000, modulation = "FM"}
prset_channels[12] = {freq = 119075, modulation = "AM"}
prset_channels[13] = {freq = 119025, modulation = "AM"}
prset_channels[14] = {freq = 142675, modulation = "FM"}
prset_channels[15] = {freq = 169500, modulation = "FM"}
prset_channels[16] = {freq = 317000, modulation = "AM"}
prset_channels[17] = {freq = 236775, modulation = "AM"}
prset_channels[18] = {freq = 278000, modulation = "AM"}
prset_channels[19] = {freq = 320000, modulation = "AM"}
prset_channels[20] = {freq = 225000, modulation = "AM"}
prset_channels[21] = {freq = 225000, modulation = "AM"}
prset_channels[22] = {freq = 225000, modulation = "AM"}
prset_channels[23] = {freq = 225000, modulation = "AM"}
prset_channels[24] = {freq = 110000, modulation = "AM"}
prset_channels[25] = {freq = 110000, modulation = "AM"}
prset_channels[26] = {freq = 110000, modulation = "AM"}
prset_channels[27] = {freq = 360000, modulation = "FM"}
prset_channels[28] = {freq = 360000, modulation = "FM"}
prset_channels[29] = {freq = 300000, modulation = "FM"}


radio_type = VHF_radio_type.AM_Radio


local gettext = require("i_18n")
_ = gettext.translate


frequency_dialer = {{143,20.0},{144,10.0},{145,10.0},{146,100.0}}

innerNoise 			= getInnerNoise(3E-6, 10)--V/m (dB S+N/N)
innerNoise_108_116_MHz_coeff = 1.2
frequency_accuracy 	= 2.0				--KHz
band_width			= 19E3				--Hz (6 dB selectivity)
power 				= 10.0				--Wt

agr = {
	input_signal_deviation		= rangeUtoDb(4E-6, 0.5), --Db
	output_signal_deviation		= 5 - (-4),  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

GUI = {
	range = {min = 30E6, max = 400.95E6, step = 25E3}, --Hz
	displayName = _('VHF AM (ARC-210)'),
	AM = true,
	FM = true
}

VHF_UHF_RADIO_FAILURE_TOTAL	= 0

Damage = {	{Failure = VHF_UHF_RADIO_FAILURE_TOTAL, Failure_name = "VHF_UHF_RADIO_FAILURE_TOTAL", Failure_editor_name = _("VHF UHF radio total failure"),  Element = 59, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}

need_to_be_closed = false -- close lua state after initialization 