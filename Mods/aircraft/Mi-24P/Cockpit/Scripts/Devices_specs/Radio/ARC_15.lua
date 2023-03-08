dofile(LockOn_Options.common_script_path..'Radio.lua')

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.2

signal_strength_Bias = {{valmin = 0.0, valmax = 1.0, bias = 0.01}}
signal_strength = {isLagElement = true, valmin = 0.0, valmax = 1.0, T1 = 0.2, bias = signal_strength_Bias}

loop_speed = math.rad(45.0)
loop_speed_manual = math.rad(10.0)
					
--------------------------------
--receiver parameters
innerNoise			= getInnerNoise(7E-6, 6)
frequency_accuracy 	= 100.0			--Hz
band_width			= 1000.0		--Hz

--automatic gain regulator
agr = {
	input_signal_deviation		= 37.0, --Db
	output_signal_deviation		= 3.0,  --Db
	input_signal_linear_zone 	= 5.0,  --Db
	regulation_time				= 0.20, --sec
}

-----------------------------------------
goniometer = {isLagElement = true, T1 = 0.3, bias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(1)}}}

------------------------------------------
need_to_be_closed = true -- lua_state  will be closed in post_initialize()