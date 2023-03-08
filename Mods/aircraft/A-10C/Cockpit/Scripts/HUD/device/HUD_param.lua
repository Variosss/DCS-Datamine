local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt	= 0.2

TFOV    = 170
ZSL     = 158.64068
PDAngle = 28.0
StandByT= 0.1	
tau_1 = 0.1
T = 0.1

IFF_Alert_interval_step = 30*60 --sec

--[[
function quickening_nightmare(Vx, Vy, Vz, psi, teta, phi)
	el_VV = math.atan2(Vy, math.sqrt(Vx * Vx + Vz * Vz))
	az_VV = math.atan2(Vz, Vx)
	
	sin_phi = math.sin(phi)
	cos_phi = math.cos(phi)
	
	Alpha = az_VV * sin_phi + el_VV * cos_phi
	Slide = az_VV * cos_phi - el_VV * sin_phi
	
    return Alpha, Slide
end

function quickening_after_action(Alpha, Slide)
    return Alpha * 1000 + ZSL, Slide * 1000
end
--]]

page_names = {}
function set_page_name (mode,name)
	
	local L1 = mode[1] or 0
	local L2 = mode[2] or 0
	local L3 = mode[3] or 0
	local L4 = mode[4] or 0
	
	if page_names[L1] == nil then
	   page_names[L1] =  {}
	end
	if page_names[L1][L2] == nil then
	   page_names[L1][L2] =  {}
	end
	if page_names[L1][L2][L3] == nil then
	   page_names[L1][L2][L3] =  {}
	end
	page_names[L1][L2][L3][L4] = name
	
end

-- master modes
A10C_HUD_OFF			= 0
A10C_HUD_NAV			= 1 
A10C_HUD_GUNS			= 2
A10C_HUD_CCIP			= 3
A10C_HUD_CCRP			= 4
A10C_HUD_AIR_TO_AIR		= 5
A10C_HUD_TEST			= 6
A10C_HUD_STANDBY	 	= 7
A10C_HUD_TEST_POWER_ON 	= 8

-- level 2
A10C_HUD_TEST_GROUND_BIT		= 1
A10C_HUD_TEST_INFLT_BIT			= 2
A10C_HUD_TEST_BIT_FAULT_DISP	= 3
A10C_HUD_TEST_AAS				= 4
A10C_HUD_TEST_WEAPONS			= 5
A10C_HUD_TEST_WPN_REL_DATA		= 6
A10C_HUD_TEST_DISPLAY_MODES		= 7
A10C_HUD_TEST_MAINTENANCE		= 8
A10C_HUD_TEST_DELTA_CAL			= 9
A10C_HUD_TEST_GCAS_BIT			= 10
A10C_HUD_TEST_PREFLIGHT_BIT		= 11
A10C_HUD_TEST_GCAS_TRAINING		= 12
A10C_HUD_TEST_IFF_ALERT			= 13
A10C_HUD_TEST_WPN_RELEASE		= 14
A10C_HUD_TEST_VMU_BIT			= 15

-- level 3
A10C_HUD_TEST_AAS_MAN_FXD		= 1
A10C_HUD_TEST_AAS_MAN_RTY		= 2

A10C_HUD_TEST_WPNS_30MM			= 1
A10C_HUD_TEST_WPNS_OFFSET_ADJ	= 2

A10C_HUD_TEST_GCAS_CAPTURE		= 1

A10C_HUD_TEST_WPN_REL_GUNS		= 1
A10C_HUD_TEST_WPN_REL_CCIP		= 2
A10C_HUD_TEST_WPN_REL_CCRP		= 3
A10C_HUD_TEST_WPN_REL_MAV		= 4

set_page_name({A10C_HUD_OFF},		  												"OFF")
set_page_name({A10C_HUD_NAV},		  												"NAV")
set_page_name({A10C_HUD_GUNS},		  												"GUNS")
set_page_name({A10C_HUD_CCIP},	  													"CCIP")
set_page_name({A10C_HUD_CCRP},	  													"CCRP")
set_page_name({A10C_HUD_AIR_TO_AIR},	  											"AIR_TO_AIR")
set_page_name({A10C_HUD_TEST}, 														"TEST")
set_page_name({A10C_HUD_STANDBY}, 													"STANDBY")
set_page_name({A10C_HUD_TEST_POWER_ON}, 											"TEST_POWER_ON")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_GROUND_BIT}, 							"TEST_GROUND_BIT")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_INFLT_BIT}, 								"TEST_INFLT_BIT")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_BIT_FAULT_DISP}, 						"TEST_BIT_FAULT_DISP")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_GCAS_BIT}, 								"TEST_GCAS_BIT")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_PREFLIGHT_BIT}, 							"TEST_PREFLIGHT_BIT")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_VMU_BIT}, 							    "TEST_VMU_BIT")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_AAS}, 									"TEST_AAS")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_AAS,A10C_HUD_TEST_AAS_MAN_FXD}, 			"TEST_AAS_MAN_FXD")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_AAS,A10C_HUD_TEST_AAS_MAN_RTY}, 			"TEST_AAS_MAN_RTY")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_WEAPONS}, 								"TEST_WEAPONS")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_WEAPONS,A10C_HUD_TEST_WPNS_30MM}, 		"TEST_WPNS_30MM")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_WEAPONS,A10C_HUD_TEST_WPNS_OFFSET_ADJ},	"TEST_WPNS_OFFSET_ADJ")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_DISPLAY_MODES}, 					 		"TEST_DISPLAY_MODES")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_GCAS_TRAINING}, 							"TEST_GCAS_TRAINING")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_GCAS_TRAINING,A10C_HUD_TEST_GCAS_CAPTURE}, "TEST_GCAS_CAPTURE")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_DELTA_CAL}, 								"TEST_DELTA_CAL")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_IFF_ALERT}, 								"TEST_IFF_ALERT")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_WPN_RELEASE}, 							"TEST_WPN_RELEASE")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_WPN_RELEASE, A10C_HUD_TEST_WPN_REL_GUNS}, "TEST_WPN_RELEASE_GUNS")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_WPN_RELEASE, A10C_HUD_TEST_WPN_REL_CCIP}, "A10C_HUD_TEST_WPN_REL_CCIP")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_WPN_RELEASE, A10C_HUD_TEST_WPN_REL_CCRP}, "A10C_HUD_TEST_WPN_REL_CCRP")
set_page_name({A10C_HUD_TEST,A10C_HUD_TEST_WPN_RELEASE, A10C_HUD_TEST_WPN_REL_MAV},  "A10C_HUD_TEST_WPN_REL_MAV")
				 						   									  
										   
HUD_FAILURE = 0
Damage = {	{Failure = HUD_FAILURE, Failure_name = "HUD_FAILURE", Failure_editor_name = _("HUD failure"),  Element = 3, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}
 
need_to_be_closed = true -- close lua state after initialization 