
function make_MirageF1(rewrite_settings) 

local nose_gear_pos_l = {2.871,-2.140,0.0}
local main_gear_pos_l = {-2.070,-1.999,-1.221}

local weight_fuel_max_F1C = 3356

local net_animation = {}
do
	copyTable(F1_all_versions.net_animation, net_animation)
	
	-- Add single-seater specific net animation here
	-- net_animation[#net_animation + 1]	= XXX
end

local Failures = {}
do
	copyTable(F1_all_versions.Failures, Failures)

	-- Add single-seater specific failures here
	-- Failures[#Failures + 1] = {...}
end

local lights_data = {}
do
	copyTable(F1_all_versions.lights_data, lights_data)

	-- Add single-seater specific lights data here
	-- lights_data[#lights_data + 1] = {...}
end

local rewrite_settings = rewrite_settings or {Shape = 'Mirage-F1', Name = 'Mirage-F1C', WorldID = WSTYPE_PLACEHOLDER}
local Mirage_F1 = {
	
	EmptyWeight 				= "7887", --"8190",
    MaxFuelWeight 				= string.format("%d", weight_fuel_max_F1C),
    MaxHeight 					= "15240",
    MaxSpeed 					= "2220",
    MaxTakeOffWeight 			= "16200",
        
	Name 						= 'Mirage-F1C',
	DisplayName					= _('Mirage F1C'),
		
	ViewSettings				= ViewSettings,	
			
	Picture 					= "Mirage-F1.png",
	Rate 						= F1_all_versions.Rate,
	Shape 						= "Mirage-F1",
	input_profile_entry 		= rewrite_settings.Name,
		
---------------------------------------------------------------------------------------------------------------------------------------------	
	shape_table_data = 
	{
		{
			file  	    		= rewrite_settings.Shape   or 'Mirage-F1',
			name    			= rewrite_settings.Name    or 'Mirage-F1C',
			username    		= rewrite_settings.Name    or 'Mirage-F1C',
			index       		= rewrite_settings.WorldID or WSTYPE_PLACEHOLDER,
			life  	 			= F1_all_versions.shape_table_data[1].life,
			vis   	 			= F1_all_versions.shape_table_data[1].vis,
			desrt    			= 'Mirage-F1_destr', -- Name of destroyed object file name
			fire  	 			= F1_all_versions.shape_table_data[1].fire,
			classname 			= F1_all_versions.shape_table_data[1].classname,
			positioning 		= F1_all_versions.shape_table_data[1].positioning,
		},
		{
			name  				= "Mirage-F1_destr",
			file  				= "Mirage-F1_destr",
			fire  				= F1_all_versions.shape_table_data[2].fire,
			classname 			= F1_all_versions.shape_table_data[2].classname,
			positioning 		= F1_all_versions.shape_table_data[2].positioning,
		},

	},
---------------------------------------------------------------------------------------------------------------------------------------------	
	mapclasskey 				= F1_all_versions.mapclasskey,
    attribute 					= makeAttribute(rewrite_settings.WorldID or WSTYPE_PLACEHOLDER),
	Categories 					= F1_all_versions.Categories,
---------------------------------------------------------------------------------------------------------------------------------------------
	M_empty 					= 7887, --8190, -- kg    -------18056 lbs "MVE" + pilot + "obus" 7950 + 95 + 145
	M_nominal 					= 11492, -- kg   -------25340 lbs Empty weight + max fuel
	M_max 						= 16200, -- kg   -------35715 lbs MTOW
	M_fuel_max 					= weight_fuel_max_F1C,
	H_max 					 	= F1_all_versions.H_max,
	average_fuel_consumption 	= F1_all_versions.average_fuel_consumption,
	CAS_min 					= F1_all_versions.CAS_min,
	V_opt 						= F1_all_versions.V_opt,
	V_take_off 					= 95, -- Take off speed in m/s (for AI)
	V_land 						= 95, -- Land speed in m/s (for AI)
	V_max_sea_level 			= 360, -- Max speed at sea level in m/s (for AI) 700 kts 0-20000 ft
	V_max_h 					= 386, -- Max speed at max altitude in m/s (for AI) 750 kts above 20000 ft
	Vy_max 						= 243, -- Max climb speed in m/s (for AI)
	Mach_max 					= F1_all_versions.Mach_max,
	Ny_min 						= F1_all_versions.Ny_min,
	Ny_max 						= F1_all_versions.Ny_max,
	Ny_max_e 					= F1_all_versions.Ny_max_e,
	AOA_take_off 				= 0.20944, -- AoA in take off (for AI) radians --12ยบ pitch attitude according to flight manual, 13ยบ according to performance manual
	bank_angle_max 				= F1_all_versions.bank_angle_max,

	has_afteburner 				= F1_all_versions.has_afteburner,
	has_speedbrake 				= F1_all_versions.has_speedbrake,
	has_differential_stabilizer = F1_all_versions.has_differential_stabilizer,
	bigParkingRamp				= F1_all_versions.bigParkingRamp,
	
	stores_number				= F1_all_versions.stores_number,
	brakeshute_name				= F1_all_versions.brakeshute_name,

	tanker_type					= F1_all_versions.tanker_type,
	is_tanker 					= F1_all_versions.is_tanker,
	
	wing_area 					= F1_all_versions.wing_area,
	wing_span 					= F1_all_versions.wing_span,
	wing_type 					= F1_all_versions.wing_type,
	length 						= F1_all_versions.length,
	height 						= F1_all_versions.height,
	flaps_maneuver 				= F1_all_versions.flaps_maneuver,
	range 						= F1_all_versions.range,
	RCS 						= F1_all_versions.RCS,
	IR_emission_coeff 			= F1_all_versions.IR_emission_coeff,
	IR_emission_coeff_ab 		= F1_all_versions.IR_emission_coeff_ab,
	wing_tip_pos 				= F1_all_versions.wing_tip_pos,

	engines_count				= F1_all_versions.engines_count,
	thrust_sum_max 				= F1_all_versions.thrust_sum_max,
	thrust_sum_ab 				= F1_all_versions.thrust_sum_ab,
	
	----------------- LANDING GEAR
	nose_gear_pos 				= nose_gear_pos_l,
	main_gear_pos 				= main_gear_pos_l,
	
	nose_gear_amortizer_direct_stroke    =  2.281 + nose_gear_pos_l[2],  -- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke  =  1.978 + nose_gear_pos_l[2],  -- up 
	main_gear_amortizer_direct_stroke	 =  2.072 + main_gear_pos_l[2], --  down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke  = 	1.860 + main_gear_pos_l[2], --  up 
	nose_gear_amortizer_normal_weight_stroke = F1_all_versions.nose_gear_amortizer_normal_weight_stroke,
	main_gear_amortizer_normal_weight_stroke = F1_all_versions.main_gear_amortizer_normal_weight_stroke,

	nose_gear_wheel_diameter 	= F1_all_versions.nose_gear_wheel_diameter,
	main_gear_wheel_diameter 	= F1_all_versions.main_gear_wheel_diameter,

	tand_gear_max 				= F1_all_versions.tand_gear_max,
	
	net_animation 				= net_animation,

	engines_nozzles 			= F1_all_versions.engines_nozzles,

	crew_size	 				= 1,
	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name 				= "Mirage-F1_pilot+ejectionseat",
			pilot_name		   				= "Mirage-F1_pilot_01",			
			drop_canopy_name 				= "Mirage-F1_canopy_ejected",
			
			drop_parachute_name 			= "Mirage-F1_parachute",			
			pos 							= {3.192, -0.013, -0.02},
			canopy_pos 						= {2.312, 0.625, 0},
			can_be_playable 	 			= true,				
			bailout_arg 		 			= -1,
			canopy_arg           			= 38,
			ejection_play_arg    			= 149,
			ejection_through_canopy 		= true,
			ejection_added_speed 			= {-5, 30, 0},
			ejection_order 		 			= -1,
			role 				 			= "pilot",
			role_display_name    			= _("Pilot"),	
			g_suit 			     			= g_suit_effectiveness,
			
			pilot_body_arg					= 50,
			boarding_arg					= 38,
			canopy_args						= {38, 1},
			canopy_ejection_dir				= {-0.4, 1.0, 0.0},
		}, -- end of [1]
	}, -- end of crew_members

	fires_pos 					= F1_all_versions.fires_pos,
	
	effects_presets 			= F1_all_versions.effects_presets,

	-- Countermeasures
	passivCounterm 				= F1_all_versions.passivCounterm,
	chaff_flare_dispenser 		= F1_all_versions.chaff_flare_dispenser,
	
	-- Sensors
	detection_range_max		 	= F1_all_versions.detection_range_max,
	radar_can_see_ground 	 	= F1_all_versions.radar_can_see_ground,
	
	Sensors						= F1_all_versions.Sensors,
	
	CanopyGeometry				= F1_all_versions.CanopyGeometry,
	
	HumanRadio 					= F1_all_versions.HumanRadio,
	
	panelRadio 					= panelRadio_CE_BE_EE,
	
---------------------------------------------------------------------------------------------------------------------------------------------	
	Guns 						= declareGuns(rewrite_settings.Name or 'Mirage-F1C'),
	
	Pylons 						= Pylons_C_B,
	
---------------------------------------------------------------------------------------------------------------------------------------------	
	Tasks = {
        aircraft_task(GroundAttack),
        aircraft_task(RunwayAttack),
        aircraft_task(PinpointStrike),
        aircraft_task(CAS),
        aircraft_task(AFAC),
		aircraft_task(CAP),
        aircraft_task(Escort),
        aircraft_task(FighterSweep),
        aircraft_task(Intercept),
    },	
	DefaultTask 				= aircraft_task(CAP),
	
---------------------------------------------------------------------------------------------------------------------------------------------	
	SFM_Data = {
		aerodynamics = 
		{
			Cy0	=	0,           -- zero AoA lift coefficient (positive for low M and slightly negative for high M, so 0)
			Mzalfa	=	6.6,     -- coefficients for pitch agility 6.6
			Mzalfadt	=	1,   -- coefficients for pitch agility 1. Higher value, higher inertia (takes more time to recover pitch)
			kjx	=	2.85,        -- affects roll inertia - smaller = massive inertia
			kjz	=	0.00125,     -- affects pitch inertia
			Czbe	=	-0.012,  -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear	=	0.032,   -- coefficient, drag, gear
			cx_flap	=	0.05,    -- coefficient, drag, full flaps
			cy_flap	=	0.6,     -- coefficient, normal force, lift, flaps
			cx_brk	=	0.04,   -- coefficient, drag, air brake
			table_data = 
			{
			--      	 M	     Cx0	 Cya	 B	     B4	   Omxmax Aldop Cymax
				[1] = 	{0,	    0.0230,	0.0625,	0.144,	0.0000,	0.5,	25,	2.0}, 
				[2] = 	{0.1,	0.0230,	0.0625,	0.144,	0.0000,	0.5,	25,	2.0}, -- 66 kts
				[3] = 	{0.2,	0.0230,	0.0625,	0.144,	0.0000,	1.5,	25,	2.0}, -- 132 kts
				[4] = 	{0.23,	0.0230,	0.0625,	0.144,	0.0000,	1.5,	25,	2.0}, -- 150 kts
				[5] = 	{0.4,	0.0230,	0.07,	0.144,	0.0000,	2.5,	24,	2.0},
				[6] = 	{0.6,	0.0230,	0.072,	0.144,	0.0000,	3.5,	22,	2.0},
				[7] = 	{0.7,	0.0230,	0.071,	0.144,	0.0000,	3.5,	21,	1.71},
				[8] = 	{0.8,	0.0200,	0.071,	0.200,	0.0001,	3.5,	17,	1.5},
				[9] = 	{0.9,	0.0198,	0.071,	0.212,	0.0000,	3.5,	17,	1.25},
				[10] = 	{0.95,	0.0204,	0.073,	0.224,	-0.0015,	3.5,	17,	1.25},
				[11] = 	{1,	    0.0354,	0.076,	0.238,	-0.0009,	3.5,	17,	0.99},
				[12] = 	{1.05,	0.038,	0.07,	0.244,	-0.0014,	3.5,	17,	0.94},
				[13] = 	{1.1,	0.038,	0.064,	0.246,	-0.0006,	3.15,	17,	0.91},
				[14] = 	{1.2,	0.037,	0.065,	0.27,	-0.0007,	2.45,	17,	0.74},
				[15] = 	{1.3,	0.036,	0.065,	0.29,	0.0001,	1.75,	16,	0.62},
				[16] = 	{1.5,	0.038,	0.065,	0.348,	0.0000,	1.5,	13,	0.487},
				[17] = 	{1.8,	0.0344,	0.052,	0.442,	-0.0004,	0.86,	11.4,	0.385},
				[18] = 	{2,	    0.0324,	0.042,	0.506,	0.0000,	0.78,	10.2,	0.33},
				[19] = 	{2.2,	0.032,	0.034,	0.55,	0.0000,	0.7,	9,	0.3},
				[20] = 	{2.3,	0.031,	0.028,	0.6,	0.0000,	0.7,	9,	0.225},
				[21] = 	{2.5,	0.0298,	0.025,	0.646,	0.0001,	0.7,	9,	0.225},
				--[21] = 	{3,	    0.03,	0.033,	0.63,	1e-005,	0.7,	9,	0.4},
				--[22] = 	{3.9,	0.03,	0.033,	0.63,	1e-005,	0.7,	9,	0.4},
			}, -- end of table_data
			
			-- M - Mach number
			-- Cx0 - Coefficient, drag, profile, of the airplane
			-- Cya - dClift/dAoA Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
			-- B - Polar quad coeff
			-- B4 - Polar 4th power coeff
			-- Omxmax - roll rate, rad/s
			-- Aldop - Alfadop Max AOA at current M - departure threshold
			-- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
			
		}, -- end of aerodynamics
---------------------------------------------------------------------------------------------------------------------------------------------		
		engine = F1_all_versions.SFM_Data.engine,
	},
---------------------------------------------------------------------------------------------------------------------------------------------	
	--damage , index meaning see in  Scripts\Aircrafts\_Common\Damage.lua
	Damage = {
		------------- nose
		[0]  = {critical_damage = 5, args = {82}},						-- nose center
		[1]  = {critical_damage = 5, args = {150}},						-- nose left
		[2]  = {critical_damage = 5, args = {146}},						-- nose right
		[59] = {critical_damage = 5, args = {148}},						-- nose bottom--front glass			
		[3]  = {critical_damage = 20, args = {65}},						-- cockpit
		[4]  = {critical_damage = 10, args = {298}},					-- cabin left
		[5]  = {critical_damage = 10, args = {299}},					-- cabin right
		[6]  = {critical_damage = 10, args = {297}},					-- cabin bottom		

		[68]  = {critical_damage = 5, args = {151}},					-- Refueling
		
		[71] = {critical_damage = 5, args = {145}},						-- 	

		[74] = {critical_damage = 5, args = {144}},						--Antenna 		
		
		[7]  = {critical_damage = 4, args = {296}},						-- Gun		

		-------------  fuselage
		[66] = {critical_damage = 10, args = {180}},					-- BLADE_1_OUT---------INTAKE RIGHT
		[64] = {critical_damage = 10, args = {181}},					-- BLADE_1_IN---------INTAKE LEFT		
		[67] = {critical_damage = 10, args = {171}},					-- BLADE_2_IN---------INTAKE RIGHT
		[69] = {critical_damage = 10, args = {170}},					-- BLADE_2_OUT---------INTAKE LEFT		
		
		[19] = {critical_damage = 4, args = {183}},									-- airbrake left
		[20] = {critical_damage = 4, args = {185}},									-- airbrake right		

		[9]  = {critical_damage = 8, args = {154}, deps_cells = {15,19}},				-- fuselage left
		[10] = {critical_damage = 8, args = {153}, deps_cells = {16,20}},				-- fuselage right
		[82] = {critical_damage = 8, args = {152}},										-- fuselage bottom		
		
		[61] = {critical_damage = 7,  args = {224}},	-- FUEL_TANK_LEFT_SIDE
		[62] = {critical_damage = 7,  args = {214}},	-- FUEL_TANK_RIGHT_SIDE
		
		[65] = {critical_damage = 7,  args = {155}},	-- FUEL_TANK_CENTER (BLADE_1_CENTER)		
		
		[56] = {critical_damage = 10, args = {158}},					-- Tail left
		[57] = {critical_damage = 10, args = {157}},					-- Tail right
		[58] = {critical_damage = 10, args = {156}},					-- Tail bottom
		
		[18] = {critical_damage = 10, args = {249}},--MTG_R
		[17] = {critical_damage = 10, args = {250}},--MTG_L	
		[13] = {critical_damage = 10, args = {251}},--MTG_L_BOTTOM
		
---------------------------------------------WINGS----------------------------------------------------------
		-------------  Left wing
		[23] = {critical_damage = 3, args = {223}, deps_cells = {27}},						-- Wing out left
		[29] = {critical_damage = 5, args = {224}, deps_cells = {25,21,33,37}},			-- Wing center left
		[35] = {critical_damage = 7, args = {225}, deps_cells = {25,21,33,37,31,27}},	-- Wing in left
		
		[27] = {critical_damage = 3, args = {230}},									-- Slat center left
		[21] = {critical_damage = 5, args = {232}},									-- Slat out left
		[33] = {critical_damage = 7, args = {231}},								    -- Spoiler 		

		[25] = {critical_damage = 3, args = {226}},									-- Aileron left
		[37] = {critical_damage = 4, args = {227}},									-- Flap in left
		[31] = {critical_damage = 3, args = {219}},									-- FLAP_L_OUT
		


		-------------  Right wing
		[24] = {critical_damage = 3, args = {213}, deps_cells = {28}},						-- Wing out right
		[30] = {critical_damage = 5, args = {214}, deps_cells = {26,22,34,38}},			-- Wing center right
		[36] = {critical_damage = 7, args = {215}, deps_cells = {26,22,34,38,32,25}},	-- Wing in right

		
		[28] = {critical_damage = 3, args = {220}},									-- Slat center left	
		[22] = {critical_damage = 5, args = {222}},									-- Slat out left
		[34] = {critical_damage = 7, args = {221}},								    -- Spoiler		

		[26] = {critical_damage = 3, args = {216}},									-- aileron right
		[38] = {critical_damage = 4, args = {217}},									-- flap in right
		[32] = {critical_damage = 3, args = {218}},									-- FLAP_R_OUT
		
	

---------------------------------------------ELEVATOR-------------------------------------------------------
		-------------  Left stabilizer
		[49] = {critical_damage = 4, args = {239}},									-- elevator out left
		[51] = {critical_damage = 5, args = {240}, deps_cells = {49}},				-- elevator in left	

		-------------  Right stabilizer
		[50] = {critical_damage = 4, args = {237}},									-- elevator out right
		[52] = {critical_damage = 5, args = {238}, deps_cells = {50}},				-- elevator in right	
		
---------------------------------------------CREW-----------------------------------------------------------
		[90] = {critical_damage = 4, args = {400}},--CREW_1		
---------------------------------------------GEAR-----------------------------------------------------------
		[8]  = {critical_damage = 6, args = {265}, deps_cells = {83}},	-- FRONT_GEAR_BOX
		[15] = {critical_damage = 6, args = {267}, deps_cells = {84}},	-- LEFT_GEAR_BOX
		[16] = {critical_damage = 6, args = {266}, deps_cells = {85}},	-- RIGHT_GEAR_BOX
		[83] = {critical_damage = 3, args = {134}},						-- WHEEL F
		[84] = {critical_damage = 3, args = {135}},						-- WHEEL L
		[85] = {critical_damage = 3, args = {136}},						-- WHEEL R
---------------------------------------------ENGINE-----------------------------------------------------
		[11] = {critical_damage = 5, args = {271}},									-- engine
		
---------------------------------------------FIN/RUDDER-----------------------------------------------------
		[39] = {critical_damage = 4, args = {244}}, 									-- fin top right
		[41] = {critical_damage = 4, args = {245},deps_cells = {53}},					-- FIN_L_CENTER		
		[43] = {critical_damage = 5, args = {246},deps_cells = {53}},					-- fin bottom left		
		[53] = {critical_damage = 3, args = {248}},										-- RUDDER
	},

	DamageParts = 
	{  
		[1000 + 0] = "miragef1-oblomok-nose",
		[1000 + 51] = "miragef1-oblomok-left-elevator",
		[1000 + 52] = "miragef1-oblomok-right-elevator",
		[1000 + 43] = "miragef1-oblomok-tail",
		[1000 + 35] = "miragef1-oblomok-left-wing",
		[1000 + 36] = "miragef1-oblomok-right-wing",
		[1000 + 19] = "miragef1-oblomok-left-airbrake",
		[1000 + 20] = "miragef1-oblomok-right-airbrake",

	},

	Failures 					= Failures,
	lights_data 				= lights_data,
	AddPropAircraft 			= F1_all_versions.AddPropAircraft,
}

applyRewriteSettings(rewrite_settings, Mirage_F1)

if Mirage_F1.Name == 'Mirage-F1C' then
	Mirage_F1.Countries = {"France"} --prevent adding this unit for all countries, it is already added in db_countries
end

add_aircraft(Mirage_F1)
end

make_MirageF1()
---------------------------------------------------------------------------------------------------------------------------------------------
