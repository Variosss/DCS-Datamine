dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.2

innerNoise 			= getInnerNoise(4E-6, 10)--V/m (dB S+N/N)
frequency_accuracy 	= 2000.0			--Hz
band_width			= 12E3				--Hz (6 dB selectivity)
power 				= 10.0				--Wt

agr = {
	input_signal_deviation		= rangeUtoDb(5E-6, 0.5), --Db
	output_signal_deviation		= 5,  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

presets = {}

presets[1] = 105000000.0
presets[2] = 139000000.0
presets[3] = 124000000.0
presets[4] = 131000000.0

GUI = {
	displayName = _('SCR522A'),
	AM = true,
	FM = false
}

ElecConsumerParams = {11.5, false, 19, 21}

VHF_CRYSTAL				= 0
VHF_SHORTED_CTL_BOX		= 1
VHF_VT_BURNED_OUT		= 2
VHF_VT207_DEFECTIVE		= 3
VHF_SQUELCH_RELAY		= 4

Damage = {
{Failure = VHF_CRYSTAL, Failure_name = "VHF_CRYSTAL", Failure_editor_name = _("Radio. Crystal or tube failure"),  Element = 3, Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = VHF_SHORTED_CTL_BOX, Failure_name = "VHF_SHORTED_CTL_BOX", Failure_editor_name = _("Radio. Shorted control box"),  Element = -1, Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = VHF_VT_BURNED_OUT, Failure_name = "VHF_VT_BURNED_OUT", Failure_editor_name = _("Radio. Receiver burned out"),  Element = -1, Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = VHF_VT207_DEFECTIVE, Failure_name = "VHF_VT207_DEFECTIVE", Failure_editor_name = _("Radio. Squelch tube burned out"),  Element = -1, Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = VHF_SQUELCH_RELAY, Failure_name = "VHF_SQUELCH_RELAY", Failure_editor_name = _("Radio. Squelch relay not working"),  Element = -1, Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = false -- close lua state after initialization
