-- Setting up model container
mount_vfs_model_path(current_mod_path .. "/A-20G/Shapes")
mount_vfs_texture_path(current_mod_path .. "/A-20G/Textures/A-20G")
mount_vfs_liveries_path(current_mod_path .. "/A-20G/Liveries")
-- end of Setting up model container



local function TurretMount (turret_name,  tbl , turret_)
        tbl.category = CAT_GUN_MOUNT
        tbl.name = turret_name   
		
		tbl.supply = {
            mixes = {{1,1,4}},
            count = 800,
        }
        if tbl.mixes then
            tbl.supply.mixes = tbl.mixes
            tbl.mixes = nil
        end
        if tbl.count then
            tbl.supply.count = tbl.count
            tbl.count = nil
        end
        tbl.gun = {
            max_burst_length = 30,
            rates = {800}, -- unsynchronized mount
            recoil_coeff =  0.7*1.3,
			barrel_circular_error = 0.0002,
            barrels_count = 1,
			trigger = {name ="GunTrigger"}
        }
		tbl.effective_fire_distance = 400;
		
        tbl.ejector_pos = tbl.ejector_pos or {0.0, 0.05, 0.0}
        tbl.ejector_dir = tbl.ejector_dir or {0, -1, 0}
        --tbl.effect_arg_number = tbl.effect_arg_number or 436
        tbl.supply_position = tbl.supply_position or {0, 0.3, -0.3}
        tbl.aft_gun_mount = false
        tbl.muzzle_pos = {0, 0, 0} -- all position from connector
        tbl.azimuth_initial = tbl.azimuth_initial or 0
        tbl.elevation_initial = tbl.elevation_initial or 0
		tbl.turret = turret_

        return declare_weapon(tbl)  --declare_gun_mount(tbl.name,tbl)
    end



local a20g_name 			= 'A-20G'
local a20g_localized 		= _('A-20G')
local a20g_wstype 			= WSTYPE_PLACEHOLDER



declare_loadout({category = CAT_BOMBS, CLSID = "{4xAN-M64_on_InvCountedAttachmentPoints}",
    DistributeOverCarrierDirectly = true,
    attribute = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, AN_M64},
    wsTypeOfWeapon = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, AN_M64},
    Cx_item = 0.0,
    Cx_pil = 0.0,
    Count = 4,
    Picture = "us_AN-M64.png",
    PictureBlendColor = "0xffffffff",
    displayName = _("4 x AN-M64 - 500lb GP Bomb LD"),
    Weight_Empty = 0.0,
    Weight = 0.0 + 4.0 * 227.0,
    Elements = {
        {
            ShapeName = "AN-M64",
            connector_name = "AttachPoint_01",
        },
        {
            ShapeName = "AN-M64",
            connector_name = "AttachPoint_02",
        },
        {
            ShapeName = "AN-M64",
            connector_name = "AttachPoint_03",
        },
        {
            ShapeName = "AN-M64",
            connector_name = "AttachPoint_04",
        },
    },
})



A_20G = {
	Name 				= a20g_name,
	DisplayName			= a20g_localized,
	Picture 			= a20g_name..".png",
	Rate 				= 20, -- RewardPoint in Multiplayer
	Shape 				= a20g_name,
    XRayShape           = "a-20g_x-ray",
	------------------------------------
	shape_table_data 	= 
	{
		{
			file  	 	= a20g_name;
			life  	 	= 18; -- lifebar
			vis   	 	= 3;  -- visibility gain.
			desrt    	= a20g_name.."_destr"; -- Name of destroyed object file name
			fire  	 	= { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username	= a20g_name;
			index    	= a20g_wstype;
			classname 	= "lLandPlane";
			positioning = "BYNORMAL";
			drawonmap 	= true;
		},
		{
			name  = a20g_name.."_destr";
			file  = a20g_name.."_destr";
			fire  = { 240, 2};
		},
	},
	------------------------------------
	mapclasskey 				= "P0091000027",
	attribute 					= {wsType_Air, wsType_Airplane, wsType_Intruder, a20g_wstype,"Strategic bombers","Bombers"},
	-------------------------
	----  !!!!!!!!!   Data for Ju-88 A4
	M_empty 					= 8010 ,  -- kg
	M_nominal 					= 11794,  -- kg
	M_max 						= 13608,  -- kg
	M_fuel_max 					= 1500,   -- kg
	M_Boost_Mixt_max			= 0,	  -- kg
	H_max 					 	= 10000,	-- 7230,   -- m
	average_fuel_consumption 	= 0.302,  -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
	CAS_min 					= 56, 
	V_opt 						= 125,  -- Cruise speed (for AI)
	V_take_off 					= 53,   -- Take off speed in m/s (for AI)
	V_land 						= 50,   -- Land speed in m/s (for AI)
	V_max_sea_level 			= 183.3,  -- Max speed at sea level in m/s (for AI)
	V_max_h 					= 172,  -- Max speed at max altitude in m/s (for AI)
	Vy_max 						= 7,   -- Max climb speed in m/s (for AI)
	Mach_max 					= 0.67, -- Max speed in Mach (for AI)
	Ny_min 						= -4, -- Min G (for AI)
	Ny_max 						= 4,  -- Max G (for AI)
	Ny_max_e 					= 4,  -- Max G (for AI)
	AOA_take_off 				= 0.157, -- AoA in take off (for AI)
	bank_angle_max 				= 30, -- Max bank angle (for AI)


	has_afteburner 				= false, -- AFB yes/no
	has_speedbrake 				= false, -- Speedbrake yes/no
	has_differential_stabilizer	= false, -- differential stabilizers
    flaps_transmission = "Hydraulic",
    undercarriage_transmission = "Hydraulic",
    undercarriage_movement = 2,
    doors_transmission = "Mechanical",
    doors_movement = 1,
	------------------------------------
	nose_gear_pos 								=  {2.85, -2.285,	0}, -- nosegear coord
	nose_gear_amortizer_direct_stroke   		=  0,  -- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke  		=  1.105 - 1.315,  -- up {-9.641,-1.105}
	nose_gear_amortizer_normal_weight_stroke 	= -0.06,   -- up 
	nose_gear_wheel_diameter 					=  0.68, -- in m

	main_gear_pos 						 	 	=  {-1.35  ,-2.15 ,2.61},
	main_gear_amortizer_direct_stroke	 	 	=   0, --  down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke  	 	=   2.605 - 2.88, --  up  {1.985,-2.605}
	main_gear_amortizer_normal_weight_stroke 	=  -0.1,-- down from main_gear_pos
	main_gear_wheel_diameter 				 	=   1.08, -- in m
	------------------------------------

	tand_gear_max 				= 0.577,
	wing_area 					= 43.1, -- wing area in m2
	wing_span 					= 18.69, -- wing spain in m
	wing_type 					= 0,
	thrust_sum_max 				= 8224, -- thrust in kg (44kN)
	thrust_sum_ab 				= 8224, -- thrust inkg (71kN)
	length 						= 14.63, -- full lenght in m
	height 						= 4.83, -- height in m
	flaps_maneuver 				= 0.3, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
	range 						= 800, -- Max range in km (for AI)
	RCS 						= 100, -- Radar Cross Section m2
	IR_emission_coeff 			= 0.1, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 0, -- With afterburner
	wing_tip_pos 				= {0,	0.9, 9.4}, -- wingtip coords for visual effects
	brakeshute_name 			= 0, -- Landing - brake chute visual shape after separation
	engines_count				= 2, -- Engines count
	engines_nozzles = {
		[1] = 
		{
			pos 		=  {1.558,-0.54,-2.61}, -- nozzle coords
			elevation   =  0, -- AFB cone elevation
			diameter	 = 0*0.1, -- AFB cone diameter
			exhaust_length_ab   = -3.0, -- lenght in m
			exhaust_length_ab_K = 0.3, -- AB animation
		}, -- end of [1]
		[2] = 
		{
			pos 		=  {1.558,-0.54,2.61}, -- nozzle coords
			elevation   =  0, -- AFB cone elevation
			diameter	 = 0*0.1, -- AFB cone diameter
			exhaust_length_ab   = -3.0, -- lenght in m
			exhaust_length_ab_K = 0.3, -- AB animation
		}, -- end of [1]
	}, -- end of engines_nozzles
	crew_members = 
	{
		[1] = 
		{
			pilot_name		  	 = "pilot_raf",
			ejection_seat_name	 = 0,
			drop_canopy_name 	 = "a-20g_canopy",
			canopy_arg			 = 38,
			pos					 = {1.5, 0.3, 0.0},
			canopy_pos 			 = {0.0, 0.0, 0.0},
			ejection_order		 = 1,
			ejection_added_speed = {-0.5, -1.0, -2.0},
			role 				 = "pilot",
			role_display_name 	 = _("Pilot in command"),
			drop_parachute_name	 = "pilot_raf_parachute",
		},
		[2] = 
		{
			pilot_name		  	 = "pilot_raf",
			ejection_seat_name	 = 0,
			drop_canopy_name 	 = "a-20g_canopy",
			canopy_arg			 = 38,
			pos					 = {-3.4, 0.4, 0.0},
			canopy_pos 			 = {0.0, 0.0, 0.0},
			ejection_order		 = 1,
			ejection_added_speed = {-0.5, -1.5, -2.5},
			role 				 = "flight_officer",
			role_display_name 	 = _("Gunner / Radio Operator"),
			drop_parachute_name	 = "pilot_raf_parachute",
		},
	}, -- end of crew_members

    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"Sleep", "for", 5.0}}}, {C = {{"PosType", 9}, {"Sleep", "for", 10.0}}}, {C = {{"Arg", 38, "to", 0.9, "at", 0.6}}}}},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "at", 0.6}}}}},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"PosType", 9}, {"Sleep", "for", 15.0}}}, {C = {{"TearCanopy", 0}}}}},
			{Transition = {"Any", "Ditch"},  Sequence = {{C = {{"Sleep", "for", 1.0}}}, {C = {{"PosType", 9}, {"Sleep", "for", 2.0}}}, {C = {{"Arg", 38, "to", 0.9, "at", 0.6}}}}},
			
        },
        Door1 = {DuplicateOf = "Door0"},

        LeftStrut = {
            {Transition = {"Retract", "Extend"}, Sequence = {{C = {{"VelType", 5}, {"Arg", 5, "to", 1.0, "in", 9.0}, {"Arg", 116, "to", 1.0, "in", 9.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Extend", "Retract"}, Sequence = {{C = {{"VelType", 5}, {"Arg", 5, "to", 0.0, "in", 12.0}, {"Arg", 116, "to", 0.0, "in", 12.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Any", "Collapse"},   Sequence = {{C = {{"VelType", 5}, {"PosType", 6}, {"Arg", 5, "to", 0.5, "in", 2.0}, {"Arg", 116, "to", 0.5, "in", 2.0}}}}},
        },
        RightStrut = {
            {Transition = {"Retract", "Extend"}, Sequence = {{C = {{"VelType", 3}, {"Arg", 3, "to", 1.0, "in", 9.0}, {"Arg", 115, "to", 1.0, "in", 9.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Extend", "Retract"}, Sequence = {{C = {{"VelType", 3}, {"Arg", 3, "to", 0.0, "in", 12.0}, {"Arg", 115, "to", 0.0, "in", 12.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Any", "Collapse"},   Sequence = {{C = {{"VelType", 3}, {"PosType", 7}, {"Arg", 3, "to", 0.5, "in", 2.0}, {"Arg", 115, "to", 0.5, "in", 2.0}}}}},
        },
        CentralStrut = {
            {Transition = {"Retract", "Extend"}, Sequence = {{C = {{"VelType", 4}, {"Arg", 0, "to", 1.0, "in", 7.0}, {"Arg", 117, "to", 1.0, "in", 7.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Extend", "Retract"}, Sequence = {{C = {{"VelType", 4}, {"Arg", 0, "to", 0.0, "in", 8.0}, {"Arg", 117, "to", 0.0, "in", 8.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Any", "Collapse"},   Sequence = {{C = {{"VelType", 4}, {"PosType", 8}, {"Arg", 0, "to", 0.5, "in", 2.0}, {"Arg", 117, "to", 0.5, "in", 2.0}}}}},
        },
    },
	InheriteCommonCallnames = true,
	SpecificCallnames = {
		["USA"] = {}
	},
	fires_pos = 
	{
		[1] = 	{1.5,	0.6, 0.0},
		[8] = 	{2.0,	-0.1,	0.55},
		[9] = 	{2.0,	-0.1,  -0.55},
	}, -- end of fires_pos

	--sensors
	detection_range_max		 = 0,
	radar_can_see_ground 	 = false, -- this should be examined (what is this exactly?)
	CanopyGeometry 			 = makeAirplaneCanopyGeometry(LOOK_GOOD, LOOK_GOOD, LOOK_GOOD),

	------------------------------------
	aim_error_level_bombing 	= 1.0,
	aim_error_dive_bombing	 	= 10.0,
    aim_error_ground_attack		= 1.0,	
    date_of_introduction		= 1943.5,
	country_of_origin			= "USA",
	------------------------------------

	Sensors = {},--TODO ADD
	Guns 	= {
		-- Nose MG top right
        BrowningM2({
            muzzle_pos_connector = "Gun_point_2",
            effect_arg_number = 350,
            mixes = {
                {2, 2, 2, 2, 2, 2, 2, 4},
                {2},
                {4}
            },
            count = 350,
            barrel_circular_error = 0.0001,
            rates = {800 - 10},
            azimuth_initial = 0.0,
            elevation_initial = 0.0,
            supply_position = {-0.385, -0.179, -4.205},
            ejector_pos_connector = "ejector_Machinegun_01",
            ejector_dir           = {0, 5, 0},
            drop_cartridge        = 204,
            effects = {
                {name = "FireEffect", arg = 350, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),
		-- Nose MG top left
        BrowningM2({
            muzzle_pos_connector = "Gun_point_3",
            effect_arg_number = 433,
            mixes = {
                {2, 2, 2, 2, 2, 2, 2, 4},
                {2},
                {4}
            },
            count = 350,
            barrel_circular_error = 0.0001,
            rates = {800 - 10},
            azimuth_initial = 0.0,
            elevation_initial = 0.0,
            supply_position = {-0.385, -0.179, -4.205},
            ejector_pos_connector = "ejector_Machinegun_01",
            ejector_dir           = {0, 5, 0},
            drop_cartridge        = 204,
            effects = {
                {name = "FireEffect", arg = 433, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),
		-- Nose MG mid right
        BrowningM2({
            muzzle_pos_connector = "Gun_point_4",
            effect_arg_number = 434,
            mixes = {
                {2, 2, 2, 2, 2, 2, 2, 4},
                {2},
                {4}
            },
            count = 350,
            barrel_circular_error = 0.0001,
            rates = {800 - 10},
            azimuth_initial = 0.0,
            elevation_initial = 0.0,
            supply_position = {-0.385, -0.179, -4.205},
            ejector_pos_connector = "ejector_Machinegun_01",
            ejector_dir           = {0, 5, 0},
            drop_cartridge        = 204,
            effects = {
                {name = "FireEffect", arg = 434, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),
		-- Nose MG mid left
        BrowningM2({
            muzzle_pos_connector = "Gun_point_5",
            effect_arg_number = 435,
            mixes = {
                {2, 2, 2, 2, 2, 2, 2, 4},
                {2},
                {4}
            },
            count = 350,
            barrel_circular_error = 0.0001,
            rates = {800 - 10},
            azimuth_initial = 0.0,
            elevation_initial = 0.0,
            supply_position = {-0.385, -0.179, -4.205},
            ejector_pos_connector = "ejector_Machinegun_01",
            ejector_dir           = {0, 5, 0},
            drop_cartridge        = 204,
            effects = {
                {name = "FireEffect", arg = 435, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),
		
		-- Nose MG bottom right
        BrowningM2({
            muzzle_pos_connector = "Gun_point_7",
            effect_arg_number = 432,
            mixes = {
                {2, 2, 2, 2, 2, 2, 2, 4},
                {2},
                {4}
            },
            count = 350,
            barrel_circular_error = 0.0001,
            rates = {800 - 10},
            azimuth_initial = 0.0,
            elevation_initial = 0.0,
            supply_position = {-0.385, -0.179, -4.205},
            ejector_pos_connector = "ejector_Machinegun_01",
            ejector_dir           = {0, 5, 0},
            drop_cartridge        = 204,
            effects = {
                {name = "FireEffect", arg = 432, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),
		-- Nose MG mid left
        BrowningM2({
            muzzle_pos_connector = "Gun_point_6",
            effect_arg_number = 436,
            mixes = {
                {2, 2, 2, 2, 2, 2, 2, 4},
                {2},
                {4}
            },
            count = 350,
            barrel_circular_error = 0.0001,
            rates = {800 - 10},
            azimuth_initial = 0.0,
            elevation_initial = 0.0,
            supply_position = {-0.385, -0.179, -4.205},
            ejector_pos_connector = "ejector_Machinegun_01",
            ejector_dir           = {0, 5, 0},
            drop_cartridge        = 204,
            effects = {
                {name = "FireEffect", arg = 436, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
                {name = "SmokeEffect"},
            }
        }),
	
		TurretMount ("A20_TopTurret_M2_R", 				--6 
						{
							muzzle_pos_connector = "Gun_point_9",
							effect_arg_number = 348,
							count = 650,
							azimuth_initial = 0,
							elevation_initial = 0.0,
							aft_gun_mount		  = false,
						} , 
						{	
							name = "Top_turret",
							H_Arg = 451,				-- аргумент горизонтального поворота
							V_Arg = 452,				-- аргумент вертикального поворота
							H_Min = -120.0,				--минимальное горизонтальное отклонение пушки (градусы)
							H_Max =  120.0,				--максимальное горизонтальное отклонение пушки (градусы)
							V_Min =   0.0, 			--минимальное вертикальное отклонение пушки (градусы)
							V_Max =  85.0,				--максимальное вертикальное отклонение пушки (градусы)
							H_Vel =  40.0,				--скорость поворота пушки по горизонтали
							V_Vel =  40.0,
							SecondGun = 7,
							crewMemberInCommandIdx	= 2, -- член экипажа управляющий данной турелью ("Copilot / Gunner")
						}
					),
		TurretMount ("A20_TopTurret_M2_L", 				--7
						{
							muzzle_pos_connector = "Gun_point_8",
							effect_arg_number = 349,
							count = 650,
							azimuth_initial = 0,
							elevation_initial = 0.0,
							aft_gun_mount		  = false,
						} , 
						{	
							name = "Top_turret",							
							SlaveGun = true,
						}
					),
	},--TODO

	Pylons = {
		pylon(
            1, -- pylon index 
            2, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
            0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
            {
            },
            {
                {
                    CLSID = "{4xAN-M64_on_InvCountedAttachmentPoints}",
                },
            }
        ),
	},

	Tasks = {
		aircraft_task(GroundAttack),
		aircraft_task(RunwayAttack),
		aircraft_task(CAS),
        aircraft_task(AntishipStrike),
    },	
	DefaultTask = aircraft_task(CAS),

	SFM_Data = {
		aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		{
		
			Cy0			=	0.27,
			Mzalfa		=	4.355,  -- coefficients for pitch agility
			Mzalfadt	=	0.8, -- coefficients for pitch agility
			kjx			= 2.25,
			kjz 		= 0.00125,
			Czbe 		= -0.016,
			cx_gear 	= 0.0277,
			cx_flap 	= 0.033,
			cy_flap 	= 0.2,
			cx_brk 		= 0.06,
			
			table_data  = 
				{	
				--			M		Cx0			Cya			Bpol		B4			Omxmax		Aldop	Cymax	
					{	0.0	,	0.027	,	0.072	,	0.056	,	0.00001	,	0.000	,	16.0,	1.37	},
					{	0.05,	0.027	,	0.072	,	0.056	,	0.00001	,	0.1136	,	17.0,	1.37	},
					{	0.1	,	0.027	,	0.072	,	0.056	,	0.00001	,	0.2576	,	17.0,	1.4		},
					{	0.15,	0.027	,	0.072	,	0.056	,	0.00001	,	0.4288	,	17.0,	1.43	},
					{	0.2	,	0.027	,	0.072	,	0.056	,	0.00001	,	0.7428	,	17.0,	1.41	},
					{	0.244,	0.027	,	0.072	,	0.056	,	0.00001	,	0.722	,	17.0,	1.38	},
					{	0.3	,	0.027	,	0.072	,	0.056	,	0.00001	,	0.544	,	15.0,	1.31	},
					{	0.35,	0.027	,	0.072	,	0.056	,	0.00001	,	0.4508	,	14.0,	1.2		},
					{	0.4	,	0.027	,	0.072	,	0.056	,	0.00001	,	0.3868	,	13.0,	1.12	},
					{	0.45,	0.027	,	0.072	,	0.056	,	0.00001	,	0.3412	,	11.0,	1.0		},
					{	0.5	,	0.027	,	0.072	,	0.056	,	0.00001	,	0.3028	,	10.0,	0.89	},
					{	0.55,	0.029	,	0.072	,	0.056	,	0.00001	,	0.2724	,	8.0	,	0.75	},
					{	0.6	,	0.032	,	0.072	,	0.06	,	0.00001	,	0.2444	,	6.0	,	0.59	},
					{	0.65,	0.0365	,	0.074	,	0.063	,	0.00001	,	0.2164	,	5.0	,	0.45	},
					{	0.7	,	0.0438	,	0.076	,	0.065	,	0.00001	,	0.1956	,	4.2	,	0.34	},
					{	0.8	,	0.0567	,	0.072	,	0.069	,	0.00001	,	0.1676	,	3.0	,	0.25	},
					{	0.9	,	0.0723	,	0.07	,	0.07	,	0.00001	,	0.1604	,	2.5	,	0.22	},
				}, -- end of table_data
			-- M - Mach number
			-- Cx0 - Coefficient, drag, profile, of the airplane
			-- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
			-- B - Polar quad coeff
			-- B4 - Polar 4th power coeff
			-- Omxmax - roll rate, rad/s
			-- Aldop - Alfadop Max AOA at current M - departure threshold
			-- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
		}, -- end of aerodynamics
		engine = 
		{
            Nominal_RPM = 2600.0,
			Nmg	=	600.0 / 2600.0 * 100.0, -- RPM at idle
			MinRUD	=	0, -- Min state of the throttle
			MaxRUD	=	1, -- Max state of the throttle
			MaksRUD	=	1, -- Military power state of the throttle
			ForsRUD	=	1, -- Afterburner state of the throttle
			type	=	"Radial",
            cylinder_firing_order = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14},

			hMaxEng	=	12.5, -- Max altitude for safe engine operation in km
			dcx_eng	=	0.015, -- Engine drag coeficient
			cemax	=	0.37, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	0.37, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	1800, --  altitude coefficient for max thrust
			dpdh_f	=	1800,  --  altitude coefficient for AB thrust
			

			k_adiab_1			= 0.024,
			k_adiab_2			= 0.043,
			MAX_Manifold_P_1	= 89700,		
			MAX_Manifold_P_2	= 124280,		
			MAX_Manifold_P_3	= 144600,		
			k_after_cool		= 0.0,
			Displ				= 42.7,
			k_Eps				= 6.5,
			Stroke				= 0.16,
			V_pist_0			= 12.8,
			Nu_0				= 1.2,
			Nu_1				= 0.87,
			Nu_2				= 0.0035,
			N_indic_0			= 1023040*1390/1450,
			N_fr_0				= 0.042,
			N_fr_1				= 0.02,
			Init_Mom			= 220,
			D_prop				= 3.47,
			MOI_prop			= 61,
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
			},
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
            Startup_Prework = 12.0,
            Startup_RPMs = {
                {0.0, 0},
                {1.0, 66},
                {4.6, 66},
                {5.0, 800},
                {7.0, 600},
            },
            Startup_Ignition_Time = 4.6,
            Shutdown_Duration = 4.8,
		}, -- end of engine
	},
	
	net_animation = {},--TODO ADD

    -- Damage, index meaning see in Scripts\Aircrafts\_Common\Damage.lua
    Damage = verbose_to_dmg_properties({
        -- Fuselage -----------------------------------------------------------------------
        ["FUSELAGE_TOP"] = {
            args = {151}, damage_boundary = 0.1,
            critical_damage = 9, droppable = false,
            construction = {durability = 2.3, skin = "Aluminum"},
            children = {"FUSELAGE_BOTTOM", "FUSELAGE_LEFT_SIDE", "FUSELAGE_RIGHT_SIDE", "TURRET"},
            innards = {
                {id = "XArmor7", skin = "Steel", wall = 0.013},
                {id = "XArmor6", skin = "Steel", wall = 0.013},
            },
        },
        ["FUSELAGE_BOTTOM"] = {
            args = {152}, damage_boundary = 0.1,
            critical_damage = 21, droppable = false,
            construction = {durability = 7.3, skin = "Aluminum"},
            children = {"NOSE_BOTTOM", "TAIL_BOTTOM"},
            innards = {
                {id = "XArmor8", skin = "Steel", wall = 0.013},
                {id = "XArmor9", skin = "Steel", wall = 0.013},
            },
        },
        ["FUSELAGE_LEFT_SIDE"] = {
            args = {154}, damage_boundary = 0.1,
            critical_damage = 20, droppable = false,
            construction = {durability = 9.0, skin = "Aluminum"},
            children = {"WING_L_IN"},
        },
        ["FUSELAGE_RIGHT_SIDE"] = {
            args = {153}, damage_boundary = 0.1,
            critical_damage = 20, droppable = false,
            construction = {durability = 9.0, skin = "Aluminum"},
            children = {"WING_R_IN"},
        },
        -- --------------------------------------------------------------------------------

        -- Nose ---------------------------------------------------------------------------
        ["NOSE_BOTTOM"] = {
            args = {148}, damage_boundary = 0.1,
            critical_damage = 5, droppable = false,
            construction = {durability = 8.7, skin = "Aluminum"},
            children = {"CABIN_LEFT_SIDE", "CABIN_RIGHT_SIDE", "COCKPIT", "NOSE_LEFT_SIDE", "NOSE_RIGHT_SIDE", "NOSE_CENTER", "NOSE_TOP_SIDE", "GEAR_F"},
            innards = {
                {id = "XUCLockC", skin = "Steel", wall = 0.009,
                    failures = {
                        {"UNCR_C_STRUT_UP_LOCK_FAILURE", 0.35, "Exclusive"},
                        {"UNCR_C_STRUT_DOWN_LOCK_FAILURE", 0.35, "Exclusive"},
                    },
                },
                {id = "XHydroGearJackC", skin = "Steel", wall = 0.004},
                {id = "XArmor0", skin = "Steel", wall = 0.013},
                {id = "XArmor1", skin = "Steel", wall = 0.012},
                {id = "XArmor2", skin = "Steel", wall = 0.010},
                {id = "XArmor3", skin = "ReinforcedGlass", wall = 0.045},
                {id = "XArmor4", skin = "Steel", wall = 0.008},
                {id = "XArmor5", skin = "Steel", wall = 0.008},
                {id = "XCrew0"},
                {id = "XCrew0H"},
                {id = "XGun-100", skin = "Steel", wall = 0.002},
                {id = "XGun-101", skin = "Steel", wall = 0.002},
                {id = "XGun-102", skin = "Steel", wall = 0.002},
                {id = "XGun-103", skin = "Steel", wall = 0.002},
                {id = "XGun-104", skin = "Steel", wall = 0.002},
                {id = "XGun-105", skin = "Steel", wall = 0.002},
            },
        },
        ["CABIN_LEFT_SIDE"] = {
            args = {502},
            critical_damage = 3, droppable = false,
            construction = {durability = 1.5, skin = "Aluminum"},
        },
        ["CABIN_RIGHT_SIDE"] = {
            args = {501},
            critical_damage = 3, droppable = false,
            construction = {durability = 1.5, skin = "Aluminum"},
        },
        ["NOSE_LEFT_SIDE"] = {
            args = {150}, damage_boundary = 0.1,
            critical_damage = 9, droppable = false,
            construction = {durability = 2.6, skin = "Aluminum"},
        },
        ["NOSE_RIGHT_SIDE"] = {
            args = {149}, damage_boundary = 0.1,
            critical_damage = 9, droppable = false,
            construction = {durability = 2.6, skin = "Aluminum"},
        },
        ["NOSE_CENTER"] = {
            args = {146}, damage_boundary = 0.1,
            critical_damage = 2, droppable = false,
            construction = {durability = 0.3, skin = "Aluminum"},
        },
        ["NOSE_TOP_SIDE"] = {
            args = {147}, damage_boundary = 0.15,
            critical_damage = 4, droppable = false,
            construction = {durability = 5.2, skin = "Aluminum"},
        },
        -- --------------------------------------------------------------------------------

        -- Cabin and Top Turret -----------------------------------------------------------
        ["COCKPIT"] = {
            args = {-1},
            critical_damage = 2, droppable = false,
            construction = {durability = 1.0, skin = "Glass"},
        },
        ["TURRET"] = {
            args = {-1},
            critical_damage = 2, droppable = false,
            construction = {durability = 1.0, skin = "Glass"},
            innards = {
                {id = "XCrew1"},
                {id = "XCrew1H"},
            },
        },
        -- --------------------------------------------------------------------------------

        -- Tail ---------------------------------------------------------------------------
        ["TAIL_BOTTOM"] = {
            args = {156, -1, -1, -1, -1, 81}, damage_boundary = 0.1,
            critical_damage = 12, droppable = true,
            construction = {durability = 2.6, skin = "Aluminum"},
            children = {"TAIL_LEFT_SIDE", "TAIL_RIGHT_SIDE", "STABILIZER_L_IN", "STABILIZER_R_IN", "FIN_L_BOTTOM"},
            innards = {
                {id = "XCtrlLineRudder", skin = "Aluminum", wall = 0.006, plenum = 0.002},
                {id = "XCtrlLineElevator", skin = "Aluminum", wall = 0.006, plenum = 0.003},
                {id = "XArmor10", skin = "Steel", wall = 0.013},
            },
        },
        ["TAIL_LEFT_SIDE"] = {
            args = {158}, damage_boundary = 0.1,
            critical_damage = 12, droppable = false,
            construction = {durability = 2.9, skin = "Aluminum"},
        },
        ["TAIL_RIGHT_SIDE"] = {
            args = {157}, damage_boundary = 0.1,
            critical_damage = 12, droppable = false,
            construction = {durability = 2.9, skin = "Aluminum"},
        },
        -- --------------------------------------------------------------------------------

        -- Stabilizers --------------------------------------------------------------------
        ["STABILIZER_L_IN"] = {
            args = {236}, damage_boundary = 0.1,
            critical_damage = 7, droppable = true,
            construction = {durability = 1.3, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"STABILIZER_L_OUT"},
            innards = {
                {id = "XSparStabLHIn", skin = "Aluminum", wall = 0.005},
            },
        },
        ["STABILIZER_L_OUT"] = {
            args = {235}, damage_boundary = 0.1,
            critical_damage = 5, droppable = true,
            construction = {durability = 0.6, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"ELEVATOR_L_OUT"},
            innards = {
                {id = "XSparStabLHOut", skin = "Aluminum", wall = 0.005},
            },
        },
        ["ELEVATOR_L_OUT"] = {
            args = {240},
            critical_damage = 4, droppable = true,
            construction = {durability = 2.9, skin = "Aluminum", spar = "Truss"},
            innards = {
                {id = "XJointELH", skin = "Aluminum", wall = 0.010, count = 2},
            },
        },
        ["STABILIZER_R_IN"] = {
            args = {234}, damage_boundary = 0.1,
            critical_damage = 7, droppable = true,
            construction = {durability = 1.3, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"STABILIZER_R_OUT"},
            innards = {
                {id = "XSparStabRHIn", skin = "Aluminum", wall = 0.005},
            },
        },
        ["STABILIZER_R_OUT"] = {
            args = {233}, damage_boundary = 0.1,
            critical_damage = 5, droppable = true,
            construction = {durability = 0.6, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"ELEVATOR_R_OUT"},
            innards = {
                {id = "XSparStabRHOut", skin = "Aluminum", wall = 0.005},
            },
        },
        ["ELEVATOR_R_OUT"] = {
            args = {238},
            critical_damage = 4, droppable = true,
            construction = {durability = 2.9, skin = "Aluminum", spar = "Truss"},
            innards = {
                {id = "XJointERH", skin = "Aluminum", wall = 0.010, count = 2},
            },
        },
        -- --------------------------------------------------------------------------------

        -- Keel ---------------------------------------------------------------------------
        ["FIN_L_BOTTOM"] = {
            args = {243}, damage_boundary = 0.1,
            critical_damage = 8, droppable = true,
            construction = {durability = 1.8, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"FIN_L_TOP"},
            innards = {
                {id = "XSparKeelIn", skin = "Aluminum", wall = 0.005, plenum = 0.4},
            },
        },
        ["FIN_L_TOP"] = {
            args = {242}, damage_boundary = 0.05,
            critical_damage = 5, droppable = true,
            construction = {durability = 1.0, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"RUDDER"},
            innards = {
                {id = "XSparKeelOut", skin = "Aluminum", wall = 0.005, plenum = 0.8},
            },
        },
        ["RUDDER"] = {
            args = {247},
            critical_damage = 6, droppable = true,
            construction = {durability = 2.8, skin = "Aluminum", spar = "Truss"},
            innards = {
                {id = "XJointR", skin = "Aluminum", wall = 0.010, count = 2},
            },
        },
        -- --------------------------------------------------------------------------------

        -- Left Wing ----------------------------------------------------------------------
        ["WING_L_IN"] = {
            args = {225}, damage_boundary = 0.1,
            critical_damage = 20, droppable = true,
            construction = {durability = 4.6, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"WING_L_CENTER", "MTG_L_TOP_SIDE", "FLAP_L_IN"},
            innards = {
                {id = "XSparWLHIn0", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
                {id = "XSparWLHIn1", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
                {id = "XFuelTank1", skin = "Rubber", wall = 0.036, lining = "Rubber", plenum = 0.66},
                {id = "XEng0OilTank", skin = "Aluminum", wall = 0.006},
                {id = "XUCLockLHU", skin = "Steel", wall = 0.007},
                {id = "XHydroGearJackLH", skin = "CastIron", wall = 0.006},
            },
        },
        ["WING_L_CENTER"] = {
            args = {224}, damage_boundary = 0.2,
            critical_damage = 15, droppable = true,
            construction = {durability = 6.0, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"WING_L_OUT", "FLAP_L_OUT"},
            innards = {
                {id = "XSparWLHMid0", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
                {id = "XSparWLHMid1", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
                {id = "XFuelTank0", skin = "Rubber", wall = 0.036, lining = "Rubber", plenum = 0.66},
                {id = "XCtrlLineAileronLH", skin = "Steel", wall = 0.002, plenum = 0.001},
            },
        },
        ["WING_L_OUT"] = {
            args = {223}, damage_boundary = 0.2,
            critical_damage = 15, droppable = true,
            construction = {durability = 3.6, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"AILERON_L"},
            innards = {
                {id = "XSparWLHOut0", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
                {id = "XSparWLHOut1", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
            },
        },
        ["AILERON_L"] = {
            args = {226},
            critical_damage = 5, droppable = true,
            construction = {durability = 2.2, skin = "Aluminum", spar = "Truss"},
            innards = {
                {id = "XJointALH", skin = "Aluminum", wall = 0.010, count = 3},
            },
        },
        ["FLAP_L_IN"] = {
            args = {228},
            critical_damage = 5, droppable = true,
            construction = {durability = 0.5, skin = "Aluminum", spar = "Truss"},
            innards = {
                {id = "XJointFlapLH1", skin = "Aluminum", wall = 0.010, count = 2,
                    failures = {
                        {"CTRL_LANDING_FLAPS_LH_MECHANICAL", 0.5},
                    },
                },
            },
        },
        ["FLAP_L_OUT"] = {
            args = {227},
            critical_damage = 5, droppable = true,
            construction = {durability = 0.5, skin = "Aluminum", spar = "Truss"},
            innards = {
                {id = "XJointFlapLH0", skin = "Aluminum", wall = 0.010, count = 2,
                    failures = {
                        {"CTRL_LANDING_FLAPS_LH_MECHANICAL", 0.5},
                    },
                },
            },
        },
        -- --------------------------------------------------------------------------------

        -- Right Wing ---------------------------------------------------------------------
        ["WING_R_IN"] = {
            args = {215}, damage_boundary = 0.1,
            critical_damage = 20, droppable = true,
            construction = {durability = 4.6, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"WING_R_CENTER", "MTG_R_TOP_SIDE", "FLAP_R_IN"},
            innards = {
                {id = "XSparWRHIn0", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
                {id = "XSparWRHIn1", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
                {id = "XFuelTank2", skin = "Rubber", wall = 0.036, lining = "Rubber", plenum = 0.66},
                {id = "XEng1OilTank", skin = "Aluminum", wall = 0.006},
                {id = "XUCLockRHU", skin = "Steel", wall = 0.007},
                {id = "XHydroGearJackRH", skin = "CastIron", wall = 0.006},
            },
        },
        ["WING_R_CENTER"] = {
            args = {214}, damage_boundary = 0.2,
            critical_damage = 15, droppable = true,
            construction = {durability = 6.0, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"WING_R_OUT", "FLAP_R_OUT"},
            innards = {
                {id = "XSparWRHMid0", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
                {id = "XSparWRHMid1", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
                {id = "XFuelTank3", skin = "Rubber", wall = 0.036, lining = "Rubber", plenum = 0.66},
                {id = "XCtrlLineAileronRH", skin = "Steel", wall = 0.002, plenum = 0.001},
            },
        },
        ["WING_R_OUT"] = {
            args = {213}, damage_boundary = 0.2,
            critical_damage = 15, droppable = true,
            construction = {durability = 3.6, skin = "Aluminum", spar = "FlangeBeam"},
            children = {"AILERON_R"},
            innards = {
                {id = "XSparWRHOut0", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
                {id = "XSparWRHOut1", skin = "Aluminum", wall = 0.005, count = 2, plenum = 0.25, durability = 1.25},
            },
        },
        ["AILERON_R"] = {
            args = {216},
            critical_damage = 5, droppable = true,
            construction = {durability = 2.2, skin = "Aluminum", spar = "Truss"},
            innards = {
                {id = "XJointARH", skin = "Aluminum", wall = 0.010, count = 3},
            },
        },
        ["FLAP_R_IN"] = {
            args = {218},
            critical_damage = 5, droppable = true,
            construction = {durability = 0.5, skin = "Aluminum", spar = "Truss"},
            innards = {
                {id = "XJointFlapRH1", skin = "Aluminum", wall = 0.010, count = 2,
                    failures = {
                        {"CTRL_LANDING_FLAPS_RH_MECHANICAL", 0.5},
                    },
                },
            },
        },
        ["FLAP_R_OUT"] = {
            args = {217},
            critical_damage = 5, droppable = true,
            construction = {durability = 0.5, skin = "Aluminum", spar = "Truss"},
            innards = {
                {id = "XJointFlapRH0", skin = "Aluminum", wall = 0.010, count = 2,
                    failures = {
                        {"CTRL_LANDING_FLAPS_RH_MECHANICAL", 0.5},
                    },
                },
            },
        },
        -- --------------------------------------------------------------------------------

        -- Engine 1 -----------------------------------------------------------------------
        ["MTG_L_TOP_SIDE"] = {
            args = {168}, damage_boundary = 0.1,
            critical_damage = 3, droppable = false,
            construction = {durability = 2.9, skin = "Aluminum"},
            children = {"ENGINE_L", "MTG_L_LEFT_SIDE", "MTG_L_RIGHT_SIDE", "MTG_L_BOTTOM", "MTG_L_TAIL", "GEAR_L"},
        },
        ["MTG_L_LEFT_SIDE"] = {
            args = {170}, damage_boundary = 0.1,
            critical_damage = 3, droppable = false,
            construction = {durability = 2.5, skin = "Aluminum"},
        },
        ["MTG_L_RIGHT_SIDE"] = {
            args = {-1}, damage_boundary = 0.1,
            critical_damage = 3, droppable = false,
            construction = {durability = 2.5, skin = "Aluminum"},
        },
        ["MTG_L_BOTTOM"] = {
            args = {169}, damage_boundary = 0.1,
            critical_damage = 2, droppable = false,
            construction = {durability = 2.7, skin = "Aluminum"},
        },
        ["MTG_L_TAIL"] = {
            args = {167}, damage_boundary = 0.1,
            critical_damage = 1, droppable = false,
            construction = {durability = 0.6, skin = "Aluminum"},
        },
        ["ENGINE_L"] = {
            args = {166}, damage_boundary = 0.1,
            critical_damage = 6, droppable = false,
            construction = {durability = 1.6, skin = "Aluminum"},
            children = {"ROTOR_L"},
            innards = {
                {id = "XEng0Case", skin = "CastIron", wall = 0.036, plenum = 0.75},
                {id = "XEng0Heads", count = 14, skin = "Aluminum", wall = 0.023, plenum = 0.6},
            },
        },
        ["ROTOR_L"] = {
            args = {-1},
            critical_damage = 1, droppable = false,
            children = {"BLADE_1_IN", "BLADE_2_IN", "BLADE_3_IN"},
        },
        ["BLADE_1_IN"] = {
            args = {429},
            critical_damage = 3, droppable = false,
            construction = {durability = 0.2, skin = "Aluminum"},
            children = {"BLADE_1_OUT"},
        },
        ["BLADE_2_IN"] = {
            args = {429},
            critical_damage = 3, droppable = false,
            construction = {durability = 0.2, skin = "Aluminum"},
            children = {"BLADE_2_OUT"},
        },
        ["BLADE_3_IN"] = {
            args = {429},
            critical_damage = 3, droppable = false,
            construction = {durability = 0.2, skin = "Aluminum"},
            children = {"BLADE_3_OUT"},
        },
        ["BLADE_1_OUT"] = {
            args = {380},
            critical_damage = 3, 
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.66, maximal = 0.33}},
        },
        ["BLADE_2_OUT"] = {
            args = {380},
            critical_damage = 3, 
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.33, maximal = 0.66}},
        },
        ["BLADE_3_OUT"] = {
            args = {380},
            critical_damage = 3, 
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.66, maximal = 1.0}},
        },
        -- --------------------------------------------------------------------------------

        -- Engine 2 -----------------------------------------------------------------------
        ["MTG_R_TOP_SIDE"] = {
            args = {162}, damage_boundary = 0.1,
            critical_damage = 3, droppable = false,
            construction = {durability = 2.9, skin = "Aluminum"},
            children = {"ENGINE_R", "MTG_R_LEFT_SIDE", "MTG_R_RIGHT_SIDE", "MTG_R_BOTTOM", "MTG_R_TAIL", "GEAR_R"},
        },
        ["MTG_R_LEFT_SIDE"] = {
            args = {165}, damage_boundary = 0.1,
            critical_damage = 3, droppable = false,
            construction = {durability = 2.5, skin = "Aluminum"},
        },
        ["MTG_R_RIGHT_SIDE"] = {
            args = {164}, damage_boundary = 0.1,
            critical_damage = 3, droppable = false,
            construction = {durability = 2.5, skin = "Aluminum"},
        },
        ["MTG_R_BOTTOM"] = {
            args = {163}, damage_boundary = 0.1,
            critical_damage = 2, droppable = false,
            construction = {durability = 2.7, skin = "Aluminum"},
        },
        ["MTG_R_TAIL"] = {
            args = {161}, damage_boundary = 0.1,
            critical_damage = 1, droppable = false,
            construction = {durability = 0.6, skin = "Aluminum"},
        },
        ["ENGINE_R"] = {
            args = {160}, damage_boundary = 0.1,
            critical_damage = 6, droppable = false,
            construction = {durability = 1.6, skin = "Aluminum"},
            children = {"ROTOR_R"},
            innards = {
                {id = "XEng1Case", skin = "CastIron", wall = 0.036, plenum = 0.75},
                {id = "XEng1Heads", count = 14, skin = "Aluminum", wall = 0.023, plenum = 0.6},
            },
        },
        ["ROTOR_R"] = {
            args = {-1},
            critical_damage = 1, droppable = false,
            children = {"BLADE_4_IN", "BLADE_5_IN", "BLADE_6_IN"},
        },
        ["BLADE_4_IN"] = {
            args = {430},
            critical_damage = 3, droppable = false,
            construction = {durability = 0.2, skin = "Aluminum"},
            children = {"BLADE_4_OUT"},
        },
        ["BLADE_5_IN"] = {
            args = {430},
            critical_damage = 3, droppable = false,
            construction = {durability = 0.2, skin = "Aluminum"},
            children = {"BLADE_5_OUT"},
        },
        ["BLADE_6_IN"] = {
            args = {430},
            critical_damage = 3, droppable = false,
            construction = {durability = 0.2, skin = "Aluminum"},
            children = {"BLADE_6_OUT"},
        },
        ["BLADE_4_OUT"] = {
            args = {381},
            critical_damage = 3, 
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.66, maximal = 0.33}},
        },
        ["BLADE_5_OUT"] = {
            args = {381},
            critical_damage = 3, 
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.33, maximal = 0.66}},
        },
        ["BLADE_6_OUT"] = {
            args = {381},
            critical_damage = 3, 
            construction = {durability = 999, min_max_arg_to_break = {minimal = 0.66, maximal = 1.0}},
        },
        -- --------------------------------------------------------------------------------

        -- Undercarriage ------------------------------------------------------------------
        ["GEAR_L"] = {
            args = {-1},
            critical_damage = 3, droppable = false,
            children = {"WHEEL_L"},
            construction = {durability = 10.0, skin = "Steel", spar = "Rod"},
            innards = {
                {id = "XUCShockLH", skin = "Steel", wall = 0.008},
            },
        },
        ["WHEEL_L"] = {
            args = {136}, damage_boundary = 1.0,
            critical_damage = 0.5,
            construction = {durability = 0.5, skin = "Rubber"},
            innards = {
                {id = "XUCWheelDrumLH", skin = "CastIron", wall = 0.012},
            },
        },
        ["GEAR_R"] = {
            args = {-1},
            critical_damage = 3, droppable = false,
            children = {"WHEEL_R"},
            construction = {durability = 10.0, skin = "Steel", spar = "Rod"},
            innards = {
                {id = "XUCShockRH", skin = "Steel", wall = 0.008},
            },
        },
        ["WHEEL_R"] = {
            args = {135}, damage_boundary = 1.0,
            critical_damage = 0.5,
            construction = {durability = 0.5, skin = "Rubber"},
            innards = {
                {id = "XUCWheelDrumRH", skin = "CastIron", wall = 0.012},
            },
        },
        ["GEAR_F"] = {
            args = {-1},
            critical_damage = 3, droppable = false,
            children = {"WHEEL_F"},
            construction = {durability = 10.0, skin = "Steel", spar = "Rod"},
            innards = {
                {id = "XUCShockC", skin = "Steel", wall = 0.008},
            },
        },
        ["WHEEL_F"] = {
            args = {134}, damage_boundary = 1.0,
            critical_damage = 0.5,
            construction = {durability = 0.5, skin = "Rubber"},
            innards = {
            },
        },
        -- --------------------------------------------------------------------------------
    }),

	DamageParts = {
        [1] = "a-20g_oblomok_wing_r", -- wing R
        [2] = "a-20g_oblomok_wing_l", -- wing L
        --[3] = "", -- nose
        [4] = "a-20g_oblomok_tail", -- tail
    },
	AddPropAircraft = {},--TODO ADD
	Failures 		= {},--TODO ADD

    lights_data = {
        typename = "collection",
        lights = {
        },
    },
}



-- Finalize
add_aircraft(A_20G)
