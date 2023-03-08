dofile(LockOn_Options.script_path.."command_defs.lua")

local gettext = require("i_18n")
_ = gettext.translate

initialization_time = 45.0 --must be approx 45 sec

-- CICU test steps
MFCD_CICU_NO_TEST  = 0
MFCD_CICU_START	   = 1
MFCD_CICU_TESTING  = 2
MFCD_CICU_WHITE    = 3
MFCD_CICU_BLACK    = 4
MFCD_CICU_GREY 	   = 5
MFCD_CICU_TEST_END = 6
MFCD_CICU_TEST_POST_END = 7

-- DISPLAY
MFCD_DISP_AUTO_TEST_START = 1
MFCD_DISP_AUTO_TEST_END   = 2

-- adding CICU test steps
cicu_index = 1
cicu_test_steps = {}

function set_cicu_test_step(name, duration, handler)
	cicu_test_steps[cicu_index] = {name,duration,handler}
	cicu_index = cicu_index + 1
end

set_cicu_test_step(MFCD_CICU_START,0.1,"StartHandler_CICU")
set_cicu_test_step(MFCD_CICU_TESTING,2.987,"ProcessHandler_CICU")
set_cicu_test_step(MFCD_CICU_BLACK,10.154,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_TESTING,1.416,"ProcessHandler_CICU")
set_cicu_test_step(MFCD_CICU_WHITE,0.841,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_GREY,2.742,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_BLACK,0.038,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_WHITE,41.533,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_GREY,2.7,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_WHITE,44.542,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_BLACK,9.923,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_WHITE,2.167,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_GREY,2.819,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_WHITE,20.136,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_GREY,1.515,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_BLACK,2.646,"DefaultHandler_CICU")
set_cicu_test_step(MFCD_CICU_TEST_END,05.051,"EndHandler_CICU")
set_cicu_test_step(MFCD_CICU_TEST_POST_END,0.1,"PostEndHandler_CICU")
-------------------------------------------------
display_test_steps = {}
display_test_steps[1] = {MFCD_DISP_AUTO_TEST_START,10.0,"DISP_StartTestHandler"}
display_test_steps[2] = {MFCD_DISP_AUTO_TEST_END,	0.0,"DISP_EndTestHandler"}

-----------------------------------------------
hotas_test_steps = {}
step = 0
function index()
	step = step + 1
	return step
end
----------------------------------
--Stick
--DMS
hotas_test_steps[index()] = {Keys.Plane_HOTAS_DataManagementSwitchUp}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_DataManagementSwitchDown}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_DataManagementSwitchLeft}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_DataManagementSwitchRight}
--TMS
hotas_test_steps[index()] = {Keys.Plane_HOTAS_TargetManagementSwitchUp}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_TargetManagementSwitchDown}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_TargetManagementSwitchLeft}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_TargetManagementSwitchRight}
--CMS
hotas_test_steps[index()] = {Keys.Plane_HOTAS_CMS_Up}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_CMS_Down}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_CMS_Left}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_CMS_Right}
--WRB 
hotas_test_steps[index()] = {Keys.PlanePickleOn}
--Trim
hotas_test_steps[index()] = {Keys.PlaneTrimUp}
hotas_test_steps[index()] = {Keys.PlaneTrimDown}
hotas_test_steps[index()] = {Keys.PlaneTrimLeft}
hotas_test_steps[index()] = {Keys.PlaneTrimRight}
--trigger
hotas_test_steps[index()] = {Keys.Plane_HOTAS_TriggerFirstStage}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_TriggerSecondStage}
--NWS
hotas_test_steps[index()] = {Keys.Plane_HOTAS_NoseWheelSteeringButton}
--MMCB
hotas_test_steps[index()] = {Keys.Plane_HOTAS_MasterModeControlButton}

-----------------------------------------------------------------------
--Throttle
--MIC switch
hotas_test_steps[index()] = {Keys.Plane_HOTAS_MIC_SwitchRight}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_MIC_SwitchLeft}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_MIC_SwitchUp}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_MIC_SwitchDown}

--Speed brake
hotas_test_steps[index()] = {Keys.Plane_HOTAS_SpeedBrakeSwitchForward}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_SpeedBrakeSwitchAft}

--Boat switch
hotas_test_steps[index()] = {Keys.Plane_HOTAS_BoatSwitchForward}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_BoatSwitchAft}

--China hat
hotas_test_steps[index()] = {Keys.Plane_HOTAS_ChinaHatForward}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_ChinaHatAft}

--Pinky
hotas_test_steps[index()] = {Keys.Plane_HOTAS_PinkySwitchForward}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_PinkySwitchAft}

--LTB
hotas_test_steps[index()] = {Keys.Plane_HOTAS_LeftThrottleButton}

--[[ removed from test
--Slew control
hotas_test_steps[index()] = {Keys.PlaneRadarUp}
hotas_test_steps[index()] = {Keys.PlaneRadarDown}
hotas_test_steps[index()] = {Keys.PlaneRadarLeft}
hotas_test_steps[index()] = {Keys.PlaneRadarRight}
]]

--Coolie SW
hotas_test_steps[index()] = {Keys.Plane_HOTAS_CoolieUp}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_CoolieDown}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_CoolieLeft}
hotas_test_steps[index()] = {Keys.Plane_HOTAS_CoolieRight} 

--AHCP
hotas_test_steps[index()] = {start_command} 
hotas_test_steps[index()] = {start_command+1}
hotas_test_steps[index()] = {start_command+2} 

hotas_test_steps[index()] = {start_command+3}
hotas_test_steps[index()] = {start_command+4} 

hotas_test_steps[index()] = {start_command+5}
hotas_test_steps[index()] = {start_command+6} 
 
CICU_FAILURE_TOTAL	= 0

Damage = {	{Failure = CICU_FAILURE_TOTAL, Failure_name = "CICU_FAILURE_TOTAL", Failure_editor_name = _("CICU total failure"),  Element = 9, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}
 
 need_to_be_closed = true -- close lua state after initialization 