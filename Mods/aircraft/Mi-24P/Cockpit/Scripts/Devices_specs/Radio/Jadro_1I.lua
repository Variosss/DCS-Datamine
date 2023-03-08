dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.2

frequency_dial = {limit = {2E6,179999E2}, dials = {{435,10.0,1E7},{434,10.0,1E6},{433,10.0,1E5},{432,10.0,1E4},{431,10.0,1E3},{430,10.0,1E2}}}

power_2_12 			= 100.0		--Watts
power_12_18 		= 50.0		--Watts

power	= 50.0	-- Watts

min_search_time = 1.0
max_search_time = 7.0

ElecConsumerParamsLight = {1.0, true, 2.0, 3.0, 28.0}
ElecLampParamsLight		= {brightnessMinVal = 0.5}

--Receiver
innerNoise			= getInnerNoise(2.5E-6, 6)
frequency_accuracy 	= 4.0		--Hz
band_width			= 100.0		--Hz 

agr = {
	input_signal_deviation		= 50.0, --Db
	output_signal_deviation		= 5.0,  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

staticNoises = {
    {
        effect = {"Aircrafts/Cockpits/Static"},
    },
    {
        filter = {1, 2, 2e6, 3e6},
        effect = {"Aircrafts/Cockpits/Atmospheric"},
    },
}

GUI = {
	range = {min = 2E6, max = 17.999E6, step = 100}, --Hz
	displayName = _('Jadro-1A'),
	AM = true,
	FM = false,
}

JADRO_FAILURE_TOTAL	= 0

Damage = {	{Failure = JADRO_FAILURE_TOTAL, Failure_name = "JADRO_1A_FAILURE_TOTAL", Failure_editor_name = _("Jadro 1A radio total failure"),  Element = 5, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}


need_to_be_closed = false -- close lua state after initialization 
