dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.2

innerNoise 			= getInnerNoise(2.5E-6, 10.0)--V/m (dB S+N/N)
frequency_accuracy 	= 500.0				--Hz
band_width			= 12E3				--Hz (6 dB selectivity)
power 				= 10.0				--Watts

agr = {
	input_signal_deviation		= rangeUtoDb(4E-6, 0.5), --Db
	output_signal_deviation		= 5 - (-4),  --Db
	input_signal_linear_zone 	= 10.0, --Db
	regulation_time				= 0.25, --sec
}

GUI = {
	range = {min = 225E6, max = 399.975E6, step = 25E3}, --Hz
	displayName = _('UHF ARC-159'),
	AM = true,
	FM = false
}

presets = {}
if get_aircraft_mission_data ~= nil then
    local  radio_from_mission = get_aircraft_mission_data("Radio")
    local  uhf_radio = radio_from_mission[1]
    if uhf_radio then
        for i = 1,20 do
            presets[i] = (uhf_radio.channels[i] or 225 ) * 1e6
        end
    end
end

--goniometer = {isLagElement = true, T1 = 0.3, bias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(1)}}}

UHF_ARC_159_FAILURE_TOTAL = 0
UHF_ARC_159_FAILURE_DISPLAY = 1
UHF_ARC_159_FAILURE_REMOTE_DISPLAY = 2
UHF_ARC_159_FAILURE_REMOTE_DISPLAY_RIO = 3
UHF_ARC_159_FAILURE_INTERNAL_MODULE = 4
UHF_ARC_159_FAILURE_TRANSCEIVER = 5
UHF_ARC_159_FAILURE_ANTENNA = 6

Damage = { {Failure = UHF_ARC_159_FAILURE_TOTAL, Failure_name = "UHF_ARC_159_FAILURE_TOTAL", Failure_editor_name = _("UHF AN/ARC-159: Total"), Element = "AVX_WALL_LEFT_REAR", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = UHF_ARC_159_FAILURE_DISPLAY, Failure_name ="UHF_ARC_159_FAILURE_DISPLAY", Failure_editor_name = _("UHF AN/ARC-159: Display"), Element = "AVX_WALL_LEFT_FRONT", Integrity_Treshold = 0.6, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = UHF_ARC_159_FAILURE_REMOTE_DISPLAY, Failure_name = "UHF_ARC_159_FAILURE_REMOTE_DISPLAY", Failure_editor_name = _("UHF AN/ARC-159: Remote Display Pilot"), Element = "DASHBOARD_PILOT", Integrity_Treshold = 0.8, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = UHF_ARC_159_FAILURE_REMOTE_DISPLAY_RIO, Failure_name = "UHF_ARC_159_FAILURE_REMOTE_DISPLAY_RIO", Failure_editor_name = _("UHF AN/ARC-159: Remote Display RIO"), Element = "DASHBOARD_RIO", Integrity_Treshold = 0.8, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = UHF_ARC_159_FAILURE_INTERNAL_MODULE, Failure_name = "UHF_ARC_159_FAILURE_INTERNAL_MODULE", Failure_editor_name = _("UHF AN/ARC-159: Internal Module"), Element = "AVX_WALL_LEFT_REAR", Integrity_Treshold = 0.25, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = UHF_ARC_159_FAILURE_TRANSCEIVER, Failure_name = "UHF_ARC_159_FAILURE_TRANSCEIVER", Failure_editor_name = _("UHF AN/ARC-159: Transceiver"), Element = "AVX_WALL_LEFT_REAR", Integrity_Treshold = 0.25, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = UHF_ARC_159_FAILURE_ANTENNA, Failure_name = "UHF_ARC_159_FAILURE_ANTENNA", Failure_editor_name = _("UHF AN/ARC-159: Antenna"), Element = "UHF_IFF", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250}
}

need_to_be_closed = true -- close lua state after initialization 
