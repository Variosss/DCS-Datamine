dofile(LockOn_Options.script_path.."config.lua")
dofile(LockOn_Options.script_path.."VR_config.lua")
dofile(LockOn_Options.script_path.."/../../Views.lua")

shape_name  	 			 = "Cockpit_F-16C"

draw_pilot					 = false

render_debug_info = false

local default_view = SnapViews[1][13]

--external_model_canopy_arg	 	 = 38

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

--
args_initial_state = {}

if get_option_value("difficulty.hideStick", "local") then 
	args_initial_state[796] = 1.0
end

-- disable mirrors 
mirrors_present = false

--
controllers = LoRegisterPanelControls()
---------------------------------------------------------------
-- CONTROLLERS
---------------------------------------------------------------
local function rad_(value)
	return math.rad(value)
end

local function CreateGaugeLocal(arg_, input_, output_, controller_, params_)
	local temp		= CreateGauge()
	temp.arg_number	= arg_
	temp.input		= input_
	temp.output		= output_
	temp.controller	= controller_
	if params_ ~= nil then
		temp.params = params_
	end
	return temp
end

-- Draw pilot
--[[pilot_draw                      = CreateGauge()
pilot_draw.arg_number    		= 775
pilot_draw.input				= {0.0, 1.0}
pilot_draw.output				= {0.0, 1.0}
pilot_draw.controller			= controllers.pilot_draw--]]

-- CANOPY -----------------------------------------------------
Canopy				= CreateGauge("external_arg")
Canopy.external_arg	= 38
Canopy.arg_number	= 7
Canopy.input		= {0,1}
Canopy.output		= {0,1}

-- CONTROLS ---------------------------------------------------
StickPitch			= CreateGaugeLocal(736, {-1, 1}, {1, -1}, controllers.StickPitch)
StickRoll			= CreateGaugeLocal(737, {-1, 1}, {-1, 1}, controllers.StickRoll)
Rudder				= CreateGaugeLocal(780, {-1, 1}, {-0.23, 0.23}, controllers.Rudder)
Throttle			= CreateGaugeLocal(755, {0.0, 0.1, 0.775, 1.0}, {0.0, 0.1, 0.6, 1.0}, controllers.Throttle)
LeftWheelBrake		= CreateGaugeLocal(781, {0, 1}, {0, 1}, controllers.LeftWheelBrake)
RightWheelBrake		= CreateGaugeLocal(782, {0, 1}, {0, 1}, controllers.RightWheelBrake)

-- Gear System
--AlterReleaseRods	= CreateGaugeLocal(97, {0.0, 1.0}, {0.0, 1.0}, controllers.AlterReleaseRods)

-- Cockpit mechanics
--CanopyHandle		= CreateGaugeLocal(712, {0.0, 1.0}, {0.0, 1.0}, controllers.CanopyHandle)
SeatHeight			= CreateGaugeLocal(783, {-1, 1}, {-1, 1}, controllers.SeatHeight)

-- WEAPONS ----------------------------------------------------

-- INSTRUMENTS ------------------------------------------------
-- Angle-of-attack Indicator
AOA					= CreateGaugeLocal(15,
	{-50.0,  -35.0, 0.0, 35.0},
	{ -1.0, -0.807, 0.0, 1.0},
	controllers.AoAIndicator)

-- Altimeter AAU-34/A
Altimeter_100_footPtr		= CreateGaugeLocal(51, {0.0, 1000.0}, {0.0, 1.0}, controllers.AAU34_100ftPtr)
Altimeter_10000_footCount	= CreateGaugeLocal(52, {0.0, 10.0},   {0.0, 1.0}, controllers.AAU34_AltDrum, {2})
Altimeter_1000_footCount	= CreateGaugeLocal(53, {0.0, 10.0},   {0.0, 1.0}, controllers.AAU34_AltDrum, {1})
Altimeter_100_footCount		= CreateGaugeLocal(54, {0.0, 10.0},   {0.0, 1.0}, controllers.AAU34_AltDrum, {0})

pressure_setting_0			= CreateGaugeLocal(59, {0.0, 10.0}, {0.0, 1.0}, controllers.AAU34_PressureDrum, {0})
pressure_setting_1			= CreateGaugeLocal(58, {0.0, 10.0}, {0.0, 1.0}, controllers.AAU34_PressureDrum, {1})
pressure_setting_2			= CreateGaugeLocal(57, {0.0, 10.0}, {0.0, 1.0}, controllers.AAU34_PressureDrum, {2})
pressure_setting_3			= CreateGaugeLocal(56, {0.0, 10.0}, {0.0, 1.0}, controllers.AAU34_PressureDrum, {3})

AAU34_PNEU_flag				= CreateGaugeLocal(61, {0.0, 1.0}, {0.0, 1.0}, controllers.AAU34_PNEU_flag)

-- AirSpeed/Mach Indicator
Airspeed					= CreateGaugeLocal(48,
	{0.0, 80.0,  100.0,	150.0,	170.0,	200.0,	250.0,	300.0,	350.0,	400.0,	450.0,	650.0,	700.0,	750.0,	800.0,	850.0},
	{0.0, 0.042, 0.095,	0.152,	0.182,	0.199,	0.255,	0.303,	0.355,	0.402,	0.455,	0.653,	0.698,	0.750,	0.797,	0.850},
	controllers.AirSpeedIndicator)

MaxAirspeed			= CreateGaugeLocal(47,
	{0.0,  80.0, 100.0, 150.0, 200.0, 250.0, 300.0, 350.0, 400.0, 850.0},
	{0.0, 0.045,   0.1, 0.153,   0.2, 0.256, 0.302, 0.355, 0.402, 0.852},
	controllers.MaxAirspeedIndex)

SetAirspeed				= CreateGaugeLocal(70,
	{0.0,	1.0},
	{0.0,	1.0},
	controllers.SetAirspeedIndex)

MachIndicator			= CreateGaugeLocal(49,
	{0.0,	0.5,	1.0,	1.05,	1.1,	1.2,	1.3,	1.4,	1.5,	1.6,	1.7,	1.8,	1.9,	2.0,	2.1,	2.2,	2.3,	2.4,	2.5},
	{1.0,	0.958,	0.921,	0.902,	0.885,	0.848,	0.812,	0.775,	0.741,	0.704,	0.668,	0.632,	0.596,	0.562,	0.528,	0.493,	0.459,	0.422,	0.387},
	controllers.MachIndicator)

-- Standby Attitude Indicator
SAI_Pitch				= CreateGaugeLocal(63,
	{-rad_(90.0),	-rad_(80.0),	-rad_(70.0),	-rad_(60.0),	-rad_(50.0),	-rad_(40.0),	-rad_(30.0),	-rad_(20.0),	-rad_(10.0),	0.0,	rad_(10.0),	rad_(20.0),	rad_(30.0),	rad_(40.0),	rad_(50.0),	rad_(60.0),	rad_(70.0),	rad_(80.0),	rad_(90.0)},
	{-1.0,			-0.902,			-0.793,			-0.687,			-0.576,			-0.450,			-0.339,			-0.225,			-0.115,			0.0,	0.114,		0.225,		0.336,		0.445,		0.569,		0.679,		0.784,		0.893,		0.995},
	controllers.SAI_Pitch)
SAI_Bank					= CreateGaugeLocal(64, {-math.pi, math.pi}, {1.0, -1.0}, controllers.SAI_Bank)
SAI_Bank_Arrow				= CreateGaugeLocal(72, {-math.pi, math.pi}, {1.0, -1.0}, controllers.SAI_Bank)
SAI_OFF_flag				= CreateGaugeLocal(65, {0.0, 1.0}, {0.0, 1.0}, controllers.SAI_OFF_flag)
SAI_AircraftReferenceSymbol = CreateGaugeLocal(68, {-1.0, 1.0}, {-1.0, 1.0}, controllers.SAI_AircraftReferenceSymbol)
SAI_knob_arrow				= CreateGaugeLocal(69, {-1.0, 1.0}, {-1.0, 1.0}, controllers.SAI_CageKnobArrow)

-- Vertical Velocity Indicator
VVI						= CreateGaugeLocal(16,
	{-10000.0, -6000.0, 0.0, 6000.0},
	{    -1.0,   -0.77, 0.0,    1.0},
	controllers.Variometer)

-- Attitude Director Indicator (ADI)
ADI_Pitch				= CreateGaugeLocal(17, {-math.pi * 0.5, math.pi * 0.5},  {-1.0, 1.0}, controllers.ADI_Pitch)
ADI_Bank				= CreateGaugeLocal(18, {0.0, 2.0 * math.pi}, {-1.0, 1.0}, controllers.ADI_Bank)
ADI_OFF_flag			= CreateGaugeLocal(25, {0.0, 1.0}, {0.0, 1.0}, controllers.ADI_OFF_flag)
ADI_LOC_flag			= CreateGaugeLocal(13, {0.0, 1.0}, {0.0, 1.0}, controllers.ADI_LOC_flag)
ADI_AUX_flag			= CreateGaugeLocal(14, {0.0, 1.0}, {0.0, 1.0}, controllers.ADI_AUX_flag)
ADI_GS_flag				= CreateGaugeLocal(26, {0.0, 1.0}, {0.0, 1.0}, controllers.ADI_GS_flag)
ADI_LOC_Bar				= CreateGaugeLocal(20, {-1.0, 1.0}, {-1.0, 1.0}, controllers.ADI_LOC_Bar)
ADI_GS_Bar				= CreateGaugeLocal(21, {-1.0, 1.0}, {-1.0, 1.0}, controllers.ADI_GS_Bar)
ADI_TurnRate			= CreateGaugeLocal(23, {-3.0, 3.0}, {-1.0, 1.0}, controllers.ADI_TurnRate)
ADI_GS_Pointer			= CreateGaugeLocal(27, {-1.0, 1.0}, {-1.0, 1.0}, controllers.ADI_GS_Pointer)
ADI_Bubble				= CreateGaugeLocal(24, {-1.0, 1.0}, {-1.0, 1.0}, controllers.ADI_Bubble)

-- Trim Indicators
RollTrimInd		= CreateGaugeLocal(561, {-1.0, 0.0, 1.0}, {1.0, 0.0, -1.0}, controllers.RollTrim)
PitchTrimInd	= CreateGaugeLocal(563, {-1.0, 0.0, 1.0}, {-1.0, 0.0, 1.0}, controllers.PitchTrim)

-- Speed brake indicator
SpeedBrake_Indicator	= CreateGaugeLocal(363, {-1.0, 1.0}, {-1.0, 1.0}, controllers.SpeedBrakeInd)

-- Hydraulic Pressure Indicators
SysA_Pressure				= CreateGaugeLocal(615,
	{0.0, 500.0, 1000.0, 2000.0, 3000.0, 3500.0, 4000.0},
	{0.0, 0.170,  0.302,  0.496,  0.694,  0.828,    1.0},
	controllers.SysA_Pressure)
SysB_Pressure				= CreateGaugeLocal(616,
	{0.0, 500.0, 1000.0, 2000.0, 3000.0, 3500.0, 4000.0},
	{0.0, 0.170,  0.302,  0.496,  0.694,  0.828,    1.0},
	controllers.SysB_Pressure)

-- Engine Indicators
-- Oil Pressure
EngineOilPressure = CreateGaugeLocal(93, {0.0, 100.0}, {0.0, 1.0}, controllers.OilPress)
-- Nozzle Position Indicators
EngineNozzlePos = CreateGaugeLocal(94,
	{0.0,  20.0, 40.0,  60.0,  80.0, 100.0, 103.0},
	{0.0, 0.185, 0.36, 0.533, 0.715, 0.894, 1.0},
	controllers.NozPos)
-- Engine Tachometers
EngineTachometer = CreateGaugeLocal(95,
	{0.0,  20.0,  40.0,  60.0,  65.0,  70.0, 80.0,  90.0, 100.0, 110.0},
	{0.0, 0.114, 0.233, 0.346, 0.377, 0.437, 0.57, 0.705, 0.855,   1.0},
	controllers.EngineRpm)
-- FTIT
EngineFTIT = CreateGaugeLocal(96,
	{0.0, 200.0, 700.0, 800.0, 900.0, 1000.0, 1100.0, 1200.0},
	{0.0, 0.026, 0.341, 0.530, 0.708, 0.882,   0.940,    1.0},
	controllers.Ftit)

-- Hydrazin Volume
HydrazinVolume = CreateGaugeLocal(617,
	{0.0,	20.0,	40.0,	60.0,	80.0,	100.0},
	{0.0,	0.258,	0.416,	0.573,	0.731,	1.0},
	controllers.HydrazinVolume)


-- Aux Intake Doors Indicator
--AuxIntakeDoors				= CreateGaugeLocal(111, {0.0, 2.0}, {0.0, 0.2}, controllers.AuxIntakeDoors)

-- Fuel Flow Indicator Counter
FuelFlowCounter_10k					= CreateGaugeLocal(88, {0.0, 10.0}, {0.0, 1.0}, controllers.FuelFlowCounter, {2})
FuelFlowCounter_1k					= CreateGaugeLocal(89, {0.0, 10.0}, {0.0, 1.0}, controllers.FuelFlowCounter, {1})
FuelFlowCounter_100					= CreateGaugeLocal(90, {0.0, 10.0}, {0.0, 1.0}, controllers.FuelFlowCounter, {0})

-- Fuel Quantity Indicator (Dual)
FuelAL				= CreateGaugeLocal(613,
	{0.0,	500.0,	1000.0,	1500.0,	2000.0,	2500.0,	3000.0,	3500.0,	4000.0,	4200.0},
	{0.0,	0.1,	0.2,	0.301,	0.401,	0.502,	0.603,	0.702,	0.801,	0.84},
	controllers.FuelAL)

FuelFR				= CreateGaugeLocal(614,
	{0.0,	500.0,	1000.0,	1500.0,	2000.0,	2500.0,	3000.0,	3500.0,	4000.0,	4200.0},
	{0.0,	0.1,	0.2,	0.301,	0.401,	0.502,	0.603,	0.702,	0.801,	0.84},
	controllers.FuelFR)

FuelTotalizer_10k	= CreateGaugeLocal(730, {0.0, 10.0}, {0.0, 1.0}, controllers.FuelTotalizer, {2})
FuelTotalizer_1k	= CreateGaugeLocal(731, {0.0, 10.0}, {0.0, 1.0}, controllers.FuelTotalizer, {1})
FuelTotalizer_100	= CreateGaugeLocal(732, {0.0, 10.0}, {0.0, 1.0}, controllers.FuelTotalizer, {0})


-- ECS Cabin Pressure Altimeter
CockpitAltitude				= CreateGaugeLocal(618,
	{0.0,	5.0,	10.0,	15.0,	20.0,	25.0,	30.0,	35.0,	40.0,	45.0,	50.0},
	{0.0,	0.094,	0.194,	0.294,	0.394,	0.496,	0.597,	0.698,	0.798,	0.899,	1.0},
	controllers.CockpitAltitude)

-- Oxygen Pressure Indicator
OxygenPressure	= CreateGaugeLocal(729,
	{0.0,	25.0,	50.0,	75.0,	100.0,	125.0,	150.0,	250.0,	350.0,	450.0,	500.0},
	{0.0,	0.107,	0.217,	0.326,	0.435,	0.544,	0.611,	0.717,	0.829,	0.940,	1.0},
	controllers.OxygenPressure)
-- Oxygen Flow Indicator
FlowIndicator	= CreateGaugeLocal(725, {0.0, 1.0}, {0.0, 1.0}, controllers.FlowIndicator)

-- Engine 

-- IFF
IffCodeDrumDigit1			= CreateGaugeLocal(546, {0.0, 1.0}, {0.0, 1.0}, controllers.IffCodeDrumDigit, {0})
IffCodeDrumDigit2			= CreateGaugeLocal(548, {0.0, 1.0}, {0.0, 1.0}, controllers.IffCodeDrumDigit, {1})
IffCodeDrumDigit3			= CreateGaugeLocal(550, {0.0, 1.0}, {0.0, 1.0}, controllers.IffCodeDrumDigit, {2})
IffCodeDrumDigit4			= CreateGaugeLocal(552, {0.0, 1.0}, {0.0, 1.0}, controllers.IffCodeDrumDigit, {3})


-- Clock
CLOCK_currtime_hours		= CreateGaugeLocal(621, {0.0, 12.0}, {0.0, 1.0}, controllers.CLOCK_currtime, {1})
CLOCK_currtime_minutes		= CreateGaugeLocal(622, {0.0, 60.0}, {0.0, 1.0}, controllers.CLOCK_currtime, {0})

CLOCK_elapsed_time_minutes	= CreateGaugeLocal(623, {0.0, 60.0}, {0.0, 1.0}, controllers.CLOCK_elapsed_time, {1})
CLOCK_elapsed_time_seconds	= CreateGaugeLocal(624, {0.0, 60.0}, {0.0, 1.0}, controllers.CLOCK_elapsed_time, {0})

reflections_animation_shift		= CreateGaugeLocal(1000, {-0.25, 0.25}, { 1  , -1}, controllers.head_shift_Z)


-- Lamps
dofile(LockOn_Options.script_path.."MainPanel/lamps.lua")

need_to_be_closed = true -- close lua state after initialization 

dofile(LockOn_Options.common_script_path.."tools.lua")
livery = find_custom_livery("F-16C_50","default")