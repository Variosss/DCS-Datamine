dofile(LockOn_Options.common_script_path..'Radio.lua')

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.2

signal_strength_Bias = {{valmin = 0.0, valmax = 1.0, bias = 0.01}}
signal_strength = {isLagElement = true, valmin = 0.0, valmax = 1.0, T1 = 0.2, bias = signal_strength_Bias}

loop_low_speed = math.rad(180/30)
loop_high_speed = math.rad(180/15)

max_tune_arg = 0.55

scale_concordance_19_40	=	{{0.0, 19.0},
							 {0.026, 19.5},
							 {0.05, 20.0},
							 {0.076, 21.0}, 
							 {0.55,40.0}}
					 
scale_concordance_40_85	 =	{{0.0, 40.0},
							 {0.027, 41.0},
							 {0.054, 42.0},
							 {0.083, 42.5},
							 {0.111, 45.0},
							 {0.55,85.0}}

scale_concordance_85_180 =	{{0.0, 85.0}, 
							{0.027,87.5}, 
							{0.056, 90.0},
							{0.083, 95.0},
							{0.55,	180.0}}								
--------------------------------
--receiver parameters
innerNoise			= getInnerNoise(2.5E-6, 6)
frequency_accuracy 	= 100.0			--Hz
band_width			= 1000.0		--Hz

--automatic gain regulator
agr = {
	input_signal_deviation		= 37.0, --Db
	output_signal_deviation		= 0.3,  --Db
	input_signal_linear_zone 	= 5.0,  --Db
	regulation_time				= 0.20, --sec
}

-----------------------------------------
goniometer = {isLagElement = true, T1 = 0.3, bias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(1)}}}


accuracy = 2.0

mountainEffect = true
shorelineEffect = false --not implemented
nightEffect = true
-----------------------------------------

ARN_83_TOTAL_FAILURE	= 0
ARN_83_ADF_DAMAGE		= 1
ARN_83_ANT_DAMAGE		= 2

Damage = {	
{Failure = ARN_83_TOTAL_FAILURE, Failure_name = "ARN_83_TOTAL_FAILURE", Failure_editor_name = _("ADF set total failure"),  Element = 56, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = ARN_83_ADF_DAMAGE, Failure_name = "ARN_83_ADF_DAMAGE", Failure_editor_name = _("ADF goniometer failure"),  Element = 5, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = ARN_83_ANT_DAMAGE, Failure_name = "ARN_83_ANT_DAMAGE", Failure_editor_name = _("ADF antenna damaged"),  Element = 56, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()