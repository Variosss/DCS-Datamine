--[[
	'scheme' table here is config for block scheme made in editor
	to edit block scheme:

		create a text config file, with .conf extention. Add there just one line:

		WeaponBlocksNL.dll

		Put it anywhere you can easily reach,
		create a bat file with the following syntax:

		start /D%DCS_path%\LockOnExe %DCS_path%\LockOnExe\bin\editor.exe %Your_path_to_conf_file%\blockeditor.conf %1
]]

--[[
	rbk_betab_m scheme parameters
	scheme   =
	{
		--
		bomb_nose =
		{
			op_time					= 200.0,						-- delete object after N sec.
			count					= 1,							-- total objects number
			effect_count			= 1,							-- at least N objects are visible
			wind_sigma				= 5.0,							-- wind sigma effect
			impulse_sigma			= 1.0,							-- impulse random coeff
			moment_sigma			= 1.0,							-- moment random coeff
			mass					= 10.0,							-- FM	mass
			caliber					= 0.325,							-- object diameter, m
			L						= 1.5,								-- object length
			I						= 1.0,								-- lateral moment of inertia
			Ma						= 0.5,								-- dependence moment coefficient of  by  AoA
			Mw						= 1.0,								-- dependence moment coefficient by angular speed
			cx_coeff				= {0, 0.4, 0.4, 0.3, 1.4},		-- Cx (drag coeff)	/FM
			model_name				= "RBK_500U_nose",				-- object 3d model name
			connectors_model_name	= "",			--optional		-- get connectors local position from this model
			init_pos				= {{0,0,0}},	--optional		-- manual local position vector
			init_impulse			= {{700,0,0}},	--optional		-- manual init impulse vector
			omega_impulse_coeff		= 0,			--optional		-- dependence on dispenser spin rate coeff.
			explosion_impulse_coeff	= 0,			--optional		-- separation charge impulse coeff
			explosion_center		= {{}},			--optional		-- separation charge local position
																	-- If the number of elements is less than the number of spawns,
																	-- the table will be cycled from the beginning
			release_rnd_coeff		= 0,			--optional		-- omega_impulse/explosion_impulse additional rnd
			chute_open_time			= 0.0,			--optional		-- Chute: live time when chute is opened
			chute_cut_time			= 0.0,			--optional		-- 			..is cut
			chute_diam				= 0.0,			--optional		--			chute diam
			chute_Cx				= 0.0,			--optional		--			chute Cx
			chute_rnd_coeff			= 0.0,			--optional		-- 			open_time rnd coeff
		},

		dispenser =
		{
			-- 'dispenser' block can send incremental counter ('increment') to blocks 'empty_dispenser' and 'acc_bomblets' to spawn new objects described there
			-- sending triggers: spawn_time, spawn_height

			op_time					= 200.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 20,
			impulse_sigma			= 1.0,
			moment_sigma			= 1.0,
			mass					= 235.6,
			caliber					= 0.325,
			L						= 2.1,
			I						= 100,
			Ma						= 0.23,
			Mw						= 2.33,
			cx_coeff				= {0, 0.9, 0.9, 1.0, 2.0},
			model_name				= "RBK_500U_tail_BETAB_M",
			--connectors_model_name		= "",			--optional
			--init_pos					= {{0,0,0}},	--optional
			--init_impulse				= {{0,0,0}},	--optional
			--omega_impulse_coeff		= 0,			--optional
			--explosion_impulse_coeff	= 0,			--optional
			--explosion_center			= {{}},			--optional
			--release_rnd_coeff			= 0,			--optional
			chute_open_time			= 0.1,				--optional
			chute_cut_time			= 0.7,				--optional
			chute_diam				= 3.0,				--optional
			chute_Cx				= 1.0,				--optional
			chute_rnd_coeff			= 0.0,				--optional
			spawn_time				= {0.02, 1, 1.02},						--		 	-- spawn time triggers. Table index corresponds to 'increment' value
			spawn_height			= {},									-- 			-- height triggers
			spawn_weight_loss		= {10.0, 90.0, 90.0},					--optional	-- dispenser mass loss
																						-- If the number of elements is less than the number of spawns,
																						-- the table will be cycled from the beginning
			--spawn_args_change		= {{1,6,1}, {2,6,0}, {3,6,1},{4,6,0}},	--optional	--	{{'increment', 'arg_num', 'value_to_set'}, ...} --
																						--
			op_spawns				= 3,												-- delete dispenser object after N spawns (param sendings)
			use_effects				= 1,												-- use explosion effects
		},

		empty_dispenser =
		{
			op_time					= 200.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 5,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 45.0,
			caliber					= 0.325,
			L						= 2,
			I						= 2,
			Ma						= 0.03,
			Mw						= 0.3,
			cx_coeff				= {1, 1, 1, 1, 2},
			model_name				= "RBK_500U_tail_BETAB_M",
			connectors_model_name	= "",					--optional
			init_pos				= {},					--optional
			init_impulse			= {},					--optional
			--omega_impulse_coeff	= 0,					--optional
			--explosion_impulse_coeff	= 0,				--optional
			--explosion_center		= {{0,0,0}},			--optional
			--release_rnd_coeff		= 0,					--optional
			--chute_open_time		= 0.1,					--optional
			--chute_cut_time		= 0.7,					--optional
			--chute_diam			= 3.0,					--optional
			--chute_Cx				= 1.0,					--optional
			--chute_rnd_coeff		= 0.0,					--optional
			spawn_options			= {{1,1,1}}				--optional		-- {{a,b,c},..{..}}

												--		FM events counter is incremented by 1 at each object spawn.
												--		When counter equals to 'a' the object is created, when counter equals to 'b' the object is released from the parent object.
												--		For example:
												--		- at counter is equal to 'a' bomblets will appear at the dispenser,
												--		- at counter is equal to 'b' boblets will be released from the dispenser,
												--		- c is the number of objects to create.
		},

		-- accelerated bomblets
		acc_bomblets =
		{
			op_time						= 400.0,
			count						= 10,
			effect_count				= 10,
			wind_sigma					= 0,
			impulse_sigma				= 0,
			moment_sigma				= 0,
			mass						= 25,
			caliber						= 0.1,
			L							= 0.9,
			I							= 0.45,
			Ma							= 2,
			Mw							= 5,
			cx_coeff					= {0, 0.4, 0.7, 0.6, 1.4},
			model_name					= "RBK_500U_bomb_BETAB_M",
			connectors_model_name		= "RBK_500U_tail_BETAB_M",				--optional
			--init_pos					= {},									--optional
			--init_impulse				= {},									--optional
			--omega_impulse_coeff		= 0,									--optional
			explosion_impulse_coeff		= 200,									--optional
			explosion_center			= {{0.21829, 0, 0}, {-0.18596, 0, 0}},	--optional
			release_rnd_coeff			= 0.4,									--optional
			chute_open_time				= 3,									--optional
			chute_cut_time				= 8,									--optional
			chute_diam					= 2,									--optional
			chute_Cx					= 1.0,									--optional
			chute_rnd_coeff				= 0.3,									--optional
			spawn_options				= {{0,1,5},{0,2,5}},					--optional
			explosion_style				= 1,									--optional	-- 0- cbu-87 like bomblet hit effect, 1- usual explosion
			engine_impulse				= 100,									-- Engine params:
			engine_fuel_mass			= 0.3,
			engine_start_time			= 8,
			engine_work_time			= 1,
			engine_rnd_coeff			= 0.8,									--optional	-- 		+-start_time rnd coeff
			engine_nozzle_position		= {{-0.06,0,0}},
			engine_nozzle_orientationXYZ= {{0,0,0}},
			engine_tail_color			= {0.5,0.5,0.5},						--optional, default value {0.4,0.4,0.4}
			engine_tail_scale			= 0.1,
		},
		--
		warhead		= predefined_warhead("AO_1SCH"),
	},
]]

--[[ disp_bomblets_empty_disp parameters
	scheme   =
	{
		-- 'dispenser' block can send incremental counter to blocks 'empty_dispenser' and 'bomblets' to spawn new objects described there
		dispenser =
		{
			op_time					= 200.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 20,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 235.6,
			caliber					= 0.325,
			L						= 2.1,
			I						= 100,
			Ma						= 0.23,
			Mw						= 2.33,
			cx_coeff				= {0, 0.9, 0.9, 1.0, 2.0},
			model_name				= "RBK_500U_tail_OAB",
			--connectors_model_name	= ""						--optional
			--init_pos				= {},						--optional
			--init_impulse			= {},						--optional
			--omega_impulse_coeff	= 0,						--optional
			--explosion_impulse_coeff	= 0,					--optional
			--explosion_center		= {{0, 0, 0}},				--optional
			--release_rnd_coeff		= 0.0,						--optional
			chute_open_time			= 0.1,						--optional
			chute_cut_time			= 0.7,						--optional
			chute_diam				= 2.0,						--optional
			chute_Cx				= 1.0,						--optional
			chute_rnd_coeff			= 0.0,						--optional
			spawn_time				= {0.02, 2, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9},
			spawn_height			= {},
			spawn_weight_loss		= {0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20},
			--spawn_args_change		= {{1,6,1}, {2,6,0}, {3,6,1},{4,6,0}},		//	--optional		{a,b,c} a-spawn_ind, b-args_ind, c- new val
			op_spawns				= 11,
			use_effects				= 1,
		},

		empty_dispenser =
		{
			op_time					= 200.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 5,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 45.0,
			caliber					= 0.325,
			L						= 2,
			I						= 2,
			Ma						= 0.03,
			Mw						= 0.3,
			cx_coeff				= {1, 1, 1, 1, 2},
			model_name				= "RBK_500U_tail_OAB",
			connectors_model_name	= "",					--optional
			init_pos				= {},					--optional
			init_impulse			= {},					--optional
			--omega_impulse_coeff	= 0,					--optional
			--explosion_impulse_coeff = 0,					--optional
			--explosion_center		= {{0,0,0}},			--optional
			--release_rnd_coeff		= 0,					--optional
			--chute_open_time		= 0,					--optional
			--chute_cut_time		= 0,					--optional
			--chute_diam			= 0,					--optional
			--chute_Cx				= 0,					--optional
			--chute_rnd_coeff		= 0,					--optional
			spawn_options			= {{10,10,1}},			--optional
		},

		bomblets =
		{
			op_time					= 400.0,
			count					= 130,
			effect_count			= 130,
			wind_sigma				= 20,
			impulse_sigma			= 1,
			moment_sigma			= 2,
			mass					= 1.2,		--FM
			caliber					= 0.1,
			L						= 0.9,
			I						= 0.45,
			Ma						= 2,
			Mw						= 5,
			cx_coeff				= {0, 0.4, 0.7, 0.6, 1.4},
			model_name				= "RBK_500U_bomb_OAB",
			connectors_model_name	= "RBK_500U_tail_OAB",	--optional
			--init_pos				= {},					--optional
			--init_impulse			= {},					--optional
			--omega_impulse_coeff	= 0,					--optional
			explosion_impulse_coeff	= 7,					--optional
			explosion_center		= {{-0.57, 0, 0}, {-0.44, 0, 0}, {-0.31, 0, 0}, {-0.18, 0, 0}, {-0.05, 0, 0}, {0.08, 0, 0}, {0.21, 0, 0}, {0.34, 0, 0}, {0.47, 0, 0}, {0.6, 0, 0}}, --optional
			release_rnd_coeff		= 0,					--optional
			chute_open_time			= 0,					--optional
			chute_cut_time			= 0,					--optional
			chute_diam				= 0,					--optional
			chute_Cx				= 0,					--optional
			chute_rnd_coeff			= 0,					--optional
			spawn_options			= {{0, 10, 13}, {0, 9, 13}, {0, 8, 13}, {0, 7, 13}, {0, 6, 13}, {0, 5, 13}, {0, 4, 13}, {0, 3, 13}, {0, 2, 13}, {0, 1, 13}},	--optional
			explosion_style			= 0,					--optional
		},
		--
		warhead		= predefined_warhead("AO_1SCH"),
]]

CLUSTER_BLG =
{
	category = CAT_CLUSTER_DESC,
	scheme   =
	{
		--
		dispenser =
		{
			op_time					= 300.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 20,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 305.0,
			caliber					= 0.36,
			L						= 3.33,
			I						= 281.84,
			Ma						= 0.23,
			Mw						= 2.33,
			cx_coeff				= {0, 0.9, 0.9, 1.0, 2.0},
			model_name				= "M2000C_BLG66",
			chute_open_time			= 0.1,
			chute_cut_time			= 0.7,
			chute_diam				= 2.0,
			chute_Cx				= 1.0,
			chute_rnd_coeff			= 0.0,
			spawn_time				= {0.1, 0.18, 0.26, 0.34, 0.42, 0.5, 0.58, 0.64, 0.72, 0.8},
			spawn_height			= {},
			spawn_weight_loss		= {19.5, 19.5, 20.8, 19.5, 19.5, 19.5, 19.5, 19.5, 19.5, 19.5},
			--spawn_args_change		= {{1,6,1}, {2,6,0}, {3,6,1},{4,6,0}},		-- {a,b,c} a-spawn_ind, b-args_ind, c- new val
			op_spawns				= 10,
			use_effects				= 1,
		},

		empty_dispenser =
		{
			op_time					= 300.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 5,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 108.7,
			caliber					= 0.36,
			L						= 3.33,
			I						= 101.65,
			Ma						= 0.03,
			Mw						= 0.3,
			cx_coeff				= {1, 1, 1, 1, 2},
			model_name				= "M2000C_BLG66",
			connectors_model_name	= "",
			spawn_options			= {{9, 9, 1}},
		},

		bomblets =
		{
			op_time					= 400.0,
			count					= 151,
			effect_count			= 40,
			wind_sigma				= 20,
			impulse_sigma			= 1,
			moment_sigma			= 2,
			mass					= 1.3,
			caliber					= 0.066,
			L						= 0.151,
			I						= 0.09,
			Ma						= 0.03,
			Mw						= 0.3,
			cx_coeff				= {0, 0.4, 0.7, 0.6, 1.4},
			model_name				= "RBK_250_PTAB_25M_bomb",
			-- connectors_model_name	= "RBK_500U_tail_OAB", -- no connector implemented on BLG-66 model atm
			explosion_impulse_coeff	= 4,
			explosion_center		= {
				{0.616, -0.170, 0}, {0.470, -0.170, 0}, {0.327, -0.170, 0}, {0.185, -0.170, 0}, {-0.006, -0.170, 0},
				{-0.152, -0.170, 0}, {-0.430, -0.170, 0}, {-0.575, -0.170, 0}, {-0.718, -0.170, 0}, {-0.860, -0.170, 0}
			},
			release_rnd_coeff		= 0,
			chute_open_time			= 0,
			chute_cut_time			= 0,
			chute_diam				= 0,
			chute_Cx				= 0,
			chute_rnd_coeff			= 0,
			spawn_options			= {
				{0, 0, 15}, {1, 1, 15}, {2, 2, 16}, {3, 3, 15}, {4, 4, 15},
				{5, 5, 15}, {6, 6, 15}, {7, 7, 15}, {8, 8, 15}, {9, 9, 15}
			},
			explosion_style			= 0,
		},
		--
		warhead		= predefined_warhead("PTAB-2-5"),
	},

	cluster_scheme	= "disp_bomblets_empty_disp",
	name			= _("BLG-66"),
	type_name		= _("cluster"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
}
declare_weapon(CLUSTER_BLG)

BLG_66 =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
	VyHold			= -100.0,
	Ag				= -1.23,
	type			= 5,
	mass			= 305.0,
	hMin			= 60.96,
	hMax			= 5000.0,
	Cx    			= 0.000413,
	explMass		= 94.0,
	Reflection		= 0.03,

	name			= "BLG66",
	model			= "M2000C_BLG66",
	user_name		= "BLG-66 Belouga AC",
	display_name_short =_("BLG-66"),

	scheme			= "bomb-cassette",
	class_name		= "wAmmunition",

	fm =
	{
		mass            = 305,
		caliber         = 0.36,
		cx_coeff        = {1.0, 0.39, 0.6, 0.168, 1.31},
		L               = 3.33,
		I               = 281.84,
		Ma				= 0.23,
		Mw				= 2.33,
		wind_time       = 1000.0,
		wind_sigma      = 15.0,
	},

	control =
	{
		open_delay = 1.3,
	},

	launcher =
	{
		blocks  = {"cluster"},
		cluster = CLUSTER_BLG.descriptor,
	},

	targeting_data =
	{
		char_time = 20.43,
		bomblet_char_time = 27.5,
	},

	shape_table_data =
	{{
		name	 = "BLG66",
		file     = "M2000C_BLG66",
		life     = 1,
		fire     = {0, 1},
		username = "BLG-66 Belouga AC",
		index    = WSTYPE_PLACEHOLDER,
	},}

}
declare_weapon(BLG_66)

declare_loadout({
	category		=	CAT_BOMBS,
	CLSID			= 	"{BLG66_AC}",
	Picture			=	"Mk20.png",
	displayName		=	_("BLG-66 Belouga AC - 305kg CBU, 151 x HEAT Bomblets"),
	wsTypeOfWeapon	=	BLG_66.wsTypeOfWeapon,
	attribute		=	BLG_66.wsTypeOfWeapon,
	Count			=	1,
	Weight			=	BLG_66.fm.mass,
	Elements		=	{
		[1]	= {
			ShapeName	=	"M2000C_BLG66",
		},
	}, -- end of Elements
})

-----------------------------------------------------------------------------------------

CLUSTER_BETAB_M =
{
	category = CAT_CLUSTER_DESC,
	scheme   =
	{
		--
		bomb_nose =
		{
			op_time					= 200.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 5,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 10.0,
			caliber					= 0.325,
			L						= 1.5,
			I						= 1,
			Ma						= 0.5,
			Mw						= 1,
			cx_coeff				= {0, 0.4, 0.4, 0.3, 1.4},
			model_name				= "RBK_500U_nose",
			connectors_model_name	= "",
			init_pos				= {{0,0,0}},
			init_impulse			= {{700,0,0}},
			omega_impulse_coeff		= 0,
			explosion_impulse_coeff	= 0,
			multispawn				= 0,
		},

		dispenser =
		{
			op_time					= 200.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 20,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 235.6,
			caliber					= 0.325,
			L						= 2.1,
			I						= 100,
			Ma						= 0.23,
			Mw						= 2.33,
			cx_coeff				= {0, 0.9, 0.9, 1.0, 2.0},
			model_name				= "RBK_500U_tail_BETAB_M",
			chute_open_time			= 0.1,
			chute_cut_time			= 0.7,
			chute_diam				= 3.0,
			chute_Cx				= 1.0,
			chute_rnd_coeff			= 0.0,
			spawn_time				= {0.02, 1, 1.02},
			spawn_height			= {},
			spawn_weight_loss		= {10, 90, 90},
			spawn_args_change		= {{1,1,0}},
			set_start_args			= {1},
			op_spawns				= 3,
			use_effects				= 1,
		},

		empty_dispenser =
		{
			op_time					= 200.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 5,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 45.0,
			caliber					= 0.325,
			L						= 2,
			I						= 2,
			Ma						= 0.03,
			Mw						= 0.3,
			cx_coeff				= {1, 1, 1, 1, 2},
			model_name				= "RBK_500U_tail_BETAB_M",
			connectors_model_name	= "",
			init_pos				= {},
			init_impulse			= {},
			explosion_center		= {{0,0,0}},
			spawn_options			= {{1,1,1}},
			multispawn				= 1,
		},

		acc_bomblets =
		{
			op_time						= 400.0,
			count						= 10,
			effect_count				= 10,
			wind_sigma					= 0,
			impulse_sigma				= 0,
			moment_sigma				= 0,
			mass						= 25,
			caliber						= 0.1,
			L							= 0.9,
			I							= 0.45,
			Ma							= 2,
			Mw							= 5,
			cx_coeff					= {0, 0.4, 0.7, 0.6, 1.4},
			model_name					= "RBK_500U_bomb_BETAB_M",
			connectors_model_name		= "RBK_500U_tail_BETAB_M",
			explosion_impulse_coeff		= 200,
			explosion_center			= {{0.57461, 0, 0}, {-0.55185, 0, 0}},
			release_rnd_coeff			= 0.4,
			chute_open_time				= 3,
			chute_cut_time				= 8,
			chute_diam					= 2,
			chute_Cx					= 1.0,
			chute_rnd_coeff				= 0.3,
			spawn_options				= {{0,1,5},{0,2,5}},
			explosion_style				= 1,
			engine_impulse				= 100,
			engine_fuel_mass			= 0.3,
			engine_start_time			= 8,
			engine_work_time			= 1,
			engine_rnd_coeff			= 0.8,
			engine_nozzle_position		= {{-0.06,0,0}},
			engine_nozzle_orientationXYZ= {{0,0,0}},
			engine_tail_color			= {0.5,0.5,0.5},
			engine_tail_scale			= 0.1,
		},
		--
		warhead		= predefined_warhead("BETAB_M"),
	},

	cluster_scheme	= "rbk_betab_m",
	name			= _("BETAB-M"),
	type_name		= _("cluster"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
}
declare_weapon(CLUSTER_BETAB_M)


RBK_500U_BETAB_M =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
	VyHold			= -100.0,
	Ag				= -1.23,
	type			= 5,
	mass			= 427.0,
	hMin			= 200.0,
	hMax			= 25000.0,
	Cx    			= 0.001438,
	explMass		= 172.0,
	Reflection		= 0.03,

	name			= "RBK_500U_BETAB_M",
	model			= "RBK_500U",
	user_name		= _("RBK-500U - 10 x BETAB-M, 500kg Bunker Buster CBU HE/Frag"),
	scheme			= "bomb-cassette",
	class_name		= "wAmmunition",
	display_name_short = _("RBK-500U"),

	fm =
	{
		mass            = 427.000000,
		caliber         = 0.400000,
		cx_coeff        = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
		L               = 2.430000,
		I               = 107.827833,
		Ma              = 0.227651,
		Mw              = 2.326556,
		wind_time       = 1000.000000,
		wind_sigma      = 100.000000,
	},

	control =
	{
		open_delay = 4.0,
	},

	launcher =
	{
		blocks  = {"cluster"},
		cluster = CLUSTER_BETAB_M.descriptor,
	},

	targeting_data =
	{
		v0 = 200.0,
		data =
		{
			{1.000000, 20.200000, 0.000000},
			{10.000000, 20.443164, 0.000001},
			{20.000000, 20.467441, -0.000170},
			{30.000000, 20.475234, -0.000199},
			{40.000000, 20.476446, -0.000209},
			{50.000000, 20.479972, -0.000252},
			{60.000000, 20.480324, -0.000249},
			{70.000000, 20.482148, -0.000257},
			{80.000000, 20.481281, -0.000241},
			{90.000000, 20.482720, -0.000259},
			{100.000000, 20.483667, -0.000247},
			{200.000000, 20.529902, -0.000179},
			{300.000000, 20.585581, -0.000106},
			{400.000000, 20.633787, -0.000045},
			{500.000000, 20.674180, -0.000000},
			{600.000000, 20.708441, 0.000036},
			{700.000000, 20.737702, 0.000065},
			{800.000000, 20.763255, 0.000087},
			{900.000000, 20.785809, 0.000106},
			{1000.000000, 20.805897, 0.000121},
			{1100.000000, 20.824022, 0.000133},
			{1200.000000, 20.840452, 0.000143},
			{1300.000000, 20.855518, 0.000151},
			{1400.000000, 20.869384, 0.000158},
			{1500.000000, 20.882217, 0.000163},
			{1600.000000, 20.894175, 0.000167},
			{1700.000000, 20.905367, 0.000170},
			{1800.000000, 20.915877, 0.000172},
			{1900.000000, 20.925774, 0.000174},
			{2000.000000, 20.935142, 0.000174},
			{3000.000000, 21.008637, 0.000156},
			{4000.000000, 21.060971, 0.000112},
			{5000.000000, 21.102148, 0.000058},
			{6000.000000, 21.136144, -0.000000},
			{7000.000000, 21.164866, -0.000060},
			{8000.000000, 21.189321, -0.000120},
			{9000.000000, 21.210072, -0.000178},
			{10000.000000, 21.227430, -0.000236},
		}
	},

	shape_table_data =
	{{
		name	 = "RBK_500U_BETAB_M",
		file     = "RBK_500U",
		life     = 1,
		fire     = {0, 1},
		username = _("RBK-500U BETAB-M"),
		index    = WSTYPE_PLACEHOLDER,
	},}

}
declare_weapon(RBK_500U_BETAB_M)

-----------------------------------------------------------------------------------------

AO_1SCH_CLUSTER =
{
	category = CAT_CLUSTER_DESC,
	scheme =
	{
		bomb_nose =
		{
			mass					= 10,
			caliber					= 0.325,
			L						= 1.5,
			I						= 1,
			Ma						= 0.3,
			Mw						= 1,
			cx_coeff				= {1, 0.39, 0.6, 0.168, 1.31},
			model_name				= "RBK_250_nose",
			init_impulse			= {{300,0,0}},
		},
		dispenser =
		{
			mass					= 225,
			caliber					= 0.325,
			cx_coeff				= {1, 0.39, 0.6, 0.168, 1.31},
			L						= 2.3,
			I						= 100,
			wind_sigma				= 100,
			Ma						= 0.227651,
			Mw						= 2.326556,
			model_name				= "RBK_250_tail",
			set_start_args			= {},
			spawn_time				= {0, 0.5},
			spawn_weight_loss		= {0, 150},
			spawn_args_change		= {},
			op_spawns				= 2,
			use_effects				= 1,
		},
		empty_dispenser =
		{
			mass					= 15,
			caliber					= 0.325,
			L						= 2,
			I						= 2,
			Ma						= 0.3,
			Mw						= 1,
			cx_coeff				= {1,1,1,1,2},
			model_name				= "RBK_250_tail",
			init_impulse			= {{0,0,0}},
			spawn_options			= {{1,1,1}},
		},
		bomblets =
		{
			wind_sigma					= 15,
			impulse_sigma				= 3,
			moment_sigma				= 0.1,
			count						= 150,
			effect_count				= 60,
			mass						= 1.2,
			caliber						= 0.049,
			cx_coeff					= {1, 0.39, 0.38, 0.236, 1.31},
			L							= 0.158,
			I							= 0.05,
			Ma							= 2,
			Mw							= 9,
			model_name					= "RBK_250_bomb",
			connectors_model_name		= "RBK_250_tail",
			explosion_impulse_coeff		= 1,
			explosion_center			= {{0,0,0}},
			explosion_dont_use_x_axis	= 1,
			spawn_options				= {{0,1,150}},
		},
		warhead = predefined_warhead("AO_1SCH"),
	},
	cluster_scheme	= "rbk_simple",
	name    		= _("AO-1SCh"),
	type_name		= _("cluster"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
}

declare_weapon(AO_1SCH_CLUSTER)

RBK_250_275_AO_1SCH =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
	VyHold			= -100.0,
	Ag				= -1.23,
	type			= 5,
	mass			= 244.6,
	hMin			= 200.0,
	hMax			= 25000.0,
	Cx				= 0.001,
	explMass		= 94.0,
	Reflection		= 0.02,

	name			= "RBK_250_275_AO_1SCH",
	model			= "rbk-250",
	user_name		= _("RBK-250-275 - 150 x AO-1SCh, 250kg CBU HE/Frag"),
	scheme			= "bomb-cassette",
	class_name		= "wAmmunition",
	display_name_short = _("RBK-250"),

	fm =
	{
		mass            = 273.0,
		caliber         = 0.325,
		cx_coeff        = {1.0, 0.39, 0.6, 0.168, 1.31},
		L               = 2.3,
		I               = 107.827833,
		Ma              = 0.227651,
		Mw              = 2.326556,
		wind_time       = 1000.0,
		wind_sigma      = 100.0,
	},

	control =
	{
		open_delay = 3.5,
	},

	launcher =
	{
		blocks  = {"cluster"},
		cluster = AO_1SCH_CLUSTER.descriptor,
	},

	targeting_data =
	{
		v0 = 200.0,
		data =
		{
			{1.000000, 20.200000, 0.000000},
			{10.000000, 20.355862, 0.000077},
			{20.000000, 20.378514, -0.000090},
			{30.000000, 20.384561, -0.000115},
			{40.000000, 20.385621, -0.000124},
			{50.000000, 20.389593, -0.000166},
			{60.000000, 20.389580, -0.000161},
			{70.000000, 20.390587, -0.000157},
			{80.000000, 20.389651, -0.000151},
			{90.000000, 20.391540, -0.000169},
			{100.000000, 20.392405, -0.000155},
			{200.000000, 20.453696, -0.000083},
			{300.000000, 20.529240, -0.000012},
			{400.000000, 20.594815, 0.000041},
			{500.000000, 20.649695, 0.000076},
			{600.000000, 20.696233, 0.000101},
			{700.000000, 20.736040, 0.000120},
			{800.000000, 20.770731, 0.000134},
			{900.000000, 20.801297, 0.000143},
			{1000.000000, 20.828531, 0.000151},
			{1100.000000, 20.853044, 0.000156},
			{1200.000000, 20.875318, 0.000159},
			{1300.000000, 20.895624, 0.000162},
			{1400.000000, 20.914330, 0.000163},
			{1500.000000, 20.931645, 0.000163},
			{1600.000000, 20.947761, 0.000163},
			{1700.000000, 20.962794, 0.000161},
			{1800.000000, 20.976925, 0.000159},
			{1900.000000, 20.990205, 0.000156},
			{2000.000000, 21.002764, 0.000153},
			{3000.000000, 21.100815, 0.000106},
			{4000.000000, 21.170027, 0.000042},
			{5000.000000, 21.224200, -0.000028},
			{6000.000000, 21.268902, -0.000100},
			{7000.000000, 21.306828, -0.000173},
			{8000.000000, 21.339423, -0.000244},
			{9000.000000, 21.367518, -0.000314},
			{10000.000000, 21.391591, -0.000383},
		}
	},

	shape_table_data =
	{{
		name	 = "RBK_250_275_AO_1SCH",
		file     = "rbk-250",
		life     = 1,
		fire     = {0, 1},
		username = _("RBK-250-275 AO-1SCh"),
		index    = WSTYPE_PLACEHOLDER,
	},}

}
declare_weapon(RBK_250_275_AO_1SCH)

-----------------------------------------------------------------------------------------
OAB_2_5RT_CLUSTER =
{
	category = CAT_CLUSTER_DESC,
	scheme =
	{
		bomb_nose =
		{
			mass					= 20,
			caliber					= 0.4,
			L						= 2,
			I						= 2,
			Ma						= 0.3,
			Mw						= 1,
			cx_coeff				= {1, 0.39, 0.6, 0.168, 1.31},
			model_name				= "RBK_500U_nose",
			init_impulse			= {{300,0,0}},
		},
		dispenser =
		{
			mass					= 427,
			caliber					= 0.4,
			cx_coeff				= {1, 0.39, 0.6, 0.168, 1.31},
			L						= 2.43,
			I						= 124.494975,
			wind_sigma				= 100,
			Ma						= 0.227651,
			Mw						= 2.326556,
			model_name				= "RBK_500U_tail_OAB",
			set_start_args			= {},
			spawn_time				= {0, 0.5},
			spawn_weight_loss		= {0, 150},
			spawn_args_change		= {},
			op_spawns				= 2,
			use_effects				= 1,
		},
		empty_dispenser =
		{
			mass					= 35,
			caliber					= 0.4,
			L						= 2,
			I						= 2,
			Ma						= 0.3,
			Mw						= 1,
			cx_coeff				= {1,1,1,1,2},
			model_name				= "RBK_500U_tail_OAB",
			init_impulse			= {{0,0,0}},
			spawn_options			= {{1,1,1}},
		},
		bomblets =
		{
			wind_sigma					= 6.8,
			impulse_sigma				= 0.5,
			moment_sigma				= 0.05,
			count						= 126,
			effect_count				= 60,
			mass						= 2.8,
			caliber						= 0.072,
			cx_coeff					= {1,0.39,0.38,0.236,1.31},
			L							= 0.332,
			I							= 0.025719,
			Ma							= 0.137484,
			Mw							= 1.208365,
			model_name					= "RBK_500U_bomb_OAB",
			connectors_model_name		= "RBK_500U_tail_OAB",
			explosion_impulse_coeff		= 4,
			explosion_center			= {{0,0,0}},
			explosion_dont_use_x_axis	= 1,
			spawn_options				= {{0,1,120}},
		},
		warhead = predefined_warhead("OAB_2_5RT"),
	},
	cluster_scheme	= "rbk_simple",
	name    		= _("OAB_2_5RT"),
	type_name		= _("cluster"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
}
declare_weapon(OAB_2_5RT_CLUSTER)

RBK_500U_OAB_2_5RT =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
	VyHold			= -100.0,
	Ag				= -1.23,
	type			= 5,
	mass			= 427,
	hMin			= 200.0,
	hMax			= 25000.0,
	Cx				= 0.001,
	explMass		= 94.0,

	name			= "RBK_500U_OAB_2_5RT",
	model			= "RBK_500U",
	user_name		= _("RBK-500U - 126 x OAB-2.5RT, 500kg CBU HE/Frag"),
	scheme			= "bomb-cassette",
	class_name		= "wAmmunition",
	display_name_short = _("RBK-500U"),

	fm =
	{
		mass            = 427,
		caliber         = 0.4,
		cx_coeff        = {1, 0.39, 0.6, 0.168, 1.31},
		L               = 2.430000,
		wind_time       = 1000,
		wind_sigma      = 100,
		Ma              = 0.227651,
		Mw              = 2.326556,
	},

	control =
	{
		open_delay = 3.5,
	},

	launcher =
	{
		blocks  = {"cluster"},
		cluster = OAB_2_5RT_CLUSTER.descriptor,
	},

	targeting_data =
	{
		v0 = 200.0,
		data =
		{
			{1.000000, 20.200000, 0.000000},
			{10.000000, 20.355862, 0.000077},
			{20.000000, 20.378514, -0.000090},
			{30.000000, 20.384561, -0.000115},
			{40.000000, 20.385621, -0.000124},
			{50.000000, 20.389593, -0.000166},
			{60.000000, 20.389580, -0.000161},
			{70.000000, 20.390587, -0.000157},
			{80.000000, 20.389651, -0.000151},
			{90.000000, 20.391540, -0.000169},
			{100.000000, 20.392405, -0.000155},
			{200.000000, 20.453696, -0.000083},
			{300.000000, 20.529240, -0.000012},
			{400.000000, 20.594815, 0.000041},
			{500.000000, 20.649695, 0.000076},
			{600.000000, 20.696233, 0.000101},
			{700.000000, 20.736040, 0.000120},
			{800.000000, 20.770731, 0.000134},
			{900.000000, 20.801297, 0.000143},
			{1000.000000, 20.828531, 0.000151},
			{1100.000000, 20.853044, 0.000156},
			{1200.000000, 20.875318, 0.000159},
			{1300.000000, 20.895624, 0.000162},
			{1400.000000, 20.914330, 0.000163},
			{1500.000000, 20.931645, 0.000163},
			{1600.000000, 20.947761, 0.000163},
			{1700.000000, 20.962794, 0.000161},
			{1800.000000, 20.976925, 0.000159},
			{1900.000000, 20.990205, 0.000156},
			{2000.000000, 21.002764, 0.000153},
			{3000.000000, 21.100815, 0.000106},
			{4000.000000, 21.170027, 0.000042},
			{5000.000000, 21.224200, -0.000028},
			{6000.000000, 21.268902, -0.000100},
			{7000.000000, 21.306828, -0.000173},
			{8000.000000, 21.339423, -0.000244},
			{9000.000000, 21.367518, -0.000314},
			{10000.000000, 21.391591, -0.000383},
		}
	},

	shape_table_data =
	{{
		name	 = "RBK_500U_OAB_2_5RT",
		file     = "RBK_500U",
		life     = 1,
		fire     = {0, 1},
		username = _("RBK-500U OAB-2.5RT"),
		index    = WSTYPE_PLACEHOLDER,
	},}
}
declare_weapon(RBK_500U_OAB_2_5RT)


declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{RBK_250_275_AO_1SCH}",
	attribute		= RBK_250_275_AO_1SCH.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= RBK_250_275_AO_1SCH.Cx,
	Picture			= "RBK250.png",
	displayName		= RBK_250_275_AO_1SCH.user_name,
	Weight			= RBK_250_275_AO_1SCH.mass,
	Elements  		= {{ShapeName = "rbk-250"}},
})

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{RBK_500U_OAB_2_5RT}",
	attribute		= RBK_500U_OAB_2_5RT.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= RBK_500U_OAB_2_5RT.Cx,
	Picture			= "RBK_500U.png",
	displayName		= RBK_500U_OAB_2_5RT.user_name,
	Weight			= RBK_500U_OAB_2_5RT.mass,
	Elements  		= {{ShapeName = "RBK_500U"}},
})


CBU_99 =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
	type			= 5,
	mass			= 222.0,
	hMin			= 90.0,
	hMax			= 5000.0,
	Cx				= 0.000413,
	VyHold			= -100.0,
	Ag				= -1.23,
	Reflection		= 0.03,

	name			= "CBU_99",
	model			= "CBU_99",
	user_name		= _("CBU-99 - 490lbs, 247 x HEAT Bomblets"),
	scheme			= "bomb-cassette-2",
	class_name		= "wAmmunition",
	display_name_short =_("RBK-500U"),

	warhead = predefined_warhead("ROCKEYE"),

	fm =
	{
		mass            = 222.000000,
		caliber         = 0.335000,
		cx_coeff        = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
		L               = 2.340000,
		I               = 101.298600,
		Ma              = 0.197848,
		Mw              = 1.987409,
		wind_time       = 1000.000000,
		wind_sigma      = 100.000000,
	},

	shape_table_data =
	{
		{
			name     = "CBU_99",
			file     = "CBU_99",
			life     = 1,
			fire     = {0, 1},
			username = _("CBU-99"),
			index    = WSTYPE_PLACEHOLDER,
		},
	},

	launcher =
	{
		cluster = cluster_desc("Bomb_Other", wsType_Bomb_Cluster, combine_cluster(MK118_DATA,
		{
			cluster = {
				count        = 247,
				effect_count = 20,

				wind_sigma  = 5,
				impulse_sigma = 2,
				moment_sigma = 0.0001,
			}
		},
		"cluster"
		)
		)
	},

	control =
	{
		default_delay		= 1.2,
		default_open_height = 457,
	},

	targeting_data =
	{
		char_time				= 20.43,
		bomblet_char_time		= 23.8,
	}
}

declare_weapon(CBU_99)

declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{CBU_99}",
	attribute		= CBU_99.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= CBU_99.Cx,
	Picture			= "Mk20.png",
	displayName		= _("CBU-99 - 490lbs, 247 x HEAT Bomblets"),
	Weight			= CBU_99.mass,
	Elements  		= {{ShapeName = "CBU_99"}},
})

bombs_data =
{
	["MK-82"]			= {name = _("Mk-82"),			mass = 228, wsType = {4, 5, 9, 31},  Cx = 0.00025, picture = "mk82.png"},
	["CBU-99"]			= {name = CBU_99.user_name,	mass = CBU_99.fm.mass, wsType = CBU_99.wsTypeOfWeapon, Cx = CBU_99.Cx, picture = "Mk20.png"},

	["CBU-87"]			= {name = _("CBU-87 - 202 x CEM Cluster Bomb"),	 mass = 430, wsType = {4,	5,	38,	77}, Cx = 0.000413, picture = "CBU.png"},
	["CBU-97"]			= {name = _("CBU-97 - 10 x SFW Cluster Bomb"),	 mass = 417, wsType = {4,	5,	38,	35}, Cx = 0.000413, picture = "CBU.png"},
	["CBU-103"]			= {name = _("CBU-103 - 202 x CEM, CBU with WCMD"), mass = 430, wsType = {4,	5,	38,	88}, Cx = 0.000413, picture = "CBU.png"},
	["CBU-105"]			= {name = _("CBU-105 - 10 x SFW, CBU with WCMD"), mass = 417, wsType = {4,	5,	38,	87}, Cx = 0.000413, picture = "CBU.png"},
}

local function bru_33_2x_bombs(element)
	local bomb_variant = bombs_data[element] or bombs_data["MK-82"]
	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	"{BRU33_2X_"..element.."}",
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _("BRU-33 with 2 x ")..bomb_variant.name,
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	0.00244140625 + 2 * bomb_variant.Cx,		-- TODO
		Count			=	2,
		Weight			=	bru_33VER_mass + 2 * bomb_variant.mass,			-- TODO
		Elements		= {	{ShapeName	= "BRU_33A",	IsAdapter  	   = true},
							{ShapeName	= element,		connector_name = "Point02"},
							{ShapeName	= element,		connector_name = "Point01"}
		}, -- end of Elements
	}
	declare_loadout(data)
end

bru_33_2x_bombs("CBU-99")			-- {BRU33_2X_CBU-99}

-- BRU-57
local function bru_57_with_2x(element)
	local bomb_variant = bombs_data[element] or bombs_data["GBU-38"]
	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	"{BRU57_2*"..element.."}",
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _("BRU-57 with 2 x ")..bomb_variant.name,
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	0.00244140625 + 2*bomb_variant.Cx,		-- TODO
		Count			=	2,
		Weight			=	bru_33VER_mass + 2*bomb_variant.mass,			-- TODO
		Elements		= {	{ShapeName	= "BRU_57",	IsAdapter  	   = true},
							{ShapeName	= element,		connector_name = "Point02"},
							{ShapeName	= element,		connector_name = "Point01"}
		}, -- end of Elements
	}
	declare_loadout(data)
end

bru_57_with_2x("CBU-103")			-- {BRU57_2*CBU-103}
bru_57_with_2x("CBU-105")			-- {BRU57_2*CBU-105}

-- TER-9/A with cluster bombs
local function ter_9a_bombs(element_, isFull, isLeft)
	local bomb_variant = bombs_data[element_] or bombs_data["MK-82"]
	local count_
	local elements_ = {}
	local side_
	if isFull then
		count_ = 3
		elements_ = ter_9a_three(element_)
		side_ = ""
	elseif isLeft then
		count_ = 2
		elements_ = ter_9a_two_left(element_)
		side_ = "L"
	else
		count_ = 2
		elements_ = ter_9a_two_right(element_)
		side_ = "R"
	end

	local data = {
		category		=	CAT_BOMBS,
		CLSID			=	"{TER_9A_"..count_..side_.."*"..element_.."}",
		Picture			=	bomb_variant.picture,
		wsTypeOfWeapon	=	bomb_variant.wsType,
		displayName		=  _("TER-9A with ")..count_.." x "..bomb_variant.name,
		attribute		=	{wsType_Weapon,wsType_Bomb,wsType_Container,WSTYPE_PLACEHOLDER},
		Cx_pil			=	0.00244140625 + count_ * bomb_variant.Cx,		-- TODO
		Count			=	count_,
		Weight			=	ter_9a_mass + count_ * bomb_variant.mass,			-- TODO
		Elements		= 	elements_,
	}
	declare_loadout(data)
end

ter_9a_bombs("CBU-87", false, true)				-- {TER_9A_2L*CBU-87}
ter_9a_bombs("CBU-87", false, false)			-- {TER_9A_2R*CBU-87}
ter_9a_bombs("CBU-87", true)					-- {TER_9A_3*CBU-87}
ter_9a_bombs("CBU-97", false, true)				-- {TER_9A_2L*CBU-97}
ter_9a_bombs("CBU-97", false, false)			-- {TER_9A_2R*CBU-97}
ter_9a_bombs("CBU-97", true)					-- {TER_9A_2*CBU-97}

-- BKF w/AO-2.5RT cluster descriptor
CLUSTER_BKF_AO2_5RT =
{
	category = CAT_CLUSTER_DESC,
	scheme   =
	{
		dispenser =
		{
			op_time					= 300.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 20,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 46.0 + 12 * 2.5,
			caliber					= 0.346,
			L						= 0.373,
			I						= 1/12 * (46.0 + 12 * 2.5) * 0.373 ^ 2,
			Ma						= 0.23,
			Mw						= 2.33,
			cx_coeff				= {0, 0.9, 0.9, 1.0, 2.0},
			model_name				= "ao-2_5rt_block2",
			spawn_time				= {0, 0.02},
			spawn_height			= {},
			spawn_weight_loss		= {0, 12 * 2.5},
			op_spawns				= 2,
			use_effects				= 0,
			hide_effect_0			= 0,
			init_impulse			= {{0, -(46.0 + 12 * 2.5) * 9, 0}}
		},

		empty_dispenser =
		{
			op_time					= 300.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 20,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 46.0,
			caliber					= 0.346,
			L						= 0.373,
			I						= 1/12 * 46.0 * 0.373 ^ 2,
			Ma						= 0.23,
			Mw						= 2.33,
			cx_coeff				= {0, 0.9, 0.9, 1.0, 2.0},
			model_name				= "ao-2_5rt_block2",
			spawn_options			= {{1, 1, 1}},
		},

		bomblets =
		{
			op_time					= 400.0,
			count					= 12,
			effect_count			= 12,
			wind_sigma				= 50,
			impulse_sigma			= 10,
			moment_sigma			= 20,
			mass					= 2.5,
			caliber					= 0.068,
			L						= 0.149,
			I						= 1/12 * 2.5 * 0.149 ^ 2,
			Ma						= 0.137484,
			Mw						= 0.208365,
			cx_coeff				= {0, 0.4, 0.7, 0.6, 1.4},
			model_name				= "ao-2_5rt",
			connectors_model_name	= "ao-2_5rt_block2",
			explosion_impulse_coeff	= 4,
			explosion_center		= {{0, -0.01, 0}},
			release_rnd_coeff		= 0,
			spawn_options			= {{0, 1, 12}},
			explosion_style			= 0,
		},
		warhead		= simple_warhead(3.0, 0.068)
	},

	cluster_scheme	= "disp_bomblets_empty_disp",
	name			= _("AO-2.5RT"),
	type_name		= _("cluster"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
}
declare_weapon(CLUSTER_BKF_AO2_5RT)

-- BKF w/PTAB-2.5KO cluster descriptor
CLUSTER_BKF_PTAB2_5KO =
{
	category = CAT_CLUSTER_DESC,
	scheme   =
	{
		dispenser =
		{
			op_time					= 300.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 20,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 41.0 + 12 * 1.85,
			caliber					= 0.346,
			L						= 0.373,
			I						= 1/12 * (41.0 + 12 * 1.85) * 0.373 ^ 2,
			Ma						= 0.23,
			Mw						= 2.33,
			cx_coeff				= {0, 0.9, 0.9, 1.0, 2.0},
			model_name				= "ptab-2_5ko_block2",
			spawn_time				= {0, 0.02},
			spawn_height			= {},
			spawn_weight_loss		= {0, 12 * 1.85},
			op_spawns				= 2,
			use_effects				= 0,
			hide_effect_0			= 0,
			init_impulse			= {{0, -(41.0 + 12 * 1.85) * 9, 0}},
		},

		empty_dispenser =
		{
			op_time					= 300.0,
			count					= 1,
			effect_count			= 1,
			wind_sigma				= 20,
			impulse_sigma			= 1,
			moment_sigma			= 1,
			mass					= 41.0,
			caliber					= 0.346,
			L						= 0.373,
			I						= 1/12 * 41.0 * 0.373 ^ 2,
			Ma						= 0.23,
			Mw						= 2.33,
			cx_coeff				= {0, 0.9, 0.9, 1.0, 2.0},
			model_name				= "ptab-2_5ko_block2",
			spawn_options			= {{1, 1, 1}},
		},

		bomblets =
		{
			op_time					= 400.0,
			count					= 12,
			effect_count			= 12,
			wind_sigma				= 50,
			impulse_sigma			= 10,
			moment_sigma			= 20,
			mass					= 1.85,
			caliber					= 0.06,
			L						= 0.308,
			I						= 1/12 * 1.85 * 0.308 ^ 2,
			Ma						= 0.8,
			Mw						= 5,
			cx_coeff				= {0, 0.4, 0.7, 0.6, 1.4},
			model_name				= "ptab-2_5ko",
			connectors_model_name	= "ptab-2_5ko_block2",
			explosion_impulse_coeff	= 0,
			explosion_center		= {{0, -0.006, 0}},
			release_rnd_coeff		= 0,
			spawn_options			= {{0, 1, 12}},
			explosion_style			= 0,
			chute_open_time			= 2.0,
			chute_diam				= 0.06,
			chute_Cx				= 0.5,
			set_start_args			= {2},
			set_changing_args		= {
				1, 0, 1, 1.7, 0,
				2, 1, 0, 1.0, 0,
				28, 0, 1, 0.34, 1
			},
			anim_time				= 0
		},
		warhead		= predefined_warhead("PTAB-2-5")
	},

	cluster_scheme	= "disp_bomblets_empty_disp",
	name			= _("PTAB-2.5KO"),
	type_name		= _("cluster"),
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
}
declare_weapon(CLUSTER_BKF_PTAB2_5KO)

-- BKF w/AO-2.5RT itself
BKF_AO2_5RT =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
	VyHold			= -100.0,
	Ag				= -1.23,
	type			= 5,
	mass			= CLUSTER_BKF_AO2_5RT.scheme.dispenser.mass,
	hMin			= 30,
	hMax			= 1000.0,
	Cx				= 0.000413,

	name			= "BKF_AO2_5RT",
	model			= "ao-2_5rt_block2",
	user_name		= _("BKF - 12 x ") .. _("AO-2.5RT"),
	scheme			= "bomb-cassette",
	class_name		= "wAmmunition",

	fm = CLUSTER_BKF_AO2_5RT.scheme.dispenser,

	control = {
		open_delay = 0,
	},

	launcher = {
		blocks	= {"cluster"},
		cluster	= CLUSTER_BKF_AO2_5RT.descriptor,
	},

	targeting_data = {
		v0 = 200,
		char_time = 26,
		bomblet_char_time = 26,
	},

	puff = {
		show_puff = 0
	},

	shape_table_data = {{
		name		= "ao-2_5rt_block2",
		file		= "ao-2_5rt_block2",
		username	= _("BKF - 12 x ") .. _("AO-2.5RT"),
		index		= WSTYPE_PLACEHOLDER,
	}}
}
declare_weapon(BKF_AO2_5RT)

-- BKF w/PTAB-2.5KO itself
BKF_PTAB2_5KO =
{
	category		= CAT_BOMBS,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
	VyHold			= -100.0,
	Ag				= -1.23,
	type			= 5,
	mass			= CLUSTER_BKF_PTAB2_5KO.scheme.dispenser.mass,
	hMin			= 30,
	hMax			= 1000.0,
	Cx				= 0.000413,

	name			= "BKF_PTAB2_5KO",
	model			= "ptab-2_5ko_block2",
	user_name		= _("BKF - 12 x ") .. _("PTAB-2.5KO"),
	scheme			= "bomb-cassette",
	class_name		= "wAmmunition",

	fm = CLUSTER_BKF_PTAB2_5KO.scheme.dispenser,

	control = {
		open_delay = 0,
	},

	launcher = {
		blocks	= {"cluster"},
		cluster	= CLUSTER_BKF_PTAB2_5KO.descriptor,
	},

	targeting_data = {
		v0 = 200,
		char_time = 25.8,
		bomblet_char_time = 25.8,
	},

	puff = {
		show_puff = 0
	},

	shape_table_data = {{
		name		= "ptab-2_5ko_block2",
		file		= "ptab-2_5ko_block2",
		username	= _("BKF - 12 x ") .. _("PTAB-2.5KO"),
		index		= WSTYPE_PLACEHOLDER,
	}}
}
declare_weapon(BKF_PTAB2_5KO)

-- BKF w/AO-2.5RT itself as a loadout
declare_loadout({
	category			= CAT_BOMBS,
	CLSID				= "{BKF_AO2_5RT}",
	displayName			= BKF_AO2_5RT.user_name,
	wsTypeOfWeapon		= BKF_AO2_5RT.wsTypeOfWeapon,
	attribute			= {4,	5,	32,	WSTYPE_PLACEHOLDER},
	Cx_pil				= 0,
	Weight				= BKF_AO2_5RT.fm.mass,
	Count				= 1,
	kind_of_shipping	= 2,
	Elements			= {
		{ ShapeName = "ao-2_5rt_block1", IsAdapter = true },
		{ ShapeName = "ao-2_5rt_block2", connector_name = "AttachPoint" },
	}
})

-- BKF w/PTAB-2.5KO itself as a loadout
declare_loadout({
	category			= CAT_BOMBS,
	CLSID				= "{BKF_PTAB2_5KO}",
	displayName			= BKF_PTAB2_5KO.user_name,
	wsTypeOfWeapon		= BKF_PTAB2_5KO.wsTypeOfWeapon,
	attribute			= {4,	5,	32,	WSTYPE_PLACEHOLDER},
	Cx_pil				= 0,
	Weight				= BKF_PTAB2_5KO.fm.mass,
	Count				= 1,
	kind_of_shipping	= 2,
	Elements			= {
		{ ShapeName = "ptab-2_5ko_block1", IsAdapter = true },
		{ ShapeName = "ptab-2_5ko_block2", connector_name = "AttachPoint" },
	}
})

-- KMGU-2 w/BKF w/AO-2.5RT
declare_loadout({
	category			= CAT_BOMBS,
	CLSID				= "{96A7F676-F956-404A-AD04-F33FB2C74884}",
	Picture				= "KMGU2.png",
	displayName			= _("KMGU-2 - 96 x AO-2.5RT Dispenser (CBU) HE/Frag"),
	attribute			= {4, 5, 32, 94},
	wsTypeOfWeapon		= BKF_AO2_5RT.wsTypeOfWeapon,
	Cx_pil				= 0.00167,
	Weight				= 8 * BKF_AO2_5RT.fm.mass + 170,
	Weight_Empty		= 170,
	Count				= 8,
	kind_of_shipping	= 2,
	Elements			= ContainerWithSubshapes("kmgu-2", "{BKF_AO2_5RT}", 8, "Point%d", {}, true)
})

-- KMGU-2 w/BKF w/PTAB-2.5KO
declare_loadout({
	category			= CAT_BOMBS,
	CLSID				= "{96A7F676-F956-404A-AD04-F33FB2C74881}",
	Picture				= "KMGU2.png",
	displayName			= _("KMGU-2 - 96 x PTAB-2.5KO Dispenser (CBU) HEAT/AP"),
	attribute			= {4, 5, 32, 95},
	wsTypeOfWeapon		= BKF_PTAB2_5KO.wsTypeOfWeapon,
	Cx_pil				= 0.00167,
	Weight				= 8 * BKF_PTAB2_5KO.fm.mass + 170,
	Weight_Empty		= 170,
	Count				= 8,
	kind_of_shipping	= 2,
	Elements			= ContainerWithSubshapes("kmgu-2", "{BKF_PTAB2_5KO}", 8, "Point%d", {}, true)
})
