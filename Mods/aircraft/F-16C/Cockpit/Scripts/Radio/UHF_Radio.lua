dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.2

innerNoise 				= getInnerNoise(2.5E-6, 10.0)--V/m (dB S+N/N)
-- Frequency tuning accuracy
frequency_accuracy 		= 500.0				--Hz
-- Receiver bandwidth
band_width				= 22E3				--Hz (3 dB selectivity, equivalent of 24KHz for 6 dB selectivity)
-- Transmitter radiated power
power 					= 10.0				--Watts

-- Receiver frequency response filter quality (filter 'power', defines the freq response curve slopeness)
RxfreqResponseQuality 	= 10				--dimentionless
-- Transmitter spectrum power factor (defines the spectrum curve slopeness)
TxSpectrumPowerFactor  	= 8					--dimentionless
-- Transmitter spectrum bandwidth
TxBandwidth				= 7E3				--Hz

goniometer = {isLagElement = true, T1 = 0.3, bias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(1)}}}

agr = {
	input_signal_deviation		= rangeUtoDb(4E-6, 0.5), --Db
	output_signal_deviation		= 5 - (-4),  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

GUI = {
	range = {min = 225E6, max = 399.975E6, step = 25E3}, --Hz
	displayName = _('UHF Radio AN/ARC-164'),
	AM = true,
	FM = false
}

UHF_RADIO_FAILURE_TRANSCEIVER		= 0
UHF_RADIO_FAILURE_ANTENNA_LOWER		= 1
UHF_RADIO_FAILURE_ANTENNA_UPPER		= 2

Damage = {
	{Failure = UHF_RADIO_FAILURE_TRANSCEIVER,	Failure_name = "UHF_RADIO_FAILURE_TRANSCEIVER",		Failure_editor_name = _("UHF radio transceiver failure"),	Element = 1,	Integrity_Treshold = 0.25,	work_time_to_fail_probability = 0.5,	work_time_to_fail = 3600*300},
	{Failure = UHF_RADIO_FAILURE_ANTENNA_LOWER,	Failure_name = "UHF_RADIO_FAILURE_ANTENNA_LOWER",	Failure_editor_name = _("UHF radio lower antenna failure"),	Element = 59,	Integrity_Treshold = 0.9,	work_time_to_fail_probability = 0.5,	work_time_to_fail = 3600*10000},
	{Failure = UHF_RADIO_FAILURE_ANTENNA_UPPER,	Failure_name = "UHF_RADIO_FAILURE_ANTENNA_UPPER",	Failure_editor_name = _("UHF radio upper antenna failure"),	Element = 39,	Integrity_Treshold = 0.9,	work_time_to_fail_probability = 0.5,	work_time_to_fail = 3600*10000}
}

need_to_be_closed = false -- close lua state after initialization 
