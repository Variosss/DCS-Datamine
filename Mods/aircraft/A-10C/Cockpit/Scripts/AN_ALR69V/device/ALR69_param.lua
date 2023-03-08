dofile(LockOn_Options.common_script_path..'AN_ALR_SymbolsBase.lua')

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt     = 0.2
MaxThreats          = 16
EmitterLiveTime     = 11
EmitterSoundTime    = 0.5
LaunchSoundDelay    = 15.0

RWR_detection_coeff = 0.85

SoundsPath = "Aircrafts/Cockpits/RWR/"
DefaultSearchSnd = SoundsPath .. "SearchNewUS"

-- sounds for radars
acquisition_sounds = 
{
    {EWR_1L13_,             DefaultSearchSnd},
    {EWR_55G6_,             DefaultSearchSnd},
	{S300PS_SR_5N66M,       DefaultSearchSnd},
    {S300PS_SR_64H6E,       DefaultSearchSnd},
    {RLO_9C15MT_,           DefaultSearchSnd},
    {RLO_9C19M2_,           DefaultSearchSnd},
    {Buk_SR_9S18M1,         DefaultSearchSnd},
    {Kub_STR_9S91,          DefaultSearchSnd},
    {Dog_Ear,               DefaultSearchSnd},
    {Roland_rdr,            DefaultSearchSnd},
    {Patriot_STR_ANMPQ_53,  DefaultSearchSnd},
    {Hawk_SR_ANMPQ_50,      DefaultSearchSnd},
    {S300PS_TR_30N6,        DefaultSearchSnd},
    {RLS_5H63C_,            DefaultSearchSnd},
    {RLS_9C32_1_,           DefaultSearchSnd},
    {Hawk_TR_ANMPQ_46,      DefaultSearchSnd},
    {S300V_9A82_,           DefaultSearchSnd},
    {S300V_9A83,            DefaultSearchSnd},
    {Buk_LN_9A310M1,        DefaultSearchSnd},
    {BUK_LL_,               DefaultSearchSnd},
    {Osa_9A33,              DefaultSearchSnd},
    {Tor_9A331,             DefaultSearchSnd},
    {Roland_ADS,            DefaultSearchSnd},
    {Tunguska_2S6,          DefaultSearchSnd},
    {ZSU_23_4_Shilka,       DefaultSearchSnd},
    {Gepard,                DefaultSearchSnd},
    {Vulcan_M163,           DefaultSearchSnd},
	{S125_SR_P_19,          DefaultSearchSnd},
    {S125_TR_SNR,         	DefaultSearchSnd},
	{DEFAULT_TYPE_,         DefaultSearchSnd},
}

DefaultLockSnd = SoundsPath .. "LockNewUS"

lock_sounds = 
{
    {EWR_1L13_,             DefaultLockSnd},
    {EWR_55G6_,             DefaultLockSnd},
    {S300PS_SR_5N66M,       DefaultLockSnd},
    {S300PS_SR_64H6E,       DefaultLockSnd},
    {RLO_9C15MT_,           DefaultLockSnd},
    {RLO_9C19M2_,           DefaultLockSnd},
    {Buk_SR_9S18M1,         DefaultLockSnd},
    {Kub_STR_9S91,          DefaultLockSnd},
    {Dog_Ear,               DefaultLockSnd},
    {Roland_rdr,            DefaultLockSnd},
    {Patriot_STR_ANMPQ_53,  DefaultLockSnd},
    {Hawk_SR_ANMPQ_50,      DefaultLockSnd},
    {S300PS_TR_30N6,        DefaultLockSnd},
    {RLS_5H63C_,            DefaultLockSnd},
    {RLS_9C32_1_,           DefaultLockSnd},
    {Hawk_TR_ANMPQ_46,      DefaultLockSnd},
    {S300V_9A82_,           DefaultLockSnd},
    {S300V_9A83,            DefaultLockSnd},
    {Buk_LN_9A310M1,        DefaultLockSnd},
    {BUK_LL_,               DefaultLockSnd},
    {Osa_9A33,              DefaultLockSnd},
    {Tor_9A331,             DefaultLockSnd},
    {Roland_ADS,            DefaultLockSnd},
    {Tunguska_2S6,          DefaultLockSnd},
    {ZSU_23_4_Shilka,       DefaultLockSnd},
    {Gepard,                DefaultLockSnd},
    {Vulcan_M163,           DefaultLockSnd},
	{S125_SR_P_19,          DefaultLockSnd},
    {S125_TR_SNR,         	DefaultLockSnd},
    {DEFAULT_TYPE_,         DefaultLockSnd},    
}

-- RWR sensors: A10C has four sensors - 2 on nose and 2 in tail
eyes ={}

eyes[1] =
{
    position      = {x = 7.5,y = 0.3,z =  0.2},
    orientation   = {azimuth  = math.rad(45),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[2] =
{
    position      = {x = 7.5,y = 0.3,z = -0.2},
    orientation   = {azimuth  = math.rad(-45),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[3] =
{
    position      = {x = -8.5,y = 0.0,z =  0.2},
    orientation   = {azimuth  = math.rad(135),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[4] =
{
    position      = {x = -8.5,y = 0.0,z =  -0.2},
    orientation   = {azimuth  = math.rad(-135),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}

AN_ALR69V_FAILURE_SENSOR_NOSE_RIGHT = 0
AN_ALR69V_FAILURE_SENSOR_NOSE_LEFT  = 1
AN_ALR69V_FAILURE_SENSOR_TAIL_RIGHT = 2
AN_ALR69V_FAILURE_SENSOR_TAIL_LEFT  = 3
AN_ALR69V_FAILURE_TOTAL         = 4

Damage = {  {Failure = AN_ALR69V_FAILURE_SENSOR_NOSE_RIGHT, Failure_name =  "AN_ALR69V_FAILURE_SENSOR_NOSE_RIGHT", Failure_editor_name = _("AN/ALR-69(V) sensor nose right"),  Element = 0, Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
        {Failure = AN_ALR69V_FAILURE_SENSOR_NOSE_LEFT, Failure_name =  "AN_ALR69V_FAILURE_SENSOR_NOSE_LEFT", Failure_editor_name = _("AN/ALR-69(V) sensor tail right"),  Element = 0, Integrity_Treshold = 0.25, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
        {Failure = AN_ALR69V_FAILURE_SENSOR_TAIL_RIGHT, Failure_name =  "AN_ALR69V_FAILURE_SENSOR_TAIL_RIGHT", Failure_editor_name = _("AN/ALR-69(V) sensor tail left"),  Element = 55, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
        {Failure = AN_ALR69V_FAILURE_SENSOR_TAIL_LEFT, Failure_name =  "AN_ALR69V_FAILURE_SENSOR_TAIL_LEFT", Failure_editor_name = _("AN/ALR-69(V) sensor nose left"),  Element = 55, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
        {Failure = AN_ALR69V_FAILURE_TOTAL, Failure_name =  "AN_ALR69V_FAILURE_TOTAL", Failure_editor_name = _("AN/ALR-69(V) total failure"),  Element = 4, Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}

need_to_be_closed = true -- close lua state after initialization 
