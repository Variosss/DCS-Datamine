dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.05

innerNoise 				= getInnerNoise(3E-6, 10) --V/m (dB S+N/N)
-- Frequency tuning accuracy
frequency_accuracy 		= 2000.0			--Hz
-- Receiver bandwidth
band_width				= 19E3				--Hz (3 dB selectivity)
-- Transmitter radiated power
power 					= 5.0				--Watts

-- Receiver frequency response filter quality (filter 'power', defines the freq response curve slopeness)
RxfreqResponseQuality 	= 10				--dimentionless
-- Transmitter spectrum power factor (defines the spectrum curve slopeness)
TxSpectrumPowerFactor  	= 8					--dimentionless
-- Transmitter spectrum bandwidth
TxBandwidth				= 7E3				--Hz

agr = {
	input_signal_deviation		= rangeUtoDb(4E-6, 0.5), --Db
	output_signal_deviation		= 5 - (-4),  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

GUI = {
	range = {min = 118E6, max = 399.975E6, step = 25E3}, --Hz
	displayName = _('VUHF (TRAP-136)'),
	AM = true,
	FM = false
}
