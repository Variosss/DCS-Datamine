--/N/ revised Sept 2015, ok
--/M/ added VR tracking support - 20200524
--/M/ Added cockpit local point for new cockpit. - 20200605


dofile(LockOn_Options.script_path.."VR_Config.lua")

shape_name = "Cockpit_MiG-21bis"

is_EDM = true
new_shape = true 
new_model_format = true
new_infrared_debug = false
v_angle_shift 	 = math.rad(1.0)

simplify_cockpit = false

shift = {0, 0, 0}
rotation = math.rad(0.0)

cockpit_local_point = {3.198, 0.914, 0.0} -- /Mike/ Coordinates must match PNT_ZERO in external model. {X, Z, Y}

ambient =
{
	lighttype = "ambient"
}
--[[
ambient_light = {0, 0, 255}
ambient_color_day_texture = { 72, 100, 160 }
ambient_color_night_texture = {40, 10, 180}
ambient_color_from_cockpit_illumination = {240, 240, 240}
ambient_color_from_devices = {16, 12, 12}
ambient_color_from_panels	 = {16, 12, 12}
ambient_color_from_abris	 = {10, 24, 12}
ambient_color_from_shkval	 = {50, 50, 50}
]]

dusk_border = 0.1

draw_old_cockpit = false
draw_pilot = false
use_external_views = false 

draw_arcade = LockOn_Options.flight.easy_radar or LockOn_Options.flight.auto_lockon

external_model_canopy_arg = 38

--[[
day_texture_set_value = 0.0
night_texture_set_value = 0.1
]]

render_target_always = true

cockpit_illumination_external = 100
nightBeginTime = 20.0
nightEndTime = 6.0


---------------------------------------------------------------
-- Livery change --/N/ moved to the EOF
---------------------------------------------------------------

args_initial_state = {} --/N/ has to be here, before any "args_initial_state" call

--[[
livery = "default"
args_initial_state = { }

dofile(lfs.writedir().."Config/options.lua")

local Custom_cockpit_livery

function check_options()
	Custom_cockpit_livery = options["plugins"]["MiG-21Bis"]["CustomCockpit"]
	--Custom_cockpit_livery = options["plugins"]["MiG-21Bis"]["CPLocalList"]
end

function load_default_livery()
	--/N/ default behaviour
	if LockOn_Options.cockpit_language == "russian" then
		args_initial_state[617] = 0.0
	else
		livery = "english"
		args_initial_state[617] = 1.0
	end
end

	
if pcall(check_options) then
	if (Custom_cockpit_livery == true) then
			livery = "custom"
			args_initial_state[617] = 1.0
	else
		load_default_livery()
	end
else
	load_default_livery()
end
]]



---------------------------------------------------------------
-- CONTROLLERS
---------------------------------------------------------------

local controllers = LoRegisterPanelControls()

-- MIRROR == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 
mirrors_data = 
{ 
	--center_point = { -1.6, 0.65, 0.00 }, 
	width = 0.3,
	aspect = 1.0,
	rotation = math.rad(-30),
	--rotation_x = math.rad(0),
	--rotation_y = math.rad(0), -- -math.pi;	
	--rotation_z = math.rad(0),
	animation_speed = 2.0,
	near_clip = 0.1,
	middle_clip = 20,--9000,
	far_clip = 50000.0,
	connector = "MIG21-CPT-MIRRORS",
	use_z_correction = true,
	--arg_value_when_on = 1.0;
}

mirrors_draw = CreateGauge()
mirrors_draw.arg_number = 16
mirrors_draw.input = { 0.0, 1.0 }
mirrors_draw.output = { 0.0, 1.0 }
mirrors_draw.controller = controllers.mirrors_draw


if not LockOn_Options.cockpit.mirrors then
 args_initial_state[16] = 1.0
 else
 args_initial_state[16] = 0.0
end

--CANOPY == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 
--/N/ note> there is also canopy open light under the LIGHTS

CANOPY_anti_ice = CreateGauge("parameter")
CANOPY_anti_ice.parameter_name = "CANOPY_anti_ice"
CANOPY_anti_ice.arg_number = 239
CANOPY_anti_ice.input = { 0.0, 1.0 } 
CANOPY_anti_ice.output = { 0.0, 1.0 }

--ALCOHOL, COMPRESSED_AIR other similar stuff == == == == == == == == == == == == == == == == == == == == == == == == 

ALCOHOL = CreateGauge("parameter")
ALCOHOL.parameter_name = "ALCOHOL"
ALCOHOL.arg_number = 411
ALCOHOL.input = { 0.0, 100.0 } 
ALCOHOL.output = { 0.0, 1.0 }

COMPRESSED_AIR_main = CreateGauge("parameter")
COMPRESSED_AIR_main.parameter_name = "COMPRESSED_AIR_main"
COMPRESSED_AIR_main.arg_number = 413
COMPRESSED_AIR_main.input = { 0.0, 130 } 
COMPRESSED_AIR_main.output = { 0.0, 1.0 }

COMPRESSED_AIR_aux = CreateGauge("parameter")
COMPRESSED_AIR_aux.parameter_name = "COMPRESSED_AIR_aux"
COMPRESSED_AIR_aux.arg_number = 414
COMPRESSED_AIR_aux.input = { 0.0, 130 } 
COMPRESSED_AIR_aux.output = { 0.0, 1.0 }

-- OXYGENE SYSTEM (pilot only, engine O2 separated) == == == == == == == == == == == == == == == == == == == == == == 

OXYGENE_instrument_IK52 = CreateGauge("parameter") 
OXYGENE_instrument_IK52.parameter_name = "OXYGENE_instrument_IK52"
OXYGENE_instrument_IK52.arg_number = 59
OXYGENE_instrument_IK52.input = { 0.0, 150 } 
OXYGENE_instrument_IK52.output = { 0.0, 1.0 }

OXYGENE_instrument_IK52_blinking_lungs = CreateGauge("parameter") 
OXYGENE_instrument_IK52_blinking_lungs.parameter_name = "OXYGENE_instrument_IK52_blinking_lungs"
OXYGENE_instrument_IK52_blinking_lungs.arg_number = 60
OXYGENE_instrument_IK52_blinking_lungs.input = { 0.0, 1.0 } 
OXYGENE_instrument_IK52_blinking_lungs.output = { 0.0, 1.0 }

OXYGENE_instrument_M2000 = CreateGauge("parameter")
OXYGENE_instrument_M2000.parameter_name = "OXYGENE_instrument_M2000"
OXYGENE_instrument_M2000.arg_number = 58
OXYGENE_instrument_M2000.input = { 0.0, 20.0 }
OXYGENE_instrument_M2000.output = { 0.0, 1.0 }


--GEAR LIGHTS == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==

GEAR_NOSE_UP_LIGHT = CreateGauge("parameter")
GEAR_NOSE_UP_LIGHT.parameter_name = "GEAR_NOSE_UP_LIGHT"
GEAR_NOSE_UP_LIGHT.arg_number = 9
GEAR_NOSE_UP_LIGHT.input = { 0.0, 1.0 }
GEAR_NOSE_UP_LIGHT.output = { 1.0, 0.0 }

GEAR_NOSE_DOWN_LIGHT = CreateGauge("parameter")
GEAR_NOSE_DOWN_LIGHT.parameter_name = "GEAR_NOSE_DOWN_LIGHT"
GEAR_NOSE_DOWN_LIGHT.arg_number = 12
GEAR_NOSE_DOWN_LIGHT.input = { 0.0, 1.0 }
GEAR_NOSE_DOWN_LIGHT.output = { 0.0, 1.0 }

GEAR_LEFT_UP_LIGHT = CreateGauge("parameter")
GEAR_LEFT_UP_LIGHT.parameter_name = "GEAR_LEFT_UP_LIGHT"
GEAR_LEFT_UP_LIGHT.arg_number = 10
GEAR_LEFT_UP_LIGHT.input = { 0.0, 1.0 }
GEAR_LEFT_UP_LIGHT.output = { 1.0, 0.0 }

GEAR_LEFT_DOWN_LIGHT = CreateGauge("parameter")
GEAR_LEFT_DOWN_LIGHT.parameter_name = "GEAR_LEFT_DOWN_LIGHT"
GEAR_LEFT_DOWN_LIGHT.arg_number = 13
GEAR_LEFT_DOWN_LIGHT.input = { 0.0, 1.0 }
GEAR_LEFT_DOWN_LIGHT.output = { 0.0, 1.0 }

GEAR_RIGHT_UP_LIGHT = CreateGauge("parameter")
GEAR_RIGHT_UP_LIGHT.parameter_name = "GEAR_RIGHT_UP_LIGHT"
GEAR_RIGHT_UP_LIGHT.arg_number = 11
GEAR_RIGHT_UP_LIGHT.input = { 0.0, 1.0 }
GEAR_RIGHT_UP_LIGHT.output = { 1.0, 0.0 }

GEAR_RIGHT_DOWN_LIGHT = CreateGauge("parameter")
GEAR_RIGHT_DOWN_LIGHT.parameter_name = "GEAR_RIGHT_DOWN_LIGHT"
GEAR_RIGHT_DOWN_LIGHT.arg_number = 14
GEAR_RIGHT_DOWN_LIGHT.input = { 0.0, 1.0 }
GEAR_RIGHT_DOWN_LIGHT.output = { 0.0, 1.0 }

-- AIRBRAKES and FLAPS (3D) == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

AIRBRAKES_button = CreateGauge("parameter")
AIRBRAKES_button.parameter_name = "AIRBRAKES_button"
AIRBRAKES_button.arg_number = 316
AIRBRAKES_button.input = { 0.0, 1.0 }
AIRBRAKES_button.output = { 0.0, 1.0 }

--[[ /N/ disabled okt 2018 - not used
AIRBRAKES_3D = CreateGauge()
AIRBRAKES_3D.arg_number = 7
AIRBRAKES_3D.input = { 0.0, 1.0 }
AIRBRAKES_3D.output = { 0.0, 1.0 }
AIRBRAKES_3D.controller = controllers.base_gauge_SpeedBrakePos
]]

--/N/ NOTE: response to mantis request 0031809, 10.09.2015.
-- This parameter is virtual. It holds external flaps 3D object position: 0.0 - fully retracted, 0.5 - 25 degrees out, 1.0 - 45 degrees out.
FLAPS_3D = CreateGauge("parameter")
FLAPS_3D.parameter_name = "FLAPS_3D"
FLAPS_3D.arg_number = 600
FLAPS_3D.input = { 0.0, 1.0 } 
FLAPS_3D.output = { 0.0, 1.0 }

-- INSTRUMENTS == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

IAS_indicator = CreateGauge("parameter")
IAS_indicator.parameter_name = "IAS_indicator"
IAS_indicator.arg_number = 100
					--	0	300		600		900	1199	1500	2000	
IAS_indicator.input = { 0.0, 83.33, 166.67, 250.0, 333.34, 416.67, 555.55 }
IAS_indicator.output = { 0.0, 0.15, 0.30, 0.45, 0.60, 0.75, 1.0 }

TAS_indicator = CreateGauge("parameter")
TAS_indicator.parameter_name = "TAS_indicator"
TAS_indicator.arg_number = 101 
--										0		600	 700	 800	 900	 1000  1100  1200    1300   1400   1500   1600   1700   1800   1900   2000   2100   2200   2300   2400   2500 3000
TAS_indicator.input = { 0.0, 166.6, 194.4, 222.2, 250.0, 277.8, 305.5, 333.3, 361.1, 388.9, 416.6, 444.4, 472.2, 500.0, 527.8, 555.5, 583.3, 611.1, 638.9, 666.7, 694.4, 833.3 }
--										0		600	 700	 800	 900	 1000  1100  1200    1300   1400   1500   1600   1700   1800   1900   2000   2100   2200   2300   2400   2500 3000
TAS_indicator.output = { 0.0, 0.20, 0.232, 0.264, 0.296, 0.329, 0.361, 0.394, 0.427, 0.460, 0.493, 0.526, 0.561, 0.598, 0.630, 0.66, 0.695, 0.729, 0.762, 0.795, 0.829, 1.00 }

M_indicator = CreateGauge("parameter")
M_indicator.parameter_name = "M_indicator"
M_indicator.arg_number = 102 
M_indicator.input = { 0.0,  0.6,  	0.7, 		0.8, 		0.9, 		1.0, 		1.1, 		1.2, 		1.3, 1.4, 			1.5, 		1.6, 		1.7, 		1.8, 		1.9, 		2.0, 3.0 }
M_indicator.output = { 0.0, 0.202, 0.234, 0.266, 0.299, 0.332, 0.364, 0.397, 0.429, 0.462, 0.495, 0.527, 0.563, 0.60, 0.630, 0.66, 1.00 }

-- Baro altimeter subgroup -------------------------------------------------------------------------------------------------------------------------

H_indicator_needle_m = CreateGauge("parameter")
H_indicator_needle_m.parameter_name = "H_indicator_needle_m"
H_indicator_needle_m.arg_number = 104
H_indicator_needle_m.input = { 0.0, 200.0, 400.0, 600.0, 800.0, 1000.0 }
H_indicator_needle_m.output = { 0.0, 0.193, 0.394, 0.602, 0.807, 1.0 }

H_indicator_needle_km = CreateGauge("parameter")
H_indicator_needle_km.parameter_name = "H_indicator_needle_km"
H_indicator_needle_km.arg_number = 112
H_indicator_needle_km.input = { 0.0, 5000.0, 10000.0, 15000.0, 20000.0, 25000.0, 30000.0 }
H_indicator_needle_km.output = { 0.0, 0.155, 0.302, 0.457, 0.621, 0.784, 0.950 }

--/N/ KSI subgroup (NPP) -------------------------------------------------------------------------------------------------------------------------

KSI_switch = CreateGauge("parameter")
KSI_switch.parameter_name = "KSI_switch"
KSI_switch.arg_number = 178
KSI_switch.input = { 0.0, 1.0 }
KSI_switch.output = { 0.0, 1.0 }

KSI_adjust_button = CreateGauge("parameter")
KSI_adjust_button.parameter_name = "KSI_adjust_button"
KSI_adjust_button.arg_number = 258
KSI_adjust_button.input = { 0.0, 1.0 }
KSI_adjust_button.output = { 0.0, 1.0 }

KSI_course_indicator = CreateGauge("parameter")
KSI_course_indicator.parameter_name = "KSI_course_indicator"
KSI_course_indicator.arg_number = 111
KSI_course_indicator.input = { 0.0, math.pi * 2.0 }
KSI_course_indicator.output = { 0.0, 1.0}

KSI_course_set_needle = CreateGauge("parameter")
KSI_course_set_needle.parameter_name = "KSI_course_set_needle"
KSI_course_set_needle.arg_number = 68
KSI_course_set_needle.input = { 0.0, math.pi * 2.0 }
KSI_course_set_needle.output = { 0.0, 1.0 }


-- RSBN subgroup -------------------------------------------------------------------------------------------------------------------------

RSBN_switch = CreateGauge("parameter")
RSBN_switch.parameter_name = "RSBN_switch"
RSBN_switch.arg_number = 176
RSBN_switch.input = { 0.0, 1.0 }
RSBN_switch.output = { 0.0, 1.0 }

RSBN_azimut_korekcija_LIGHT = CreateGauge("parameter")
RSBN_azimut_korekcija_LIGHT.parameter_name = "RSBN_azimut_korekcija_LIGHT"
RSBN_azimut_korekcija_LIGHT.arg_number = 548
RSBN_azimut_korekcija_LIGHT.input = { 0.0, 1.0 }
RSBN_azimut_korekcija_LIGHT.output = { 0.0, 1.0 }

RSBN_dalnost_korekcija_LIGHT = CreateGauge("parameter")
RSBN_dalnost_korekcija_LIGHT.parameter_name = "RSBN_dalnost_korekcija_LIGHT"
RSBN_dalnost_korekcija_LIGHT.arg_number = 549
RSBN_dalnost_korekcija_LIGHT.input = { 0.0, 1.0 }
RSBN_dalnost_korekcija_LIGHT.output = { 0.0, 1.0 }

RSBN_distance_meter = CreateGauge("parameter")
RSBN_distance_meter.parameter_name = "RSBN_distance_meter"
RSBN_distance_meter.arg_number = 417 
RSBN_distance_meter.input = { 0.0, 200.0 } 
RSBN_distance_meter.output = { 0.0, 1.0 }

RSBN_distance_meter_Hundreds = CreateGauge("parameter")
RSBN_distance_meter_Hundreds.parameter_name = "RSBN_distance_meter_Hundreds"
RSBN_distance_meter_Hundreds.arg_number = 355 
RSBN_distance_meter_Hundreds.input = { 0.0, 10.0 } 
RSBN_distance_meter_Hundreds.output = { 0.0, 1.0 }

RSBN_distance_meter_Tens = CreateGauge("parameter")
RSBN_distance_meter_Tens.parameter_name = "RSBN_distance_meter_Tens"
RSBN_distance_meter_Tens.arg_number = 356 
RSBN_distance_meter_Tens.input = { 0.0, 10.0 } 
RSBN_distance_meter_Tens.output = { 0.0, 1.0 }

RSBN_distance_meter_Singles = CreateGauge("parameter")
RSBN_distance_meter_Singles.parameter_name = "RSBN_distance_meter_Singles"
RSBN_distance_meter_Singles.arg_number = 357
RSBN_distance_meter_Singles.input = { 0.0, 10.0 } 
RSBN_distance_meter_Singles.output = { 0.0, 1.0 }

RSBN_NPP_kurs_blinker = CreateGauge("parameter")
RSBN_NPP_kurs_blinker.parameter_name = "RSBN_NPP_kurs_blinker"
RSBN_NPP_kurs_blinker.arg_number = 587
RSBN_NPP_kurs_blinker.input = { 0.0, 1.0 }
RSBN_NPP_kurs_blinker.output = { 0.0, 1.0 }

RSBN_NPP_glisada_blinker = CreateGauge("parameter")
RSBN_NPP_glisada_blinker.parameter_name = "RSBN_NPP_glisada_blinker"
RSBN_NPP_glisada_blinker.arg_number = 588
RSBN_NPP_glisada_blinker.input = { 0.0, 1.0 }
RSBN_NPP_glisada_blinker.output = { 0.0, 1.0 }

RSBN_NPP_kurs_needle = CreateGauge("parameter") 
RSBN_NPP_kurs_needle.parameter_name = "RSBN_NPP_kurs_needle"
RSBN_NPP_kurs_needle.arg_number = 590
RSBN_NPP_kurs_needle.input = { -1.0, 1.0 }
RSBN_NPP_kurs_needle.output = { -1.0, 1.0 }

RSBN_NPP_glisada_needle = CreateGauge("parameter") 
RSBN_NPP_glisada_needle.parameter_name = "RSBN_NPP_glisada_needle"
RSBN_NPP_glisada_needle.arg_number = 589
RSBN_NPP_glisada_needle.input = { -1.0, 1.0 }
RSBN_NPP_glisada_needle.output = { -1.0, 1.0 }

RSBN_KPP_kren_blinker = CreateGauge("parameter")
RSBN_KPP_kren_blinker.parameter_name = "RSBN_KPP_kren_blinker"
RSBN_KPP_kren_blinker.arg_number = 567
RSBN_KPP_kren_blinker.input = { 0.0, 1.0 }
RSBN_KPP_kren_blinker.output = { 0.0, 1.0 }

RSBN_KPP_tangaz_blinker = CreateGauge("parameter")
RSBN_KPP_tangaz_blinker.parameter_name = "RSBN_KPP_tangaz_blinker"
RSBN_KPP_tangaz_blinker.arg_number = 568
RSBN_KPP_tangaz_blinker.input = { 0.0, 1.0 }
RSBN_KPP_tangaz_blinker.output = { 0.0, 1.0 }

RSBN_KPP_kurs_director = CreateGauge("parameter") 
RSBN_KPP_kurs_director.parameter_name = "RSBN_KPP_kurs_director"
RSBN_KPP_kurs_director.arg_number = 565
RSBN_KPP_kurs_director.input = { -1.0, 1.0 }
RSBN_KPP_kurs_director.output = { -1.0, 1.0 }

RSBN_KPP_glisada_director = CreateGauge("parameter") 
RSBN_KPP_glisada_director.parameter_name = "RSBN_KPP_glisada_director"
RSBN_KPP_glisada_director.arg_number = 566
RSBN_KPP_glisada_director.input = { -1.0, 1.0 }
RSBN_KPP_glisada_director.output = { -1.0, 1.0 }

RSBN_ARK_needle_selector = CreateGauge("parameter") 
RSBN_ARK_needle_selector.parameter_name = "RSBN_ARK_needle_selector"
RSBN_ARK_needle_selector.arg_number = 340
RSBN_ARK_needle_selector.input = { 0.0, 1.0 }
RSBN_ARK_needle_selector.output = { 0.0, 1.0 }

--/N/ ARK subgroup -------------------------------------------------------------------------------------------------------------------------

ARK_switch = CreateGauge("parameter")
ARK_switch.parameter_name = "ARK_switch"
ARK_switch.arg_number = 174 
ARK_switch.input = { 0.0, 1.0 }
ARK_switch.output = { 0.0, 1.0 }

ARK_dal_bliz_selector = CreateGauge("parameter")
ARK_dal_bliz_selector.parameter_name = "ARK_dal_bliz_selector"
ARK_dal_bliz_selector.arg_number = 254 
ARK_dal_bliz_selector.input = { 0.0, 1.0 } 
ARK_dal_bliz_selector.output = { 0.0, 1.0 }


ARK_RSBN_needle = CreateGauge("parameter")
ARK_RSBN_needle.parameter_name = "ARK_RSBN_needle"
ARK_RSBN_needle.arg_number = 36 
ARK_RSBN_needle.input = { 0.0, math.pi * 2.0 }
ARK_RSBN_needle.output = { 0.0, 1.0 }

-- Radio-altimeter subgroup -------------------------------------------------------------------------------------------------------------------------

RADIO_ALTIMETER_MARKER_switch = CreateGauge("parameter")
RADIO_ALTIMETER_MARKER_switch.parameter_name = "RADIO_ALTIMETER_MARKER_switch"
RADIO_ALTIMETER_MARKER_switch.arg_number = 175 
RADIO_ALTIMETER_MARKER_switch.input = { 0.0, 1.0 }  
RADIO_ALTIMETER_MARKER_switch.output = { 0.0, 1.0 } 

RADIO_ALTIMETER_indicator = CreateGauge("parameter")
RADIO_ALTIMETER_indicator.parameter_name = "RADIO_ALTIMETER_indicator"
RADIO_ALTIMETER_indicator.arg_number = 103 
RADIO_ALTIMETER_indicator.input = { 0.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0, 100.0, 150.0, 200.0, 250.0, 300.0, 400.0, 500.0, 600.0, 1000.0 } 
RADIO_ALTIMETER_indicator.output = { 0.0, 0.038, 0.0653, 0.102, 0.1253, 0.1752, 0.206, 0.241, 0.257, 0.293, 0.318, 0.465, 0.589, 0.675, 0.729, 0.805, 0.862, 0.905, 1.0 }

LOW_ALT_LIGHT = CreateGauge("parameter")
LOW_ALT_LIGHT.parameter_name = "LOW_ALT_LIGHT"
LOW_ALT_LIGHT.arg_number = 500 
LOW_ALT_LIGHT.input = { 0.0, 1.0 } 
LOW_ALT_LIGHT.output = { 0.0, 1.0 }

-- UUA and SUA subgroup -------------------------------------------------------------------------------------------------------------------------

UUA_indicator = CreateGauge("parameter")
UUA_indicator.parameter_name = "UUA_indicator"
UUA_indicator.arg_number = 105
UUA_indicator.input = { -0.174533, -0.087267, 0.0, 0.087267, 0.17453, 0.2918, 0.349, 0.4363, 0.5236, 0.61087 } 
UUA_indicator.output = { -0.30, -0.14, 0.0, 0.153, 0.290, 0.430, 0.570, 0.707, 0.850, 1.0 } 

AOA_WARNING_LIGHT = CreateGauge("parameter")
AOA_WARNING_LIGHT.parameter_name = "AOA_WARNING_LIGHT"
AOA_WARNING_LIGHT.arg_number = 537
AOA_WARNING_LIGHT.input = { 0.0, 1.0 } 
AOA_WARNING_LIGHT.output = { 0.0, 1.0 }

---DA-200 subgroup -------------------------------------------------------------------------------------------------------------------------
DA200_TurnNeedle = CreateGauge("parameter")
DA200_TurnNeedle.parameter_name = "DA200_TurnNeedle"
DA200_TurnNeedle.arg_number = 107
DA200_TurnNeedle.input = { -0.04433, 0.04433 }
DA200_TurnNeedle.output = { 1.0, -1.0 }

DA200_VerticalVelocity = CreateGauge("parameter")
DA200_VerticalVelocity.parameter_name = "DA200_VerticalVelocity"
DA200_VerticalVelocity.arg_number = 106
DA200_VerticalVelocity.input = { -400.0, -200.0, -100.0, -50.0, -20.0, -10.0, 0.0, 10.0, 20.0, 50.0, 100.0, 200.0, 400.0 }
DA200_VerticalVelocity.output = { -1.0, -0.875, -0.749, -0.57, -0.492, -0.238, 0.016, 0.257, 0.499, 0.568, 0.749, 0.871, 1.0 }

DA200_Slipball = CreateGauge("parameter")
DA200_Slipball.parameter_name = "DA200_SLIPBALL"
DA200_Slipball.arg_number = 31
DA200_Slipball.input = { -1.0, 1.0 }
DA200_Slipball.output = { -1.0, 1.0 }

KPP_switch = CreateGauge("parameter")
KPP_switch.parameter_name = "KPP_switch"
KPP_switch.arg_number = 177
KPP_switch.input = { 0.0, 1.0 } 
KPP_switch.output = { 0.0, 1.0 }

KPP_ARRETIR = CreateGauge("parameter")
KPP_ARRETIR.parameter_name = "KPP_ARRETIR"
KPP_ARRETIR.arg_number = 259
KPP_ARRETIR.input = { 0.0, 1.0 } 
KPP_ARRETIR.output = { 0.0, 1.0 }

KPP_ARRETIR_light = CreateGauge("parameter")
KPP_ARRETIR_light.parameter_name = "KPP_ARRETIR_light"
KPP_ARRETIR_light.arg_number = 535
KPP_ARRETIR_light.input = { 0.0, 1.0 } 
KPP_ARRETIR_light.output = { 0.0, 1.0 }

KPP_Bank = CreateGauge("parameter")
KPP_Bank.parameter_name = "KPP_Bank"
KPP_Bank.arg_number = 108
KPP_Bank.input = { 0.0, 2.0 * math.pi }
KPP_Bank.output = { -1.0, 1.0 }

KPP_Pitch = CreateGauge("parameter")
KPP_Pitch.parameter_name = "KPP_Pitch"
KPP_Pitch.arg_number = 109
KPP_Pitch.input = { -1.5708, 1.5708 } 
KPP_Pitch.output = { -1.0, 1.0 }

--ACCELEROMETER == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==  

ACCELEROMETER = CreateGauge("parameter")
ACCELEROMETER.parameter_name = "ACCELEROMETER"
ACCELEROMETER.arg_number = 110
--[[
ACCELEROMETER.input = { -5.0, 1.0, 5.0, 8.0, 10.0 } 
ACCELEROMETER.output = { -0.41, 0.096, 0.5, 0.81, 1.0 }
]]
ACCELEROMETER.input = { -5.0, -4.0, -3.0, -2.0, -1.0, 0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 10.02 } 
ACCELEROMETER.output = { -0.394, -0.309, -0.238, -0.160, -0.081, 0.0, 0.088, 0.187, 0.290, 0.388, 0.492, 0.603, 0.702, 0.802, 0.902, 0.993, 1.0 }


RESET_G_needle = CreateGauge("parameter")
RESET_G_needle.parameter_name = "RESET_G"
RESET_G_needle.arg_number = 228 
RESET_G_needle.input = { 0.0, 1.0 } 
RESET_G_needle.output = { 0.0, 1.0 }

MAX_G_needle = CreateGauge("parameter")
MAX_G_needle.parameter_name = "MAX_G"
MAX_G_needle.arg_number = 113
MAX_G_needle.input = { 1.0, 10.0 }
MAX_G_needle.output = { 0.0, 1.0 }

MIN_G_needle = CreateGauge("parameter")
MIN_G_needle.parameter_name = "MIN_G"
MIN_G_needle.arg_number = 114
MIN_G_needle.input = { -5.0, 1.0 }
MIN_G_needle.output = { 0.0, 1.0 }

--TRIMMER == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

TRIMMER_switch = CreateGauge("parameter")
TRIMMER_switch.parameter_name = "TRIMMER_switch"
TRIMMER_switch.arg_number = 172
TRIMMER_switch.input = { 0.0, 1.0 }
TRIMMER_switch.output = { 0.0, 1.0 }

TRIMMER_light = CreateGauge("parameter")
TRIMMER_light.parameter_name = "TRIMMER_light"
TRIMMER_light.arg_number = 519
TRIMMER_light.input = { 0.0, 1.0 }
TRIMMER_light.output = { 0.0, 1.0 }

--PITOT TUBES == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

PITOT_TUBES_SELECTOR = CreateGauge("parameter")
PITOT_TUBES_SELECTOR.parameter_name = "PITOT_TUBES_SELECTOR"
PITOT_TUBES_SELECTOR.arg_number = 229
PITOT_TUBES_SELECTOR.input = { 0.0, 1.0 }
PITOT_TUBES_SELECTOR.output = { 0.0, 1.0 }  

PITOT_TUBES_HEATING_main = CreateGauge("parameter")
PITOT_TUBES_HEATING_main.parameter_name = "PITOT_TUBES_HEATING_main"
PITOT_TUBES_HEATING_main.arg_number = 279
PITOT_TUBES_HEATING_main.input = { 0.0, 1.0 } 
PITOT_TUBES_HEATING_main.output = { 0.0, 1.0 } 

PITOT_TUBES_HEATING_aux = CreateGauge("parameter")
PITOT_TUBES_HEATING_aux.parameter_name = "PITOT_TUBES_HEATING_aux"
PITOT_TUBES_HEATING_aux.arg_number = 280
PITOT_TUBES_HEATING_aux.input = { 0.0, 1.0 } 
PITOT_TUBES_HEATING_aux.output = { 0.0, 1.0 }  

PITOT_TUBES_STATUS = CreateGauge("parameter")
PITOT_TUBES_STATUS.parameter_name = "PITOT_TUBES_STATUS"
PITOT_TUBES_STATUS.arg_number = 406
PITOT_TUBES_STATUS.input = { 0.0, 1.0 } 
PITOT_TUBES_STATUS.output = { 0.0, 1.0 }  

-- FREEZING EFFECTS == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

FREEZING_level = CreateGauge("parameter")
FREEZING_level.parameter_name = "FREEZING_level"
FREEZING_level.arg_number = 410
FREEZING_level.input = { 0.0, 100.0 }
FREEZING_level.output = { 0.0, 1.0 } 

FREEZING_level_absolute = CreateGauge("parameter")
FREEZING_level_absolute.parameter_name = "FREEZING_level_absolute"
FREEZING_level_absolute.arg_number = 410
FREEZING_level_absolute.input = { 0.0, 100.0 } 
FREEZING_level_absolute.output = { 0.0, 1.0 } 

FREEZING_EFFECTS_canopy = CreateGauge("parameter")
FREEZING_EFFECTS_canopy.parameter_name = "FREEZING_EFFECTS_canopy"
FREEZING_EFFECTS_canopy.arg_number = 543
FREEZING_EFFECTS_canopy.input = { 0.0, 100.0 } 
FREEZING_EFFECTS_canopy.output = { 0.0, 1.0 } 

--/N/ DC bus == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

DC_BUS_V_needle = CreateGauge("parameter")
DC_BUS_V_needle.parameter_name = "DC_BUS_V_needle"
DC_BUS_V_needle.arg_number = 124
DC_BUS_V_needle.input = { 0.0, 30.0 }
DC_BUS_V_needle.output = { 0.0, 1.0 }

DC_BUS_battery = CreateGauge("parameter")
DC_BUS_battery.parameter_name = "DC_BUS_battery"
DC_BUS_battery.arg_number = 165
DC_BUS_battery.input = { 0.0, 1.0 } 
DC_BUS_battery.output = { 0.0, 1.0 } 

DC_BUS_battery_heat = CreateGauge("parameter")
DC_BUS_battery_heat.parameter_name = "DC_BUS_battery_heat"
DC_BUS_battery_heat.arg_number = 155
DC_BUS_battery_heat.input = { 0.0, 1.0 } 
DC_BUS_battery_heat.output = { 0.0, 1.0 } 

DC_GENERATOR_LIGHT = CreateGauge("parameter")
DC_GENERATOR_LIGHT.parameter_name = "DC_GEN_LIGHT"
DC_GENERATOR_LIGHT.arg_number = 510
DC_GENERATOR_LIGHT.input = { 0.0, 1.0 } 
DC_GENERATOR_LIGHT.output = { 0.0, 1.0 }

DC_GENERATOR = CreateGauge("parameter")
DC_GENERATOR.parameter_name = "DC_GEN"
DC_GENERATOR.arg_number = 166--16666 
DC_GENERATOR.input = { 0.0, 1.0 } 
DC_GENERATOR.output = { 0.0, 1.0 }

DC_BUS = CreateGauge("parameter")
DC_BUS.parameter_name = "DC_BUS"
DC_BUS.arg_number = 563
DC_BUS.input = { 0.0, 2.0 }
DC_BUS.output = { 0.0, 2.0 }

DC_BUS_ISA_K = CreateGauge("parameter")
DC_BUS_ISA_K.parameter_name = "DC_BUS_ISA_K"
DC_BUS_ISA_K.arg_number = 55
DC_BUS_ISA_K.input = { 0.0, 100.0 }
DC_BUS_ISA_K.output = { 0.0, 1.0 } 

--/N/ AC bus == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==  

AC_BUS = CreateGauge("parameter")
AC_BUS.parameter_name = "AC_BUS"
AC_BUS.arg_number = 564
AC_BUS.input = { 0.0, 2.0 }
AC_BUS.output = { 0.0, 2.0 }

AC_BUS_PO7501 = CreateGauge("parameter")
AC_BUS_PO7501.parameter_name = "AC_BUS_PO7501"
AC_BUS_PO7501.arg_number = 153 --15366
AC_BUS_PO7501.input = { 0.0, 1.0 } 
AC_BUS_PO7501.output = { 0.0, 1.0 } 

AC_BUS_PO7502 = CreateGauge("parameter")
AC_BUS_PO7502.parameter_name = "AC_BUS_PO7502"
AC_BUS_PO7502.arg_number = 154 --15466
AC_BUS_PO7502.input = { 0.0, 1.0 }
AC_BUS_PO7502.output = { 0.0, 1.0 } 

AC_BUS_Emerg_Inverter = CreateGauge("parameter")
AC_BUS_Emerg_Inverter.parameter_name = "AC_BUS_Emerg_Inverter"
AC_BUS_Emerg_Inverter.arg_number = 164 --16466
AC_BUS_Emerg_Inverter.input = { 0.0, 1.0 } 
AC_BUS_Emerg_Inverter.output = { 0.0, 1.0 } 

AC_GENERATOR = CreateGauge("parameter")
AC_GENERATOR.parameter_name = "AC_GEN"
AC_GENERATOR.arg_number = 169 --16966
AC_GENERATOR.input = { 0.0, 1.0 } 
AC_GENERATOR.output = { 0.0, 1.0 }

AC_GENERATOR_LIGHT = CreateGauge("parameter")
AC_GENERATOR_LIGHT.parameter_name = "AC_GEN_LIGHT"
AC_GENERATOR_LIGHT.arg_number = 511
AC_GENERATOR_LIGHT.input = { 0.0, 1.0 } 
AC_GENERATOR_LIGHT.output = { 0.0, 1.0 }

--/N/ FUEL PUMPS & FUEL SYSTEM == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

FUEL_PUMP_3 = CreateGauge("parameter")
FUEL_PUMP_3.parameter_name = "FUEL_PUMP_3"
FUEL_PUMP_3.arg_number = 159 
FUEL_PUMP_3.input = { 0.0, 1.0 } 
FUEL_PUMP_3.output = { 0.0, 1.0 } 

FUEL_PUMP_1 = CreateGauge("parameter")
FUEL_PUMP_1.parameter_name = "FUEL_PUMP_1"
FUEL_PUMP_1.arg_number = 160 
FUEL_PUMP_1.input = { 0.0, 1.0 } 
FUEL_PUMP_1.output = { 0.0, 1.0 } 

FUEL_PUMP_RASHOD = CreateGauge("parameter")
FUEL_PUMP_RASHOD.parameter_name = "FUEL_PUMP_RASHOD"
FUEL_PUMP_RASHOD.arg_number = 161
FUEL_PUMP_RASHOD.input = { 0.0, 1.0 } 
FUEL_PUMP_RASHOD.output = { 0.0, 1.0 } 

FUEL_PRESSURE = CreateGauge("parameter")
FUEL_PRESSURE.parameter_name = "FUEL_PRESSURE"
FUEL_PRESSURE.arg_number = 402
FUEL_PRESSURE.input = { 0.0, 45.0 } 
FUEL_PRESSURE.output = { 0.0, 45.0 } 

FUEL_METER = CreateGauge("parameter") 
FUEL_METER.parameter_name = "FUEL_METER"
FUEL_METER.arg_number = 52
FUEL_METER.input = { 0.0, 1000.0, 2000.0, 3000.0, 4000.0, 6000.0 }--1
FUEL_METER.output = { 0.0, 0.173, 0.330, 0.485, 0.642, 1.0 } 

--FUEL LIGHTS (in connection with previous) == == == == == == == == == == == == == == == == == == == == == == == == == 

FUEL_LIGHT_FUELPODC = CreateGauge("parameter")
FUEL_LIGHT_FUELPODC.parameter_name = "FUEL_PODC"
FUEL_LIGHT_FUELPODC.arg_number = 501 
FUEL_LIGHT_FUELPODC.input = { 0.0, 1.0 } 
FUEL_LIGHT_FUELPODC.output = { 0.0, 1.0 }

FUEL_LIGHT_1GR = CreateGauge("parameter")
FUEL_LIGHT_1GR.parameter_name = "FUEL_1GR"
FUEL_LIGHT_1GR.arg_number = 502 
FUEL_LIGHT_1GR.input = { 0.0, 1.0 } 
FUEL_LIGHT_1GR.output = { 0.0, 1.0 }

FUEL_LIGHT_450 = CreateGauge("parameter")
FUEL_LIGHT_450.parameter_name = "FUEL_450"
FUEL_LIGHT_450.arg_number = 503 
FUEL_LIGHT_450.input = { 0.0, 1.0 } 
FUEL_LIGHT_450.output = { 0.0, 1.0 }

FUEL_LIGHT_3GR = CreateGauge("parameter")
FUEL_LIGHT_3GR.parameter_name = "FUEL_3GR"
FUEL_LIGHT_3GR.arg_number = 504 
FUEL_LIGHT_3GR.input = { 0.0, 1.0 } 
FUEL_LIGHT_3GR.output = { 0.0, 1.0 }

FUEL_LIGHT_FUELPODW = CreateGauge("parameter")
FUEL_LIGHT_FUELPODW.parameter_name = "FUEL_PODW"
FUEL_LIGHT_FUELPODW.arg_number = 505
FUEL_LIGHT_FUELPODW.input = { 0.0, 1.0 } 
FUEL_LIGHT_FUELPODW.output = { 0.0, 1.0 }

FUEL_LIGHT_RASHOD = CreateGauge("parameter")
FUEL_LIGHT_RASHOD.parameter_name = "FUEL_RASHOD"
FUEL_LIGHT_RASHOD.arg_number = 506
FUEL_LIGHT_RASHOD.input = { 0.0, 1.0 } 
FUEL_LIGHT_RASHOD.output = { 0.0, 1.0 }

--ENGINE START DEVICE == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

ENGINE_START_DEVICE_STATUS = CreateGauge("parameter")
ENGINE_START_DEVICE_STATUS.parameter_name = "ENGINE_START_DEVICE_STATUS"
ENGINE_START_DEVICE_STATUS.arg_number = 403
ENGINE_START_DEVICE_STATUS.input = { -1.0, 0.0, 1.0, 2.0 } 
ENGINE_START_DEVICE_STATUS.output = { -1.0, 0.0, 1.0, 2.0 }

START_DEVICE_ZAZIG_LIGHT = CreateGauge("parameter")
START_DEVICE_ZAZIG_LIGHT.parameter_name = "START_DEVICE_ZAZIG_LIGHT"
START_DEVICE_ZAZIG_LIGHT.arg_number = 509
START_DEVICE_ZAZIG_LIGHT.input = { 0.0, 1.0 } 
START_DEVICE_ZAZIG_LIGHT.output = { 0.0, 1.0 } 

ENGINE_OXYGENE_STATUS = CreateGauge("parameter")
ENGINE_OXYGENE_STATUS.parameter_name = "ENGINE_OXYGENE_STATUS"
ENGINE_OXYGENE_STATUS.arg_number = 415
ENGINE_OXYGENE_STATUS.input = { 0.0, 100.0 } 
ENGINE_OXYGENE_STATUS.output = { 0.0, 1.0 } 

ENGINE_OXYGENE_manometer = CreateGauge("parameter")
ENGINE_OXYGENE_manometer.parameter_name = "ENGINE_OXYGENE_manometer"
ENGINE_OXYGENE_manometer.arg_number = 61
ENGINE_OXYGENE_manometer.input = { 0.0, 40.0 }
ENGINE_OXYGENE_manometer.output = { 0.0, 1.0 }

ENGINE_START_DEVICE_ZAZIG_SWITCH = CreateGauge("parameter")
ENGINE_START_DEVICE_ZAZIG_SWITCH.parameter_name = "ENGINE_START_DEVICE_ZAZIG_SWITCH"
ENGINE_START_DEVICE_ZAZIG_SWITCH.arg_number = 302
ENGINE_START_DEVICE_ZAZIG_SWITCH.input = { 0.0, 1.0 }
ENGINE_START_DEVICE_ZAZIG_SWITCH.output = { 0.0, 1.0 }

ENGINE_START_DEVICE_NCSTART_SWITCH = CreateGauge("parameter")
ENGINE_START_DEVICE_NCSTART_SWITCH.parameter_name = "ENGINE_START_DEVICE_NCSTART_SWITCH"
ENGINE_START_DEVICE_NCSTART_SWITCH.arg_number = 288
ENGINE_START_DEVICE_NCSTART_SWITCH.input = { 0.0, 1.0 }
ENGINE_START_DEVICE_NCSTART_SWITCH.output = { 0.0, 1.0 }

ENGINE_START_DEVICE_AIR_START_SWITCH = CreateGauge("parameter")
ENGINE_START_DEVICE_AIR_START_SWITCH.parameter_name = "ENGINE_START_DEVICE_AIR_START_SWITCH"
ENGINE_START_DEVICE_AIR_START_SWITCH.arg_number = 301
ENGINE_START_DEVICE_AIR_START_SWITCH.input = { 0.0, 1.0 }
ENGINE_START_DEVICE_AIR_START_SWITCH.output = { 0.0, 1.0 }

ENGINE_START_DEVICE_START_BUTTON = CreateGauge("parameter")
ENGINE_START_DEVICE_START_BUTTON.parameter_name = "ENGINE_START_DEVICE_START_BUTTON"
ENGINE_START_DEVICE_START_BUTTON.arg_number = 289
ENGINE_START_DEVICE_START_BUTTON.input = { 0.0, 1.0 }
ENGINE_START_DEVICE_START_BUTTON.output = { 0.0, 1.0 }

-- ENGINE and THROTTLE == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==  

SPS_state = CreateGauge("parameter")
SPS_state.parameter_name = "SPS_state"
SPS_state.arg_number = 624 
SPS_state.input = { 0.0, 1.0 }
SPS_state.output = { 0.0, 1.0 }

KONUS_efficiency = CreateGauge("parameter")
KONUS_efficiency.parameter_name = "KONUS_efficiency"
KONUS_efficiency.arg_number = 625 
KONUS_efficiency.input = { 0.0, 1.0 } 
KONUS_efficiency.output = { 0.0, 1.0 }	

SOPLO_efficiency = CreateGauge("parameter")
SOPLO_efficiency.parameter_name = "SOPLO_efficiency"
SOPLO_efficiency.arg_number = 626 
SOPLO_efficiency.input = { 0.0, 1.0 } 
SOPLO_efficiency.output = { 0.0, 1.0 }

ENGINE_RPM = CreateGauge("parameter")
ENGINE_RPM.parameter_name = "ENGINE_RPM"
ENGINE_RPM.arg_number = 50
ENGINE_RPM.input = { 0.0, 110.0 }
ENGINE_RPM.output = { 0.0, 1.0 }

ENGINE_RPM2 = CreateGauge("parameter")
ENGINE_RPM2.parameter_name = "ENGINE_RPM2"
ENGINE_RPM2.arg_number = 670
ENGINE_RPM2.input = { 0.0, 110.0 }
ENGINE_RPM2.output = { 0.0, 1.0 }

ENGINE_TEMP = CreateGauge("parameter")
ENGINE_TEMP.parameter_name = "ENGINE_TEMPERATURE"
ENGINE_TEMP.arg_number = 51
ENGINE_TEMP.input = { 300.0, 400.0, 500.0, 600.0, 650.0, 700.0, 750.0, 800.0, 850.0, 900.0 } 
ENGINE_TEMP.output = { 0.0, 0.107, 0.244, 0.381, 0.505, 0.629, 0.733, 0.850, 0.935, 1.00 }

ENGINE_STRESS= CreateGauge("parameter")
ENGINE_STRESS.parameter_name = "ENGINE_STRESS"
ENGINE_STRESS.arg_number = 404
ENGINE_STRESS.input = { 0.0, 100.0 }
ENGINE_STRESS.output = { 0.0, 100.0 }

FORSAZ_1_LIGHT = CreateGauge("parameter")
FORSAZ_1_LIGHT.parameter_name = "FORSAZ_1_LIGHT"
FORSAZ_1_LIGHT.arg_number = 507
FORSAZ_1_LIGHT.input = { 0.0, 1.0 } 
FORSAZ_1_LIGHT.output = { 0.0, 1.0 }

FORSAZ_2_LIGHT = CreateGauge("parameter")
FORSAZ_2_LIGHT.parameter_name = "FORSAZ_2_LIGHT"
FORSAZ_2_LIGHT.arg_number = 508
FORSAZ_2_LIGHT.input = { 0.0, 1.0 } 
FORSAZ_2_LIGHT.output = { 0.0, 1.0 }

NOZZLE_LIGHT = CreateGauge("parameter")
NOZZLE_LIGHT.parameter_name = "NOZZLE_LIGHT"
NOZZLE_LIGHT.arg_number = 512
NOZZLE_LIGHT.input = { 0.0, 1.0 } 
NOZZLE_LIGHT.output = { 0.0, 1.0 }

KONUS_LIGHT = CreateGauge("parameter")
KONUS_LIGHT.parameter_name = "KONUS_LIGHT"
KONUS_LIGHT.arg_number = 517
KONUS_LIGHT.input = { 0.0, 1.0 } 
KONUS_LIGHT.output = { 0.0, 1.0 }

OIL_LIGHT = CreateGauge("parameter")
OIL_LIGHT.parameter_name = "OIL_LIGHT"
OIL_LIGHT.arg_number = 513
OIL_LIGHT.input = { 0.0, 1.0 } 
OIL_LIGHT.output = { 0.0, 1.0 }

OIL_PRESSURE = CreateGauge("parameter")
OIL_PRESSURE.parameter_name = "OIL_PRESSURE"
OIL_PRESSURE.arg_number = 627 
OIL_PRESSURE.input = { 0.0, 4.0, 8.0 } 
OIL_PRESSURE.output = { 0.0, 0.51, 1.0 }

FIRE_LIGHT = CreateGauge("parameter")
FIRE_LIGHT.parameter_name = "FIRE_LIGHT"
FIRE_LIGHT.arg_number = 534
FIRE_LIGHT.input = { 0.0, 1.0 } 
FIRE_LIGHT.output = { 0.0, 1.0 }

ENGINE_SURGE_DOORS_POZITION = CreateGauge("parameter")
ENGINE_SURGE_DOORS_POZITION.parameter_name = "ENGINE_SURGE_DOORS_POZITION"
ENGINE_SURGE_DOORS_POZITION.arg_number = 405 
ENGINE_SURGE_DOORS_POZITION.input = { -1.0, 0.0, 1.0 }
ENGINE_SURGE_DOORS_POZITION.output = { -1.0, 0.0, 1.0 }

-- GIDRO == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

PRIMARY_GIDRO_Pressure = CreateGauge("parameter")
PRIMARY_GIDRO_Pressure.parameter_name = "GIDRO_PRESS_P"
PRIMARY_GIDRO_Pressure.arg_number = 418
PRIMARY_GIDRO_Pressure.input = { 0.0, 300.0 }
PRIMARY_GIDRO_Pressure.output = { 0.0, 1.0 }

SECONDARY_GIDRO_Pressure = CreateGauge("parameter")
SECONDARY_GIDRO_Pressure.parameter_name = "GIDRO_PRESS_S"
SECONDARY_GIDRO_Pressure.arg_number = 419
SECONDARY_GIDRO_Pressure.input = { 0.0, 300.0 }
SECONDARY_GIDRO_Pressure.output = { 0.0, 1.0 }

PRIMARY_GIDRO_Pressure_needle = CreateGauge("parameter")
PRIMARY_GIDRO_Pressure_needle.parameter_name = "GIDRO_PRESS_P_needle"
PRIMARY_GIDRO_Pressure_needle.arg_number = 126
PRIMARY_GIDRO_Pressure_needle.input = { 0.0, 300.0 }
PRIMARY_GIDRO_Pressure_needle.output = { 0.0, 1.0 } 

SECONDARY_GIDRO_Pressure_needle = CreateGauge("parameter")
SECONDARY_GIDRO_Pressure_needle.parameter_name = "GIDRO_PRESS_S_needle"
SECONDARY_GIDRO_Pressure_needle.arg_number = 125
SECONDARY_GIDRO_Pressure_needle.input = { 0.0, 300.0 }
SECONDARY_GIDRO_Pressure_needle.output = { 0.0, 1.0 }

GIDRO_NR27_switch = CreateGauge("parameter")
GIDRO_NR27_switch.parameter_name = "GIDRO_NR27_switch"
GIDRO_NR27_switch.arg_number = 171
GIDRO_NR27_switch.input = { 0.0, 1.0 }
GIDRO_NR27_switch.output = { 0.0, 1.0 } 

GIDRO_ailerones_busters_switch = CreateGauge("parameter")
GIDRO_ailerones_busters_switch.parameter_name = "GIDRO_ailerones_busters_switch"
GIDRO_ailerones_busters_switch.arg_number = 319
GIDRO_ailerones_busters_switch.input = { 0.0, 1.0 }
GIDRO_ailerones_busters_switch.output = { 0.0, 1.0 }

HYDRAULIC_LIGHT = CreateGauge("parameter")
HYDRAULIC_LIGHT.parameter_name = "CHECK_HYDRAULIC_PRESSURE"
HYDRAULIC_LIGHT.arg_number = 515
HYDRAULIC_LIGHT.input = { 0.0, 1.0 } 
HYDRAULIC_LIGHT.output = { 0.0, 1.0 }

BUSTER_LIGHT = CreateGauge("parameter")
BUSTER_LIGHT.parameter_name = "CHECK_BUSTER_PRESSURE"
BUSTER_LIGHT.arg_number = 514
BUSTER_LIGHT.input = { 0.0, 1.0 } 
BUSTER_LIGHT.output = { 0.0, 1.0 }

--HELMET == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

HELMET_heat_man_auto_switch = CreateGauge("parameter")
HELMET_heat_man_auto_switch.parameter_name = "HELMET_heat_man_auto_switch"
HELMET_heat_man_auto_switch.arg_number = 306
HELMET_heat_man_auto_switch.input = { 0.0, 1.0 } 
HELMET_heat_man_auto_switch.output = { 0.0, 1.0 }

HELMET_quick_heat_button = CreateGauge("parameter")
HELMET_quick_heat_button.parameter_name = "HELMET_quick_heat_button"
HELMET_quick_heat_button.arg_number = 310
HELMET_quick_heat_button.input = { 0.0, 1.0 } 
HELMET_quick_heat_button.output = { 0.0, 1.0 }

HELMET_visor_switch = CreateGauge("parameter")
HELMET_visor_switch.parameter_name = "HELMET_visor_switch"
HELMET_visor_switch.arg_number = 595
HELMET_visor_switch.input = { 0.0, 1.0 } 
HELMET_visor_switch.output = { 0.0, 1.0 }

--AIR CONDITIONING == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 
--[[ //N/ not used
AIR_CONDITION_cockpit_temperature = CreateGauge("parameter")
AIR_CONDITION_cockpit_temperature.parameter_name = "AIR_CONDITION_cockpit_temperature"
AIR_CONDITION_cockpit_temperature.arg_number = 412
AIR_CONDITION_cockpit_temperature.input = { -60.0, 60.0 } 
AIR_CONDITION_cockpit_temperature.output = { -1.0, 1.0 }
]]
-- WARNING LIGHTS == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

CANOPY_WARNING_LIGHT = CreateGauge("parameter")
CANOPY_WARNING_LIGHT.parameter_name = "CANOPY_WARNING_LIGHT"
CANOPY_WARNING_LIGHT.arg_number = 541
CANOPY_WARNING_LIGHT.input = { 0.0, 1.0 } 
CANOPY_WARNING_LIGHT.output = { 0.0, 1.0 }

SORC_LIGHT = CreateGauge("parameter")
SORC_LIGHT.parameter_name = "SORC"
SORC_LIGHT.arg_number = 542
SORC_LIGHT.input = { 0.0, 1.0 } 
SORC_LIGHT.output = { 0.0, 1.0 }

WARNING_LIGHTS_CHECK_STATE = CreateGauge("parameter")
WARNING_LIGHTS_CHECK_STATE.parameter_name = "WARNING_LIGHTS_CHECK_STATE"
WARNING_LIGHTS_CHECK_STATE.arg_number = 407 
WARNING_LIGHTS_CHECK_STATE.input = { 0.0, 1.0 } 
WARNING_LIGHTS_CHECK_STATE.output = { 0.0, 1.0 }

MARKER_LIGHT = CreateGauge("parameter")
MARKER_LIGHT.parameter_name = "MARKER_LIGHT"
MARKER_LIGHT.arg_number = 516
MARKER_LIGHT.input = { 0.0, 1.0 } 
MARKER_LIGHT.output = { 0.0, 1.0 }

STABILISATOR_LIGHT = CreateGauge("parameter")
STABILISATOR_LIGHT.parameter_name = "STABILISATOR_LIGHT"
STABILISATOR_LIGHT.arg_number = 518
STABILISATOR_LIGHT.input = { 0.0, 1.0 } 
STABILISATOR_LIGHT.output = { 0.0, 1.0 }

CHECK_GEAR_LIGHT = CreateGauge("parameter")
CHECK_GEAR_LIGHT.parameter_name = "CHECK_GEAR_LIGHT"
CHECK_GEAR_LIGHT.arg_number = 520
CHECK_GEAR_LIGHT.input = { 0.0, 1.0 } 
CHECK_GEAR_LIGHT.output = { 0.0, 1.0 }

FLAPS_LIGHT = CreateGauge("parameter")
FLAPS_LIGHT.parameter_name = "FLAPS_LIGHT"
FLAPS_LIGHT.arg_number = 521
FLAPS_LIGHT.input = { 0.0, 1.0 } 
FLAPS_LIGHT.output = { 0.0, 1.0 }

AIRBRAKE_LIGHT = CreateGauge("parameter")
AIRBRAKE_LIGHT.parameter_name = "AIRBRAKE_LIGHT"
AIRBRAKE_LIGHT.arg_number = 522
AIRBRAKE_LIGHT.input = { 0.0, 1.0 } 
AIRBRAKE_LIGHT.output = { 0.0, 1.0 }

CENTRAL_PYLON_LIGHT = CreateGauge("parameter")
CENTRAL_PYLON_LIGHT.parameter_name = "CENTRAL_PYLON_LIGHT"
CENTRAL_PYLON_LIGHT.arg_number = 523
CENTRAL_PYLON_LIGHT.input = { 0.0, 1.0 } 
CENTRAL_PYLON_LIGHT.output = { 0.0, 1.0 }

RATO_L_LIGHT = CreateGauge("parameter")
RATO_L_LIGHT.parameter_name = "RATO_L_LIGHT"
RATO_L_LIGHT.arg_number = 524
RATO_L_LIGHT.input = { 0.0, 1.0 } 
RATO_L_LIGHT.output = { 0.0, 1.0 }

RATO_R_LIGHT = CreateGauge("parameter")
RATO_R_LIGHT.parameter_name = "RATO_R_LIGHT"
RATO_R_LIGHT.arg_number = 525
RATO_R_LIGHT.input = { 0.0, 1.0 } 
RATO_R_LIGHT.output = { 0.0, 1.0 }

PYLON_1_ON_LIGHT = CreateGauge("parameter")
PYLON_1_ON_LIGHT.parameter_name = "PYLON_1_ON_LIGHT"
PYLON_1_ON_LIGHT.arg_number = 526
PYLON_1_ON_LIGHT.input = { 0.0, 1.0 } 
PYLON_1_ON_LIGHT.output = { 0.0, 1.0 }

PYLON_2_ON_LIGHT = CreateGauge("parameter")
PYLON_2_ON_LIGHT.parameter_name = "PYLON_2_ON_LIGHT"
PYLON_2_ON_LIGHT.arg_number = 527
PYLON_2_ON_LIGHT.input = { 0.0, 1.0 } 
PYLON_2_ON_LIGHT.output = { 0.0, 1.0 }

PYLON_3_ON_LIGHT = CreateGauge("parameter")
PYLON_3_ON_LIGHT.parameter_name = "PYLON_3_ON_LIGHT"
PYLON_3_ON_LIGHT.arg_number = 528
PYLON_3_ON_LIGHT.input = { 0.0, 1.0 } 
PYLON_3_ON_LIGHT.output = { 0.0, 1.0 }

PYLON_4_ON_LIGHT = CreateGauge("parameter")
PYLON_4_ON_LIGHT.parameter_name = "PYLON_4_ON_LIGHT"
PYLON_4_ON_LIGHT.arg_number = 529
PYLON_4_ON_LIGHT.input = { 0.0, 1.0 } 
PYLON_4_ON_LIGHT.output = { 0.0, 1.0 }

PYLON_1_OFF_LIGHT = CreateGauge("parameter")
PYLON_1_OFF_LIGHT.parameter_name = "PYLON_1_OFF_LIGHT"
PYLON_1_OFF_LIGHT.arg_number = 530
PYLON_1_OFF_LIGHT.input = { 0.0, 1.0 } 
PYLON_1_OFF_LIGHT.output = { 0.0, 1.0 }

PYLON_2_OFF_LIGHT = CreateGauge("parameter")
PYLON_2_OFF_LIGHT.parameter_name = "PYLON_2_OFF_LIGHT"
PYLON_2_OFF_LIGHT.arg_number = 531
PYLON_2_OFF_LIGHT.input = { 0.0, 1.0 } 
PYLON_2_OFF_LIGHT.output = { 0.0, 1.0 }

PYLON_3_OFF_LIGHT = CreateGauge("parameter")
PYLON_3_OFF_LIGHT.parameter_name = "PYLON_3_OFF_LIGHT"
PYLON_3_OFF_LIGHT.arg_number = 532
PYLON_3_OFF_LIGHT.input = { 0.0, 1.0 } 
PYLON_3_OFF_LIGHT.output = { 0.0, 1.0 }

PYLON_4_OFF_LIGHT = CreateGauge("parameter")
PYLON_4_OFF_LIGHT.parameter_name = "PYLON_4_OFF_LIGHT"
PYLON_4_OFF_LIGHT.arg_number = 533
PYLON_4_OFF_LIGHT.input = { 0.0, 1.0 } 
PYLON_4_OFF_LIGHT.output = { 0.0, 1.0 }

-- GIRO DEVICES == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

GIRO_ARRETIR = CreateGauge("parameter")
GIRO_ARRETIR.parameter_name = "GIRO_ARRETIR" 
GIRO_ARRETIR.arg_number = 536
GIRO_ARRETIR.input = { 0.0, 1.0 } 
GIRO_ARRETIR.output = { 0.0, 1.0 }

GIRO_AGD_KSI_SAU_RLS_STATE = CreateGauge("parameter")
GIRO_AGD_KSI_SAU_RLS_STATE.parameter_name = "GIRO_AGD_KSI_SAU_RLS_STATE"
GIRO_AGD_KSI_SAU_RLS_STATE.arg_number = 408
GIRO_AGD_KSI_SAU_RLS_STATE.input = { 0.0, 1.0 } 
GIRO_AGD_KSI_SAU_RLS_STATE.output = { 0.0, 1.0 }

GIRO_DA200_KSI_SAU_RLS_STATE = CreateGauge("parameter")
GIRO_DA200_KSI_SAU_RLS_STATE.parameter_name = "GIRO_DA200_KSI_SAU_RLS_STATE" 
GIRO_DA200_KSI_SAU_RLS_STATE.arg_number = 409
GIRO_DA200_KSI_SAU_RLS_STATE.input = { 0.0, 1.0 } 
GIRO_DA200_KSI_SAU_RLS_STATE.output = { 0.0, 1.0 }

GIRO_AGD_KSI_SAU_RLS_switch = CreateGauge("parameter")
GIRO_AGD_KSI_SAU_RLS_switch.parameter_name = "GIRO_AGD_KSI_SAU_RLS_switch"
GIRO_AGD_KSI_SAU_RLS_switch.arg_number = 162
GIRO_AGD_KSI_SAU_RLS_switch.input = { 0.0, 1.0 } 
GIRO_AGD_KSI_SAU_RLS_switch.output = { 0.0, 1.0 }

GIRO_DA200_KSI_SAU_RLS_switch = CreateGauge("parameter")
GIRO_DA200_KSI_SAU_RLS_switch.parameter_name = "GIRO_DA200_KSI_SAU_RLS_switch"
GIRO_DA200_KSI_SAU_RLS_switch.arg_number = 163
GIRO_DA200_KSI_SAU_RLS_switch.input = { 0.0, 1.0 } 
GIRO_DA200_KSI_SAU_RLS_switch.output = { 0.0, 1.0 }

-- ASP == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==  

ASP_TGT_ACQUIRED_LIGHT = CreateGauge("parameter")
ASP_TGT_ACQUIRED_LIGHT.parameter_name = "ASP_TGT_ACQUIRED_LIGHT"
ASP_TGT_ACQUIRED_LIGHT.arg_number = 539
ASP_TGT_ACQUIRED_LIGHT.input = { 0.0, 1.0 } 
ASP_TGT_ACQUIRED_LIGHT.output = { 0.0, 1.0 }

ASP_LAUNCH = CreateGauge("parameter")
ASP_LAUNCH.parameter_name = "ASP_LAUNCH"
ASP_LAUNCH.arg_number = 538
ASP_LAUNCH.input = { 0.0, 1.0 } 
ASP_LAUNCH.output = { 0.0, 1.0 }

ASP_DISENGAGE = CreateGauge("parameter")
ASP_DISENGAGE.parameter_name = "ASP_DISENGAGE"
ASP_DISENGAGE.arg_number = 540
ASP_DISENGAGE.input = { 0.0, 1.0 } 
ASP_DISENGAGE.output = { 0.0, 1.0 }

GUN_camera_3D = CreateGauge("parameter")
GUN_camera_3D.parameter_name = "GUN_camera_3D"
GUN_camera_3D.arg_number = 67
GUN_camera_3D.input = { 0.0, 1.0 } 
GUN_camera_3D.output = { 0.0, 1.0 }

ASP_DISTANCE = CreateGauge("parameter")
ASP_DISTANCE.parameter_name = "ASP_TGT_DISTANCE"
ASP_DISTANCE.arg_number = 551
ASP_DISTANCE.input = { 0.0, 1.0 }
ASP_DISTANCE.output = { 0.0, 1.0 }

ASP_DISTANCE_MISSILE = CreateGauge("parameter")
ASP_DISTANCE_MISSILE.parameter_name = "ASP_TGT_DISTANCE_MISSILE"
ASP_DISTANCE_MISSILE.arg_number = 552
ASP_DISTANCE_MISSILE.input  = { 0.0, 1.0,  2.0,  2.5,  3.0,  3.5,  4.0,  4.5,  5.0,  5.5 } 
ASP_DISTANCE_MISSILE.output = { 0.0, 0.01, 0.075, 0.35, 0.53, 0.687, 0.785, 0.876, 0.954, 1.0 }

RADAR_ERROR = CreateGauge("parameter")
RADAR_ERROR.parameter_name = "RADAR_ERROR"
RADAR_ERROR.arg_number = 553
RADAR_ERROR.input = { 0.0, 1.0 } 
RADAR_ERROR.output = { 0.0, 1.0 }

RADAR_LOW_ALT = CreateGauge("parameter")
RADAR_LOW_ALT.parameter_name = "RADAR_LOW_ALT"
RADAR_LOW_ALT.arg_number = 554
RADAR_LOW_ALT.input = { 0.0, 1.0 } 
RADAR_LOW_ALT.output = { 0.0, 1.0 }

RADAR_FIX_BEAM = CreateGauge("parameter")
RADAR_FIX_BEAM.parameter_name = "RADAR_FIX_BEAM"
RADAR_FIX_BEAM.arg_number = 555
RADAR_FIX_BEAM.input = { 0.0, 1.0 } 
RADAR_FIX_BEAM.output = { 0.0, 1.0 }

ASP_SCALE_BASE = CreateGauge("parameter")
ASP_SCALE_BASE.parameter_name = "ASP_SCALE_BASE"
ASP_SCALE_BASE.arg_number = 556
ASP_SCALE_BASE.input = { 0.0, 1.0 } 
ASP_SCALE_BASE.output = { 0.0, 1.0 }

ASP_SCALE_ANGLE = CreateGauge("parameter")
ASP_SCALE_ANGLE.parameter_name = "ASP_SCALE_ANGLE"
ASP_SCALE_ANGLE.arg_number = 557
ASP_SCALE_ANGLE.input = { 0.0, 6.5 } 
ASP_SCALE_ANGLE.output = { 0.0, 1.0 }

RADAR_LAUNCH = CreateGauge("parameter")
RADAR_LAUNCH.parameter_name = "RADAR_LAUNCH"
RADAR_LAUNCH.arg_number = 558
RADAR_LAUNCH.input = { 0.0, 1.0 } 
RADAR_LAUNCH.output = { 0.0, 1.0 }

RADAR_MISSILE_HEAD_RDY = CreateGauge("parameter")
RADAR_MISSILE_HEAD_RDY.parameter_name = "RADAR_MISSILE_HEAD_RDY"
RADAR_MISSILE_HEAD_RDY.arg_number = 559
RADAR_MISSILE_HEAD_RDY.input = { 0.0, 1.0 } 
RADAR_MISSILE_HEAD_RDY.output = { 0.0, 1.0 }

RADAR_JAMMED = CreateGauge("parameter")
RADAR_JAMMED.parameter_name = "RADAR_JAMMED"
RADAR_JAMMED.arg_number = 560
RADAR_JAMMED.input = { 0.0, 1.0 } 
RADAR_JAMMED.output = { 0.0, 1.0 }

RADAR_BROKEN = CreateGauge("parameter")
RADAR_BROKEN.parameter_name = "RADAR_BROKEN"
RADAR_BROKEN.arg_number = 561
RADAR_BROKEN.input = { 0.0, 1.0 } 
RADAR_BROKEN.output = { 0.0, 1.0 }

RADAR_DISENGAGE = CreateGauge("parameter")
RADAR_DISENGAGE.parameter_name = "RADAR_DISENGAGE"
RADAR_DISENGAGE.arg_number = 562
RADAR_DISENGAGE.input = { 0.0, 1.0 } 
RADAR_DISENGAGE.output = { 0.0, 1.0 }

-- RADAR_SCREEN_1 = CreateGauge("parameter")
-- RADAR_SCREEN_1.parameter_name = "RADAR_SCREEN_1"
-- RADAR_SCREEN_1.arg_number = 569
-- RADAR_SCREEN_1.input = { 0.0, 1.0 } 
-- RADAR_SCREEN_1.output = { 0.0, 1.0 }

-- RADAR_SCREEN_2 = CreateGauge("parameter")
-- RADAR_SCREEN_2.parameter_name = "RADAR_SCREEN_2"
-- RADAR_SCREEN_2.arg_number = 570
-- RADAR_SCREEN_2.input = { 0.0, 1.0 } 
-- RADAR_SCREEN_2.output = { 0.0, 1.0 }

RADAR_19A_1 = CreateGauge("parameter")
RADAR_19A_1.parameter_name = "RADAR_19A_1"
RADAR_19A_1.arg_number = 571
RADAR_19A_1.input = { 0.0, 1.0 } 
RADAR_19A_1.output = { 0.0, 1.0 }

RADAR_19A_2 = CreateGauge("parameter")
RADAR_19A_2.parameter_name = "RADAR_19A_2"
RADAR_19A_2.arg_number = 572
RADAR_19A_2.input = { 0.0, 1.0 } 
RADAR_19A_2.output = { 0.0, 1.0 }

RADAR_19A_3 = CreateGauge("parameter")
RADAR_19A_3.parameter_name = "RADAR_19A_3"
RADAR_19A_3.arg_number = 573
RADAR_19A_3.input = { 0.0, 1.0 } 
RADAR_19A_3.output = { 0.0, 1.0 }

RADAR_19A_4 = CreateGauge("parameter")
RADAR_19A_4.parameter_name = "RADAR_19A_4"
RADAR_19A_4.arg_number = 574
RADAR_19A_4.input = { 0.0, 1.0 } 
RADAR_19A_4.output = { 0.0, 1.0 }

RADAR_19A_5 = CreateGauge("parameter")
RADAR_19A_5.parameter_name = "RADAR_19A_5"
RADAR_19A_5.arg_number = 575
RADAR_19A_5.input = { 0.0, 1.0 } 
RADAR_19A_5.output = { 0.0, 1.0 }

RADAR_19A_6 = CreateGauge("parameter")
RADAR_19A_6.parameter_name = "RADAR_19A_6"
RADAR_19A_6.arg_number = 576
RADAR_19A_6.input = { 0.0, 1.0 } 
RADAR_19A_6.output = { 0.0, 1.0 }

RADAR_19A_7 = CreateGauge("parameter")
RADAR_19A_7.parameter_name = "RADAR_19A_7"
RADAR_19A_7.arg_number = 577
RADAR_19A_7.input = { 0.0, 1.0 } 
RADAR_19A_7.output = { 0.0, 1.0 }

RADAR_19A_8 = CreateGauge("parameter")
RADAR_19A_8.parameter_name = "RADAR_19A_8"
RADAR_19A_8.arg_number = 578
RADAR_19A_8.input = { 0.0, 1.0 } 
RADAR_19A_8.output = { 0.0, 1.0 }

SEAT_HEIGHT = CreateGauge("parameter")
SEAT_HEIGHT.parameter_name = "SEAT_HEIGHT"
SEAT_HEIGHT.arg_number = 579
SEAT_HEIGHT.input = { 0.0, 1.0 } 
SEAT_HEIGHT.output = { 0.0, 1.0 }

IAB_BOX = CreateGauge("parameter")
IAB_BOX.parameter_name = "IAB_BOX"
IAB_BOX.arg_number = 580
IAB_BOX.input = { 0.0, 1.0 } 
IAB_BOX.output = { 0.0, 1.0 }

IAB_LIGHT_1 = CreateGauge("parameter")
IAB_LIGHT_1.parameter_name = "IAB_LIGHT_1"
IAB_LIGHT_1.arg_number = 581
IAB_LIGHT_1.input = { 0.0, 1.0 } 
IAB_LIGHT_1.output = { 0.0, 1.0 }

IAB_LIGHT_2 = CreateGauge("parameter")
IAB_LIGHT_2.parameter_name = "IAB_LIGHT_2"
IAB_LIGHT_2.arg_number = 582
IAB_LIGHT_2.input = { 0.0, 1.0 } 
IAB_LIGHT_2.output = { 0.0, 1.0 }

IAB_LIGHT_3 = CreateGauge("parameter")
IAB_LIGHT_3.parameter_name = "IAB_LIGHT_3"
IAB_LIGHT_3.arg_number = 583
IAB_LIGHT_3.input = { 0.0, 1.0 } 
IAB_LIGHT_3.output = { 0.0, 1.0 }

MISSILE_55_1 = CreateGauge("parameter")
MISSILE_55_1.parameter_name = "MISSILE_55_1"
MISSILE_55_1.arg_number = 584
MISSILE_55_1.input = { 0.0, 1.0 } 
MISSILE_55_1.output = { 0.0, 1.0 }

MISSILE_55_2 = CreateGauge("parameter")
MISSILE_55_2.parameter_name = "MISSILE_55_2"
MISSILE_55_2.arg_number = 585
MISSILE_55_2.input = { 0.0, 1.0 } 
MISSILE_55_2.output = { 0.0, 1.0 }

MISSILE_62 = CreateGauge("parameter")
MISSILE_62.parameter_name = "MISSILE_62"
MISSILE_62.arg_number = 586
MISSILE_62.input = { 0.0, 1.0 } 
MISSILE_62.output = { 0.0, 1.0 }

TACTICAL_DROP_ARMED = CreateGauge("parameter")
TACTICAL_DROP_ARMED.parameter_name = "TACTICAL_DROP_ARMED"
TACTICAL_DROP_ARMED.arg_number = 63
TACTICAL_DROP_ARMED.input = { 0.0, 1.0 } 
TACTICAL_DROP_ARMED.output = { 0.0, 1.0 }

SPS_BOX = CreateGauge("parameter")
SPS_BOX.parameter_name = "SPS_BOX"
SPS_BOX.arg_number = 591
SPS_BOX.input = { 0.0, 1.0 } 
SPS_BOX.output = { 0.0, 1.0 }

SPS_HIGH = CreateGauge("parameter")
SPS_HIGH.parameter_name = "SPS_WORKS"
SPS_HIGH.arg_number = 592
SPS_HIGH.input = { 0.0, 1.0 } 
SPS_HIGH.output = { 0.0, 1.0 }

SPS_ILLUMINATION = CreateGauge("parameter")
SPS_ILLUMINATION.parameter_name = "SPS_ILLUMINATION"
SPS_ILLUMINATION.arg_number = 593
SPS_ILLUMINATION.input = { 0.0, 1.0 } 
SPS_ILLUMINATION.output = { 0.0, 1.0 }

SPS_LAUNCH = CreateGauge("parameter")
SPS_LAUNCH.parameter_name = "SPS_LAUNCH"
SPS_LAUNCH.arg_number = 594
SPS_LAUNCH.input = { 0.0, 1.0 } 
SPS_LAUNCH.output = { 0.0, 1.0 }

GUV_BOX = CreateGauge("parameter")
GUV_BOX.parameter_name = "GUV_BOX"
GUV_BOX.arg_number = 598
GUV_BOX.input = { 0.0, 1.0 } 
GUV_BOX.output = { 0.0, 1.0 }

GUV_LAUNCH = CreateGauge("parameter")
GUV_LAUNCH.parameter_name = "GUV_LAUNCH"
GUV_LAUNCH.arg_number = 701
GUV_LAUNCH.input = { 0.0, 1.0 } 
GUV_LAUNCH.output = { 0.0, 1.0 }

-- SARPP == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==  

SARPP_switch = CreateGauge("parameter")
SARPP_switch.parameter_name = "SARPP_switch"
SARPP_switch.arg_number = 193
SARPP_switch.input = { 0.0, 1.0 } 
SARPP_switch.output = { 0.0, 1.0 }

-- SAU == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

SAU_stabilization_LIGHT = CreateGauge("parameter")
SAU_stabilization_LIGHT.parameter_name = "SAU_stabilization_LIGHT"
SAU_stabilization_LIGHT.arg_number = 546
SAU_stabilization_LIGHT.input = { 0.0, 1.0 } 
SAU_stabilization_LIGHT.output = { 0.0, 1.0 }

SAU_privedenie_LIGHT = CreateGauge("parameter")
SAU_privedenie_LIGHT.parameter_name = "SAU_privedenie_LIGHT"
SAU_privedenie_LIGHT.arg_number = 547
SAU_privedenie_LIGHT.input = { 0.0, 1.0 } 
SAU_privedenie_LIGHT.output = { 0.0, 1.0 }

SAU_landing_COMMAND_LIGHT = CreateGauge("parameter")
SAU_landing_COMMAND_LIGHT.parameter_name = "SAU_landing_COMMAND_LIGHT"
SAU_landing_COMMAND_LIGHT.arg_number = 544
SAU_landing_COMMAND_LIGHT.input = { 0.0, 1.0 } 
SAU_landing_COMMAND_LIGHT.output = { 0.0, 1.0 }

SAU_landing_AUTO_LIGHT = CreateGauge("parameter")
SAU_landing_AUTO_LIGHT.parameter_name = "SAU_landing_AUTO_LIGHT"
SAU_landing_AUTO_LIGHT.arg_number = 545
SAU_landing_AUTO_LIGHT.input = { 0.0, 1.0 } 
SAU_landing_AUTO_LIGHT.output = { 0.0, 1.0 }

-- ARU == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==  

ARU_3G_instrument = CreateGauge("parameter")
ARU_3G_instrument.parameter_name = "ARU_3G_instrument"
ARU_3G_instrument.arg_number = 64
ARU_3G_instrument.input = { 0.0, 1.0 } 
ARU_3G_instrument.output = { 0.0, 1.0 }

ARU_manual_auto_switch = CreateGauge("parameter")
ARU_manual_auto_switch.parameter_name = "ARU_manual_auto_switch"
ARU_manual_auto_switch.arg_number = 295
ARU_manual_auto_switch.input = { 0.0, 1.0 } 
ARU_manual_auto_switch.output = { 0.0, 1.0 }


-- KONUS == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

KONUS_UPES_3_instrument = CreateGauge("parameter")
KONUS_UPES_3_instrument.parameter_name = "KONUS_UPES_3_instrument"
KONUS_UPES_3_instrument.arg_number = 66
KONUS_UPES_3_instrument.input = { 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0 } 
KONUS_UPES_3_instrument.output = { 0.0, 0.095, 0.195, 0.296, 0.399, 0.499, 0.597, 0.695, 0.795, 0.899, 1.0 }

-- DRAG CHUTE == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

GUN_GOTOVN_LIGHT = CreateGauge("parameter")
GUN_GOTOVN_LIGHT.parameter_name = "GUN_gotovn_LIGHT"
GUN_GOTOVN_LIGHT.arg_number = 550
GUN_GOTOVN_LIGHT.input = { 0.0, 1.0 }
GUN_GOTOVN_LIGHT.output = { 0.0, 1.0 }

-- SPO == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == 

SPO_L_F = CreateGauge("parameter")
SPO_L_F.parameter_name = "SPO_L_F"
SPO_L_F.arg_number = 601
SPO_L_F.input = { 0.0, 1.0 }
SPO_L_F.output = { 0.0, 1.0 }

SPO_R_F = CreateGauge("parameter")
SPO_R_F.parameter_name = "SPO_R_F"
SPO_R_F.arg_number = 602
SPO_R_F.input = { 0.0, 1.0 }
SPO_R_F.output = { 0.0, 1.0 }

SPO_R_B = CreateGauge("parameter")
SPO_R_B.parameter_name = "SPO_R_B"
SPO_R_B.arg_number = 603
SPO_R_B.input = { 0.0, 1.0 }
SPO_R_B.output = { 0.0, 1.0 }

SPO_L_B = CreateGauge("parameter")
SPO_L_B.parameter_name = "SPO_L_B"
SPO_L_B.arg_number = 604
SPO_L_B.input = { 0.0, 1.0 }
SPO_L_B.output = { 0.0, 1.0 }

SPO_MUTED = CreateGauge("parameter")
SPO_MUTED.parameter_name = "SPO_MUTED"
SPO_MUTED.arg_number = 605
SPO_MUTED.input = { 0.0, 1.0 }
SPO_MUTED.output = { 0.0, 1.0 }

-- SOD == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==

SOD_ANSWER = CreateGauge("parameter")
SOD_ANSWER.parameter_name = "SOD_ANSWER"
SOD_ANSWER.arg_number = 606
SOD_ANSWER.input = { 0.0, 1.0 }
SOD_ANSWER.output = { 0.0, 1.0 }

-- SOD == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==

SRZO_ON = CreateGauge("parameter")
SRZO_ON.parameter_name = "SRZO_ON"
SRZO_ON.arg_number = 607
SRZO_ON.input = { 0.0, 1.0 }
SRZO_ON.output = { 0.0, 1.0 }

SRZO_CODE = CreateGauge("parameter")
SRZO_CODE.parameter_name = "SRZO_CODE"
SRZO_CODE.arg_number = 608
SRZO_CODE.input = { 0.0, 1.0 }
SRZO_CODE.output = { 0.0, 1.0 }

SRZO_CIPH = CreateGauge("parameter")
SRZO_CIPH.parameter_name = "SRZO_CIPH"
SRZO_CIPH.arg_number = 609
SRZO_CIPH.input = { 0.0, 1.0 }
SRZO_CIPH.output = { 0.0, 1.0 }

SRZO_ERROR = CreateGauge("parameter")
SRZO_ERROR.parameter_name = "SRZO_ERROR"
SRZO_ERROR.arg_number = 611
SRZO_ERROR.input = { 0.0, 1.0 }
SRZO_ERROR.output = { 0.0, 1.0 }

ASP_BACKLIGHT_ON = CreateGauge("parameter")
ASP_BACKLIGHT_ON.parameter_name = "ASP_BACKLIGHT_ON"
ASP_BACKLIGHT_ON.arg_number = 613
ASP_BACKLIGHT_ON.input = { 0.0, 1.0 }
ASP_BACKLIGHT_ON.output = { 0.0, 1.0 }

ASP_BACKLIGHT_INTENSITY = CreateGauge("parameter")
ASP_BACKLIGHT_INTENSITY.parameter_name = "ASP_BACKLIGHT_INTENSITY"
ASP_BACKLIGHT_INTENSITY.arg_number = 614
ASP_BACKLIGHT_INTENSITY.input = { 0.0, 1.0 }
ASP_BACKLIGHT_INTENSITY.output = { 0.0, 1.0 }

NEEDLES_PHOSPHOR_LIGHT = CreateGauge("parameter")
NEEDLES_PHOSPHOR_LIGHT.parameter_name = "NEEDLES_PHOSPHOR_LIGHT"
NEEDLES_PHOSPHOR_LIGHT.arg_number = 618
NEEDLES_PHOSPHOR_LIGHT.input = { 0.0, 1.0 }
NEEDLES_PHOSPHOR_LIGHT.output = { 0.0, 1.0 }

RED_PANELLIGHT = CreateGauge("parameter")
RED_PANELLIGHT.parameter_name = "RED_PANELLIGHT"
RED_PANELLIGHT.arg_number = 152
RED_PANELLIGHT.input = { 0.0, 1.0 }
RED_PANELLIGHT.output = { 0.0, 1.0 }

RED_FLOODLIGHT = CreateGauge("parameter")
RED_FLOODLIGHT.parameter_name = "RED_FLOODLIGHT"
RED_FLOODLIGHT.arg_number = 619
RED_FLOODLIGHT.input = { 0.0, 1.0 }
RED_FLOODLIGHT.output = { 0.0, 1.0 }

WHITE_PANELLIGHT = CreateGauge("parameter")
WHITE_PANELLIGHT.parameter_name = "WHITE_PANELLIGHT"
WHITE_PANELLIGHT.arg_number = 620
WHITE_PANELLIGHT.input = { 0.0, 1.0 }
WHITE_PANELLIGHT.output = { 0.0, 1.0 }

RED_INSTRUMENT = CreateGauge("parameter")
RED_INSTRUMENT.parameter_name = "RED_INSTRUMENT"
RED_INSTRUMENT.arg_number = 621
RED_INSTRUMENT.input = { 0.0, 1.0 }
RED_INSTRUMENT.output = { 0.0, 1.0 }

ASP_GLASS_LIGHT_INTENSITY = CreateGauge("parameter")
ASP_GLASS_LIGHT_INTENSITY.parameter_name = "ASP_GLASS_LIGHT_INTENSITY"
ASP_GLASS_LIGHT_INTENSITY.arg_number = 622
ASP_GLASS_LIGHT_INTENSITY.input = { 0.0, 1.0 }
ASP_GLASS_LIGHT_INTENSITY.output = { 0.0, 1.0 }

H_indicator_triangle_km = CreateGauge("parameter")
H_indicator_triangle_km.parameter_name = "H_indicator_triangle_km"
H_indicator_triangle_km.arg_number = 652
H_indicator_triangle_km.input = { 0.0, 30000.0 }
H_indicator_triangle_km.output = { 0.0, 1.0 }

H_indicator_triangle_m = CreateGauge("parameter")
H_indicator_triangle_m.parameter_name = "H_indicator_triangle_m"
H_indicator_triangle_m.arg_number = 658
H_indicator_triangle_m.input = { 0.0, 1000.0 }
H_indicator_triangle_m.output = { 0.0, 1.0 }

COCKPIT_PRESSURE_ALTIMETER = CreateGauge("parameter")
COCKPIT_PRESSURE_ALTIMETER.parameter_name = "COCKPIT_PRESSURE_ALTIMETER"
COCKPIT_PRESSURE_ALTIMETER.arg_number = 655
COCKPIT_PRESSURE_ALTIMETER.input = { 0.0, 20.0 } 
COCKPIT_PRESSURE_ALTIMETER.output = { 0.0, 1.0 }

COCKPIT_PRESSURE = CreateGauge("parameter")
COCKPIT_PRESSURE.parameter_name = "COCKPIT_PRESSURE"
COCKPIT_PRESSURE.arg_number = 656
COCKPIT_PRESSURE.input = { -0.3, -0.2, -0.1, 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6 }
COCKPIT_PRESSURE.output = { -1.0, -0.56, -0.27, 0.0, 0.17, 0.35, 0.50, 0.66, 0.82, 1.0 }

need_to_be_closed = true


--/N/ livery change, Apr. 2017
dofile(LockOn_Options.common_script_path.."tools.lua")
livery = find_custom_livery("MiG-21Bis","default")