--dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."config.lua")
dofile(LockOn_Options.script_path.."VR_config.lua")
shape_name   = shape

shift            = {0, 0, 0}
rotation         = math.rad(0.0)

draw_pilot					 = true

args_initial_state = {}
local default_view_ = {--default view
		viewAngle = 89.777542,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	}

local eye_pos_	   = {0.090000,0.000000,0.000000}
local default_v_angle_      =  math.rad(-15.5927584723690)
local default_x_    = 0--eye_pos_ * math.cos(-15.5927584723690) --+ default_view_.x_trans
local default_y_    = 0--eye_pos_ * math.sin(-15.5927584723690) --+ default_view_.y_trans
local default_z_    = 0--default_view_.z_trans

desired_fight_adjustment = 
{
	x	= 0.1   - default_x_,
	y	= 0.15  - default_y_,
	z	= 1.4  - default_z_,
	v_angle = 40.0 - default_v_angle_,
	h_angle = 90.0 
}

external_model_canopy_arg	 = 38

cockpit_local_point = {2.34, 0.37 , 0.0}

render_target_always    = true

-- main panel shaking
shake_filter_Y_Left_ = {IsHPF = false, B = 1/6.0, C = 1.0, Freq0 = 7.7, K = 0.02}
shake_filter_Y_Right_ = {IsHPF = false, B = 1/6.2, C = 1.0, Freq0 = 8.0, K = 0.023}
shake_filter_Z_ = {IsHPF = false, B = 1/4.0, C = 1.0, Freq0 = 7.5, K = 0.02}
		
rot_x_k = 1.0
cross_accel = 0.5

shaking_dt 			= 0.01

mirrors_present 	= false

---------------------------------------------------------------
-- CONTROLLERS
---------------------------------------------------------------

controllers = LoRegisterPanelControls()
-----------------------------------------------------------------
rudder              = CreateGauge()
rudder.arg_number   = 184
rudder.input		= {-0.1, 0.1}
rudder.output		= { -1.0, 1.0}
rudder.controller   = controllers.rudder_position

rudder_add          	= CreateGauge()
rudder_add.arg_number   = 185
rudder_add.input		= {-0.1, 0.1}
rudder_add.output		= {-1.0, 1.0}
rudder_add.controller   = controllers.rudder_position

stick_roll              = CreateGauge()
stick_roll.arg_number   = 187
stick_roll.input		= {-0.16, 0.16}
stick_roll.output		= {1.0, -1.0}
stick_roll.controller   = controllers.stick_roll

stick_pitch             = CreateGauge()
stick_pitch.arg_number  = 186
stick_pitch.input		= {-0.16, 0.16}
stick_pitch.output		= {1.0, -1.0}
stick_pitch.controller  = controllers.stick_pitch

stick_roll_sec              = CreateGauge()
stick_roll_sec.arg_number   = 191
stick_roll_sec.input		= {-0.16, 0.16}
stick_roll_sec.output		= {1.0, -1.0}
stick_roll_sec.controller   = controllers.stick_roll

stick_pitch_sec             = CreateGauge()
stick_pitch_sec.arg_number  = 190
stick_pitch_sec.input		= {-0.16, 0.16}
stick_pitch_sec.output		= {1.0, -1.0}
stick_pitch_sec.controller  = controllers.stick_pitch

collective_position					= CreateGauge()
collective_position.arg_number		= 200
collective_position.input			= {0, 1}
collective_position.output			= {0, 1}
collective_position.controller		= controllers.collective_position

collective_position_operator				= CreateGauge()
collective_position_operator.arg_number		= 207
collective_position_operator.input			= {0, 1}
collective_position_operator.output			= {0, 1}
collective_position_operator.controller		= controllers.collective_position


AIRSPEED_Nose					= CreateGauge()
AIRSPEED_Nose.arg_number		= 117
AIRSPEED_Nose.input				= {0.0, 20.0, 30.0, 40.0, 50.0, 60.0, 80.0, 120.0, 150.0}
AIRSPEED_Nose.output			= {0.0, 0.075, 0.19, 0.32, 0.395, 0.44, 0.55, 0.825, 1.0}
AIRSPEED_Nose.controller		= controllers.IAS_Front

AIRSPEED_Roof					= CreateGauge()
AIRSPEED_Roof.arg_number		= 118
AIRSPEED_Roof.input				= {0.0, 20.0, 30.0, 40.0, 50.0, 60.0, 80.0, 120.0, 150.0}
AIRSPEED_Roof.output			= {0.0, 0.075, 0.19, 0.32, 0.395, 0.44, 0.55, 0.825, 1.0}
AIRSPEED_Roof.controller		= controllers.IAS_Roof

--============================UH1-H==================

----Course Indicator ID-1347
VerticalBar					= CreateGauge()
VerticalBar.arg_number		= 151
VerticalBar.input			= {-1.0, 1.0}
VerticalBar.output			= {-0.7, 0.7}
VerticalBar.controller		= controllers.CourseInd_VerticalBar

HorisontalBar				= CreateGauge()
HorisontalBar.arg_number	= 152
HorisontalBar.input			= {-1.0, 1.0}
HorisontalBar.output		= {-0.7, 0.7}
HorisontalBar.controller	= controllers.CourseInd_HorisontalBar

ToMarker					= CreateGauge()
ToMarker.arg_number			= 153
ToMarker.input				= {0.0, 1.0}
ToMarker.output				= {0.0, 1.0}
ToMarker.controller			= controllers.CourseInd_ToMarker

FromMarker					= CreateGauge()
FromMarker.arg_number		= 154
FromMarker.input			= {0.0, 1.0}
FromMarker.output			= {0.0, 1.0}
FromMarker.controller		= controllers.CourseInd_FromMarker

RotCourseCard				= CreateGauge()
RotCourseCard.arg_number	= 156
RotCourseCard.input			= {0.0, math.pi * 2.0}
RotCourseCard.output		= {0.0, 1}
RotCourseCard.controller	= controllers.CourseInd_CourseCard

VerticalOFF					= CreateGauge()
VerticalOFF.arg_number		= 157
VerticalOFF.input			= {0.0, 1.0}
VerticalOFF.output			= {0.0, 1.0}
VerticalOFF.controller		= controllers.CourseInd_VOR_LOC_warning_flag

HorisontalOFF				= CreateGauge()
HorisontalOFF.arg_number	= 158
HorisontalOFF.input			= {0.0, 1.0}
HorisontalOFF.output		= {0.0, 1.0}
HorisontalOFF.controller	= controllers.CourseInd_GS_warning_flag
------------

ADF_ARN83_Frequency				= CreateGauge()
ADF_ARN83_Frequency.arg_number	= 45
ADF_ARN83_Frequency.input		= {0.0, 1.0}
ADF_ARN83_Frequency.output		= {0.0, 0.55}
ADF_ARN83_Frequency.controller	= controllers.ADF_ARN83_Frequency

ARN83_SignalLevel				= CreateGauge()
ARN83_SignalLevel.arg_number	= 40
ARN83_SignalLevel.input			= {0.0,1.0}
ARN83_SignalLevel.output		= {0.0,1.0}
ARN83_SignalLevel.controller	= controllers.ARN83_SignalLevel

------------GMC---
GMC_CoursePointer1				= CreateGauge()
GMC_CoursePointer1.arg_number	= 159
GMC_CoursePointer1.input		= {0.0, math.pi * 2.0}
GMC_CoursePointer1.output		= {0.0, 1.0}
GMC_CoursePointer1.controller	= controllers.GMC_CoursePointer1

GMC_CoursePointer2				= CreateGauge()
GMC_CoursePointer2.arg_number	= 160
GMC_CoursePointer2.input		= {0.0, math.pi * 2.0}
GMC_CoursePointer2.output		= {0.0, 1.0}
GMC_CoursePointer2.controller	= controllers.GMC_CoursePointer2

GMC_HeadingMarker			= CreateGauge()
GMC_HeadingMarker.arg_number= 162
GMC_HeadingMarker.input		= {0.0, math.pi * 2.0}
GMC_HeadingMarker.output	= {0.0, 1.0}
GMC_HeadingMarker.controller= controllers.GMC_HeadingMarker

GMC_Heading					= CreateGauge()
GMC_Heading.arg_number		= 165
GMC_Heading.input			= {0.0, math.pi * 2.0}
GMC_Heading.output			= {0.0, 1.0}
GMC_Heading.controller		= controllers.GMC_Heading

GMC_Annunciator				= CreateGauge()
GMC_Annunciator.arg_number	= 166
GMC_Annunciator.input		= {-1.0, 1.0}
GMC_Annunciator.output		= {0.0, 1.0}
GMC_Annunciator.controller	= controllers.GMC_Annunciator

GMC_PowerFail				= CreateGauge()
GMC_PowerFail.arg_number	= 167
GMC_PowerFail.input			= {0.0, 1.0}
GMC_PowerFail.output		= {0.0, 1.0}
GMC_PowerFail.controller	= controllers.GMC_PowerFail

--------Copilot RMI----------
RMI_CoursePointer1				= CreateGauge()
RMI_CoursePointer1.arg_number	= 266
RMI_CoursePointer1.input		= {0.0, math.pi * 2.0}
RMI_CoursePointer1.output		= {0.0, 1.0}
RMI_CoursePointer1.controller	= controllers.RMI_CoursePointer1

RMI_CoursePointer2				= CreateGauge()
RMI_CoursePointer2.arg_number	= 267
RMI_CoursePointer2.input		= {0.0, math.pi * 2.0}
RMI_CoursePointer2.output		= {0.0, 1.0}
RMI_CoursePointer2.controller	= controllers.RMI_CoursePointer2

RMI_Heading					= CreateGauge()
RMI_Heading.arg_number		= 269
RMI_Heading.input			= {0.0, math.pi * 2.0}
RMI_Heading.output			= {0.0, 1.0}
RMI_Heading.controller		= controllers.RMI_Heading
---------------Altimeter Indicator AAU-32/A (operator)

Pointer						= CreateGauge()
Pointer.arg_number			= 168
Pointer.input				= {0.0, 1000.0}
Pointer.output				= {0.0, 1.0}
Pointer.controller			= controllers.PointerAAU_32_A

Alt1AAU_10000_footCount				= CreateGauge()
Alt1AAU_10000_footCount.arg_number	= 169
Alt1AAU_10000_footCount.input		= {0.0, 10.0}
Alt1AAU_10000_footCount.output		= {0.0, 1.0}
Alt1AAU_10000_footCount.params		= {2}
Alt1AAU_10000_footCount.controller	= controllers.AAU_32_Drum_Counter

Alt1AAU_1000_footCount				= CreateGauge()
Alt1AAU_1000_footCount.arg_number	= 170
Alt1AAU_1000_footCount.input		= {0.0, 10.0}
Alt1AAU_1000_footCount.output		= {0.0, 1.0}
Alt1AAU_1000_footCount.params		= {1}
Alt1AAU_1000_footCount.controller	= controllers.AAU_32_Drum_Counter

Alt1AAU_100_footCount				= CreateGauge()
Alt1AAU_100_footCount.arg_number	= 171
Alt1AAU_100_footCount.input			= {0.0, 10.0}
Alt1AAU_100_footCount.output		= {0.0, 1.0}
Alt1AAU_100_footCount.params		= {0}
Alt1AAU_100_footCount.controller	= controllers.AAU_32_Drum_Counter

AAU_32_Drum_Counter = CreateGauge()
AAU_32_Drum_Counter.arg_number		= 174
AAU_32_Drum_Counter.input			= {28.0, 31.0}
AAU_32_Drum_Counter.output			= {0.0, 0.3}
AAU_32_Drum_Counter.params			= {2}
AAU_32_Drum_Counter.controller		= controllers.AAU_32_Pressure_Drum_Counter

AAU_32_Drum_Counter = CreateGauge()
AAU_32_Drum_Counter.arg_number		= 175
AAU_32_Drum_Counter.input			= {0.0, 10.0}
AAU_32_Drum_Counter.output			= {0.0, 1.0}
AAU_32_Drum_Counter.params			= {1}
AAU_32_Drum_Counter.controller		= controllers.AAU_32_Pressure_Drum_Counter

AAU_32_Drum_Counter = CreateGauge()
AAU_32_Drum_Counter.arg_number		= 176
AAU_32_Drum_Counter.input			= {0.0, 10.0}
AAU_32_Drum_Counter.output			= {0.0, 1.0}
AAU_32_Drum_Counter.params			= {0}
AAU_32_Drum_Counter.controller		= controllers.AAU_32_Pressure_Drum_Counter

CodeOff_flag				= CreateGauge()
CodeOff_flag.arg_number		= 177
CodeOff_flag.input			= {0.0, 1.0}
CodeOff_flag.output			= {0.0, 1.0}
CodeOff_flag.controller		= controllers.CodeOff_flag
--------------------

------------Altimeter Indicator AAU-7/A (pilot)
Alt_10000_AAU_7A				= CreateGauge()
Alt_10000_AAU_7A.arg_number		= 178
Alt_10000_AAU_7A.input			= {0.0, 100000.0}
Alt_10000_AAU_7A.output			= {0.0, 1.0}
Alt_10000_AAU_7A.controller		= controllers.Alt_10000_AAU_7A

Alt_1000_AAU_7A					= CreateGauge()
Alt_1000_AAU_7A.arg_number		= 179
Alt_1000_AAU_7A.input			= {0.0, 10000.0}
Alt_1000_AAU_7A.output			= {0.0, 1.00}
Alt_1000_AAU_7A.controller		= controllers.Alt_1000_AAU_7A

Alt_100_AAU_7A					= CreateGauge()
Alt_100_AAU_7A.arg_number		= 180
Alt_100_AAU_7A.input			= {0.0, 1000.0}
Alt_100_AAU_7A.output			= {0.0, 1.0}
Alt_100_AAU_7A.controller		= controllers.Alt_100_AAU_7A

Press_AAU_7A				= CreateGauge()
Press_AAU_7A.arg_number		= 182
Press_AAU_7A.input			= {28.1, 31.0}
Press_AAU_7A.output			= {0.0, 1.0}
Press_AAU_7A.controller		= controllers.Press_AAU_7A

--------------------

EngOilPress					= CreateGauge()
EngOilPress.arg_number		= 113
EngOilPress.input			= {-3.0, 0.0, 100.0}
EngOilPress.output			= {0.0, 0.029, 1.0}
EngOilPress.controller		= controllers.EngOilPress

EngOilTemp					= CreateGauge()
EngOilTemp.arg_number		= 114
EngOilTemp.input			= {-70.0, -50.0, 0.0, 100.0, 150.0}
EngOilTemp.output			= {0.0, 0.13, 0.38, 0.71, 1.0}
EngOilTemp.controller		= controllers.EngOilTemp

TransmOilPress				= CreateGauge()
TransmOilPress.arg_number	= 115
TransmOilPress.input		= {-3.0, 0.0, 100.0}
TransmOilPress.output		= {0.0, 0.029, 1.0}
TransmOilPress.controller	= controllers.TransmOilPress

TransmOilTemp				= CreateGauge()
TransmOilTemp.arg_number	= 116
TransmOilTemp.input			= {-70.0, -50.0, 0.0, 100.0, 150.0}
TransmOilTemp.output		= {0.0, 0.13, 0.38, 0.71, 1.0}
TransmOilTemp.controller	= controllers.TransmOilTemp

AIRSPEED_Nose				= CreateGauge()
AIRSPEED_Nose.arg_number	= 117
AIRSPEED_Nose.input			= {0.0, 20.0, 30.0, 40.0, 50.0, 60.0, 80.0, 120.0, 150.0}
AIRSPEED_Nose.output		= {0.0, 0.075, 0.19, 0.32, 0.395, 0.44, 0.55, 0.825, 1.0}
AIRSPEED_Nose.controller	= controllers.IAS

AIRSPEED_Roof				= CreateGauge()
AIRSPEED_Roof.arg_number	= 118
AIRSPEED_Roof.input			= {0.0, 20.0, 30.0, 40.0, 50.0, 60.0, 80.0, 120.0, 150.0}
AIRSPEED_Roof.output		= {0.0, 0.075, 0.19, 0.32, 0.395, 0.44, 0.55, 0.825, 1.0}

ExhaustTemp					= CreateGauge()
ExhaustTemp.arg_number		= 121
ExhaustTemp.input			= {0.0, 500.0, 600.0, 900.0, 1000.0}
ExhaustTemp.output			= {0.0, 0.508, 0.604, 0.904, 1.0}
ExhaustTemp.controller		= controllers.ExhaustTemp

EngineTach					= CreateGauge()
EngineTach.arg_number		= 122
EngineTach.input			= {0.0, 7200.0}
EngineTach.output			= {0.0, 1.0}
EngineTach.controller		= controllers.EngineTach

RotorTach					= CreateGauge()
RotorTach.arg_number		= 123
RotorTach.input				= {0.0, 360.0}--{0.0, 300.0, 320.0, 339.0}
RotorTach.output			= {0.0, 1.0}--{0.0, 0.83, 0.94, 1.0}
RotorTach.controller		= controllers.RotorTach

GasProducerTach				= CreateGauge()
GasProducerTach.arg_number	= 119
GasProducerTach.input		= {0.0, 50.0, 100.0, 109}
GasProducerTach.output		= {0.0, 0.45,  0.91, 1.0}
GasProducerTach.controller	= controllers.GasProduceTachRPM

GasProducerTach_U				= CreateGauge()
GasProducerTach_U.arg_number	= 120
GasProducerTach_U.input			= {0.0, 10.0}
GasProducerTach_U.output		= {0.0, 1.0}
GasProducerTach_U.controller	= controllers.GasProduceTachRPM_Units

TorquePress					= CreateGauge()
TorquePress.arg_number		= 124
TorquePress.input			= {-3.0, 0.0, 100.0}
TorquePress.output			= {0.0, 0.029, 1.0}
TorquePress.controller		= controllers.TorquePress

VoltageDC					= CreateGauge()
VoltageDC.arg_number		= 149
VoltageDC.input				= {0.0, 30.0}
VoltageDC.output			= {0.0, 1.0}
VoltageDC.controller		= controllers.DC_voltage

VoltageAC					= CreateGauge()
VoltageAC.arg_number		= 150
VoltageAC.input				= {0.0, 150.0}
VoltageAC.output			= {0.0, 1.0}
VoltageAC.controller		= controllers.AC_voltage

LoadmeterMainGen			= CreateGauge()
LoadmeterMainGen.arg_number	= 436
LoadmeterMainGen.input		= {-1.5, 0.0, 12.5}
LoadmeterMainGen.output		= {0.0, 0.156, 1.0}
LoadmeterMainGen.controller	= controllers.MainGen_current

LoadmeterSTBYGen			= CreateGauge()
LoadmeterSTBYGen.arg_number	= 125
LoadmeterSTBYGen.input		= {-1.5, 0.0, 12.5}
LoadmeterSTBYGen.output		= {0.0, 0.09, 1.0}
LoadmeterSTBYGen.controller	= controllers.StdbyGen_current

FuelPress					= CreateGauge()
FuelPress.arg_number		= 126
FuelPress.input				= {-2.0, 0.0, 50.0}
FuelPress.output			= {0.0, 0.015, 1.0}
FuelPress.controller		= controllers.FuelPress

FuelQuantity				= CreateGauge()
FuelQuantity.arg_number		= 239
FuelQuantity.input			= {0.0, 1580.0}
FuelQuantity.output			= {0.0, 1.0}
FuelQuantity.controller		= controllers.FuelQuantity
---------------------------------------------------
-- Mechanic clock
CLOCK_hours					= CreateGauge()
CLOCK_hours.arg_number		= 127
CLOCK_hours.input			= {0.0, 12.0}
CLOCK_hours.output			= {0.0, 1.0}
CLOCK_hours.controller		= controllers.CLOCK_hours

CLOCK_minutes				= CreateGauge()
CLOCK_minutes.arg_number	= 128
CLOCK_minutes.input			= {0.0, 60.0}
CLOCK_minutes.output		= {0.0, 1.0}
CLOCK_minutes.controller	= controllers.CLOCK_minutes

CLOCK_seconds				= CreateGauge()
CLOCK_seconds.arg_number	= 129
CLOCK_seconds.input			= {0.0, 60.0}
CLOCK_seconds.output		= {0.0, 1.0}
CLOCK_seconds.controller	= controllers.CLOCK_seconds
-------------------------------------------------------------

TurnPtr						= CreateGauge()
TurnPtr.arg_number			= 132
TurnPtr.input				= {-math.rad(6.0), math.rad(6.0)}
TurnPtr.output				= {-1.0, 1.0}
TurnPtr.controller			= controllers.TurnPtr

SideSlip					= CreateGauge()
SideSlip.arg_number			= 133
SideSlip.input				= {-1.0, 1.0}
SideSlip.output				= {-1.0, 1.0}
SideSlip.controller			= controllers.SideSlip

VertVelocPilot					= CreateGauge()
VertVelocPilot.arg_number		= 134
VertVelocPilot.input			= {-4000.0, -3000.0, -1500.0, -1000.0, 1000.0, 1500.0, 3000.0, 4000.0}
VertVelocPilot.output			= {-1.0, -0.81,  -0.54, -0.36, 0.36, 0.54, 0.81, 1.0}
VertVelocPilot.controller		= controllers.VertVelPilot

VertVelocCopilot				= CreateGauge()
VertVelocCopilot.arg_number		= 251
VertVelocCopilot.input			= {-4000.0, -3000.0, -1500.0, -1000.0, 1000.0, 1500.0, 3000.0, 4000.0}
VertVelocCopilot.output			= {-1.0, -0.81,  -0.54, -0.36, 0.36, 0.54, 0.81, 1.0}
VertVelocCopilot.controller		= controllers.VertVelCopilot


---------------------------------------------------
-- ADI - pilot
Attitude_Roll					= CreateGauge()
Attitude_Roll.arg_number		= 142
Attitude_Roll.input				= {-math.pi, math.pi}
Attitude_Roll.output			= {1.0, -1.0}
Attitude_Roll.controller		= controllers.Attitude_roll

Attitude_Pitch					= CreateGauge()
Attitude_Pitch.arg_number		= 143
Attitude_Pitch.input			= {-math.rad(90), math.rad(90)}
Attitude_Pitch.output			= {1.0, -1.0}
Attitude_Pitch.controller		= controllers.Attitude_pitch

Attitude_Off_flag				= CreateGauge()
Attitude_Off_flag.arg_number	= 148
Attitude_Off_flag.input			= {0.0, 1.0}
Attitude_Off_flag.output		= {0.0, 1.0}
Attitude_Off_flag.controller	= controllers.Attitude_Off_flag

------------------------- 
-- ADI - operator

Attitude_Roll_left				= CreateGauge()
Attitude_Roll_left.arg_number	= 135
Attitude_Roll_left.input		= {-math.pi, math.pi}
Attitude_Roll_left.output		= {1.0, -1.0}
Attitude_Roll_left.controller	= controllers.Attitude_Operator_roll

Attitude_Pitch_left				= CreateGauge()
Attitude_Pitch_left.arg_number	= 136
Attitude_Pitch_left.input		= {-math.rad(90), math.rad(90)}
Attitude_Pitch_left.output		= {1.0, -1.0}
Attitude_Pitch_left.controller	= controllers.Attitude_Operator_pitch

Attitude_Off_flag_left				= CreateGauge()
Attitude_Off_flag_left.arg_number	= 141
Attitude_Off_flag_left.input		= {0.0, 1.0}
Attitude_Off_flag_left.output		= {1.0, 0.0}
Attitude_Off_flag_left.controller	= controllers.Attitude_Off_failure_flag
		
Attitude_PitchShift				= CreateGauge()
Attitude_PitchShift.arg_number	= 138
Attitude_PitchShift.input		= {0.0, 1.0}
Attitude_PitchShift.output		= {-1.0, 1.0}
Attitude_PitchShift.controller	= controllers.Attitude_PitchShift

DCVoltmeter					= CreateGauge()
DCVoltmeter.arg_number		= 149
DCVoltmeter.input			= {0.0, 30.0}
DCVoltmeter.output			= {0.0, 1.0}
DCVoltmeter.controller		= controllers.DC_voltage

ACVoltmeter					= CreateGauge()
ACVoltmeter.arg_number		= 150
ACVoltmeter.input			= {0.0, 150.0}
ACVoltmeter.output			= {0.0, 1.0}
ACVoltmeter.controller		= controllers.AC_voltage


UHF_ARC51_Freq1					= CreateGauge()
UHF_ARC51_Freq1.arg_number		= 10
UHF_ARC51_Freq1.input			= {2.0, 3.0}
UHF_ARC51_Freq1.output			= {0.0, 1.0}
UHF_ARC51_Freq1.controller		= controllers.UHF_ARC51_Freq1

UHF_ARC51_Freq2					= CreateGauge()
UHF_ARC51_Freq2.arg_number		= 11
UHF_ARC51_Freq2.input			= {0.0, 10.0}
UHF_ARC51_Freq2.output			= {0.0, 1.0}
UHF_ARC51_Freq2.controller		= controllers.UHF_ARC51_Freq2

UHF_ARC51_Freq3					= CreateGauge()
UHF_ARC51_Freq3.arg_number		= 12
UHF_ARC51_Freq3.input			= {0.0, 10.0}
UHF_ARC51_Freq3.output			= {0.0, 1.0}
UHF_ARC51_Freq3.controller		= controllers.UHF_ARC51_Freq3

UHF_ARC51_Freq4					= CreateGauge()
UHF_ARC51_Freq4.arg_number		= 13
UHF_ARC51_Freq4.input			= {0.0, 10.0}
UHF_ARC51_Freq4.output			= {0.0, 1.0}
UHF_ARC51_Freq4.controller		= controllers.UHF_ARC51_Freq4

UHF_ARC51_Freq5					= CreateGauge()
UHF_ARC51_Freq5.arg_number		= 14
UHF_ARC51_Freq5.input			= {0.0, 10.0}
UHF_ARC51_Freq5.output			= {0.0, 1.0}
UHF_ARC51_Freq5.controller		= controllers.UHF_ARC51_Freq5


NAV_ARN82_Freq1					= CreateGauge()
NAV_ARN82_Freq1.arg_number		= 46
NAV_ARN82_Freq1.input			= {0.0, 10.0}
NAV_ARN82_Freq1.output			= {0.0, 1.0}
NAV_ARN82_Freq1.controller		= controllers.NAV_ARN82_Freq1

NAV_ARN82_Freq2					= CreateGauge()
NAV_ARN82_Freq2.arg_number		= 47
NAV_ARN82_Freq2.input			= {0.0, 10.0}
NAV_ARN82_Freq2.output			= {0.0, 1.0}
NAV_ARN82_Freq2.controller		= controllers.NAV_ARN82_Freq2

NAV_ARN82_Freq3					= CreateGauge()
NAV_ARN82_Freq3.arg_number		= 48
NAV_ARN82_Freq3.input			= {0.0, 10.0}
NAV_ARN82_Freq3.output			= {0.0, 1.0}
NAV_ARN82_Freq3.controller		= controllers.NAV_ARN82_Freq3

NAV_ARN82_Freq4					= CreateGauge()
NAV_ARN82_Freq4.arg_number		= 49
NAV_ARN82_Freq4.input			= {0.0, 10.0}
NAV_ARN82_Freq4.output			= {0.0, 1.0}
NAV_ARN82_Freq4.controller		= controllers.NAV_ARN82_Freq4

NAV_ARN82_Freq5					= CreateGauge()
NAV_ARN82_Freq5.arg_number		= 50
NAV_ARN82_Freq5.input			= {0.0, 10.0}
NAV_ARN82_Freq5.output			= {0.0, 1.0}
NAV_ARN82_Freq5.controller		= controllers.NAV_ARN82_Freq5

VHF_ARC134_Freq1				= CreateGauge()
VHF_ARC134_Freq1.arg_number		= 1
VHF_ARC134_Freq1.input			= {0.0, 10.0}
VHF_ARC134_Freq1.output			= {0.0, 1.0}
VHF_ARC134_Freq1.controller		= controllers.VHF_ARC134_Freq1

VHF_ARC134_Freq2				= CreateGauge()
VHF_ARC134_Freq2.arg_number		= 2
VHF_ARC134_Freq2.input			= {0.0, 10.0}
VHF_ARC134_Freq2.output			= {0.0, 1.0}
VHF_ARC134_Freq2.controller		= controllers.VHF_ARC134_Freq2

VHF_ARC134_Freq3				= CreateGauge()
VHF_ARC134_Freq3.arg_number		= 3
VHF_ARC134_Freq3.input			= {0.0, 10.0}
VHF_ARC134_Freq3.output			= {0.0, 1.0}
VHF_ARC134_Freq3.controller		= controllers.VHF_ARC134_Freq3

VHF_ARC134_Freq4				= CreateGauge()
VHF_ARC134_Freq4.arg_number		= 4
VHF_ARC134_Freq4.input			= {0.0, 100.0}
VHF_ARC134_Freq4.output			= {0.0, 1.0}
VHF_ARC134_Freq4.controller		= controllers.VHF_ARC134_Freq4

Marker_Beacon_Lamp				= CreateGauge()
Marker_Beacon_Lamp.arg_number	= 56
Marker_Beacon_Lamp.input		= {0.0, 1.0}
Marker_Beacon_Lamp.output		= {0.0, 0.9}
Marker_Beacon_Lamp.controller	= controllers.Marker_Beacon_Lamp



Panel_Shake_Z  				= CreateGauge()
Panel_Shake_Z.arg_number	= 264
Panel_Shake_Z.input			= {-1,1}
Panel_Shake_Z.output		= {-0.8,0.8}
Panel_Shake_Z.controller	= controllers.Panel_Shake_Z

Panel_Shake_Y  				= CreateGauge()
Panel_Shake_Y.arg_number	= 265
Panel_Shake_Y.input			= {-1,1}
Panel_Shake_Y.output		= {-0.8,0.8}
Panel_Shake_Y.controller	= controllers.Panel_Shake_Y

Panel_Rot_X  				= CreateGauge()
Panel_Rot_X.arg_number		= 282
Panel_Rot_X.input			= {-1,1}
Panel_Rot_X.output			= {-0.5,0.5}
Panel_Rot_X.controller		= controllers.Panel_Rot_X

Wiper_Pilot  				= CreateGauge()
Wiper_Pilot.arg_number		= 284
Wiper_Pilot.input			= {0.0,1.0}
Wiper_Pilot.output			= {0.0,1.0}
Wiper_Pilot.controller		= controllers.Wiper_Pilot

Wiper_Operator  			= CreateGauge()
Wiper_Operator.arg_number	= 283
Wiper_Operator.input		= {0.0,1.0}
Wiper_Operator.output		= {0.0,1.0}
Wiper_Operator.controller	= controllers.Wiper_Operator


Pilot_Model  				= CreateGauge()
Pilot_Model.arg_number		= 242
Pilot_Model.input			= {0.0,1.0}
Pilot_Model.output			= {0.0,1.0}
Pilot_Model.controller		= controllers.Pilot_Model

Operator_Model 				= CreateGauge()
Operator_Model.arg_number	= 245
Operator_Model.input		= {0.0,1.0}
Operator_Model.output		= {0.0,1.0}
Operator_Model.controller	= controllers.Operator_Model

--Flexible sight station
FlexSightHeight				= CreateGauge()
FlexSightHeight.arg_number	= 263
FlexSightHeight.input		= {0.0, 1.0}
FlexSightHeight.output		= {0.0, 0.79}
FlexSightHeight.controller	= controllers.Flex_Sight_Height

FlexSightAzimuth				= CreateGauge()
FlexSightAzimuth.arg_number		= 261
FlexSightAzimuth.input			= {-math.rad(90.0),math.rad(90.0)}
FlexSightAzimuth.output			= {1.0, -1.0}
FlexSightAzimuth.controller		= controllers.Flex_Sight_Azimuth

FlexSightElevation				= CreateGauge()
FlexSightElevation.arg_number	= 262
FlexSightElevation.input		= {-math.rad(90.0), math.rad(90.0)}
FlexSightElevation.output		= {-1.0, 1.0}
FlexSightElevation.controller	= controllers.Flex_Sight_Elevation

--Pilot sight station
PilotSightHeight				= CreateGauge()
PilotSightHeight.arg_number		= 438
PilotSightHeight.input			= {0.0, 1.0}
PilotSightHeight.output			= {0.0, 1.0}
PilotSightHeight.controller		= controllers.Pilot_Sight_Height

PilotSightGlass					= CreateGauge()
PilotSightGlass.arg_number		= 442
PilotSightGlass.input			= {-1.0, 1.0}
PilotSightGlass.output			= {0.45, 0.55}
PilotSightGlass.controller		= controllers.Pilot_Sight_Glass

ConsoleLight					= CreateGauge()
ConsoleLight.arg_number			= 279
ConsoleLight.input				= {0.0, 1.0}
ConsoleLight.output				= {0.0, 1.0}
ConsoleLight.controller			= controllers.ConsoleLight

PedLight						= CreateGauge()
PedLight.arg_number				= 476
PedLight.input					= {0.0, 1.0}
PedLight.output					= {0.0, 1.0}
PedLight.controller				= controllers.PedLight

SecLight						= CreateGauge()
SecLight.arg_number				= 474
SecLight.input					= {0.0, 1.0}
SecLight.output					= {0.0, 1.0}
SecLight.controller				= controllers.SecLight

EngineLight						= CreateGauge()
EngineLight.arg_number			= 477
EngineLight.input				= {0.0, 1.0}
EngineLight.output				= {0.0, 1.0}
EngineLight.controller			= controllers.EngineLight

CoPilotLight					= CreateGauge()
CoPilotLight.arg_number			= 475
CoPilotLight.input				= {0.0, 1.0}
CoPilotLight.output				= {0.0, 1.0}
CoPilotLight.controller			= controllers.CoPilotLight

PilotLight						= CreateGauge()
PilotLight.arg_number			= 478
PilotLight.input				= {0.0, 1.0}
PilotLight.output				= {0.0, 1.0}
PilotLight.controller			= controllers.PilotLight

DomeLight						= CreateGauge()
DomeLight.arg_number			= 410
DomeLight.input					= {0.0, 1.0}
DomeLight.output				= {0.0, 1.0}
DomeLight.controller			= controllers.DomeLight

DomeLightGreen					= CreateGauge()
DomeLightGreen.arg_number		= 411
DomeLightGreen.input			= {0.0, 1.0}
DomeLightGreen.output			= {0.0, 1.0}
DomeLightGreen.controller		= controllers.DomeLightGreen

DeadPilot						= CreateGauge()
DeadPilot.arg_number			= 248
DeadPilot.input					= {0.0, 1.0}
DeadPilot.output				= {0.0, 1.0}
DeadPilot.controller			= controllers.DeadPilotArg

DeadCoPilot						= CreateGauge()
DeadCoPilot.arg_number			= 249
DeadCoPilot.input				= {0.0, 1.0}
DeadCoPilot.output				= {0.0, 1.0}
DeadCoPilot.controller			= controllers.DeadCoPilotArg

LeftWindShield					= CreateGauge()
LeftWindShield.arg_number		= 414
LeftWindShield.input			= {0.0, 1.0}
LeftWindShield.output			= {0.0, 1.0}
LeftWindShield.controller		= controllers.LeftWindShield

RightWindShield					= CreateGauge()
RightWindShield.arg_number		= 413
RightWindShield.input			= {0.0, 1.0}
RightWindShield.output			= {0.0, 1.0}
RightWindShield.controller		= controllers.RightWindShield

DownBlisters					= CreateGauge()
DownBlisters.arg_number			= 412
DownBlisters.input				= {0.0, 1.0}
DownBlisters.output				= {0.0, 1.0}
DownBlisters.controller			= controllers.DownBlisters

UpRightBlister					= CreateGauge()
UpRightBlister.arg_number		= 417
UpRightBlister.input			= {0.0, 1.0}
UpRightBlister.output			= {0.0, 1.0}
UpRightBlister.controller		= controllers.UpRightBlister

UpLeftBlister					= CreateGauge()
UpLeftBlister.arg_number		= 418
UpLeftBlister.input				= {0.0, 1.0}
UpLeftBlister.output			= {0.0, 1.0}
UpLeftBlister.controller		= controllers.UpLeftBlister

RightWindow					= CreateGauge()
RightWindow.arg_number		= 415
RightWindow.input			= {0.0, 1.0}
RightWindow.output			= {0.0, 1.0}
RightWindow.controller		= controllers.RightWindow

LeftWindow					= CreateGauge()
LeftWindow.arg_number		= 416
LeftWindow.input			= {0.0, 1.0}
LeftWindow.output			= {0.0, 1.0}
LeftWindow.controller		= controllers.LeftWindow

RightDoor					= CreateGauge()
RightDoor.arg_number		= 422
RightDoor.input				= {0.0, 1.0}
RightDoor.output			= {0.0, 1.0}
RightDoor.controller		= controllers.RightDoor

LeftDoor					= CreateGauge()
LeftDoor.arg_number			= 420
LeftDoor.input				= {0.0, 1.0}
LeftDoor.output				= {0.0, 1.0}
LeftDoor.controller			= controllers.LeftDoor

RamTemp						= CreateGauge()
RamTemp.arg_number			= 437
RamTemp.input				= {-70, -50,   -30,   -10,   0,     10,    20,    30,    50}
RamTemp.output				= {0.0, 0.152, 0.314, 0.482, 0.567, 0.651, 0.738, 0.825, 1.0}
RamTemp.controller			= controllers.RamTemp

-- Radar Altimeter
RALT_Needle					= CreateGauge()
RALT_Needle.arg_number		= 443
RALT_Needle.input			= {0.0, 0.98}
RALT_Needle.output			= {0.0, 0.98}
RALT_Needle.controller		= controllers.RALT_Needle

RALT_Off_Flag				= CreateGauge()
RALT_Off_Flag.arg_number	= 467
RALT_Off_Flag.input			= {0.0, 1.0}
RALT_Off_Flag.output		= {0.0, 1.0}
RALT_Off_Flag.controller	= controllers.RALT_Off_Flag

RALT_LO_Lamp				= CreateGauge()
RALT_LO_Lamp.arg_number		= 447
RALT_LO_Lamp.input			= {0.0, 1.0}
RALT_LO_Lamp.output			= {0.0, 1.0}
RALT_LO_Lamp.controller		= controllers.RALT_LO_Lamp

RALT_HI_Lamp				= CreateGauge()
RALT_HI_Lamp.arg_number		= 465
RALT_HI_Lamp.input			= {0.0, 1.0}
RALT_HI_Lamp.output			= {0.0, 1.0}
RALT_HI_Lamp.controller		= controllers.RALT_HI_Lamp

RALT_LO_Index				= CreateGauge()
RALT_LO_Index.arg_number	= 444
RALT_LO_Index.input			= {-0.02, -0.01, -0.0001,0.0, 0.744}
RALT_LO_Index.output		= {0.97,  0.99, 1.0, 0.0, 0.744}
RALT_LO_Index.controller	= controllers.RALT_LO_Index

RALT_HI_Index				= CreateGauge()
RALT_HI_Index.arg_number	= 466
RALT_HI_Index.input			= {0.0, 0.744}
RALT_HI_Index.output		= {0.0, 0.744}
RALT_HI_Index.controller	= controllers.RALT_HI_Index

RALT_Digit_1				= CreateGauge()
RALT_Digit_1.arg_number		= 468
RALT_Digit_1.input			= {0.0, 10.0}
RALT_Digit_1.output			= {0.0, 1.0}
RALT_Digit_1.controller		= controllers.RALT_Digit_1

RALT_Digit_2				= CreateGauge()
RALT_Digit_2.arg_number		= 469
RALT_Digit_2.input			= {0.0, 10.0}
RALT_Digit_2.output			= {0.0, 1.0}
RALT_Digit_2.controller		= controllers.RALT_Digit_2

RALT_Digit_3				= CreateGauge()
RALT_Digit_3.arg_number		= 470
RALT_Digit_3.input			= {0.0, 10.0}
RALT_Digit_3.output			= {0.0, 1.0}
RALT_Digit_3.controller		= controllers.RALT_Digit_3

RALT_Digit_4				= CreateGauge()
RALT_Digit_4.arg_number		= 471
RALT_Digit_4.input			= {0.0, 10.0}
RALT_Digit_4.output			= {0.0, 1.0}
RALT_Digit_4.controller		= controllers.RALT_Digit_4

--[[Radar_Altitude				= CreateGauge()
Radar_Altitude.arg_number	= 443
Radar_Altitude.input		= {0.008, 0.8}
Radar_Altitude.output		= {0.008, 0.8}
Radar_Altitude.controller	= controllers.Radar_Altitude

Ralt_DH_index				= CreateGauge()
Ralt_DH_index.arg_number   	= 444
Ralt_DH_index.input			= {0.0, 1.0}
Ralt_DH_index.output		= {0.0, 1.0}
Ralt_DH_index.controller  	= controllers.Ralt_DH_index

Ralt_DH_Lamp				= CreateGauge()
Ralt_DH_Lamp.arg_number		= 447
Ralt_DH_Lamp.input			= {0.0, 1.0}
Ralt_DH_Lamp.output			= {0.0, 1.0}
Ralt_DH_Lamp.controller		= controllers.Ralt_DH_Lamp]]


FLARE_Digit_1				= CreateGauge()
FLARE_Digit_1.arg_number	= 460
FLARE_Digit_1.input			= {0.0, 10.0}
FLARE_Digit_1.output		= {0.0, 1.0}
FLARE_Digit_1.controller	= controllers.FLARE_Digit_1

FLARE_Digit_2				= CreateGauge()
FLARE_Digit_2.arg_number	= 461
FLARE_Digit_2.input			= {0.0, 10.0}
FLARE_Digit_2.output		= {0.0, 1.0}
FLARE_Digit_2.controller	= controllers.FLARE_Digit_2

CHAFF_Digit_1				= CreateGauge()
CHAFF_Digit_1.arg_number	= 462
CHAFF_Digit_1.input			= {0.0, 10.0}
CHAFF_Digit_1.output		= {0.0, 1.0}
CHAFF_Digit_1.controller	= controllers.CHAFF_Digit_1

CHAFF_Digit_2				= CreateGauge()
CHAFF_Digit_2.arg_number	= 463
CHAFF_Digit_2.input			= {0.0, 10.0}
CHAFF_Digit_2.output		= {0.0, 1.0}
CHAFF_Digit_2.controller	= controllers.CHAFF_Digit_2

XM130_ARMED					= CreateGauge()
XM130_ARMED.arg_number		= 458
XM130_ARMED.input			= {0.0, 1.0}
XM130_ARMED.output			= {0.0, 1.0}
XM130_ARMED.controller		= controllers.XM130_ARMED_lamp

SIGHTS_FOR_CIVIL				= CreateGauge()
SIGHTS_FOR_CIVIL.arg_number		= 473
SIGHTS_FOR_CIVIL.input			= {0.0, 1.0}
SIGHTS_FOR_CIVIL.output			= {0.0, 1.0}
SIGHTS_FOR_CIVIL.controller		= controllers.Civil_Heli

--=================================================
-- LAMPS
--=================================================
dofile(LockOn_Options.script_path.."MAIN_PANEL/lamps.lua")

seat_points = 
{
[1] = {point = {0.0,  0.1,  0.55}},
[2] = {point = {0.0,  0.1, -0.5825}},
[3] = {point = {-0.121463, -0.139260 + 0.5,  1.477076 - 0.5 ,absolute_position = true }},
[4] = {point = {-0.121377, -0.139260 + 0.5, -1.514663 + 0.5 ,absolute_position = true }},
}

need_to_be_closed = true -- close lua state after initialization

dofile(LockOn_Options.common_script_path.."tools.lua")
livery = find_custom_livery("UH-1H","default")

