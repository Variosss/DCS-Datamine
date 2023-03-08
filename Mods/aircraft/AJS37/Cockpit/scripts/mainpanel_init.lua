shape_name   	   = "AJS37cockpit"
is_EDM			   = true
new_model_format   = true
ambient_light    = {255,255,255}
ambient_color_day_texture    = {72, 100, 160}
ambient_color_night_texture  = {40, 60 ,150}
ambient_color_from_devices   = {50, 50, 40}
ambient_color_from_panels	 = {35, 25, 25}

dusk_border					 = 0.4
draw_pilot					 = false

external_model_canopy_arg	 = 38

use_external_views = false

day_texture_set_value   = 0.0
night_texture_set_value = 0.1

local controllers = LoRegisterPanelControls()

mirrors_data = 
{
    center_point 	= {0.264,0.145,0},
	width           =  2.0,
    aspect          =  2.0,
    rotation        = math.rad(0);
    animation_speed = 2.0;
    near_clip       = 0.1;
    middle_clip     = 10;
    far_clip        = 600000;
}

mirrors_draw                    = CreateGauge()
mirrors_draw.arg_number    		= 16
mirrors_draw.input   			= {0,1}
mirrors_draw.output   			= {1,0}
mirrors_draw.controller         = controllers.mirrors_draw

pilot_draw                      = CreateGauge()
pilot_draw.arg_number           = 3333
pilot_draw.input                = {0.0, 1.0}
pilot_draw.output               = {0.0, 1.0}
pilot_draw.controller           = controllers.pilot_draw

-- Canopy      = CreateGauge()
-- Canopy.arg_number = 1
-- Canopy.input   = {0,1}
-- Canopy.output  = {0,1}
-- Canopy.controller = controllers.base_gauge_CanopyPos

-- StickPitch						= CreateGauge("parameter")
-- StickPitch.parameter_name   	= "STICK_PITCH"
-- StickPitch.arg_number			= 2
-- StickPitch.input				= {-100, 100}
-- StickPitch.output				= {-1, 1}

-- StickBank						= CreateGauge("parameter")
-- StickBank.parameter_name   		= "STICK_ROLL"
-- StickBank.arg_number			= 3
-- StickBank.input					= {-100, 100}
-- StickBank.output				= {-1, 1}

-- RudderPedals					= CreateGauge("parameter")
-- RudderPedals.parameter_name   	= "PEDALS"
-- RudderPedals.arg_number			= 4
-- RudderPedals.input				= {-100,100}
-- RudderPedals.output				= {-1,1}

-- Throttle						= CreateGauge("parameter")
-- Throttle.parameter_name   		= "THROTTLE_POS"
-- Throttle.arg_number				= 5
-- Throttle.input					= {0, 1}
-- Throttle.output					= {0, 1}

-- Landinggearhandle							= CreateGauge("parameter")
-- Landinggearhandle.parameter_name   			= "LGHANDLE"
-- Landinggearhandle.input						= {0, 1}
-- Landinggearhandle.output					= {1, 0}

---------------------------------------------------------------
-- ENGINE
---------------------------------------------------------------

-- Engine_RPM_100					= CreateGauge("parameter")
-- Engine_RPM_100.arg_number				= 139
-- Engine_RPM_100.input					= {0.0, 1.1} 
-- Engine_RPM_100.output					= {-1.0, 1.0}
-- Engine_RPM_100.parameter_name			= "RPM_PARAM"

-- Engine_RPM_10					= CreateGauge("cycled")
-- Engine_RPM_10.cycle_value				= 10		
-- Engine_RPM_10.arg_number				= 140
-- Engine_RPM_10.input						= {0.0, 10.0} 
-- Engine_RPM_10.output					= {0.0, 1.0}
-- Engine_RPM_10.controller				= controllers.base_gauge_EngineRightRPM


-- Engine_TEMP							= CreateGauge()
-- Engine_TEMP.arg_number				= 146
-- Engine_TEMP.input					= {100, 800} 
-- Engine_TEMP.output					= {0.0, 1.00}
-- Engine_TEMP.controller				= controllers.base_gauge_EngineRightTemperatureBeforeTurbine

---------------------------------------------------------------
-- INSTRUMENTS Front panel
---------------------------------------------------------------

-- Airspeed indicator--------------
IndicatedAirSpeed							= CreateGauge("parameter")
IndicatedAirSpeed.arg_number				= 100
IndicatedAirSpeed.input						= {0, 55.5,     69.44,  83.3,   111.1,  138.8,  166.6,  194.4,  222.2,  250,    277.78, 333.33, 388.89 }  --m/s
IndicatedAirSpeed.output					= {0, 0.0977,   0.181,   0.258,  0.378,  0.4707, 0.5574, 0.6284, 0.69310,0.7521, 0.8077, 0.9101, 1.0   }
--IndicatedAirSpeed.controller				= controllers.base_gauge_IndicatedAirSpeed
IndicatedAirSpeed.parameter_name			= "FDUFVELIND"

-- --Mach-meter----------<
-- -- Second decimal 	(1.2 _3_)
-- MachMeterDec2					= CreateGauge("parameter")
-- MachMeterDec2.arg_number		= 103
-- MachMeterDec2.input				= {0.0,1.00}
-- MachMeterDec2.output			= {0.0,1.0}
-- MachMeterDec2.parameter_name	= "FDUMACHIND1"

-- -- First decimal 	(1. _2_ 3)
-- MachMeterDec1					= CreateGauge("parameter")
-- MachMeterDec1.arg_number		= 102
-- MachMeterDec1.input				= {0.0,1.00}
-- MachMeterDec1.output			= {0.0,1.0}
-- MachMeterDec1.parameter_name	= "FDUMACHIND2"

-- -- Integer 			(_1_ .23)
-- MachMeterInt					= CreateGauge("parameter")
-- MachMeterInt.arg_number			= 101
-- MachMeterInt.input				= {0.0,1.00}
-- MachMeterInt.output				= {0.0,1.0}
-- MachMeterInt.parameter_name		= "FDUMACHIND3"

-- Accelerometer --------------------------------

-- VerticalAcceleration      					= CreateGauge() -- Vertical accelerometer
-- VerticalAcceleration.arg_number    			= 136
-- VerticalAcceleration.input     				= { -2.0, 9.0}
-- VerticalAcceleration.output     			= {-0.3, 0.8}
-- VerticalAcceleration.controller    			= controllers.base_gauge_VerticalAcceleration -- G accelerometer

-- Main altimeter-----------------------------------

--10000 m needle
Altimeter_10000m_Gauge                = CreateGauge("parameter")
Altimeter_10000m_Gauge.cycle_value    = 10000
Altimeter_10000m_Gauge.arg_number     = 114
Altimeter_10000m_Gauge.input          = {0.0, 10000}
Altimeter_10000m_Gauge.output         = {0.0, 1.0}
--Altimeter_10000m_Gauge.controller     = controllers.base_gauge_BarometricAltitude
Altimeter_10000m_Gauge.parameter_name = "FDUALTIND10KM"

--1000 m needle 
Altimeter_1000m_Gauge                = CreateGauge("parameter")
Altimeter_1000m_Gauge.cycle_value    = 1000
Altimeter_1000m_Gauge.arg_number     = 113
Altimeter_1000m_Gauge.input          = {0.0, 1000}
Altimeter_1000m_Gauge.output         = {0.0, 1.0}
--Altimeter_1000m_Gauge.controller 	 = controllers.base_gauge_BarometricAltitude
Altimeter_1000m_Gauge.parameter_name = "FDUALTIND1KM"

--Altimeter setting 1 hPa
-- AltimeterSetting_000X_Gauge                = CreateGauge("parameter")
-- AltimeterSetting_000X_Gauge.arg_number     = 115
-- AltimeterSetting_000X_Gauge.input          = {0.0, 1.0}
-- AltimeterSetting_000X_Gauge.output         = {0.0, 1.0}
-- AltimeterSetting_000X_Gauge.parameter_name = "ALTIMETERSETTING1"

--Altimeter setting 10 hPa
-- AltimeterSetting_00X0_Gauge                = CreateGauge("parameter")
-- AltimeterSetting_00X0_Gauge.arg_number     = 116
-- AltimeterSetting_00X0_Gauge.input          = {0.0, 1.0}
-- AltimeterSetting_00X0_Gauge.output         = {0.0, 1.0}
-- AltimeterSetting_00X0_Gauge.parameter_name = "ALTIMETERSETTING2"

--Altimeter setting 100 hPa
-- AltimeterSetting_0X00_Gauge                = CreateGauge("parameter")
-- AltimeterSetting_0X00_Gauge.arg_number     = 117
-- AltimeterSetting_0X00_Gauge.input          = {0.0, 1.0}
-- AltimeterSetting_0X00_Gauge.output         = {0.0, 1.0}
-- AltimeterSetting_0X00_Gauge.parameter_name = "ALTIMETERSETTING3"

--Altimeter setting 1000 hPa
-- AltimeterSetting_X000_Gauge                = CreateGauge("parameter")
-- AltimeterSetting_X000_Gauge.arg_number     = 118
-- AltimeterSetting_X000_Gauge.input          = {0.0, 1.0}
-- AltimeterSetting_X000_Gauge.output         = {0.0, 1.0}
-- AltimeterSetting_X000_Gauge.parameter_name = "ALTIMETERSETTING4"

-- ADI------------------------------------------------------------
-- Pitch								= CreateGauge("parameter") -- ADI Pitch
-- Pitch.arg_number					= 105
-- Pitch.input						    = {-math.pi, math.pi}
-- Pitch.output						= {1.0, -1.0} 
-- -- Pitch.controller					= controllers.base_gauge_Pitch
-- Pitch.parameter_name				= "FDUPITCHIND"


-- Heading							 	= CreateGauge("parameter") -- FLI37 Heading
-- Heading.arg_number					= 106
-- Heading.input						= {0.0, math.pi * 2.0}
-- Heading.output						= {1.0, -1.0} 
-- --Heading.controller					= controllers.base_gauge_Heading
-- Heading.parameter_name				= "FDUHEADINGIND"


-- Roll								= CreateGauge("parameter") -- FLI37 Roll
-- Roll.arg_number						= 107
-- Roll.input							= {-math.pi, math.pi}  --Degrees?
-- Roll.output							= {-1.0, 1.0} 
-- -- Roll.controller						= controllers.base_gauge_Roll
-- Roll.parameter_name					= "FDUROLLIND"

-- VerticalSpeed						= CreateGauge("parameter") -- FLI37 VSI
-- VerticalSpeed	.arg_number			= 108
-- VerticalSpeed	.input				= {-5.0, 5.0}  --ms
-- VerticalSpeed	.output				= {-1.0, 1.0} 
-- -- VerticalSpeed	.controller			= controllers.base_gauge_VerticalVelocity
-- VerticalSpeed.parameter_name		= "FDUVVELIND"

-- Rollindex							= CreateGauge("parameter") -- FLI37 Roll
-- Rollindex.arg_number				= 107
-- Rollindex.input						= {-math.pi , math.pi}  --Degrees?
-- Rollindex.output					= {1.0, -1.0} 
--Rollindex.controller				= controllers.base_gauge_Roll
-- Rollindex.parameter_name			= "FDUROLLIND"

-- VerticalILS							= CreateGauge("parameter") -- FLI37 ILS
-- VerticalILS.arg_number				= 109
-- VerticalILS.input						= {-1 , 1}  --Degrees?
-- VerticalILS.output					= {1.0, -1.0} 
--Rollindex.controller				= controllers.base_gauge_Roll
-- VerticalILS.parameter_name			= "FDUADIILSV"

-- VerticalILS							= CreateGauge("parameter") -- FLI37 ILS
-- VerticalILS.arg_number				= 110
-- VerticalILS.input						= {-1 , 1}  --Degrees?
-- VerticalILS.output					= {1.0, -1.0} 
--Rollindex.controller				= controllers.base_gauge_Roll
-- VerticalILS.parameter_name			= "FDUADIILSH"

-- This isn't slip angle, its acceleration :) But in what scale?
-- Slipball							= CreateGauge("parameter")
-- Slipball.arg_number					= 111
-- Slipball.input						= {-math.pi/12, math.pi/12}
-- Slipball.output						= {-1.0, 1.0}
-- -- Slipball.controller					= controllers.base_gauge_AngleOfSlide
-- Slipball.parameter_name				= "INDSIDEACCEL"

-- AoA_indicator      					= CreateGauge()
-- AoA_indicator.arg_number 			= 147
-- AoA_indicator.input  				= {0, math.pi/6}
-- AoA_indicator.output  				= {0,1}
-- AoA_indicator.controller 			= controllers.base_gauge_AngleOfAttack

-- CI Instruments ----------------------------------------

-- CIHeading							 	= CreateGauge("parameter") -- FLI37 Heading
-- CIHeading.arg_number					= 128
-- CIHeading.input						    = {0.0, math.pi * 2.0}
-- CIHeading.output						= {1.0, -1.0} 
--CIHeading.controller					= controllers.base_gauge_Heading
-- CIHeading.parameter_name				= "FDUGYROCOMPASS"

-- CICommandedHeading					 	= CreateGauge("parameter") -- FLI37 Heading
-- CICommandedHeading.arg_number			= 129
-- CICommandedHeading.input				= {-math.pi, math.pi}
-- CICommandedHeading.output				= {1.0, 0.0} 
--CIHeading.controller					= controllers.base_gauge_Heading
-- CICommandedHeading.parameter_name		= "FCCOMMANDEDHEADING"

-- Backup instruments--------------------------------------------

-- MagneticHeading								= CreateGauge("parameter") -- Backup course indicator
-- MagneticHeading.arg_number					= 127
-- MagneticHeading.input						= {0.0, math.pi * 2.0}  --Degrees?
-- MagneticHeading.output						= {1.0, -1.0} 
-- MagneticHeading.controller					= controllers.base_gauge_MagneticHeading
-- MagneticHeading.parameter_name					= "COMPASSHEADING"

IndicatedAirSpeedBackup							= CreateGauge("parameter")
IndicatedAirSpeedBackup.arg_number				= 138
IndicatedAirSpeedBackup.input					= {0, 55.5,    69.44,    83.3,   111.1,  138.8,  166.6,  194.4, 208.33 ,222.2 }  --m/s
IndicatedAirSpeedBackup.output					= {0, 0.001,   0.160300, 0.2948, 0.5022, 0.6566, 0.7889, 0.901199, 0.9562,1.0   }
--IndicatedAirSpeedBackup.controller				= controllers.base_gauge_IndicatedAirSpeed
IndicatedAirSpeedBackup.parameter_name			= "BCKPFVELIND"

BackupAltimeter_10000m_Gauge                = CreateGauge("parameter")
BackupAltimeter_10000m_Gauge.cycle_value         = 10000
BackupAltimeter_10000m_Gauge.arg_number            = 125
BackupAltimeter_10000m_Gauge.input                = {0.0, 10000}
BackupAltimeter_10000m_Gauge.output            = {0.0, 1.0}
--BackupAltimeter_10000m_Gauge.controller  = controllers.base_gauge_BarometricAltitude
BackupAltimeter_10000m_Gauge.parameter_name		= "BCKPALTIND10KM"

BackupAltimeter_1000m_Gauge                = CreateGauge("parameter")
BackupAltimeter_1000m_Gauge.cycle_value         = 1000
BackupAltimeter_1000m_Gauge.arg_number            = 124
BackupAltimeter_1000m_Gauge.input                = {0.0, 1000}
BackupAltimeter_1000m_Gauge.output                = {0.0, 1.0}
--BackupAltimeter_1000m_Gauge.controller  = controllers.base_gauge_BarometricAltitude
BackupAltimeter_1000m_Gauge.parameter_name		= "BCKPALTIND1KM"

--BackupPitch								= CreateGauge("parameter") -- backup Pitch
--BackupPitch.arg_number					= 121
--BackupPitch.input						= {-math.pi, math.pi}
--BackupPitch.output						= {1.0, -1.0} 
--BackupPitch.parameter_name				= "BCKPPITCHIND"

--BackupRoll								   = CreateGauge("parameter") -- Backup Roll
--BackupRoll.arg_number						= 122
--BackupRoll.input							= {-math.pi, math.pi}  --Degrees?
--BackupRoll.output							= {1.0, -1.0} 
--BackupRoll.parameter_name					= "BCKPROLLIND"

--Distance indicator---
-- DistanceGauge					    = CreateGauge("parameter")
-- DistanceGauge.parameter_name   		= "FCDISTANCETOWP"
-- DistanceGauge.arg_number			= 142
-- DistanceGauge.input					= {0.0, 40.0} 
-- DistanceGauge.output				= {0.0, 1.0}

--Fuel Gauge-----------

-- FuelGauge					       	= CreateGauge("parameter")
-- FuelGauge.parameter_name   			= "INDICATED_FUEL"
-- FuelGauge.arg_number				= 144
-- FuelGauge.input					    = {0.0, 135.0} 
-- FuelGauge.output					= {0.0, 1.0}

-- FuelNeeded					       	= CreateGauge("parameter")
-- FuelNeeded.parameter_name   		= "INDICATED_FUEL_NEEDED"
-- FuelNeeded.arg_number				= 145
-- FuelNeeded.input					= {0.0, 135.0} 
-- FuelNeeded.output					= {0.0, 1.0}


--SA06 functionality lamps--

-- SPAKLamp					       	= CreateGauge("parameter")
-- SPAKLamp.parameter_name   			= "SPAK_ON"
-- SPAKLamp.arg_number					= 401
-- SPAKLamp.input					    = {0.0, 1.0} 
-- SPAKLamp.output						= {0.0, 1.0}

-- ATTLamp					       	= CreateGauge("parameter")
-- ATTLamp.parameter_name   			= "ATT_ON"
-- ATTLamp.arg_number					= 402
-- ATTLamp.input					    = {0.0, 1.0} 
-- ATTLamp.output						= {0.0, 1.0}

-- HOJDLamp					       	= CreateGauge("parameter")
-- HOJDLamp.parameter_name   			= "HOJD_ON"
-- HOJDLamp.arg_number					= 403
-- HOJDLamp.input					    = {0.0, 1.0} 
-- HOJDLamp.output						= {0.0, 1.0}




-- TEST_PARAM_GAUGE      			  = CreateGauge("parameter")
-- TEST_PARAM_GAUGE.parameter_name   = "TEST"
-- TEST_PARAM_GAUGE.arg_number    	  = 300
-- TEST_PARAM_GAUGE.input    		  = {0,100} 
-- TEST_PARAM_GAUGE.output    		  = {0,1} 

need_to_be_closed = true -- close lua state after initialization 


Z_test =
{
	near = 0.05,
	far  = 4.0,
}
	
	seat_points = 
{
[1] = {point = {-0.13,  0.02,  0.0}},
}

-- for customized cockpit
dofile(LockOn_Options.common_script_path.."tools.lua")
livery = find_custom_livery("AJS37","default")

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
