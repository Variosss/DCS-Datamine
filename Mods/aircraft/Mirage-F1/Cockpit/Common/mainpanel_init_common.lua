
ambient_light    = {255,255,255}
ambient_color_day_texture    = {72, 100, 160}
ambient_color_night_texture  = {40, 60 ,150}
ambient_color_from_devices   = {50, 50, 40}
ambient_color_from_panels	 = {35, 25, 25}

dusk_border					 = 0.4
draw_pilot					 = false

external_model_canopy_arg	 = 38

use_external_views = false 
cockpit_local_point = {3.225, 0.368, 0.0} -- it is the same as CockpitLocalPoint of the seat index 0 in Views.lua

day_texture_set_value   = 0.0
night_texture_set_value = 0.1

local controllers = LoRegisterPanelControls()

dofile(LockOn_Options.common_script_path.."tools.lua")


mirrors_data = 
{
    width 		 	= 0.8,
    aspect 		 	= 0.9,
	--rotation 	 	= math.rad(-13.5),
	animation_speed = 2.0,
	near_clip 		= 0.001,
	middle_clip		= 10,
	far_clip		= 60000,
	connector 		= "MF1_CPT_MIRROR",
	flaps 			= {"PNT-1", "PNT-2",},
}

mirrors_draw                    = CreateGauge()
mirrors_draw.arg_number    		= 0
mirrors_draw.input   			= {0,1}
mirrors_draw.output   			= {1,0}
mirrors_draw.controller         = controllers.mirrors_draw

--[[
Canopy      = CreateGauge()
Canopy.arg_number = 1
Canopy.input   = {0,1}
Canopy.output  = {0,1}
Canopy.controller = controllers.base_gauge_CanopyPos

StickPitch						= CreateGauge()
StickPitch.arg_number			= 11
StickPitch.input				= {-100, 100}
StickPitch.output				= {-1, 1}
StickPitch.controller			= controllers.base_gauge_StickPitchPosition

StickBank						= CreateGauge()
StickBank.arg_number			= 12
StickBank.input					= {-100, 100}
StickBank.output				= {-1, 1}
StickBank.controller			= controllers.base_gauge_StickRollPosition

RudderPedals					= CreateGauge()
RudderPedals.arg_number			= 25
RudderPedals.input				= {-100,100}
RudderPedals.output				= {-1,1}
RudderPedals.controller			= controllers.base_gauge_RudderPosition

Throttle						= CreateGauge()
Throttle.arg_number				= 155
Throttle.input					= {0, 1}
Throttle.output					= {0, 1}
Throttle.controller				= controllers.base_gauge_ThrottleLeftPosition

Landinggearhandle							= CreateGauge()
Landinggearhandle.arg_number				= 54
Landinggearhandle.input						= {0, 1}
Landinggearhandle.output					= {1, 0}
Landinggearhandle.controller				= controllers.base_gauge_LandingGearHandlePos
--]]

---------------------------------------------------------------
-- ENGINE
---------------------------------------------------------------

--[[
Engine_RPM							= CreateGauge()
Engine_RPM.arg_number				= 511
Engine_RPM.input					= {0.0, 110.0} 
Engine_RPM.output					= {0.0, 1.0}
Engine_RPM.controller				= controllers.base_gauge_EngineLeftRPM


Engine_TEMP							= CreateGauge()
Engine_TEMP.arg_number				= 512
Engine_TEMP.input					= {300, 900} 
Engine_TEMP.output					= {0.0, 1.00}
Engine_TEMP.controller				= controllers.base_gauge_EngineLeftTemperatureBeforeTurbine
]]

---------------------------------------------------------------
-- INSTRUMENTS
---------------------------------------------------------------

--[[
IndicatedAirSpeed							= CreateGauge()
IndicatedAirSpeed.arg_number				= 509
IndicatedAirSpeed.input						= {0.0, 600}  --m/s
IndicatedAirSpeed.output					= {0.0, 1.0}
IndicatedAirSpeed.controller				= controllers.base_gauge_IndicatedAirSpeed
]]

--TEST_PARAM_GAUGE      			  = CreateGauge("parameter")
--TEST_PARAM_GAUGE.parameter_name   = "TEST"
--TEST_PARAM_GAUGE.arg_number    	  = 113
--TEST_PARAM_GAUGE.input    		  = {0,100} 
--TEST_PARAM_GAUGE.output    		  = {0,1} 

draw_arcade					 = LockOn_Options.flight.easy_radar or LockOn_Options.flight.auto_lockon

args_initial_state = {}

if not LockOn_Options.cockpit.mirrors then
   args_initial_state[18] = 1.0
end

Z_test =
{
	near = 0.05,
	far  = 4.0,
}

need_to_be_closed = true -- close lua state after initialization 

--[[ available functions 

 --base_gauge_RadarAltitude
 --base_gauge_BarometricAltitude
 --base_gauge_AngleOfAttack
 --base_gauge_AngleOfSlide
 --base_gauge_VerticalVelocity
 --base_gauge_TrueAirSpeed
 --base_gauge_IndicatedAirSpeed
 --base_gauge_MachNumber
 --base_gauge_VerticalAcceleration --Ny
 --base_gauge_HorizontalAcceleration --Nx
 --base_gauge_LateralAcceleration --Nz
 --base_gauge_RateOfRoll
 --base_gauge_RateOfYaw
 --base_gauge_RateOfPitch
 --base_gauge_Roll
 --base_gauge_MagneticHeading
 --base_gauge_Pitch
 --base_gauge_Heading
 --base_gauge_EngineLeftFuelConsumption
 --base_gauge_EngineRightFuelConsumption
 --base_gauge_EngineLeftTemperatureBeforeTurbine
 --base_gauge_EngineRightTemperatureBeforeTurbine
 --base_gauge_EngineLeftRPM
 --base_gauge_EngineRightRPM
 --base_gauge_WOW_RightMainLandingGear
 --base_gauge_WOW_LeftMainLandingGear
 --base_gauge_WOW_NoseLandingGear
 --base_gauge_RightMainLandingGearDown
 --base_gauge_LeftMainLandingGearDown
 --base_gauge_NoseLandingGearDown
 --base_gauge_RightMainLandingGearUp
 --base_gauge_LeftMainLandingGearUp
 --base_gauge_NoseLandingGearUp
 --base_gauge_LandingGearHandlePos
 --base_gauge_StickRollPosition
 --base_gauge_StickPitchPosition
 --base_gauge_RudderPosition
 --base_gauge_ThrottleLeftPosition
 --base_gauge_ThrottleRightPosition
 --base_gauge_HelicopterCollective
 --base_gauge_HelicopterCorrection
 --base_gauge_CanopyPos
 --base_gauge_CanopyState
 --base_gauge_FlapsRetracted
 --base_gauge_SpeedBrakePos
 --base_gauge_FlapsPos
 --base_gauge_TotalFuelWeight

--]]
