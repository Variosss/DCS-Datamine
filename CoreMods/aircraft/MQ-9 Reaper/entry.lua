declare_plugin("MQ-9 Reaper AI",
{
installed 	 	  = true, -- if false that will be place holder , or advertising
state		 	  = "installed",
developerName	  = "Eagle Dynamics",
version		 	  = __DCS_VERSION__,		 
})


Reaper =  {
        
	Name 				=   'MQ-9 Reaper',
	DisplayName			= _('MQ-9 Reaper'),
	Picture 			= "MQ-9_Reaper.png",
	Rate 				=  40, -- RewardPoint in Multiplayer
	Shape 				= "mq-9_reaper",
	shape_table_data 	= 
	{
		{
			file  	 	= 'mq-9_reaper';
			life  	 	= 18; -- lifebar
			vis   	 	= 3; -- visibility gain.
			desrt    	= 'self'; -- Name of destroyed object file name
			fire  	 	= { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username	= 'MQ-9 Reaper';
			index    	=  WSTYPE_PLACEHOLDER;
			classname 	= "lLandPlane";
			positioning = "BYNORMAL";
			drawonmap 	= true;
		},
	},
    mapclasskey 		= "P0091000023",
 	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER ,"Battleplanes","UAVs"},

	country_of_origin	= "USA",

	M_empty 					= 2223 , -- kg
	M_nominal 					= 4273, -- kg
	M_max 						= 4760, -- kg
	M_fuel_max 					= 1300, -- kg --2225
	H_max 					 	= 15000, -- m
	average_fuel_consumption 	= 0.302, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
	CAS_min 					= 100/3.6, -- if this is not OVERAL FLIGHT TIME, but jus LOITER TIME, than it sholud be 10-15 minutes.....CAS capability in minute (for AI)
	V_opt 						= 80,-- Cruise speed (for AI)
	V_take_off 					= 100/3.6, -- Take off speed in m/s (for AI)
	V_land 						= 100/3.6, -- Land speed in m/s (for AI)
	V_max_sea_level 			= 400/3.6, -- Max speed at sea level in m/s (for AI)
	V_max_h 					= 400/3.6, -- Max speed at max altitude in m/s (for AI)
	Vy_max 						= 5, -- Max climb speed in m/s (for AI)
	Mach_max 					= 0.4, -- Max speed in Mach (for AI)
	Ny_min 						= -1, -- Min G (for AI)
	Ny_max 						= 3,  -- Max G (for AI)
	Ny_max_e 					= 2,  -- Max G (for AI)
	AOA_take_off 				= 3/57.3, -- AoA in take off (for AI)
	bank_angle_max 				= 30, -- Max bank angle (for AI)


	has_afteburner 				= false, -- AFB yes/no
	has_speedbrake 				= false, -- Speedbrake yes/no
	has_differential_stabilizer	= false, -- differential stabilizers
	
	nose_gear_pos 				= {2.504 , -1.978,	0}, -- nosegear coord
	main_gear_pos 				= {-0.628, -2.046,  1.888}, -- main gear coords
	
	nose_gear_amortizer_direct_stroke    	 =  0,  -- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke  	 = -0.196,  -- up 
	main_gear_amortizer_direct_stroke		 =  0, --  down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke  	 = 	0, --  up 
	nose_gear_amortizer_normal_weight_stroke = -0.075,
	
	tand_gear_max 				= 0.577,
	wing_area 					= 23.52, -- wing area in m2
	wing_span 					= 20, -- wing spain in m
	wing_type 					= 0,
	thrust_sum_max 				= 8224, -- thrust in kg (44kN)
	thrust_sum_ab 				= 8224, -- thrust inkg (71kN)
	length 						= 11, -- full lenght in m
	height 						= 4.77, -- height in m
	flaps_maneuver 				= 0.5, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
	range 						= 5920, -- Max range in km (for AI)
	RCS 						= 0.5, -- Radar Cross Section m2
	IR_emission_coeff 			= 0.1, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 0, -- With afterburner
	wing_tip_pos 				= {-1.1,	0,	10}, -- wingtip coords for visual effects
	nose_gear_wheel_diameter 	= 0.319, -- in m
	main_gear_wheel_diameter 	= 0.683, -- in m
	brakeshute_name 			= 0, -- Landing - brake chute visual shape after separation
	engines_count				= 1, -- Engines count
	engines_nozzles = {
		[1] = 
		{
			pos 		=  {1.97,-0.09,-0.56}, -- nozzle coords
			elevation   =  0, -- AFB cone elevation
			diameter	 = 0*0.1, -- AFB cone diameter
			exhaust_length_ab   = -3.0, -- lenght in m
			exhaust_length_ab_K = 0.3, -- AB animation
			engine_number  = 1, --both to first engine
		}, -- end of [1]
	}, -- end of engines_nozzles
	crew_members =  --UAV
	{
	}, -- end of crew_members

	fires_pos = 
	{
		[1] = 	{1,	0.5,0},
		[2] = 	{0.6 ,-0.25,	0.95},
		[3] = 	{-0.1,-0.3 ,	0.95},
		[4] = 	{2,	-0.5,	0.4},
		[5] = 	{-0.4,	-0.25,	-2},
		[6] = 	{-1.9,	-0.18,	0.4},
		[7] = 	{-1.9,	-0.18, -0.4},
		[8] = 	{1.7,	-0.1,	0.55},
		[9] = 	{1.7,	-0.1,  -0.55},
		[10] = 	{-5,	0.5,	0},
		[11] = 	{-5,	0.5,	0},
	}, -- end of fires_pos
	
		        
    singleInFlight = true,
	
 	detection_range_max		 = 0,
	radar_can_see_ground 	 = true, -- this should be examined (what is this exactly?)
	CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_BAD, LOOK_BAD, LOOK_BAD),
    Sensors = {
            OPTIC = {"RQ-1 Predator CAM", "RQ-1 Predator FLIR"},
            RADAR =  "RQ-1 Predator SAR"
    },
	laserEquipment = 
	{
		laserDesignator  = true,
	},	
	Pylons = 
    {
        pylon(1, 0, -0.297847, -0.481713, -2.223118,{arg = 308, arg_value = 0,use_full_connector_position=true},
            {
                { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",arg_value = 1  ,connector = "Pylon1_gbu12" },--GBU-12
                { CLSID = "{GBU-38}"							  ,arg_value = 1  ,connector = "Pylon1_gbu12" },--Connectors named Pylonx_gbu38 are offset too far forward
				{ CLSID = "AGM114x2_OH_58"						  ,arg_value = 0.5,connector = "Pylon1_m272"  },--M272 AGM-114x2
				{ CLSID	= "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}",arg_value = 0.5,connector = "Pylon1_m299"  },--M299 AGM-114x4							
            }
        ),
        pylon(2, 0, -0.283242, -0.492762, -1.297102,{arg = 309, arg_value = 0,use_full_connector_position=true},
            {
                { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",arg_value = 1  ,connector = "Pylon2_gbu12" },--GBU-12
                { CLSID = "{GBU-38}"							  ,arg_value = 1  ,connector = "Pylon2_gbu12" },
				{ CLSID = "AGM114x2_OH_58"						  ,arg_value = 0.5,connector = "Pylon2_m272"  },--M272 AGM-114x2
			  --{ CLSID	= "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}",arg_value = 0.5,connector = "Pylon2_m299"  },--M299 AGM-114x4 conflict with gear
            }
        ),
		pylon(3, 0, -0.283242, -0.492762,  1.297102,{arg = 310, arg_value = 0,use_full_connector_position=true},
            {
                { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",arg_value = 1  ,connector = "Pylon3_gbu12" },--GBU-12
                { CLSID = "{GBU-38}"							  ,arg_value = 1  ,connector = "Pylon3_gbu12" },
				{ CLSID = "AGM114x2_OH_58"						  ,arg_value = 0.5,connector = "Pylon3_m272"  },--M272 AGM-114x2
			  --{ CLSID	= "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}",arg_value = 0.5,connector = "Pylon3_m299"  },--M299 AGM-114x4 conflict with gear							
             }
        ),
		pylon(4, 0, -0.297847, -0.481713,  2.223118,{arg = 311, arg_value = 0,use_full_connector_position=true},
            {
                { CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",arg_value = 1  ,connector = "Pylon4_gbu12" },--GBU-12
                { CLSID = "{GBU-38}"							  ,arg_value = 1  ,connector = "Pylon4_gbu12" },
				{ CLSID = "AGM114x2_OH_58"						  ,arg_value = 0.5,connector = "Pylon4_m272"  },--M272 AGM-114x2
				{ CLSID	= "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}",arg_value = 0.5,connector = "Pylon4_m299"  },--M299 AGM-114x4							
             }
        ),
    },
	EPLRS = true,
	Tasks = {
		aircraft_task(GroundAttack),
        aircraft_task(CAS),
        aircraft_task(AFAC),
		aircraft_task(Reconnaissance),
    },	
	DefaultTask = aircraft_task(Reconnaissance),

	SFM_Data =
	{
		aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		{
			Cy0			=	0.3,
			Mzalfa		=	6.6,
			Mzalfadt	=	1,
			kjx	=	2.85,
			kjz	=	0.00125,
			Czbe	=	-0.012,
			cx_gear	=	0.002,
			cx_flap	=	0.01,
			cy_flap	=	0.3,
			cx_brk	=	0.025,
			table_data = 
			{--  M		Cx0		Cya		B		B4	   Omxmax	Aldop		Cymax
				{0	,	0.026,	0.12,	0.0227,	0.0001,	1,		20,	1.4},
				{0.4,	0.026,	0.12,	0.0227,	0.0001,	1,		20,	1.4},
				{1	,	0.026,	0.12,	0.0227,	0.0001,	1,		20,	1.4},
			}, -- end of table_data
		}, -- end of aerodynamics
		engine = 
		{
			Nmg		=	20.5, -- RPM at idle
			MinRUD	=	0, -- Min state of the throttle
			MaxRUD	=	1, -- Max state of the throttle
			MaksRUD	=	1, -- Military power state of the throttle
			ForsRUD	=	1, -- Afterburner state of the throttle
			type	=	"TurboProp",
			hMaxEng	=	17, -- Max altitude for safe engine operation in km
			dcx_eng	=	0.015, -- Engine drag coeficient
			cemax	=	0.37, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	0.37, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	1800, --  altitude coefficient for max thrust
			dpdh_f	=	1800,  --  altitude coefficient for AB thrust
			
			k_adiab_1			= 0.037923,
			k_adiab_2			= 0.0562,
			MAX_Manifold_P_1	= 180000,		
			MAX_Manifold_P_2	= 180000,		
			MAX_Manifold_P_3	= 180000,		
			k_after_cool		= 0.0,
			Displ				= 35,
			k_Eps				= 6.5,
			Stroke				= 0.165,
			V_pist_0			= 13,
			Nu_0				= 1.2,
			Nu_1				= 0.9,
			Nu_2				= 0.001,
			N_indic_0			= 1052480,
			N_fr_0				= 0.04,
			N_fr_1				= 0.001,
			Init_Mom			= 220,
			D_prop				= 3.5,
			MOI_prop			= 45,
			k_gearbox			= 2.4,
			P_oil				= 495438,
			k_boost				= 3,
			k_cfug				= 0.003,
			k_oil				= 0.00004,
			k_piston			= 3000,
			k_reg				= 0.003,
			k_vel				= 0.017,
			table_data = 
			{
			--   M			Pmax
				{0.0,		16620.0},
				{0.1,		15600.0},
				{0.2,		14340.0},
				{0.3,		13320.0},
				{0.4,		12230.0},
				{0.5,		11300.0},
				{0.6,		10600.0},
				{0.7,		10050.0},
				{0.8,		 9820.0},
				{0.9,		 5902.0},
				{1.9,		 3469.0}
			}
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},
	--damage , index meaning see in  Scripts\Aircrafts\_Common\Damage.lua
	Damage  = verbose_to_dmg_properties({
		--fuselage
		["NOSE_CENTER"]  		 = {critical_damage = 1  ,args = {148},droppable = false}, -- sensor ball 
		["NOSE_TOP"]  	 		 = {critical_damage = 2  ,args = {147}},
		["NOSE_Bottom"]  		 = {critical_damage = 2  ,args = {147}},
		["FUSELAGE_TOP"] 	  	 = {critical_damage = 5  ,args = {151}},
		["FUSELAGE_BOTTOM"] 	 = {critical_damage = 5  ,args = {152}},
	
		["TAIL_TOP"]  	 		 = {critical_damage = 5	 ,args = {115}},
		["TAIL_BOTTOM"]  		 = {critical_damage = 5  ,args = {156}},
		
		["FRONT_GEAR_BOX"]  	 = {critical_damage = 5  ,},
		["LEFT_GEAR_BOX"]  	 	 = {critical_damage = 5  ,},
		["RIGHT_GEAR_BOX"]  	 = {critical_damage = 5  ,},

		
		["ROTOR"] 				 = {critical_damage = 3  ,args = {271},deps_cells = {"BLADE_1_OUT","BLADE_2_OUT","BLADE_3_OUT"}},
		["BLADE_1_OUT"] 		 = {critical_damage = 1  ,droppable = false},
		["BLADE_2_OUT"] 		 = {critical_damage = 1  ,droppable = false},
		["BLADE_3_OUT"] 		 = {critical_damage = 1  ,droppable = false},

		["STABILIZATOR_L_IN"]	 = {critical_damage = 5  ,args = {246},deps_cells = {"ELEVATOR_L_IN","ELEVATOR_L_OUT"}},
		["ELEVATOR_L_IN"]	 	 = {critical_damage = 2  ,args = {239},droppable = false},
		["ELEVATOR_L_OUT"]	 	 = {critical_damage = 2  ,args = {240},droppable = false},
		["STABILIZATOR_R_IN"]	 = {critical_damage = 5  ,args = {243},deps_cells = {"ELEVATOR_R_IN","ELEVATOR_R_OUT"}},
		["ELEVATOR_R_IN"]	 	 = {critical_damage = 2  ,args = {237},droppable = false},
		["ELEVATOR_R_OUT"]	     = {critical_damage = 2  ,args = {238},droppable = false},

		["RUDDER_R"]	 		 = {critical_damage = 3  ,args = {247},deps_cells = {"RUDDER"}},
		["RUDDER"]	 			 = {critical_damage = 1  ,args = {224}},
		--left wing
		["WING_L_OUT"]	 		 = {critical_damage = 5  ,args = {213},deps_cells = {"FLAPS_L_OUT"	,"WING_L_CENTER"}},
		["WING_L_CENTER"] 		 = {critical_damage = 5  ,args = {214},deps_cells = {"FLAPS_L_CENTER","FLAPS_L_IN","WING_L_IN"}},
		["WING_L_IN"] 			 = {critical_damage = 5  ,args = {223},deps_cells = {"AILERON_L"},droppable = false},
		["FLAPS_L_OUT"]	 		 = {critical_damage = 2  ,args = {226},droppable = false},
		["FLAPS_L_CENTER"] 		 = {critical_damage = 2  ,args = {227},droppable = false},
		["FLAPS_L_IN"]	 		 = {critical_damage = 2  ,args = {228},droppable = false},
		["AILERON_L"] 			 = {critical_damage = 2  ,args = {229},droppable = false},
		--right wing	
		["WING_R_OUT"]	 		 = {critical_damage = 5  ,args = {213},deps_cells = {"FLAPS_R_OUT"	,"WING_R_CENTER"}},
		["WING_R_CENTER"] 		 = {critical_damage = 5  ,args = {214},deps_cells = {"FLAPS_R_CENTER","FLAPS_R_IN","WING_R_IN"}},
		["WING_R_IN"] 			 = {critical_damage = 5  ,args = {215},deps_cells = {"AILERON_R"},droppable = false},
		["FLAPS_R_OUT"]	 		 = {critical_damage = 2  ,args = {216},droppable = false},
		["FLAPS_R_CENTER"] 		 = {critical_damage = 2  ,args = {217},droppable = false},
		["FLAPS_R_IN"]	 		 = {critical_damage = 2  ,args = {218},droppable = false},
		["AILERON_R"] 		     = {critical_damage = 2  ,args = {219},droppable = false},
	}),
	
	DamageParts = 
	{  
		[1] = "mq-9_reaper_oblomok_R", -- wing R
		[2] = "mq-9_reaper_oblomok_L", -- wing L
	},
	
	lights_data = {	typename = "collection", lights = {
    [3]	= {typename = "collection",
			lights = {-- Left Position Light (red)
					  {typename = "omnilight",
					   connector = "BANO_1",
					   color = {0.99, 0.11, 0.3},
					   pos_correction  = {0, 0, -0.2},
					   argument  = 190
					  },
					  -- Right Position Light (green)
					  {typename = "omnilight",
					   connector = "BANO_2",
					   color = {0, 0.894, 0.6},
					   pos_correction = {0, 0, 0.2},
					   argument  = 191
					  }}
			},
	}},
	ViewSettings = ViewSettings,
	Countries = {"USA","Italy","UK","Turkey","France"},
}

add_aircraft(Reaper)
---------------------------------------------------------
plugin_done()
