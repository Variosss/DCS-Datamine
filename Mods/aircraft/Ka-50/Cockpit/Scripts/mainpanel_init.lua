dofile(LockOn_Options.script_path.."config.lua")
dofile(LockOn_Options.script_path.."VR_config.lua")

simplify_cockpit = false

ambient_light    = {0, 0, 255}

ambient_color_night_texture  = {40, 10, 180}
ambient_color_from_cockpit_illumination = {240, 240, 240}
ambient_color_from_devices   = {16, 12, 12}
ambient_color_from_panels	 = {16, 12, 12}
ambient_color_from_abris	 = {50,150,50}
ambient_color_from_shkval	 = {255,255,255}

plafon =
{
	lighttype 		= "omni",
	position  		= {-0.32,0.048,-0.314},
	range		 	= 7.0,
}

illumination_from_shkval = 
{
	lighttype 		= "omni",
	position  		= {0.55,-0.4,0},
	range		 	= 1.0,
}

illumination_from_abris = 
{
	lighttype 		= "omni",
	position  		= {0.64,-0.5342,0.2458},
	range		 	= 1.0,
}

common_illumination = 
{
	lighttype    = "omni",
	position     = {0,-0.15,0},
	range		 = 2.0,
}


hud_backlight 		= 
{
	lighttype 		= "omni",
	position  		= {0.58,-0.05,0},
	range		 	= 1.1,
	color 			= {0,1,0},
}

draw_pilot					 = false

external_model_canopy_arg	 = 38

cockpit_local_point = {3.188, 0.39, 0.0}

render_target_always    = true

args_initial_state = {
	[900] = 0.1,
}

if LockOn_Options.avionics_language == "native"  then
    args_initial_state[617] = 0
else
    args_initial_state[617] = 1.0
end

if get_option_value("difficulty.hideStick", "local") then 
	args_initial_state[1005] = 1.0
end

---------------------------------------------------------------
-- CONTROLLERS
---------------------------------------------------------------

local controllers = LoRegisterPanelControls()

ambient_controller				= CreateGauge()
ambient_controller.controller   = controllers.Ka50_ambient --ambient

--------------------------------------------------------------------------------------------
-- Illumination
illumination_panels			    = CreateGauge()
illumination_panels.arg_number  = 803
illumination_panels.input		= {0.0, 1.0}
illumination_panels.output  	= {0.0, 1.0}
illumination_panels.controller  = controllers.panel_illumination

illumination_panels2			 = CreateGauge()
illumination_panels2.arg_number  = 799
illumination_panels2.input		= {0.0, 1.0}
illumination_panels2.output  	= {0.0, 1.0}
illumination_panels2.controller  = controllers.panel_illumination

ADI_illumination			= CreateGauge()
ADI_illumination.arg_number	= 798
ADI_illumination.input		= {0.0, 1.0}
ADI_illumination.output		= {0.0, 1.0}
ADI_illumination.controller	= controllers.ADI_illumination

ADI_illumination2				= CreateGauge()
ADI_illumination2.arg_number	= 801
ADI_illumination2.input			= {0.0, 1.0}
ADI_illumination2.output		= {0.0, 1.0}
ADI_illumination2.controller	= controllers.ADI_illumination


AHR_illumination			= CreateGauge()
AHR_illumination.arg_number	= 802
AHR_illumination.input		= {0.0, 1.0}
AHR_illumination.output		= {0.0, 1.0}
AHR_illumination.controller	= controllers.AHR_illumination

Control_Panel_illumination			= CreateGauge()
Control_Panel_illumination.arg_number	= 800
Control_Panel_illumination.input		= {0.0, 1.0}
Control_Panel_illumination.output		= {0.0, 1.0}
Control_Panel_illumination.controller	= controllers.Control_Panel_illumination

Plafond				= CreateGauge()
Plafond.arg_number	= 1000
Plafond.input		= {0.0, 1.0}
Plafond.output		= {0.0, 1.0}
Plafond.controller	= controllers.Plafond

-------------------------------------------------------------------------------------------

-----------------------------------------------------------------

mirrors_draw                    = CreateGauge()
mirrors_draw.arg_number    		= 545
mirrors_draw.input   			= {0,1}
mirrors_draw.output   			= {1,0}
mirrors_draw.controller         = controllers.mirrors_draw

pilot_draw                      = CreateGauge()
pilot_draw.arg_number    		= 540
pilot_draw.input				= {0.0, 1.0}
pilot_draw.output				= {0.0, 1.0}
pilot_draw.controller			= controllers.pilot_draw

rudder              = CreateGauge()
rudder.arg_number   = 266
rudder.input		= {-0.0815, 0.0815}
rudder.output		= { 1, -1}
rudder.controller   = controllers.rudder_position

stick_roll              = CreateGauge()
stick_roll.arg_number   = 71
stick_roll.input		= {-0.13, 0.13}
stick_roll.output		= {1, -1}
stick_roll.controller   = controllers.stick_roll

stick_pitch             = CreateGauge()
stick_pitch.arg_number  = 74
stick_pitch.input		= {-0.115, 0.1816}
stick_pitch.output		= {-1, 1}
stick_pitch.controller  = controllers.stick_pitch

collective_position					= CreateGauge()
collective_position.arg_number		= 104
collective_position.input			= {0, 1}
collective_position.output			= {0, 1}
collective_position.controller		= controllers.collective_position

coll_ROUTE_DESCENT_sw				= CreateGauge()
coll_ROUTE_DESCENT_sw.arg_number	= 560
coll_ROUTE_DESCENT_sw.input			= {0, 1}
coll_ROUTE_DESCENT_sw.output		= {0, 1}
coll_ROUTE_DESCENT_sw.controller	= controllers.coll_ROUTE_DESCENT_sw

coll_ReadjustFreeTurbRPM_sw				= CreateGauge()
coll_ReadjustFreeTurbRPM_sw.arg_number	= 558
coll_ReadjustFreeTurbRPM_sw.input		= {0, 1}
coll_ReadjustFreeTurbRPM_sw.output		= {0, 1}
coll_ReadjustFreeTurbRPM_sw.controller	= controllers.coll_ReadjustFreeTurbRPM_sw

collective_stopper              = CreateGauge()
collective_stopper.arg_number	= 580
collective_stopper.input		= {0, 1}
collective_stopper.output		= {0, 1}
collective_stopper.controller	= controllers.collective_stopper

left_door				= CreateGauge()
left_door.arg_number	= 533
left_door.input			= {0.0, 1.0}
left_door.output		= {0.0, 1.0}
left_door.controller	= controllers.left_door

left_engine_throttle			= CreateGauge()
left_engine_throttle.arg_number	= 578
left_engine_throttle.input		= {0.0, 1.0}
left_engine_throttle.output		= {0.0, 1.0}
left_engine_throttle.controller	= controllers.throttle_left

right_engine_throttle			= CreateGauge()
right_engine_throttle.arg_number	= 557
right_engine_throttle.input		= {0.0, 1.0}
right_engine_throttle.output		= {0.0, 1.0}
right_engine_throttle.controller	= controllers.throttle_right

throttle_cover			    = CreateGauge()
throttle_cover.arg_number	= 579
throttle_cover.input		= {0.0, 1.0}
throttle_cover.output		= {0.0, 1.0}
throttle_cover.controller	= controllers.throttle_cover


--=================================================
-- Laser warning system
LWS_LampReady						= CreateGauge()
LWS_LampReady.arg_number			= 582
LWS_LampReady.input					= {0.0, 1.0}
LWS_LampReady.output				= {0.0, 1.0}
LWS_LampReady.controller			= controllers.LWS_LampReady

LWS_LampAzimuth_0					= CreateGauge()
LWS_LampAzimuth_0.arg_number		= 25
LWS_LampAzimuth_0.input				= {0.0, 1.0}
LWS_LampAzimuth_0.output			= {0.0, 1.0}
LWS_LampAzimuth_0.controller		= controllers.LWS_LampAzimuth_0

LWS_LampAzimuth_90					= CreateGauge()
LWS_LampAzimuth_90.arg_number		= 28
LWS_LampAzimuth_90.input			= {0.0, 1.0}
LWS_LampAzimuth_90.output			= {0.0, 1.0}
LWS_LampAzimuth_90.controller		= controllers.LWS_LampAzimuth_90

LWS_LampAzimuth_180					= CreateGauge()
LWS_LampAzimuth_180.arg_number		= 26
LWS_LampAzimuth_180.input			= {0.0, 1.0}
LWS_LampAzimuth_180.output			= {0.0, 1.0}
LWS_LampAzimuth_180.controller		= controllers.LWS_LampAzimuth_180

LWS_LampAzimuth_270					= CreateGauge()
LWS_LampAzimuth_270.arg_number		= 27
LWS_LampAzimuth_270.input			= {0.0, 1.0}
LWS_LampAzimuth_270.output			= {0.0, 1.0}
LWS_LampAzimuth_270.controller		= controllers.LWS_LampAzimuth_270

LWS_LampAzimuth_UpperHemisphere					= CreateGauge()
LWS_LampAzimuth_UpperHemisphere.arg_number		= 31
LWS_LampAzimuth_UpperHemisphere.input			= {0.0, 1.0}
LWS_LampAzimuth_UpperHemisphere.output			= {0.0, 1.0}
LWS_LampAzimuth_UpperHemisphere.controller		= controllers.LWS_LampAzimuth_UpperHemisphere

LWS_LampAzimuth_LowerHemisphere					= CreateGauge()
LWS_LampAzimuth_LowerHemisphere.arg_number		= 32
LWS_LampAzimuth_LowerHemisphere.input			= {0.0, 1.0}
LWS_LampAzimuth_LowerHemisphere.output			= {0.0, 1.0}
LWS_LampAzimuth_LowerHemisphere.controller		= controllers.LWS_LampAzimuth_LowerHemisphere

LWS_LampAzimuth_LaserRangefinder				= CreateGauge()
LWS_LampAzimuth_LaserRangefinder.arg_number		= 33
LWS_LampAzimuth_LaserRangefinder.input			= {0.0, 1.0}
LWS_LampAzimuth_LaserRangefinder.output			= {0.0, 1.0}
LWS_LampAzimuth_LaserRangefinder.controller		= controllers.LWS_LampAzimuth_LaserRangefinder

LWS_LampAzimuth_LaserTargetingSystem				= CreateGauge()
LWS_LampAzimuth_LaserTargetingSystem.arg_number		= 34
LWS_LampAzimuth_LaserTargetingSystem.input			= {0.0, 1.0}
LWS_LampAzimuth_LaserTargetingSystem.output			= {0.0, 1.0}
LWS_LampAzimuth_LaserTargetingSystem.controller		= controllers.LWS_LampAzimuth_LaserTargetingSystem

--=================================================
-- LAMPS

--=================================================
-- upper panel left group

lamp_H_RALT_stab					= CreateGauge()
lamp_H_RALT_stab.arg_number			= 170
lamp_H_RALT_stab.input				= {0.0, 1.0}
lamp_H_RALT_stab.output				= {0.0, 1.0}
lamp_H_RALT_stab.controller			= controllers.lamp_H_RALT_stab

lamp_Hover							= CreateGauge()
lamp_Hover.arg_number				= 175
lamp_Hover.input					= {0.0, 1.0}
lamp_Hover.output					= {0.0, 1.0}
lamp_Hover.controller				= controllers.lamp_Hover

lamp_Descent						= CreateGauge()
lamp_Descent.arg_number				= 172
lamp_Descent.input					= {0.0, 1.0}
lamp_Descent.output					= {0.0, 1.0}
lamp_Descent.controller				= controllers.lamp_Descent

lamp_RouteHeadingSteering				= CreateGauge()
lamp_RouteHeadingSteering.arg_number	= 165
lamp_RouteHeadingSteering.input			= {0.0, 1.0}
lamp_RouteHeadingSteering.output		= {0.0, 1.0}
lamp_RouteHeadingSteering.controller	= controllers.lamp_RouteHeadingSteering

lamp_RouteCourseSteering				= CreateGauge()
lamp_RouteCourseSteering.arg_number		= 171
lamp_RouteCourseSteering.input			= {0.0, 1.0}
lamp_RouteCourseSteering.output			= {0.0, 1.0}
lamp_RouteCourseSteering.controller		= controllers.lamp_RouteCourseSteering

lamp_Waypoint						= CreateGauge()
lamp_Waypoint.arg_number			= 176
lamp_Waypoint.input					= {0.0, 1.0}
lamp_Waypoint.output				= {0.0, 1.0}
lamp_Waypoint.controller			= controllers.lamp_Waypoint

lamp_EndOfRoute						= CreateGauge()
lamp_EndOfRoute.arg_number			= 166
lamp_EndOfRoute.input				= {0.0, 1.0}
lamp_EndOfRoute.output				= {0.0, 1.0}
lamp_EndOfRoute.controller			= controllers.lamp_EndOfRoute

lamp_RoughNAVcalc					= CreateGauge()
lamp_RoughNAVcalc.arg_number		= 164
lamp_RoughNAVcalc.input				= {0.0, 1.0}
lamp_RoughNAVcalc.output			= {0.0, 1.0}
lamp_RoughNAVcalc.controller		= controllers.lamp_RoughNAVcalc

lamp_Burst							= CreateGauge()
lamp_Burst.arg_number				= 178
lamp_Burst.input					= {0.0, 1.0}
lamp_Burst.output					= {0.0, 1.0}
lamp_Burst.controller				= controllers.lamp_Burst

lamp_CannonMovingBarr				= CreateGauge()
lamp_CannonMovingBarr.arg_number	= 173
lamp_CannonMovingBarr.input			= {0.0, 1.0}
lamp_CannonMovingBarr.output		= {0.0, 1.0}
lamp_CannonMovingBarr.controller	= controllers.lamp_CannonMovingBarr

lamp_CannonMovingBarr2				= CreateGauge()
lamp_CannonMovingBarr2.arg_number	= 177
lamp_CannonMovingBarr2.input		= {0.0, 1.0}
lamp_CannonMovingBarr2.output		= {0.0, 1.0}
lamp_CannonMovingBarr2.controller	= controllers.lamp_CannonMovingBarr2

lamp_FuelCrossfeedOn				= CreateGauge()
lamp_FuelCrossfeedOn.arg_number		= 211
lamp_FuelCrossfeedOn.input			= {0.0, 1.0}
lamp_FuelCrossfeedOn.output			= {0.0, 1.0}
lamp_FuelCrossfeedOn.controller		= controllers.lamp_FuelCrossfeedOn

lamp_CouplerOff						= CreateGauge()
lamp_CouplerOff.arg_number			= 187
lamp_CouplerOff.input				= {0.0, 1.0}
lamp_CouplerOff.output				= {0.0, 1.0}
lamp_CouplerOff.controller			= controllers.lamp_CouplerOff

lamp_ActuatorsOilPress				= CreateGauge()
lamp_ActuatorsOilPress.arg_number	= 204
lamp_ActuatorsOilPress.input		= {0.0, 1.0}
lamp_ActuatorsOilPress.output		= {0.0, 1.0}
lamp_ActuatorsOilPress.controller	= controllers.lamp_ActuatorsOilPress

lamp_LockOff						= CreateGauge()
lamp_LockOff.arg_number				= 213
lamp_LockOff.input					= {0.0, 1.0}
lamp_LockOff.output					= {0.0, 1.0}
lamp_LockOff.controller				= controllers.lamp_LockOff

--=================================================
-- upper panel right group

lamp_WeapSysBUS_ON					= CreateGauge()
lamp_WeapSysBUS_ON.arg_number		= 167
lamp_WeapSysBUS_ON.input			= {0.0, 1.0}
lamp_WeapSysBUS_ON.output			= {0.0, 1.0}
lamp_WeapSysBUS_ON.controller		= controllers.lamp_WeapSysBUS_ON

lamp_TrainingMode					= CreateGauge()
lamp_TrainingMode.arg_number		= 180
lamp_TrainingMode.input				= {0.0, 1.0}
lamp_TrainingMode.output			= {0.0, 1.0}
lamp_TrainingMode.controller		= controllers.lamp_TrainingMode

lamp_OBZOR_800						= CreateGauge()
lamp_OBZOR_800.arg_number			= 179
lamp_OBZOR_800.input				= {0.0, 1.0}
lamp_OBZOR_800.output				= {0.0, 1.0}
lamp_OBZOR_800.controller			= controllers.lamp_OBZOR_800

lamp_RANET							= CreateGauge()
lamp_RANET.arg_number				= 188
lamp_RANET.input					= {0.0, 1.0}
lamp_RANET.output					= {0.0, 1.0}
lamp_RANET.controller				= controllers.lamp_RANET

lamp_CC_test						= CreateGauge()
lamp_CC_test.arg_number				= 189
lamp_CC_test.input					= {0.0, 1.0}
lamp_CC_test.output					= {0.0, 1.0}
lamp_CC_test.controller				= controllers.lamp_CC_test

lamp_CC_failure						= CreateGauge()
lamp_CC_failure.arg_number			= 206
lamp_CC_failure.input				= {0.0, 1.0}
lamp_CC_failure.output				= {0.0, 1.0}
lamp_CC_failure.controller			= controllers.lamp_CC_failure

lamp_DC_AC_Inverter					= CreateGauge()
lamp_DC_AC_Inverter.arg_number		= 212
lamp_DC_AC_Inverter.input			= {0.0, 1.0}
lamp_DC_AC_Inverter.output			= {0.0, 1.0}
lamp_DC_AC_Inverter.controller		= controllers.lamp_DC_AC_Inverter

lamp_I_251V							= CreateGauge()
lamp_I_251V.arg_number				= 205
lamp_I_251V.input					= {0.0, 1.0}
lamp_I_251V.output					= {0.0, 1.0}
lamp_I_251V.controller				= controllers.lamp_I_251V

lamp_AntiIceLeftEngine				= CreateGauge()
lamp_AntiIceLeftEngine.arg_number	= 181
lamp_AntiIceLeftEngine.input		= {0.0, 1.0}
lamp_AntiIceLeftEngine.output		= {0.0, 1.0}
lamp_AntiIceLeftEngine.controller	= controllers.lamp_AntiIceLeftEngine

lamp_DustProtectLeftEngine				= CreateGauge()
lamp_DustProtectLeftEngine.arg_number	= 190
lamp_DustProtectLeftEngine.input		= {0.0, 1.0}
lamp_DustProtectLeftEngine.output		= {0.0, 1.0}
lamp_DustProtectLeftEngine.controller	= controllers.lamp_DustProtectLeftEngine

lamp_BackupModeLeftEngine				= CreateGauge()
lamp_BackupModeLeftEngine.arg_number	= 207
lamp_BackupModeLeftEngine.input			= {0.0, 1.0}
lamp_BackupModeLeftEngine.output		= {0.0, 1.0}
lamp_BackupModeLeftEngine.controller	= controllers.lamp_BackupModeLeftEngine

lamp_AntiIceRotors						= CreateGauge()
lamp_AntiIceRotors.arg_number			= 183
lamp_AntiIceRotors.input				= {0.0, 1.0}
lamp_AntiIceRotors.output				= {0.0, 1.0}
lamp_AntiIceRotors.controller			= controllers.lamp_AntiIceRotors

lamp_AntiIceRightEngine					= CreateGauge()
lamp_AntiIceRightEngine.arg_number		= 182
lamp_AntiIceRightEngine.input			= {0.0, 1.0}
lamp_AntiIceRightEngine.output			= {0.0, 1.0}
lamp_AntiIceRightEngine.controller		= controllers.lamp_AntiIceRightEngine

lamp_DustProtectRightEngine				= CreateGauge()
lamp_DustProtectRightEngine.arg_number	= 191
lamp_DustProtectRightEngine.input		= {0.0, 1.0}
lamp_DustProtectRightEngine.output		= {0.0, 1.0}
lamp_DustProtectRightEngine.controller	= controllers.lamp_DustProtectRightEngine

lamp_BackupModeRightEngine				= CreateGauge()
lamp_BackupModeRightEngine.arg_number	= 208
lamp_BackupModeRightEngine.input		= {0.0, 1.0}
lamp_BackupModeRightEngine.output		= {0.0, 1.0}
lamp_BackupModeRightEngine.controller	= controllers.lamp_BackupModeRightEngine

lamp_VUO_Heat							= CreateGauge()
lamp_VUO_Heat.arg_number				= 184
lamp_VUO_Heat.input						= {0.0, 1.0}
lamp_VUO_Heat.output					= {0.0, 1.0}
lamp_VUO_Heat.controller				= controllers.lamp_VUO_Heat

lamp_ForwardTank						= CreateGauge()
lamp_ForwardTank.arg_number				= 200
lamp_ForwardTank.input					= {0.0, 1.0}
lamp_ForwardTank.output					= {0.0, 1.0}
lamp_ForwardTank.controller				= controllers.lamp_ForwardTank

lamp_LeftValveClosed					= CreateGauge()
lamp_LeftValveClosed.arg_number			= 209
lamp_LeftValveClosed.input				= {0.0, 1.0}
lamp_LeftValveClosed.output				= {0.0, 1.0}
lamp_LeftValveClosed.controller			= controllers.lamp_LeftValveClosed

lamp_LeftOuterTank						= CreateGauge()
lamp_LeftOuterTank.arg_number			= 185
lamp_LeftOuterTank.input				= {0.0, 1.0}
lamp_LeftOuterTank.output				= {0.0, 1.0}
lamp_LeftOuterTank.controller			= controllers.lamp_LeftOuterTank

lamp_LeftInnerTank						= CreateGauge()
lamp_LeftInnerTank.arg_number			= 202
lamp_LeftInnerTank.input				= {0.0, 1.0}
lamp_LeftInnerTank.output				= {0.0, 1.0}
lamp_LeftInnerTank.controller			= controllers.lamp_LeftInnerTank

lamp_RearTank							= CreateGauge()
lamp_RearTank.arg_number				= 201
lamp_RearTank.input						= {0.0, 1.0}
lamp_RearTank.output					= {0.0, 1.0}
lamp_RearTank.controller				= controllers.lamp_RearTank

lamp_RightValveClosed					= CreateGauge()
lamp_RightValveClosed.arg_number		= 210
lamp_RightValveClosed.input				= {0.0, 1.0}
lamp_RightValveClosed.output			= {0.0, 1.0}
lamp_RightValveClosed.controller		= controllers.lamp_RightValveClosed

lamp_RightOuterTank						= CreateGauge()
lamp_RightOuterTank.arg_number			= 186
lamp_RightOuterTank.input				= {0.0, 1.0}
lamp_RightOuterTank.output				= {0.0, 1.0}
lamp_RightOuterTank.controller			= controllers.lamp_RightOuterTank

lamp_RightInnerTank						= CreateGauge()
lamp_RightInnerTank.arg_number			= 203
lamp_RightInnerTank.input				= {0.0, 1.0}
lamp_RightInnerTank.output				= {0.0, 1.0}
lamp_RightInnerTank.controller			= controllers.lamp_RightInnerTank

lamp_LeftPitotHeatTest					= CreateGauge()
lamp_LeftPitotHeatTest.arg_number		= 155
lamp_LeftPitotHeatTest.input			= {0.0, 1.0}
lamp_LeftPitotHeatTest.output			= {0.0, 1.0}
lamp_LeftPitotHeatTest.controller		= controllers.lamp_LeftPitotHeatTest

lamp_RightPitotHeatTest					= CreateGauge()
lamp_RightPitotHeatTest.arg_number		= 157
lamp_RightPitotHeatTest.input			= {0.0, 1.0}
lamp_RightPitotHeatTest.output			= {0.0, 1.0}
lamp_RightPitotHeatTest.controller		= controllers.lamp_RightPitotHeatTest

--=================================================
-- HUD
--=================================================

filter				= CreateGauge()
filter.arg_number   = 509
filter.input		= {0,1}
filter.output		= {0,1}
filter.controller   = controllers.filter

filter_handle				= CreateGauge()
filter_handle.arg_number	= 510
filter_handle.input			= {0,1}
filter_handle.output		= {0,1}
filter_handle.controller	= controllers.filter_handle

---------------------------------------------------
-- UV-26
UV26_lampLeftBoard				= CreateGauge()
UV26_lampLeftBoard.arg_number	= 541
UV26_lampLeftBoard.input		= {0.0, 1.0}
UV26_lampLeftBoard.output		= {0.0, 1.0}
UV26_lampLeftBoard.controller	= controllers.UV26_lampLeftBoard

UV26_lampRightBoard				= CreateGauge()
UV26_lampRightBoard.arg_number	= 542
UV26_lampRightBoard.input		= {0.0, 1.0}
UV26_lampRightBoard.output		= {0.0, 1.0}
UV26_lampRightBoard.controller	= controllers.UV26_lampRightBoard

---------------------------------------------------
-- DATALINK

PRC_button_SEND					= CreateGauge()
PRC_button_SEND.arg_number		= 159
PRC_button_SEND.input			= {0.0, 0.3}
PRC_button_SEND.output			= {0.0, 0.3}
PRC_button_SEND.controller		= controllers.PRC_button_SEND

PRC_button_ESCAPE				= CreateGauge()
PRC_button_ESCAPE.arg_number	= 150
PRC_button_ESCAPE.input			= {0.0, 0.3}
PRC_button_ESCAPE.output		= {0.0, 0.3}
PRC_button_ESCAPE.controller	= controllers.PRC_button_ESCAPE

PRC_button_ERASE				= CreateGauge()
PRC_button_ERASE.arg_number		= 161
PRC_button_ERASE.input			= {0.0, 0.3}
PRC_button_ERASE.output			= {0.0, 0.3}
PRC_button_ERASE.controller		= controllers.PRC_button_ERASE

PRC_button_CLEAN				= CreateGauge()
PRC_button_CLEAN.arg_number		= 15
PRC_button_CLEAN.input			= {0.0, 0.3}
PRC_button_CLEAN.output			= {0.0, 0.3}
PRC_button_CLEAN.controller		= controllers.PRC_button_CLEAN

PRC_button_WINGMAN_ALL				= CreateGauge()
PRC_button_WINGMAN_ALL.arg_number	= 16
PRC_button_WINGMAN_ALL.input		= {0.0, 0.3}
PRC_button_WINGMAN_ALL.output		= {0.0, 0.3}
PRC_button_WINGMAN_ALL.controller	= controllers.PRC_button_WINGMAN_ALL

PRC_button_WINGMAN_1			= CreateGauge()
PRC_button_WINGMAN_1.arg_number	= 17
PRC_button_WINGMAN_1.input		= {0.0, 0.3}
PRC_button_WINGMAN_1.output		= {0.0, 0.3}
PRC_button_WINGMAN_1.controller	= controllers.PRC_button_WINGMAN_1

PRC_button_WINGMAN_2			= CreateGauge()
PRC_button_WINGMAN_2.arg_number	= 18
PRC_button_WINGMAN_2.input		= {0.0, 0.3}
PRC_button_WINGMAN_2.output		= {0.0, 0.3}
PRC_button_WINGMAN_2.controller	= controllers.PRC_button_WINGMAN_2

PRC_button_WINGMAN_3			= CreateGauge()
PRC_button_WINGMAN_3.arg_number	= 19
PRC_button_WINGMAN_3.input		= {0.0, 0.3}
PRC_button_WINGMAN_3.output		= {0.0, 0.3}
PRC_button_WINGMAN_3.controller	= controllers.PRC_button_WINGMAN_3

PRC_button_WINGMAN_4			= CreateGauge()
PRC_button_WINGMAN_4.arg_number	= 20
PRC_button_WINGMAN_4.input		= {0.0, 0.3}
PRC_button_WINGMAN_4.output		= {0.0, 0.3}
PRC_button_WINGMAN_4.controller	= controllers.PRC_button_WINGMAN_4

PRC_button_TARGET_1				= CreateGauge()
PRC_button_TARGET_1.arg_number	= 21
PRC_button_TARGET_1.input		= {0.0, 0.3}
PRC_button_TARGET_1.output		= {0.0, 0.3}
PRC_button_TARGET_1.controller	= controllers.PRC_button_TARGET_1

PRC_button_TARGET_2				= CreateGauge()
PRC_button_TARGET_2.arg_number	= 22
PRC_button_TARGET_2.input		= {0.0, 0.3}
PRC_button_TARGET_2.output		= {0.0, 0.3}
PRC_button_TARGET_2.controller	= controllers.PRC_button_TARGET_2

PRC_button_TARGET_3				= CreateGauge()
PRC_button_TARGET_3.arg_number	= 23
PRC_button_TARGET_3.input		= {0.0, 0.3}
PRC_button_TARGET_3.output		= {0.0, 0.3}
PRC_button_TARGET_3.controller	= controllers.PRC_button_TARGET_3

PRC_button_TARGET_POINT				= CreateGauge()
PRC_button_TARGET_POINT.arg_number	= 50
PRC_button_TARGET_POINT.input		= {0.0, 0.3}
PRC_button_TARGET_POINT.output		= {0.0, 0.3}
PRC_button_TARGET_POINT.controller	= controllers.PRC_button_TARGET_POINT

---------------------------------------------------
-- WEAPON  INTERFACE

PRC_button_AUTO_TURN				= CreateGauge()
PRC_button_AUTO_TURN.arg_number	= 437
PRC_button_AUTO_TURN.input		= {0.0, 0.3}
PRC_button_AUTO_TURN.output		= {0.0, 0.3}
PRC_button_AUTO_TURN.controller	= controllers.PVR_button_AUTO_TURN

PRC_button_AIRBORNE_TARGET				= CreateGauge()
PRC_button_AIRBORNE_TARGET.arg_number	= 438
PRC_button_AIRBORNE_TARGET.input		= {0.0, 0.3}
PRC_button_AIRBORNE_TARGET.output		= {0.0, 0.3}
PRC_button_AIRBORNE_TARGET.controller	= controllers.PVR_button_AIRBORNE_TARGET

PRC_button_GROUND_MOVING_TARGET				= CreateGauge()
PRC_button_GROUND_MOVING_TARGET.arg_number	= 440
PRC_button_GROUND_MOVING_TARGET.input		= {0.0, 0.3}
PRC_button_GROUND_MOVING_TARGET.output		= {0.0, 0.3}
PRC_button_GROUND_MOVING_TARGET.controller	= controllers.PVR_button_GROUND_MOVING_TARGET

PRC_button_FORWARD_HEMISPHERE				= CreateGauge()
PRC_button_FORWARD_HEMISPHERE.arg_number	= 439
PRC_button_FORWARD_HEMISPHERE.input			= {0.0, 0.3}
PRC_button_FORWARD_HEMISPHERE.output		= {0.0, 0.3}
PRC_button_FORWARD_HEMISPHERE.controller	= controllers.PVR_button_FORWARD_HEMISPHERE

PRC_button_CLEAR							= CreateGauge()
PRC_button_CLEAR.arg_number					= 441
PRC_button_CLEAR.input						= {0.0, 0.3}
PRC_button_CLEAR.output						= {0.0, 0.3}
PRC_button_CLEAR.controller					= controllers.PVR_button_CLEAR

--[[
PRC_button_RESET				= CreateGauge()
PRC_button_RESET.arg_number	= 50
PRC_button_RESET.input		= {0.0, 0.3}
PRC_button_RESET.output		= {0.0, 0.3}
PRC_button_RESET.controller	= controllers.PRC_button_RESET
]]--
--=================================================
-- Left main panel
--=================================================

--=================================================
-- LAMPS

lamp_MasterWarning							= CreateGauge()
lamp_MasterWarning.arg_number				= 44
lamp_MasterWarning.input					= {0.0, 0.3}
lamp_MasterWarning.output					= {0.0, 0.3}
lamp_MasterWarning.controller				= controllers.lamp_MasterWarning

lamp_MasterWarning_brightness				= CreateGauge()
lamp_MasterWarning_brightness.arg_number	= 1015
lamp_MasterWarning_brightness.input			= {0, 1}
lamp_MasterWarning_brightness.output		= {0, 1}
lamp_MasterWarning_brightness.controller	= controllers.lamp_MasterWarning_brightness

lamp_RotorRPM								= CreateGauge()
lamp_RotorRPM.arg_number					= 46
lamp_RotorRPM.input							= {0.0, 1.0}
lamp_RotorRPM.output						= {0.0, 1.0}
lamp_RotorRPM.controller					= controllers.lamp_RotorRPM

lamp_RotorRPM_brightness					= CreateGauge()
lamp_RotorRPM_brightness.arg_number			= 1016
lamp_RotorRPM_brightness.input				= {0, 1}
lamp_RotorRPM_brightness.output				= {0, 1}
lamp_RotorRPM_brightness.controller			= controllers.lamp_RotorRPM_brightness

lamp_UNDERFIREwarning				= CreateGauge()
lamp_UNDERFIREwarning.arg_number	= 47
lamp_UNDERFIREwarning.input			= {0.0, 1.0}
lamp_UNDERFIREwarning.output		= {0.0, 1.0}
lamp_UNDERFIREwarning.controller	= controllers.lamp_UNDERFIREwarning

lamp_LowerGear						= CreateGauge()
lamp_LowerGear.arg_number			= 48
lamp_LowerGear.input				= {0.0, 1.0}
lamp_LowerGear.output				= {0.0, 1.0}
lamp_LowerGear.controller			= controllers.lamp_LowerGear

lamp_RPM_leftEngineMax				= CreateGauge()
lamp_RPM_leftEngineMax.arg_number	= 78
lamp_RPM_leftEngineMax.input		= {0.0, 1.0}
lamp_RPM_leftEngineMax.output		= {0.0, 1.0}
lamp_RPM_leftEngineMax.controller	= controllers.lamp_RPM_leftEngineMax

lamp_RPM_rightEngineMax				= CreateGauge()
lamp_RPM_rightEngineMax.arg_number	= 79
lamp_RPM_rightEngineMax.input		= {0.0, 1.0}
lamp_RPM_rightEngineMax.output		= {0.0, 1.0}
lamp_RPM_rightEngineMax.controller	= controllers.lamp_RPM_rightEngineMax

lamp_NyMax							= CreateGauge()
lamp_NyMax.arg_number				= 80
lamp_NyMax.input					= {0.0, 1.0}
lamp_NyMax.output					= {0.0, 1.0}
lamp_NyMax.controller				= controllers.lamp_NyMax

lamp_vibr_leftEngine				= CreateGauge()
lamp_vibr_leftEngine.arg_number		= 81
lamp_vibr_leftEngine.input			= {0.0, 1.0}
lamp_vibr_leftEngine.output			= {0.0, 1.0}
lamp_vibr_leftEngine.controller		= controllers.lamp_vibr_leftEngine

lamp_vibr_rightEngine				= CreateGauge()
lamp_vibr_rightEngine.arg_number	= 82
lamp_vibr_rightEngine.input			= {0.0, 1.0}
lamp_vibr_rightEngine.output		= {0.0, 1.0}
lamp_vibr_rightEngine.controller	= controllers.lamp_vibr_rightEngine

lamp_IAS_max						= CreateGauge()
lamp_IAS_max.arg_number				= 83
lamp_IAS_max.input					= {0.0, 1.0}
lamp_IAS_max.output					= {0.0, 1.0}
lamp_IAS_max.controller				= controllers.lamp_IAS_max

lamp_mainTransmission				= CreateGauge()
lamp_mainTransmission.arg_number	= 84
lamp_mainTransmission.input			= {0.0, 1.0}
lamp_mainTransmission.output		= {0.0, 1.0}
lamp_mainTransmission.controller	= controllers.lamp_mainTransmission

lamp_Fire							= CreateGauge()
lamp_Fire.arg_number				= 85
lamp_Fire.input						= {0.0, 1.0}
lamp_Fire.output					= {0.0, 1.0}
lamp_Fire.controller				= controllers.lamp_Fire

lamp_IFFfailure						= CreateGauge()
lamp_IFFfailure.arg_number			= 86
lamp_IFFfailure.input				= {0.0, 1.0}
lamp_IFFfailure.output				= {0.0, 1.0}
lamp_IFFfailure.controller			= controllers.lamp_IFFfailure

vy              = CreateGauge()
vy.arg_number   = 24
vy.input		= {-30,30}
vy.output		= {-1.0, 1.0}
vy.controller   = controllers.variometer

IAS					= CreateGauge()
IAS.arg_number		= 51
IAS.input			= {0.0, 100.0}
IAS.output			= {0.0, 1.0}
IAS.controller		= controllers.IAS

---------------------------------------------------
-- IKP-81 (ADI)

ADI_Roll				= CreateGauge()
ADI_Roll.arg_number		= 100
ADI_Roll.input			= {0.0, 2.0 * math.pi}
ADI_Roll.output			= {-1.0, 1.0}
ADI_Roll.controller		= controllers.ADI_roll

ADI_Pitch				= CreateGauge()
ADI_Pitch.arg_number	= 101
ADI_Pitch.input			= {-math.pi / 2.0, math.pi / 2.0}
ADI_Pitch.output		= {1.0, -1.0}
ADI_Pitch.controller	= controllers.ADI_pitch

ADI_steering_warning_flag					= CreateGauge()
ADI_steering_warning_flag.arg_number		= 102
ADI_steering_warning_flag.input				= {0.0, 1.0}
ADI_steering_warning_flag.output			= {0.0, 1.0}
ADI_steering_warning_flag.controller		= controllers.ADI_steering_warning_flag

ADI_attitude_warning_flag					= CreateGauge()
ADI_attitude_warning_flag.arg_number		= 109
ADI_attitude_warning_flag.input				= {0.0, 1.0}
ADI_attitude_warning_flag.output			= {0.0, 1.0}
ADI_attitude_warning_flag.controller		= controllers.ADI_attitude_warning_flag

ADI_bank_steering							= CreateGauge()
ADI_bank_steering.arg_number				= 107
ADI_bank_steering.input						= {-1.0, 1.0}
ADI_bank_steering.output					= {-1.0, 1.0}
ADI_bank_steering.controller				= controllers.ADI_bank_steering

ADI_pitch_steering							= CreateGauge()
ADI_pitch_steering.arg_number				= 106
ADI_pitch_steering.input					= {-1.0, 1.0}
ADI_pitch_steering.output					= {-1.0, 1.0}
ADI_pitch_steering.controller				= controllers.ADI_pitch_steering

ADI_airspeed_deviation						= CreateGauge()
ADI_airspeed_deviation.arg_number			= 111
ADI_airspeed_deviation.input				= {-1.0, 1.0}
ADI_airspeed_deviation.output				= {-1.0, 1.0}
ADI_airspeed_deviation.controller			= controllers.ADI_airspeed_deviation

ADI_track_deviation							= CreateGauge()
ADI_track_deviation.arg_number				= 103
ADI_track_deviation.input					= {-1.0, 1.0}
ADI_track_deviation.output					= {-1.0, 1.0}
ADI_track_deviation.controller				= controllers.ADI_track_deviation

ADI_height_deviation						= CreateGauge()
ADI_height_deviation.arg_number				= 526
ADI_height_deviation.input					= {-1.0, 1.0}
ADI_height_deviation.output					= {-1.0, 1.0}
ADI_height_deviation.controller				= controllers.ADI_height_deviation
			
ADI_sideslip				= CreateGauge()
ADI_sideslip.arg_number		= 108
ADI_sideslip.input			= {-1.0, 1.0}
ADI_sideslip.output			= {-1.0, 1.0}
ADI_sideslip.controller		= controllers.ADI_sideslip

---------------------------------------------------
-- PNP-72-16 (HSI)
HSI_heading					= CreateGauge()
HSI_heading.arg_number		= 112
HSI_heading.input			= {0.0, math.pi * 2.0}
HSI_heading.output			= {0.0, 1.0}
HSI_heading.controller		= controllers.HSI_heading

HSI_commanded_course_needle					= CreateGauge()
HSI_commanded_course_needle.arg_number		= 118
HSI_commanded_course_needle.input			= {0.0, math.pi * 2.0}
HSI_commanded_course_needle.output			= {0.0, 1.0}
HSI_commanded_course_needle.controller		= controllers.HSI_commanded_course_needle

HSI_commanded_heading_needle					= CreateGauge()
HSI_commanded_heading_needle.arg_number			= 124
HSI_commanded_heading_needle.input				= {0.0, math.pi * 2.0}
HSI_commanded_heading_needle.output				= {0.0, 1.0}
HSI_commanded_heading_needle.controller			= controllers.HSI_commanded_heading_needle

HSI_bearing_needle								= CreateGauge()
HSI_bearing_needle.arg_number					= 115
HSI_bearing_needle.input						= {0.0, math.pi * 2.0}
HSI_bearing_needle.output						= {0.0, 1.0}
HSI_bearing_needle.controller					= controllers.HSI_bearing_needle

HSI_heading_warning_flag						= CreateGauge()
HSI_heading_warning_flag.arg_number				= 119
HSI_heading_warning_flag.input					= {0.0, 1.0}
HSI_heading_warning_flag.output					= {0.0, 1.0}
HSI_heading_warning_flag.controller				= controllers.HSI_heading_warning_flag

HSI_course_warning_flag							= CreateGauge()
HSI_course_warning_flag.arg_number				= 114
HSI_course_warning_flag.input					= {0.0, 1.0}
HSI_course_warning_flag.output					= {0.0, 1.0}
HSI_course_warning_flag.controller				= controllers.HSI_course_warning_flag

HSI_glideslope_warning_flag						= CreateGauge()
HSI_glideslope_warning_flag.arg_number			= 125
HSI_glideslope_warning_flag.input				= {0.0, 1.0}
HSI_glideslope_warning_flag.output				= {0.0, 1.0}
HSI_glideslope_warning_flag.controller			= controllers.HSI_glideslope_warning_flag

HSI_range_counter_hundreds						= CreateGauge()
HSI_range_counter_hundreds.arg_number			= 117
HSI_range_counter_hundreds.input				= {0.0, 10.0}
HSI_range_counter_hundreds.output				= {0.0, 1.0}
HSI_range_counter_hundreds.controller			= controllers.HSI_range_counter_hundreds

HSI_range_counter_tenth							= CreateGauge()
HSI_range_counter_tenth.arg_number				= 527
HSI_range_counter_tenth.input					= {0.0, 10.0}
HSI_range_counter_tenth.output					= {0.0, 1.0}
HSI_range_counter_tenth.controller				= controllers.HSI_range_counter_tenth

HSI_range_counter_units							= CreateGauge()
HSI_range_counter_units.arg_number				= 528
HSI_range_counter_units.input					= {0.0, 10.0}
HSI_range_counter_units.output					= {0.0, 1.0}
HSI_range_counter_units.controller				= controllers.HSI_range_counter_units

HSI_course_counter_hundreds_tenth				= CreateGauge()
HSI_course_counter_hundreds_tenth.arg_number	= 529
HSI_course_counter_hundreds_tenth.input			= {0.0, 36.0}
HSI_course_counter_hundreds_tenth.output		= {-1.0, 1.0}
HSI_course_counter_hundreds_tenth.controller	= controllers.HSI_course_counter_hundreds_tenth

HSI_course_counter_units						= CreateGauge()
HSI_course_counter_units.arg_number				= 530
HSI_course_counter_units.input					= {0.0, 10.0}
HSI_course_counter_units.output					= {0.0, 1.0}
HSI_course_counter_units.controller				= controllers.HSI_course_counter_units

HSI_longitudinal_deviation						= CreateGauge()
HSI_longitudinal_deviation.arg_number			= 127
HSI_longitudinal_deviation.input				= {-1.0, 1.0}
HSI_longitudinal_deviation.output				= {-1.0, 1.0}
HSI_longitudinal_deviation.controller			= controllers.HSI_longitudinal_deviation

HSI_lateral_deviation							= CreateGauge()
HSI_lateral_deviation.arg_number				= 128
HSI_lateral_deviation.input						= {-1.0, 1.0}
HSI_lateral_deviation.output					= {-1.0, 1.0}
HSI_lateral_deviation.controller				= controllers.HSI_lateral_deviation

HSI_range_unavailable_flag						= CreateGauge()
HSI_range_unavailable_flag.arg_number			= 116
HSI_range_unavailable_flag.input				= {0.0, 1.0}
HSI_range_unavailable_flag.output				= {0.0, 1.0}
HSI_range_unavailable_flag.controller			= controllers.HSI_range_unavailable_flag

HSI_course_unavailable_flag						= CreateGauge()
HSI_course_unavailable_flag.arg_number			= 121
HSI_course_unavailable_flag.input				= {0.0, 1.0}
HSI_course_unavailable_flag.output				= {0.0, 1.0}
HSI_course_unavailable_flag.controller			= controllers.HSI_course_unavailable_flag

HSI_courseKnob								    = CreateGauge()
HSI_courseKnob.arg_number					    = 126
HSI_courseKnob.input						    = {0.0, math.pi * 2.0}
HSI_courseKnob.output						    = {0.0, 1.0}
HSI_courseKnob.controller					    = controllers.HSI_courseKnob

HSI_headingKnob								    = CreateGauge()
HSI_headingKnob.arg_number					    = 129
HSI_headingKnob.input						    = {0.0, math.pi * 2.0}
HSI_headingKnob.output						    = {0.0, 1.0}
HSI_headingKnob.controller					    = controllers.HSI_headingKnob

---------------------------------------------------
-- Barometric altimeter VM-15PV

VM_15PV_BALT_thousands					= CreateGauge()
VM_15PV_BALT_thousands.arg_number		= 87
VM_15PV_BALT_thousands.input			= {0.0, 10000.0}
VM_15PV_BALT_thousands.output			= {0.0, 1.0}
VM_15PV_BALT_thousands.controller		= controllers.VM_15PV_BALT_thousands


VM_15PV_BALT_tenth						= CreateGauge()
VM_15PV_BALT_tenth.arg_number			= 573
VM_15PV_BALT_tenth.input				= {0.0, 1000.0}
VM_15PV_BALT_tenth.output				= {0.0, 1.0}
VM_15PV_BALT_tenth.controller			= controllers.VM_15PV_BALT_tenth

VM_15PV_BaroPressure					= CreateGauge()
VM_15PV_BaroPressure.arg_number			= 88
VM_15PV_BaroPressure.input				= {600,  620,   630,   640,  650,   670,   700,   720,   740,  750,  770, 800}
VM_15PV_BaroPressure.output				= {0.0, 0.12, 0.178, 0.236, 0.29, 0.396, 0.541, 0.638, 0.734, 0.78, 0.87, 1.0}
VM_15PV_BaroPressure.controller			= controllers.VM_15PV_BaroPressure
--[[
VM_15PV_BaroPressureRotary				= CreateGauge()
VM_15PV_BaroPressureRotary.arg_number	= 90
VM_15PV_BaroPressureRotary.input		= {0.0, 1.0}
VM_15PV_BaroPressureRotary.output		= {0.0, 1.0}
VM_15PV_BaroPressureRotary.controller	= controllers.VM_15PV_BaroPressureRotary
--]]
VM_15PV_BALT_CommandedAlt				= CreateGauge()
VM_15PV_BALT_CommandedAlt.arg_number	= 89
VM_15PV_BALT_CommandedAlt.input			= {0.0, 10000.0}
VM_15PV_BALT_CommandedAlt.output		= {0.0, 1.0}
VM_15PV_BALT_CommandedAlt.controller	= controllers.VM_15PV_BALT_CommandedAlt

---------------------------------------------------
-- Rotor RPM

RotorRPM					= CreateGauge()
RotorRPM.arg_number			= 52
RotorRPM.input				= {0.0, 110.0}
RotorRPM.output				= {0.0, 1.0}
RotorRPM.controller			= controllers.RotorRPM

---------------------------------------------------
-- Rotor Pitch

RotorPitch					= CreateGauge()
RotorPitch.arg_number		= 53
RotorPitch.input			= {1.0, 15.0}
RotorPitch.output			= {0.0, 1.0}
RotorPitch.controller		= controllers.RotorPitch

---------------------------------------------------
-- Radar altimeter A-036

A_036_RALT							= CreateGauge()
A_036_RALT.arg_number				= 94
A_036_RALT.input					= {0, 20, 50, 150, 200, 300, 350}
A_036_RALT.output					= {0.0, 0.1838, 0.4631, 0.7541, 0.8330, 0.9329, 1.0}
A_036_RALT.controller				= controllers.A_036_RALT

A_036_DangerRALT_index				= CreateGauge()
A_036_DangerRALT_index.arg_number   = 93
A_036_DangerRALT_index.input		= {0, 20, 50, 150, 200, 300, 350}
A_036_DangerRALT_index.output		= {0.0, 0.1838, 0.4631, 0.7541, 0.8330, 0.9329, 1.0}
A_036_DangerRALT_index.controller   = controllers.A_036_DangerRALT_index

A_036_DangerRALT_lamp				= CreateGauge()
A_036_DangerRALT_lamp.arg_number	= 92
A_036_DangerRALT_lamp.input			= {0.0, 1.0}
A_036_DangerRALT_lamp.output		= {0.0, 1.0}
A_036_DangerRALT_lamp.controller	= controllers.A_036_DangerRALT_lamp

A_036_warning_flag					= CreateGauge()
A_036_warning_flag.arg_number		= 95
A_036_warning_flag.input			= {0.0, 1.0}
A_036_warning_flag.output			= {0.0, 1.0}
A_036_warning_flag.controller		= controllers.A_036_warning_flag

---------------------------------------------------

--RadioCommunicator R-800
Radio_Test_lamp				= CreateGauge()
Radio_Test_lamp.arg_number	= 419
Radio_Test_lamp.input		= {0.0, 1.0}
Radio_Test_lamp.output		= {0.0, 1.0}
Radio_Test_lamp.controller	= controllers.Radio_Test_lamp

R800Revolve1			= CreateGauge()
R800Revolve1.arg_number	= 424
R800Revolve1.input		= {0.0, 1.0}
R800Revolve1.output		= {0.0, 1.0}
R800Revolve1.controller	= controllers.R800Revolve1

R800Rotary1				= CreateGauge()
R800Rotary1.arg_number	= 577
R800Rotary1.input		= {0.0, 1.0}
R800Rotary1.output		= {0.0, 1.0}
R800Rotary1.controller	= controllers.R800Rotary1

R800Revolve2			= CreateGauge()
R800Revolve2.arg_number	= 425
R800Revolve2.input		= {0.0, 1.0}
R800Revolve2.output		= {0.0, 1.0}
R800Revolve2.controller	= controllers.R800Revolve2

R800Rotary2				= CreateGauge()
R800Rotary2.arg_number	= 574
R800Rotary2.input		= {0.0, 1.0}
R800Rotary2.output		= {0.0, 1.0}
R800Rotary2.controller	= controllers.R800Rotary2

R800Revolve3			= CreateGauge()
R800Revolve3.arg_number	= 426
R800Revolve3.input		= {0.0, 1.0}
R800Revolve3.output		= {0.0, 1.0}
R800Revolve3.controller	= controllers.R800Revolve3

R800Rotary3				= CreateGauge()
R800Rotary3.arg_number	= 575
R800Rotary3.input		= {0.0, 1.0}
R800Rotary3.output		= {0.0, 1.0}
R800Rotary3.controller	= controllers.R800Rotary3

R800Revolve4			= CreateGauge()
R800Revolve4.arg_number	= 427
R800Revolve4.input		= {0.0, 1.0}
R800Revolve4.output		= {0.0, 1.0}
R800Revolve4.controller	= controllers.R800Revolve4

R800Rotary4				= CreateGauge()
R800Rotary4.arg_number	= 576
R800Rotary4.input		= {0.0, 1.0}
R800Rotary4.output		= {0.0, 1.0}
R800Rotary4.controller	= controllers.R800Rotary4

---------------------------------------------------

--RadioCommunicator R-828
Radio_ASU_lamp				= CreateGauge()
Radio_ASU_lamp.arg_number	= 375
Radio_ASU_lamp.input		= {0.0, 1.0}
Radio_ASU_lamp.output		= {0.0, 1.0}
Radio_ASU_lamp.controller	= controllers.Radio_ASU_lamp

R828_channel_selector				= CreateGauge()
R828_channel_selector.arg_number	= 581
R828_channel_selector.input			= {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
R828_channel_selector.output		= {0.007, 0.119, 0.234, 0.331, 0.447, 0.559, 0.663, 0.771, 0.884, 1.0};
R828_channel_selector.controller	= controllers.R828_channel_selector
---------------------------------------------------

-- Accelerometer ADP-4
ADP_4_acceleration				= CreateGauge()
ADP_4_acceleration.arg_number   = 97
ADP_4_acceleration.input		= {-2.0, 4.0}
ADP_4_acceleration.output		= {0.0, 1.0}
ADP_4_acceleration.controller   = controllers.ADP_4_acceleration

ADP_4_max_achieved_acc				= CreateGauge()
ADP_4_max_achieved_acc.arg_number   = 98
ADP_4_max_achieved_acc.input		= {-2.0, 4.0}
ADP_4_max_achieved_acc.output		= {0.0, 1.0}
ADP_4_max_achieved_acc.controller   = controllers.ADP_4_max_achieved_acc

ADP_4_min_achieved_acc				= CreateGauge()
ADP_4_min_achieved_acc.arg_number   = 99
ADP_4_min_achieved_acc.input		= {-2.0, 4.0}
ADP_4_min_achieved_acc.output		= {0.0, 1.0}
ADP_4_min_achieved_acc.controller   = controllers.ADP_4_min_achieved_acc

---------------------------------------------------
-- LGCP - Landing gear control panel

LGCP_Lamp_NoseGearUp					= CreateGauge()
LGCP_Lamp_NoseGearUp.arg_number			= 63
LGCP_Lamp_NoseGearUp.input				= {0.0, 1.0}
LGCP_Lamp_NoseGearUp.output				= {0.0, 1.0}
LGCP_Lamp_NoseGearUp.controller			= controllers.LGCP_Lamp_NoseGearUp

LGCP_Lamp_NoseGearDown					= CreateGauge()
LGCP_Lamp_NoseGearDown.arg_number		= 64
LGCP_Lamp_NoseGearDown.input			= {0.0, 1.0}
LGCP_Lamp_NoseGearDown.output			= {0.0, 1.0}
LGCP_Lamp_NoseGearDown.controller		= controllers.LGCP_Lamp_NoseGearDown

LGCP_Lamp_RightMainGearUp				= CreateGauge()
LGCP_Lamp_RightMainGearUp.arg_number	= 61
LGCP_Lamp_RightMainGearUp.input			= {0.0, 1.0}
LGCP_Lamp_RightMainGearUp.output		= {0.0, 1.0}
LGCP_Lamp_RightMainGearUp.controller	= controllers.LGCP_Lamp_RightMainGearUp

LGCP_Lamp_RightMainGearDown				= CreateGauge()
LGCP_Lamp_RightMainGearDown.arg_number	= 62
LGCP_Lamp_RightMainGearDown.input		= {0.0, 1.0}
LGCP_Lamp_RightMainGearDown.output		= {0.0, 1.0}
LGCP_Lamp_RightMainGearDown.controller	= controllers.LGCP_Lamp_RightMainGearDown

LGCP_Lamp_LeftMainGearUp				= CreateGauge()
LGCP_Lamp_LeftMainGearUp.arg_number		= 59
LGCP_Lamp_LeftMainGearUp.input			= {0.0, 1.0}
LGCP_Lamp_LeftMainGearUp.output			= {0.0, 1.0}
LGCP_Lamp_LeftMainGearUp.controller		= controllers.LGCP_Lamp_LeftMainGearUp

LGCP_Lamp_LeftMainGearDown				= CreateGauge()
LGCP_Lamp_LeftMainGearDown.arg_number	= 60
LGCP_Lamp_LeftMainGearDown.input		= {0.0, 1.0}
LGCP_Lamp_LeftMainGearDown.output		= {0.0, 1.0}
LGCP_Lamp_LeftMainGearDown.controller	= controllers.LGCP_Lamp_LeftMainGearDown

LGCP_gear_handle				= CreateGauge()
LGCP_gear_handle.arg_number		= 65
LGCP_gear_handle.input			= {0.0, 1.0}
LGCP_gear_handle.output			= {0.0, 1.0}
LGCP_gear_handle.controller		= controllers.LGCP_gear_handle

---------------------------------------------------
-- Mechanic clock

CLOCK_currtime_hours				= CreateGauge()
CLOCK_currtime_hours.arg_number		= 68
CLOCK_currtime_hours.input			= {0.0, 12.0}
CLOCK_currtime_hours.output			= {0.0, 1.0}
CLOCK_currtime_hours.controller		= controllers.CLOCK_currtime_hours

CLOCK_currtime_minutes				= CreateGauge()
CLOCK_currtime_minutes.arg_number	= 69
CLOCK_currtime_minutes.input		= {0.0, 60.0}
CLOCK_currtime_minutes.output		= {0.0, 1.0}
CLOCK_currtime_minutes.controller	= controllers.CLOCK_currtime_minutes

CLOCK_currtime_seconds				= CreateGauge()
CLOCK_currtime_seconds.arg_number	= 70
CLOCK_currtime_seconds.input		= {0.0, 60.0}
CLOCK_currtime_seconds.output		= {0.0, 1.0}
CLOCK_currtime_seconds.controller	= controllers.CLOCK_currtime_seconds

CLOCK_flight_time_meter_status				= CreateGauge()
CLOCK_flight_time_meter_status.arg_number	= 75
CLOCK_flight_time_meter_status.input		= {0.0, 0.2}
CLOCK_flight_time_meter_status.output		= {0.0, 0.2}
CLOCK_flight_time_meter_status.controller	= controllers.CLOCK_flight_time_meter_status

CLOCK_flight_hours					= CreateGauge()
CLOCK_flight_hours.arg_number		= 72
CLOCK_flight_hours.input			= {0.0, 12.0}
CLOCK_flight_hours.output			= {0.0, 1.0}
CLOCK_flight_hours.controller		= controllers.CLOCK_flight_hours

CLOCK_flight_minutes				= CreateGauge()
CLOCK_flight_minutes.arg_number		= 531
CLOCK_flight_minutes.input			= {0.0, 60.0}
CLOCK_flight_minutes.output			= {0.0, 1.0}
CLOCK_flight_minutes.controller		= controllers.CLOCK_flight_minutes

CLOCK_seconds_meter_time_minutes				= CreateGauge()
CLOCK_seconds_meter_time_minutes.arg_number		= 73
CLOCK_seconds_meter_time_minutes.input			= {0.0, 60.0}
CLOCK_seconds_meter_time_minutes.output			= {0.0, 1.0}
CLOCK_seconds_meter_time_minutes.controller		= controllers.CLOCK_seconds_meter_time_minutes

CLOCK_seconds_meter_time_seconds				= CreateGauge()
CLOCK_seconds_meter_time_seconds.arg_number		= 532
CLOCK_seconds_meter_time_seconds.input			= {0.0, 60.0}
CLOCK_seconds_meter_time_seconds.output			= {0.0, 1.0}
CLOCK_seconds_meter_time_seconds.controller		= controllers.CLOCK_seconds_meter_time_seconds

	
--=================================================
-- Upper panel
--=================================================

---------------------------------------------------
-- KI-13 (magnetic compass)

KI_13_course				= CreateGauge()
KI_13_course.arg_number		= 11
KI_13_course.input			= {0, math.pi * 2.0}
KI_13_course.output			= {-1, 1}
KI_13_course.controller		= controllers.KI_13_course

KI_13_pitch					= CreateGauge()
KI_13_pitch.arg_number		= 12
KI_13_pitch.input			= {-math.pi / 2.0, math.pi / 2.0}
KI_13_pitch.output			= {-1, 1}
KI_13_pitch.controller		= controllers.KI_13_pitch

KI_13_bank					= CreateGauge()
KI_13_bank.arg_number		= 14
KI_13_bank.input			= {-math.pi, math.pi}
KI_13_bank.output			= {-1, 1}
KI_13_bank.controller		= controllers.KI_13_bank


--=================================================
-- Right main panel
--=================================================

---------------------------------------------------
-- AGR-81 backup ADI

AGR_81_Roll					= CreateGauge()
AGR_81_Roll.arg_number		= 142
AGR_81_Roll.input			= {-math.pi, math.pi}
AGR_81_Roll.output			= {1.0, -1.0}
AGR_81_Roll.controller		= controllers.AGR_81_Roll

AGR_81_Pitch				= CreateGauge()
AGR_81_Pitch.arg_number		= 143
AGR_81_Pitch.input			= {-math.pi / 2.0, math.pi / 2.0}
AGR_81_Pitch.output			= {-1.0, 1.0}
AGR_81_Pitch.controller		= controllers.AGR_81_Pitch

AGR_81_sideslip				= CreateGauge()
AGR_81_sideslip.arg_number	= 144
AGR_81_sideslip.input		= {-1.0, 1.0}
AGR_81_sideslip.output		= {-1.0, 1.0}
AGR_81_sideslip.controller	= controllers.AGR_81_sideslip

AGR_81_failure_flag				= CreateGauge()
AGR_81_failure_flag.arg_number	= 145
AGR_81_failure_flag.input		= {0.0, 1.0}
AGR_81_failure_flag.output		= {0.0, 1.0}
AGR_81_failure_flag.controller	= controllers.AGR_81_failure_flag

AGR_81_LongitudinalDeviationBar				= CreateGauge()
AGR_81_LongitudinalDeviationBar.arg_number	= 599
AGR_81_LongitudinalDeviationBar.input		= {-1.0, 1.0}
AGR_81_LongitudinalDeviationBar.output		= {-1.0, 1.0}
AGR_81_LongitudinalDeviationBar.controller	= controllers.AGR_81_LongitudinalDeviationBar

AGR_81_LateralDeviationBar					= CreateGauge()
AGR_81_LateralDeviationBar.arg_number		= 613
AGR_81_LateralDeviationBar.input			= {-1.0, 1.0}
AGR_81_LateralDeviationBar.output			= {-1.0, 1.0}
AGR_81_LateralDeviationBar.controller		= controllers.AGR_81_LateralDeviationBar

---------------------------------------------------
-- ABRIS

lamp_ABRIS_button1				= CreateGauge()
lamp_ABRIS_button1.arg_number	= 561
lamp_ABRIS_button1.input		= {0.0, 1.0}
lamp_ABRIS_button1.output		= {0.0, 1.0}
lamp_ABRIS_button1.controller	= controllers.lamp_ABRIS_button1

lamp_ABRIS_button2				= CreateGauge()
lamp_ABRIS_button2.arg_number	= 562
lamp_ABRIS_button2.input		= {0.0, 1.0}
lamp_ABRIS_button2.output		= {0.0, 1.0}
lamp_ABRIS_button2.controller	= controllers.lamp_ABRIS_button2

lamp_ABRIS_button3				= CreateGauge()
lamp_ABRIS_button3.arg_number	= 563
lamp_ABRIS_button3.input		= {0.0, 1.0}
lamp_ABRIS_button3.output		= {0.0, 1.0}
lamp_ABRIS_button3.controller	= controllers.lamp_ABRIS_button3

lamp_ABRIS_button4				= CreateGauge()
lamp_ABRIS_button4.arg_number	= 564
lamp_ABRIS_button4.input		= {0.0, 1.0}
lamp_ABRIS_button4.output		= {0.0, 1.0}
lamp_ABRIS_button4.controller	= controllers.lamp_ABRIS_button4

lamp_ABRIS_button5				= CreateGauge()
lamp_ABRIS_button5.arg_number	= 565
lamp_ABRIS_button5.input		= {0.0, 1.0}
lamp_ABRIS_button5.output		= {0.0, 1.0}
lamp_ABRIS_button5.controller	= controllers.lamp_ABRIS_button5

---------------------------------------------------
-- Engines RPM
LeftEngineRPM					= CreateGauge()
LeftEngineRPM.arg_number		= 135
LeftEngineRPM.input				= {0.0, 110.0}
LeftEngineRPM.output			= {0.0, 1.0}
LeftEngineRPM.controller		= controllers.LeftEngineRPM

RightEngineRPM					= CreateGauge()
RightEngineRPM.arg_number		= 136
RightEngineRPM.input			= {0.0, 110.0}
RightEngineRPM.output			= {0.0, 1.0}
RightEngineRPM.controller		= controllers.RightEngineRPM

---------------------------------------------------
-- Engines temperature
LeftEngineTemperatureHund				= CreateGauge()
LeftEngineTemperatureHund.arg_number	= 133
LeftEngineTemperatureHund.input			= {0.0, 1200.0}
LeftEngineTemperatureHund.output		= {0.0, 1.0}
LeftEngineTemperatureHund.controller	= controllers.LeftEngineTemperatureHund

LeftEngineTemperatureTenth				= CreateGauge()
LeftEngineTemperatureTenth.arg_number	= 566
LeftEngineTemperatureTenth.input		= {0.0, 100.0}
LeftEngineTemperatureTenth.output		= {0.0, 1.0}
LeftEngineTemperatureTenth.controller	= controllers.LeftEngineTemperatureTenth

RightEngineTemperatureHund				= CreateGauge()
RightEngineTemperatureHund.arg_number	= 134
RightEngineTemperatureHund.input		= {0.0, 1200.0}
RightEngineTemperatureHund.output		= {0.0, 1.0}
RightEngineTemperatureHund.controller	= controllers.RightEngineTemperatureHund

RightEngineTemperatureTenth				= CreateGauge()
RightEngineTemperatureTenth.arg_number	= 567
RightEngineTemperatureTenth.input		= {0.0, 100.0}
RightEngineTemperatureTenth.output		= {0.0, 1.0}
RightEngineTemperatureTenth.controller	= controllers.RightEngineTemperatureTenth

-- APU Temperature
APUTemperature				= CreateGauge()
APUTemperature.arg_number	= 6
APUTemperature.input		= {0.0, 900.0}
APUTemperature.output		= {0.0, 1.0}
APUTemperature.controller	= controllers.APUTemperature

-- Engines mode indicator
-- Middle pointer is calibrated for nominal mode pressure
-- Cruise mode = nominal - 0.45 kgs/sm sq
-- Take-off mode = nominal + 0.98 kgs/sm sq
EnginesMode					= CreateGauge()
EnginesMode.arg_number		= 592
EnginesMode.input			= {5.45, 9.02}
EnginesMode.output			= {0, 1}
EnginesMode.controller		= controllers.EnginesMode

LeftEngineMode				= CreateGauge()
LeftEngineMode.arg_number	= 234
LeftEngineMode.input		= {5, 10}
LeftEngineMode.output		= {0, 1}
LeftEngineMode.controller	= controllers.LeftEngineMode

RightEngineMode				= CreateGauge()
RightEngineMode.arg_number	= 235
RightEngineMode.input		= {5, 10}
RightEngineMode.output		= {0, 1}
RightEngineMode.controller	= controllers.RightEngineMode

---------------------------------------------------
-- Fuel tanks
ForwardTankAmount						= CreateGauge()
ForwardTankAmount.arg_number			= 137
ForwardTankAmount.input					= {0.0, 1.0}
ForwardTankAmount.output				= {0.0, 1.0}
ForwardTankAmount.controller			= controllers.ForwardTankAmount

RearTankAmount							= CreateGauge()
RearTankAmount.arg_number				= 138
RearTankAmount.input					= {0.0, 1.0}
RearTankAmount.output					= {0.0, 1.0}
RearTankAmount.controller				= controllers.RearTankAmount

lamp_ForwardTankTest					= CreateGauge()
lamp_ForwardTankTest.arg_number			= 139
lamp_ForwardTankTest.input				= {0.0, 1.0}
lamp_ForwardTankTest.output				= {0.0, 1.0}
lamp_ForwardTankTest.controller			= controllers.lamp_ForwardTankTest

lamp_RearTankTest						= CreateGauge()
lamp_RearTankTest.arg_number			= 140
lamp_RearTankTest.input					= {0.0, 1.0}
lamp_RearTankTest.output				= {0.0, 1.0}
lamp_RearTankTest.controller			= controllers.lamp_RearTankTest

--=================================================
-- Right panel
--=================================================

---------------------------------------------------
-- Fire Extinguishers panel

lamp_Exting_LeftEngineFire				= CreateGauge()
lamp_Exting_LeftEngineFire.arg_number	= 237
lamp_Exting_LeftEngineFire.input		= {0.0, 1.0}
lamp_Exting_LeftEngineFire.output		= {0.0, 1.0}
lamp_Exting_LeftEngineFire.controller	= controllers.lamp_Exting_LeftEngineFire

lamp_Exting_APU_Fire					= CreateGauge()
lamp_Exting_APU_Fire.arg_number			= 239
lamp_Exting_APU_Fire.input				= {0.0, 1.0}
lamp_Exting_APU_Fire.output				= {0.0, 1.0}
lamp_Exting_APU_Fire.controller			= controllers.lamp_Exting_APU_Fire

lamp_Exting_HydraulicsFire				= CreateGauge()
lamp_Exting_HydraulicsFire.arg_number	= 568
lamp_Exting_HydraulicsFire.input		= {0.0, 1.0}
lamp_Exting_HydraulicsFire.output		= {0.0, 1.0}
lamp_Exting_HydraulicsFire.controller	= controllers.lamp_Exting_Hydraulics_Fire

lamp_Exting_RightEngineFire				= CreateGauge()
lamp_Exting_RightEngineFire.arg_number	= 241
lamp_Exting_RightEngineFire.input		= {0.0, 1.0}
lamp_Exting_RightEngineFire.output		= {0.0, 1.0}
lamp_Exting_RightEngineFire.controller	= controllers.lamp_Exting_RightEngineFire

lamp_Exting_VentilatorFire				= CreateGauge()
lamp_Exting_VentilatorFire.arg_number	= 243
lamp_Exting_VentilatorFire.input		= {0.0, 1.0}
lamp_Exting_VentilatorFire.output		= {0.0, 1.0}
lamp_Exting_VentilatorFire.controller	= controllers.lamp_Exting_VentilatorFire

lamp_Exting_Lamp1						= CreateGauge()
lamp_Exting_Lamp1.arg_number			= 244
lamp_Exting_Lamp1.input					= {0.0, 1.0}
lamp_Exting_Lamp1.output				= {0.0, 1.0}
lamp_Exting_Lamp1.controller			= controllers.lamp_Exting_Lamp1

lamp_Exting_Lamp2						= CreateGauge()
lamp_Exting_Lamp2.arg_number			= 245
lamp_Exting_Lamp2.input					= {0.0, 1.0}
lamp_Exting_Lamp2.output				= {0.0, 1.0}
lamp_Exting_Lamp2.controller			= controllers.lamp_Exting_Lamp2

---------------------------------------------------
-- Oil pressure and temperature indicators group
NeedleOilPressureEngineLeft					= CreateGauge()
NeedleOilPressureEngineLeft.arg_number		= 252
NeedleOilPressureEngineLeft.input			= {0.0, 1.0}
NeedleOilPressureEngineLeft.output			= {0.0, 1.0}
NeedleOilPressureEngineLeft.controller		= controllers.NeedleOilPressureEngineLeft

NeedleOilPressureEngineRight				= CreateGauge()
NeedleOilPressureEngineRight.arg_number		= 253
NeedleOilPressureEngineRight.input			= {0.0, 1.0}
NeedleOilPressureEngineRight.output			= {0.0, 1.0}
NeedleOilPressureEngineRight.controller		= controllers.NeedleOilPressureEngineRight

NeedleOilPressureGearBox					= CreateGauge()
NeedleOilPressureGearBox.arg_number			= 254
NeedleOilPressureGearBox.input				= {0.0, 1.0}
NeedleOilPressureGearBox.output				= {0.0, 1.0}
NeedleOilPressureGearBox.controller			= controllers.NeedleOilPressureGearBox

NeedleOilTemperatureEngineLeft				= CreateGauge()
NeedleOilTemperatureEngineLeft.arg_number	= 255
NeedleOilTemperatureEngineLeft.input		= {0.0, 1.0}
NeedleOilTemperatureEngineLeft.output		= {0.0, 1.0}
NeedleOilTemperatureEngineLeft.controller	= controllers.NeedleOilTemperatureEngineLeft

NeedleOilTemperatureEngineRight				= CreateGauge()
NeedleOilTemperatureEngineRight.arg_number	= 256
NeedleOilTemperatureEngineRight.input		= {0.0, 1.0}
NeedleOilTemperatureEngineRight.output		= {0.0, 1.0}
NeedleOilTemperatureEngineRight.controller	= controllers.NeedleOilTemperatureEngineRight

NeedleOilTemperatureGearBox					= CreateGauge()
NeedleOilTemperatureGearBox.arg_number		= 257
NeedleOilTemperatureGearBox.input			= {0.0, 1.0}
NeedleOilTemperatureGearBox.output			= {0.0, 1.0}
NeedleOilTemperatureGearBox.controller		= controllers.NeedleOilTemperatureGearBox

---------------------------------------------------
-- Panels buttons light
Panels_buttons_light			= CreateGauge()
Panels_buttons_light.arg_number	= 551
Panels_buttons_light.input		= {0.0, 1.0}
Panels_buttons_light.output		= {0.0, 1.0}
Panels_buttons_light.controller	= controllers.Panels_buttons_light

---------------------------------------------------
-- PVI (Nav Control Panel)
PVI_button_ENTER				= CreateGauge()
PVI_button_ENTER.arg_number		= 313
PVI_button_ENTER.input			= {0.0, 0.3}
PVI_button_ENTER.output			= {0.0, 0.3}
PVI_button_ENTER.controller		= controllers.PVI_button_ENTER

PVI_button_CANCEL				= CreateGauge()
PVI_button_CANCEL.arg_number	= 314
PVI_button_CANCEL.input			= {0.0, 0.3}
PVI_button_CANCEL.output		= {0.0, 0.3}
PVI_button_CANCEL.controller	= controllers.PVI_button_CANCEL

PVI_button_WPT					= CreateGauge()
PVI_button_WPT.arg_number		= 315
PVI_button_WPT.input			= {0.0, 0.3}
PVI_button_WPT.output			= {0.0, 0.3}
PVI_button_WPT.controller		= controllers.PVI_button_WPT

PVI_button_FIXPT				= CreateGauge()
PVI_button_FIXPT.arg_number		= 316
PVI_button_FIXPT.input			= {0.0, 0.3}
PVI_button_FIXPT.output			= {0.0, 0.3}
PVI_button_FIXPT.controller		= controllers.PVI_button_FIXPT

PVI_button_AERDR				= CreateGauge()
PVI_button_AERDR.arg_number		= 317
PVI_button_AERDR.input			= {0.0, 0.3}
PVI_button_AERDR.output			= {0.0, 0.3}
PVI_button_AERDR.controller		= controllers.PVI_button_AERDR

PVI_button_TGT					= CreateGauge()
PVI_button_TGT.arg_number		= 318
PVI_button_TGT.input			= {0.0, 0.3}
PVI_button_TGT.output			= {0.0, 0.3}
PVI_button_TGT.controller		= controllers.PVI_button_TGT

PVI_button_FILAMBDA				= CreateGauge()
PVI_button_FILAMBDA.arg_number	= 319
PVI_button_FILAMBDA.input		= {0.0, 0.3}
PVI_button_FILAMBDA.output		= {0.0, 0.3}
PVI_button_FILAMBDA.controller	= controllers.PVI_button_FILAMBDA

PVI_button_FIZ					= CreateGauge()
PVI_button_FIZ.arg_number		= 320
PVI_button_FIZ.input			= {0.0, 0.3}
PVI_button_FIZ.output			= {0.0, 0.3}
PVI_button_FIZ.controller		= controllers.PVI_button_FIZ

PVI_button_DU					= CreateGauge()
PVI_button_DU.arg_number		= 321
PVI_button_DU.input				= {0.0, 0.3}
PVI_button_DU.output			= {0.0, 0.3}
PVI_button_DU.controller		= controllers.PVI_button_DU

PVI_button_FII					= CreateGauge()
PVI_button_FII.arg_number		= 322
PVI_button_FII.input			= {0.0, 0.3}
PVI_button_FII.output			= {0.0, 0.3}
PVI_button_FII.controller		= controllers.PVI_button_FII

PVI_button_BRGRNG				= CreateGauge()
PVI_button_BRGRNG.arg_number	= 323
PVI_button_BRGRNG.input			= {0.0, 0.3}
PVI_button_BRGRNG.output		= {0.0, 0.3}
PVI_button_BRGRNG.controller	= controllers.PVI_button_BRGRNG

PVI_button_INSREALN				= CreateGauge()
PVI_button_INSREALN.arg_number	= 519
PVI_button_INSREALN.input		= {0.0, 0.3}
PVI_button_INSREALN.output		= {0.0, 0.3}
PVI_button_INSREALN.controller	= controllers.PVI_button_INSREALN

PVI_button_PRECALN				= CreateGauge()
PVI_button_PRECALN.arg_number	= 520
PVI_button_PRECALN.input		= {0.0, 0.3}
PVI_button_PRECALN.output		= {0.0, 0.3}
PVI_button_PRECALN.controller	= controllers.PVI_button_PRECALN

PVI_button_NORMALN				= CreateGauge()
PVI_button_NORMALN.arg_number	= 521
PVI_button_NORMALN.input		= {0.0, 0.3}
PVI_button_NORMALN.output		= {0.0, 0.3}
PVI_button_NORMALN.controller	= controllers.PVI_button_NORMALN

PVI_button_INITCOORD			= CreateGauge()
PVI_button_INITCOORD.arg_number	= 522
PVI_button_INITCOORD.input		= {0.0, 0.3}
PVI_button_INITCOORD.output		= {0.0, 0.3}
PVI_button_INITCOORD.controller	= controllers.PVI_button_INITCOORD

PPR_button_K			= CreateGauge()
PPR_button_K.arg_number	= 330
PPR_button_K.input		= {0.0, 0.3}
PPR_button_K.output		= {0.0, 0.3}
PPR_button_K.controller	= controllers.PPR_button_K

PPR_button_H			= CreateGauge()
PPR_button_H.arg_number	= 332
PPR_button_H.input		= {0.0, 0.3}
PPR_button_H.output		= {0.0, 0.3}
PPR_button_H.controller	= controllers.PPR_button_H

PPR_button_B			= CreateGauge()
PPR_button_B.arg_number	= 333
PPR_button_B.input		= {0.0, 0.3}
PPR_button_B.output		= {0.0, 0.3}
PPR_button_B.controller	= controllers.PPR_button_B

PPR_button_T			= CreateGauge()
PPR_button_T.arg_number	= 331
PPR_button_T.input		= {0.0, 0.3}
PPR_button_T.output		= {0.0, 0.3}
PPR_button_T.controller	= controllers.PPR_button_T

PPR_button_DIR				= CreateGauge()
PPR_button_DIR.arg_number	= 334
PPR_button_DIR.input		= {0.0, 0.3}
PPR_button_DIR.output		= {0.0, 0.3}
PPR_button_DIR.controller	= controllers.PPR_button_DIR

--=================================================
-- Left panel
--=================================================

---------------------------------------------------
-- Engines start panel

lamp_EnginesStartValve				= CreateGauge()
lamp_EnginesStartValve.arg_number	= 163
lamp_EnginesStartValve.input		= {0.0, 1.0}
lamp_EnginesStartValve.output		= {0.0, 1.0}
lamp_EnginesStartValve.controller	= controllers.lamp_EnginesStartValve

-- Engines breaks
left_engine_break_hangle				= CreateGauge()
left_engine_break_hangle.arg_number		= 554
left_engine_break_hangle.input			= {0.0, 1.0}
left_engine_break_hangle.output			= {0.0, 1.0}
left_engine_break_hangle.controller		= controllers.left_engine_break_hangle

right_engine_break_hangle				= CreateGauge()
right_engine_break_hangle.arg_number	= 555
right_engine_break_hangle.input			= {0.0, 1.0}
right_engine_break_hangle.output		= {0.0, 1.0}
right_engine_break_hangle.controller	= controllers.right_engine_break_hangle

---------------------------------------------------
-- APU control panel
lamp_APUValveOpen					= CreateGauge()
lamp_APUValveOpen.arg_number		= 162
lamp_APUValveOpen.input				= {0.0, 1.0}
lamp_APUValveOpen.output			= {0.0, 1.0}
lamp_APUValveOpen.controller		= controllers.lamp_APUValveOpen

lamp_APUOilPres						= CreateGauge()
lamp_APUOilPres.arg_number			= 168
lamp_APUOilPres.input				= {0.0, 1.0}
lamp_APUOilPres.output				= {0.0, 1.0}
lamp_APUOilPres.controller			= controllers.lamp_APUOilPres

lamp_APUStoppedByRPM				= CreateGauge()
lamp_APUStoppedByRPM.arg_number		= 169
lamp_APUStoppedByRPM.input			= {0.0, 1.0}
lamp_APUStoppedByRPM.output			= {0.0, 1.0}
lamp_APUStoppedByRPM.controller		= controllers.lamp_APUStoppedByRPM

lamp_APU_IsON						= CreateGauge()
lamp_APU_IsON.arg_number			= 174
lamp_APU_IsON.input					= {0.0, 1.0}
lamp_APU_IsON.output				= {0.0, 1.0}
lamp_APU_IsON.controller			= controllers.lamp_APU_IsON

lamp_PUI800_Sta1_WeapIsPresent				= CreateGauge()
lamp_PUI800_Sta1_WeapIsPresent.arg_number	= 392
lamp_PUI800_Sta1_WeapIsPresent.input		= {0.0, 1.0}
lamp_PUI800_Sta1_WeapIsPresent.output		= {0.0, 1.0}
lamp_PUI800_Sta1_WeapIsPresent.controller	= controllers.lamp_PUI800_Sta1_WeapIsPresent

lamp_PUI800_Sta2_WeapIsPresent				= CreateGauge()
lamp_PUI800_Sta2_WeapIsPresent.arg_number	= 393
lamp_PUI800_Sta2_WeapIsPresent.input		= {0.0, 1.0}
lamp_PUI800_Sta2_WeapIsPresent.output		= {0.0, 1.0}
lamp_PUI800_Sta2_WeapIsPresent.controller	= controllers.lamp_PUI800_Sta2_WeapIsPresent

lamp_PUI800_Sta3_WeapIsPresent				= CreateGauge()
lamp_PUI800_Sta3_WeapIsPresent.arg_number	= 394
lamp_PUI800_Sta3_WeapIsPresent.input		= {0.0, 1.0}
lamp_PUI800_Sta3_WeapIsPresent.output		= {0.0, 1.0}
lamp_PUI800_Sta3_WeapIsPresent.controller	= controllers.lamp_PUI800_Sta3_WeapIsPresent

lamp_PUI800_Sta4_WeapIsPresent				= CreateGauge()
lamp_PUI800_Sta4_WeapIsPresent.arg_number	= 395
lamp_PUI800_Sta4_WeapIsPresent.input		= {0.0, 1.0}
lamp_PUI800_Sta4_WeapIsPresent.output		= {0.0, 1.0}
lamp_PUI800_Sta4_WeapIsPresent.controller	= controllers.lamp_PUI800_Sta4_WeapIsPresent

lamp_PUI800_Sta1_WeapIsReady				= CreateGauge()
lamp_PUI800_Sta1_WeapIsReady.arg_number		= 388
lamp_PUI800_Sta1_WeapIsReady.input			= {0.0, 1.0}
lamp_PUI800_Sta1_WeapIsReady.output			= {0.0, 1.0}
lamp_PUI800_Sta1_WeapIsReady.controller		= controllers.lamp_PUI800_Sta1_WeapIsReady

lamp_PUI800_Sta2_WeapIsReady				= CreateGauge()
lamp_PUI800_Sta2_WeapIsReady.arg_number		= 389
lamp_PUI800_Sta2_WeapIsReady.input			= {0.0, 1.0}
lamp_PUI800_Sta2_WeapIsReady.output			= {0.0, 1.0}
lamp_PUI800_Sta2_WeapIsReady.controller		= controllers.lamp_PUI800_Sta2_WeapIsReady

lamp_PUI800_Sta3_WeapIsReady				= CreateGauge()
lamp_PUI800_Sta3_WeapIsReady.arg_number		= 390
lamp_PUI800_Sta3_WeapIsReady.input			= {0.0, 1.0}
lamp_PUI800_Sta3_WeapIsReady.output			= {0.0, 1.0}
lamp_PUI800_Sta3_WeapIsReady.controller		= controllers.lamp_PUI800_Sta3_WeapIsReady

lamp_PUI800_Sta4_WeapIsReady				= CreateGauge()
lamp_PUI800_Sta4_WeapIsReady.arg_number		= 391
lamp_PUI800_Sta4_WeapIsReady.input			= {0.0, 1.0}
lamp_PUI800_Sta4_WeapIsReady.output			= {0.0, 1.0}
lamp_PUI800_Sta4_WeapIsReady.controller		= controllers.lamp_PUI800_Sta4_WeapIsReady

---------------------------------------------------
-- Right Side Panel
lamp_AC_Ground_Power					= CreateGauge()
lamp_AC_Ground_Power.arg_number			= 586
lamp_AC_Ground_Power.input				= {0.0, 1.0}
lamp_AC_Ground_Power.output				= {0.0, 1.0}
lamp_AC_Ground_Power.controller			= controllers.lamp_AC_Ground_Power

lamp_DC_Ground_Power					= CreateGauge()
lamp_DC_Ground_Power.arg_number			= 261
lamp_DC_Ground_Power.input				= {0.0, 1.0}
lamp_DC_Ground_Power.output				= {0.0, 1.0}
lamp_DC_Ground_Power.controller			= controllers.lamp_DC_Ground_Power

---------------------------------------------------
-- Right Back Panel
lamp_flap_hydro_1				= CreateGauge()
lamp_flap_hydro_1.arg_number	= 469
lamp_flap_hydro_1.input			= {0.0, 1.0}
lamp_flap_hydro_1.output		= {0.0, 1.0}
lamp_flap_hydro_1.controller	= controllers.lamp_flap_hydro_1

lamp_flap_hydro_2				= CreateGauge()
lamp_flap_hydro_2.arg_number	= 470
lamp_flap_hydro_2.input			= {0.0, 1.0}
lamp_flap_hydro_2.output		= {0.0, 1.0}
lamp_flap_hydro_2.controller	= controllers.lamp_flap_hydro_2

-- Hydraulics
hydro_common_pressure				= CreateGauge()
hydro_common_pressure.arg_number	= 471
hydro_common_pressure.input			= {0.0, 1.0}
hydro_common_pressure.output		= {0.0, 1.0}
hydro_common_pressure.controller	= controllers.hydro_common_pressure

hydro_main_pressure				= CreateGauge()
hydro_main_pressure.arg_number	= 472
hydro_main_pressure.input		= {0.0, 1.0}
hydro_main_pressure.output		= {0.0, 1.0}
hydro_main_pressure.controller	= controllers.hydro_main_pressure

hydro_acc_brake_pressure			= CreateGauge()
hydro_acc_brake_pressure.arg_number	= 473
hydro_acc_brake_pressure.input		= {0.0, 1.0}
hydro_acc_brake_pressure.output		= {0.0, 1.0}
hydro_acc_brake_pressure.controller	= controllers.hydro_acc_brake_pressure

hydro_gear_brake_pressure				= CreateGauge()
hydro_gear_brake_pressure.arg_number	= 474
hydro_gear_brake_pressure.input			= {0.0, 1.0}
hydro_gear_brake_pressure.output		= {0.0, 1.0}
hydro_gear_brake_pressure.controller	= controllers.hydro_gear_brake_pressure

hydro_common_temperature			= CreateGauge()
hydro_common_temperature.arg_number	= 475
hydro_common_temperature.input		= {0.0, 1.0}
hydro_common_temperature.output		= {0.0, 1.0}
hydro_common_temperature.controller	= controllers.hydro_common_temperature

hydro_main_temperature				= CreateGauge()
hydro_main_temperature.arg_number	= 476
hydro_main_temperature.input		= {0.0, 1.0}
hydro_main_temperature.output		= {0.0, 1.0}
hydro_main_temperature.controller	= controllers.hydro_main_temperature

-- Eject system
EjectSystemTestLamp				= CreateGauge()
EjectSystemTestLamp.arg_number	= 461
EjectSystemTestLamp.input		= {0.0, 1.0}
EjectSystemTestLamp.output		= {0.0, 1.0}
EjectSystemTestLamp.controller	= controllers.EjectSystemTestLamp

--------------------------------------------------------------------------------------------
-- PShK_7 (Latitude Entry Panel)
PShK7_Latitude_counter_tenth				= CreateGauge()
PShK7_Latitude_counter_tenth.arg_number		= 339
PShK7_Latitude_counter_tenth.input			= {0.0, 10.0}
PShK7_Latitude_counter_tenth.output			= {0.0, 1.0}
PShK7_Latitude_counter_tenth.controller		= controllers.PShK7_Latitude_counter_tenth

PShK7_Latitude_counter_units				= CreateGauge()
PShK7_Latitude_counter_units.arg_number		= 594
PShK7_Latitude_counter_units.input			= {0.0, 10.0}
PShK7_Latitude_counter_units.output			= {0.0, 1.0}
PShK7_Latitude_counter_units.controller		= controllers.PShK7_Latitude_counter_units

PShK7_LampAuto								= CreateGauge()
PShK7_LampAuto.arg_number					= 342
PShK7_LampAuto.input						= {0.0, 1.0}
PShK7_LampAuto.output						= {0.0, 1.0}
PShK7_LampAuto.controller					= controllers.PShK7_LampAuto

--------------------------------------------------------------------------------------------
-- ZMS_3 (Magnetic Variation Entry Panel)
ZMS3_MagVar_counter_hundreds_tenth				= CreateGauge()
ZMS3_MagVar_counter_hundreds_tenth.arg_number	= 337
ZMS3_MagVar_counter_hundreds_tenth.input		= {-18.0, 18.0}
ZMS3_MagVar_counter_hundreds_tenth.output		= {-1.0, 1.0}
ZMS3_MagVar_counter_hundreds_tenth.controller	= controllers.ZMS3_MagVar_counter_hundreds_tenth

ZMS3_MagVar_counter_units					= CreateGauge()
ZMS3_MagVar_counter_units.arg_number		= 596
ZMS3_MagVar_counter_units.input				= {0.0, 10.0}
ZMS3_MagVar_counter_units.output			= {0.0, 1.0}
ZMS3_MagVar_counter_units.controller		= controllers.ZMS3_MagVar_counter_units

--------------------------------------------------------------------------------------------
-- Mechanical stuff
wheel_brakes				= CreateGauge()
wheel_brakes.arg_number		= 571
wheel_brakes.input			= {0.0, 1.0}
wheel_brakes.output			= {0.0, 1.0}
wheel_brakes.controller		= controllers.wheel_brakes

gun_trigger				    = CreateGauge()
gun_trigger.arg_number		= 615
gun_trigger.input			= { -1.0, 1.0}
gun_trigger.output			= {  1.0,-1.0}
gun_trigger.controller		= controllers.gun_trigger

missile_trigger				    = CreateGauge()
missile_trigger.arg_number		= 614
missile_trigger.input			= { -1.0, 1.0}
missile_trigger.output			= {  1.0,-1.0}
missile_trigger.controller		= controllers.missile_trigger

windscreen_wiper				= CreateGauge()
windscreen_wiper.arg_number		= 546
windscreen_wiper.input			= {0.0,1.0}
windscreen_wiper.output			= {0.0,1.0}
windscreen_wiper.controller		= controllers.windscreen_wiper

ambientTemperature				= CreateGauge()
ambientTemperature.arg_number	= 587
ambientTemperature.input		= {-60, 50}
ambientTemperature.output		= {-0.946, 0.788}
ambientTemperature.controller	= controllers.ambientTemperature

mirrors_data = 
{
    center_point 	= {0.370000005,0.497999996,0}, 
    width 			=  1.53, --integrated (keep in mind that mirrors can be none planar )
    aspect 		 	=  3,
	rotation 	 	= -0.536,
	animation_speed =  0,
	flaps = 
	{
		"MIRROR_1",
		"MIRROR_2",	
	}
}

dofile(LockOn_Options.common_script_path.."tools.lua")
livery = find_custom_livery("Ka-50","default")
