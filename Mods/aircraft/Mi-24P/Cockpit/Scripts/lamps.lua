 local count = -1
local function counter()
	count = count + 1
	return count
end

function create_simple_lamp(arg_, controller_, param_)
	local _lamp	= CreateGauge()
	_lamp.arg_number	= arg_
	_lamp.input		= {0.0, 1.0}
	_lamp.output 	= {0.0, 1.0}
	_lamp.controller	= controller_
	if param_ ~= nil then
		_lamp.params 	= {param_}
	end
	return _lamp
end



-- Warning Lights
count = -1
Warning_Lights = 
{
	--flashing
	FLAG_RIGHT_GENERATOR_OFF					= counter(),
	FLAG_LEFT_GENERATOR_OFF               		= counter(),
	FLAG_MAIN_REDUCER_LOW_PRESSURE              = counter(),
	FLAG_TANK1_REMAINS120L                      = counter(),
	FLAG_TANK2_REMAINS120L                      = counter(),
	FLAG_HYRO_UNIT_1_FAILURE                    = counter(),
	FLAG_HYRO_UNIT_2_FAILURE                    = counter(),
	FLAG_ATTENTION_ELECTRO_SYSTEM_PANEL         = counter(),
	FLAG_AI9V_WORKS                             = counter(),
	FLAG_FIRE                                   = counter(),
	FLAG_ICING                                  = counter(),
	--end flashing


	FLAG_LEFT_VU_OFF 							= counter(),
	FLAG_RIGHT_VU_OFF							= counter(),

	FLAG_DC_SOCKET_ON							= counter(),

	FLAG_APU_ON									= counter(),

	FLAG_MAIN_TRANSFORMER_115_OFF				= counter(),
	FLAG_MAIN_TRANSFORMER_36_OFF				= counter(),
	FLAG_AC_SOCKET_ON							= counter(),

	FLAG_GENERATORS_IN_PARALLEL					= counter(),


	FLAG_PO750A_ON                        		= counter(),
	FLAG_PT125TS_OFF                      		= counter(),

	FLAG_MAIN_TRANSFORMER_36_DIM_OFF			= counter(),
	
	FLAG_HYDRO_GEAR_OFF                   		= counter(),
	FLAG_HYDRO_MAIN_ON                    		= counter(),
	FLAG_HYDRO_AUXILIARY_ON               		= counter(),
	FLAG_HYDRO_AUXILIARY_OFF              		= counter(),
	
	FLAG_N_GEAR_DN_P							= counter(),
	FLAG_L_GEAR_DN_P							= counter(),
	FLAG_R_GEAR_DN_P							= counter(),
	FLAG_N_GEAR_UP_P							= counter(),
	FLAG_L_GEAR_UP_P							= counter(),
	FLAG_R_GEAR_UP_P							= counter(),
	
	FLAG_EC_SYSTEM_DISABLED     				= counter(),
	FLAG_EC_CABIN_OVERPRESSURE  				= counter(),
	FLAG_EC_DOORS_SEALED        				= counter(),
	FLAG_EC_DOORS_UNSEALED      				= counter(),
	
	
	
	
	FLAG_AUTOMATIC_ON                           = counter(),
	FLAG_STARTER_WORKS                          = counter(),
	FLAG_AUTOMATIC_ON_TURB                      = counter(),
	FLAG_OIL_PRESSURE_NORMAL                    = counter(),
	FLAG_REV_AI9V_NORMAL                        = counter(),
	FLAG_REV_AI9V_HIGH                          = counter(),
	
	FLAG_PUMP_WORKS_1                           = counter(),
	FLAG_PUMP_WORKS_2                           = counter(),
	FLAG_PUMP_WORKS_4                           = counter(),
	FLAG_PUMP_WORKS_5                           = counter(),
	FLAG_FUEL_TRANSFER                          = counter(),
	FLAG_OFF_FUEL_TRANSFER                      = counter(),
	FLAG_LEFT_CONSUMPTION_TANK_VALVE_CLOSE_1    = counter(),
	FLAG_RIGHT_CONSUMPTION_TANK_VALVE_CLOSE_2   = counter(),
	FLAG_LEFT_ENGINE_VALVE_CLOSE                = counter(),
	FLAG_RIGHT_ENGINE_VALVE_CLOSE               = counter(),
	FLAG_SEPARATORY_VALVE_CLOSE                 = counter(),
	
	FLAG_FIRE_IN_LEFT_ENGINE                    = counter(),
	FLAG_FIRE_IN_RIGHT_ENGINE                   = counter(),
	FLAG_FIRE_IN_AI9_TANK3                      = counter(),
	FLAG_FIRE_IN_MAIN_REDUCER                   = counter(),
	FLAG_PYRO1_1                                = counter(),
	FLAG_PYRO1_2                                = counter(),
	FLAG_PYRO1_3                                = counter(),
	FLAG_PYRO1_4                                = counter(),
	FLAG_PYRO2_1                                = counter(),
	FLAG_PYRO2_2                                = counter(),
	FLAG_PYRO2_3                                = counter(),
	FLAG_PYRO2_4                                = counter(),
	FLAG_CONTROL_SENSOR                         = counter(),
	FLAG_CHIP_IN_TRANSMISSION_OIL               = counter(),
	FLAG_MAIN_REDUCER_PRESSURE_LOW              = counter(),
	FLAG_MAIN_REDUCER_CHIP_IN_OIL               = counter(),
	FLAG_WHEEL_BRAKE                            = counter(),
	FLAG_OPERATOR_CONTROL                       = counter(),
	FLAG_GREAT_TEMP_GIVE_A_PEDAL                = counter(),
	FLAG_LEFT_HEATING_FAILED                    = counter(),
	FLAG_RIGHT_HEATING_FAILED                   = counter(),
	
	FLAG_ANTI_ICING_SYSTEM_FAILED               = counter(),
	FLAG_AUTOMATIC_CONTROL_ANTI_ICING_SYSTEM    = counter(),
	FLAG_ANTI_ICING_ON                          = counter(),
	FLAG_HEATING_LEFT_ENGINE_ON                 = counter(),
	FLAG_HEATING_RIGHT_ENGINE_ON                = counter(),
	FLAG_HEATING_LEFT_DUSTPROOF_ON              = counter(),
	FLAG_HEATING_RIGHT_DUSTPROOF_ON             = counter(),
	FLAG_HEATING_RIO3_IN_NORMAL_STATE           = counter(),
	FLAG_BLADES_SECTIONS_HB_1                   = counter(),
	FLAG_BLADES_SECTIONS_HB_2                   = counter(),
	FLAG_BLADES_SECTIONS_HB_3                   = counter(),
	FLAG_BLADES_SECTIONS_HB_4                   = counter(),
	FLAG_LOCK_RELEASED                          = counter(),
	FLAG_LOCK_OPEN                              = counter(),
	FLAG_AUTOMATIC_DEPARTMENT_ON                = counter(),
	FLAG_RT_WORKS                               = counter(),
	FLAG_SARPP_WORKS                            = counter(),
	FLAG_REGULATOR_T_PTK                        = counter(),
	FLAG_REGULATOR_T_PTK_                       = counter(),
	FLAG_REV_CT_RIGHT_ENGINE                    = counter(),
	FLAG_REV_CT_LEFT_ENGINE                     = counter(),
	FLAG_LEFT_ENGINE_ANTI_DUST_ON 				= counter(),
	FLAG_RIGHT_ENGINE_ANTI_DUST_ON 				= counter(),
	FLAG_LEFT_ENGINE_GAS_T_HIGH                 = counter(),
	FLAG_RIGHT_ENGINE_GAS_T_HIGH                = counter(),	
	
	FLAG_RESTRICT_MANEUVER						= counter(),
	
	FLAG_N_GEAR_DN_O							= counter(),
	FLAG_L_GEAR_DN_O							= counter(),
	FLAG_R_GEAR_DN_O							= counter(),
	
	FLAG_BUTTON_K_ON							= counter(),
	FLAG_BUTTON_K_OFF							= counter(),
	FLAG_BUTTON_H_ON							= counter(),
	FLAG_BUTTON_H_OFF							= counter(),
	FLAG_BUTTON_B_ON							= counter(),
	FLAG_BUTTON_B_OFF							= counter(),
	FLAG_BUTTON_T_ON							= counter(),
	FLAG_BUTTON_T_OFF							= counter(),
	FLAG_BUTTON_ROUTE_ON						= counter(),
	FLAG_BUTTON_HOVER_ROUTE_OFF					= counter(),
	FLAG_BUTTON_HOVER_ON						= counter(),
	FLAG_BUTTON_HEIGHT_ON						= counter(),
	FLAG_BUTTON_HEIGHT_OFF						= counter(),
	FLAG_BUTTON_SPUU_OFF						= counter(),
	
	FLAG_LAMP_MAX								= counter(),
}	

function create_warning_lamp(arg_, param_)
	return create_simple_lamp(arg_, controllers.warning_lights, param_)
end
				

LEFT_VU_OFF 				       		= create_warning_lamp(63,	Warning_Lights.FLAG_LEFT_VU_OFF)
RIGHT_VU_OFF				       		= create_warning_lamp(64,	Warning_Lights.FLAG_RIGHT_VU_OFF)

DC_SOCKET_ON				       		= create_warning_lamp(72,	Warning_Lights.FLAG_DC_SOCKET_ON)

--APU_ON						        	= create_warning_lamp(79,	Warning_Lights.FLAG_APU_ON)
RIGHT_GENERATOR_OFF		       			= create_warning_lamp(81,	Warning_Lights.FLAG_RIGHT_GENERATOR_OFF)
MAIN_TRANSFORMER_115_OFF	       		= create_warning_lamp(82,	Warning_Lights.FLAG_MAIN_TRANSFORMER_115_OFF)
MAIN_TRANSFORMER_36_OFF	       			= create_warning_lamp(84,	Warning_Lights.FLAG_MAIN_TRANSFORMER_36_OFF)
AC_SOCKET_ON				        	= create_warning_lamp(86,	Warning_Lights.FLAG_AC_SOCKET_ON)

GENERATORS_IN_PARALLEL					= create_warning_lamp(178, Warning_Lights.FLAG_GENERATORS_IN_PARALLEL)

LEFT_GENERATOR_OFF                		= create_warning_lamp(94, Warning_Lights.FLAG_LEFT_GENERATOR_OFF)
PO750A_ON                        	 	= create_warning_lamp(92, Warning_Lights.FLAG_PO750A_ON)
PT125TS_OFF                      	  	= create_warning_lamp(93, Warning_Lights.FLAG_PT125TS_OFF)

--TODO: arguments

MAIN_TRANSFORMER_36_DIM_OFF				= create_warning_lamp(197, Warning_Lights.FLAG_MAIN_TRANSFORMER_36_DIM_OFF)

HYDRO_GEAR_OFF                   		= create_warning_lamp(209,	Warning_Lights.FLAG_HYDRO_GEAR_OFF)
HYDRO_MAIN_ON                    		= create_warning_lamp(210,	Warning_Lights.FLAG_HYDRO_MAIN_ON)
HYDRO_AUXILIARY_ON               		= create_warning_lamp(211,	Warning_Lights.FLAG_HYDRO_AUXILIARY_ON)
HYDRO_AUXILIARY_OFF              		= create_warning_lamp(212,	Warning_Lights.FLAG_HYDRO_AUXILIARY_OFF)

N_GEAR_DN_P							= create_warning_lamp(230,	Warning_Lights.FLAG_N_GEAR_DN_P)
L_GEAR_DN_P							= create_warning_lamp(231,	Warning_Lights.FLAG_L_GEAR_DN_P)
R_GEAR_DN_P							= create_warning_lamp(229,	Warning_Lights.FLAG_R_GEAR_DN_P)
N_GEAR_UP_P							= create_warning_lamp(226,	Warning_Lights.FLAG_N_GEAR_UP_P)
L_GEAR_UP_P							= create_warning_lamp(225,	Warning_Lights.FLAG_L_GEAR_UP_P)
R_GEAR_UP_P							= create_warning_lamp(227,	Warning_Lights.FLAG_R_GEAR_UP_P)

EC_SYSTEM_DISABLED   	      	 		= create_warning_lamp(132,	Warning_Lights.FLAG_EC_SYSTEM_DISABLED)
EC_CABIN_OVERPRESSURE          		= create_warning_lamp(172,	Warning_Lights.FLAG_EC_CABIN_OVERPRESSURE)
EC_DOORS_SEALED                		= create_warning_lamp(221,	Warning_Lights.FLAG_EC_DOORS_SEALED)
EC_DOORS_UNSEALED              		= create_warning_lamp(222,	Warning_Lights.FLAG_EC_DOORS_UNSEALED)
	
MAIN_REDUCER_LOW_PRESSURE             = create_warning_lamp(154,	Warning_Lights.FLAG_MAIN_REDUCER_LOW_PRESSURE)
TANK1_REMAINS120L                     = create_warning_lamp(152,	Warning_Lights.FLAG_TANK1_REMAINS120L)
TANK2_REMAINS120L                     = create_warning_lamp(153,	Warning_Lights.FLAG_TANK2_REMAINS120L)
HYRO_UNIT_1_FAILURE                   = create_warning_lamp(11,	Warning_Lights.FLAG_HYRO_UNIT_1_FAILURE)
HYRO_UNIT_2_FAILURE                   = create_warning_lamp(13,	Warning_Lights.FLAG_HYRO_UNIT_2_FAILURE)
ATTENTION_ELECTRO_SISTEM_PANEL        = create_warning_lamp(155,	Warning_Lights.FLAG_ATTENTION_ELECTRO_SYSTEM_PANEL)

AUTOMATIC_ON                          = create_warning_lamp(317,	Warning_Lights.FLAG_AUTOMATIC_ON)
STARTER_WORKS                         = create_warning_lamp(316,	Warning_Lights.FLAG_STARTER_WORKS)
AUTOMATIC_ON_TURB                     = create_warning_lamp(310,	Warning_Lights.FLAG_AUTOMATIC_ON_TURB)
OIL_PRESSURE_NORMAL                   = create_warning_lamp(306,	Warning_Lights.FLAG_OIL_PRESSURE_NORMAL)
REV_AI9V_NORMAL                       = create_warning_lamp(288,	Warning_Lights.FLAG_REV_AI9V_NORMAL)
REV_AI9V_HIGH                         = create_warning_lamp(309,	Warning_Lights.FLAG_REV_AI9V_HIGH)
AI9V_WORKS                            = create_warning_lamp(79,		Warning_Lights.FLAG_AI9V_WORKS)

PUMP_WORKS_1                          = create_warning_lamp(407,	Warning_Lights.FLAG_PUMP_WORKS_1)
PUMP_WORKS_2                          = create_warning_lamp(409,	Warning_Lights.FLAG_PUMP_WORKS_2)
PUMP_WORKS_4                          = create_warning_lamp(403,	Warning_Lights.FLAG_PUMP_WORKS_4)
PUMP_WORKS_5                          = create_warning_lamp(405,	Warning_Lights.FLAG_PUMP_WORKS_5)
FUEL_TRANSFER                         = create_warning_lamp(413,	Warning_Lights.FLAG_FUEL_TRANSFER)
OFF_FUEL_TRANSFER                     = create_warning_lamp(412,	Warning_Lights.FLAG_OFF_FUEL_TRANSFER)
LEFT_CONSUMPTION_TANK_VALVE_CLOSE_1   = create_warning_lamp(391,	Warning_Lights.FLAG_LEFT_CONSUMPTION_TANK_VALVE_CLOSE_1)
RIGHT_CONSUMPTION_TANK_VALVE_CLOSE_2  = create_warning_lamp(393,	Warning_Lights.FLAG_RIGHT_CONSUMPTION_TANK_VALVE_CLOSE_2)
LEFT_ENGINE_VALVE_CLOSE               = create_warning_lamp(395,	Warning_Lights.FLAG_LEFT_ENGINE_VALVE_CLOSE)
RIGHT_ENGINE_VALVE_CLOSE              = create_warning_lamp(398,	Warning_Lights.FLAG_RIGHT_ENGINE_VALVE_CLOSE)
SEPARATORY_VALVE_CLOSE                = create_warning_lamp(401,	Warning_Lights.FLAG_SEPARATORY_VALVE_CLOSE)
FIRE                                  = create_warning_lamp(151,	Warning_Lights.FLAG_FIRE)
FIRE_IN_LEFT_ENGINE                   = create_warning_lamp(470,	Warning_Lights.FLAG_FIRE_IN_LEFT_ENGINE)
FIRE_IN_RIGHT_ENGINE                  = create_warning_lamp(473,	Warning_Lights.FLAG_FIRE_IN_RIGHT_ENGINE)
FIRE_IN_AI9_TANK3                     = create_warning_lamp(476,	Warning_Lights.FLAG_FIRE_IN_AI9_TANK3)
FIRE_IN_MAIN_REDUCER                  = create_warning_lamp(479,	Warning_Lights.FLAG_FIRE_IN_MAIN_REDUCER)
PYRO1_1                               = create_warning_lamp(471,	Warning_Lights.FLAG_PYRO1_1)
PYRO1_2                               = create_warning_lamp(474,	Warning_Lights.FLAG_PYRO1_2)
PYRO1_3                               = create_warning_lamp(477,	Warning_Lights.FLAG_PYRO1_3)
PYRO1_4                               = create_warning_lamp(480,	Warning_Lights.FLAG_PYRO1_4)
PYRO2_1                               = create_warning_lamp(472,	Warning_Lights.FLAG_PYRO2_1)
PYRO2_2                               = create_warning_lamp(475,	Warning_Lights.FLAG_PYRO2_2)
PYRO2_3                               = create_warning_lamp(478,	Warning_Lights.FLAG_PYRO2_3)
PYRO2_4                               = create_warning_lamp(481,	Warning_Lights.FLAG_PYRO2_4)
CONTROL_SENSOR                        = create_warning_lamp(483,	Warning_Lights.FLAG_CONTROL_SENSOR)
CHIP_IN_TRANSMISSION_OIL              = create_warning_lamp(158,	Warning_Lights.FLAG_CHIP_IN_TRANSMISSION_OIL)
--MAIN_REDUCER_PRESSURE_LOW             = create_warning_lamp(,	Warning_Lights.FLAG_MAIN_REDUCER_PRESSURE_LOW)
--MAIN_REDUCER_CHIP_IN_OIL              = create_warning_lamp(,	Warning_Lights.FLAG_MAIN_REDUCER_CHIP_IN_OIL)
WHEEL_BRAKE                           = create_warning_lamp(220,	Warning_Lights.FLAG_WHEEL_BRAKE)
OPERATOR_CONTROL                      = create_warning_lamp(177,	Warning_Lights.FLAG_OPERATOR_CONTROL)
GREAT_TEMP_GIVE_A_PEDAL               = create_warning_lamp(291,	Warning_Lights.FLAG_GREAT_TEMP_GIVE_A_PEDAL)
LEFT_HEATING_FAILED                   = create_warning_lamp(388,	Warning_Lights.FLAG_LEFT_HEATING_FAILED)
RIGHT_HEATING_FAILED                  = create_warning_lamp(390,	Warning_Lights.FLAG_RIGHT_HEATING_FAILED)
ICING                                 = create_warning_lamp(150,	Warning_Lights.FLAG_ICING)
ANTI_ICING_SYSTEM_FAILED              = create_warning_lamp(163,	Warning_Lights.FLAG_ANTI_ICING_SYSTEM_FAILED)
AUTOMATIC_CONTROL_ANTI_ICING_SYSTEM   = create_warning_lamp(156,	Warning_Lights.FLAG_AUTOMATIC_CONTROL_ANTI_ICING_SYSTEM)
ANTI_ICING_ON                         = create_warning_lamp(103,	Warning_Lights.FLAG_ANTI_ICING_ON)
HEATING_LEFT_ENGINE_ON                = create_warning_lamp(104,	Warning_Lights.FLAG_HEATING_LEFT_ENGINE_ON)
HEATING_RIGHT_ENGINE_ON               = create_warning_lamp(105,	Warning_Lights.FLAG_HEATING_RIGHT_ENGINE_ON)
HEATING_LEFT_DUSTPROOF_ON             = create_warning_lamp(106,	Warning_Lights.FLAG_HEATING_LEFT_DUSTPROOF_ON)
HEATING_RIGHT_DUSTPROOF_ON            = create_warning_lamp(107,	Warning_Lights.FLAG_HEATING_RIGHT_DUSTPROOF_ON)
HEATING_RIO3_IN_NORMAL_STATE          = create_warning_lamp(108,	Warning_Lights.FLAG_HEATING_RIO3_IN_NORMAL_STATE)
BLADES_SECTIONS_HB_1                  = create_warning_lamp(131,	Warning_Lights.FLAG_BLADES_SECTIONS_HB_1)
BLADES_SECTIONS_HB_2                  = create_warning_lamp(117,	Warning_Lights.FLAG_BLADES_SECTIONS_HB_2)
BLADES_SECTIONS_HB_3                  = create_warning_lamp(116,	Warning_Lights.FLAG_BLADES_SECTIONS_HB_3)
BLADES_SECTIONS_HB_4                  = create_warning_lamp(115,	Warning_Lights.FLAG_BLADES_SECTIONS_HB_4)
LOCK_RELEASED                         = create_warning_lamp(200,	Warning_Lights.FLAG_LOCK_RELEASED)
LOCK_OPEN                             = create_warning_lamp(201,	Warning_Lights.FLAG_LOCK_OPEN)
AUTOMATIC_DEPARTMENT_ON               = create_warning_lamp(202,	Warning_Lights.FLAG_AUTOMATIC_DEPARTMENT_ON)
--RT_WORKS                              = create_warning_lamp(,	Warning_Lights.FLAG_RT_WORKS)
SARPP_WORKS 						 = create_warning_lamp(358,	Warning_Lights.FLAG_SARPP_WORKS)
--REGULATOR_T_PTK                       = create_warning_lamp(,	Warning_Lights.FLAG_REGULATOR_T_PTK)
--REGULATOR_T_PTK_                      = create_warning_lamp(,	Warning_Lights.FLAG_REGULATOR_T_PTK_)
--REV_CT_RIGHT_ENGINE                   = create_warning_lamp(,	Warning_Lights.FLAG_REV_CT_RIGHT_ENGINE)
--REV_CT_LEFT_ENGINE                    = create_warning_lamp(,	Warning_Lights.FLAG_REV_CT_LEFT_ENGINE)
LEFT_ENGINE_GAS_T_HIGH                = create_warning_lamp(161,	Warning_Lights.FLAG_LEFT_ENGINE_GAS_T_HIGH)
RIGHT_ENGINE_GAS_T_HIGH               = create_warning_lamp(162,	Warning_Lights.FLAG_RIGHT_ENGINE_GAS_T_HIGH)
LEFT_ENGINE_ANTI_DUST_ON              = create_warning_lamp(175,	Warning_Lights.FLAG_LEFT_ENGINE_ANTI_DUST_ON)
RIGHT_ENGINE_ANTI_DUST_ON             = create_warning_lamp(176,	Warning_Lights.FLAG_RIGHT_ENGINE_ANTI_DUST_ON)

N_GEAR_DN_O							= create_warning_lamp(684,	Warning_Lights.FLAG_N_GEAR_DN_O)
L_GEAR_DN_O							= create_warning_lamp(683,	Warning_Lights.FLAG_L_GEAR_DN_O)
R_GEAR_DN_O							= create_warning_lamp(685,	Warning_Lights.FLAG_R_GEAR_DN_O)

BUTTON_K_ON							= create_warning_lamp(281,	Warning_Lights.FLAG_BUTTON_K_ON)
BUTTON_K_OFF						= create_warning_lamp(280,	Warning_Lights.FLAG_BUTTON_K_OFF)
BUTTON_H_ON							= create_warning_lamp(279,	Warning_Lights.FLAG_BUTTON_H_ON)
BUTTON_H_OFF						= create_warning_lamp(278,	Warning_Lights.FLAG_BUTTON_H_OFF)
BUTTON_B_ON							= create_warning_lamp(296,	Warning_Lights.FLAG_BUTTON_B_ON)
BUTTON_B_OFF						= create_warning_lamp(295,	Warning_Lights.FLAG_BUTTON_B_OFF)
BUTTON_T_ON							= create_warning_lamp(294,	Warning_Lights.FLAG_BUTTON_T_ON)
BUTTON_T_OFF						= create_warning_lamp(293,	Warning_Lights.FLAG_BUTTON_T_OFF)
BUTTON_ROUTE_ON						= create_warning_lamp(299,	Warning_Lights.FLAG_BUTTON_ROUTE_ON)
BUTTON_HOVER_ROUTE_OFF				= create_warning_lamp(298,	Warning_Lights.FLAG_BUTTON_HOVER_ROUTE_OFF)
BUTTON_HOVER_ON						= create_warning_lamp(297,	Warning_Lights.FLAG_BUTTON_HOVER_ON)
BUTTON_HEIGHT_ON					= create_warning_lamp(304,	Warning_Lights.FLAG_BUTTON_HEIGHT_ON)
BUTTON_HEIGHT_OFF					= create_warning_lamp(303,	Warning_Lights.FLAG_BUTTON_HEIGHT_OFF)
BUTTON_SPUU_OFF						= create_warning_lamp(302,	Warning_Lights.FLAG_BUTTON_SPUU_OFF)

RESTRICT_MANEUVER					= create_warning_lamp(157,	Warning_Lights.FLAG_RESTRICT_MANEUVER)

-- Red Lights
count = -1
Red_Lights = 
{
	FLAG_PilotInstrumentPanelRightPanel_1           = counter(),
	FLAG_SpecialEquipmentPanelRedLights_1_2    	    = counter(),
	FLAG_PilotInstrumentPanelRightPanel_2           = counter(),
	FLAG_SpecialEquipmentPanelRedLights_5_6    	    = counter(),
--	FLAG_SpecialEquipmentPanelRedLights_    	    = counter(),
	FLAG_PilotLeftPanel_1                           = counter(),
	FLAG_PilotLeftPanel_2                           = counter(),
	FLAG_OperatorPanel_1                            = counter(),
	FLAG_OperatorPanelRedLights_5_6                 = counter(),
	FLAG_OperatorPanel_2                            = counter(),
	FLAG_OperatorPanelRedLights_3_4                 = counter(),
--	FLAG_OperatorPanelRedLights_1_2                 = counter(),
	FLAG_PilotBuiltInRedLights                      = counter(),
	FLAG_RedLights_MAX								= counter()
}	

function create_red_lamp(arg_, param_)
	return create_simple_lamp(arg_, controllers.red_lights, param_)
end
				--TODO: arguments
PilotInstrumentPanelRightPanel_1      = create_red_lamp(821,	Red_Lights.FLAG_PilotInstrumentPanelRightPanel_1)
--SpecialEquipmentPanelRedLights_1_2    = create_red_lamp(821,	Red_Lights.FLAG_SpecialEquipmentPanelRedLights_1_2)
--PilotInstrumentPanelRightPanel_2      = create_red_lamp(821,	Red_Lights.FLAG_PilotInstrumentPanelRightPanel_2)
--SpecialEquipmentPanelRedLights_5_6    = create_red_lamp(821,	Red_Lights.FLAG_SpecialEquipmentPanelRedLights_5_6)
----SpecialEquipmentPanelRedLights_		= create_red_lamp(,	Red_Lights.FLAG_SpecialEquipmentPanelRedLights_)
--PilotLeftPanel_1                		= create_red_lamp(,	Red_Lights.FLAG_PilotLeftPanel_1)
PilotLeftPanel_2                      = create_red_lamp(979,	Red_Lights.FLAG_PilotLeftPanel_2)
OperatorPanel_1                       = create_red_lamp(282,	Red_Lights.FLAG_OperatorPanel_1)
--OperatorPanelRedLights_5_6            = create_red_lamp(,	Red_Lights.FLAG_OperatorPanelRedLights_5_6)
OperatorPanel_2                       = create_red_lamp(283,	Red_Lights.FLAG_OperatorPanel_2)
--OperatorPanelRedLights_3_4            = create_red_lamp(,	Red_Lights.FLAG_OperatorPanelRedLights_3_4)
----OperatorPanelRedLights_1_2          = create_red_lamp(,	Red_Lights.FLAG_OperatorPanelRedLights_1_2)
PilotBuiltInRedLights                 = create_red_lamp(978,	Red_Lights.FLAG_PilotBuiltInRedLights)


-- Cabin Lights
count = -1
Cabin_Lights = 
{
	FLAG_WhiteOperator                              = counter(),
	FLAG_RedOperator                                = counter(),
	FLAG_SBKoperator                                = counter(),
	FLAG_WhitePilot                                 = counter(),	
	FLAG_RedPilot                                   = counter(),
	FLAG_SBKpilot                                   = counter(),
	FLAG_WhiteCargo                                 = counter(),
	FLAG_BlueCargo                                  = counter(),
	FLAG_RadioBay                                   = counter(),
	FLAG_Tailboom                                   = counter(),
	FLAG_CabinLights_MAX                           	= counter()
}	

function create_cabin_lamp(arg_, param_)
	return create_simple_lamp(arg_, controllers.cabin_lights, param_)
end
				--TODO: arguments
WhiteOperator                     	= create_cabin_lamp(981, Cabin_Lights.FLAG_WhiteOperator)
RedOperator                  		= create_cabin_lamp(982, Cabin_Lights.FLAG_RedOperator)
--SBKoperator                       	= create_cabin_lamp(, Cabin_Lights.FLAG_SBKoperator)
WhitePilot                        	= create_cabin_lamp(881, Cabin_Lights.FLAG_WhitePilot)
RedPilot                          	= create_cabin_lamp(976, Cabin_Lights.FLAG_RedPilot)
--SBKpilot                          	= create_cabin_lamp(, Cabin_Lights.FLAG_SBKpilot)
--WhiteCargo                        	= create_cabin_lamp(, Cabin_Lights.FLAG_WhiteCargo)
--BlueCargo                         	= create_cabin_lamp(, Cabin_Lights.FLAG_BlueCargo)
--RadioBay                          	= create_cabin_lamp(, Cabin_Lights.FLAG_RadioBay)
--Tailboom                          	= create_cabin_lamp(, Cabin_Lights.FLAG_Tailboom)


count = -1
ASP17_Lights = 
{
	ASPLamp_KMG                           	= counter(),
	ASPLamp_GUV                           	= counter(),
	ASPLamp_BOMB                           	= counter(),
	ASPLamp_30                           	= counter(),
	ASPLamp_NRS                           	= counter(),
	ASPLamp_SYNC                           	= counter(),
	ASPLamp_ASYNC                           = counter(),
	ASPLamp_AUTO                           	= counter(),
	ASPLamp_MANUAL                          = counter(),
	ASPLamp_CONTROL                         = counter(),
	ASPLamp_GODEN                           = counter(),
	ASPLamp_HORIZ                           = counter(),
	ASPLamp_VERT                           	= counter(),
    ASPLamp_Yellow                          = counter(),
    ASPLamp_Green                           = counter(),
	ASPLamp_USR_Check						= counter(),
	ASP_Lights_MAX                          = counter()
}

function create_asp17_lamp(arg_, param_)
	return create_simple_lamp(arg_, controllers.asp17_lights, param_)
end
asp17_KMG_lamp							= create_asp17_lamp(559, ASP17_Lights.ASPLamp_KMG)
asp17_GUV_lamp							= create_asp17_lamp(560, ASP17_Lights.ASPLamp_GUV)
asp17_BOMB_lamp							= create_asp17_lamp(561, ASP17_Lights.ASPLamp_BOMB)
asp17_30_lamp							= create_asp17_lamp(562, ASP17_Lights.ASPLamp_30)
asp17_NRS_lamp							= create_asp17_lamp(563, ASP17_Lights.ASPLamp_NRS)
asp17_GODEN_lamp						= create_asp17_lamp(571, ASP17_Lights.ASPLamp_GODEN)
asp17_USR_CHECK_lamp					= create_asp17_lamp(760, ASP17_Lights.ASPLamp_USR_Check)
asp17_GREEN_lamp						= create_asp17_lamp(679, ASP17_Lights.ASPLamp_Green)
asp17_YELLOW_lamp						= create_asp17_lamp(678, ASP17_Lights.ASPLamp_Yellow)



count = -1
PUVL_Lights = 
{
	Caution_Weap_On               = counter(),
	Weapon_Off                    = counter(),
	BD_1                          = counter(),
	BD_2                          = counter(),
	BD_3                          = counter(),
	BD_4                          = counter(),
	ControlOnOperator             = counter(),
	Operator_Bombs                = counter(),
	Operator_NRS                  = counter(),
	Operator_NPU30                = counter(),
	Operator_KMG                  = counter(),
	PUS_VZVED_LEFT                = counter(),
	PUS_VZVED_RIGHT               = counter(),
	PU_RELEASE_OK_LEFT            = counter(),
	PU_RELEASE_OK_RIGHT           = counter(),
	EMERG_EXPLODE_OPERATOR        = counter(),
	EMERG_EXPLODE_PILOT           = counter(),
	RedLamp_1                     = counter(),
	RedLamp_2                     = counter(),
	RedLamp_3                     = counter(),
	RedLamp_4                     = counter(),
	RedLamp_5                     = counter(),
	RestrictManeuver              = counter(),
	KMG_Loaded					  = counter(),
	KMG_Finished				  = counter(),
	PUVL_Lights_MAX               = counter()
}	

function create_puvl_lamp(arg_, param_)
	return create_simple_lamp(arg_, controllers.puvl_lights, param_)
end

weap_ON_lamp					= create_puvl_lamp(662, PUVL_Lights.Caution_Weap_On)
weap_OFF_lamp					= create_puvl_lamp(663, PUVL_Lights.Weapon_Off)
puvl_BD1_lamp					= create_puvl_lamp(544, PUVL_Lights.BD_1)
puvl_BD2_lamp					= create_puvl_lamp(543, PUVL_Lights.BD_2)
puvl_BD3_lamp					= create_puvl_lamp(540, PUVL_Lights.BD_3)
puvl_BD4_lamp					= create_puvl_lamp(539, PUVL_Lights.BD_4)
puvl_PUS1_lamp					= create_puvl_lamp(535, PUVL_Lights.PUS_VZVED_LEFT)
puvl_PUS2_lamp					= create_puvl_lamp(534, PUVL_Lights.PUS_VZVED_RIGHT)
puvl_EXPL_lamp					= create_puvl_lamp(548, PUVL_Lights.EMERG_EXPLODE_PILOT)

puvl_KMG_Loaded_lamp			= create_puvl_lamp(533, PUVL_Lights.KMG_Loaded)
puvl_KMG_Finished_lamp			= create_puvl_lamp(532, PUVL_Lights.KMG_Finished)

puvl_op_BD1_lamp				= create_puvl_lamp(137, PUVL_Lights.BD_1)
puvl_op_BD2_lamp				= create_puvl_lamp(138, PUVL_Lights.BD_2)
puvl_op_BD3_lamp				= create_puvl_lamp(139, PUVL_Lights.BD_3)
puvl_op_BD4_lamp				= create_puvl_lamp(140, PUVL_Lights.BD_4)
puvl_op_EXPLODE_lamp			= create_puvl_lamp(135, PUVL_Lights.EMERG_EXPLODE_OPERATOR)
puvl_op_Lamp_30_lamp			= create_puvl_lamp(703, PUVL_Lights.Operator_NPU30)
puvl_op_NRS_lamp				= create_puvl_lamp(705, PUVL_Lights.Operator_NRS)
puvl_op_BOMBS_lamp				= create_puvl_lamp(704, PUVL_Lights.Operator_Bombs)
puvl_op_KMG_POWERED_lamp		= create_puvl_lamp(707, PUVL_Lights.Operator_KMG)
puvl_op_KMG_Loaded_lamp			= create_puvl_lamp(706, PUVL_Lights.KMG_Loaded)
puvl_op_KMG_Finished_lamp		= create_puvl_lamp(708, PUVL_Lights.KMG_Finished)

puvl_op_PU_Left_Release_Ok		= create_puvl_lamp(766, PUVL_Lights.PU_RELEASE_OK_LEFT)
puvl_op_PU_Right_Release_Ok		= create_puvl_lamp(767, PUVL_Lights.PU_RELEASE_OK_RIGHT)

GUVReadyLamp1					= create_puvl_lamp(718, PUVL_Lights.RedLamp_1)
GUVReadyLamp2					= create_puvl_lamp(722, PUVL_Lights.RedLamp_2)
GUVReadyLamp3					= create_puvl_lamp(726, PUVL_Lights.RedLamp_3)
GUVReadyLamp4					= create_puvl_lamp(730, PUVL_Lights.RedLamp_4)
GUVReadyLamp5					= create_puvl_lamp(734, PUVL_Lights.RedLamp_5)


count = -1
R60_Lights = 
{
	Power_On               = counter(),
	Working                = counter(),
	Ready                  = counter(),
}	

function create_r60_lamp(arg_, param_)
	return create_simple_lamp(arg_, controllers.r60_lights, param_)
end

R60_ON_lamp					= create_r60_lamp(1031, R60_Lights.Power_On)
R60working_lamp				= create_r60_lamp(1029, R60_Lights.Working)
R60ready_lamp				= create_r60_lamp(1030, R60_Lights.Ready)


count = -1
SPO10_Lights = 
{
	Right_Front_DAY = counter(),
	Right_Back_DAY = counter(),
	Left_Back_DAY = counter(),
	Left_Front_DAY = counter(),
	Right_Front_NIGHT = counter(),
	Right_Back_NIGHT = counter(),
	Left_Back_NIGHT = counter(),
	Left_Front_NIGHT = counter(),
	No_Sound = counter(),
}

function create_spo10_lamp(arg_, param_)
	return create_simple_lamp(arg_, controllers.spo10_lights, param_)
end
spo10_Right_Front_DAY				= create_spo10_lamp(997, SPO10_Lights.Right_Front_DAY)
spo10_Right_Back_DAY				= create_spo10_lamp(998, SPO10_Lights.Right_Back_DAY)
spo10_Left_Back_DAY					= create_spo10_lamp(995, SPO10_Lights.Left_Back_DAY)
spo10_Left_Front_DAY				= create_spo10_lamp(996, SPO10_Lights.Left_Front_DAY)
spo10_Right_Front_NIGHT				= create_spo10_lamp(993, SPO10_Lights.Right_Front_NIGHT)
spo10_Right_Back_NIGHT				= create_spo10_lamp(994, SPO10_Lights.Right_Back_NIGHT)
spo10_Left_Back_NIGHT				= create_spo10_lamp(991, SPO10_Lights.Left_Back_NIGHT)
spo10_Left_Front_NIGHT				= create_spo10_lamp(992, SPO10_Lights.Left_Front_NIGHT)
spo10_No_Sound						= create_spo10_lamp(999, SPO10_Lights.No_Sound)


count = -1
ASO2V_Lights = 
{
	ASO2V_Left = counter(),
	ASO2V_Right = counter(),
}

function create_aso2V_lamp(arg_, param_)
	return create_simple_lamp(arg_, controllers.aso2V_lights, param_)
end
aso2V_Left				= create_aso2V_lamp(966, ASO2V_Lights.ASO2V_Left)
aso2V_Right				= create_aso2V_lamp(967, ASO2V_Lights.ASO2V_Right)

count = -1
URS_Control = 
{
	SightDoorsOpen             = counter(),
}

function create_URS_control_lamp(arg_, param_)
	return create_simple_lamp(arg_, controllers.URS_Control, param_)
end

SightDoorsOpenLamp = create_URS_control_lamp(754, URS_Control.SightDoorsOpen)

count = -1
OP_RightBoard_Lights = 
{
	L166B_Work     		       = counter(),
	L166B_Failure              = counter(),
	
	SCHO_9K113_COMPL_ON       	= counter(), --2
	SCHO_9K113_READY 	      	= counter(),
	SCHO_9K113_CHECK 	      	= counter(),
	SCHO_9K113_MSL_EXIST       	= counter(),
	SCHO_9K113_PU_OFF       	= counter(),
	SCHO_9K113_LAUNCH_PERM     	= counter(),
	
	PK_9K113_L1     			= counter(),--8
	PK_9K113_L2     			= counter(),
	PK_9K113_L3     			= counter(),
	PK_9K113_L4     			= counter(),
	PK_9K113_L5     			= counter(),
	PK_9K113_L6     			= counter(),
	PK_9K113_L7     			= counter(),
	PK_9K113_L8     			= counter(),
	PK_9K113_L9     			= counter(),
	PK_9K113_L10     			= counter(),
	PK_9K113_L11     			= counter(),
	PK_9K113_L12     			= counter(),
	PK_9K113_L13     			= counter(),
	PK_9K113_L14     			= counter(),
	
	
	SHTV_Tablo_Plus27V     		= counter(),--22
	SHTV_Tablo_0     			= counter(),
	SHTV_Tablo_04_K     		= counter(),
	SHTV_Tablo_04_T     		= counter(),
	SHTV_Tablo_Minus27V     	= counter(),
	SHTV_Tablo_APCH     		= counter(),
	SHTV_Tablo_UP     			= counter(),
	SHTV_Tablo_LEFT     		= counter(),
	SHTV_Tablo_DOWN     		= counter(),
	SHTV_Tablo_RIGHT     		= counter(),
	SHTV_Tablo_READY     		= counter(),
	SHTV_Tablo_CONTR     		= counter(),
	SHTV_Tablo_0K     			= counter(),
	SHTV_Tablo_0T     			= counter(),
	SHTV_Tablo_WORK     		= counter(),
	SHTV_Tablo_TOK     			= counter(),
}	

function create_op_right_board_lamp(arg_, param_)
	return create_simple_lamp(arg_, controllers.op_right_board_lights, param_)
end

op_L166B_work_lamp 						= create_op_right_board_lamp(868, OP_RightBoard_Lights.L166B_Work)
op_L166B_failure_lamp 					= create_op_right_board_lamp(869, OP_RightBoard_Lights.L166B_Failure)

op_SCHO_9K113_COMPL_ON_lamp 		= create_op_right_board_lamp(957, OP_RightBoard_Lights.SCHO_9K113_COMPL_ON)
op_SCHO_9K113_PU_OFF_lamp 			= create_op_right_board_lamp(958, OP_RightBoard_Lights.SCHO_9K113_PU_OFF)
op_SCHO_9K113_CHECK_lamp 			= create_op_right_board_lamp(959, OP_RightBoard_Lights.SCHO_9K113_CHECK)
op_SCHO_9K113_READY_lamp 			= create_op_right_board_lamp(960, OP_RightBoard_Lights.SCHO_9K113_READY)
op_SCHO_9K113_MSL_EXIST_lamp 		= create_op_right_board_lamp(961, OP_RightBoard_Lights.SCHO_9K113_MSL_EXIST)
op_SCHO_9K113_LAUNCH_PERM_lamp 		= create_op_right_board_lamp(962, OP_RightBoard_Lights.SCHO_9K113_LAUNCH_PERM)  	

op_PK_9K113_L1_lamp					= create_op_right_board_lamp(902, OP_RightBoard_Lights.PK_9K113_L1)
op_PK_9K113_L2_lamp					= create_op_right_board_lamp(901, OP_RightBoard_Lights.PK_9K113_L2)
op_PK_9K113_L3_lamp 				= create_op_right_board_lamp(888, OP_RightBoard_Lights.PK_9K113_L3)
op_PK_9K113_L4_lamp 				= create_op_right_board_lamp(889, OP_RightBoard_Lights.PK_9K113_L4)
op_PK_9K113_L5_lamp 				= create_op_right_board_lamp(898, OP_RightBoard_Lights.PK_9K113_L5)
op_PK_9K113_L6_lamp 				= create_op_right_board_lamp(904, OP_RightBoard_Lights.PK_9K113_L6)
op_PK_9K113_L7_lamp 				= create_op_right_board_lamp(900, OP_RightBoard_Lights.PK_9K113_L7)
op_PK_9K113_L8_lamp 				= create_op_right_board_lamp(894, OP_RightBoard_Lights.PK_9K113_L8)
op_PK_9K113_L9_lamp 				= create_op_right_board_lamp(896, OP_RightBoard_Lights.PK_9K113_L9)
op_PK_9K113_L10_lamp 				= create_op_right_board_lamp(897, OP_RightBoard_Lights.PK_9K113_L10)
op_PK_9K113_L11_lamp 				= create_op_right_board_lamp(891, OP_RightBoard_Lights.PK_9K113_L11)
op_PK_9K113_L12_lamp 				= create_op_right_board_lamp(892, OP_RightBoard_Lights.PK_9K113_L12)
op_PK_9K113_L13_lamp 				= create_op_right_board_lamp(895, OP_RightBoard_Lights.PK_9K113_L13)
op_PK_9K113_L14_lamp 				= create_op_right_board_lamp(893, OP_RightBoard_Lights.PK_9K113_L14)

op_SHTV_Tablo_Plus27V     			= create_op_right_board_lamp(915, OP_RightBoard_Lights.SHTV_Tablo_Plus27V)
op_SHTV_Tablo_0     				= create_op_right_board_lamp(918, OP_RightBoard_Lights.SHTV_Tablo_0)
op_SHTV_Tablo_04_K     				= create_op_right_board_lamp(924, OP_RightBoard_Lights.SHTV_Tablo_04_K)
op_SHTV_Tablo_04_T     				= create_op_right_board_lamp(923, OP_RightBoard_Lights.SHTV_Tablo_04_T)
op_SHTV_Tablo_Minus27V     			= create_op_right_board_lamp(914, OP_RightBoard_Lights.SHTV_Tablo_Minus27V)
op_SHTV_Tablo_APCH     				= create_op_right_board_lamp(922, OP_RightBoard_Lights.SHTV_Tablo_APCH)
op_SHTV_Tablo_UP     				= create_op_right_board_lamp(928, OP_RightBoard_Lights.SHTV_Tablo_UP)
op_SHTV_Tablo_LEFT     				= create_op_right_board_lamp(929, OP_RightBoard_Lights.SHTV_Tablo_LEFT)
op_SHTV_Tablo_DOWN     				= create_op_right_board_lamp(927, OP_RightBoard_Lights.SHTV_Tablo_DOWN)
op_SHTV_Tablo_RIGHT     			= create_op_right_board_lamp(930, OP_RightBoard_Lights.SHTV_Tablo_RIGHT)
op_SHTV_Tablo_READY     			= create_op_right_board_lamp(917, OP_RightBoard_Lights.SHTV_Tablo_READY)
op_SHTV_Tablo_CONTR     			= create_op_right_board_lamp(919, OP_RightBoard_Lights.SHTV_Tablo_CONTR)
op_SHTV_Tablo_0K     				= create_op_right_board_lamp(926, OP_RightBoard_Lights.SHTV_Tablo_0K)
op_SHTV_Tablo_0T     				= create_op_right_board_lamp(925, OP_RightBoard_Lights.SHTV_Tablo_0T)
op_SHTV_Tablo_WORK     	 			= create_op_right_board_lamp(920, OP_RightBoard_Lights.SHTV_Tablo_WORK)
op_SHTV_Tablo_TOK     		 		= create_op_right_board_lamp(921, OP_RightBoard_Lights.SHTV_Tablo_TOK)


create_simple_lamp(1026, controllers.TimerDeviceLamp)