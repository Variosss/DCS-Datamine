--/N/ feb 2022
-- main gear travel 0.23
-- nosegear travel 0.2165


--[[ 
local	 nose_amortizer_min_length				=	0.000
local	 nose_amortizer_max_length				=	0.120
local	 nose_amortizer_basic_length				=	0.120
local	 nose_amortizer_reduce_length				=	0.090
	 					
local	 main_amortizer_min_length				=	0.000
local	 main_amortizer_max_length				=	0.160
local	 main_amortizer_basic_length				=	0.160
local	 main_amortizer_reduce_length				=	0.120
						
						
local	 nose_amortizer_static_force				=	14691.5
local	 nose_amortizer_spring_force_factor				=	9.21486E+09
local	 nose_amortizer_spring_force_factor_rate				=	6.000
						
local	 nose_amortizer_direct_damper_force_factor				=	10882.6
local	 nose_amortizer_back_damper_force_factor				=	9794.3
						
						
local	 main_amortizer_static_force				=	38565.1
local	 main_amortizer_spring_force_factor				=	2.49139E+12
local	 main_amortizer_spring_force_factor_rate				=	9.000
						
local	 main_amortizer_direct_damper_force_factor				=	21425.0
local	 main_amortizer_back_damper_force_factor				=	19282.5
]]

local	 nose_amortizer_min_length				=	0.000
local	 nose_amortizer_max_length				=	0.120
local	 nose_amortizer_basic_length				=	0.120
local	 nose_amortizer_reduce_length				=	0.108
	 					
local	 main_amortizer_min_length				=	0.000
local	 main_amortizer_max_length				=	0.160
local	 main_amortizer_basic_length				=	0.160
local	 main_amortizer_reduce_length				=	0.144
						
						
local	 nose_amortizer_static_force				=	14691.5
local	 nose_amortizer_spring_force_factor				=	85723234684.2
local	 nose_amortizer_spring_force_factor_rate				=	7.000
						
local	 nose_amortizer_direct_damper_force_factor				=	22672.0
local	 nose_amortizer_back_damper_force_factor				=	20404.8
						
						
local	 main_amortizer_static_force				=	38565.1
local	 main_amortizer_spring_force_factor				=	1448544086990.4
local	 main_amortizer_spring_force_factor_rate				=	9.000
						
local	 main_amortizer_direct_damper_force_factor				=	44635.5
local	 main_amortizer_back_damper_force_factor				=	40172.0




local brake_moment_max = 9761
--local glide_friction_factor = 0.45 
local brake_factor_main = 1.0
local brake_factor_nose = 0.5

local dc = 20.0 -- doesn't have any effect, tested with values 0 ... +- 2 mil


suspension = 
{ 
	{ -- Nosegear
		anti_skid_installed = true,	

		mass = 170.0,
		damage_element = 83,
		moment_of_inertia = {100.0,100.0,100.0},
		wheel_axle_offset = 0.185,
		self_attitude = true,
		yaw_limit = math.rad(40.0), --math.rad(89.0),
		
		amortizer_min_length = nose_amortizer_min_length,
		amortizer_max_length = nose_amortizer_max_length,
		amortizer_basic_length = nose_amortizer_basic_length,
		amortizer_reduce_length = nose_amortizer_reduce_length,
		
		allowable_hard_contact_length = 1.0,
		damper_coeff = dc,
		
		amortizer_spring_force_factor = nose_amortizer_spring_force_factor, -- sto vise to tvrdje
		amortizer_spring_force_factor_rate = nose_amortizer_spring_force_factor_rate,-- sto manje to tvrdje

		amortizer_static_force = nose_amortizer_static_force,
		amortizer_direct_damper_force_factor = nose_amortizer_direct_damper_force_factor,-- amortizacija na dole
		amortizer_back_damper_force_factor = nose_amortizer_back_damper_force_factor,-- amortizacija na gore
	
		wheel_radius = 0.250,
		wheel_static_friction_factor = 0.65,
		wheel_side_friction_factor = 0.55,
		wheel_roll_friction_factor = 0.045,--0.085
		wheel_glide_friction_factor = 0.38,
wheel_damage_force_factor = 135.0 * 1.5,--/N/ damage to tyres, 250 Su-25
		wheel_damage_speed = 108.0,
		wheel_brake_moment_max = brake_moment_max * brake_factor_nose,
		wheel_moment_of_inertia = 2.6,

		arg_post = 0,
		arg_amortizer = 1,
		arg_wheel_rotation = 76,
		arg_wheel_yaw = 2,
		collision_shell_name = "WHEEL_F",
	},
	
	{ -- Maingear L
		anti_skid_installed = true,
	
		mass = 240.0,
		damage_element = 84,
		moment_of_inertia = {200.0,200.0,200.0},
wheel_axle_offset 	= 0.0,--0.254,
		yaw_limit	 = 0.0,
		self_attitude	 = false,
		
		amortizer_min_length = main_amortizer_min_length,
		amortizer_max_length = main_amortizer_max_length,
		amortizer_basic_length = main_amortizer_basic_length,
		amortizer_reduce_length = main_amortizer_reduce_length,
		
		allowable_hard_contact_length = 0.3,
		damper_coeff = dc,
		
		amortizer_spring_force_factor = main_amortizer_spring_force_factor,
		amortizer_spring_force_factor_rate = main_amortizer_spring_force_factor_rate,
		
		amortizer_static_force = main_amortizer_static_force,
		amortizer_direct_damper_force_factor = main_amortizer_direct_damper_force_factor,
		amortizer_back_damper_force_factor = main_amortizer_back_damper_force_factor,
	
		wheel_radius = 0.400,
		wheel_static_friction_factor = 0.65,
		wheel_side_friction_factor = 0.55,
		wheel_roll_friction_factor = 0.045,
		wheel_glide_friction_factor = 0.38,
wheel_damage_force_factor = 180.0 * 1.5,--/N/ damage 
		wheel_damage_speed = 108.0, 
		wheel_brake_moment_max = brake_moment_max * brake_factor_main,
		wheel_moment_of_inertia = 7.0,

		arg_post = 5,
		arg_amortizer = 6,
		arg_wheel_rotation = 77,
		arg_wheel_yaw = -1,
		collision_shell_name = "WHEEL_L",
	},
	
	{ -- Maingear R
		anti_skid_installed = true,
		
		mass = 240.0,
		damage_element = 85,
		moment_of_inertia = {200.0,200.0,200.0},
wheel_axle_offset 	= 0.0,--0.254,
		yaw_limit	 = 0.0,
		self_attitude	 = false,
		
		amortizer_min_length = main_amortizer_min_length,
		amortizer_max_length = main_amortizer_max_length,
		amortizer_basic_length = main_amortizer_basic_length,
		amortizer_reduce_length = main_amortizer_reduce_length,
		
		allowable_hard_contact_length = 0.3,
		damper_coeff = dc,
	
		amortizer_spring_force_factor = main_amortizer_spring_force_factor,
		amortizer_spring_force_factor_rate = main_amortizer_spring_force_factor_rate,
		
		amortizer_static_force = main_amortizer_static_force,
		amortizer_direct_damper_force_factor = main_amortizer_direct_damper_force_factor,
		amortizer_back_damper_force_factor = main_amortizer_back_damper_force_factor,
		
		wheel_radius = 0.400,
		wheel_static_friction_factor = 0.65,
		wheel_side_friction_factor = 0.55,
		wheel_roll_friction_factor = 0.045,
		wheel_glide_friction_factor = 0.38,
wheel_damage_force_factor = 180.0 * 1.5,--/N/ damage 
		wheel_damage_speed = 108.0, 
		wheel_brake_moment_max = brake_moment_max * brake_factor_main,
		wheel_moment_of_inertia = 7.0,

		arg_post = 3,
		arg_amortizer = 4,
		arg_wheel_rotation = 77,
		arg_wheel_yaw = -1,
		collision_shell_name = "WHEEL_R",
	},
}