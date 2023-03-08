dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."VR_config.lua")

shape_name       = "Cockpit_Mi-24P"

draw_pilot					 = false

external_model_canopy_arg	 = 133

mirrors_data = 
{
	center_point 		= {0.612,-0.032, 0.0},
	width        		= 3,
	aspect		 		= 1.9825,
	rotation			= 0.067240274,
	flaps =
	{
		"Point001",
		"Point002",
	}
}

--use_external_views = true

render_target_always    = true


---------------------------------------------------------------
-- CONTROLLERS
---------------------------------------------------------------

controllers 							= LoRegisterPanelControls()

CyclicPitch					= CreateGauge()
CyclicPitch.arg_number		= 2
CyclicPitch.input			= {-0.1525, 0.1525}
CyclicPitch.output			= {1.0 , -1.0}
CyclicPitch.params			= {1}
CyclicPitch.controller		= controllers.flight_controls

CyclicRoll					= CreateGauge()
CyclicRoll.arg_number		= 1
CyclicRoll.input			= {-0.13, 0.13}
CyclicRoll.output			= {1.0 , -1.0}
CyclicRoll.params			= {2}
CyclicRoll.controller		= controllers.flight_controls

Pedals						= CreateGauge()
Pedals.arg_number			= 266
Pedals.input				= {-0.0815, 0.0815}
Pedals.output				= {1.0, -1.0}
Pedals.params				= {3}
Pedals.controller			= controllers.flight_controls

Collective					= CreateGauge()
Collective.arg_number		= 3
Collective.input			= {0 , 1.0}
Collective.output			= {0 , 1.0}
Collective.params			= {4}
Collective.controller		= controllers.flight_controls

Correction					= CreateGauge()
Correction.arg_number		= 746
Correction.input			= {0, 1}
Correction.output			= {1, 0}
Correction.params			= {5}
Correction.controller		= controllers.flight_controls

CyclicPitchOp					= CreateGauge()
CyclicPitchOp.arg_number		= 850
CyclicPitchOp.input			= {-0.1525, 0.1525}
CyclicPitchOp.output			= {1.0 , -1.0}
CyclicPitchOp.params			= {51}
CyclicPitchOp.controller		= controllers.flight_controls

CyclicRollOp					= CreateGauge()
CyclicRollOp.arg_number		= 851
CyclicRollOp.input			= {-0.13, 0.13}
CyclicRollOp.output			= {1.0 , -1.0}
CyclicRollOp.params			= {52}
CyclicRollOp.controller		= controllers.flight_controls

PedalsOp						= CreateGauge()
PedalsOp.arg_number			= 964
PedalsOp.input				= {-0.0815, 0.0815}
PedalsOp.output				= {1.0, -1.0}
PedalsOp.params				= {53}
PedalsOp.controller			= controllers.flight_controls

CollectiveOp					= CreateGauge()
CollectiveOp.arg_number		= 3
CollectiveOp.input			= {0 , 1.0}
CollectiveOp.output			= {0 , 1.0}
CollectiveOp.params			= {54}
CollectiveOp.controller		= controllers.flight_controls

CorrectionOp				= CreateGauge()
CorrectionOp.arg_number		= 860
CorrectionOp.input			= {0, 1}
CorrectionOp.output			= {1, 0}
CorrectionOp.params			= {55}
CorrectionOp.controller		= controllers.flight_controls

StickStowingOp					= CreateGauge()
StickStowingOp.arg_number		= 852
StickStowingOp.input			= {0.0, 1.0}
StickStowingOp.output			= {0.0, 1.0}
StickStowingOp.params			= {61}
StickStowingOp.controller		= controllers.flight_controls

PedalsStowingOp						= CreateGauge()
PedalsStowingOp.arg_number			= 952
PedalsStowingOp.input				= {0.0, 1.0}
PedalsStowingOp.output				= {0.0, 1.0}
PedalsStowingOp.params				= {62}
PedalsStowingOp.controller			= controllers.flight_controls

ThrottleLeft				= CreateGauge()
ThrottleLeft.arg_number		= 5
ThrottleLeft.input			= {0, 1}
ThrottleLeft.output			= {0, 1}
ThrottleLeft.params			= {6}
ThrottleLeft.controller		= controllers.flight_controls

ThrottleRight				= CreateGauge()
ThrottleRight.arg_number	= 4
ThrottleRight.input			= {0, 1}
ThrottleRight.output		= {0, 1}
ThrottleRight.params		= {7}
ThrottleRight.controller	= controllers.flight_controls

TrimButton					= CreateGauge()
TrimButton.arg_number		= 742
TrimButton.input			= {0, 1}
TrimButton.output			= {0, 1}
TrimButton.params			= {70}
TrimButton.controller		= controllers.flight_controls

TrimHat						= CreateGauge()
TrimHat.arg_number			= 739
TrimHat.input				= {0,	2,		4,		8,		10,		12,		16,		18,		20}
TrimHat.output				= {0,	0.3,	0.7,	0.1,	0.2,	0.8,	0.5,	0.4,	0.6}
TrimHat.params				= {71}
TrimHat.controller			= controllers.flight_controls

Variometer              = CreateGauge()
Variometer.arg_number   = 95
Variometer.input		= {-30.0,	-20.0,	-18.0,	-10.0,	-5.0,	0.0,	5.0,	10.0,	18.0,	20.0,	30.0}
Variometer.output		= {-1.0,	-0.778,	-0.711,	-0.445,	-0.215,	0.0,	0.215,	0.445,	0.711,	0.778,	1.0}
Variometer.controller   = controllers.Variometer

GMeter              = CreateGauge()
GMeter.arg_number   = 17
GMeter.input		= {-2.0, 0.0, 1.000, 2.000, 3.000, 4.0}
GMeter.output		= {-1.0, 0.0, 0.296, 0.567, 0.783, 1.0}
GMeter.params		= {1}
GMeter.controller   = controllers.GMeter_controller

G_Meter_Min					= CreateGauge()
G_Meter_Min.arg_number		= 16
G_Meter_Min.input			= {-2.0,0.0, 1.000}
G_Meter_Min.output			= {-1.0,0.0, 0.296}
G_Meter_Min.params			= {2}
G_Meter_Min.controller		= controllers.GMeter_controller

G_Meter_Max					= CreateGauge()
G_Meter_Max.arg_number		= 18
G_Meter_Max.input			= {1.000, 2.000, 3.000, 4.0}
G_Meter_Max.output			= {0.296, 0.567, 0.783, 1.0}
G_Meter_Max.params			= {3}
G_Meter_Max.controller		= controllers.GMeter_controller

IAS_Pilot					= CreateGauge()
IAS_Pilot.arg_number		= 790
IAS_Pilot.input				= {-200.0,	0.0,	50.0,	100.0,	150.0,	200.0,	250.0,	300.0,	350.0,	370.0,	400.0,	450.0}
IAS_Pilot.output			= {-0.243,	0.0,	0.029,	0.111,	0.227,	0.344,	0.462,	0.581,	0.7,	0.748,	0.838,	0.991}
IAS_Pilot.controller		= controllers.IAS_Pilot

IAS_Operator				= CreateGauge()
IAS_Operator.arg_number		= 776
IAS_Operator.input			= {-200.0,	0.0,	50.0,	100.0,	150.0,	200.0,	250.0,	300.0,	350.0,	370.0,	400.0,	450.0}
IAS_Operator.output			= {-0.243,	0.0,	0.029,	0.111,	0.227,	0.344,	0.462,	0.581,	0.7,	0.748,	0.838,	0.991}
IAS_Operator.controller		= controllers.IAS_Operator

---------------------------------------------------
-- UKT-2
ukt2_Pitch										= CreateGauge()
ukt2_Pitch.arg_number							= 949
ukt2_Pitch.input								= {-math.pi / 2.0, math.pi / 2.0}
ukt2_Pitch.output								= {-1.0, 1.0}
ukt2_Pitch.params								= {0}
ukt2_Pitch.controller							= controllers.ukt2

ukt2_Roll										= CreateGauge()
ukt2_Roll.arg_number							= 950
ukt2_Roll.input									= {-math.pi / 2.0, math.pi / 2.0}
ukt2_Roll.output								= {1.0, -1.0}
ukt2_Roll.params								= {1}
ukt2_Roll.controller							= controllers.ukt2

ukt2_failure_flag								= CreateGauge()
ukt2_failure_flag.arg_number					= 948
ukt2_failure_flag.input							= {0.0, 1.0}
ukt2_failure_flag.output						= {0.0, 1.0}
ukt2_failure_flag.params						= {2}
ukt2_failure_flag.controller					= controllers.ukt2

---------------------------------------------------
-- RMI2
rmi2_P_heading								= CreateGauge()
rmi2_P_heading.arg_number					= 25
rmi2_P_heading.input						= {0.0, math.pi * 2.0}
rmi2_P_heading.output						= {1.0, 0.0}
rmi2_P_heading.params						= {0}
rmi2_P_heading.controller					= controllers.rmi2_P

rmi2_P_bearing1								= CreateGauge()
rmi2_P_bearing1.arg_number					= 28
rmi2_P_bearing1.input						= {0.0, math.pi * 2.0}
rmi2_P_bearing1.output						= {0.0, 1.0}
rmi2_P_bearing1.params						= {1}
rmi2_P_bearing1.controller					= controllers.rmi2_P

rmi2_P_bearing2								= CreateGauge()
rmi2_P_bearing2.arg_number					= 27
rmi2_P_bearing2.input						= {0.0, math.pi * 2.0}
rmi2_P_bearing2.output						= {0.0, 1.0}
rmi2_P_bearing2.params						= {2}
rmi2_P_bearing2.controller					= controllers.rmi2_P

rmi2_O_heading								= CreateGauge()
rmi2_O_heading.arg_number					= 841
rmi2_O_heading.input						= {0.0, math.pi * 2.0}
rmi2_O_heading.output						= {1.0, 0.0}
rmi2_O_heading.params						= {0}
rmi2_O_heading.controller					= controllers.rmi2_O

rmi2_O_bearing1								= CreateGauge()
rmi2_O_bearing1.arg_number					= 842
rmi2_O_bearing1.input						= {0.0, math.pi * 2.0}
rmi2_O_bearing1.output						= {0.0, 1.0}
rmi2_O_bearing1.params						= {1}
rmi2_O_bearing1.controller					= controllers.rmi2_O

rmi2_O_bearing2								= CreateGauge()
rmi2_O_bearing2.arg_number					= 840
rmi2_O_bearing2.input						= {0.0, math.pi * 2.0}
rmi2_O_bearing2.output						= {0.0, 1.0}
rmi2_O_bearing2.params						= {2}
rmi2_O_bearing2.controller					= controllers.rmi2_O

---------------------------------------------------
-- Barometric altimeter

VD_10K_100_PILOT					= CreateGauge()
VD_10K_100_PILOT.arg_number			= 19
VD_10K_100_PILOT.params				= {0}
VD_10K_100_PILOT.input				= {0.0, 10000.0}
VD_10K_100_PILOT.output				= {0.0, 1.0}
VD_10K_100_PILOT.controller			= controllers.VD_10K_pilot_controller

VD_10K_10_PILOT						= CreateGauge()
VD_10K_10_PILOT.arg_number			= 20
VD_10K_10_PILOT.params				= {1}
VD_10K_10_PILOT.input				= {0.0, 1000.0}
VD_10K_10_PILOT.output				= {0.0, 1.0}
VD_10K_10_PILOT.controller			= controllers.VD_10K_pilot_controller

VD_10K_100_Ind_PILOT				= CreateGauge()
VD_10K_100_Ind_PILOT.arg_number		= 833
VD_10K_100_Ind_PILOT.params			= {2}
VD_10K_100_Ind_PILOT.input			= {0.0, 10000.0}
VD_10K_100_Ind_PILOT.output			= {0.0, 1.0}
VD_10K_100_Ind_PILOT.controller		= controllers.VD_10K_pilot_controller

VD_10K_Shutter_PILOT				= CreateGauge()
VD_10K_Shutter_PILOT.arg_number		= 916
VD_10K_Shutter_PILOT.params			= {3}
VD_10K_Shutter_PILOT.input			= {830, 1480}
VD_10K_Shutter_PILOT.output			= {0.822, 0.75}
VD_10K_Shutter_PILOT.controller		= controllers.VD_10K_pilot_controller

VD_10K_10_Ind_PILOT					= CreateGauge()
VD_10K_10_Ind_PILOT.arg_number		= 832
VD_10K_10_Ind_PILOT.params			= {4}
VD_10K_10_Ind_PILOT.input			= {0.0, 1000.0}
VD_10K_10_Ind_PILOT.output			= {0.0, 1.0}
VD_10K_10_Ind_PILOT.controller		= controllers.VD_10K_pilot_controller

VD_10K_RESS_PILOT					= CreateGauge()
VD_10K_RESS_PILOT.arg_number		= 21
VD_10K_RESS_PILOT.params			= {5}
VD_10K_RESS_PILOT.input				= {670.0, 790.0}
VD_10K_RESS_PILOT.output			= {0.0, 1.0}
VD_10K_RESS_PILOT.controller		= controllers.VD_10K_pilot_controller

VD_10K_100_OPERATOR					= CreateGauge()
VD_10K_100_OPERATOR.arg_number		= 789
VD_10K_100_OPERATOR.params			= {0}
VD_10K_100_OPERATOR.input			= {0.0, 10000.0}
VD_10K_100_OPERATOR.output			= {0.0, 1.0}
VD_10K_100_OPERATOR.controller		= controllers.VD_10K_operator_controller

VD_10K_10_OPERATOR					= CreateGauge()
VD_10K_10_OPERATOR.arg_number		= 988
VD_10K_10_OPERATOR.params			= {1}
VD_10K_10_OPERATOR.input			= {0.0, 1000.0}
VD_10K_10_OPERATOR.output			= {0.0, 1.0}
VD_10K_10_OPERATOR.controller		= controllers.VD_10K_operator_controller

VD_10K_100_Ind_OPERATOR				= CreateGauge()
VD_10K_100_Ind_OPERATOR.arg_number	= 837
VD_10K_100_Ind_OPERATOR.params		= {2}
VD_10K_100_Ind_OPERATOR.input		= {0.0, 10000.0}
VD_10K_100_Ind_OPERATOR.output		= {0.0, 1.0}
VD_10K_100_Ind_OPERATOR.controller	= controllers.VD_10K_operator_controller

VD_10K_Shutter_OPERATOR				= CreateGauge()
VD_10K_Shutter_OPERATOR.arg_number	= 835
VD_10K_Shutter_OPERATOR.params		= {3}
VD_10K_Shutter_OPERATOR.input		= {830, 1480}
VD_10K_Shutter_OPERATOR.output		= {0.822, 0.75}
VD_10K_Shutter_OPERATOR.controller	= controllers.VD_10K_operator_controller

VD_10K_10_Ind_OPERATOR				= CreateGauge()
VD_10K_10_Ind_OPERATOR.arg_number	= 836
VD_10K_10_Ind_OPERATOR.params		= {4}
VD_10K_10_Ind_OPERATOR.input		= {0.0, 1000.0}
VD_10K_10_Ind_OPERATOR.output		= {0.0, 1.0}
VD_10K_10_Ind_OPERATOR.controller	= controllers.VD_10K_operator_controller

VD_10K_RESS_OPERATOR				= CreateGauge()
VD_10K_RESS_OPERATOR.arg_number		= 834
VD_10K_RESS_OPERATOR.params			= {5}
VD_10K_RESS_OPERATOR.input			= {670.0, 790.0}
VD_10K_RESS_OPERATOR.output			= {0.0, 1.0}
VD_10K_RESS_OPERATOR.controller		= controllers.VD_10K_operator_controller
---------------------------------------------------
-- Rotor RPM

RotorRPM_Pilot					= CreateGauge()
RotorRPM_Pilot.arg_number		= 42
RotorRPM_Pilot.input			= {0.0, 110.0}
RotorRPM_Pilot.output			= {0.0, 1.0}
RotorRPM_Pilot.controller		= controllers.RotorRPM_P

RotorRPM_Operator				= CreateGauge()
RotorRPM_Operator.arg_number	= 845
RotorRPM_Operator.input			= {0.0, 110.0}
RotorRPM_Operator.output		= {0.0, 1.0}
RotorRPM_Operator.controller	= controllers.RotorRPM_O
---------------------------------------------------
-- Rotor Pitch

RotorPitch					= CreateGauge()
RotorPitch.arg_number		= 36
RotorPitch.input			= {1.0, 2.0,  3.0,  4.0,  5.0,  6.0,  7.0,  8.0, 9.0,  10.0, 11.0, 12.0, 13.0, 14.0, 15.0}
RotorPitch.output			= {0.0, 0.07, 0.14, 0.21, 0.29, 0.35, 0.43, 0.5, 0.57, 0.64, 0.71, 0.79, 0.86, 0.93, 1.0}
RotorPitch.controller		= controllers.RotorPitch

---------------------------------------------------
-- Radar altimeter UV 5

UV_5_RALT							= CreateGauge()
UV_5_RALT.arg_number				= 32
UV_5_RALT.params					= {0}
UV_5_RALT.input						= {0,	10,		20,		40,		60,		80, 	100, 	200,	300,	400,	500,	600,	700,	850}
UV_5_RALT.output					= {0.0, 0.0425,	0.0875,	0.18,	0.272,	0.364,	0.456,	0.528,	0.6,	0.67,	0.745,	0.815,	0.885,	1.0}
UV_5_RALT.controller				= controllers.UV_5_controller

--Interfered with electric so I this commented out until the model is developed properly

UV_5_DangerRALT_index				= CreateGauge()
UV_5_DangerRALT_index.arg_number   = 33
UV_5_DangerRALT_index.params		= {1}
--UV_5_DangerRALT_index.input		= {0, 	100, 	200,	300,	400,	500,	600,	700}	--this is now in Devices_specs\RadarAltimeter.lua
--UV_5_DangerRALT_index.output		= {0.0, 0.427,	0.496,	0.565,	0.634,	0.702,	0.768,	0.8333}	--this was really needed
UV_5_DangerRALT_index.input			= {0.0, 1.0}
UV_5_DangerRALT_index.output		= {0.0, 1.0}
UV_5_DangerRALT_index.controller   	= controllers.UV_5_controller

UV_5_DangerRALT_lamp				= CreateGauge()
UV_5_DangerRALT_lamp.arg_number		= 284
UV_5_DangerRALT_lamp.params			= {2}
UV_5_DangerRALT_lamp.input			= {0.0, 1.0}
UV_5_DangerRALT_lamp.output			= {0.0, 1.0}
UV_5_DangerRALT_lamp.controller		= controllers.UV_5_controller

UV_5_warning_flag					= CreateGauge()
UV_5_warning_flag.arg_number		= 1021
UV_5_warning_flag.params			= {3}
UV_5_warning_flag.input				= {0.0, 1.0}
UV_5_warning_flag.output			= {0.0, 1.0}
UV_5_warning_flag.controller		= controllers.UV_5_controller

------------------------------------------------

-- Engines RPM
LeftEngineRPM_Pilot					= CreateGauge()
LeftEngineRPM_Pilot.arg_number		= 40
LeftEngineRPM_Pilot.input			= {0.0, 110.0}
LeftEngineRPM_Pilot.output			= {0.0, 1.0}
LeftEngineRPM_Pilot.controller		= controllers.LeftEngineRPM_P

RightEngineRPM_Pilot				= CreateGauge()
RightEngineRPM_Pilot.arg_number		= 41
RightEngineRPM_Pilot.input			= {0.0, 110.0}
RightEngineRPM_Pilot.output			= {0.0, 1.0}
RightEngineRPM_Pilot.controller		= controllers.RightEngineRPM_P

LeftEngineRPM_Operator				= CreateGauge()
LeftEngineRPM_Operator.arg_number	= 838
LeftEngineRPM_Operator.input		= {0.0, 110.0}
LeftEngineRPM_Operator.output		= {0.0, 1.0}
LeftEngineRPM_Operator.controller	= controllers.LeftEngineRPM_O

RightEngineRPM_Operator				= CreateGauge()
RightEngineRPM_Operator.arg_number	= 839
RightEngineRPM_Operator.input		= {0.0, 110.0}
RightEngineRPM_Operator.output		= {0.0, 1.0}
RightEngineRPM_Operator.controller	= controllers.RightEngineRPM_O

---------------------------------------------------
-- Engines temperature
LeftEngineTemperatureHund				= CreateGauge()
LeftEngineTemperatureHund.arg_number	= 43
LeftEngineTemperatureHund.input			= {0.0, 1200.0}
LeftEngineTemperatureHund.output		= {0.0, 1.0}
LeftEngineTemperatureHund.controller	= controllers.LeftEngineTemperatureHund

LeftEngineTemperatureTenth				= CreateGauge()
LeftEngineTemperatureTenth.arg_number	= 44
LeftEngineTemperatureTenth.input		= {0.0, 100.0}
LeftEngineTemperatureTenth.output		= {0.0, 1.0}
LeftEngineTemperatureTenth.controller	= controllers.LeftEngineTemperatureTenth

RightEngineTemperatureHund				= CreateGauge()
RightEngineTemperatureHund.arg_number	= 45
RightEngineTemperatureHund.input		= {0.0, 1200.0}
RightEngineTemperatureHund.output		= {0.0, 1.0}
RightEngineTemperatureHund.controller	= controllers.RightEngineTemperatureHund

RightEngineTemperatureTenth				= CreateGauge()
RightEngineTemperatureTenth.arg_number	= 46
RightEngineTemperatureTenth.input		= {0.0, 100.0}
RightEngineTemperatureTenth.output		= {0.0, 1.0}
RightEngineTemperatureTenth.controller	= controllers.RightEngineTemperatureTenth

APUTemperature							= CreateGauge()
APUTemperature.arg_number				= 292
APUTemperature.input					= {0.0, 900.0}
APUTemperature.output					= {0.0, 1.0}
APUTemperature.controller				= controllers.APUTemperature

APUPressure								= CreateGauge()
APUPressure.arg_number					= 305
APUPressure.input						= {0.0, 8.0}
APUPressure.output						= {0.0, 1.0}
APUPressure.controller					= controllers.APUPressure

-- Engines mode indicator
EnginesMode					= CreateGauge()
EnginesMode.arg_number		= 39
EnginesMode.input			= {0.0, 1.0}
EnginesMode.output			= {0.0, 1.0}
EnginesMode.controller		= controllers.EnginesMode

LeftEngineMode				= CreateGauge()
LeftEngineMode.arg_number	= 37
LeftEngineMode.input		= {0.0, 1.0}
LeftEngineMode.output		= {0.0, 1.0}
LeftEngineMode.controller	= controllers.LeftEngineMode

RightEngineMode				= CreateGauge()
RightEngineMode.arg_number	= 38
RightEngineMode.input		= {0.0, 1.0}
RightEngineMode.output		= {0.0, 1.0}
RightEngineMode.controller	= controllers.RightEngineMode

AntiIceCurrent								= CreateGauge()
AntiIceCurrent.arg_number					= 118
AntiIceCurrent.input						= {0.0, 20.0, 30.0, 40.0, 50.0}
AntiIceCurrent.output						= {0.0, 0.1625, 0.344, 0.602, 1.0}
AntiIceCurrent.controller					= controllers.AntiIceCurrent



oils_p_main_reductor				= CreateGauge()
oils_p_main_reductor.arg_number		= 181
oils_p_main_reductor.input			= {0.0, 8.0}
oils_p_main_reductor.output			= {0.0, 1.0}
oils_p_main_reductor.controller		= controllers.oils_p_main_reductor

oils_t_main_reductor				= CreateGauge()
oils_t_main_reductor.arg_number		= 180
oils_t_main_reductor.input			= {-60.0, 0.0, 150.0}
oils_t_main_reductor.output			= {-0.25, 0.025, 0.65}
oils_t_main_reductor.controller		= controllers.oils_t_main_reductor

oils_temp_tail_reductor				= CreateGauge()
oils_temp_tail_reductor.arg_number	= 190
oils_temp_tail_reductor.input		= {-50.0, 0.0, 150.0}
oils_temp_tail_reductor.output		= {-0.25, 0.0, 0.75}
oils_temp_tail_reductor.controller	= controllers.oils_temp_tail_reductor

oils_temp_intermediate_reductor				= CreateGauge()
oils_temp_intermediate_reductor.arg_number	= 179
oils_temp_intermediate_reductor.input		= {-50.0, 0.0, 150.0}
oils_temp_intermediate_reductor.output		= {-0.25, 0.036, 0.75}
oils_temp_intermediate_reductor.controller	= controllers.oils_temp_intermediate_reductor


oils_p_gearbox					= CreateGauge()
oils_p_gearbox.arg_number		= 186
oils_p_gearbox.input			= {0.0, 8.0}
oils_p_gearbox.output			= {0.0, 1.0}
oils_p_gearbox.controller		= controllers.oils_p_gearbox

oils_t_gearbox					= CreateGauge()
oils_t_gearbox.arg_number		= 188
oils_t_gearbox.input			= {-60.0, 0.0, 150.0}
oils_t_gearbox.output			= {-0.25, 0.025, 0.65}
oils_t_gearbox.controller		= controllers.oils_t_gearbox

oils_p_left_engine					= CreateGauge()
oils_p_left_engine.arg_number		= 182
oils_p_left_engine.input			= {0.0, 8.0}
oils_p_left_engine.output			= {0.0, 1.0}
oils_p_left_engine.controller		= controllers.oils_p_left_engine

oils_t_left_engine					= CreateGauge()
oils_t_left_engine.arg_number		= 183
oils_t_left_engine.input			= {-50.0, 0.0, 150.0}
oils_t_left_engine.output			= {-0.25, 0.04, 0.75}
oils_t_left_engine.controller		= controllers.oils_t_left_engine

oils_p_right_engine					= CreateGauge()
oils_p_right_engine.arg_number		= 184
oils_p_right_engine.input			= {0.0, 8.0}
oils_p_right_engine.output			= {0.0, 1.0}
oils_p_right_engine.controller		= controllers.oils_p_right_engine

oils_t_right_engine					= CreateGauge()
oils_t_right_engine.arg_number		= 185
oils_t_right_engine.input			= {-50.0, 0.0, 150.0}
oils_t_right_engine.output			= {-0.25, 0.04, 0.75}
oils_t_right_engine.controller		= controllers.oils_t_right_engine



-- Engines mode indicator
--EnginesMode					= CreateGauge()
--EnginesMode.arg_number		= 592
--EnginesMode.input			= {0.0, 1.0}
--EnginesMode.output			= {0.0, 1.0}
--EnginesMode.controller		= controllers.EnginesMode
--
--LeftEngineMode				= CreateGauge()
--LeftEngineMode.arg_number	= 234
--LeftEngineMode.input		= {0.0, 1.0}
--LeftEngineMode.output		= {0.0, 1.0}
--LeftEngineMode.controller	= controllers.LeftEngineMode
--
--RightEngineMode				= CreateGauge()
--RightEngineMode.arg_number	= 235
--RightEngineMode.input		= {0.0, 1.0}
--RightEngineMode.output		= {0.0, 1.0}
--RightEngineMode.controller	= controllers.RightEngineMode


-- Engines breaks
--[[left_engine_break_hangle				= CreateGauge()
left_engine_break_hangle.arg_number		= 554
left_engine_break_hangle.input			= {0.0, 1.0}
left_engine_break_hangle.output			= {0.0, 1.0}
left_engine_break_hangle.controller		= controllers.left_engine_break_hangle

right_engine_break_hangle				= CreateGauge()
right_engine_break_hangle.arg_number	= 555
right_engine_break_hangle.input			= {0.0, 1.0}
right_engine_break_hangle.output		= {0.0, 1.0}
right_engine_break_hangle.controller	= controllers.right_engine_break_hangle
]]
--Hydraulic Pressure Controls
hydraulicMainPressure							= CreateGauge()
hydraulicMainPressure.arg_number				= 23
hydraulicMainPressure.input						= {0.0, 10.0}
hydraulicMainPressure.output					= {0.0, 1.0}
hydraulicMainPressure.params					= {0}
hydraulicMainPressure.controller				= controllers.hydraulic_pressure

hydraulicAuxiliaryPressure						= CreateGauge()
hydraulicAuxiliaryPressure.arg_number			= 24
hydraulicAuxiliaryPressure.input				= {0.0, 10.0}
hydraulicAuxiliaryPressure.output				= {0.0, 1.0}
hydraulicAuxiliaryPressure.params				= {1}
hydraulicAuxiliaryPressure.controller			= controllers.hydraulic_pressure

hydraulicUtilityPressure						= CreateGauge()
hydraulicUtilityPressure.arg_number				= 22
hydraulicUtilityPressure.input					= {0.0, 10.0}
hydraulicUtilityPressure.output					= {0.0, 1.0}
hydraulicUtilityPressure.params					= {2}
hydraulicUtilityPressure.controller				= controllers.hydraulic_pressure

--PKP72M Pilot Controls
PKP72M_P_Pitch									= CreateGauge()
PKP72M_P_Pitch.arg_number						= 939
PKP72M_P_Pitch.input							= {-math.pi / 2.0, math.pi / 2.0} 
PKP72M_P_Pitch.output							= {-1.0, 1.0}
PKP72M_P_Pitch.params							= {0}
PKP72M_P_Pitch.controller						= controllers.PKP72M_P

PKP72M_P_Bank									= CreateGauge()
PKP72M_P_Bank.arg_number						= 942
PKP72M_P_Bank.input								= {-math.pi,	math.pi}
PKP72M_P_Bank.output							= {0.5, 		-0.5}
PKP72M_P_Bank.params							= {1}
PKP72M_P_Bank.controller						= controllers.PKP72M_P

PKP72M_P_Flag									= CreateGauge()
PKP72M_P_Flag.arg_number						= 940
PKP72M_P_Flag.input								= {0.0, 1.0}
PKP72M_P_Flag.output							= {0.0, 1.0}
PKP72M_P_Flag.params							= {2}
PKP72M_P_Flag.controller						= controllers.PKP72M_P

PKP72M_P_Altitude								= CreateGauge()
PKP72M_P_Altitude.arg_number					= 945
PKP72M_P_Altitude.input							= {0.0, 1.0}
PKP72M_P_Altitude.output						= {0.0, 1.0}
PKP72M_P_Altitude.params						= {3}
PKP72M_P_Altitude.controller					= controllers.PKP72M_P

PKP72M_P_AltFlag								= CreateGauge()
PKP72M_P_AltFlag.arg_number						= 936
PKP72M_P_AltFlag.input							= {0.0, 1.0}
PKP72M_P_AltFlag.output							= {0.0, 1.0}
PKP72M_P_AltFlag.params							= {4}
PKP72M_P_AltFlag.controller						= controllers.PKP72M_P

PKP72M_P_SlipBall								= CreateGauge()
PKP72M_P_SlipBall.arg_number					= 943
PKP72M_P_SlipBall.input							= {-1.0, 1.0}
PKP72M_P_SlipBall.output						= {1.0, -1.0}
PKP72M_P_SlipBall.params						= {5}
PKP72M_P_SlipBall.controller					= controllers.PKP72M_P

PKP72M_P_blankerK								= CreateGauge()
PKP72M_P_blankerK.arg_number					= 937
PKP72M_P_blankerK.input							= {0.0, 1.0}
PKP72M_P_blankerK.output						= {0.0, 1.0}
PKP72M_P_blankerK.params						= {6}
PKP72M_P_blankerK.controller					= controllers.PKP72M_P

PKP72M_P_blankerT								= CreateGauge()
PKP72M_P_blankerT.arg_number					= 938
PKP72M_P_blankerT.input							= {0.0, 1.0}
PKP72M_P_blankerT.output						= {0.0, 1.0}
PKP72M_P_blankerT.params						= {7}
PKP72M_P_blankerT.controller					= controllers.PKP72M_P

----PKP72M Operator Controls
PKP72M_O_Pitch									= CreateGauge()
PKP72M_O_Pitch.arg_number						= 780
PKP72M_O_Pitch.input							= {-math.pi / 2.0, math.pi / 2.0} 
PKP72M_O_Pitch.output							= {-1.0, 1.0}
PKP72M_O_Pitch.params							= {0}
PKP72M_O_Pitch.controller						= controllers.PKP72M_O

PKP72M_O_Bank									= CreateGauge()
PKP72M_O_Bank.arg_number						= 783
PKP72M_O_Bank.input								= {-math.pi,	math.pi}
PKP72M_O_Bank.output							= {0.5, 		-0.5}
PKP72M_O_Bank.params							= {1}
PKP72M_O_Bank.controller						= controllers.PKP72M_O

PKP72M_O_Flag									= CreateGauge()
PKP72M_O_Flag.arg_number						= 781
PKP72M_O_Flag.input								= {0.0, 1.0}
PKP72M_O_Flag.output							= {0.0, 1.0}
PKP72M_O_Flag.params							= {2}
PKP72M_O_Flag.controller						= controllers.PKP72M_O

PKP72M_O_Altitude								= CreateGauge()
PKP72M_O_Altitude.arg_number					= 786
PKP72M_O_Altitude.input							= {0.0, 1.0}
PKP72M_O_Altitude.output						= {0.0, 1.0}
PKP72M_O_Altitude.params						= {3}
PKP72M_O_Altitude.controller					= controllers.PKP72M_O
--
PKP72M_O_AltFlag								= CreateGauge()
PKP72M_O_AltFlag.arg_number						= 777
PKP72M_O_AltFlag.input							= {0.0, 1.0}
PKP72M_O_AltFlag.output							= {0.0, 1.0}
PKP72M_O_AltFlag.params							= {4}
PKP72M_O_AltFlag.controller						= controllers.PKP72M_O

PKP72M_O_SlipBall								= CreateGauge()
PKP72M_O_SlipBall.arg_number					= 784
PKP72M_O_SlipBall.input							= {-1.0, 1.0}
PKP72M_O_SlipBall.output						= { 1.0, -1.0}
PKP72M_O_SlipBall.params						= {5}
PKP72M_O_SlipBall.controller					= controllers.PKP72M_O

PKP72M_O_blankerK								= CreateGauge()
PKP72M_O_blankerK.arg_number					= 778
PKP72M_O_blankerK.input							= {0.0, 1.0}
PKP72M_O_blankerK.output						= {0.0, 1.0}
PKP72M_O_blankerK.params						= {6}
PKP72M_O_blankerK.controller					= controllers.PKP72M_O

PKP72M_O_blankerT								= CreateGauge()
PKP72M_O_blankerT.arg_number					= 779
PKP72M_O_blankerT.input							= {0.0, 1.0}
PKP72M_O_blankerT.output						= {0.0, 1.0}
PKP72M_O_blankerT.params						= {7}
PKP72M_O_blankerT.controller					= controllers.PKP72M_O


-- Mechanic clock pilot

CLOCK_P_currtime_hours							= CreateGauge()
CLOCK_P_currtime_hours.arg_number				= 49
CLOCK_P_currtime_hours.input					= {0.0, 12.0}
CLOCK_P_currtime_hours.output					= {0.0, 1.0}
CLOCK_P_currtime_hours.params					= {0}
CLOCK_P_currtime_hours.controller				= controllers.CLOCK_P

CLOCK_P_currtime_minutes						= CreateGauge()
CLOCK_P_currtime_minutes.arg_number				= 50
CLOCK_P_currtime_minutes.input					= {0.0, 60.0}
CLOCK_P_currtime_minutes.output					= {0.0, 1.0}
CLOCK_P_currtime_minutes.params					= {1}
CLOCK_P_currtime_minutes.controller				= controllers.CLOCK_P

CLOCK_P_currtime_seconds						= CreateGauge()
CLOCK_P_currtime_seconds.arg_number				= 51
CLOCK_P_currtime_seconds.input					= {0.0, 60.0}
CLOCK_P_currtime_seconds.output					= {0.0, 1.0}
CLOCK_P_currtime_seconds.params					= {2}
CLOCK_P_currtime_seconds.controller				= controllers.CLOCK_P

CLOCK_P_flight_time_meter_status				= CreateGauge()
CLOCK_P_flight_time_meter_status.arg_number		= 56
CLOCK_P_flight_time_meter_status.input			= {0.0, 0.2}
CLOCK_P_flight_time_meter_status.output			= {0.0, 1.0}
CLOCK_P_flight_time_meter_status.params			= {3}
CLOCK_P_flight_time_meter_status.controller		= controllers.CLOCK_P

CLOCK_P_flight_hours							= CreateGauge()
CLOCK_P_flight_hours.arg_number					= 52
CLOCK_P_flight_hours.input						= {0.0, 12.0}
CLOCK_P_flight_hours.output						= {0.0, 1.0}
CLOCK_P_flight_hours.params						= {4}
CLOCK_P_flight_hours.controller					= controllers.CLOCK_P

CLOCK_P_flight_minutes							= CreateGauge()
CLOCK_P_flight_minutes.arg_number				= 53
CLOCK_P_flight_minutes.input					= {0.0, 60.0}
CLOCK_P_flight_minutes.output					= {0.0, 1.0}
CLOCK_P_flight_minutes.params					= {5}
CLOCK_P_flight_minutes.controller				= controllers.CLOCK_P

CLOCK_P_seconds_meter_time_minutes				= CreateGauge()
CLOCK_P_seconds_meter_time_minutes.arg_number	= 54
CLOCK_P_seconds_meter_time_minutes.input		= {0.0, 60.0}
CLOCK_P_seconds_meter_time_minutes.output		= {0.0, 1.0}
CLOCK_P_seconds_meter_time_minutes.params		= {6}
CLOCK_P_seconds_meter_time_minutes.controller	= controllers.CLOCK_P
	
CLOCK_P_seconds_meter_time_seconds				= CreateGauge()
CLOCK_P_seconds_meter_time_seconds.arg_number	= 55
CLOCK_P_seconds_meter_time_seconds.input		= {0.0, 60.0}
CLOCK_P_seconds_meter_time_seconds.output		= {0.0, 1.0}
CLOCK_P_seconds_meter_time_seconds.params		= {7}
CLOCK_P_seconds_meter_time_seconds.controller	= controllers.CLOCK_P

-- Mechanic clock operator

CLOCK_O_currtime_hours							= CreateGauge()
CLOCK_O_currtime_hours.arg_number				= 695
CLOCK_O_currtime_hours.input					= {0.0, 12.0}
CLOCK_O_currtime_hours.output					= {0.0, 1.0}
CLOCK_O_currtime_hours.params					= {0}
CLOCK_O_currtime_hours.controller				= controllers.CLOCK_O

CLOCK_O_currtime_minutes						= CreateGauge()
CLOCK_O_currtime_minutes.arg_number				= 1027
CLOCK_O_currtime_minutes.input					= {0.0, 60.0}
CLOCK_O_currtime_minutes.output					= {0.0, 1.0}
CLOCK_O_currtime_minutes.params					= {1}
CLOCK_O_currtime_minutes.controller				= controllers.CLOCK_O

CLOCK_O_currtime_seconds						= CreateGauge()
CLOCK_O_currtime_seconds.arg_number				= 690
CLOCK_O_currtime_seconds.input					= {0.0, 60.0}
CLOCK_O_currtime_seconds.output					= {0.0, 1.0}
CLOCK_O_currtime_seconds.params					= {2}
CLOCK_O_currtime_seconds.controller				= controllers.CLOCK_O

CLOCK_O_flight_time_meter_status				= CreateGauge()
CLOCK_O_flight_time_meter_status.arg_number		= 692
CLOCK_O_flight_time_meter_status.input			= {0.0, 0.2}
CLOCK_O_flight_time_meter_status.output			= {0.0, 1.0}
CLOCK_O_flight_time_meter_status.params			= {3}
CLOCK_O_flight_time_meter_status.controller		= controllers.CLOCK_O

CLOCK_O_flight_hours							= CreateGauge()
CLOCK_O_flight_hours.arg_number					= 691
CLOCK_O_flight_hours.input						= {0.0, 12.0}
CLOCK_O_flight_hours.output						= {0.0, 1.0}
CLOCK_O_flight_hours.params						= {4}
CLOCK_O_flight_hours.controller					= controllers.CLOCK_O

CLOCK_O_light_minutes							= CreateGauge()
CLOCK_O_light_minutes.arg_number				= 689
CLOCK_O_light_minutes.input						= {0.0, 60.0}
CLOCK_O_light_minutes.output					= {0.0, 1.0}
CLOCK_O_light_minutes.params					= {5}
CLOCK_O_light_minutes.controller				= controllers.CLOCK_O

CLOCK_O_seconds_meter_time_minutes				= CreateGauge()
CLOCK_O_seconds_meter_time_minutes.arg_number	= 698
CLOCK_O_seconds_meter_time_minutes.input		= {0.0, 60.0}
CLOCK_O_seconds_meter_time_minutes.output		= {0.0, 1.0}
CLOCK_O_seconds_meter_time_minutes.params		= {6}
CLOCK_O_seconds_meter_time_minutes.controller	= controllers.CLOCK_O

CLOCK_O_seconds_meter_time_seconds				= CreateGauge()
CLOCK_O_seconds_meter_time_seconds.arg_number	= 697
CLOCK_O_seconds_meter_time_seconds.input		= {0.0, 60.0}
CLOCK_O_seconds_meter_time_seconds.output		= {0.0, 1.0}
CLOCK_O_seconds_meter_time_seconds.params		= {7}
CLOCK_O_seconds_meter_time_seconds.controller	= controllers.CLOCK_O
---------------------------------------------------

ELEC_Volt_DC				= CreateGauge()
ELEC_Volt_DC.arg_number		= 68
ELEC_Volt_DC.input			= {0.0, 30.0}
ELEC_Volt_DC.output			= {0.0, 1.0}
ELEC_Volt_DC.params			= {1}
ELEC_Volt_DC.controller		= controllers.ELEC_controller

ELEC_Volt_AC				= CreateGauge()
ELEC_Volt_AC.arg_number		= 90
ELEC_Volt_AC.input			= {0.0, 100.0, 150.0, 200.0, 250.0}
ELEC_Volt_AC.output			= {0.0, 0.16, 0.345, 0.605, 1.0}
ELEC_Volt_AC.params			= {2}
ELEC_Volt_AC.controller		= controllers.ELEC_controller

ELEC_Amp_LeftBatt					= CreateGauge()
ELEC_Amp_LeftBatt.arg_number		= 77
ELEC_Amp_LeftBatt.input				= {0.0, 400.0}
ELEC_Amp_LeftBatt.output			= {0.0, 1.0}
ELEC_Amp_LeftBatt.params			= {3}
ELEC_Amp_LeftBatt.controller		= controllers.ELEC_controller

ELEC_Amp_RightBatt					= CreateGauge()
ELEC_Amp_RightBatt.arg_number		= 76
ELEC_Amp_RightBatt.input			= {0.0, 400.0}
ELEC_Amp_RightBatt.output			= {0.0, 1.0}
ELEC_Amp_RightBatt.params			= {4}
ELEC_Amp_RightBatt.controller		= controllers.ELEC_controller

ELEC_Amp_DCGen					= CreateGauge()
ELEC_Amp_DCGen.arg_number		= 67
ELEC_Amp_DCGen.input			= {0.0, 400.0}
ELEC_Amp_DCGen.output			= {0.0, 1.0}
ELEC_Amp_DCGen.params			= {5}
ELEC_Amp_DCGen.controller		= controllers.ELEC_controller

ELEC_Amp_LeftGen				= CreateGauge()
ELEC_Amp_LeftGen.arg_number		= 102
ELEC_Amp_LeftGen.input			= {0.0, 50.0, 100.0, 150.0}
ELEC_Amp_LeftGen.output			= {0.0, 0.07, 0.525, 1.0}
ELEC_Amp_LeftGen.params			= {6}
ELEC_Amp_LeftGen.controller		= controllers.ELEC_controller

ELEC_Amp_RightGen				= CreateGauge()
ELEC_Amp_RightGen.arg_number	= 78
ELEC_Amp_RightGen.input			= {0.0, 50.0, 100.0, 150.0}
ELEC_Amp_RightGen.output		= {0.0, 0.07, 0.525, 1.0}
ELEC_Amp_RightGen.params		= {7}
ELEC_Amp_RightGen.controller	= controllers.ELEC_controller

-------------------------------------------
-- Autopilot

APRudderDrive					= CreateGauge()
APRudderDrive.arg_number			= 238
APRudderDrive.input				= {0.0, 1.0}
APRudderDrive.output				= {0.0, 1.0}
APRudderDrive.params				= {0}
APRudderDrive.controller			= controllers.AutopilotController

APRollDrive						= CreateGauge()
APRollDrive.arg_number			= 244
APRollDrive.input				= {0.0, 1.0}
APRollDrive.output				= {0.0, 1.0}
APRollDrive.params				= {1}
APRollDrive.controller			= controllers.AutopilotController

APPitchDrive						= CreateGauge()
APPitchDrive.arg_number			= 251
APPitchDrive.input				= {0.0, 1.0}
APPitchDrive.output				= {0.0, 1.0}
APPitchDrive.params				= {2}
APPitchDrive.controller			= controllers.AutopilotController

APCollectiveDrive				= CreateGauge()
APCollectiveDrive.arg_number		= 256
APCollectiveDrive.input			= {0.0, 1.0}
APCollectiveDrive.outpu			= {0.0, 1.0}
APCollectiveDrive.params			= {3}
APCollectiveDrive.controller		= controllers.AutopilotController

APCourseHundr				= CreateGauge()
APCourseHundr.arg_number	= 265
APCourseHundr.input			= {0 , 1.0}
APCourseHundr.output		= {0 , 1.0}
APCourseHundr.params		= {4}
APCourseHundr.controller	= controllers.AutopilotController

APCourseTen					= CreateGauge()
APCourseTen.arg_number		= 264
APCourseTen.input			= {0 , 1.0}
APCourseTen.output			= {0 , 1.0}
APCourseTen.params			= {5}
APCourseTen.controller		= controllers.AutopilotController

APCourseOne					= CreateGauge()
APCourseOne.arg_number		= 263
APCourseOne.input			= {0 , 1.0}
APCourseOne.output			= {0 , 1.0}
APCourseOne.params			= {6}
APCourseOne.controller		= controllers.AutopilotController

APYawDelta					= CreateGauge()
APYawDelta.arg_number		= 235
APYawDelta.input			= {0 , 1.0}
APYawDelta.output			= {0 , 1.0}
APYawDelta.params			= {7}
APYawDelta.controller		= controllers.AutopilotController

APRollDelta					= CreateGauge()
APRollDelta.arg_number		= 241
APRollDelta.input			= {0 , 1.0}
APRollDelta.output			= {0 , 1.0}
APRollDelta.params			= {8}
APRollDelta.controller		= controllers.AutopilotController

APPitchDelta				= CreateGauge()
APPitchDelta.arg_number		= 247
APPitchDelta.input			= {0 , 1.0}
APPitchDelta.output			= {0 , 1.0}
APPitchDelta.params			= {9}
APPitchDelta.controller		= controllers.AutopilotController

APYawPushed					= CreateGauge()
APYawPushed.arg_number		= 233
APYawPushed.input			= {0 , 1.0}
APYawPushed.output			= {0 , 1.0}
APYawPushed.params			= {10}
APYawPushed.controller		= controllers.AutopilotController

APRollPushed				= CreateGauge()
APRollPushed.arg_number		= 239
APRollPushed.input			= {0 , 1.0}
APRollPushed.output			= {0 , 1.0}
APRollPushed.params			= {11}
APRollPushed.controller		= controllers.AutopilotController

APPitchPushed				= CreateGauge()
APPitchPushed.arg_number	= 245
APPitchPushed.input			= {0 , 1.0}
APPitchPushed.output		= {0 , 1.0}
APPitchPushed.params		= {12}
APPitchPushed.controller	= controllers.AutopilotController


SPUU_Delta					= CreateGauge()
SPUU_Delta.arg_number		= 271
SPUU_Delta.input			= {-1.0 , 1.0}
SPUU_Delta.output			= {-1.0 , 1.0}
SPUU_Delta.controller		= controllers.SPUU_Controller


FuelMeter					= CreateGauge()
FuelMeter.arg_number		= 525
FuelMeter.input				= {0 , 1.0}
FuelMeter.output			= {0 , 1.0}
FuelMeter.params			= {0}
FuelMeter.controller		= controllers.fuel_meter


ASP17_UP_DOWN					= CreateGauge()
ASP17_UP_DOWN.arg_number		= 555
ASP17_UP_DOWN.input				= {-6.0 , 30.0}
ASP17_UP_DOWN.output			= {1.0 , 0.0}
ASP17_UP_DOWN.controller		= controllers.ASP17_UP_DOWN

ASP17_LEFT_RIGHT				= CreateGauge()
ASP17_LEFT_RIGHT.arg_number		= 565
ASP17_LEFT_RIGHT.input			= {-210.0 , 210.0}
ASP17_LEFT_RIGHT.output			= {0.0 , 1.0}
ASP17_LEFT_RIGHT.controller		= controllers.ASP17_LEFT_RIGHT

ASP17_BASE					= CreateGauge()
ASP17_BASE.arg_number		= 558
ASP17_BASE.input			= {0.0 , 1.0}
ASP17_BASE.output			= {0.0 , 1.0}
ASP17_BASE.controller		= controllers.ASP17_BASE


GrebenNorthClosed					= CreateGauge()
GrebenNorthClosed.arg_number		= 443
GrebenNorthClosed.input				= {0.0 , 1.0}
GrebenNorthClosed.output			= {0.0 , 1.0}
GrebenNorthClosed.params			= {0}
GrebenNorthClosed.controller		= controllers.Greben_Controller

GrebenSouthClosed					= CreateGauge()
GrebenSouthClosed.arg_number		= 447
GrebenSouthClosed.input				= {0.0 , 1.0}
GrebenSouthClosed.output			= {0.0 , 1.0}
GrebenSouthClosed.params			= {1}
GrebenSouthClosed.controller		= controllers.Greben_Controller

GrebenNorthTen						= CreateGauge()
GrebenNorthTen.arg_number			= 442
GrebenNorthTen.input				= {0.0 , 10.0}
GrebenNorthTen.output				= {0.0 , 1.0}
GrebenNorthTen.params				= {2}
GrebenNorthTen.controller			= controllers.Greben_Controller

GrebenNorthOne						= CreateGauge()
GrebenNorthOne.arg_number			= 441
GrebenNorthOne.input				= {0.0 , 10.0}
GrebenNorthOne.output				= {0.0 , 1.0}
GrebenNorthOne.params				= {3}
GrebenNorthOne.controller			= controllers.Greben_Controller

GrebenNorthTenths					= CreateGauge()
GrebenNorthTenths.arg_number		= 440
GrebenNorthTenths.input				= {0.0 , 10.0}
GrebenNorthTenths.output			= {0.0 , 1.0}
GrebenNorthTenths.params			= {4}
GrebenNorthTenths.controller		= controllers.Greben_Controller

GrebenSouthTen						= CreateGauge()
GrebenSouthTen.arg_number			= 446
GrebenSouthTen.input				= {0.0 , 10.0}
GrebenSouthTen.output				= {0.0 , 1.0}
GrebenSouthTen.params				= {5}
GrebenSouthTen.controller			= controllers.Greben_Controller

GrebenSouthOne						= CreateGauge()
GrebenSouthOne.arg_number			= 445
GrebenSouthOne.input				= {0.0 , 10.0}
GrebenSouthOne.output				= {0.0 , 1.0}
GrebenSouthOne.params				= {6}
GrebenSouthOne.controller			= controllers.Greben_Controller

GrebenSouthTenths					= CreateGauge()
GrebenSouthTenths.arg_number		= 444
GrebenSouthTenths.input				= {0.0 , 10.0}
GrebenSouthTenths.output			= {0.0 , 1.0}
GrebenSouthTenths.params			= {7}
GrebenSouthTenths.controller		= controllers.Greben_Controller

KM_2_magnetic_decl					= CreateGauge()
KM_2_magnetic_decl.arg_number		= 646
KM_2_magnetic_decl.input			= {0.0, math.pi * 2.0}
KM_2_magnetic_decl.output			= {0.0, 1.0}
KM_2_magnetic_decl.params			= {0}
KM_2_magnetic_decl.controller		= controllers.KM_2_Controller

KM_2_magnetic_decl_01_plus				= CreateGauge()
KM_2_magnetic_decl_01_plus.arg_number	= 651
KM_2_magnetic_decl_01_plus.input		= {0.0, 10.0}
KM_2_magnetic_decl_01_plus.output		= {0.0, 1.0}
KM_2_magnetic_decl_01_plus.params		= {1}
KM_2_magnetic_decl_01_plus.controller	= controllers.KM_2_Controller

KM_2_magnetic_decl_1_plus				= CreateGauge()
KM_2_magnetic_decl_1_plus.arg_number	= 650
KM_2_magnetic_decl_1_plus.input			= {0.0, 10.0}
KM_2_magnetic_decl_1_plus.output		= {0.0, 1.0}
KM_2_magnetic_decl_1_plus.params		= {2}
KM_2_magnetic_decl_1_plus.controller	= controllers.KM_2_Controller

KM_2_magnetic_decl_10_plus				= CreateGauge()
KM_2_magnetic_decl_10_plus.arg_number	= 649 
KM_2_magnetic_decl_10_plus.input		= {0.0, 10.0}
KM_2_magnetic_decl_10_plus.output		= {0.0, 1.0}
KM_2_magnetic_decl_10_plus.params		= {3}
KM_2_magnetic_decl_10_plus.controller	= controllers.KM_2_Controller

KM_2_magnetic_decl_100_plus				= CreateGauge()
KM_2_magnetic_decl_100_plus.arg_number	= 648 
KM_2_magnetic_decl_100_plus.input		= {0.0, 10.0}
KM_2_magnetic_decl_100_plus.output		= {0.0, 1.0}
KM_2_magnetic_decl_100_plus.params		= {4}
KM_2_magnetic_decl_100_plus.controller	= controllers.KM_2_Controller

KM_2_magnetic_decl_01_minus				= CreateGauge()
KM_2_magnetic_decl_01_minus.arg_number	= 652
KM_2_magnetic_decl_01_minus.input		= {0.0, 10.0}
KM_2_magnetic_decl_01_minus.output		= {0.0, 1.0}
KM_2_magnetic_decl_01_minus.params		= {5}
KM_2_magnetic_decl_01_minus.controller	= controllers.KM_2_Controller

KM_2_magnetic_decl_1_minus				= CreateGauge()
KM_2_magnetic_decl_1_minus.arg_number	= 653
KM_2_magnetic_decl_1_minus.input		= {0.0, 10.0}
KM_2_magnetic_decl_1_minus.output		= {0.0, 1.0}
KM_2_magnetic_decl_1_minus.params		= {6}
KM_2_magnetic_decl_1_minus.controller	= controllers.KM_2_Controller

KM_2_magnetic_decl_10_minus				= CreateGauge()
KM_2_magnetic_decl_10_minus.arg_number	= 654
KM_2_magnetic_decl_10_minus.input		= {0.0, 10.0}
KM_2_magnetic_decl_10_minus.output		= {0.0, 1.0}
KM_2_magnetic_decl_10_minus.params		= {7}
KM_2_magnetic_decl_10_minus.controller	= controllers.KM_2_Controller

KM_2_magnetic_decl_100_minus			= CreateGauge()
KM_2_magnetic_decl_100_minus.arg_number	= 655
KM_2_magnetic_decl_100_minus.input		= {0.0, 10.0}
KM_2_magnetic_decl_100_minus.output		= {0.0, 1.0}
KM_2_magnetic_decl_100_minus.params		= {8}
KM_2_magnetic_decl_100_minus.controller	= controllers.KM_2_Controller

--DISS-15
local w = 25 / 3.6  -- m/s
diss15_hover_x						= CreateGauge()
diss15_hover_x.arg_number			= 830
diss15_hover_x.input				= {-w, 0, 2*w}
diss15_hover_x.output				= {-1.0, 0, 1.0}
diss15_hover_x.params				= {0}
diss15_hover_x.controller			= controllers.DISS_Controller

diss15_hover_y						= CreateGauge()
diss15_hover_y.arg_number			= 828
diss15_hover_y.input				= {-10.0, 10.0}
diss15_hover_y.output				= {-1.0, 1.0}
diss15_hover_y.params				= {1}
diss15_hover_y.controller			= controllers.DISS_Controller

diss15_hover_z						= CreateGauge()
diss15_hover_z.arg_number			= 829
diss15_hover_z.input				= {-w, w}
diss15_hover_z.output				= {-1.0, 1.0}
diss15_hover_z.params				= {2}
diss15_hover_z.controller			= controllers.DISS_Controller

diss15_hover_lamp_off				= CreateGauge()
diss15_hover_lamp_off.arg_number	= 831
diss15_hover_lamp_off.input			= {0.0, 1.0}
diss15_hover_lamp_off.output		= {0.0, 1.0}
diss15_hover_lamp_off.params		= {3}
diss15_hover_lamp_off.controller	= controllers.DISS_Controller

diss15_drift_angle					= CreateGauge()
diss15_drift_angle.arg_number		= 791
diss15_drift_angle.input			= {-math.rad(46.0), math.rad(46.0)}
diss15_drift_angle.output			= {-1.0, 1.0}
diss15_drift_angle.params			= {4}
diss15_drift_angle.controller		= controllers.DISS_Controller

diss15_W_shutter					= CreateGauge()
diss15_W_shutter.arg_number			= 795
diss15_W_shutter.input				= {0.0, 1.0}
diss15_W_shutter.output				= {0.0, 1.0}
diss15_W_shutter.params				= {5}
diss15_W_shutter.controller			= controllers.DISS_Controller

diss15_W_memory_lamp				= CreateGauge()
diss15_W_memory_lamp.arg_number		= 975
diss15_W_memory_lamp.input			= {0.0, 1.0}
diss15_W_memory_lamp.output			= {0.0, 1.0}
diss15_W_memory_lamp.params			= {6}
diss15_W_memory_lamp.controller		= controllers.DISS_Controller

diss15_W_hundreds					= CreateGauge()
diss15_W_hundreds.arg_number		= 792
diss15_W_hundreds.input				= {0.0, 10.0}
diss15_W_hundreds.output			= {0.0, 1.0}
diss15_W_hundreds.params			= {2}
diss15_W_hundreds.controller		= controllers.diss15_W_controller

diss15_W_tens						= CreateGauge()
diss15_W_tens.arg_number			= 793
diss15_W_tens.input					= {0.0, 10.0}
diss15_W_tens.output				= {0.0, 1.0}
diss15_W_tens.params				= {1}
diss15_W_tens.controller			= controllers.diss15_W_controller

diss15_W_ones						= CreateGauge()
diss15_W_ones.arg_number			= 794
diss15_W_ones.input					= {0.0, 10.0}
diss15_W_ones.output				= {0.0, 1.0}
diss15_W_ones.params				= {0}
diss15_W_ones.controller			= controllers.diss15_W_controller

diss15_coord_on_lamp				= CreateGauge()
diss15_coord_on_lamp.arg_number		= 817
diss15_coord_on_lamp.input			= {0.0, 1.0}
diss15_coord_on_lamp.output			= {0.0, 1.0}
diss15_coord_on_lamp.params			= {7}
diss15_coord_on_lamp.controller		= controllers.DISS_Controller

diss15_coord_forward				= CreateGauge()
diss15_coord_forward.arg_number		= 805
diss15_coord_forward.input			= {0.0, 1.0}
diss15_coord_forward.output			= {1.0, 0.0}
diss15_coord_forward.params			= {8, 0}
diss15_coord_forward.controller		= controllers.DISS_Controller

diss15_coord_right					= CreateGauge()
diss15_coord_right.arg_number		= 802
diss15_coord_right.input			= {0.0, 1.0}
diss15_coord_right.output			= {1.0, 0.0}
diss15_coord_right.params			= {8, 1}
diss15_coord_right.controller		= controllers.DISS_Controller

diss15_coord_X_hundreds				= CreateGauge()
diss15_coord_X_hundreds.arg_number	= 806
diss15_coord_X_hundreds.input		= {0.0, 10.0}
diss15_coord_X_hundreds.output		= {0.0, 1.0}
diss15_coord_X_hundreds.params		= {0, 2}
diss15_coord_X_hundreds.controller	= controllers.diss15_coord_XZ_controller

diss15_coord_X_tens					= CreateGauge()
diss15_coord_X_tens.arg_number		= 807
diss15_coord_X_tens.input			= {0.0, 10.0}
diss15_coord_X_tens.output			= {0.0, 1.0}
diss15_coord_X_tens.params			= {0, 1}
diss15_coord_X_tens.controller		= controllers.diss15_coord_XZ_controller

diss15_coord_X_ones					= CreateGauge()
diss15_coord_X_ones.arg_number		= 808
diss15_coord_X_ones.input			= {0.0, 10.0}
diss15_coord_X_ones.output			= {0.0, 1.0}
diss15_coord_X_ones.params			= {0, 0}
diss15_coord_X_ones.controller		= controllers.diss15_coord_XZ_controller

diss15_coord_Z_hundreds				= CreateGauge()
diss15_coord_Z_hundreds.arg_number	= 799
diss15_coord_Z_hundreds.input		= {0.0, 10.0}
diss15_coord_Z_hundreds.output		= {0.0, 1.0}
diss15_coord_Z_hundreds.params		= {1, 2}
diss15_coord_Z_hundreds.controller	= controllers.diss15_coord_XZ_controller

diss15_coord_Z_tens					= CreateGauge()
diss15_coord_Z_tens.arg_number		= 800
diss15_coord_Z_tens.input			= {0.0, 10.0}
diss15_coord_Z_tens.output			= {0.0, 1.0}
diss15_coord_Z_tens.params			= {1, 1}
diss15_coord_Z_tens.controller		= controllers.diss15_coord_XZ_controller

diss15_coord_Z_ones					= CreateGauge()
diss15_coord_Z_ones.arg_number		= 801
diss15_coord_Z_ones.input			= {0.0, 10.0}
diss15_coord_Z_ones.output			= {0.0, 1.0}
diss15_coord_Z_ones.params			= {1, 0}
diss15_coord_Z_ones.controller		= controllers.diss15_coord_XZ_controller

diss15_coord_angle_hundreds				= CreateGauge()
diss15_coord_angle_hundreds.arg_number	= 811
diss15_coord_angle_hundreds.input		= {0.0, 10.0}
diss15_coord_angle_hundreds.output		= {0.0, 1.0}
diss15_coord_angle_hundreds.params		= {3}
diss15_coord_angle_hundreds.controller	= controllers.diss15_coord_map_angle

diss15_coord_angle_tens					= CreateGauge()
diss15_coord_angle_tens.arg_number		= 812
diss15_coord_angle_tens.input			= {0.0, 10.0}
diss15_coord_angle_tens.output			= {0.0, 1.0}
diss15_coord_angle_tens.params			= {2}
diss15_coord_angle_tens.controller		= controllers.diss15_coord_map_angle

diss15_coord_angle_ones					= CreateGauge()
diss15_coord_angle_ones.arg_number		= 813
diss15_coord_angle_ones.input			= {0.0, 10.0}
diss15_coord_angle_ones.output			= {0.0, 1.0}
diss15_coord_angle_ones.params			= {1}
diss15_coord_angle_ones.controller		= controllers.diss15_coord_map_angle

diss15_coord_angle_minutes				= CreateGauge()
diss15_coord_angle_minutes.arg_number	= 814
diss15_coord_angle_minutes.input		= {0.0, 10.0}
diss15_coord_angle_minutes.output		= {0.0, 1.0}
diss15_coord_angle_minutes.params		= {0}
diss15_coord_angle_minutes.controller	= controllers.diss15_coord_map_angle

--[[
diss15_check_control_lamp				= CreateGauge()
diss15_check_control_lamp.arg_number	= 822
diss15_check_control_lamp.input			= {0.0, 1.0}
diss15_check_control_lamp.output		= {0.0, 0.9}
diss15_check_control_lamp.params		= {10}
diss15_check_control_lamp.controller	= controllers.DISS_Controller
]]
diss15_check_work_lamp					= CreateGauge()
diss15_check_work_lamp.arg_number		= 823
diss15_check_work_lamp.input			= {0.0, 1.0}
diss15_check_work_lamp.output			= {0.0, 0.9}
diss15_check_work_lamp.params			= {9}
diss15_check_work_lamp.controller		= controllers.DISS_Controller

diss15_check_failM_lamp					= CreateGauge()
diss15_check_failM_lamp.arg_number		= 824
diss15_check_failM_lamp.input			= {0.0, 1.0}
diss15_check_failM_lamp.output			= {0.0, 0.9}
diss15_check_failM_lamp.params			= {11}
diss15_check_failM_lamp.controller		= controllers.DISS_Controller

diss15_check_failC_lamp					= CreateGauge()
diss15_check_failC_lamp.arg_number		= 825
diss15_check_failC_lamp.input			= {0.0, 1.0}
diss15_check_failC_lamp.output			= {0.0, 0.9}
diss15_check_failC_lamp.params			= {12}
diss15_check_failC_lamp.controller		= controllers.DISS_Controller

map_display_lamp						= CreateGauge()
map_display_lamp.arg_number				= 977
map_display_lamp.input					= {0.0, 1.0}
map_display_lamp.output					= {0.0, 0.9}
map_display_lamp.params					= {0}
map_display_lamp.controller				= controllers.map_display_Controller

map_display_lon							= CreateGauge()
map_display_lon.arg_number				= 986
map_display_lon.input					= {-1.0, 1.0}
map_display_lon.output					= {0.0, 1.0}
map_display_lon.params					= {1}
map_display_lon.controller				= controllers.map_display_Controller

map_display_lat							= CreateGauge()
map_display_lat.arg_number				= 987
map_display_lat.input					= {-1.0, 1.0}
map_display_lat.output					= {0.0, 1.0}
map_display_lat.params					= {2}
map_display_lat.controller				= controllers.map_display_Controller


R_863_chan					= CreateGauge()
R_863_chan.arg_number		= 512
R_863_chan.input			= {0.0, 20.0}
R_863_chan.output			= {0.0, 1.0}
R_863_chan.params			= {0}
R_863_chan.controller		= controllers.R863_Controller

R_863_lamp					= CreateGauge()
R_863_lamp.arg_number		= 508
R_863_lamp.input			= {0.0, 1.0}
R_863_lamp.output			= {0.0, 1.0}
R_863_lamp.params			= {1}
R_863_lamp.controller		= controllers.R863_Controller

Jadro_SearchLamp				= CreateGauge()
Jadro_SearchLamp.arg_number		= 422
Jadro_SearchLamp.input			= {0.0, 1.0}
Jadro_SearchLamp.output			= {0.0, 1.0}
Jadro_SearchLamp.params			= {0}
Jadro_SearchLamp.controller		= controllers.Jadro_Controller

Jadro_CtlLamp					= CreateGauge()
Jadro_CtlLamp.arg_number		= 424
Jadro_CtlLamp.input				= {0.0, 1.0}
Jadro_CtlLamp.output			= {0.0, 1.0}
Jadro_CtlLamp.params			= {1}
Jadro_CtlLamp.controller		= controllers.Jadro_Controller

Jadro_BreakdownLamp					= CreateGauge()
Jadro_BreakdownLamp.arg_number		= 425
Jadro_BreakdownLamp.input			= {0.0, 1.0}
Jadro_BreakdownLamp.output			= {0.0, 1.0}
Jadro_BreakdownLamp.params			= {2}
Jadro_BreakdownLamp.controller		= controllers.Jadro_Controller

Eucalypt_chan					= CreateGauge()
Eucalypt_chan.arg_number		= 338
Eucalypt_chan.input				= {0.0, 10.0}
Eucalypt_chan.output			= {0.0, 1.0}
Eucalypt_chan.params			= {0}
Eucalypt_chan.controller		= controllers.Eucalypt_Controller

Eucalypt_lamp					= CreateGauge()
Eucalypt_lamp.arg_number		= 342
Eucalypt_lamp.input				= {0.0, 1.0}
Eucalypt_lamp.output			= {0.0, 1.0}
Eucalypt_lamp.params			= {1}
Eucalypt_lamp.controller		= controllers.Eucalypt_Controller

R_852_chan					= CreateGauge()
R_852_chan.arg_number		= 519
R_852_chan.input			= {0.0, 10.0}
R_852_chan.output			= {0.0, 1.0}
R_852_chan.controller		= controllers.R852_Controller

pilot_fan_vib1					= CreateGauge()
pilot_fan_vib1.arg_number		= 866
pilot_fan_vib1.input			= {0.0, 1.0}
pilot_fan_vib1.output			= {0.0, 1.0}
pilot_fan_vib1.params			= {0}
pilot_fan_vib1.controller		= controllers.fan_controller

pilot_fan_vib2					= CreateGauge()
pilot_fan_vib2.arg_number		= 867
pilot_fan_vib2.input			= {0.0, 1.0}
pilot_fan_vib2.output			= {0.0, 1.0}
pilot_fan_vib2.params			= {1}
pilot_fan_vib2.controller		= controllers.fan_controller

operator_fan_vib1				= CreateGauge()
operator_fan_vib1.arg_number	= 1022
operator_fan_vib1.input			= {0.0, 1.0}
operator_fan_vib1.output		= {0.0, 1.0}
operator_fan_vib1.params		= {2}
operator_fan_vib1.controller	= controllers.fan_controller

operator_fan_vib2				= CreateGauge()
operator_fan_vib2.arg_number	= 1023
operator_fan_vib2.input			= {0.0, 1.0}
operator_fan_vib2.output		= {0.0, 1.0}
operator_fan_vib2.params		= {3}
operator_fan_vib2.controller	= controllers.fan_controller

IFF_KD_LAMP             = CreateGauge()
IFF_KD_LAMP.arg_number  = 333
IFF_KD_LAMP.input		= {0.0, 1.0}
IFF_KD_LAMP.output		= {0.0, 1.0}
IFF_KD_LAMP.params		= {1}
IFF_KD_LAMP.controller 	= controllers.IFF_controller

IFF_KP_LAMP				= CreateGauge()
IFF_KP_LAMP.arg_number	= 335
IFF_KP_LAMP.input		= {0.0, 1.0}
IFF_KP_LAMP.output		= {0.0, 1.0}
IFF_KP_LAMP.params		= {2}
IFF_KP_LAMP.controller	= controllers.IFF_controller

MC61_Recorder_Lamp		= CreateGauge()
MC61_Recorder_Lamp.arg_number	= 379
MC61_Recorder_Lamp.input		= {0.0, 1.0}
MC61_Recorder_Lamp.output		= {0.0, 1.0}
MC61_Recorder_Lamp.params		= {0}
MC61_Recorder_Lamp.controller	= controllers.RecorderMC61_controller
--[[
MC61_Recorder_PanelLightness				= CreateGauge()
MC61_Recorder_PanelLightness.arg_number		= no argument for lamp brightness !!!
MC61_Recorder_PanelLightness.input			= {0.0, 1.0}
MC61_Recorder_PanelLightness.output			= {1.0, 0.0}
MC61_Recorder_PanelLightness.params			= {1}
MC61_Recorder_PanelLightness.controller		= controllers.RecorderMC61_controller
]]

canopy  			= CreateGauge()
canopy.arg_number	= 849
canopy.input		= {0,1}
canopy.output		= {0,1}
canopy.controller	= controllers.Canopy

pilotDoor  			= CreateGauge()
pilotDoor.arg_number= 9
pilotDoor.input		= {0,1}
pilotDoor.output	= {0,1}
pilotDoor.controller= controllers.PilotDoor

Wiper_Pilot  				= CreateGauge()
Wiper_Pilot.arg_number		= 972
Wiper_Pilot.input			= {0.0,1.0}
Wiper_Pilot.output			= {0.0,1.0}
Wiper_Pilot.controller		= controllers.PilotWiper

Wiper_Operator  			= CreateGauge()
Wiper_Operator.arg_number	= 973
Wiper_Operator.input		= {0.0,1.0}
Wiper_Operator.output		= {0.0,1.0}
Wiper_Operator.controller	= controllers.OperatorWiper


Sight9K113_Azimuth  				= CreateGauge()
Sight9K113_Azimuth.arg_number		= 874
Sight9K113_Azimuth.input			= {-1.0,1.0}
Sight9K113_Azimuth.output			= {-0.44,0.44}
Sight9K113_Azimuth.controller		= controllers.Sight9K113_Azimuth

Sight9K113_Elevation  				= CreateGauge()
Sight9K113_Elevation.arg_number		= 876
Sight9K113_Elevation.input			= {-1.0, 0.0, 1.0}
Sight9K113_Elevation.output			= {-0.75, 0.0, 1.0}
Sight9K113_Elevation.controller		= controllers.Sight9K113_Elevation

mirror_fake  			= CreateGauge()
mirror_fake.arg_number	= 323
mirror_fake.input		= {0,1}
mirror_fake.output		= {0,1}
mirror_fake.controller	= controllers.mirrors_draw

wheelBrakes				= CreateGauge()
wheelBrakes.arg_number	= 737
wheelBrakes.input		= {0.0, 1.0}
wheelBrakes.output		= {0.0, 1.0}
wheelBrakes.controller	= controllers.wheelBrakes

parkingBrake			= CreateGauge()
parkingBrake.arg_number	= 736
parkingBrake.input		= {0.0, 1.0}
parkingBrake.output		= {0.0, 1.0}
parkingBrake.controller	= controllers.parkingBrake


failure_gyro_2_lamp				= CreateGauge()
failure_gyro_2_lamp.arg_number	= 702
failure_gyro_2_lamp.input		= {0.0, 1.0}
failure_gyro_2_lamp.output		= {0.0, 1.0}
failure_gyro_2_lamp.controller	= controllers.failure_gyro_2

RAM_Temp				= CreateGauge()
RAM_Temp.arg_number		= 980
RAM_Temp.input			= {-50.0,  0.000, 70.0}
RAM_Temp.output			= {  0.0,  0.456, 1.0}
RAM_Temp.controller		= controllers.RAM_Temp


USB_1_2A_1_hundreds  				= CreateGauge()
USB_1_2A_1_hundreds.arg_number		= 716
USB_1_2A_1_hundreds.input			= {0.0,19.0}
USB_1_2A_1_hundreds.output			= {0.0,1.0}
USB_1_2A_1_hundreds.controller		= controllers.USB_1_2A_1_hundreds

USB_1_2A_1  						= CreateGauge()
USB_1_2A_1.arg_number				= 717
USB_1_2A_1.input					= {0.0,95.0}
USB_1_2A_1.output					= {0.0,1.0}
USB_1_2A_1.controller				= controllers.USB_1_2A_1

USB_1_2A_2_hundreds  				= CreateGauge()
USB_1_2A_2_hundreds.arg_number		= 720
USB_1_2A_2_hundreds.input			= {0.0,19.0}
USB_1_2A_2_hundreds.output			= {0.0,1.0}
USB_1_2A_2_hundreds.controller		= controllers.USB_1_2A_2_hundreds

USB_1_2A_2  						= CreateGauge()
USB_1_2A_2.arg_number				= 721
USB_1_2A_2.input					= {0.0,95.0}
USB_1_2A_2.output					= {0.0,1.0}
USB_1_2A_2.controller				= controllers.USB_1_2A_2

USB_1_2A_3_hundreds  				= CreateGauge()
USB_1_2A_3_hundreds.arg_number		= 724
USB_1_2A_3_hundreds.input			= {0.0,19.0}
USB_1_2A_3_hundreds.output			= {0.0,1.0}
USB_1_2A_3_hundreds.controller		= controllers.USB_1_2A_3_hundreds

USB_1_2A_3  						= CreateGauge()
USB_1_2A_3.arg_number				= 725
USB_1_2A_3.input					= {0.0,95.0}
USB_1_2A_3.output					= {0.0,1.0}
USB_1_2A_3.controller				= controllers.USB_1_2A_3

USB_1_2A_4_hundreds  				= CreateGauge()
USB_1_2A_4_hundreds.arg_number		= 728
USB_1_2A_4_hundreds.input			= {0.0,19.0}
USB_1_2A_4_hundreds.output			= {0.0,1.0}
USB_1_2A_4_hundreds.controller		= controllers.USB_1_2A_4_hundreds

USB_1_2A_4  						= CreateGauge()
USB_1_2A_4.arg_number				= 729
USB_1_2A_4.input					= {0.0,95.0}
USB_1_2A_4.output					= {0.0,1.0}
USB_1_2A_4.controller				= controllers.USB_1_2A_4

USB_1_2A_5_hundreds  				= CreateGauge()
USB_1_2A_5_hundreds.arg_number		= 732
USB_1_2A_5_hundreds.input			= {0.0,19.0}
USB_1_2A_5_hundreds.output			= {0.0,1.0}
USB_1_2A_5_hundreds.controller		= controllers.USB_1_2A_5_hundreds

USB_1_2A_5  						= CreateGauge()
USB_1_2A_5.arg_number				= 733
USB_1_2A_5.input					= {0.0,95.0}
USB_1_2A_5.output					= {0.0,1.0}
USB_1_2A_5.controller				= controllers.USB_1_2A_5

Aiming_reference_marker						= CreateGauge()
Aiming_reference_marker.arg_number			= 1028
Aiming_reference_marker.input				= {0.0, 1.0}
Aiming_reference_marker.output				= {0.0, 1.0}
Aiming_reference_marker.controller			= controllers.Aiming_marker
-- Lamps
dofile(LockOn_Options.script_path.."lamps.lua")
need_to_be_closed = true -- close lua state after initialization

dofile(LockOn_Options.common_script_path.."tools.lua")
livery = find_custom_livery("Mi-24P","default")
