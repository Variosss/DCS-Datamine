-- Gyromagnetic compass set AN/ASN-43
-- Indicator (ID-998/ASN)

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.012

DriftRate		= math.rad(5.0)/3600 -- The gyroscope free drift rate not exceed 5.5 deg per hour for any heading (MIL-G-45279 GYRO, DIRECTIONAL CN-998( )_ASN-43)

SlavingRate 	= math.rad(3.0)/60 --slaving rate is 2.5 +/- 1 per minute (Operator_s_and_organizational_maintenance)
SyncRate 		= math.rad(45.0) --45 degr per second


heading_and_needles_Bias = {{valmin = math.rad(0.0), valmax = math.rad(360.0), bias = math.rad(1.0)}}
heading_and_needles = {isLagElement = true, valmin = math.rad(0.0), valmax = math.rad(360.0), T1 = 0.2, bias = heading_and_needles_Bias}

warn_flag_d_value	= 11.0
warn_flag_value_min	= 0.0
warn_flag_value_max	= 1.0

annun_flag_d_value	= 11.0
annun_flag_value_min= -1.0
annun_flag_value_max= 1.0

--------------------------------------------------------
GMC_TOTAL_FAILURE		= 0
GMC_GYRO_FAILURE		= 1
GMC_MAGN_COMP_FAILURE	= 2

Damage = {	
{Failure = GMC_TOTAL_FAILURE, 	  Failure_name = "GMC_TOTAL_FAILURE", Failure_editor_name = _("GMC total failure"),  Element = 5, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = GMC_GYRO_FAILURE, 	  Failure_name = "GMC_GYRO_FAILURE", Failure_editor_name = _("GMC directional gyro failure"),  Element = 56, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
{Failure = GMC_MAGN_COMP_FAILURE, Failure_name = "GMC_MAGN_COMP_FAILURE", Failure_editor_name = _("GMC magnetic compass failure"),  Element = 56, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}
need_to_be_closed = true -- lua_state  will be closed in post_initialize()