dofile(LockOn_Options.common_script_path..'AN_ALR_SymbolsBase.lua')

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt     = 0.2
MaxThreats          = 16
EmitterLiveTime     = 11
EmitterSoundTime    = 0.5
LaunchSoundDelay    = 15.0

RWR_detection_coeff = 0.85

-- sounds for radars
SoundsPath = "Aircrafts/F-5E/Cockpit/RWR/"
DefaultGuidedSnd = SoundsPath .. "750Hz"
DefaultSearchSnd = SoundsPath .. "1500Hz"
DefaultOnboardSnd = SoundsPath .. "1744Hz"
DefaultCannonSnd = SoundsPath .. "1974Hz"

-- RWR sensors: F-16C has four sensors - 2 on nose and 2 in tail
eyes ={}

eyes[1] =
{
    position      = {x = 6.7,y = -0.1,z =  0.35},
    orientation   = {azimuth  = math.rad(45),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[2] =
{
    position      = {x = 6.7,y = -0.1,z = 0.35},
    orientation   = {azimuth  = math.rad(-45),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[3] =
{
    position      = {x = -5.5,y = 0.15,z =  0.6},
    orientation   = {azimuth  = math.rad(135),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[4] =
{
    position      = {x = -5.5,y = 0.15,z =  -0.6},
    orientation   = {azimuth  = math.rad(-135),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}

AN_ALR56_FAILURE_SENSOR_NOSE_RIGHT = 0
AN_ALR56_FAILURE_SENSOR_NOSE_LEFT  = 1
AN_ALR56_FAILURE_SENSOR_TAIL_RIGHT = 2
AN_ALR56_FAILURE_SENSOR_TAIL_LEFT  = 3
AN_ALR56_FAILURE_TOTAL         = 4

Damage = {  {Failure = AN_ALR56_FAILURE_SENSOR_NOSE_RIGHT,	Failure_name =  "AN_ALR56_FAILURE_SENSOR_NOSE_RIGHT",	Failure_editor_name = _("AN/ALR-56 sensor nose right"),	Element = 0,  Integrity_Treshold = 0.0,  work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
			{Failure = AN_ALR56_FAILURE_SENSOR_NOSE_LEFT,	Failure_name =  "AN_ALR56_FAILURE_SENSOR_NOSE_LEFT",	Failure_editor_name = _("AN/ALR-56 sensor tail right"),	Element = 0,  Integrity_Treshold = 0.25, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
			{Failure = AN_ALR56_FAILURE_SENSOR_TAIL_RIGHT,	Failure_name =  "AN_ALR56_FAILURE_SENSOR_TAIL_RIGHT",	Failure_editor_name = _("AN/ALR-56 sensor tail left"),	Element = 55, Integrity_Treshold = 0.5,  work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
			{Failure = AN_ALR56_FAILURE_SENSOR_TAIL_LEFT,	Failure_name =  "AN_ALR56_FAILURE_SENSOR_TAIL_LEFT",	Failure_editor_name = _("AN/ALR-56 sensor nose left"),	Element = 55, Integrity_Treshold = 0.5,  work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
			{Failure = AN_ALR56_FAILURE_TOTAL,				Failure_name =  "AN_ALR56_FAILURE_TOTAL",				Failure_editor_name = _("AN/ALR-56 total failure"),		Element = 4,  Integrity_Treshold = 0.0,  work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}

need_to_be_closed = true -- close lua state after initialization 
