dofile(LockOn_Options.common_script_path..'Radio.lua')

local gettext = require("i_18n")
_ = gettext.translate

ElecConsumerParamsSingLight = {0.5, true}

--------------------------------
--receiver parameters
innerNoise			= getInnerNoise(7E-6, 6)
frequency_accuracy 	= 500			--Hz
band_width			= 25E3			--Hz

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
ElecConsumerParamsDC = 
{
	2.0, 			-- load DC current ARK U2, [A]
	true,
	19.0,			-- DC voltage value after which the ARK U2 is off, [V]
	22.0, 			-- DC voltage value after which the ARK U2 is on, [V]
	27.0			-- nominal DC voltage value ARK U2, [V]
 }

ElecConsumerParamsAC = 
{
	1.0, 			-- load AC current ARK U2, [A]
	true,
	100.0,			-- AC voltage value after which the ARK U2 is off, [V]
	110.0, 			-- AC voltage value after which the ARK U2 is on, [V]
	115.0			-- nominal AC voltage value ARK U2, [V]
 }
 
need_to_be_closed = true -- lua_state  will be closed in post_initialize()