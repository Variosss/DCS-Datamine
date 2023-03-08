declare_weapon({category = CAT_SHELLS,name =   "N37_37x155_HEI_T",
  user_name		 = _("N37_37x155_HEI_T"),
  model_name     = "tracer_bullet_crimson",
  v0    		 = 690,
  Dv0   		 = 0.0060,
  Da0     		 = 0.0017,
  Da1     		 = 0.0,
  mass      	 = 0.722,
  round_mass 	 = 1.250+0.115,		-- round + link
  cartridge_mass = 0.0,				-- 0.413+0.115, cartridges are ejected
  explosive      = 0.410,
  life_time      = 5.0,
  caliber        = 37.0,
  s              = 0.0,
  j              = 0.0,
  l              = 0.0,
  charTime       = 0,
  cx        	 = {0.5,0.80,0.90,0.080,2.15},
  k1        	 = 5.7e-09,
  tracer_off     = 1.5,
  scale_smoke    = 2.0, 
  smoke_tail_life_time = 1.0,
  cartridge		 = 0,
  visual_effect_correction = 3.0,
})

declare_weapon({category = CAT_SHELLS,name =   "N37_37x155_API_T",
  user_name		 = _("N37_37x155_API_T "),
  model_name     = "tracer_bullet_crimson",
  v0    		 = 675,
  Dv0   		 = 0.0060,
  Da0     		 = 0.0017,
  Da1     		 = 0.0,
  mass      	 = 0.765,
  round_mass 	 = 1.294+0.115,		-- round + link
  cartridge_mass = 0.0,				-- 0.413+0.115, cartridges are ejected
  explosive      = 0.410,
  life_time      = 5.0,
  caliber        = 37.0,
  s              = 0.0,
  j              = 0.0,
  l              = 0.0,
  charTime       = 0,
  cx        	 = {0.5,0.80,0.90,0.080,2.15},
  k1        	 = 5.7e-09,
  tracer_off     = 1.5,
  scale_smoke    = 2.0, 
  smoke_tail_life_time = 1.0,
  cartridge		 = 0,
  visual_effect_correction = 3.0,
})

declare_weapon({category = CAT_SHELLS,name =   "NR23_23x115_HEI_T",
  user_name		 = _("NR23_23x115_HEI_T"),
  model_name     = "tracer_bullet_crimson",
  v0    		 = 680,
  Dv0   		 = 0.0050,
  Da0     		 = 0.0007,
  Da1     		 = 0.0,
  mass      	 = 0.196,
  round_mass 	 = 0.340+0.071,		-- round + link
  cartridge_mass = 0.0,				-- 0.111+0.071, cartridges are ejected
  explosive      = 0.011,
  life_time      = 5.0,
  caliber        = 23.0,
  s              = 0.0,
  j              = 0.0,
  l              = 0.0,
  charTime       = 0,
  cx        	 = {1.0,0.74,0.65,0.150,1.78},
  k1        	 = 2.3e-08,
  tracer_off     = 1.5,
  scale_smoke    = 2.0, 
  smoke_tail_life_time = 1.0,
  cartridge		 = 0,
})

declare_weapon({category = CAT_SHELLS,name =   "NR23_23x115_API",
  user_name		 = _("NR23_23x115_API"),
  model_name     = "tracer_bullet_crimson",
  v0    		 = 680,
  Dv0   		 = 0.0050,
  Da0     		 = 0.0007,
  Da1     		 = 0.0,
  mass      	 = 0.199,
  round_mass 	 = 0.340+0.071,		-- round + link
  cartridge_mass = 0.0,				-- 0.111+0.071, cartridges are ejected
  explosive      = 0.000,
  life_time      = 5.0,
  caliber        = 23.0,
  s              = 0.0,
  j              = 0.0,
  l              = 0.0,
  charTime       = 0,
  cx        	 = {1.0,0.74,0.65,0.150,1.78},
  k1        	 = 2.3e-08,
  tracer_off     = -1,
  scale_smoke    = 2.0, 
  smoke_tail_life_time = 1.0,
  cartridge		 = 0,
})

function nr23(tbl)

	tbl.category = CAT_GUN_MOUNT 
	tbl.name 	 = "NR-23"
	tbl.display_name	= "NR-23"
	tbl.supply 	 = 
	{
		shells = {"NR23_23x115_HEI_T","NR23_23x115_API"},
		mixes  = {{1,2,2,1,2,2}}, --  
		count  = 80,
	}
	if tbl.mixes then 
	   tbl.supply.mixes =  tbl.mixes
	   tbl.mixes	    = nil
	end
	tbl.gun = 
	{
		max_burst_length = 80,
		rates 			 = {850},
		recoil_coeff 	 = 1,
		barrels_count 	 = 1,
	}
	if tbl.rates then 
	   tbl.gun.rates    =  tbl.rates
	   tbl.rates	    = nil
	end	
	tbl.ejector_pos 			= tbl.ejector_pos or {-0.4, -1.2, 0.18}
	tbl.ejector_dir 			= tbl.ejector_dir or {0,2,0}
	tbl.supply_position  		= tbl.supply_position   or {0,  0.3, -0.3}
	tbl.aft_gun_mount 			= false
	tbl.effective_fire_distance = 1000
	tbl.drop_cartridge 			= 204		-- shell_50cal
	tbl.muzzle_pos				= {0,0,0}	-- all position from connector
	tbl.azimuth_initial 		= tbl.azimuth_initial    or 0   
	tbl.elevation_initial 		= tbl.elevation_initial  or 0   
	if  tbl.effects == nil then
		tbl.effects = {{ name = "FireEffect"     , arg 		 = tbl.effect_arg_number or 436 },
					   { name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
					   { name = "SmokeEffect"}}
	end
	return declare_weapon(tbl)
end

function n37(tbl)

	tbl.category = CAT_GUN_MOUNT 
	tbl.name 	 = "N-37"
	tbl.display_name	= "N-37"
	tbl.supply 	 = 
	{
		shells = {"N37_37x155_HEI_T", "N37_37x155_API_T"},
		mixes  = {{1,1,1,2}}, --  Calculated by weight (55 kg)
		count  = 40,
	}
	if tbl.mixes then 
	   tbl.supply.mixes =  tbl.mixes
	   tbl.mixes	    = nil
	end
	tbl.gun = 
	{
		max_burst_length = 40,
		rates 			 = {400},
		recoil_coeff 	 = 1,
		barrels_count 	 = 1,
	}
	if tbl.rates then 
	   tbl.gun.rates    =  tbl.rates
	   tbl.rates	    = nil
	end	
	tbl.ejector_pos 			= tbl.ejector_pos or {-0.4, -1.2, 0.18}
	tbl.ejector_dir 			= tbl.ejector_dir or {0,3,0}
	tbl.supply_position  		= tbl.supply_position   or {0,  0.3, -0.3}
	tbl.aft_gun_mount 			= false
	tbl.effective_fire_distance = 1000
	tbl.drop_cartridge 			= 203		-- shell_30mm
	tbl.muzzle_pos				= {0,0,0}	-- all position from connector
	tbl.azimuth_initial 		= tbl.azimuth_initial    or 0   
	tbl.elevation_initial 		= tbl.elevation_initial  or 0   
	if  tbl.effects == nil then
		tbl.effects = {{ name = "FireEffect"     , arg 		 = tbl.effect_arg_number or 436 },
					   { name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
					   { name = "SmokeEffect"}}
	end
	return declare_weapon(tbl)
end

function make_mig15(rewrite_settings)
local rewrite_settings  = rewrite_settings or {Name = 'MiG-15bis', DisplayName = _('MiG-15bis')}

local base_MiG_15bis =  {        
	Name 				= rewrite_settings.Name,
	DisplayName			= rewrite_settings.DisplayName,
	Picture 			= "MiG-15bis.png",
	Rate 				= 20, -- RewardPoint in Multiplayer
	Shape 				= "MiG_15bis",
	livery_entry		= "MiG-15bis",
	
	country_of_origin = "SUN", --USSR

	shape_table_data 	= 
	{
		{
			file  	 = 'MiG_15bis';
			life  	 = 15; -- прочность объекта (методом lifebar*) -- The strength of the object (ie. lifebar *)
			vis   	 = 3; -- множитель видимости (для маленьких объектов лучше ставить поменьше). Visibility factor (For a small objects is better to put lower nr).
			desrt    = 'Fighter-2-crush',-- Name of destroyed object file name
			fire  	 = { 300, 4}; -- Fire on the ground after destoyed: 300sec 4m
			username = 'MiG-15bis';
			index    =  WSTYPE_PLACEHOLDER;
			classname = "lLandPlane";
			positioning = "BYNORMAL";
		},
	},
	mapclasskey 		= "P0091000024",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER ,"Battleplanes",},
	Categories 			= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},	
	-------------------------
	M_empty 					= 3753 , -- with pilot and nose load, kg
	M_nominal 					= 5044 , -- kg
	M_max 						= 6106 , -- kg
	M_fuel_max 					= 1172 , -- 1412 * 0.83, -- kg
	H_max 					 	= 15100, -- m
	average_fuel_consumption 	= 0.5, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
	CAS_min 					= 50, -- minimal indicated airspeed*?
	-- M = 15600 lbs
	V_opt 						= 850 / 3.6,-- Cruise speed (for AI)*
	V_take_off 					= 63, 		-- Take off speed in m/s (for AI)*	(122)
	V_land 						= 78, 		-- Land speed in m/s (for AI)
	V_max_sea_level 			= 1059/3.6, -- Max speed at sea level in m/s (for AI)
	V_max_h 					= 992/3.6 ,	-- Max speed at max altitude in m/s (for AI)
	Vy_max 						= 51, 		-- Max climb speed in m/s (for AI)
	Mach_max 					= 0.95, 	-- Max speed in Mach (for AI)
	Ny_min 						= -3, 		-- Min G (for AI)
	Ny_max 						= 8.0,  	-- Max G (for AI)
	Ny_max_e 					= 8.0, 		-- ?? Max G (for AI)
	AOA_take_off 				= 0.17, 	-- AoA in take off radians (for AI)
	bank_angle_max 				= 85,		-- Max bank angle (for AI)


	has_afteburner 				= false, 	-- AFB yes/no
	has_speedbrake 				= true, 	-- Speedbrake yes/no
	tand_gear_max 				= 1.192, 	-- tangent on maximum yaw angle of front wheel, 50 degrees
	wing_area 					= 20.6, 	-- wing area in m2 		
	wing_span 					= 10.08 , 	-- wing span in m			
	wing_type 					= 0,		-- Fixed wing				
	thrust_sum_max 				= 2650,		-- thrust in kg (26.3kN)	
	thrust_sum_ab 				= 2650, 	-- thrust inkg (26.3kN)		
	length 						= 10.11, 	-- full lenght in m		
	height 						= 3.7, 		-- height in m				
	flaps_maneuver 				= 0, 		-- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
    flaps_transmission          = "Hydraulic",
    undercarriage_transmission  = "Hydraulic",
	range 						= 1240, 	-- Max range in km (for AI)
	RCS 						= 2, 		-- Radar Cross Section m2
	IR_emission_coeff 			= 0.26,		-- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 0.26, 	-- With afterburner
	wing_tip_pos 				= {-2.248,-0.212,4.9}, -- wingtip coords for visual effects
	
	nose_gear_pos 								= { 2.782, -1.416,	0},   -- nosegear coord 
	nose_gear_amortizer_direct_stroke   		=  0,  -- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke  		= -0.227,  -- up 
	nose_gear_amortizer_normal_weight_stroke 	= -0.06,   -- up 
	nose_gear_wheel_diameter 					=  0.478, -- in m
	
	main_gear_pos 						 	 = {-0.4  ,-1.249 , 1.905}, -- main gear coords (base = 3810)
	main_gear_amortizer_direct_stroke	 	 =   0, --  down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke  	 = 	-0.192, --  up 
	main_gear_amortizer_normal_weight_stroke =  -0.06,-- down from main_gear_pos
	main_gear_wheel_diameter 				 =   0.658, -- in m
	
	nose_gear_door_close_after_retract		= false,
	main_gear_door_close_after_retract		= false,

	--sounderName = "Aircraft/Planes/MiG15bis",
	
	brakeshute_name 			= 0, -- Landing - brake chute visual shape after separation
	engines_count				= 1, -- Engines count
	engines_nozzles = {
		[1] = 
		{
			pos 				= {-4.105,-0.063,0}, -- nozzle coords
			elevation 			= 0, -- AFB cone elevation
			diameter 			= 0.675, -- AFB cone diameter
			exhaust_length_ab 	= 3, -- lenght in m
			exhaust_length_ab_K = 0.76, -- AB animation
			smokiness_level     = 0.1, 
		}, -- end of [1]
	}, -- end of engines_nozzles
	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name = "pilot_mig15_seat",
			drop_canopy_name   = "MiG_15bis-fonar",
            canopy_pos = {1.5, 0.7, 0.0},
            bailout_arg = 91,
			pilot_name		   = "pilot_mig15",
			pos 			   =  {1.771, 0.856,0},
			g_suit 			   =  0.35,
			drop_parachute_name	 = "pilot_mig15_parachute",
		}, -- end of [1]
	}, -- end of crew_members
    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"VelType", 3}, {"Arg", 38, "to", 0.9, "in", 2.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"VelType", 3}, {"Arg", 38, "to", 0.0, "in", 2.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Any", "Bailout"}, Sequence = {
                --[[0]] {C = {{"ArgumentPhase", 5, "x", 38, "to", 0.88, "sign", 1}}},
                --[[1]] {C = {{"Arg", 38, "set", 0.04}}},
                --[[2]] {C = {{"Sleep", "for", 1.0}}},
                --[[3]] {C = {{"TearCanopy", 0}}},
                --[[4]] {C = {{"Sleep", "for", 2.0}}},
                --[[5]] {C = {{"Arg", 91, "set", 1.0}}},
                }},
            {Transition = {"Any", "TearOff"},  Sequence = {{C = {{"TearCanopy", 0}, {"Arg", 91, "set", 1.0}}}}},
        },
    }, -- end of mechanimations

	fires_pos = {
			[1] = 	{-0.40,	-0.46, 0},      -- After maingear, fuselage bottom
			[2] = 	{-1.114, 0.082, 0.901},   -- Wing inner Left top **
			[3] = 	{-1.268, -0.08, -1.162},   -- Wing inner Right bottom **
			[4] = 	{0.215, -0.08, 1.195},    -- Wing middle Left bottom **
			[5] = 	{-1.582, 0.07, -1.687},   -- Wing middle Right top **
			[6] = 	{-0.80,	0.066,	2.2},    -- Wing outer Left **
			[7] = 	{1.58, 0.102,	-0.806},   -- Wing outer Right
			[8] = 	{-5.35, 0.0, 0},      -- Engine damage big
			[9] = 	{-5.59, -0.12, -0.393},      -- Engine damage small
			[10] = 	{1.25, -0.38, 0.30},   -- Air intake bottom L
			[11] = 	{0.85, -0.28, -0.40},  -- Air intake bottom R
	}, -- end of fires_pos
	

	--sensors
	
	detection_range_max		 = 30,
	radar_can_see_ground 	 = true, -- this should be examined (what is this exactly?)
	CanopyGeometry 								=	makeAirplaneCanopyGeometry(LOOK_GOOD, LOOK_GOOD, LOOK_AVERAGE),
	Sensors = {
		--RWR = "Abstract RWR", -- RWR type
	},
	HumanRadio = {
		frequency = 3.750,  -- Radio Freq
		editable = true,
		minFrequency = 3.750,
		maxFrequency = 5.000,
		modulation = MODULATION_AM
	},

	--panelRadio = {
	--},

	Guns = {
			n37({
				muzzle_pos_connector = "Gun_point_2",
				effect_arg_number	 = 350,
				azimuth_initial		 = 0,
				elevation_initial	 = 0,
				supply_position		 = {2.115, -0.45, 0.0},
--				ejector_pos			 = {0.0, 0.0, 0.0},					--{-1.67, -0.07, -0.07}}),
				ejector_pos_connector = "ejector_1",
				}),
			nr23({
				muzzle_pos_connector = "Gun_point_3",
				effect_arg_number	 = 433,
				mixes				 = {{2,1,1,1}},
				azimuth_initial		 = 0,
				elevation_initial	 = 0,
				supply_position		 = {2.436, -0.4, 0.0},
--				ejector_pos			 = {0.0, 0.0 ,0.0},
				ejector_pos_connector = "ejector_2",
				}),	-- FRONT
			nr23({
				muzzle_pos_connector = "Gun_point_007",
				effect_arg_number	 = 432,
				mixes				 = {{1,1,2,1}},
				azimuth_initial		 = 0,
				elevation_initial	 = 0,
				supply_position		 = {1.866, -0.47, 0.0},
--				ejector_pos			 = {0.0, 0.0 ,0.0},
				ejector_pos_connector = "ejector_3",
				}),	-- REAR
			},

	Pylons = {
		-- LEFT WING
		pylon(1, 0, -0.309661, -0.226186, -2.976318,{use_full_connector_position=true,connector = "Pylon_2",arg = 309,arg_value = 0},
			{
				{ CLSID = "FAB_50",				arg_value = 0.15 },
				{ CLSID = "FAB_100M",			arg_value = 0.15 },
				{ CLSID = "PTB400_MIG15",		arg_value = 0.25 },
				{ CLSID = "PTB600_MIG15",		arg_value = 0.35 },
				{ CLSID = "PTB300_MIG15",		arg_value = 0.45 },
			}
		),
		-- RIGHT WING
		pylon(2, 0, -0.309661, -0.226186, 2.976639,{use_full_connector_position=true,connector = "Pylon_1",arg = 308,arg_value = 0},
			{
				{ CLSID = "FAB_50",			arg_value = 0.15 },
				{ CLSID = "FAB_100M",			arg_value = 0.15 },
				{ CLSID = "PTB400_MIG15",		arg_value = 0.25 },
				{ CLSID = "PTB600_MIG15",		arg_value = 0.35 },
				{ CLSID = "PTB300_MIG15",		arg_value = 0.45 },
			}
		),
    },
	
	Tasks = {
		aircraft_task(CAP),				-- 11, Combat Air Patrol
        aircraft_task(CAS),				-- 31, Close air support
        aircraft_task(Escort),			-- 18,
        aircraft_task(FighterSweep),	-- 19,
        aircraft_task(GroundAttack),	-- 32,
        aircraft_task(Intercept),		-- 10,
    },	
	DefaultTask = aircraft_task(CAP),
	
	SFM_Data = {
		aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		{
			Cy0	=	0.0668, -- zero AoA lift coefficient*
			Mzalfa	=	4.355, -- coefficients for pitch agility
			Mzalfadt	=	0.8,  -- coefficients for pitch agility
			kjx	=	2,--2.3, -- Inertia parametre X - Dimension (clean) airframe drag coefficient at X (Top) Simply the wing area in square meters (as that is a major factor in drag calculations)
			kjz	=	0.01,--0.0011, -- Inertia parametre Z - Dimension (clean) airframe drag coefficient at Z (Front) Simply the wing area in square meters (as that is a major factor in drag calculations)
			Czbe	=	-0.014, -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear	=	0.02, -- coefficient, drag, gear ??
			cx_flap	=	0.06, -- coefficient, drag, full flaps
			cy_flap	=	0.35, -- coefficient, normal force, lift, flaps
			cx_brk	=	0.026, -- coefficient, drag, breaks
			table_data = 
			{	--      M		Cx0*	 	Cya*		B2		 	B4	 		Omxmax		Aldop*		Cymax*
				{ 0.0,	0.018	,	0.067	,	0.074	,	0.01 	,	0.372	,	17.3	,	1.1},		
				{ 0.1,	0.018	,	0.067	,	0.074	,	0.01 	,	0.372	,	17.3	,	1.1},
				{ 0.2,	0.0172	,	0.067	,	0.074	,	0.01	   ,	0.741	,	17.3	,	1.1},
				{ 0.3,	0.0165	,	0.067	,	0.074	,	0.01    ,	1.089	,	17.3	,	1.1},
				{ 0.4,	0.016	,	0.0682	,	0.074	,	0.01  	,	1.489	,	17.3	,	1.1},
				{ 0.5,	0.016	,	0.0708	,	0.074	,	0.01 	,	1.489	,	16.9	,	1.075},
				{ 0.6,	0.016	,	0.0746	,	0.074	,	0.01 	,	1.208	,	16.2	,	1.031},
				{ 0.7,	0.016	,	0.0798	,	0.074	,	0.01 	,	0.475	,	15.3	,	0.974},
				{ 0.8,	0.0168	,	0.0850	,	0.08 	,	0.01 	,	0.103	,	13.9	,	0.882},
				{ 0.86,	0.018	,	0.0822	,	0.082	,	0.11		,	0.028	,	12.8	,	0.815},
				{ 0.9,	0.0232	,	0.076	,	0.088	,	0.36 	,	0.008   ,	11.6	,	0.737},
				{ 0.94,	0.0402	,	0.0737	,	0.125	,	0.43	   ,	0.006	,	9.8	,	0.625},
				{ 1,	    0.0598	,	0.0735	,	0.15 	,	0.56   	,	0.004	,	8	,	0.511},
				{ 1.04,	0.063	,	0.0744	,	0.23 	,	0.84 	,	0.002	,	7.4	,	0.469},
				{ 1.2,	0.0642	,	0.0760	,	0.26 	,	1   	,	0.001 	,	6.7	,	0.425},
			}, -- end of table_data
			-- M - Mach number
			-- Cx0 - Coefficient, drag, profile, of the airplane
			-- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
			-- B2 - Polar 2nd power coeff
			-- B4 - Polar 4th power coeff
			-- Omxmax - roll rate, rad/s
			-- Aldop - Alfadop Max AOA at current M - departure threshold
			-- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
		}, -- end of aerodynamics
		engine = 
		{
            Nominal_RPM = 11600.0,
			Nmg	=	21.5, -- RPM at idle
            Startup_Prework = 28.0,
            Startup_Duration = 21.0,
            Shutdown_Duration = 62.0,
			MinRUD	=	0, -- Min state of the РУД
			MaxRUD	=	1, -- Max state of the РУД
			MaksRUD	=	1, -- Military power state of the РУД
			ForsRUD	=	1, -- Afterburner state of the РУД
			type	=	"TurboJet",
			hMaxEng	=	19, -- Max altitude for safe engine operation in km
			dcx_eng	=	0.0134, -- Engine drag coeficient
			cemax	=	1.24, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	2.56, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	1340, --  altitude coefficient for max thrust
			dpdh_f	=	1340, --  altitude coefficient for AB thrust
			table_data = 
			{		--   M			Pmax		 Pfor	
				{ 0.0	,	26000	,	26000	},
				{ 0.1	,	26000	,	26000	},
				{ 0.2	,	24430	,	24430	},
				{ 0.3	,	23040	,	23040	},
				{ 0.4	,	22090	,	22090	},
				{ 0.5	,	21490	,	21490	},
				{ 0.6	,	21310	,	21310	},
				{ 0.7	,	21400	,	21400    },
				{ 0.8	,	22090	,	22090	},
				{ 0.86,	22780	,	22780	},
				{ 0.9	,	23300	,	23300	},
				{ 0.94,	23650	,	23650	},
				{ 1	,	24260	,	24260	},
				{ 1.04,	24600	,	24600	},
				{ 1.1	,	25640	,	25640	},
				
				
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},

	Failures = {
		-- electric system
		{ id = 'es_damage_Generator',	label = _('Generator FAILURE'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'es_damage_Starter',		label = _('Starter FAILURE'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'es_damage_Battery',		label = _('Battery FAILURE'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- fuel system
		{ id = 'fs_damage_TransferPump',	label = _('Fuel Transfer Pump FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'fs_damage_BoosterPump',		label = _('Fuel Booster Pump FAILURE'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- hydraulic system
		{ id = 'hs_damage_MainPump',			label = _('Main Hydraulic Pump FAILURE'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hs_damage_MainAccumulator',		label = _('Main Hydraulic Accumulator FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hs_damage_MainAutoUnload',		label = _('Main Relief Valve FAILURE'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hs_damage_GainPump',			label = _('Booster Pump FAILURE'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hs_damage_GainAccumulator',		label = _('Booster Accumulator FAILURE'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hs_damage_GainAutoUnload',		label = _('Booster Relief Valve FAILURE'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- oxygen system
		{ id = 'os_damage_BalloonLeakage',		label = _('Oxygen FAILURE'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- power plant

		-- air system
		{ id = 'as_damage_Depressurization',	label = _('Depressurization'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
				
		-- 
		{ id = 'AGK_47B_GYRO_TOTAL_FAILURE', 	label = _('AGK-47B gyro failure'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

	},

	Damage = {
		-------------  nose, gear
		[0]  = {critical_damage = 3, args = {146}},						-- nose center (arg - ?)
		[1]  = {critical_damage = 3, args = {150}},						-- nose left
		[2]  = {critical_damage = 3, args = {149}},						-- nose right
		[59] = {critical_damage = 3, args = {148}},						-- nose bottom 
		[8]  = {critical_damage = 2, args = {265}},						-- front gear - FRONT_GEAR_BOX (arg - ?)
		[83] = {critical_damage = 2, args = {134}},						-- wheel nose 
		-------------  cabin
		[3]  = {critical_damage = 1, args = {65}},						-- cockpit
		-------------  fuselage
		[9]  = {critical_damage = 3, args = {154}},									-- fuselage left
		[10] = {critical_damage = 3, args = {153}},									-- fuselage right
		[82] = {critical_damage = 3, args = {152}},									-- fuselage bottom
		[19] = {critical_damage = 1, args = {185}},									-- airbrake left
		[20] = {critical_damage = 1, args = {183}},									-- airbrake right
		-------------  left wing, aileron, flap, gear
		[23] = {critical_damage = 6, args = {223}, deps_cells = {25}},				-- wing out left
		[29] = {critical_damage = 7, args = {224}, deps_cells = {23, 25, 37}},		-- wing center left
		[35] = {critical_damage = 7, args = {225}, deps_cells = {23, 29, 25, 37, 15, 84}},	-- wing in left
		[25] = {critical_damage = 1, args = {226}},									-- aileron left
		[37] = {critical_damage = 2, args = {227}},									-- flap in left
		[15] = {critical_damage = 3,args = {267}},									-- gear left - LEFT_GEAR_BOX (arg - ?)
		[84] = {critical_damage = 3, args = {136}},						  			-- wheel left
		-------------  right wing, aileron, flap, gear
		[24] = {critical_damage = 6, args = {213}, deps_cells = {26}},				-- wing out right
		[30] = {critical_damage = 7, args = {214}, deps_cells = {24, 26, 38}},		-- wing center right
		[36] = {critical_damage = 7, args = {215}, deps_cells = {24, 30, 26, 38, 16, 85}},	-- wing in right
		[26] = {critical_damage = 1, args = {216}},									-- aileron right
		[38] = {critical_damage = 2, args = {217}},									-- flap in right
		[16] = {critical_damage = 3,args = {266}},									-- gear right - RIGHT_GEAR_BOX
		[85] = {critical_damage = 3, args = {135}},						  			-- wheel right
		-------------  fin, rudder
		[40] = {critical_damage = 3, args = {241}, deps_cells = {53}},				-- fin top right
		[44] = {critical_damage = 3, args = {242}},									-- fin bottom left
		[53] = {critical_damage = 1, args = {248}},									-- rudder top (left)
		[54] = {critical_damage = 1, args = {247}},									-- rudder bottom (right)
		-------------  tail
		[56] = {critical_damage = 3, args = {158}},									-- tail left
		[57] = {critical_damage = 3, args = {157}},									-- tail right
		[58] = {critical_damage = 3, args = {156}},									-- tail bottom
		[11] = {critical_damage = 3, args = {167}},									-- engine		 (arg - ?)
		-------------  left stabilizer
		[47] = {critical_damage = 3, args = {236}, deps_cells = {51}},				-- stabilizer left
		[51] = {critical_damage = 1, args = {239}},									-- elevator left		(visual - 239)
		-------------  right stabilizer
		[48] = {critical_damage = 3, args = {234}, deps_cells = {52}},				-- stabilizer right
		[52] = {critical_damage = 1, args = {238}},									-- elevator right
	},
	
	DamageParts = 
	{  
		[1] = "MiG_15bis_oblomok__wing_R",
		[2] = "MiG_15bis_oblomok__wing_L",
	},
	
	lights_data = {
		typename =	"collection",
		lights 	 = 
		{
			-- WOLALIGHT_SPOTS -- фары
			[2] =
			{
				lights = 
				{
					[1] = -- nose
					{
						typename	=	"argumentlight",
						argument	=	51,
					}, -- end of [1]
				}, -- end of lights
				typename	=	"collection",
			}, -- end of [2]
			-- WOLALIGHT_NAVLIGHTS -- навигационные
			[3] =
			{
				lights =
				{
					[1] =	-- left wing
					{
						typename	=	"argumentlight",
						argument	=	190,
					},
					[2] =	-- right wing
					{
						typename	=	"argumentlight",
						argument	=	191,
					},
					[3] =	-- tail
					{
						typename	=	"argumentlight",
						argument	=	192,
					},
				}, -- end of lights
				typename	=	"collection",
			}, -- end of [3]
		}, -- end of lights
	},-- end of lights data
}

if rewrite_settings then 
   for i,o in pairs(rewrite_settings) do
		base_MiG_15bis[i] = o
   end
end

add_aircraft(base_MiG_15bis)
end

make_mig15()
----------------------------------------------------------------------------------



local FAB_50 = {
	category  = CAT_BOMBS,
	name      = "FAB_50",
	model     = "fab50_40x",
	user_name = _("FAB-50 - 50kg GP Bomb LD"),
	wsTypeOfWeapon = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme    = "bomb-common",
	type      = 0,
    mass      = 50.0,
    hMin      = 1000.0,
    hMax      = 12000.0,
    Cx        = 0.00035,
    VyHold    = -100.0,
    Ag        = -1.23,

	fm = {
        mass        = 50,  -- empty weight with warhead, wo fuel, kg
        caliber     = 0.200,  -- Caliber, meters 
        cx_coeff    = {1, 0.39, 0.38, 0.236, 1.31}, -- Cx
        L           = 1.040, -- Length, meters 
        I           = 4.507, -- kgm2 - moment of inertia  I = 1/12 ML2
        Ma          = 0.667,  -- dependence moment coefficient of  by  AoA angular acceleration  T / I
        Mw          = 1.094, --  rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t
        
        wind_sigma  = 10, -- dispersion coefficient
  
        cx_factor   = 100,
    },
  
	warhead = {
		mass                 = 25,
		expl_mass            = 25,
		other_factors        = {1, 1, 1},
		obj_factors          = {1, 1},
		concrete_factors     = {1, 1, 1},
		cumulative_factor    = 0,
		concrete_obj_factor  = 0,
		cumulative_thickness = 0,
		piercing_mass        = 5,
		caliber              = 200,
	},

	-- velK is calibrated to get arming time of 0.8 seconds at initial bomb speed of 150 m/s (540 km/h)
	arming_vane = {enabled = true, velK = 0.00834},
	-- overriding default setting (delay is enabled for all bombs by default)
	arming_delay = {enabled = false, delay_time = 0},
	
	shape_table_data = {
		{
			name     = "FAB_50",
			file     = "fab50_40x",
			life     = 1,
			fire     = {0, 1},
			username = "FAB-50",
			index    = WSTYPE_PLACEHOLDER,
		},
	},
 
	targeting_data = {
		char_time = 20.87, -- characteristic time for sights 
	},
}
declare_weapon(FAB_50)

declare_loadout(
{
	category 		= CAT_BOMBS,
	CLSID	 		= "FAB_50",
	attribute		= FAB_50.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= FAB_50.Cx,
	Picture			= "fab100.png",		-- TODO: "FAB50.png",
	displayName		= FAB_50.user_name,
	Weight			= FAB_50.mass,
	Elements  = {
		{
			ShapeName = "fab50_40x",
		}, 
	},
}
)

-- Copy from FAB-100
local FAB_100M = {
	category  = CAT_BOMBS,
	name      = "FAB_100M",
	model     = "fab100_40x",
	user_name = _("FAB-100M - 100kg GP Bomb LD"),
	wsTypeOfWeapon  = {wsType_Weapon,wsType_Bomb,wsType_Bomb_A,WSTYPE_PLACEHOLDER},
	scheme    = "bomb-common",
	type      = 0,
    mass      = 100.0,
    hMin      = 1000.0,
    hMax      = 12000.0,
    Cx        = 0.00035,
    VyHold    = -100.0,
    Ag        = -1.23,

	fm = {
        mass        = 100,  -- empty weight with warhead, wo fuel, kg
        caliber     = 0.280,  -- Caliber, meters 
        cx_coeff    = {1, 0.39, 0.38, 0.236, 1.31}, -- Cx
        L           = 1.040, -- Length, meters 
        I           = 9.0133, -- kgm2 - moment of inertia  I = 1/12 ML2
        Ma          = 0.68,  -- dependence moment coefficient of  by  AoA angular acceleration  T / I
        Mw          = 1.116, --  rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t
        
        wind_sigma  = 20, -- dispersion coefficient
  
        cx_factor   = 100,
    },
  
	warhead = {
		mass                 = 45,
		expl_mass            = 45,
		other_factors        = {1, 1, 1},
		obj_factors          = {1, 1},
		concrete_factors     = {1, 1, 1},
		cumulative_factor    = 0,
		concrete_obj_factor  = 0,
		cumulative_thickness = 0,
		piercing_mass        = 9,
		caliber              = 280,
	},
  
    -- velK is calibrated to get arming time of 0.8 seconds at initial bomb speed of 150 m/s (540 km/h)
	arming_vane = {enabled = true, velK = 0.00834},
	-- overriding default setting (delay is enabled for all bombs by default)
	arming_delay = {enabled = false, delay_time = 0},
	
	shape_table_data = {
		{
			name     = "FAB_100M",
			file     = "fab100_40x",
			life     = 1,
			fire     = {0, 1},
			username = "FAB-100M",
			index    = WSTYPE_PLACEHOLDER,
		},
	},
 
	targeting_data = {
		char_time = 20.84, -- characteristic time for sights 
	},
}

declare_weapon(FAB_100M)

declare_loadout(
{
	category 		= CAT_BOMBS,
	CLSID	 		= "FAB_100M",
	attribute		= FAB_100M.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= FAB_100M.Cx,
	Picture			= "fab100.png",
	displayName		= FAB_100M.user_name,
	Weight			= FAB_100M.mass,
	Elements  = {
		{
			ShapeName = "fab100_40x",
		}, 
	},
}
)

declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "PTB400_MIG15",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("Fuel Tank 400 liters"),
		Weight_Empty	= 32.0,
		Weight		= 32.0 + 400*0.83,
		Cx_pil		= 0.001313754,
		shape_table_data = 
		{
			{
				name	= "PTB400_MIG15";
				file	= "PTB400_MIG15";
				life	= 1;
				fire	= { 0, 1};
				username	= "PTB400_MIG15";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "PTB400_MIG15",
			}, 
		}, 
	}
)

declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "PTB600_MIG15",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("Fuel Tank 600 liters"),
		Weight_Empty	= 33.0,
		Weight		= 33.0 + 600*0.83,
		Cx_pil		= 0.0018392556,			--2.0*0.001313754,
		shape_table_data = 
		{
			{
				name	= "PTB600_MIG15";
				file	= "PTB600_MIG15";
				life	= 1;
				fire	= { 0, 1};
				username	= "PTB600_MIG15";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "PTB600_MIG15",
			}, 
		}, 
	}
)

declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "PTB300_MIG15",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("Fuel Tank 300 liters"),
		Weight_Empty	= 22.0,
		Weight		= 22.0 + 300*0.83,
		Cx_pil		= 0.00141885432,		--1.2*0.001313754,
		shape_table_data = 
		{
			{
				name	= "PTB300_MIG15";
				file	= "PTB300_MIG15";
				life	= 1;
				fire	= { 0, 1};
				username	= "PTB300_MIG15";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "PTB300_MIG15",
			}, 
		}, 
	}
)
