--/N/ 08. Aug 2014.
local self_ID = "I-16 AI by OctopusG"

declare_plugin(self_ID,
{
installed 	 = true,
dirName	 	 = current_mod_path,
version		 = "1.0.0",
state		 = "installed",
info		 = _("I-16 AI"),
encyclopedia_path = current_mod_path..'/Encyclopedia'
})

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/I-16")

---------------------------------------------------------

local mixes_shkas =
{
{1,2,2,2,2},
{2,1,2,2,2},
{2,2,1,2,2},
{2,2,2,1,2},
{2,2,2,2,1},
}
local actual_mix = 1

function shkas_mount(tbl)

	local mix = mixes_shkas[actual_mix]
	actual_mix = actual_mix + 1
	if actual_mix > #mixes_shkas then
	   actual_mix = 1
	end
	tbl.category = CAT_GUN_MOUNT 
	tbl.name 	 = "SHKAS_GUN"
	tbl.supply 	 = 
	{
		shells = {"7_62x54","7_62x54_NOTRACER"}, 
		mixes  = {mix}, -- ????????
		count  = tbl.count or 450,
	}
	if tbl.mixes then 
	   tbl.supply.mixes = tbl.mixes
	   tbl.mixes	    = nil
	end
	tbl.gun = 
	{
		max_burst_length = 267, -- ????????
		rates 			 = {1800}, 
		recoil_coeff 	 = 1,
		barrels_count 	 = 1
	}
	if tbl.rates then 
	   tbl.gun.rates    = tbl.rates
	   tbl.rates	    = nil
	end	
	tbl.ejector_pos 			= tbl.ejector_pos or {-0.4, -1.2, 0.18}
	tbl.ejector_dir 			= {0,-1,0}
	tbl.supply_position  		= tbl.supply_position   or {0,  0.3, -0.3}
	tbl.aft_gun_mount 			= false
	tbl.barrel_circular_error	= 0.003
	tbl.effective_fire_distance = 500 
	tbl.drop_cartridge 			= 205 
	tbl.muzzle_pos				= tbl.muzzle_pos 		 or  {0,0,0} -- all position from connector
	tbl.muzzle_pos_connector	= tbl.muzzle_pos_connector 		 or  "Gun_point" -- all position from connector
	tbl.azimuth_initial 		= tbl.azimuth_initial    or 0   
	tbl.elevation_initial 		= tbl.elevation_initial  or 0   
	if  tbl.effects == nil then
		if tbl.muzzle_pos[3] > 0.5 or tbl.muzzle_pos[3] < -0.5 then  -- wing guns
			tbl.effects = {
							{ name = "FireEffect"     , arg 		 = tbl.effect_arg_number or 432 },
							{ name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
							--{ name = "SmokeEffect"}
						  }
		else  -- nose guns with synchronizer
			tbl.effects = {
							{ name = "GunSynchronizer", sectors = 2, reduction_gear = 1, engine_rpm_nominal = 2200, dead_angle_degrees = 30},
							{ name = "FireEffect"     , arg 		 = tbl.effect_arg_number or 432 },
							{ name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
							--{ name = "SmokeEffect"}
						  }
		end
	end
	return declare_weapon(tbl)
end

----- RS-82 ---------
local function make_RS82()
	local t = {}
	t.name  			= "RS-82"
	t.model 			= "i16_RS-82"
	t.user_name 		= _("RS-82")
	t.scheme			= "nurs-standard"
	t.category   		= CAT_ROCKETS
	t.wsTypeOfWeapon 	= {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER}
	t.L 				= 0.55
	t.mass    			= 6.8-- weight with kg
	t.fm 		 		= 
	{
		mass        = 6.8,-- weight with kg
		caliber     = 0.082,  
		cx_coeff    = {0.4,0.89,0.78,0.22,1.83},
		L			= 0.55,
		I           = 1.7240,-- kgm2 - moment of inertia  I = 1/12 ML2
		Ma          = 0.23322,-- dependence moment coefficient of  by  AoA angular acceleration  T / I
		Mw          = 2.177036,--rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t     
		wind_time   = 1.3,-- dispersion coefficient
		wind_sigma  = 36,
		freq        = 0.1,
		shapeName	= t.model
	}
	t.warhead    		= predefined_warhead("HYDRA_70_MK1")
	----------------------------------------
	t.engine    		= {
		fuel_mass   			= 1.1,
		boost_time  			= 0,
		work_time   			= 0.5,
		boost_factor			= 1,
		nozzle_position 	    =  {{-0.245, -0.042, 0}},
		nozzle_orientationXYZ   =  {{0, 0, 0}},
		tail_width  			= 0.052,
		boost_tail  			= 1,
		work_tail   			= 1,
		smoke_color 			= {0.6, 0.6, 0.6},
		smoke_transparency 		= 0.3,
		motor_length 			= 0.4,
		impulse 				= 3300 / (9.8 * 1.1 / 0.5), --3300 / (9.8 * fuel_mass / work_time)
	}
	t.properties = 
	{
		dist_min = 600,   -- min range, meters
		dist_max = 1200,  -- max range, meters
		cx_pil	 = 0.00017;
	}
	t.shape_table_data ={
		{
			name     = t.model,
			file     = t.model,
			life     = 1,
			fire     = {0, 1},
			username = t.name,
			index    = WSTYPE_PLACEHOLDER,
		},
	}
	declare_weapon(t)
	return t
end

local RS82 = make_RS82()


declare_loadout({
    category 		= CAT_ROCKETS,
    CLSID 			= "I16_RS_82",
	attribute		= RS82.wsTypeOfWeapon,
	Picture 		= "HVAR.png",
    displayName 	= RS82.user_name,
    Weight_Empty 	= 2.9,
    Weight 			= 2.9 + RS82.mass,
	Cx_item 		= 0.00011;
    Cx_pil 			= 0.00017,
    Elements = {
        {
            ShapeName = RS82.model
        },
    },
})

----- FAB-100SV ---------
local FAB_100SV = {
	category		= CAT_BOMBS,
	name			= "FAB_100SV",
	model			= "i16_FAB-100SV",
	user_name		= _("FAB-100SV"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
	scheme			= "bomb-common",
    type			= 0,
    mass			= 100,
    hMin			= 1000.0,
    hMax			= 12000.0,
    Cx				= 0.00035,
    VyHold			= -100.0,
    Ag				= -1.23,

	fm = {
            mass            = 100,
            caliber         = 0.3,
            cx_coeff        = {1.0, 0.39, 0.38, 0.236, 1.31},
            L               = 0.9,
            I               = 6.75,
            Ma              = 0.68,
            Mw              = 1.116,
            wind_time       = 100.0,
            wind_sigma      = 20.0,
			cx_factor		= 100,
    },
  
	warhead = {
		mass                 = 40,
		expl_mass            = 40,
		other_factors        = {1, 1, 1},
		obj_factors          = {1, 1},
		concrete_factors     = {1, 1, 1},
		cumulative_factor    = 0,
		concrete_obj_factor  = 0,
		cumulative_thickness = 0,
		piercing_mass        = 8,
		caliber              = 300,
	},

	 -- velK is calibrated to get arming time of 0.8 seconds at initial bomb speed of 150 m/s (540 km/h)
	arming_vane = {enabled = true, velK = 0.00834},
	-- overriding default setting (delay is enabled for all bombs by default)
	arming_delay = {enabled = false, delay_time = 0},

	shape_table_data = {
		{
			name     = "FAB_100SV",
			file     = "i16_FAB-100SV",
			life     = 1,
			fire     = {0, 1},
			username = "FAB_100SV",
			index    = WSTYPE_PLACEHOLDER,
		},
	},
 
	targeting_data = {
		char_time = 21.5,
	},
}
declare_weapon(FAB_100SV)

declare_loadout(
{
	category 		= CAT_BOMBS,
	CLSID	 		= "I16_FAB_100SV",
	attribute		= FAB_100SV.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= FAB_100SV.Cx,
	Picture			= "FAB100.png", 
	displayName		= FAB_100SV.user_name,
	Weight			= FAB_100SV.mass,
	Elements  = {
		{
			ShapeName = "i16_FAB-100SV",
		}, 
	},
}
)

declare_loadout(
{
	category = CAT_FUEL_TANKS,
	CLSID = "I16_DROP_FUEL_TANK", 
	displayName = _("I-16 External Fuel Tank"),
    attribute       = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
    Picture         = "i16_fuel_tank.png",
    PictureBlendColor = "0xffffffff",
    Weight_Empty    = 5.0,
    Weight          = 5.0 + 68.0, --93L
    Cx_pil          = 0.0007, -- 21km/h
    shape_table_data = {
        {
            file    = "i16_eft",
            life    = 1,
            fire    = {0, 1},
            username= _("I-16 External Fuel Tank"),
            index   = WSTYPE_PLACEHOLDER,
        },
    },
    Elements = {
        {
            --[[DrawArgs = {
                [1] = {19, 0.0},
                [2] = {57, 0.0},
            }, 
            Position = {0, 0, 0},]]
            ShapeName = "i16_eft",
        }, 
    }, 
})


--[[declare_loadout(
	{
		category		= CAT_PODS,
		CLSID			= "I16_RS_82_S",
		Picture			= "HVAR.png",
		displayName		= _("HVAR_SMOKE_2"),
		
		attribute	=	{4,	15,	50,	WSTYPE_PLACEHOLDER},			
		Smoke  = {
			alpha = 180,
			r  = 245,
			g  = 40,
			b  = 100,
			dx = -1.455,
			dy = -0.062
		}, -- red R-73U
		
		shape_table_data = 
		{
			{
				name 	= "HVAR_SMOKE_2",
				file	= "i16_RS-82";
				life	= 1;
				fire	= { 0, 1};
				username	= "HVAR_SMOKE_2";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Weight			= 100,
		Count 			= 1,
		Cx_pil			= 0.001313754,
		Elements		={{
								ShapeName	=	"i16_RS-82", 
								Position	=	{0,- 0.059317,0}, 
								DrawArgs	=	{[3] = {3,0.1}}
							}}
	}
)]]


I_16 =  {
        
	Name 				=   'I-16',
	DisplayName			= _('I-16'),
	Picture 			= "I-16-24.png",
	Rate 				= 20, -- RewardPoint in Multiplayer
	Shape 				= "I-16",
	propellorShapeType  = "3ARG_PROC_BLUR",
    propellorShapeName  = "I-16_blade.FBX",

	HumanCockpit 		= false,
	HumanCockpitPath    = false, --current_mod_path..'/Cockpit/',

	
	shape_table_data 	= 
	{
		{
			file  	 = 'I-16';
			life  	 = 15; -- прочность объекта (методом lifebar*) -- The strength of the object (ie. lifebar *)
			vis   	 = 3; -- множитель видимости (дл€ маленьких объектов лучше ставить поменьше). Visibility factor (For a small objects is better to put lower nr).
			desrt    = 'I-16_destr',-- Name of destroyed object file name
			fire  	 = { 300, 2}; -- Fire on the ground after destoyed: 300sec 4m
			username = 'I-16';
			index    =  WSTYPE_PLACEHOLDER;
			classname = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  = "I-16_destr";
			file  = "I-16_oblomok";
			fire  = { 240, 2};
			classname = "lLandPlane";
			positioning = "BYNORMAL";			
		},

	},
	mapclasskey 		= "P0091000024",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER ,"Battleplanes",},
	Categories 			= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},	
	-------------------------
	 M_empty	= 1614, -- (with pilot and nose load), kg
	 M_nominal	= 1878, -- kg	
	 M_max		= 2146, -- kg

	M_fuel_max	= 191, -- (260 l) + 2*93 l  external!!
	H_max		= 9700,
	average_fuel_consumption	=	0.08,
	CAS_min	=	56,
	V_opt	=	97,
	V_take_off	=	45,
	V_land	=	39,
	has_afteburner	=	false,
	has_speedbrake	=	false,
	has_differential_stabilizer = false,
	radar_can_see_ground	=	false,
	main_gear_pos = { 0.4,  -1.59,  1.15},
	nose_gear_pos = {-3.93, -0.348,  0},
	nose_gear_amortizer_direct_stroke    =  0.05,  -- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke  =  -0.05,  -- up 
	main_gear_amortizer_direct_stroke	 =  0.05, --  down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke  = 	-0.05, --  up 
	nose_gear_amortizer_normal_weight_stroke = 0,-- down from nose_gear_pos
	main_gear_amortizer_normal_weight_stroke =  0,-- down from main_gear_pos

	AOA_take_off	=	0.17,
	bank_angle_max	=	60,
	tand_gear_max	=	573,
	V_max_sea_level	=	113,
	V_max_h	=	129,
	tanker_type	=	0,
	wing_area	=	14.54,
	wing_span	=	9.004,
	thrust_sum_max	=	1100,
	thrust_sum_ab	=	1200, 
	Vy_max	=	14.7,
	length	=	6.13,
	height	=	3.25,
	flaps_maneuver	=	0.0,
	Mach_max	=	0.41, --500 kph
	range	=	440,
	RCS	=	2.5,
	Ny_min = -4, 
	Ny_max 	= 8.0,
	Ny_max_e = 8.0,
	detection_range_max	=	0,
	IR_emission_coeff	=	0.1,
	IR_emission_coeff_ab	=	0,
	engines_count	=	1,
	wing_tip_pos = 	{-0.152, -0.225,	4.493},
	nose_gear_wheel_diameter	=	0.25,
	main_gear_wheel_diameter	=	0.66,

	--sounderName = "Aircraft/Planes/I16",
	--sounderName = "../." .. current_mod_path .. "/Sounder/I16",
	--sounderName = "../../CoreMods/aircraft/I-16/Sounder/I16",

	engines_nozzles =
	{
		[1] = 
		{
			pos 		=  {1.624990,0.047866,-0.56}, -- nozzle coords
			elevation   =  0, -- AFB cone elevation
			diameter	 = 0*0.1, -- AFB cone diameter
			exhaust_length_ab   = -3.0, -- lenght in m
			exhaust_length_ab_K = 0.3, -- AB animation
			engine_number  = 1, --both to first engine
		}, -- end of [1]
		[2] = 
		{
			pos 		=  {1.624990,0.047866,0.56}, -- nozzle coords
			elevation   =  0, -- AFB cone elevation
			diameter	 = 0*0.1, -- AFB cone diameter
			exhaust_length_ab   = -3.0, -- lenght in m
			exhaust_length_ab_K = 0.3, -- AB animation
			engine_number  = 1, --both to first engine
		}, -- end of [1]
	}, -- end of engines_nozzles
	crew_members = 
	{
		[1] = 
		{
			pilot_name			=	"i16_pilot.EDM",
			ejection_seat_name  = 	 0,
			drop_canopy_name	=	0,
			drop_parachute_name	 =  "i16_pilot_parachute",
			pos		   = 	{-1.439000,0.182000,0.000000},
			canopy_pos =	{ 0,0,0},
            canopy_arg          = -1,
            bailout_arg         = -1,
            boarding_arg        = 252,
		}, -- end of [1]
	}, -- end of crew_members
	brakeshute_name	=	0,
	is_tanker	=	false,
	fires_pos = 
	{
		[1] = 	{-2,	0.595,	0.5},
		[2] = 	{0,	0,	2.237},
		[3] = 	{0,	0,	-2.237},
		[4] = 	{0.265,	0,	1.5},
		[5] = 	{-0.265,	0,	-1.5},
		[6] = 	{0.5,	0,	4.274},
		[7] = 	{0.5,	0,	-4.274},
		[8] = 	{-5,	0.5,	0},
		[9] = 	{-5,	0.5,	0},
		[10] = 	{-5,	0.5,	0},
		[11] = 	{-5,	0.5,	0},
	}, -- end of fires_pos
	-- add model draw args for network transmitting to this draw_args table (16 limit)
	
	net_animation = { 420 }, --external_model_throttle_arg

	chaff_flare_dispenser = 
	{
		[1] = 
		{
			dir = 	{0,	1,	0},
			pos = 	{-5.776,	1.4,	-0.422},
		}, -- end of [1]
		[2] = 
		{
			dir = 	{0,	1,	0},
			pos = 	{-5.776,	1.4,	0.422},
		}, -- end of [2]
	}, 

	--Guns = {gun_mount("GSh_23_2", { count = 150 },{impulse_vec_rot = {x = 0,y = 0.3,z = -0.3 * 0 }})},			
	
	Guns = {
			-- left wing
			shkas_mount({muzzle_pos = {0.716,   -0.333,  -1.536 }, muzzle_pos_connector = "Gun_point1", count = 900, effect_arg_number = 432, azimuth_initial = -0.22, elevation_initial = 0.4, supply_position = {0.5,   -0.2,  -0.3}, ejector_pos_connector = "ejector_point_1"}), --ejector_pos = {-0.35, -0.12, 0.0}}), 
			-- left nose
			shkas_mount({muzzle_pos = {1.272,   0.593,  -0.221 }, muzzle_pos_connector = "Gun_point2",  count = 500, effect_arg_number = 433, azimuth_initial = -0.033, elevation_initial = 0.15, supply_position = {0.5,   -0.2,  -0.3}, ejector_pos_connector = "ejector_point_2"}), -- ejector_pos = {-0.5, -1.25, 0.0}}), 

			-- right nose
			shkas_mount({muzzle_pos = {1.272,   0.593,  0.221 }, muzzle_pos_connector = "Gun_point3",  count = 500, effect_arg_number = 434, azimuth_initial = 0.033, elevation_initial = 0.15, supply_position = {0.5,   -0.2,  0.3}, ejector_pos_connector = "ejector_point_3"}), -- ejector_pos = {-0.5, -1.25, 0.0}}),
			-- right wing
			shkas_mount({muzzle_pos = {0.716,   -0.333,   1.536 }, muzzle_pos_connector = "Gun_point4",  count = 900, effect_arg_number = 435, azimuth_initial = 0.22, elevation_initial = 0.4, supply_position = {0.5,   -0.2,  0.3}, ejector_pos_connector = "ejector_point_4"}), -- ejector_pos = {-0.35, -0.12, 0.0}}),
	},


	Pylons = {
        pylon(
            1, -- pylon index 
            0, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
            0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
            {
                use_full_connector_position = true,
                connector = "Pylon1",
                arg = 308,
                arg_value = 1,
            },
            {
                {
                    CLSID = "I16_RS_82",
                    arg_value = 0.0,
                },
                --{
                --    CLSID = "I16_RS_82_S",
                --    arg_value = 0.0,
                --},
            }
        ),
        pylon(
            2, -- pylon index 
            0, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
            0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
            {
                use_full_connector_position = true,
                connector = "Pylon2",
                arg = 309,
                arg_value = 1,
            },
            {
                {
                    CLSID = "I16_RS_82",
                    arg_value = 0.0,
                },
            }
        ),
	    pylon(
			3, -- pylon index 
			0, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
			0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
			{
				use_full_connector_position = true,
				connector = "Pylon3",
				arg = 310,
				arg_value = 1,
			},
			{
				{
					CLSID = "I16_RS_82",
					arg_value = 0.0,
				},
			}
		),
		pylon( -- bomb/tank left
			4, -- pylon index 
			1, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
			0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
			{
				use_full_connector_position = true,
				connector = "Pylon7",
				arg = 314,
				arg_value = 1,
			},
			{
				{
					CLSID = "I16_FAB_100SV", --"{FB3CE165-BF07-4979-887C-92B87F13276B}", 
					arg_value = 0.0,
				},
				{
					CLSID = "I16_DROP_FUEL_TANK", 
					arg_value = 0.5,
				},
			}
		),

		pylon( -- bomb/tank right
			5, -- pylon index 
			1, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
			0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
			{
				use_full_connector_position = true,
				connector = "Pylon8",
				arg = 315,
				arg_value = 1,
			},
			{
				{
					CLSID = "I16_FAB_100SV", --"{FB3CE165-BF07-4979-887C-92B87F13276B}", 
					arg_value = 0.0,
				},
				{
					CLSID = "I16_DROP_FUEL_TANK", 
					arg_value = 0.5,
				},
			}
		),
	    pylon(
			6, -- pylon index 
			0, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
			0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
			{
				use_full_connector_position = true,
				connector = "Pylon4",
				arg = 311,
				arg_value = 1,
			},
			{
				{
					CLSID = "I16_RS_82",
					arg_value = 0.0,
				},
			}
		),
	    pylon(
			7, -- pylon index 
			0, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
			0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
			{
				use_full_connector_position = true,
				connector = "Pylon5",
				arg = 312,
				arg_value = 1,
			},
			{
				{
					CLSID = "I16_RS_82",
					arg_value = 0.0,
				},
			}
		),
		pylon(
			8, -- pylon index 
			0, -- pylon default weapon start (0 - rail, 1 - catapult, > 1 - from hatch)
			0, 0, 0, -- coordinates in aircraft space, can be 0, 0, 0 if connector is used
			{
				use_full_connector_position = true,
				connector = "Pylon6",
				arg = 313,
				arg_value = 1,
			},
			{
				{
					CLSID = "I16_RS_82",
					arg_value = 0.0,
				},
				--[[{
					CLSID = "{HVAR_SMOKE_GENERATOR}",
                    arg_value = 0.0,
                },]]
			}
		),
    },

    CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_BAD, LOOK_GOOD, LOOK_GOOD),
    Sensors = {
		OPTIC = "Merkury LLTV", -- For night goggles imitation
        -- RWR = "Abstract RWR"
    },

	-- Countermeasures
	SingleChargeTotal	 	= 0,
	CMDS_Incrementation 	= 0,
	ChaffDefault 			= 0, 
	ChaffChargeSize 		= 0,
	FlareDefault 			= 0,
	FlareChargeSize 		= 0,
	CMDS_Edit 				= false,

	HumanRadio = {
		frequency = 124.0,
		editable = true,
		minFrequency = 100.000,
		maxFrequency = 156.000,
		modulation = MODULATION_AM
	},

    panelRadio = {
        [1] = {  
            name = _("SCR522"),
            range = {min = 100, max = 156},
            channels = {
                [1] = { name = _("ButtonA"), default = 105, modulation = _("AM"), connect = true},
                [2] = { name = _("ButtonB"), default = 124, modulation = _("AM")},
                [3] = { name = _("ButtonC"), default = 131, modulation = _("AM")},
                [4] = { name = _("ButtonD"), default = 139, modulation = _("AM")},
            }
        },
    },
	
	Tasks = {
		aircraft_task(CAP),				-- 11, Combat Air Patrol
        aircraft_task(CAS),				-- 31, Close air support
        aircraft_task(Escort),			-- 18,
        aircraft_task(FighterSweep),	-- 19,
        aircraft_task(GroundAttack),	-- 32,
        aircraft_task(Intercept),		-- 10,
        aircraft_task(Reconnaissance),	-- 17,
    },	
	DefaultTask = aircraft_task(CAP),
	
	SFM_Data = {
		aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		{
			Cy0	=	0.21,
			Mzalfa	=	4.355,  -- coefficients for pitch agility
			Mzalfadt	=	0.8, -- coefficients for pitch agility
			kjx = 2.25,
			kjz = 0.00125,
			Czbe = -0.016,
			cx_gear = 0.0277,
			cx_flap = 0.095,
			cy_flap = 0.4,
			cx_brk = 0.06,
			table_data = {
			--			M		Cx0			Cya			Bpol		B4			Omxmax		Aldop		Cymax	
					{	0.0	,	0.032	,	0.072	,	0.0678	,	0.01	,	0.1		,	19.01	,	1.32	},
					{	0.05,	0.032	,	0.072	,	0.0678	,	0.01	,	0.284	,	19.01	,	1.35	},
					{	0.1	,	0.032	,	0.072	,	0.0678	,	0.01	,	0.644	,	19.01	,	1.38	},
					{	0.15,	0.032	,	0.072	,	0.0678	,	0.01	,	1.072	,	19.01	,	1.43	},
					{	0.2	,	0.032	,	0.072	,	0.0678	,	0.01	,	1.857	,	19.01	,	1.41	},
					{	0.25,	0.032	,	0.072	,	0.0678	,	0.01	,	1.805	,	19.01	,	1.38	},
					{	0.3	,	0.032	,	0.072	,	0.0678	,	0.01	,	1.36	,	19.01	,	1.31	},
					{	0.35,	0.032	,	0.072	,	0.0678	,	0.01	,	1.127	,	19.01	,	1.20	},
					{	0.4	,	0.032	,	0.072	,	0.0678	,	0.01	,	0.967	,	18.01	,	1.12	},
					{	0.45,	0.032	,	0.072	,	0.0678	,	0.01	,	0.853	,	17.01	,	1.01	},
					{	0.5	,	0.032	,	0.072	,	0.0678	,	0.01	,	0.757	,	16.01	,	0.89	},
					{	0.55,	0.032	,	0.072	,	0.0678	,	0.01	,	0.681	,	15.01	,	0.75	},
					{	0.6	,	0.032	,	0.072	,	0.0678	,	0.01	,	0.611	,	15.01	,	0.59	},
					{	0.65,	0.0365	,	0.072	,	0.068	,	0.01	,	0.541	,	15.01	,	0.45	},
					{	0.7	,	0.0438	,	0.076	,	0.075	,	0.01	,	0.489	,	15.01	,	0.34	},
					{	0.8	,	0.0567	,	0.072	,	0.084	,	0.01	,	0.419	,	15.01	,	0.25	},
					{	0.9	,	0.0723	,	0.07	,	0.09	,	0.01	,	0.401	,	15.01	,	0.22	},
					
			},
		}, -- end of aerodynamics
		engine = 
		{
			type    = "Radial",
			Nominal_RPM = 2200.0,
			Nmg		=	20.5,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	1,
			ForsRUD	=	1,
			typeng	=	2,--PISTON ENGINE
			hMaxEng	=	12.5,
			dcx_eng	=	0.0015,
			cemax	=	0.37,
			cefor	=	0.37,
			dpdh_m	=	1800,
			dpdh_f	=	1800,
			k_adiab_1			= 0.023,
			k_adiab_2			= 0.0474327,
			MAX_Manifold_P_1	= 101325,		
			MAX_Manifold_P_2	= 120217,		
			MAX_Manifold_P_3	= 140535,		
			k_after_cool		= 0.01,
			Displ				= 29.8,
			k_Eps				= 6.4,
			Stroke				= 0.1745,
			V_pist_0			= 12,
			Nu_0				= 1.2,
			Nu_1				= 0.87,
			Nu_2				= 0.001,
			N_indic_0			= 1023040*1390/1450,
			N_fr_0				= 0.092,
			N_fr_1				= 0.4,
			Init_Mom			= 220,
			D_prop				= 2.8,
			MOI_prop			= 9.5,
			k_gearbox			= 1.0,
			P_oil				= 495438,
			k_boost				= 3,
			k_cfug				= 0.003,
			k_oil				= 0.00004,
			k_piston			= 3000,
			k_reg				= 0.003,
			k_vel				= 0.017,
			prop_pitch_min		= 17.0,	-- prop pitch min, degrees 
			prop_pitch_max		= 47.0,	-- prop pitch max, degrees 
			prop_pitch_feather	= 0.0,	-- prop pitch feather position, degrees if feather < prop_pitch_max no feathering available
			prop_blades_count   = 2,
			prop_locations      = {                {1.398, 0.000, 0.000},
            },
			table_data =  --NOT USED! (for jet)
			{
			--   M			Pmax
				{0.0,		10000.0},
				{2.0,		10000.0},

			}
		}, -- end of engine
	}, 


	Failures = {
		{ id = 'ENG0_GOVERNOR_FAILURE',						label = _('Prop governor Fault.'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ENG0_MAGNETO0',								label = _('Magneto 1 Fault.'),								enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ENG0_MAGNETO1',								label = _('Magneto 2 Fault.'),								enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ENG0_JAMMED',								label = _('Engine Jam'),									enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = 'ENG0_BOOST_REGULATOR_MALFUNCTION',			label = _('Boost regulator failure'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEC_RETICLE_BULB_FAILURE',					label = _('Reticle bulb broken'),                    		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- custom
		{ id = 'ENG0_MIXTURE_AUTOMATIC_CONTROL_FAILURE',	label = _('Mixture automatic control failure'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'OXYGEN_AUTOMATIC_CONTROL_MALFUNCTION',		label = _('Breathe oxygen automatic control malfunction'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'OXYGEN_AUTOMATIC_CONTROL_FAILURE',			label = _('Breathe oxygen automatic control failure'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'GEAR_DOWN_AUTOMATIC_BRAKE_FAILURE',			label = _('Gear down automatic brake failure'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	},

	Damage = {
	[0]  = {critical_damage = 4, args = {146}},  -- кок
	[1]  = {critical_damage = 4, args = {296}},  -- носова€ часть, лева€ сторона
	[2]  = {critical_damage = 4, args = {297}},  -- носова€ часть, права€ сторона
	[3]  = {critical_damage = 3, args = {65}},	 -- козырек 
	[4]  = {critical_damage = 4, args = {298}},  -- кокпит, левый борт
	[5]  = {critical_damage = 4, args = {301}},  -- кокпит, правый борт
	[8]  = {critical_damage = 2, args = {264}},  -- костыль
	[9]  = {critical_damage = 50, args = {81}},  -- вспомогательный элемент дл€ разрушени€ хвостовой части
	[12] = {critical_damage = 6, args = {162}},  -- двигатель
	[15] = {critical_damage = 2, args = {267}},  -- ниша шасси лева€
	[16] = {critical_damage = 2, args = {266}},  -- ниша шасси права€ 
	[23] = {critical_damage = 5, args = {223}, deps_cells = {25}}, -- крыло левое, внешн€€ часть
	[24] = {critical_damage = 5, args = {213}, deps_cells = {26}}, -- крыло правое, внешн€€ часть
	[25] = {critical_damage = 2, args = {226}},  -- элерон левый 
	[26] = {critical_damage = 2, args = {216}},  -- элерон правый 
	[29] = {critical_damage = 5, args = {224}, deps_cells = {23, 25}},  -- крыло левое, центральна€ часть
	[30] = {critical_damage = 5, args = {214}, deps_cells = {24, 26}},  -- крыло правое, центральна€ часть
	[35] = {critical_damage = 6, args = {225}, deps_cells = {15, 29, 23, 25, 84}},  -- крыло левое, внутренн€€ часть
	[36] = {critical_damage = 6, args = {215}, deps_cells = {16, 30, 24, 26, 85}},  -- крыло правое, внутренн€€ часть
	[37] = {critical_damage = 2, args = {55}},  -- закрылок левый
	[38] = {critical_damage = 2, args = {56}},  -- закрылок правый
	[42] = {critical_damage = 5, args = {242}, deps_cells = {54}},  -- киль  
	[47] = {critical_damage = 5, args = {236}, deps_cells = {51}},  -- стабилизатор левый
	[48] = {critical_damage = 5, args = {234}, deps_cells = {52}},  -- стабилизатор правый
	[51] = {critical_damage = 2, args = {240}},  -- руль высоты левый
	[52] = {critical_damage = 2, args = {238}},  -- руль высоты правый 
	[54] = {critical_damage = 2, args = {247}},  -- руль направлени€
	[55] = {critical_damage = 3,  args = {159}},  -- гаргрот
	[56] = {critical_damage = 50, args = {158}, deps_cells = {42, 47, 48, 51, 52, 54, 8, 9}},  -- фюзел€ж, хвостова€ часть, лева€ сторона
	[57] = {critical_damage = 50, args = {157}, deps_cells = {42, 47, 48, 51, 52, 54, 8, 9}},  -- фюзел€ж, хвостова€ часть, права€ сторона
	[58] = {critical_damage = 50, args = {156}, deps_cells = {42, 47, 48, 51, 52, 54, 8, 9}},  -- фюзел€ж, хвостова€ часть, низ
	[64] = {critical_damage = 50, args = {429}},  -- лопасть 1 (in)  объемы - дыр€вить
	[67] = {critical_damage = 50, args = {430}},  -- лопасть 2 (in)
	[66] = {critical_damage = 50, args = {380}},  -- лопасть 1 (out) палки - гнуть
	[69] = {critical_damage = 50, args = {381}},  -- лопасть 2 (out)
	[82] = {critical_damage = 6, args = {152}},  -- фюзел€ж, низ 
	--[83] = {critical_damage = 3, args = {134}},  -- колесо костыл€
	[84] = {critical_damage = 3, args = {136}},  -- колесо левое                                
	[85] = {critical_damage = 3, args = {135}},  -- колесо правое
	},
	
	DamageParts = 
	{  
	    [1] = "I-16_wing_r", -- wing R
        [2] = "I-16_wing_l", -- wing L
        --[3] = "I-16_nose", -- nose
        --[4] = "I-16_tail", -- tail

	},
	
	-- mech speed with mech position value , in pairs - first is mech value , second - absolute speed of mech value change in this point
	mech_timing = {{}, 		 -- CANOPY_OPEN_TIMES  -- keep empty
				   {}, 		 -- CANOPY_CLOSE_TIMES -- keep empty
				   {0,1/37}, -- LANDING_GEAR_RETRACTION_TIMES -- retract 37 seconds 
				   {0,1/34}, -- LANDING_GEAR_EXTENSION_TIMES  -- extent  34 seconds , gravity helps :)
					},
    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Board"}, Sequence = {{C = {{"VelType", 0}, {"Arg", 250, "to", 1.0, "in", 0.35}, {"VelType", 1}, {"Arg", 252, "to", 1.0, "in", 0.35}}}}},
            {Transition = {"Board", "Close"}, Sequence = {{C = {{"PosType", 9}, {"Sleep", "for", 10.0}}}, {C = {{"VelType", 1}, {"Arg", 250, "to", 0.0, "in", 1.0}}}, {"Sleep", "for", 0.5}, {C = {{"PosType", 10}, {"Sleep", "for", 3.0}}}, {C = {{"VelType", 1}, {"Arg", 252, "to", 0.0, "in", 1.0}}}}},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"Sleep", "for", 1.0}}}, {C = {{"Arg", 252, "to", 1.0, "in", 0.35}}}}},
        },
    },

    AddPropAircraft = 
	{
		{ id = "landingTorch" , control = 'checkbox', label = _('Landing Torch'), defValue = false, weight = 20, arg = 457, playerOnly = true}, 
    },

	lights_data = {
		typename =	"collection",
		lights 	 = 
		{
			-- WOLALIGHT_NAVLIGHTS -- навигационные
			[WOLALIGHT_NAVLIGHTS] =
			{
				lights =
				{
					{typename = "argumentlight",   argument  = 190}, -- Left Position Light (red)
					{typename = "argumentlight",   argument  = 191}, -- Right Position Light (green)
					{typename = "argumentlight",   argument  = 192 } -- Tail Position Light (white)
				}, -- end of lights
				typename	=	"collection",
			}, -- end of [3]
            [WOLALIGHT_CABIN_BOARDING] = {
                typename = "collection",
                lights = {
                    {
                        typename = "argumentlight", argument = 69,
                    },
                },
            },
		}, -- end of lights
	},-- end of lights data

--	ViewSettings = ViewSettings,
--	SnapViews    = SnapViews,
}

add_aircraft(I_16)

---------------------------------------------------------
plugin_done()