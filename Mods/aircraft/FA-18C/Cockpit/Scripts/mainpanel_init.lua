dofile(LockOn_Options.script_path.."config.lua")
dofile(LockOn_Options.script_path.."VR_config.lua")
dofile(LockOn_Options.script_path.."/../../Views.lua")

shape_name			= "Cockpit_F-18C"

draw_pilot			= false

render_debug_info	= false

local default_view	= SnapViews[1][13]

mirrors_data = 
{
--{x=0.420374006 y=-0.107384428 z=-0.297454894 }
	center_point		= {0.572,0.1098,0},
	width				=  0.82,
	aspect				=  2.5325,
	rotation			= -0.232914032,
	animation_speed		=  2.0,
	arg_value_when_on	=  1.0,
	flaps =
	{
		"pnt_497",
		"pnt_498",
		"pnt_499",
	}
}

local default_view = SnapViews[1][13]
local eye_pos	   = ViewSettings.Cockpit[1].EyePoint[1] or 0;
local default_v_angle      = math.rad(default_view.vAngle)
local default_x    = eye_pos * math.cos(default_v_angle) + default_view.x_trans
local default_y    = eye_pos * math.sin(default_v_angle) + default_view.y_trans
local default_z    = default_view.z_trans

desired_fight_adjustment = 
{
	x	= 0.152   - default_x,
	y	= -0.001   - default_y,
	z	= 0.0295  - default_z,
	v_angle = -4.0 - default_v_angle
}

controllers = LoRegisterPanelControls()
---------------------------------------------------------------
-- CONTROLLERS
---------------------------------------------------------------
local function rad_(value)
	return math.rad(value)
end

-- Draw pilot
pilot_draw                      = CreateGauge()
pilot_draw.arg_number    		= 540
pilot_draw.input				= {0.0, 1.0}
pilot_draw.output				= {0.0, 1.0}
pilot_draw.controller			= controllers.pilot_draw

-- CANOPY -----------------------------------------------------
Canopy				= CreateGauge("external_arg")
Canopy.external_arg	= 38
Canopy.arg_number	= 181
Canopy.input		= {0,1}
Canopy.output		= {0,1}

-- MIRRORS ----------------------------------------------------
function create_mirror(arg_) 
	local _mirrors_draw			= CreateGauge()
	_mirrors_draw.arg_number	= arg_
	_mirrors_draw.input			= {0,1}
	_mirrors_draw.output		= {0,1}
	_mirrors_draw.controller	= controllers.mirrors_draw
	return _mirrors_draw
end
create_mirror(497)
create_mirror(498)
create_mirror(499)

-- CAMERA ADJUSTMENT ------------------------------------------
CameraAdjustment			= CreateGauge()
CameraAdjustment.arg_number	= 503
CameraAdjustment.input		= {0, 1}
CameraAdjustment.output		= {0, 1}
CameraAdjustment.controller	= controllers.CameraAdjustment

-- CONTROLS ---------------------------------------------------
StickPitch				= CreateGauge()
StickPitch.arg_number	= 71
StickPitch.input		= {-1, 	0,		0.137, 	0.5}
StickPitch.output		= {1,	0.12, 	0,		-0.726}
StickPitch.controller	= controllers.StickPitch

StickRoll				= CreateGauge()
StickRoll.arg_number	= 74
StickRoll.input			= {-1, 1}
StickRoll.output		= {-1, 1}
StickRoll.controller	= controllers.StickRoll

Rudder					= CreateGauge()
Rudder.arg_number		= 500
Rudder.input			= {-1, 1}
Rudder.output			= {-1, 1}
Rudder.controller		= controllers.Rudder

LeftWheelBrake				= CreateGauge()
LeftWheelBrake.arg_number	= 501
LeftWheelBrake.input		= {0, 1}
LeftWheelBrake.output		= {0, 1}
LeftWheelBrake.controller	= controllers.LeftWheelBrake

RightWheelBrake				= CreateGauge()
RightWheelBrake.arg_number	= 502
RightWheelBrake.input		= {0, 1}
RightWheelBrake.output		= {0, 1}
RightWheelBrake.controller	= controllers.RightWheelBrake

LeftThrottle				= CreateGauge()
LeftThrottle.arg_number		= 104
LeftThrottle.input			= {0.0, 1.0}
LeftThrottle.output			= {0.0, 1.0}
LeftThrottle.controller		= controllers.LeftThrottle

RightThrottle				= CreateGauge()
RightThrottle.arg_number	= 105
RightThrottle.input			= {0.0, 1.0}
RightThrottle.output		= {0.0, 1.0}
RightThrottle.controller	= controllers.RightThrottle

LeftFingerLift				= CreateGauge()
LeftFingerLift.arg_number	= 495
LeftFingerLift.input		= {0.0, 1.0}
LeftFingerLift.output		= {0.0, 1.0}
LeftFingerLift.params		= {0}
LeftFingerLift.controller	= controllers.FingerLift

RightFingerLift				= CreateGauge()
RightFingerLift.arg_number	= 496
RightFingerLift.input		= {0.0, 1.0}
RightFingerLift.output		= {0.0, 1.0}
RightFingerLift.params		= {1}
RightFingerLift.controller	= controllers.FingerLift

-- Electric Interface
VoltmeterU					= CreateGauge()
VoltmeterU.arg_number		= 400
VoltmeterU.input			= {16.0,	30.0}
VoltmeterU.output			= {0.0,		1.0}
VoltmeterU.controller		= controllers.VoltmeterU

VoltmeterE					= CreateGauge()
VoltmeterE.arg_number		= 401
VoltmeterE.input			= {16.0,	30.0}
VoltmeterE.output			= {0.0,		1.0}
VoltmeterE.controller		= controllers.VoltmeterE

-- Hydraulic Interface
HydIndLeft					= CreateGauge()
HydIndLeft.arg_number		= 310
HydIndLeft.input			= {0.0,	5000.0}
HydIndLeft.output			= {0.0,	1.0}
HydIndLeft.controller		= controllers.HydIndLeft

HydIndRight					= CreateGauge()
HydIndRight.arg_number		= 311
HydIndRight.input			= {0.0,	5000.0}
HydIndRight.output			= {0.0,	1.0}
HydIndRight.controller		= controllers.HydIndRight

HydIndBrake					= CreateGauge()
HydIndBrake.arg_number		= 242
HydIndBrake.input			= {0.0,	1000.0,	2000.0,	3000.0,	4000.0,	5000.0}
HydIndBrake.output			= {0.0,	0.036,	0.338,	0.636,	0.924,	1.0}
HydIndBrake.controller		= controllers.HydIndBrake

-- Gear Interface
EmergGearDownHandle					= CreateGauge()
EmergGearDownHandle.arg_number		= 228
EmergGearDownHandle.input			= {0.0,	1.0}
EmergGearDownHandle.output			= {0.0,	1.0}
EmergGearDownHandle.controller		= controllers.EmergGearDownHandle

EmergParkBrakeHandle				= CreateGauge()
EmergParkBrakeHandle.arg_number		= 240
EmergParkBrakeHandle.input			= {0.0,	1.0}
EmergParkBrakeHandle.output			= {0.0,	1.0}
EmergParkBrakeHandle.controller		= controllers.EmergParkBrakeHandle

-- Instruments --------------------------
-- Standby Pressure Altimeter AAU-52/A
Altimeter_100_footPtr				= CreateGauge()
Altimeter_100_footPtr.arg_number	= 218
Altimeter_100_footPtr.input			= {0.0, 1000.0}
Altimeter_100_footPtr.output		= {0.0, 1.0}
Altimeter_100_footPtr.controller	= controllers.Altimeter100ftPtr

Altimeter_10000_footCount				= CreateGauge()
Altimeter_10000_footCount.arg_number	= 220
Altimeter_10000_footCount.input			= {0.0, 9.0}
Altimeter_10000_footCount.output		= {0.0, 1.0}
Altimeter_10000_footCount.params		= {1}
Altimeter_10000_footCount.controller	= controllers.AltimeterDrumCounter

Altimeter_1000_footCount				= CreateGauge()
Altimeter_1000_footCount.arg_number		= 219
Altimeter_1000_footCount.input			= {-1.0, 0.0, 0.0, 10.0}
Altimeter_1000_footCount.output			= {0.9, 1.0, 0.0, 1.0}
Altimeter_1000_footCount.params			= {0}
Altimeter_1000_footCount.controller		= controllers.AltimeterDrumCounter

pressure_setting_0 = CreateGauge()
pressure_setting_0.arg_number		= 221
pressure_setting_0.input			= {0.0, 10.0}
pressure_setting_0.output			= {0.0, 1.0}
pressure_setting_0.params			= {0}
pressure_setting_0.controller		= controllers.AltimeterPressureDrumCounter

pressure_setting_1 = CreateGauge()
pressure_setting_1.arg_number		= 222
pressure_setting_1.input			= {0.0, 10.0}
pressure_setting_1.output			= {0.0, 1.0}
pressure_setting_1.params			= {1}
pressure_setting_1.controller		= controllers.AltimeterPressureDrumCounter

pressure_setting_2 = CreateGauge()
pressure_setting_2.arg_number		= 223
pressure_setting_2.input			= {26.0, 31.0}
pressure_setting_2.output			= {0.0, 1.0}
pressure_setting_2.params			= {2}
pressure_setting_2.controller		= controllers.AltimeterPressureDrumCounter

-- Indicated Airspeed Indicator AVU-35/A
Airspeed					= CreateGauge()
Airspeed.arg_number			= 217
Airspeed.input				= {0.0,   60.0, 100.0, 150.0, 200.0, 250.0, 300.0, 350.0, 400.0, 450.0, 500.0, 550.0, 600.0, 650.0, 700.0, 750.0, 800.0, 850.0}
Airspeed.output				= {0.0, 0.0445,  0.15, 0.348, 0.586, 0.636, 0.673, 0.715, 0.748, 0.782, 0.819, 0.849, 0.870, 0.898, 0.922, 0.950, 0.976,   1.0}
Airspeed.controller			= controllers.AirSpeedIndicator

-- Vertical Speed Indicator AVU-53/A
Variometer					= CreateGauge()
Variometer.arg_number		= 225
Variometer.input			= {-6000.0, -4000.0, -3000.0, -2000.0, -1000.0, -500.0, 0.0, 500.0, 1000.0, 2000.0, 3000.0, 4000.0, 6000.0} 
Variometer.output			= {   -1.0,   -0.83,   -0.73,  -0.605,   -0.40,  -0.22, 0.0,  0.22,   0.40,  0.605,   0.73,   0.83,    1.0}
Variometer.controller		= controllers.Variometer

-- Clock
CLOCK_currtime_hours				= CreateGauge()
CLOCK_currtime_hours.arg_number		= 278
CLOCK_currtime_hours.input			= {0.0, 12.0}
CLOCK_currtime_hours.output			= {0.0, 1.0}
CLOCK_currtime_hours.params			= {1}
CLOCK_currtime_hours.controller		= controllers.CLOCK_currtime

CLOCK_currtime_minutes				= CreateGauge()
CLOCK_currtime_minutes.arg_number	= 279
CLOCK_currtime_minutes.input		= {0.0, 60.0}
CLOCK_currtime_minutes.output		= {0.0, 1.0}
CLOCK_currtime_minutes.params		= {0}
CLOCK_currtime_minutes.controller	= controllers.CLOCK_currtime

CLOCK_elapsed_time_minutes				= CreateGauge()
CLOCK_elapsed_time_minutes.arg_number	= 281
CLOCK_elapsed_time_minutes.input		= {0.0, 60.0}
CLOCK_elapsed_time_minutes.output		= {0.0, 1.0}
CLOCK_elapsed_time_minutes.params		= {1}
CLOCK_elapsed_time_minutes.controller	= controllers.CLOCK_elapsed_time

CLOCK_elapsed_time_seconds				= CreateGauge()
CLOCK_elapsed_time_seconds.arg_number	= 280
CLOCK_elapsed_time_seconds.input		= {0.0, 60.0}
CLOCK_elapsed_time_seconds.output		= {0.0, 1.0}
CLOCK_elapsed_time_seconds.params		= {0}
CLOCK_elapsed_time_seconds.controller	= controllers.CLOCK_elapsed_time

-- ID-2163/A
Min_Height_Indicator_ID2163A			= CreateGauge()
Min_Height_Indicator_ID2163A.arg_number	= 287
Min_Height_Indicator_ID2163A.input		= {-0.03, 0.0, 0.5, 0.8, 1.0}
Min_Height_Indicator_ID2163A.output		= {0.0, 0.031, 0.525, 0.802, 0.982}
Min_Height_Indicator_ID2163A.controller	= controllers.MinHeightIndicatorID2163A

Altitude_Pointer_ID2163A				= CreateGauge()
Altitude_Pointer_ID2163A.arg_number		= 286
Altitude_Pointer_ID2163A.input			= {-10.0, 0.0, 100.0, 200.0, 300.0, 400.0, 600.0, 800.0, 1000.0, 3000.0, 5000.0, 5100.0}
Altitude_Pointer_ID2163A.output			= {0.0, 0.048, 0.171, 0.296, 0.416, 0.530, 0.616, 0.706, 0.799, 0.886, 0.974, 0.98}
Altitude_Pointer_ID2163A.controller		= controllers.AltitudePointerID2163A

OFF_Flag_ID2163A						= CreateGauge()
OFF_Flag_ID2163A.arg_number				= 288
OFF_Flag_ID2163A.input					= {0.0, 1.0}
OFF_Flag_ID2163A.output					= {0.0, 1.0}
OFF_Flag_ID2163A.controller				= controllers.OffFlagID2163A

Red_Lamp_ID2163A						= CreateGauge()
Red_Lamp_ID2163A.arg_number				= 290
Red_Lamp_ID2163A.input					= {0.0, 1.0}
Red_Lamp_ID2163A.output					= {0.0, 1.0}
Red_Lamp_ID2163A.controller				= controllers.RedLampID2163A

Green_Lamp_ID2163A						= CreateGauge()
Green_Lamp_ID2163A.arg_number			= 289
Green_Lamp_ID2163A.input				= {0.0, 1.0}
Green_Lamp_ID2163A.output				= {0.0, 1.0}
Green_Lamp_ID2163A.controller			= controllers.GreenLampID2163A

-- SAI
SAI_Pitch					= CreateGauge()
SAI_Pitch.arg_number		= 205
SAI_Pitch.input				= {-math.pi / 2.0, math.pi / 2.0}
SAI_Pitch.output			= {-1.0, 1.0}
SAI_Pitch.controller		= controllers.SAI_Pitch

SAI_Bank					= CreateGauge()
SAI_Bank.arg_number			= 206
SAI_Bank.input				= {-math.pi, math.pi}
SAI_Bank.output				= {-1.0, 1.0}
SAI_Bank.controller			= controllers.SAI_Bank

SAI_attitude_warning_flag				= CreateGauge()
SAI_attitude_warning_flag.arg_number	= 209
SAI_attitude_warning_flag.input			= {0.0, 1.0}
SAI_attitude_warning_flag.output		= {0.0, 1.0}
SAI_attitude_warning_flag.controller	= controllers.SAI_Off_flag

SAI_manual_pitch_adjustment				= CreateGauge()
SAI_manual_pitch_adjustment.arg_number	= 210
SAI_manual_pitch_adjustment.input	    = {0.0, 1.0}
SAI_manual_pitch_adjustment.output		= {-1.0, 1.0}
SAI_manual_pitch_adjustment.controller	= controllers.SAI_manual_pitch

SAI_SlipBall								= CreateGauge()
SAI_SlipBall.arg_number						= 207
SAI_SlipBall.input	    					= {-1.0, 1.0}
SAI_SlipBall.output							= {-1.0, 1.0}
SAI_SlipBall.controller						= controllers.SAI_SlipBall

SAI_RateOfTurn								= CreateGauge()
SAI_RateOfTurn.arg_number					= 208
SAI_RateOfTurn.input						= {-4.5, 4.5}
SAI_RateOfTurn.output						= {1.0, -1.0}
SAI_RateOfTurn.controller					= controllers.SAI_RateOfTurn


SAI_vertical_pointer					= CreateGauge()
SAI_vertical_pointer.arg_number			= 211
SAI_vertical_pointer.input				= {-1.0, 1.0}
SAI_vertical_pointer.output				= {-1.0, 1.0}
SAI_vertical_pointer.controller			= controllers.SAI_vertical_pointer

SAI_horisontal_pointer					= CreateGauge()
SAI_horisontal_pointer.arg_number		= 212
SAI_horisontal_pointer.input	    	= {-1.0, 1.0}
SAI_horisontal_pointer.output			= {-1.0, 1.0}
SAI_horisontal_pointer.controller		= controllers.SAI_horisontal_pointer

-- Cockpit Pressure Altimeter
CockpitPressureAltimeter				= CreateGauge()
CockpitPressureAltimeter.arg_number		= 285
CockpitPressureAltimeter.input	    	= {0.0,	5000.0,	10000.0,	15000.0,	20000.0,	25000.0,	30000.0,	35000.0,	40000.0,	45000.0,	50000.0}
CockpitPressureAltimeter.output			= {0.0,	0.117,	0.2245,		0.3225,		0.411,		0.506,		0.609,		0.717,		0.823,		0.914,		1.0}
CockpitPressureAltimeter.controller		= controllers.CockpitPressureAltimeter



-- Lamps
dofile(LockOn_Options.script_path.."MainPanel/lamps.lua")

need_to_be_closed = true -- close lua state after initialization 

dofile(LockOn_Options.common_script_path.."tools.lua")
livery = find_custom_livery("F/A-18C","default")
